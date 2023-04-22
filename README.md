# cs5200FinalProject README

It is a relational Airbnb database. Use python to applicate interaction with the database.

## Installation

To use this system, you will need to install Python and MySQL on your local machine. You can download Python from https://www.python.org/downloads/ 
and MySQL from https://dev.mysql.com/downloads/mysql/. 
You will also need to install the MySQL Connector Python library by running the following command:

```
pip install pymysql
```
## Usage

Upzie file `ZhangWBrahmbhattP_project.zip`,  there are following files in the zip:

schemaDump.sql
report.pdf
script.py
precent.mp4

To get the database, open the `schemaDump.sql` file in the mySQL, and run the file to add airbnb database in you local.

To use the library database application, open your terminal and make sure you are in the project folder. And then run the `script.py ` file using the following command:
```
python script.py 
```
Since it is python3 code, if there is python2 in you device as well, please call:
```
python3 script.py
```
Then it will let you type the username and password to connect the database, type the user name and password if  you have in your mySQL:

```
Please enter your username
[root]
Please enter your password
[12345678]
```

Then if you see this, you successfully connect to the database, and then you can go through this program.

```
Connect database ... 
Database connection successful.
```
### Sign up
Then you can choose create a new user account or login
```
Are you a new user? Please enter yes or no. 
Yes[yes]
```
If you choose yes you will be ask to sign up as host or tenate, otherwise you will be ask to log gin as a host or tenate
```
Would you like to sign up as a host or tenant? 
host
```
If you choose sign up, you need to fill out the information about the account
```
Enter your name: 
[wenyu]
Enter your email: 
[wenyu@gmail.com]
Enter your phone: 
[12345678]
Enter your gender (Male, Female, Others, or Not to tell): 
[female]
Enter your preferred language: 
[EN]

Welcome new host [wenyu]
```
### Log in
Then you well auto login to the new host account.
Then you will If you what to log in existed host account, choose 'no' for new user question


## Host
```
Enter your email: 
jasmine.wong@yahoo.com

Login Successful.
```
This is what is the Home Page of host looks like, there 13 operations host account can do:

```
Home Screen Menu. 

 Please enter any of the below given options (any number) to perform an action as a host. 
1) Display all your owned Airbnbs. 
2) Post a new Airbnb. 
3) Mark an Airbnb unavailable. 
4) Edit price for an Airbnb. 
5) Show all orders. 
6) Show all 'wait-to-confirmed' orders. 
7) Confirm an order. 
8) Reject an order. 
9) To complete an order. 
10 To remove an unavailable airbnb. 
11) Edit your Host profile.
12) Give Profile Details. 
13) Logout.
```
### 1) 5) 6) 11) 
For these four READ operations, just type the number of the operation (such as `1`) then the all the information will be list out, and then back the host home page. 
If you need apply other operation just type the number in the terminal.
### 2) Post a new Airbnb
For post a new Airbnb you will enter the country name, and it will list out all the invalid cities in this country. Then you need to chose the city you want and copy its `city_id` (NOT city name).
```
[2]

Please enter a title for the new airbnb: 
sweet studio 


Please enter a country for your new airbnb: 
united states
       city_id            city
0   1840000455          Boston
......
39  1840034016        New York
40  1840034030        Brooklyn



Please enter the ID of the city from the above list where you want to create your new Airbnb: 
[1840034016]
```
Then answer more details about your house:

```
Please enter an address for your new Airbnb: 
[11 Ave]

Please enter the number of rooms for your new Airbnb: 
[1]

Please enter the number of beds for your new Airbnb: 
[1]

Please enter the number of parking spots for your new Airbnb: 
[0]

Please enter a description for your new Airbnb: 
[Great location! Pets friendly!]

Please enter the final price for your new Airbnb: 
[120]

Please enter the cleaning fee for your new Airbnb: 
[10]

You've successfully created the new Airbnb named  sweet studio
Home Screen Menu. 

```
### 7) Comfirm  8) Reject an order
It will show all "wait to confirmed" orders. If chose comfirm an order you need to type in the order ID. As long as you confirmed one order, the other orders which has same house which comflict time will be automatically rejected.

```
7
  order_num            tenant  house_id check_in_date check_out_date  \
0   ORD0011  dkim@outlook.com      1010    2024-01-01     2024-02-02   

  price_per_day cleaning_fee             states  rate  
0         80.00        15.00  wait to confirmed  None  



Please enter the order ID that you want to confirm: 
ORD0011


You have successfully confirmed order  ORD0011
Home Screen Menu. 
```
Similar steps to reject a order.


### 3) 10) Mark/Remove the unavailiable of the Airbnb
If a host doesn't want to show the house in same period of time. They can `3 ) Mark an Airbnb unavailable`.
If they want repost the Airbnb at this time, they can `10 To remove an unavailable airbnb`.
```
3
   house_id                    host  \
0      1010  jasmine.wong@yahoo.com   

                                         title     city_id       address  \
0  Beautifully Furnished Apartment in the City  1840034016  123 Main St.   

   num_of_rooms  num_of_beds  num_parking average_rating  rating_times  \
0             2            2            1           3.80             9   

                                         description current_price  \
0  This beautifully furnished apartment is locate...         80.00   

  current_cleaning_fee  
0                15.00  

Please enter the house ID of the Airbnb you want to mark unavailable: 
1010

Please enter the start date from which onwards the Airbnb is unavailable: 
2024-01-01

Please enter the end date until when the Airbnb is unavailable: 
2024-01-03


You have successfully marked the Airbnb  1010  unavailable from  2024-01-01  to  2024-01-03
Home Screen Menu. 
```
Similar steps for the remove.

### 11) Edit 12)Read your Host profile.
You can reand your profile to see all your informations, and edit your profile by changing your gender and language preferance. The gender and language are only details you can adjust about your proflie.
Before edit
```
12
      host_name                   email         phone  gender language_code
0  Jasmine Wong  jasmine.wong@yahoo.com  555-555-8901  Female            zh

Home Screen Menu. 

```
Edit
```
11

You've decided to edit your profile. 
. Here you can edit your gender and language.


Please enter the gender you want to change to. 
You can choose from Male, Female, Others or Not to tell.
Others

Please enter a language code you want to change to from the list above. 
EN

You have successfully changed your gender to  Others  and your language of preferrence to  EN
Home Screen Menu. 
```
After edite

```
12
      host_name                   email         phone  gender language_code
0  Jasmine Wong  jasmine.wong@yahoo.com  555-555-8901  Others            EN

Home Screen Menu.
```

### 13) Logout
If you want to log out the whole progrom.
```
13

You've been logged out. Thank you!

(base) $ 
```

## Tenant
Tanent has same login/signup as host. 
```
Connect database ... 
Database connection successful.
Are you a new user? Please enter yes or no. 
[no]
Are you a host or a tenant? 
[tenant]
Enter your email: 
[dkim@outlook.com]
Login Successful.

````

There are 6 operations tenants can do:
```

Home Screen Menu. 

Please enter any of the below given options (any number) to perform an action as a tenant: 

1) Search Airbnbs. 
2) See all orders. 
3) Rate a completed order. 
4) Edit your Tenant profile. 
5) Give Profile Details. 
6) Logout. 
```
### 1)Search Airbnbs and then make a order
Firstly search the Airbnbs with the country, city and dates. It will show you all available houses you can book
```
1       
You've selected to search an Airbnb. 
 Please enter a country where you would like to search an Airbnb at. 
United States

Now please enter a city in this country where you want to look up for an Airbnb. 
New York

Can you please enter a start date for your reservation? 
2023-5-1

Can you please enter an end date for your reservation? 
2023-5-2
   house_id                    host  \
0      1010  jasmine.wong@yahoo.com   
1      1011  mary.johnson@yahoo.com   

                                         title       address  num_of_rooms  \
0  Beautifully Furnished Apartment in the City  123 Main St.             2   
1                                 sweet studio        11 Ave             1   

   num_of_beds average_rating current_price  
0            2           3.80         80.00  
1            1           None        120.00  
```
Then choose the house you want to book by enter the house id. Then you can make a reservation.
```

Please enter a house id to book and create an order.
1010

You've successfully booked the Airbnb no.  1010 . Your order number is:  ORD0012
Home Screen Menu. 
```

### 2)See all orders AND 3) Rate a completed order.
For these two READ operations, just type the number of the operation (such as `1`) then the all the information will be list out, and then back the host home page. 
If you need apply other operation just type the number in the terminal. For example:
```
2
  order_num                                        title      city  \
0   ORD0011  Beautifully Furnished Apartment in the City  New York   
1    ORD010        Luxury Condo with Pool and Gym Access   Beijing   

         country check_in_date check_out_date price_per_day cleaning_fee  \
0  United States    2024-01-01     2024-02-02         80.00        15.00   
1          China    2023-08-01     2023-08-06         95.00        20.00   

       states  rate  
0  processing  None  
1   completed  None  

Home Screen Menu. 
......

```
For the unrated and completed orders you can `3) Rate a completed order`
```
Please enter the order number you want to rate based on your living experience at the Airbnb. 
ORD010
Please enter your rating on a scale of 0-5 for the selected Airbnb. 
4


You've successfully rated a  4  to an Airbnb having order number  ORD010 
```


### 4) Edit your Tenant profile. AND 5) Give Profile Details.
Same steps as host
### 5) Log out
If you want to log out the whole progrom.
```
5

You've been logged out. Thank you!

(base) $ 
```
