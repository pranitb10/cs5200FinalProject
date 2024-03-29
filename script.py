import email
from operator import truediv
from select import select
from unittest import result
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

pd.options.display.max_columns = None
def showPandasDataFrame(attributes, table):
    df = pd.DataFrame(table, columns=attributes)
    print(df)
    print()

def readData(data_dict):
    if len(data_dict) == 0:
        return [], []
    attributes = list(data_dict[0].keys())
    info = []
    for row in data_dict:
        tuple = []
        for attr in attributes:
            tuple.append(row[attr])
        info.append(tuple)
    return attributes, info

def create_new_host() :
    host_name = input("Enter your name: \n")
    host_email = input("Enter your email: \n")
    host_phone = input("Enter your phone: \n")
    host_gender = input("Enter your gender (Male, Female, Others, or Not to tell): \n")
    language_query = "CALL get_languages()"
    language_args = cursor.execute(language_query)
    language_result = cursor.fetchall()
    attr, info = readData(language_result)
    showPandasDataFrame(attr, info)
    host_language = input("Enter your preferred language code from the above list: \n")
    query = "CALL create_host(%s, %s, %s, %s, %s)"
    cursor.execute(query, (host_name, host_email, host_phone, host_gender, host_language))
    print("Welcome new host ", host_name, "\n\n")
    connection.commit()
    host_login(host_email)


def create_new_tenant() :
    t_name = input("Enter your name: \n")
    t_email = input("Enter your email: \n")
    t_phone = input("Enter your phone: \n")
    t_gender = input("Enter your gender (Male, Female, Others, or Not to tell): \n")
    language_query = "CALL get_languages()"
    language_args = cursor.execute(language_query)
    language_result = cursor.fetchall()
    attr, info = readData(language_result)
    showPandasDataFrame(attr, info)
    t_language = input("Enter your preferred language code from the above list: \n")
    query = "CALL create_tenant(%s, %s, %s, %s, %s)"
    cursor.execute(query, (t_name, t_email, t_phone, t_gender, t_language))
    print("Welcome new tenant ", t_name, "\n\n")
    connection.commit()
    tenant_login(t_email)

def host_login(host_login_email) :
    # Call the login_host procedure and print the result
    query = "SELECT login_host(%s) AS host_login"
    result_args = cursor.execute(query, (host_login_email,))
    result = cursor.fetchall()[0]["host_login"]
    if result == 1:
        print("Login Successful.\n\n")
        host_menu(host_login_email)
    else:
       print("Login Unsuccessful. No such user exists.\n\n") 

def tenant_login(tenant_login_email):
    # Call the login_tenant procedure and print the result
    query = "SELECT login_tenant(%s) AS tenant_login"
    result_args = cursor.execute(query, (tenant_login_email,))
    result = cursor.fetchall()[0]["tenant_login"]
    if result == 1:
        print("Login Successful.\n\n")
        tenant_menu(tenant_login_email)
    else:
       print("Login Unsuccessful. No such user exists.\n\n")


#tenant menu options
def tenant_menu(tenant_email):
    loop = True
    while(loop):
        menu_options = input("Home Screen Menu. \n\nPlease enter any of the below given options (any number)" + 
        " to perform an action as a tenant: \n\n1) Search Airbnbs. \n2) See all orders. \n3) Rate a completed order." + 
        " \n4) Edit your Tenant profile. \n5) Give Profile Details. \n6) Logout. \n\n") 
        if menu_options == '1':
            enter_country = input("You've selected to search an Airbnb. \n Please enter a country where you would like to search" + 
            " an Airbnb at. \n")
            query = "CALL check_country(%s)"
            result_args = cursor.execute(query, (enter_country,))
            result_country = cursor.fetchall()[0]['out_response']
            if result_country == 1:
                enter_city = input("\nNow please enter a city in this country where you want to look up for an Airbnb. \n")
                query = "CALL check_city(%s)"
                result_args = cursor.execute(query, (enter_city,))
                result_city = cursor.fetchall()[0]['out_response']
                if result_city == 1:
                    start_date = input("\nCan you please enter a start date for your reservation? \n")
                    query = "CALL validate_start_date(%s)"
                    result_args = cursor.execute(query, (start_date,))
                    result_start_date = cursor.fetchall()[0]['p_result']
                    if result_start_date == 0:
                        print("\nEntered date is null. Please enter a valid date. \n")
                    elif result_start_date == -1:
                        print("\nEntered date is before today's date. Please enter a valid date. \n")
                    else:
                        end_date = input("\nCan you please enter an end date for your reservation? \n")
                        query = "CALL validate_end_date(%s)"
                        result_args = cursor.execute(query, (end_date,))
                        result_end_date = cursor.fetchall()[0]['p_result']
                        if result_end_date == 0:
                            print("\nEntered date is null. Please enter a valid date. \n")
                        elif result_end_date == -1:
                            print("\nEntered date is before today's date. Please enter a valid date. \n")
                        else:
                            query = "CALL search_airbnbs(%s, %s, %s, %s)"
                            result_args = cursor.execute(query, (enter_country, enter_city, start_date, end_date))
                            result_search_airbnb = cursor.fetchall()
                            attr, info = readData(result_search_airbnb)
                            showPandasDataFrame(attr, info)
                            
                            house_id = input("\nPlease enter a house id to book and create an order.\n\n")
                            query2 = "CALL create_order(%s, %s, %s, %s)"
                            result_arg = cursor.execute(query2, (email, house_id, start_date, end_date,))
                            result = cursor.fetchall()[0]["out_order_num"]
                            print("You've successfully booked the Airbnb no. ", house_id, ". Your order number is: ", result)
                            connection.commit()
                else:
                    print("\n\nWe could not find an Airbnb in the entered city. Please search for a new city. \n")
            else:
                print("\n\nWe could not find an Airbnb in the entered country. Please search for a new country. \n")

        elif menu_options == '2':
            query = "CALL list_orders_by_tenant(%s)"
            result_args = cursor.execute(query, (email))
            result_list_all_orders = cursor.fetchall()
            attr, info = readData(result_list_all_orders)
            showPandasDataFrame(attr, info)

        elif menu_options == '3':
            query = "CALL get_completed_orders_to_rate(%s)"
            result_args = cursor.execute(query, (email))
            result_list_completed_orders = cursor.fetchall()
            attr, info = readData(result_list_completed_orders)
            showPandasDataFrame(attr, info)
            
            order_no = input("\n\nPlease enter the order number you want to rate based on your living experience at the Airbnb. \n")
            rating = input("Please enter your rating on a scale of 0-5 for the selected Airbnb. \n")
            query2 = "CALL rate_order_and_update_airbnb(%s, %s)"
            result_arg = cursor.execute(query2, (order_no, rating))
            print("\n\nYou've successfully rated a ", rating, " to an Airbnb having order number ", order_no, "\n\n")

        elif menu_options == '4':
            print("\nYou've decided to edit your profile. \n. Here you can edit your gender and language.\n")
            edit_gender = input("Please enter the gender you want to change to. \nYou can choose from Male, Female, Others or Not to tell.\n")

            language_query = "CALL get_languages()"
            language_arg = cursor.execute(language_query)
            edit_language = input("Please enter a language code you want to change to from the list above. \n")

            query = "CALL edit_tenant(%s, %s, %s)"
            result_args = cursor.execute(query, (email, edit_gender, edit_language))
            connection.commit()

            print("\nYou have successfully changed your gender to ", edit_gender, " and your language of preferrence to ", edit_language)

        elif menu_options == '5':
            query = "CALL get_tenant_details(%s)"
            result_args = cursor.execute(query, (email))
            profile_details = cursor.fetchall()
            attr, info = readData(profile_details)
            showPandasDataFrame(attr, info)

        elif menu_options == '6':
            print("\n\nYou've been logged out. Thank you!\n")
            loop = False
        else:
            print("\n\nPlease enter a valid response to the menu options.")



#host menu options
def host_menu(host_email):
    loop = True
    while(loop):
        menu_options = input("Home Screen Menu. \n\n Please enter any of the below given options (any number)" + 
        " to perform an action as a host. \n1) Display all your owned Airbnbs. \n2) Post a new Airbnb. \n3) Mark an Airbnb unavailable." + 
        " \n4) Edit price for an Airbnb. \n5) Show all orders. \n6) Show all 'wait-to-confirmed' orders. \n7) Confirm an order." + 
        " \n8) Reject an order. \n9) To complete an order. \n10 To remove an unavailable airbnb. \n11) Edit your Host profile." + 
        "\n12) Give Profile Details. \n13) Logout. \n\n") 

        if menu_options == '1':
            query = "CALL display_airbnb(%s)"
            result_args = cursor.execute(query, (email))
            all_airbnbs = cursor.fetchall()
            attr, info = readData(all_airbnbs)
            showPandasDataFrame(attr, info)

        elif menu_options == '2':
            host_name_query = "CALL get_host_name(%s)"
            host_name_arg = cursor.execute(host_name_query, (email))
            host_name = cursor.fetchall()[0]['host_name']

            a_title = input("\n\nPlease enter a title for the new airbnb: \n")

            a_country = input("\n\nPlease enter a country for your new airbnb: \n")

            get_city_query = "CALL display_cities(%s)"
            city_args = cursor.execute(get_city_query, (a_country))
            all_cities = cursor.fetchall()
            attr, info = readData(all_cities)
            showPandasDataFrame(attr, info)

            a_city = input("\n\nPlease enter the ID of the city from the above list where you want to create your new Airbnb: \n")

            a_address = input("\n\nPlease enter an address for your new Airbnb: \n")

            a_rooms = input("\n\nPlease enter the number of rooms for your new Airbnb: \n")

            a_beds = input("\n\nPlease enter the number of beds for your new Airbnb: \n")

            a_parking = input("\n\nPlease enter the number of parking spots for your new Airbnb: \n")

            a_description = input("\n\nPlease enter a description for your new Airbnb: \n")

            a_price = input("\n\nPlease enter the final price for your new Airbnb: \n")

            a_cleaning_fee = input("\n\nPlease enter the cleaning fee for your new Airbnb: \n")

            query = "SELECT create_airbnb(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s) AS new_airbnb"
            result_args = cursor.execute(query, (email, a_title, a_city, a_address, a_rooms, a_beds, a_parking, 
            a_description, a_price, a_cleaning_fee ))
            connection.commit()
            print("\n\nYou've successfully created the new Airbnb named ", a_title)
            connection.commit()
        elif menu_options == '3':
            query = "CALL display_airbnb(%s)"
            result_args = cursor.execute(query, (email))
            all_airbnbs = cursor.fetchall()
            attr, info = readData(all_airbnbs)
            showPandasDataFrame(attr, info)

            a_house_id = input("\n\nPlease enter the house ID of the Airbnb you want to mark unavailable: \n")

            a_start_date = input("\n\nPlease enter the start date from which onwards the Airbnb is unavailable: \n")

            a_end_date = input("\n\nPlease enter the end date until when the Airbnb is unavailable: \n")

            unavailable_query = "CALL add_unavailable(%s, %s, %s)"
            unavailable_args = cursor.execute(unavailable_query, (a_house_id, a_start_date, a_end_date))
            connection.commit()
            print("\n\nYou have successfully marked the Airbnb ", a_house_id, " unavailable from ", a_start_date, " to ", a_end_date)
        
        elif menu_options == '4':
            query = "CALL display_airbnb(%s)"
            result_args = cursor.execute(query, (email))
            all_airbnbs = cursor.fetchall()
            attr, info = readData(all_airbnbs)
            showPandasDataFrame(attr, info)

            a_house_id = input("\n\nPlease enter the house ID of the Airbnb of which you want to change the price: \n")

            a_edited_price = input("\n\nPlease enter the updated price for this Airbnb: \n")

            a_edited_cleaning = input("\n\nPlease enter the updated cleaning fee for this Airbnb: \n")

            unavailable_query = "CALL edite_price(%s, %s, %s)"
            unavailable_args = cursor.execute(unavailable_query, (a_house_id, a_edited_price, a_edited_cleaning))
            connection.commit()
            print("\n\nYou have successfully changed the price for the Airbnb ", a_house_id, " to ", a_edited_price, 
            " and the cleaning fee to ", a_edited_cleaning)
        
        elif menu_options == '5':
            query = "CALL get_host_orders(%s)"
            result_args = cursor.execute(query, (email))
            all_host_orders = cursor.fetchall()
            attr, info = readData(all_host_orders)
            showPandasDataFrame(attr, info)
        
        elif menu_options == '6':
            query = "CALL show_wait_to_confirmed_orders(%s)"
            result_args = cursor.execute(query, (email))
            all_wait_to_confirmed_orders = cursor.fetchall()
            attr, info = readData(all_wait_to_confirmed_orders)
            showPandasDataFrame(attr, info)
        
        elif menu_options == '7':
            query = "CALL show_wait_to_confirmed_orders(%s)"
            result_args = cursor.execute(query, (email))
            all_wait_to_confirmed_orders = cursor.fetchall()
            attr, info = readData(all_wait_to_confirmed_orders)
            showPandasDataFrame(attr, info)

            order_id = input("\n\nPlease enter the order ID that you want to confirm: \n")

            order_confirm_query = "CALL confirm_order(%s)"
            order_confirm_arg = cursor.execute(order_confirm_query, (order_id, ))
            connection.commit()
            print("\n\nYou have successfully confirmed order ", order_id)

        elif menu_options == '8':
            query = "CALL show_wait_to_confirmed_orders(%s)"
            result_args = cursor.execute(query, (email))
            all_wait_to_confirmed_orders = cursor.fetchall()
            attr, info = readData(all_wait_to_confirmed_orders)
            showPandasDataFrame(attr, info)

            order_id = input("\n\nPlease enter the order ID that you want to confirm: \n")

            order_reject_query = "CALL reject_order(%s)"
            order_reject_arg = cursor.execute(order_reject_query, (order_id))
            connection.commit()
            print("\n\nYou have successfully rejected order ", order_id)

        elif menu_options == '9':
            processing_orders_query = "CALL show_processing_orders(%s)"
            processing_orders_args = cursor.execute(processing_orders_query, (email))
            all_processing_orders = cursor.fetchall()
            attr, info = readData(all_processing_orders)
            showPandasDataFrame(attr, info)

            order_input = input("\n\nPlease enter the order ID that is to be updated to completed: \n")
            completed_query = "CALL update_order_status_completed(%s)"
            completed_args = cursor.execute(completed_query, (order_input))
            connection.commit()
            print("\n\nYou have successfully completed the order ", order_id)

        elif menu_options == '10':
            show_unavailable_airbnb_query = "CALL show_unavailable_airbnbs_for_host(%s)"
            unavailable_airbnb_args = cursor.execute(show_unavailable_airbnb_query, (email))
            list_unavailable_airbnbs = cursor.fetchall()
            attr, info = readData(list_unavailable_airbnbs)
            showPandasDataFrame(attr, info)

            input_airbnb_house_id = input("\n\nPlease enter the House ID of the airbnb that you want to remove from unavailable: \n")
            input_airbnb_start_date = input("\n\nPlease enter the Start Date for this airbnb: \n")

            remove_unavailable_query = "CALl remove_unavailable(%s, %s)"
            remove_unavailable_args = cursor.execute(remove_unavailable_query, (input_airbnb_house_id, input_airbnb_start_date))
            connection.commit()
            print("\n\n You have successfully removed the airbnb ", input_airbnb_house_id, " from unavailable and now it's" + 
            " available from the date ", input_airbnb_start_date)

        elif menu_options == '11':
            print("\nYou've decided to edit your profile. \n. Here you can edit your gender and language.\n")
            edit_gender = input("\nPlease enter the gender you want to change to. \nYou can choose from Male, Female, Others or Not to tell.\n")

            language_query = "CALL get_languages()"
            language_arg = cursor.execute(language_query)
            edit_language = input("\nPlease enter a language code you want to change to from the list above. \n")

            query = "CALL edit_host(%s, %s, %s)"
            result_args = cursor.execute(query, (email, edit_gender, edit_language))
            connection.commit()

            print("\nYou have successfully changed your gender to ", edit_gender, " and your language of preferrence to ", edit_language)

        elif menu_options == '12':
            query = "CALL get_host_details(%s)"
            result_args = cursor.execute(query, (email))
            profile_details = cursor.fetchall()
            attr, info = readData(profile_details)
            showPandasDataFrame(attr, info)

        elif menu_options == '13':
            print("\n\nYou've been logged out. Thank you!\n")
            loop = False
        else:
            print("\n\nPlease enter a valid response to the menu options.")



first_quest = input("Are you a new user? Please enter yes or no. \n")

if first_quest.lower() == "yes":
    second_quest = input("Would you like to sign up as a host or tenant? \n")

    if second_quest.lower() == "host":
        create_new_host()
    else:
        create_new_tenant()
else: 
    # Prompt the user to select their user type (host or tenant)
    user_type = input("Are you a host or a tenant? \n")

    # Prompt the user to enter their email
    email = input("Enter your email: \n")

    # Call the appropriate stored procedure based on user type
    if user_type.lower() == "host":
        host_login(email)
    elif user_type.lower() == "tenant":
        tenant_login(email)
    else:
        print("Invalid user type.")
    
# Close the database connection
cursor.close()
connection.close()