drop database hms_3
create database hms_3
use  hms_3
--project tables definition
--facility/hospital branch/hospital table
create table facility(id int identity(1,1) primary key clustered, [name] varchar(255) not null unique, [address] varchar(255) not null, phone varchar(25))
--department
create table department (id int primary key clustered identity(1,1), [name] varchar(100) not null,
[description] varchar(255) not null,
[block] varchar(5) not null,
facility_id int foreign key references facility(id) not null
)

--floor
create table floor (id int primary key clustered identity(1,1) , [level] int not null,
[description] varchar(255) not null,
department_id int foreign key references department(id) not null
)
--a floor has different wards and rooms
--ward
create table ward (id int primary key clustered identity(1,1), name varchar(50) not null,
[description] varchar(255) not null,
floor_id int foreign key references floor(id) not null
)
--room
create table room (id int primary key clustered identity(1,1), name varchar(50) not null,
floor_id int foreign key references floor(id) not null
)

--patient
create table patient (id int primary key clustered identity(1,1), first_name varchar(50) not null,
	last_name varchar(50) not null, date_of_birth date not null,
	 gender varchar(10) not null check(gender in ('male' , 'female', 'other') ),
	email varchar(50) not null unique, password varchar(20) not null ,
	 ward_id int foreign key references ward(id)  null
	)
	

-- patient history
create table history (
id int primary key clustered identity(1,1),
condition varchar(50) not null,
[date] date not null,
patient_id int foreign key references patient(id) not null
)
--prescription {after employee tables are done}

--create employee
create table employee (
id int primary key clustered identity(1,1) ,
first_name varchar(50) not null,
last_name varchar(50) not null,
date_of_birth date not null,
gender varchar(10) not null check(gender in ('male' , 'female', 'other') ),
job_description varchar(100) not null ,
working_shift varchar(15) not null check(working_shift in ('full_time', 'morning', 'night') ),
email varchar(50) not null,
password varchar(50) not null,
department_id int foreign key references department(id) not null,
room_id int foreign key references room(id) null
)

----medical
	create table medical_employee (
	id int primary key clustered identity(1,1),
	employee_id int foreign key references employee(id) not null unique
	)
	--managerial
	create table managerial_employee (
	id int primary key clustered identity(1,1),
	[type] varchar(20) not null check ([type] in ('hr_manager','facility_manager', 'receptionist') ),
	employee_id int foreign key references employee(id) unique not null
	)
--drop table managerial_employee
	--technical
	create table technical_employee (
	id int primary key clustered identity(1,1),
	post varchar(50) not null,
	type varchar(50) not null,
	floor_id int foreign key references floor(id) null,
	employee_id int foreign key references employee(id) unique not null
	)
	--inventory for the technical employees
	create table item (
	id int primary key clustered identity(1,1),
	amount int not null,
	description varchar(50) not null,
	[name] varchar(50) not null unique,
	)
	create table inventory (
	id int primary key clustered identity(1,1),
	[type] varchar(50) not null,
	item_id int foreign key references item(id) not null unique
	)
	create table inventory_in_use (
	primary key(inventory_id, technical_employee_id),
	inventory_id int foreign key references inventory(id),
	technical_employee_id int foreign key references technical_employee(id),
	amount int not null
	)
	--DOCTOR NURSE SURGEON
	create table doctor (
	id int primary key clustered identity(1,1),
	speciality varchar(50) not null,
	medical_employee_id int foreign key references medical_employee(id)
	)
	create table surgeon (
	id int primary key clustered identity(1,1),
	speciality varchar(50) not null,
	medical_employee_id int foreign key references medical_employee(id)
	)
	create table nurse (
	id int primary key clustered identity(1,1),
	role varchar(50) not null,
	medical_employee_id int foreign key references medical_employee(id) not null,
	ward_id int foreign key references ward(id) null 
	)

	--appointment
	create table appointment (
	[date] date not null,
	[time] time not null,
	primary key (patient_id, receptionist_id, doctor_id),
	patient_id int foreign key references patient(id) not null,
	receptionist_id int foreign key references managerial_employee(id) not null,
	doctor_id int foreign key references doctor(id) not null,

	
	)
	--PRESCRIPTIOn
	create table prescription(
	id int primary key clustered identity(1,1),
	dose int not null,
	description varchar(50) not null,
	[date] date not null,
	patient_id int foreign key references patient(id) ,
	doctor_id int foreign key references doctor(id)
	
	)
	--medicine prsecription
	create table medicine (
	id int primary key clustered identity(1,1),
	name varchar (100) not null unique,
	chemical_formula varchar(150) not null,
	amount int not null,
	)
	--medicine
	create table medicine_prescription (
	id int primary key clustered identity(1,1),
	medicine_id int foreign key references medicine(id),
	prescription_id int foreign key references prescription(id),
	)
	--SURGERY
		create table surgery (
	[date] date not null,
	[time] time not null,
	primary key (patient_id, surgeon_id, doctor_id),
	patient_id int foreign key references patient(id) not null,
	surgeon_id int foreign key references surgeon(id) not null,
	doctor_id int foreign key references doctor(id) not null
	)

	create table errors_history (
	id int primary key clustered identity(1,1),
	error varchar(255) not null,
	[time] date not null,
	

	)
	--drop table errors_history