import hashlib
import os
import uuid
from flask import current_app
from werkzeug.utils import secure_filename
from app.models import db, Cover

class ImageSaver:
    def __init__(self, file):
        self.file = file

    def save(self):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img

        self.img = Cover(
            id=str(uuid.uuid4()),
            filename='',
            mime_type=self.file.mimetype,
            md5_hash=self.md5_hash
        )
        db.session.add(self.img)
        db.session.flush()
        filename = f'{self.img.id}{os.path.splitext(secure_filename(self.file.filename))[1]}'
        self.img.filename = filename
        self.file.save(os.path.join(current_app.config['UPLOAD_FOLDER'], filename))

        db.session.commit()
        return self.img

    def __find_by_md5_hash(self):
        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()
        self.file.seek(0)
        return db.session.execute(db.select(Cover).filter(Cover.md5_hash == self.md5_hash)).scalar()