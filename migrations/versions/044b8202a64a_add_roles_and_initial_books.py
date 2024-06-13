"""Add roles and initial books

Revision ID: 044b8202a64a
Revises: 00a4f8f5ab10
Create Date: 2024-06-13 20:00:11.194186

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.sql import table, column
from sqlalchemy import String, Integer, Text

# revision identifiers, used by Alembic.
revision = '044b8202a64a'
down_revision = '00a4f8f5ab10'
branch_labels = None
depends_on = None


def upgrade():
    role_table = table('roles',
                       column('id', Integer),
                       column('name', String),
                       column('description', Text))

    op.bulk_insert(role_table, [
        {'id': 1, 'name': 'Admin', 'description': 'Администратор (суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг)'},
        {'id': 2, 'name': 'Moderator', 'description': 'Модератор (может редактировать данные книг и производить модерацию рецензий)'},
        {'id': 3, 'name': 'User', 'description': 'Пользователь (может оставлять рецензии)'}
    ])

    op.create_table('covers',
        sa.Column('id', sa.Integer, primary_key=True),
        sa.Column('filename', sa.String(length=200), nullable=False),
        sa.Column('mime_type', sa.String(length=50), nullable=False),
        sa.Column('md5_hash', sa.String(length=32), nullable=False),
    )

    op.create_table('books',
        sa.Column('id', sa.Integer, primary_key=True),
        sa.Column('title', sa.String(length=200), nullable=False),
        sa.Column('description', sa.Text, nullable=False),
        sa.Column('year', sa.Integer, nullable=False),
        sa.Column('publisher', sa.String(length=200), nullable=False),
        sa.Column('author', sa.String(length=200), nullable=False),
        sa.Column('pages', sa.Integer, nullable=False),
        sa.Column('cover_id', sa.Integer, sa.ForeignKey('covers.id', ondelete='CASCADE'), nullable=False)
    )

    book_table = table('books',
                       column('id', Integer),
                       column('title', String),
                       column('description', Text),
                       column('year', Integer),
                       column('publisher', String),
                       column('author', String),
                       column('pages', Integer),
                       column('cover_id', Integer))

    op.bulk_insert(book_table, [
        {'id': 1, 'title': 'Book 1', 'description': 'Description for Book 1', 'year': 2022, 'publisher': 'Publisher 1', 'author': 'Author 1', 'pages': 100, 'cover_id': 1},
        {'id': 2, 'title': 'Book 2', 'description': 'Description for Book 2', 'year': 2021, 'publisher': 'Publisher 2', 'author': 'Author 2', 'pages': 200, 'cover_id': 2},
    ])

    cover_table = table('covers',
                        column('id', Integer),
                        column('filename', String),
                        column('mime_type', String),
                        column('md5_hash', String))

    op.bulk_insert(cover_table, [
        {'id': 1, 'filename': 'cover1.jpg', 'mime_type': 'image/jpeg', 'md5_hash': 'd41d8cd98f00b204e9800998ecf8427e'},
        {'id': 2, 'filename': 'cover2.jpg', 'mime_type': 'image/jpeg', 'md5_hash': 'd41d8cd98f00b204e9800998ecf8427e'},
    ])

def downgrade():
    op.drop_table('books')
    op.drop_table('covers')
    op.execute('DELETE FROM roles WHERE name IN ("Admin", "Moderator", "User")')