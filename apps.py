from flask import Flask, render_template, request, redirect, url_for, flash
import sqlite3
import atexit

app = Flask(__name__)

DATABASE = "/covid.db"


def create_connection():
    conn = sqlite3.connect("covid.db")
    return conn


def create_tables():
    conn = create_connection()
    cur = conn.cursor()
    cur.execute(
        """CREATE TABLE IF NOT EXISTS Patients (
                    ID INTEGER PRIMARY KEY,
                    Name TEXT NOT NULL,
                    Age INTEGER NOT NULL,
                    Gender TEXT NOT NULL,
                    ContactDetails TEXT NOT NULL,
                    Address TEXT NOT NULL,
                    MedicalHistory TEXT NOT NULL
                )"""
    )
    cur.execute(
        """CREATE TABLE IF NOT EXISTS Hospitals (
                    HospitalID INTEGER PRIMARY KEY,
                    Name TEXT NOT NULL,
                    Location TEXT NOT NULL
                )"""
    )
    cur.execute(
        """CREATE TABLE IF NOT EXISTS Tests (
                    TestID INTEGER PRIMARY KEY,
                    Name TEXT NOT NULL,
                    Description TEXT NOT NULL
                )"""
    )
    conn.commit()
    cur.close()
    conn.close()


atexit.register(create_tables)


# @app.before_first_request
# def before_first_request_func():
#     create_tables()


@app.route("/")
def index():
    conn = create_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM Patients")
    patients = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("index.html", patients=patients)


@app.route("/add_patient", methods=["POST"])
def add_patient():
    if request.method == "POST":
        serialnumber = int(request.form["ID"])  # Convert to integer
        name = request.form["Name"]
        age = int(request.form["Age"])  # Convert to integer
        gender = request.form["Gender"]
        contact = request.form["ContactDetails"]
        address = request.form["Address"]
        medicalhistory = request.form["MedicalHistory"]

        conn = create_connection()
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO Patients (ID, Name, Age, Gender, ContactDetails, Address, MedicalHistory) VALUES (?, ?, ?, ?, ?, ?, ?)",
            (serialnumber, name, age, gender, contact, address, medicalhistory),
        )
        conn.commit()
        cur.close()
        conn.close()

        flash("Patient added successfully", "success")
        return redirect(url_for("index"))


@app.route("/hospitals")
def hospitals():
    conn = create_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM Hospitals")
    hospitals = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("hospitals.html", hospitals=hospitals)


@app.route("/tests")
def tests():
    conn = create_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM Tests")
    tests = cur.fetchall()
    cur.close()
    conn.close()
    return render_template("tests.html", tests=tests)


if __name__ == "__main__":
    # app.secret_key = "super_secret_key"
    app.run(debug=True)
