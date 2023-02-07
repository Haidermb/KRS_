from flask_wtf import FlaskForm
from wtforms import StringField ,EmailField, PasswordField, SubmitField
from wtforms.validators import Length , EqualTo, Email ,DataRequired, ValidationError
import mysql.connector 


config = {
  'user': 'root',
  'password': '',
  'host': 'localhost',
  'database': 'nli',
  'raise_on_warnings': True
} 

cnx = mysql.connector.connect(**config)




class registerform(FlaskForm):
  

    username = StringField(label ='User Name', validators=[Length(min=2,max=30),DataRequired()])
    email= EmailField(label='Email', validators=[Email(),DataRequired()])
    password1 = PasswordField(label='Create Password',validators=[Length(min=6),DataRequired()])
    password2 = PasswordField(label='Confirm Password' ,validators=[EqualTo('password1'),DataRequired()])
    submit = SubmitField(label = 'Create Account')



class login(FlaskForm):
    username = StringField(label ='User Name', validators=[DataRequired()])
    password1 = PasswordField(label='Eneter Password',validators=[DataRequired()])
    uid = StringField(label ='Enter User ID', validators=[DataRequired()])
    kid = StringField(label='Eneter Key ID',validators=[DataRequired()])

    submit = SubmitField(label = 'Sign in')

class adminadd(FlaskForm):
  submit = SubmitField(label = 'Save')
