from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, TextAreaField, IntegerField, SelectMultipleField, FileField, SelectField
from wtforms.validators import DataRequired, Length, Email, EqualTo, NumberRange
from app.models import Genre

class LoginForm(FlaskForm):
    username = StringField('Имя пользователя', validators=[DataRequired()])
    password = PasswordField('Пароль', validators=[DataRequired()])
    remember_me = BooleanField('Запомнить меня')
    submit = SubmitField('Войти')

class RegistrationForm(FlaskForm):
    username = StringField('Имя пользователя', validators=[DataRequired(), Length(min=4, max=25)])
    password = PasswordField('Пароль', validators=[DataRequired(), Length(min=6)])
    password2 = PasswordField(
        'Повторите пароль', validators=[DataRequired(), EqualTo('password')]
    )
    last_name = StringField('Фамилия', validators=[DataRequired()])
    first_name = StringField('Имя', validators=[DataRequired()])
    middle_name = StringField('Отчество')
    submit = SubmitField('Регистрация')

class BookForm(FlaskForm):
    title = StringField('Название', validators=[DataRequired()])
    description = TextAreaField('Описание', validators=[DataRequired()])
    year = IntegerField('Год', validators=[DataRequired()])
    publisher = StringField('Издательство', validators=[DataRequired()])
    author = StringField('Автор', validators=[DataRequired()])
    pages = IntegerField('Страниц', validators=[DataRequired()])
    genres = SelectMultipleField('Жанры', coerce=int)
    cover = FileField('Обложка')
    submit = SubmitField('Сохранить')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.genres.choices = [(genre.id, genre.name) for genre in Genre.query.order_by('name')]

class ReviewForm(FlaskForm):
    rating = SelectField('Оценка', choices=[
        (5, 'Отлично'),
        (4, 'Хорошо'),
        (3, 'Удовлетворительно'),
        (2, 'Неудовлетворительно'),
        (1, 'Плохо'),
        (0, 'Ужасно')
    ], coerce=int, validators=[DataRequired()])
    text = TextAreaField('Рецензия', validators=[DataRequired()])
    submit = SubmitField('Отправить')
