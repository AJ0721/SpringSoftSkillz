# SpringSoftSkillz
Spring MVC

Project Name: SoftSkillz

1.Description:
This is part of a group project that is still under development. My contributions to the project focuses on the forum functionality.

2.Installation:
Eclipse 2023/6
Tomcat 10.1

3.Database Setup:
Use the 'springboot_team4.sql' file to set up the database required for the project. This file contains all the necessary SQL scripts.

-create a database in sql server named 'softskillzdb'
-create all the tables and insert corresponding data
-add resourse in server -> context.xml as below:
*NOTE: if you are using mysql or other database service, make sure the name and the database in the url matches. 

<Resource name="connectSqlServerJdbc/SystemService"
		type="javax.sql.DataSource" auth="Container"
		username="your username"
		password="your password"
		driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"
		url="jdbc:sqlserver://localhost:1433;databaseName=softskillzdb;encrypt=true;trustServerCertificate=true" />


4.Running the Application:
Clone the repository to your local machine.
The application will be available at http://localhost:8080.


5.Access to the website:
softskillz frontstage homepage: http://localhost:8080/softskillz/fhomepage
softskillz backstage homepage: http://localhost:8080/softskillz/newhomepage
forum frontstage homepage: http://localhost:8080/forum/home
forum backstage homepage: http://localhost:8080/forum/adminhome



