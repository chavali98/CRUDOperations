<%-- 
    Document   : deleteIt
    Created on : Jan 7, 2020, 3:17:48 PM
    Author     : admin
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="Classes.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Records</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body{
                background-image: url('bg2.jpg');
                background-size: 100% 100%;

            }

            #top{

                background-color: rgba(10,10,77,0.6);
                height:100px;
            }
            .add{

                background: rgb(100,140,220);
                border: none;
                color: white;
                padding: 15px 32px;
                clear: left;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                margin-left:auto;
                margin-right:auto;
                width:60%;
            }
            .submit{

                background-color: #4CAF50; /* Green */
                border: none;
                color: white;
                padding: 15px 32px;
                clear: left;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                margin-left:auto;
                margin-right:auto;
                width:60%;
            }
            #form{
                background-color:rgba(0,0,0,0.3);
                margin: auto auto;
                height:100%;
                width: 60%;
                padding: 30px 30px;

            }
            #heading{
                text-align: center;
                size:50px;
                color:white;
                font-family: Arial Rounded MT Bold;
                padding: 30px;

            }

            .text{

                color:wheat;
                font-size: 20px;
            }
            .submit:hover {

                background: #434343;
                letter-spacing: 2px;
                -webkit-box-shadow: 0px 5px 40px -10px rgba(20,36,50,0.57);
                -moz-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
                box-shadow: 5px 40px -10px rgba(0,0,0,0.57);
                transition: all 0.4s ease 0s;
            }
            .add:hover {
                background: rgb(100,40,20);
                letter-spacing: 2px;
                -webkit-box-shadow: 0px 5px 40px -10px rgba(20,36,50,0.57);
                -moz-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
                box-shadow: 5px 40px -10px rgba(0,0,0,0.57);
                transition: all 0.4s ease 0s;
            }
            .name{
                border: none;
                border-bottom: 2px solid greenyellow;
                height:30px;
                width:250px;
                margin: 10px 10px;

            }

        </style>
    </head>
    <body>
        <%
            if (request.getParameter("count") != null) {
                delTable(response, request.getParameter("tname"), request.getParameter("clause"));
            } else {
            }
        %>
        <%!
            public void delTable(HttpServletResponse response, String name, String where) {
                boolean flag = false;
                String tablequery = "";
                Statement statement = null;
                Connection con = ConnectDB.getConnection();
                if (where != null) {
                    tablequery = "DELETE from " + name + " where " + where;
                } else {
                    tablequery = "DELETE from " + name;
                }
                try {
                    statement = con.createStatement();

                } catch (SQLException ex) {
                }
                try {
                    System.out.println("Before");
                    statement.executeUpdate(tablequery);
                    System.out.println("After");
                    if (flag) {

                    }
                } catch (SQLException ex) {
                }
            }
        %>
        <div id="form">
            <div id="top"><h1 id="heading">Welcome to database creator</h1></div>
            <center> <input class="add" type="submit" onclick="location.href = 'home.html';" value="Home" ></center>


            <center>  <form action="" method="post">
                    <table>
                        <tr><input class="submit" type="submit" value="Delete" >
                        </tr>

                        <tr><td><label  class="text" >Select where clause</label> <input class="name" name="clause" ></td></tr>
                    </table>
                </form></center>
        </div>
    </body>
</html>
