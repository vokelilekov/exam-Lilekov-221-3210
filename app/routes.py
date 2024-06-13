from flask import Blueprint, render_template, redirect, url_for, flash, request, current_app
from flask_login import login_user, logout_user, login_required, current_user
from app.models import db, User, Book, Review, Cover, Genre
from app.forms import LoginForm, RegistrationForm, ReviewForm, BookForm
from werkzeug.utils import secure_filename
import os
import hashlib
import bleach

main = Blueprint('main', __name__)

@main.route('/')
@main.route('/index', methods=['GET'])
def index():
    page = request.args.get('page', 1, type=int)
    books = Book.query.order_by(Book.year.desc()).paginate(page=page, per_page=10, error_out=False)
    return render_template('index.html', books=books)

@main.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.index'))
    
    form = LoginForm()
    if form.validate_on_submit():
        user = User.get_by_username(form.username.data)
        if user is None or not user.check_password(form.password.data):
            flash('Invalid username or password', 'danger')
            return redirect(url_for('main.login'))
        login_user(user, remember=form.remember_me.data)
        next_page = request.args.get('next')
        if not next_page:
            next_page = url_for('main.index')
        return redirect(next_page)
    return render_template('login.html', title='Sign In', form=form)

@main.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('main.index'))

@main.route('/register', methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('main.index'))
    
    form = RegistrationForm()
    if form.validate_on_submit():
        user = User.create(
            username=form.username.data,
            password=form.password.data,
            last_name=form.last_name.data,
            first_name=form.first_name.data,
            middle_name=form.middle_name.data,
            role_id=3
        )
        flash('Congratulations, you are now a registered user!', 'success')
        return redirect(url_for('main.login'))
    return render_template('register.html', title='Register', form=form)

@main.route('/book/<int:book_id>', methods=['GET'])
def book(book_id):
    book = Book.query.get_or_404(book_id)
    reviews = Review.query.filter_by(book_id=book_id).all()
    user_review = None
    if current_user.is_authenticated:
        user_review = Review.query.filter_by(book_id=book_id, user_id=current_user.id).first()
    return render_template('book.html', book=book, reviews=reviews, user_review=user_review)

@main.route('/book/<int:book_id>/add_review', methods=['GET', 'POST'])
@login_required
def add_review(book_id):
    book = Book.query.get_or_404(book_id)
    if Review.query.filter_by(book_id=book_id, user_id=current_user.id).first():
        flash('Вы уже оставили рецензию на эту книгу.', 'danger')
        return redirect(url_for('main.book', book_id=book_id))
    
    form = ReviewForm()
    if form.validate_on_submit():
        review_text = bleach.clean(form.text.data)
        review = Review(
            book_id=book_id,
            user_id=current_user.id,
            rating=form.rating.data,
            text=review_text
        )
        db.session.add(review)
        db.session.commit()
        flash('Рецензия успешно добавлена.', 'success')
        return redirect(url_for('main.book', book_id=book_id))
    
    return render_template('add_review.html', form=form, book=book)

@main.route('/book/add', methods=['GET', 'POST'])
@login_required
def add_book():
    if current_user.role.name != 'Admin':
        flash('У вас нет прав для выполнения этого действия.', 'danger')
        return redirect(url_for('main.index'))
    
    form = BookForm()
    if form.validate_on_submit():
        try:
            file = form.cover.data
            if file:
                filename = secure_filename(file.filename)
                file_path = os.path.join(current_app.config['UPLOAD_FOLDER'], filename)
                file.save(file_path)

                md5_hash = hashlib.md5()
                with open(file_path, 'rb') as f:
                    for chunk in iter(lambda: f.read(4096), b""):
                        md5_hash.update(chunk)
                md5_hex = md5_hash.hexdigest()

                cover = Cover.query.filter_by(md5_hash=md5_hex).first()
                if not cover:
                    cover = Cover(filename=filename, mime_type=file.mimetype, md5_hash=md5_hex)
                    db.session.add(cover)
                    db.session.commit()

            book = Book(
                title=form.title.data,
                description=form.description.data,
                year=form.year.data,
                publisher=form.publisher.data,
                author=form.author.data,
                pages=form.pages.data,
                cover_id=cover.id
            )
            db.session.add(book)
            db.session.commit()

            genres = Genre.query.filter(Genre.id.in_(form.genres.data)).all()
            book.genres.extend(genres)
            db.session.commit()

            flash('Книга успешно добавлена.', 'success')
            return redirect(url_for('main.index'))
        except Exception as e:
            db.session.rollback()
            flash(f'Ошибка при добавлении книги: {str(e)}', 'danger')

    return render_template('add_book.html', form=form)

@main.route('/book/edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
def edit_book(book_id):
    if current_user.role.name not in ['Admin', 'Moderator']:
        flash('You do not have permission to perform this action.', 'danger')
        return redirect(url_for('main.index'))
    
    book = Book.query.get_or_404(book_id)
    form = BookForm(obj=book)
    if form.validate_on_submit():
        
        flash('Book details have been updated.', 'success')
        return redirect(url_for('main.book', book_id=book.id))
    return render_template('edit_book.html', form=form, book=book)

@main.route('/book/<int:book_id>/delete', methods=['POST'])
@login_required
def delete_book(book_id):
    if current_user.role.name != 'Admin':
        flash('У вас нет прав для выполнения этого действия.', 'danger')
        return redirect(url_for('main.index'))
    
    book = Book.query.get_or_404(book_id)
    db.session.delete(book)
    db.session.commit()
    flash('Книга успешно удалена.', 'success')
    return redirect(url_for('main.index'))
