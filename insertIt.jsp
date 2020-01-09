<%-- 
    Document   : insertIt
    Created on : 8 Jan, 2020, 10:50:52 AM
    Author     : DNSPY
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="Classes.ConnectDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InsertIt Page</title>
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
                width:70%;
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
                width:70%;
            }
            #form{
                background-color:rgba(0,0,0,0.3);
                margin: auto auto;
                height:100%;
                width: 50%;
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
                StringBuilder sb = inTable(response, request.getParameter("tname"), request.getParameterValues("cols"), request.getParameterValues("value"));
                out.print(sb.toString());
            } else {
            }
        %>
        <%!
            public StringBuilder inTable(HttpServletResponse response, String name, String[] cols, String[] value) {
                boolean flag = false;
                //String tablequery = "insert into " + name + " values(";
                String tablequery = "insert into stud values(";
                ResultSet rs = null;
                PreparedStatement statement = null;
                Connection con = ConnectDB.getConnection();
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < cols.length - 1; i++) {
                    tablequery += "?" + ",";
                }
                tablequery += "?)";
                try {
                    statement = con.prepareStatement(tablequery);
                    for (int i = 0, j = 1; i < cols.length; i++, j++) {
                        statement.setObject(j, value[i]);
                    }
                    System.out.println(statement.toString());
                } catch (SQLException ex) {
                }
                try {
                    statement.executeUpdate();
                    sb.append("Insertion Successful");
                } catch (SQLException ex) {
                }
                return sb;
            }
        %>

        <div id="form">
            <div id="top"><h1 id="heading">Welcome To Database Creator</h1></div>
            <center> <input class="add" type="submit" onclick="location.href = 'index.jsp';" value="Home" ></center>

            <center>  <form action="" method="post">

                    <table>
                        <%
                            Connection con = ConnectDB.getConnection();
                            Statement stmt = con.createStatement();
                            //ResultSet rs = stmt.executeQuery("SELECT * FROM " + request.getParameter("tname"));
                            ResultSet rs = stmt.executeQuery("SELECT * FROM "+request.getParameter("tname"));
                            System.err.println("SELECT * FROM   "+request.getParameter("tname"));
                            if (rs.next()) {
                                ResultSetMetaData rsmd = rs.getMetaData();
                                int size = rsmd.getColumnCount();
                        %>
                        <input  type="hidden" name="count" value="1"/>
                        <%
                            for (int i = 1; i <= size; i++) {
                                System.out.println(rsmd.getColumnName(i));
                        %>
                        <label class="text"><%=rsmd.getColumnName(i)%></label><input type="text" class="name" name="value"/><br/>
                        <%
                            }
                        %>
                        <!--                            </select>
                                                    <button class="add_field_button">Add More Fields</button>
                        
                                                    <div><label>Field:</label><input type="text" name="myret">
                                                    </div></td>-->
                        <%
                            }
                        %>
                        </tr>
                         <input class="submit" type="submit" value="Insert" name="retrive" >
                    </table>
                    </body>
                    </html>
