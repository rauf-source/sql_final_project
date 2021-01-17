--some views
create view patients_info
as
select id, first_name, last_name, date_of_birth, time, doctor_id from patient
inner join appointment
on patient.id = appointment.patient_id
--
