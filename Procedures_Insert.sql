--create facility --one hospital has only one entry here {unless there are many many other branches}
create procedure create_facility
@name varchar(255), 
@address varchar(255),
@phone varchar(25)
as 
begin 
	insert into facility values( @name,@address, @phone)
end --created,tested
--exec create_facility 'Vader advanced universal hospital','the new empire, the outer rim,galaxy far far away', '124-123-15-2351-123'
--create department
create procedure create_department
@name varchar(100),
@description varchar(255),
@block varchar(5),
@facility_id int
as 
begin 
	insert into department values(@name, @description, @block, @facility_id)
end--created
----
--create floor
select * from department
create procedure create_floor
@level int,
@description varchar(255),
@department_id int 
as 
begin 
	insert into floor values( @level, @description, @department_id)
end --created,

--add ward
create procedure add_ward 
@name varchar(50),
@description varchar(255),
@floor_id int 
as 
begin 
	insert into ward values(@name, @description, @floor_id)
end
select * from patient
--created

--add room
create procedure add_room
@name varchar(50),
@department_id int 
as 
begin 
	insert into room values (@name, @department_id)
end --created,
--add inventory
create procedure add_inventory
@type varchar(50),
@item_id int
as
begin
	insert into inventory values( @type, @item_id)
end--created

--addInventoryItem
create procedure add_item
@amount int ,
@description varchar(50),
@name varchar(50) 
as 
begin 
	insert into item values(@amount, @description, @name)
end--created

--add inventory use
create procedure add_inventory_use
@inventory_id int ,
@technical_employee_id int ,
@amount int 
as 
begin 
	insert into inventory_in_use values (@inventory_id, @technical_employee_id, @amount)
end--created

--add patient
create procedure add_patient
@first_name varchar(50),
@last_name varchar(50) , 
@date_of_birth date ,
@gender varchar(10) ,
@email varchar(30), 
@password varchar(20),
@ward_id int 
as 
begin 
	insert into patient values( @first_name, @last_name, @date_of_birth, @gender, @email, @password, @ward_id)
end --created
select * from patient
--add patient history
create procedure add_patient_history
@condition varchar(50),
@date date,
@patient_id int 
as
begin 
	insert into history values(@condition, @date, @patient_id)
end --created
--exec add_patient_history 'hypothermia caused by swimming in winter', '1997-02-14',4
--add prescription
create procedure add_prescription 
@dose int,
@description varchar(50),
@date date,
@patient_id int,
@doctor_id int
as 
begin 
	insert into prescription values( @dose, @description, @date, @patient_id, @doctor_id)
end--created

--add medicine
create procedure add_medicine
@name varchar(100),
@chemical_formula varchar(150),
@amount int
as 
begin
	insert into medicine values( @name, @chemical_formula, @amount)
end--created
exec add_medicine 'panadol', 'acetaminophen ',20
drop procedure add_medicine

--add medicine-prescription
create procedure add_medicine_prescription
@medicine_id int,
@prescription_id int
as 
begin
	insert into medicine_prescription values( @medicine_id, @prescription_id)
end--created

--add surgery
create procedure add_surgery 
@date date,
@time time,
@patient_id int,
@surgeon_id int,
@doctor_id int
as 
begin
	insert into surgery values(@date, @time, @patient_id, @surgeon_id, @doctor_id)
end--created

--set appointment
create procedure set_appointment
@date date,
@time time,
@patient_id int,
@receptionist_id int,
@doctor_id int
as
begin
	insert into appointment values(@date, @time, @patient_id, @receptionist_id, @doctor_id)
end--created

--get all the appontments
create procedure get_appointments
@patient_id int
as 
begin
	select * from (select doctor_id, [date], [time] from appointment where  appointment.patient_id = @patient_id) app,doctor
	where doctor.id = app.doctor_id
end

--getting full doctor information
create procedure get_doctor
@doctor_id int
as 
begin
	select * from employee where id = 
	(select employee_id from medical_employee where medical_employee.id =
	(select medical_employee_id from doctor where id = @doctor_id))	
end
exec get_doctor 8