import pymssql
import lib
import random
# localhost  1433
conn = pymssql.connect(server='DESKTOP-OD65O5T',
                       user='admin3', password='admin', database='hms_2')
cursor = conn.cursor()
# lib.add_department(cursor, department={
#     'name': 'engineering',
#     'description': 'engineering department for dealing with technical issues',
#     'facility_id': 1,
#     'block': 'a'
# })

for i in range(5):
    patient = {
        'first_name': lib.generate_random_name(5, 4),
        'last_name': lib.generate_random_name(5, 4),
        'date_of_birth': lib.generate_random_date(50, 1960),
        'gender': lib.generate_random_binary_gender(),
        'email': lib.generate_random_name(5, 3) + "@email.com",
        'password': lib.generate_random_name(5, 7),
        'ward_id': lib.get_null_or_id(4)

    }
    query = "exec add_patient " + lib.generate_query_params(patient) + " "
    cursor.execute(query)
    conn.commit()
    print(query)


# row = cursor.fetchone()
# while row:
#     print(str(row[0]) + " " + str(row[1]) + " " + str(row[2]))
#     row = cursor.fetchone()
