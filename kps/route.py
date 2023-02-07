from kps import app,bcrypt
from flask import redirect, render_template ,request, url_for, flash,session
import re
import mysql.connector
from kps.module import adminadd, registerform,config,cnx,login

@app.route('/')

def home():
    return redirect(url_for("u_display"))

@app.route('/log')

def u_display():
 cnx = mysql.connector.connect(**config)

 if 'loggedin' in session :
   
    cnx = mysql.connector.connect(**config)

    cursor = cnx.cursor(dictionary=True)

    sql='''SELECT * from log, student, `key` where student.s_id = log.s_id AND `key`.key_id = log.key_id
'''
    sql1 = ''' SELECT `key`.`Room` as Room, concat(student.f_name , student.l_name)as BName , student.Mobile, log.TimeIn from log, student, `key` where student.s_id = log.s_id AND `key`.key_id = log.key_id'''

    sql2= ''' SELECT `key`.`Room` as Room, concat(student.f_name , student.l_name)as BName , student.Mobile, log.TimeIn , concat(student.f_name , student.l_name)as RName , student.Mobile, log.TimeOut from log, student, `key` where student.s_id = log.s_id AND `key`.key_id = log.key_id'''

    sql3 = '''SELECT log.`SRNO.`,`key`.`Room` as Room, concat(student.f_name , student.l_name)as BName , student.Mobile, log.TimeIn , concat(student.f_name , student.l_name)as RName , student.Mobile, log.TimeOut from log, student, `key` where student.s_id = log.s_id AND `key`.key_id = log.key_id'''
    
    sql4 = '''SELECT log.`SRNO.`,`key`.`Room` as Room, concat(student.f_name , student.l_name)as BName , student.Mobile, log.TimeIn , log.rs_id as RName , student.Mobile, log.TimeOut from log, student, `key` where student.s_id = log.s_id AND `key`.key_id = log.key_id
    '''    
    sql5 = '''SELECT log.`SRNO.`,concat (student.f_name,student.l_name)as Bname , student.Mobile , log.TimeIn
    from log
    LEFT JOIN student 
    on student.s_id = log.s_id '''
    sql6 = '''
    SELECT concat(student.f_name , student.l_name) as Rname , student.Mobile
    from log
    LEFT JOIN student
    on student.s_id = log.rs_id'''
    sql7 = '''SELECT lv.`srno.` as SRNO, lv.Room,lv.Bname,lv.Mobile  ,lv.TimeIn ,rv.Rname,rv.Mobile as rvm ,rv.TimeOut 
from lv, rv
where rv.`SRNO.` = lv.`SRNO.`  
ORDER by lv.`SRNO.`
    '''
    sql8='''
SELECT log.`srno.`, `key`.`Room`,concat (student.f_name,student.l_name)as Bname , student.Mobile , log.TimeIn,concat(student.f_name , student.l_name) as Rname , student.Mobile,log.TimeOut
from log
LEFT JOIN student
on student.s_id = log.rs_id   
LEFT JOIN `key` 
on `key`.`key_id` = log.key_id
where log.rs_id = student.s_id
order by log.timeout DESC'''
    sql9='''SELECT lv.`srno.` as SRNO, lv.Room,lv.Bname,lv.Mobile  ,lv.TimeIn ,rv.Rname,rv.Mobile as rvm ,rv.TimeOut 
from lv, rv
where rv.`SRNO.` = lv.`SRNO.` and lv.TimeIn like '%s %'
ORDER by lv.`SRNO.`
    '''
    # y =2021
    # m= 12
    # d = 15
    
#     cursor.execute('''SELECT lv.`srno.` as SRNO, lv.Room,lv.Bname,lv.Mobile  ,lv.TimeIn ,rv.Rname,rv.Mobile as rvm ,rv.TimeOut 
# from lv, rv
# where rv.`SRNO.` = lv.`SRNO.` and lv.TimeIn like '%s-%s-%s %'
# ORDER by lv.`SRNO.`
#     ''',(y,m,d))
    cursor.execute(sql7)
    a=cursor.fetchall()
    i=1
    cnx.close()
    return render_template("ke.html",b=a)  
 return redirect(url_for('ulogin'))    



@app.route('/add2')
@app.route('/add', methods = ["POST", "GET"])
def add():
    key= "rfid3022"
    user= "rfids02"
# have to add a time delay of 5 sec between consecutve tabs of a same rfid using temp table    
#temp table is table which will auto deleted once the calulation is done 
# delay will be calculated using timetab1 - timetab2 > = 5 sec 
    cnx = mysql.connector.connect(**config)
    cursor = cnx.cursor(dictionary=True)
    sql=('''SELECT * FROM `key` WHERE rfid_key="rfid3011"'''  )
    cursor.execute('''SELECT * FROM `key` WHERE rfid_key= %s ''',(key,))
    a = cursor.fetchall()
    cursor.execute('''SELECT * FROM `student` WHERE Rfid_s= %s ''',(user,))
    b = cursor.fetchall()
    if len(a)>0:
        for x in a:
          kid= x['key_id']
          #return f"{kid}"   
    else:
        return "Not Found"
    if len(b)>0:
        for x in b:
          uid= x['s_id']
          #return f"{uid , kid}"   
    else:
        return "Not found"
    
    if len(a)>0:
        cursor.execute('''SELECT * FROM `log` WHERE key_id= %s AND TimeOut IS NOT NULL''',(kid,))
        d=cursor.fetchall() # here time out already exsit thus create new row 
        cursor.execute('''SELECT * FROM log where key_id = %s AND TimeIn IS NOT NULL AND TimeOut IS NULL  ''',(kid,))
        c= cursor.fetchall() # here timein exsit and time out is null dose update timeout
        
        if len(c)>0: # here timein exsit and time out is null does update timeout
         cursor.execute('''UPDATE `log` SET `TimeOut` = CURRENT_TIMESTAMP , rs_id = %s WHERE `log`.`key_id` = %s ''', (uid,kid))
         return "Time out Updated"
        elif len(d)>0: # here timeout already exsit thus create new row
            cursor.execute('''INSERT INTO `log` (`SRNO.`, `key_id`, `s_id`, `TimeIn`, `TimeOut`) VALUES (NULL, %s, %s,   CURRENT_TIMESTAMP, NULL)''', (kid,uid))
            return"New row created"
        else:
            cursor.execute('''INSERT INTO `log` (`SRNO.`, `key_id`, `s_id`, `TimeIn`, `TimeOut`) VALUES (NULL, %s, %s,   CURRENT_TIMESTAMP, NULL)''', (kid,uid))
            return "New row created"

       #INSERT INTO `log` (`SRNO.`, `key_id`, `s_id`, `TimeIn`, `TimeOut`) VALUES (NULL, 'test1', 'test1', CURRENT_TIMESTAMP, NULL);
       #UPDATE `log` SET `TimeOut` = '2022-05-07 16:13:24' WHERE `log`.`SRNO.` = 1;

    
    cnx.close()
    return "0"    

@app.route('/register' , methods=['GET', 'POST'])
def register():

    cnx = mysql.connector.connect(**config)
     
    form = registerform()
       
    
    if form.validate_on_submit() :
        uname=form.username.data
        emailaddress=form.email.data
        pwd=form.password1.data         
        pwd_hash= bcrypt.generate_password_hash(pwd).decode('utf-8')
        cursor = cnx.cursor(dictionary=True)

        cursor.execute('''SELECT username from member where username = %s''', (uname,))
        user = cursor.fetchall()
        
        if user :
            flash (f'Username already exists! Please try  a different username')
        
        cursor.execute('''SELECT email from member where email = %s''', (emailaddress,))
        emails = cursor.fetchall()
        
        if emails : 
            flash (f'Email address already exists! Please try a different email address')    
        
        
        if len(user) + len(emails) == 0: 
            cursor.execute('''INSERT INTO `member` (`SRNO`, `username`, `password`, `email`) VALUES (NULL, %s, %s, %s)''',(uname,pwd_hash,emailaddress))
            return redirect(url_for('u_display'))
            
    if form.errors != {}:
        for err in form.errors.values():
            flash(f'There was an error : {err}')   
        return render_template('register.html', form=form, cag ='danger')       
    return render_template('register.html', form=form)       


@app.route('/ulogin', methods=['GET', 'POST'])   
def ulogin():
    form = login()
    cursor = cnx.cursor(dictionary = True)
    
    if request.method == 'POST':
        user = form.username.data
        pwd = form.password1.data
        cursor.execute('''SELECT password FROM `memberview` WHERE username = %s ''' ,(user,))
        a= cursor.fetchall()
        if len(a)>0:
            for x in a:
                for y in x.values() :
                    pwd_hash = y 
            if bcrypt.check_password_hash(pwd_hash, pwd):
                session['loggedin'] = True
                cursor.execute('''SELECT * FROM `memberview` where username = %s and type = False''',(user,))
                a= cursor.fetchall()
                if a :     
                    return redirect(url_for('u_display'))
                else :
                    return redirect(url_for('adminlog'))    
            else: 
                flash(f'Username and Password does not match')            
        else: 
            flash(f'Username Not Found ')

    return render_template('ulogin.html',form=form)

@app.route('/logout')
def ulogout():
    session.pop('loggedin', None)
    return redirect(url_for('ulogin'))

@app.route('/forget')
def forget_pasward():
    pass

@app.route('/adlt')
def adminlog ():
    cnx = mysql.connector.connect(**config)

    if 'loggedin' in session :
        
        cursor = cnx.cursor(dictionary=True)
        
        form = adminadd()
        if form.validate_on_submit() :
            uid=form.uid.data
            kid= form.kid.data
            sql7='''INSERT INTO `log` (`SRNO.`, `key_id`, `s_id`, `TimeIn`, `TimeOut`) VALUES (NULL, %s, %s,   CURRENT_TIMESTAMP, NULL''',(kid,uid)
            cursor.execute(sql7)
        
        sql7 = '''SELECT lv.`srno.` as SRNO, lv.Room,lv.Bname,lv.Mobile  ,lv.TimeIn ,rv.Rname,rv.Mobile as rvm ,rv.TimeOut 
from lv, rv
where rv.`SRNO.` = lv.`SRNO.`
ORDER by lv.`SRNO.`
    '''
        cursor.execute(sql7)
        a=cursor.fetchall()
        return render_template('lt.html',b=a,form=form)
 
    return redirect(url_for('ulogin'))    

@app.route('/adu')
def adminuser (): 
    cnx = mysql.connector.connect(**config)

    if 'loggedin' in session :
        cnx = mysql.connector.connect(**config)

        cursor = cnx.cursor(dictionary=True)
        sql7 = '''SELECT * FROM `memberview`'''
        cursor.execute(sql7)
        a=cursor.fetchall()
        user= 'test1'
        sql7 = '''SELECT type FROM `memberview` where type = True and username = %s'''
        cursor.execute(sql7,(user,))
        aa=cursor.fetchall()

        return render_template("adminuser.html",b=a , c="Admin",cc="User",aa=aa)
    return redirect(url_for('ulogin'))    
@app.route("/rm",methods = ['POST', 'GET'])
def rm():
    cnx= mysql.connector.connect(**config)
    cursor=cnx.cursor(dictionary=True)
    form = adminadd()
    if form.validate_on_submit() :
        uid=form.uid.data
        kid= form.kid.data
        sql7='''INSERT INTO `log` (`SRNO.`, `key_id`, `s_id`, `TimeIn`, `TimeOut`) VALUES (NULL, %s, %s,   CURRENT_TIMESTAMP, NULL''',(kid,uid)
        cursor.execute(sql7)
        return redirect(url_for('adu'))
    return render_template('lt.html')
 
