import pymysql

def call_airbnbdb():
    conn = pymysql.connect(
        host = "localhost",
        user = 'root',
        password = '12345678',
        database = 'airbnb'
    )
    return conn

def get_integer_input(prompt):
    while True:
        value = input(prompt)
        try:
            int_value = int(value)
            return int_value
        except ValueError:
            print("Please enter a number.")

def get_float_input(prompt):
    while True:
        value = input(prompt)
        try:
            float_value = float(value)
            return float_value
        except ValueError:
            print("Please enter a valid number.")

def host_line(conn):


    cursor = conn.cursor()
    # get into host account

    while True:
        action1 = input("log in [L] or sign up [S]: ")
        def host_log_in(email):
            cursor.execute("SELECT * FROM hosts WHERE email = %s ;", (email,))
            h = cursor.fetchone()
            print("------- Account Information------")
            print("Name:      ", h[0])
            print("Email:     ", h[1])
            print("Phone:     ", h[2])
            print("Gender:    ", h[3])
            if h[4] != None:
                cursor.execute("SELECT name FROM languages WHERE code = %s ;" (h[4],))
                print("Language:  ", cursor.fetchone()[0])
            else:
                print("Language:  ", h[4])


        if action1 == 'L':
            while True:
                email = input("Enter Host Email: ")
                # email = "john.smith@gmail.com"
                try:
                    host_log_in(email)
                except:
                    print("Wrong email")
                else:
                    break;
                    print("=====Succefully login!!!!")
            break;


        elif action1 == 'S':
            # create a new host account
            print("Fill your information to sing up as a host")
            new_hname = input("Name: ")
            new_hemail = input("Email: ")
            while new_hemail == '':
                print("email address cannot be empty")
                new_hemail = input("Email: ")

            new_hphone = input("Phone: ")
            try:
                cursor.callproc('create_host', [new_hname, new_hemail, new_hphone])
            except:
                print("The account is already exist.")
                login = input("Do you want to login with this email? [Yes/No] ")
                if login == 'Yes':
                    host_log_in(new_hemail)
                    email = new_hemail
            else:
                check1 = input("Are you sure to create this account? [y/n]")
                if (check1 == "y"):
                    conn.commit()
                    print("Hello %s ! You are an Airbnb host now!" % new_hname)
                    host_log_in(new_hemail)
                    email = new_hemail
                    break;
        else:
            print("type L or S")

    print("===="*10)



    while True:
        print("You can:\n [E] edite your account \n [M] manage your airbnbs \n [O] log out ")
        action2 = input()

        if action2 == 'O':
            print("logining out......")
            break;

        elif action2 == 'E':
            # edite host account
            while True:
                new_gender = input("Select your gender: \n Male, Female, Others, Not to tell \n")
                if (new_gender not in ["Male", "Female", "Others", "Not to tell"]):
                    print("Unrecognized or gender")
                    continue;
                new_lang = input("The main language you speak: ")
                while True:
                    try:
                        cursor.callproc("edit_host", [email, new_gender, new_lang])
                    except:
                        print("Unrecognized language")
                        new_lang = input("The main language you speak: ")
                    else:
                        # display the updated account
                        host_log_in(email)
                        break;
                break;
            conn.commit()

        elif action2 == 'M':
            while True:
                # action with airbnbs
                print("******** Your airbnbs *******")
                cursor.callproc("display_airbnb", [email])
                result = cursor.fetchall()
                air_list = []
                for row in result:
                    # list out all the houses
                    print('---------- Hoese %d ---------' % row[0])
                    air_list.append(row[0])
                    print("Title:   ", row[2])
                    print("Description:  \n", row[10])
                    cursor.execute("SELECT city FROM world_cities WHERE city_id = %s ;", (row[3],))
                    print("City:    ", cursor.fetchone()[0])
                    print("Address: ", row[4])
                    print("%d rooms, %d beds, %d parking    " %(row[5], row[6], row[7]))
                    print("%s average rate in %d rating times" %(row[8], row[9]))
                    print("Price per day", row[11])
                    print("Cleanning fee", row[12])
                    print("----"*10)
                if len(air_list) ==0:
                    print("You didn't posted any airbnb, go create one!")

                def get_house():
                    while True:
                        air = get_integer_input("which airbnb you want to edit: ")
                        if air in air_list:
                            break;
                        else:
                            print("It is not your house")
                    return air

                action3 = input(" [P] edit the airbnb price \n [C] create a new airbnb \n [I] inactive the airbnb \n [A] active the airbnb \n [B] back \n")
                if action3 == 'P':
                    ''' change price '''

                    air = get_house()

                    new_price = get_float_input("new price per day: ")
                    new_clean = get_float_input("new cleanning pice: ")
                    cursor.callproc("edite_price", [air, new_price, new_clean])

                    conn.commit()

                elif action3 == 'I':
                    """add unavailable"""
                    air = get_house()

                    start = input("Start date is (yyyy-mm-dd): ")
                    end = input("end date is (yyyy-mm-dd): ")

                    try:
                        cursor.callproc("add_unavailable", [air, start, end])
                    except:
                        print("something wrong")
                    else:
                        print("now your airbnb is not available at these date: ")
                        cursor.callproc("dislay_removable_date", [email, air])
                        for d in cursor.fetchall():
                            print(d)
                    conn.commit()

                elif action3 =='A':
                    ''' DELETE unvailable'''
                    air = get_house()
                    while True:
                        cursor.callproc("dislay_removable_date", [email, air])
                        un = 0

                        for u in cursor.fetchall():

                            un += 1
                            print(u)

                        if un == 0:
                            print("This airbnb is available all the time")
                            break;
                        else:
                            start = input("remove the unvailable priod which start from (yyyy-mm-dd): ")

                            try:
                                cursor.callproc("remove_unavailable", [air, start])
                            except:
                                print("You can not access to remove this unvailable")
                            else:
                                print("Now your airbnb is only not available at these date: ")
                                cursor.execute("SELECT * FROM airbnb_unavailable WHERE house_id = %s ;", (air,))
                                for d in cursor.fetchall():
                                    print(d)
                                break;
                    conn.commit()


                elif action3 =='C':
                    title = input("Title: ")

                    cursor.execute("SELECT country FROM world_cities GROUP BY country ;")
                    country_list =[]
                    for con in cursor.fetchall():
                        country_list.append(con[0])
                        print(con[0])


                    while True:
                        country = input("select country:\n")
                        if country in country_list:
                            break;
                        else:
                            print("no such country")

                    cursor.callproc("display_cities", [country])
                    cities = cursor.fetchall()
                    for cc in cities:
                        print(cc[0], "  ", cc[1])

                    city_id =0
                    while True:
                        city = input("Select city: ")
                        for c in cities:
                            if city == c[1]:
                                city_id = int(c[0])

                        if city_id ==0:
                            print("No such city")
                        else:
                            break;

                    # city_id = get_integer_input("select the city with its id:\n")
                    address = input("Address: ")

                    n_r = get_integer_input("Number of rooms: ")
                    n_b = get_integer_input("Number of beds: ")
                    n_p = get_integer_input("Number of parking spaces: ")

                    discrip = input("write some discription: \n")
                    price = get_float_input("Price per day: ")
                    clean = get_float_input("Clean fee: ")
                    info= (email, country, city_id, address, n_r, n_b, n_p, discrip, price, clean)
                    try:
                        cursor.execute("SELECT create_airbnb(%s, %s, %s, %s, %s, %s,%s, %s,%s, %s)", info)
                    except:
                        print("not able to create")
                    else:
                        air_list.append(cursor.fetchall()[0])

                    conn.commit()

                elif action3 == 'B':
                    break;

    cursor.close()
    conn.close()


if __name__ == '__main__':

    try:
        conn = call_airbnbdb()
    except:
        print("Cannot connect to the database")
    else:
        print("The Airbnb database is connected")
        host_line(conn)
