--we need to validate email
	create trigger check_email on employee instead of insert
	as begin 
	--can implement history tables
		DECLARE @first_name varchar(50);
		DECLARE @last_name varchar(50) ;
		DECLARE @date_of_birth date ;
		DECLARE @gender varchar(10) ;
		DECLARE @job_description varchar(100)  ;
		DECLARE @working_shift varchar(15) ;
		DECLARE @email varchar(50) ;
		DECLARE @password varchar(50) ;
		DECLARE @department_id int ;
		DECLARE @room_id int ;
		select @first_name =first_name,
		  @last_name=last_name, 
		 @date_of_birth =date_of_birth ,
		 @gender = gender, 
		 @job_description =job_description,
		 @working_shift =working_shift,
		 @email =email,
		 @password = password,
		 @department_id =department_id,
		 @room_id =room_id
		 from 
		 INSERTED
		if @email like '%@%.com'
		begin
			insert into employee values (@first_name,
		  @last_name, 
		 @date_of_birth  ,
		 @gender , 
		 @job_description ,
		 @working_shift ,
		 @email ,
		 @password,
		 @department_id,
		 @room_id )
		end
		else 
		begin
			insert into errors_history values(
			'error during validation, email',
			CURRENT_TIMESTAMP
			)
		end
	
end
---checking whether the items are available before assigning 
select * from inventory_in_use
create trigger on check_inventory_amount 
instead of insert
as begin 
DECLARE @inventory_id int;
DECLARE @technical_employee_id int;
DECLARE @amount int;
DECLARE @amount_present int;
DECLARE @item_id int;

select @inventory_id = inventory_id, @technical_employee_id = technical_employee_id, @amount = amount
from inserted
select @amount_present = amount from item where item.id =
	(select @item_id = inventory.item_id from inventory where inventory_id = @inventory_id)
if @amount_present <= @amount
	begin
		--update the item amount
		update item set amount = @amount_present - @amount where id = @item_id
		--now insert the inventory in use
		insert into inventory_in_use values(@inventory_id,@technical_employee_id, @amount)
	end 
else 
	begin 
		insert into errors_history values(
				'error during inserting inventory_in_usem amount is greater than present in stock',
				CURRENT_TIMESTAMP
				)
	end
	select * from inventory_in_use

	--checking password length for the patient logging in 
	create trigger on validate_deletion 
instead of delete
as begin 
DECLARE @patient_id int;
DECLARE @ward_id int;

select @ward_id
from inserted
if @ward_id = ISNULL(NULL,@ward_id)
	begin
			insert into errors_history values(
				'error during inserting inventory_in_usem amount is greater than present in stock',
				CURRENT_TIMESTAMP
				)
	end 
else 
	begin 
	
	end