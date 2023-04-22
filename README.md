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
### signup
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
If you choose sign up, you need to fill out the information about the accountp
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
### login
Then you well auto login to the new host account.

### host
Then you will If you what to log in existed host account, choose 'no' for new user question
```
Enter your email: 
wenyu@gmail.com
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
10) Edit your Host profile. 
11) Give Profile Details. 
12) Logout. 
```
### tenant
Samilar to login/signup as en tenant. There are 6 operations tenants can do:

```
Database connection successful.
Are you a new user? Please enter yes or no. 
[yes]
Would you like to sign up as a host or tenant? 
[tenant]
Enter your name: 
[parnit]
Enter your email: 
[parnit@gmail.com]
Enter your phone: 
[1234567]
Enter your gender (Male, Female, Others, or Not to tell): 
[male]
Enter your preferred language: 
[EN]
Welcome new tenant  [parnit] 

Login Successful.

Home Screen Menu. 

Please enter any of the below given options (any number) to perform an action as a tenant: 

Search Airbnbs. 
See all orders. 
Rate a completed order. 
Edit your Tenant profile. 
Give Profile Details. 
Logout. 
```

