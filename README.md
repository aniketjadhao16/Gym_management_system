# 🏋️ Gym Management System

A simple **Database Management System (DBMS) mini project** developed using **MySQL**.

## 📌 Project Description

The **Gym Management System** is a relational database designed to manage basic gym operations such as gym members, trainers, membership plans, memberships, and payments.

This project focuses only on the **database layer** and does not include a frontend or backend application.

The project demonstrates important DBMS concepts including:

* Relational database design
* Primary keys and foreign keys
* Database constraints
* Normalization
* CRUD operations
* SQL joins
* Aggregate functions
* Views
* Triggers
* Transactions

---

## 🎯 Objectives

The main objectives of this project are:

* To design a simple relational database for a gym.
* To store and manage member information.
* To manage trainer information.
* To manage different membership plans.
* To maintain membership records.
* To store payment information.
* To demonstrate important SQL and DBMS concepts.

---

## 🛠️ Technologies Used

| Technology      | Purpose                          |
| --------------- | -------------------------------- |
| MySQL           | Database Management System       |
| SQL             | Database creation and operations |
| MySQL Workbench | SQL development and execution    |

---

## 🗄️ Database Structure

The database is named:

```text
gym_management
```

It contains five main tables:

### 1. `trainers`

Stores information about gym trainers.

Main fields:

* `trainer_id`
* `trainer_name`
* `specialization`
* `phone`
* `email`

### 2. `members`

Stores information about gym members.

Main fields:

* `member_id`
* `member_name`
* `gender`
* `phone`
* `email`
* `join_date`
* `trainer_id`

### 3. `membership_plans`

Stores available gym membership plans.

Main fields:

* `plan_id`
* `plan_name`
* `duration_months`
* `price`

### 4. `memberships`

Stores membership information for each member.

Main fields:

* `membership_id`
* `member_id`
* `plan_id`
* `start_date`
* `end_date`
* `status`

### 5. `payments`

Stores payment information.

Main fields:

* `payment_id`
* `membership_id`
* `payment_date`
* `amount`
* `payment_method`

---

## 🔗 Database Relationships

The major relationships are:

```text
TRAINERS
    |
    | 1 : Many
    |
 MEMBERS
    |
    | 1 : Many
    |
MEMBERSHIPS
    |
    +------------------+
    |                  |
    v                  v
MEMBERSHIP_PLANS    PAYMENTS
```

A trainer can be assigned to multiple members.

A member can have membership records.

Each membership is associated with one membership plan.

A membership can have payment records.

---

## ✨ DBMS Concepts Implemented

### Primary Keys

Every major table has a unique primary key.

Examples:

```sql
trainer_id
member_id
plan_id
membership_id
payment_id
```

### Foreign Keys

Foreign keys are used to establish relationships between tables.

Examples:

```text
members.trainer_id → trainers.trainer_id

memberships.member_id → members.member_id

memberships.plan_id → membership_plans.plan_id

payments.membership_id → memberships.membership_id
```

### Constraints

The project uses:

* `PRIMARY KEY`
* `FOREIGN KEY`
* `NOT NULL`
* `UNIQUE`
* `CHECK`
* `DEFAULT`

---

## 🔄 CRUD Operations

The project demonstrates all four basic database operations:

### Create

```sql
INSERT INTO members
(member_name, gender, phone, email, join_date, trainer_id)
VALUES
('Kunal More', 'Male', '9000000006',
'kunal@gmail.com', '2026-06-01', 1);
```

### Read

```sql
SELECT * FROM members;
```

### Update

```sql
UPDATE members
SET phone = '9111111111'
WHERE member_id = 6;
```

### Delete

```sql
DELETE FROM members
WHERE member_id = 6;
```

---

## 🔎 SQL Queries

The project contains SQL queries for:

* Displaying all members
* Displaying trainers
* Displaying membership plans
* Displaying members with trainers
* Displaying membership details
* Displaying payment details
* Finding active members
* Calculating total revenue
* Calculating revenue by payment method
* Counting members assigned to each trainer

---

## 👁️ View

The project contains a view called:

```text
active_members_view
```

It displays active gym members along with their membership information.

Example:

```sql
SELECT * FROM active_members_view;
```

---

## ⚡ Trigger

A trigger named:

```text
before_membership_insert
```

is implemented.

It automatically sets the membership status to:

* `Active` if the membership end date has not passed.
* `Expired` if the end date has already passed.

---

## 🔐 Transaction

A transaction is demonstrated while recording payments.

Example:

```sql
START TRANSACTION;

INSERT INTO payments
(membership_id, payment_date, amount, payment_method)
VALUES
(5, CURDATE(), 4800.00, 'UPI');

COMMIT;
```

If an error occurs, the transaction can be cancelled using:

```sql
ROLLBACK;
```

---

## ▶️ How to Run the Project

### Step 1: Install MySQL

Install **MySQL Server** and optionally **MySQL Workbench**.

### Step 2: Open MySQL Workbench

Open MySQL Workbench and connect to your MySQL server.

### Step 3: Open the SQL File

Open:

```text
Gym_Management_System.sql
```

### Step 4: Execute the Script

Run the complete SQL script.

The script will:

1. Create the database.
2. Create all tables.
3. Add primary and foreign keys.
4. Add constraints.
5. Insert sample data.
6. Execute sample CRUD operations.
7. Create SQL queries.
8. Create the view.
9. Create the trigger.
10. Demonstrate a transaction.

### Step 5: Select the Database

```sql
USE gym_management;
```

You can then execute the queries individually.

---

## 📂 Project Structure

```text
Gym-Management-System/
│
├── README.md
│
├── Gym_Management_System.sql
│
├── Gym_Management_System_Report.pdf
│
└── screenshots/
    │
    ├── members_trainers.png
    ├── membership_details.png
    ├── payment_details.png
    └── revenue_by_payment_method.png
```

---

## 📸 Screenshots

The repository contains screenshots showing the output of the SQL queries.

### Members with Trainers

Shows gym members and their assigned trainers.

### Membership Details

Shows membership plans, duration, start date, end date, and status.

### Payment Details

Shows payment information for gym members.

### Revenue by Payment Method

Shows the total revenue collected through different payment methods.

---

## 📊 Sample Data

The project contains sample data for:

* 3 Trainers
* 5 Members
* 3 Membership Plans
* 5 Membership Records
* 5 Payment Records

### Membership Plans

| Plan     | Duration | Price |
| -------- | -------: | ----: |
| Basic    |  1 Month | ₹1000 |
| Standard | 3 Months | ₹2700 |
| Premium  | 6 Months | ₹4800 |

---

## 📄 Project Report

The complete project report is available in:

```text
Gym_Management_System_Report.pdf
```

The report contains:

* Introduction
* Problem Statement
* Objectives
* Scope
* Technologies Used
* ER Diagram
* Database Schema
* Normalization
* SQL Features
* SQL Queries
* Sample Data
* Output Screenshots
* Advantages
* Limitations
* Future Scope
* Conclusion

---

## 🚀 Future Scope

The project can be extended in the future by adding:

* Attendance management
* Workout plans
* Diet plans
* Online payment
* Membership expiry notifications
* Admin authentication
* Member progress tracking
* Web or mobile interface

---

## 👨‍🎓 Project Information

**Project:** Gym Management System
**Subject:** Database Management Systems
**DBMS:** MySQL
**Project Type:** Mini Project

---

## 📜 License

This project was created for **educational and academic purposes** as a DBMS mini project.

