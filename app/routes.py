from flask import Blueprint, render_template, redirect, url_for, flash, request, current_app
from flask_login import login_user, logout_user, login_required, current_user
from app.models import db, User, Book, Review, Cover, Genre
import os
import bleach
from app.tools import ImageSaver
import markdown

main = Blueprint('main', __name__)

@main.route('/')
@main.route('/index')
def index():
    page = request.args.get('page', 1, type=int)
    books = Book.query.order_by(Book.year.desc()).paginate(page=page, per_page=10, error_out=False)
    return render_template('index.html', books=books)

@main.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.index'))
    
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        remember = 'remember_me' in request.form
        
        user = User.get_by_username(username)
        if user is None or not user.check_password(password):
            flash('Неверный логин или пароль.', 'danger')
            return redirect(url_for('main.login'))
        
        login_user(user, remember=remember)
        next_page = request.args.get('next', url_for('main.index'))
        return redirect(next_page)
    
    return render_template('login.html')

@main.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('main.index'))

@main.route('/book/<int:book_id>')
def book(book_id):
    book = Book.query.get_or_404(book_id)
    reviews = Review.query.filter_by(book_id=book_id).all()
    user_review = Review.query.filter_by(book_id=book_id, user_id=current_user.id).first() if current_user.is_authenticated else None
    return render_template('book.html', book=book, reviews=reviews, user_review=user_review, markdown=markdown)

@main.route('/book/<int:book_id>/add_review', methods=['GET', 'POST'])
@login_required
def add_review(book_id):
    book = Book.query.get_or_404(book_id)
    if Review.query.filter_by(book_id=book_id, user_id=current_user.id).first():
        flash('Вы уже оставили рецензию на эту книгу.', 'danger')
        return redirect(url_for('main.book', book_id=book_id))
    
    if request.method == 'POST':
        rating = request.form['rating']
        text = bleach.clean(request.form['text'])
        review = Review(book_id=book_id, user_id=current_user.id, rating=rating, text=text)
        db.session.add(review)
        db.session.commit()
        flash('Рецензия добавлена.', 'success')
        return redirect(url_for('main.book', book_id=book_id))
    
    return render_template('add_review.html', book=book)

@main.route('/book/add', methods=['GET', 'POST'])
@login_required
def add_book():
    if current_user.role.name != 'Admin':
        flash('У вас нет прав для выполнения данного действия.', 'danger')
        return redirect(url_for('main.index'))

    if request.method == 'POST':
        try:
            title = request.form['title']
            description = bleach.clean(request.form['description'])
            year = request.form['year']
            publisher = request.form['publisher']
            author = request.form['author']
            pages = request.form['pages']
            genre_ids = request.form.getlist('genres')
            cover_file = request.files['cover']

            cover = None
            if cover_file:
                image_saver = ImageSaver(cover_file)
                cover = image_saver.save()

            book = Book(title=title, description=description, year=year, publisher=publisher, author=author, pages=pages, cover_id=cover.id if cover else None)
            db.session.add(book)
            db.session.commit()

            genres = Genre.query.filter(Genre.id.in_(genre_ids)).all()
            book.genres.extend(genres)
            db.session.commit()

            flash('Книга добавлена.', 'success')
            return redirect(url_for('main.index'))
        except Exception as e:
            db.session.rollback()
            flash(f'Ошибка при добавлении книги: {str(e)}', 'danger')

    genres = Genre.query.order_by('name').all()
    return render_template('add_book.html', genres=genres)

@main.route('/book/edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
def edit_book(book_id):
    if current_user.role.name not in ['Admin', 'Moderator']:
        flash('У вас нет прав для выполнения данного действия.', 'danger')
        return redirect(url_for('main.index'))
    
    book = Book.query.get_or_404(book_id)
    if request.method == 'POST':
        try:
            book.title = request.form['title']
            book.description = bleach.clean(request.form['description'])
            book.year = request.form['year']
            book.publisher = request.form['publisher']
            book.author = request.form['author']
            book.pages = request.form['pages']
            genre_ids = request.form.getlist('genres')
            book.genres = Genre.query.filter(Genre.id.in_(genre_ids)).all()
            db.session.commit()
            flash('Данные книги обновлены.', 'success')
            return redirect(url_for('main.book', book_id=book.id))
        except Exception as e:
            db.session.rollback()
            flash(f'Ошибка при обновлении книги: {str(e)}', 'danger')

    genres = Genre.query.order_by('name').all()
    selected_genres = [genre.id for genre in book.genres]
    return render_template('edit_book.html', book=book, genres=genres, selected_genres=selected_genres)

@main.route('/book/<int:book_id>/delete', methods=['POST'])
@login_required
def delete_book(book_id):
    if current_user.role.name != 'Admin':
        flash('У вас нет прав для выполнения данного действия.', 'danger')
        return redirect(url_for('main.index'))

    try:
        book = Book.query.get_or_404(book_id)
        cover = Cover.query.get(book.cover_id)
        book.genres.clear()
        Review.query.filter_by(book_id=book_id).delete()
        db.session.delete(book)
        db.session.commit()

        if cover and not Book.query.filter_by(cover_id=cover.id).count():
            cover_path = os.path.join(current_app.config['UPLOAD_FOLDER'], cover.filename)
            if os.path.exists(cover_path):
                os.remove(cover_path)
            db.session.delete(cover)
            db.session.commit()

        flash('Книга удалена.', 'success')
    except Exception as e:
        db.session.rollback()
        flash(f'Ошибка при удалении книги: {str(e)}', 'danger')

    return redirect(url_for('main.index'))
