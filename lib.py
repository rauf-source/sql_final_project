# insert random stuff
# def insert_departments(n, cursor):
import string
import random


def add_department(cursor, department):
    query = "exec create_department(" + generate_query_params(department)+")"
    print(query)
    # cursor.execute("exec create_department()")


def generate_query_params(obj):
    query = ""
    for key in obj:
        if(type(obj[key]) == str):
            query += "'"+obj[key]+"',"
        elif (type(obj[key]) == int):
            query += str(obj[key])+','
        elif (type(obj[key]).__name__ == 'NoneType'):
            query += "NULL,"
    return query[:-1]


def generate_random_name(weight, bias):
    s = ""
    for i in range(int(random.random()*weight)+bias):
        s += random.choice(string.ascii_letters[:26])
    return s


def generate_random_date(weight, bias):
    s = ""
    s += str(int(random.random()*weight)+bias)
    s += "-12-23"
    return s


def generate_random_binary_gender():
    n = int(random.random()*2)
    if n == 0:
        return 'male'
    else:
        return 'female'


def get_null_or_id(weight):
    if(bool(int(random.random()*2))):
        return int((random.random()*weight)+1)
    else:
        return None
# different objects that were used in filling db may be used if time permits for a gui app
# department = {
#     'name': 'physiology',
#     'description': 'department for physiology',
#     'block': 'B',
#     'facility_id': 1
# }
# floor = {
#     'level': 5,
#     'description': 'template discussion, no time for everything',
#     'department_id': 8
# }

#  ward = {
#             'name': lib.generate_random_name(5, 4),
#             'description': lib.generate_random_name(40, 10),
#             'floor_id': i+1
#         }
#    patient = {
#         'first_name': lib.generate_random_name(5, 4),
#         'last_name': lib.generate_random_name(5, 4),
#         'date_of_birth': lib.generate_random_date(50, 1960),
#         'gender': lib.generate_random_binary_gender(),
#         'email': lib.generate_random_name(5, 3) + "@email.com",
#         'password': lib.generate_random_name(5, 7),
#         'ward_id': lib.get_null_or_id(4)

#     }
