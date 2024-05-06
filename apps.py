# from flask import Flask, render_template, request, redirect, url_for, flash
# from flask_mysqldb import MySQL

# app = Flask(__name__)

# app.config['MYSQL_HOST'] = 'localhost'
# app.config['MYSQL_USER'] = 'root'
# app.config['MYSQL_PASSWORD'] = 'root'
# app.config['MYSQL_DB'] = 'covid19'

# mysql = MySQL(app)

# @app.route('/')
# def index():
#     cur = mysql.connection.cursor()
#     cur.execute("SELECT * FROM Patients")
#     patients = cur.fetchall()
#     cur.close()
#     return render_template('index.html', patients=patients)

# @app.route('/add_patient', methods=['POST'])
# def add_patient():
#     if request.method == 'POST':
#         serialnumber = request.form['ID']
#         name = request.form['Name']
#         age = request.form['Age']
#         gender = request.form['Gender']
#         contact = request.form['ContactDetails']
#         address = request.form['Address']
#         medicalhistory = request.form['MedicalHistory']

#         cur = mysql.connection.cursor()
#         cur.execute("INSERT INTO Patients (ID ,Name, Age, Gender, ContactDetails, Address, MedicalHistory) VALUES (%s, %s, %s, %s, %s, %s, %s)",
#                     (serialnumber,name, age, gender, contact, address, medicalhistory))
#         mysql.connection.commit()
#         cur.close()

#         flash('Patient added successfully', 'success')
#         return redirect(url_for('index'))

# if __name__ == '__main__':
#     app.secret_key = 'super_secret_key'
    # app.run(debug=False)

from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'covid19'

mysql = MySQL(app)

@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Patients")
    patients = cur.fetchall()
    cur.close()
    return render_template('index.html', patients=patients)

@app.route('/add_patient', methods=['POST'])
def add_patient():
    if request.method == 'POST':
        serialnumber = request.form['ID']
        name = request.form['Name']
        age = request.form['Age']
        gender = request.form['Gender']
        contact = request.form['ContactDetails']
        address = request.form['Address']
        medicalhistory = request.form['MedicalHistory']

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO Patients (ID ,Name, Age, Gender, ContactDetails, Address, MedicalHistory) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                    (serialnumber,name, age, gender, contact, address, medicalhistory))
        mysql.connection.commit()
        cur.close()

        flash('Patient added successfully', 'success')
        return redirect(url_for('index'))

@app.route('/hospitals')
def hospitals():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Hospitals")
    hospitals = cur.fetchall()
    cur.close()
    return render_template('hospitals.html', hospitals=hospitals)

@app.route('/tests')
def tests():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Tests")
    tests = cur.fetchall()
    cur.close()
    return render_template('tests.html', tests=tests)

if __name__ == '__main__':
    app.secret_key = 'super_secret_key'
    app.run(debug=False)