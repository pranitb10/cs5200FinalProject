from operator import truediv
import pymysql
import pandas as pd

# Using Pandas library to display the resulting data in a proper format.
pd.set_option('display.max_columns', None)

# Connect to the database
while True:
    print("Please enter your username")
    username = input()

    print("Please enter your password")
    password = input()

    print("Connect database ... ")
    try:
        connection = pymysql.connect(host='localhost', user=username, password=password,
                                     db='airbnb', charset='utf8mb4',
                                     cursorclass=pymysql.cursors.DictCursor)
        print("Database connection successful.")
        break
    except:
        print("Database connection failed.")

# Create cursor object to execute SQL commands
cursor = connection.cursor()

def create_new_host() :
    host_name = input("Enter your name: ")
    host_email = input("Enter your email: ")
    host_phone = input("Enter your phone: ")
    create_new_host = cursor.callproc("create_host", [host_name, host_email, host_phone])

def create_new_tenant() :
    t_name = input("Enter your name: ")
    t_email = input("Enter your email: ")
    t_phone = input("Enter your phone: ")
    create_new_tenant = cursor.callproc("create_tenant", [t_name, t_email, t_phone]) 

def host_login(host_login_email) :
    # Call the login_host procedure and print the result
    result_args = cursor.callproc("login_host", [email, " "])
    result = result_args[-1]
    if result == 1:
        print("Login Successful.")
    else:
       print("Login Unsuccessful. No such user exists.") 

def tenant_login(tenant_login_email):
    # Call the login_tenant procedure and print the result
    result_args = cursor.callproc("login_tenant", [email, " "])
    result = result_args[-1]
    if result == 1:
        print("Login Successful.")
    else:
       print("Login Unsuccessful. No such user exists.")

def tenant_menu(tenant_email):
    loop = True
    while(loop):
        menu_options = input("Home Screen Menu. \n Please enter any of the below given options (any number) to perform an action as a tenant. \n" + 
        "1) Search Airbnbs. \n2) See all orders. \n3) Rate a completed order. \n4)Edit your tenant profile. \n5) Logout. \n") 
        if menu_options == '1':
            enter_country = input("You've selected to search an Airbnb. \n Please enter a country where you would like to search an Airbnb at. \n")
            country_check = cursor.callproc("check_country", [enter_country, " "])
            result_country = country_check[-1]
            if result_country == 1:
                enter_city = input("Now please enter a city in this country where you want to look up for an Airbnb. \n")
                city_check = cursor.callproc("check_city", [enter_city, " "])
                result_city = city_check[-1]
                if result_city == 1:
                    start_date = input("Can you please enter a start date for your reservation? \n")
                    start_date_check = cursor.callproc("validate_start_date", [start_date, " "])
                    result_start_date = start_date_check[-1]
                    if result_start_date == 0:
                        print("Entered date is null. Please enter a valid date.")
                    elif result_start_date == -1:
                        print("Entered date is before today's date. Please enter a valid date.")
                    else:
                        end_date = input("Can you please enter a start date for your reservation? \n")
                        end_date_check = cursor.callproc("validate_end_date", [end_date, " "])
                        result_end_date = end_date_check[-1]
                        if result_end_date == 0:
                            print("Entered date is null. Please enter a valid date.")
                        elif result_end_date == -1:
                            print("Entered date is before today's date. Please enter a valid date.")
                        else:
                            search_airbnb = cursor.callproc("search_airbnbs", [enter_country, enter_city, start_date, end_date])
                            print(search_airbnb)
                            house_id = input("Please enter a house id to book and create an order.\n")
                            generate_order = cursor.callproc("create_order", [email, enter_country, house_id, start_date, end_date, " "])
                            order_num = generate_order[-1]
                            print("You've successfully booked the Airbnb no. ", house_id, ". Your order number is: ", order_num)
                else:
                    print("We could not find an Airbnb in the entered city. Please search for a new city.")
            else:
                print("We could not find an Airbnb in the entered country. Please search for a new country.") 
        elif menu_options == '2':
            list_tenant_orders = cursor.callproc("list_orders_by_tenant", [email])
        elif menu_options == '3':
            list_completed_orders = cursor.callproc("get_completed_orders_to_rate", [email])
            print(list_completed_orders)
            order_no = input("Please enter the order number you want to rate based on your living experience at the Airbnb. \n")
            rating = input("Please enter your rating on a scale of 0-5 for the selected Airbnb.")
            rate_airbnb = cursor.callproc("rate_order_and_update_airbnb", [order_no, rating])
            print("You've successfully rated a ", rating, " to an Airbnb having order number ", order_no)
        elif menu_options == '4':
            print("You've decided to edit your profile. \n. Here you can edit your gender and language.\n")
            edit_gender = input("Please enter the gender you want to change to. \nYou can choose from Male, Female or Not to tell.\n")
            edit_language = input("Please enter a language you want to change to.")
            edit_tenant_profile = cursor.callproc("edit_tenant", [email, edit_gender, edit_language])
            print("You have successfully changed your gender to ", edit_gender, " and your language of preferrence to ", edit_language)
        elif menu_options == '5':
            print("You've been logged out. Thank you!")
            loop = False
        else:
            print("Please enter a valid response to the menu options.")

def host_menu(host_email):
    loop = True
    while(loop):
        menu_options = input("Home Screen Menu. \n Please enter any of the below given options (any number) to perform an action as a host. \n" + 
        "1) Search Airbnbs. \n2) See all orders. \n3) Rate a completed order. \n4)Edit your tenant profile. \n5) Logout. \n") 



first_quest = input("Are you a new user? Please enter yes or no. \n")

if first_quest.lower() == "yes":
    second_quest = input("Would you like to sign up as a host or tenant? \n")

    if second_quest.lower() == "host":
        create_new_host()
        print("Host account successfully created.")
    else:
        create_new_tenant()
        print("Tenant account successfully created.")
else: 
    # Prompt the user to select their user type (host or tenant)
    user_type = input("Are you a host or a tenant? \n")

    # Prompt the user to enter their email
    email = input("Enter your email: \n")

    # Call the appropriate stored procedure based on user type
    if user_type.lower() == "host":
        host_login(email)
        host_menu(email)
    elif user_type.lower() == "tenant":
        tenant_login(email)
        tenant_menu(email)
    else:
        print("Invalid user type.")
    
# Close the database connection
cursor.close()
connection.close()