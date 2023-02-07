from flask import Flask 
from flask_bcrypt import Bcrypt
from flask_session import Session
from datetime import timedelta


app = Flask(__name__)
app.config['SECRET_KEY'] ='627403cbfc5f2966080038e5'
bcrypt = Bcrypt(app)
app.config["SESSION_PERMANENT"] = True
app.config["SESSION_TYPE"] = "filesystem"
app.permanent_session_lifetime = timedelta(minutes=1)

Session(app)

from kps import route