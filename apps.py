from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_login import current_user
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
    cur.execute(
        """CREATE TABLE IF NOT EXISTS Users (
                    Username TEXT PRIMARY KEY,
                    Password TEXT NOT NULL
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
    # if "username" not in session:
    #     return redirect(url_for("login"))
    print("Session : ")
    print(session["username"])
    logged_in_user = session["username"]
    conn = create_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM Patients")
    patients = cur.fetchall()
    cur.close()
    conn.close()
    # print("current user : ")
    # print(cur)
    return render_template("index.html", patients=patients, current_user=logged_in_user)


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        print("While logging in...")
        print(username, password)

        conn = create_connection()
        cur = conn.cursor()
        cur.execute("SELECT * FROM Users WHERE Username = ?", (username,))
        user = cur.fetchone()
        cur.close()
        conn.close()

        if user and user[1] == password:
            session["username"] = username
            return redirect(url_for("index"))
        else:
            flash("Invalid username or password", "error")

    return render_template("login.html")


@app.route("/logout")
def logout():
    session.pop("username", None)
    return redirect(url_for("login"))


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        conn = create_connection()
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO Users (Username, Password) VALUES (?, ?)", (username, password)
        )
        conn.commit()
        cur.close()
        conn.close()

        # flash("Registration successful. Please log in.", "success")
        return redirect(url_for("login"))

    return render_template("register.html")


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
    app.secret_key = "super_secret_key"
    app.run(debug=True)
