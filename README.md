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
