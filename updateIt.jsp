<%-- 
    Document   : updateIt
    Created on : Jan 7, 2020, 3:17:41 PM
    Author     : admin
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Classes.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                upTable(response, request.getParameter("tname"), request.getParameterValues("cols"), request.getParameterValues("value"), request.getParameter("clause"));
            } else {
            }
        %>
        <%!
            public void upTable(HttpServletResponse response, String name, String[] cols, String[] value, String where) {
                boolean flag = false;
                String tablequery = "UPDATE " + name + " set ";
                PreparedStatement statement = null;
                ResultSet rs = null;
                Connection con = ConnectDB.getConnection();
//                for (int i = 0; i < cols.length - 1; i++) {
//                    tablequery += cols[i] + "="+value[i]+" ,";
//                }
//                if (!where.equals("")) {
//                    tablequery += cols[cols.length - 1] + "="+value[value.length-1]+  " where " + where;
//                } else {
//                    tablequery += cols[cols.length - 1]+ "="+value[cols.length-1] ;
//                }
                for (int i = 0; i < cols.length - 1; i++) {
                    tablequery += cols[i] + "=? ,";
                }
                if (!where.equals("")) {
                    tablequery += cols[cols.length - 1] + "=? where " + where;
                    try {
                        statement = con.prepareStatement(tablequery);
                        for (int j = 1, i = 0; j <= cols.length; j++, i++) {
                            statement.setObject(j, value[i]);
                        }
                        //statement.setObject(cols.length+1,where);
                        System.out.println(statement.toString());
                    } catch (SQLException ex) {
                    }

                } else {
                    tablequery += cols[cols.length - 1] + "=?";
                    try {
                        statement = con.prepareStatement(tablequery);
                        for (int j = 1, i = 0; j <= cols.length; j++, i++) {
                            statement.setObject(j, value[i]);
                        }
                        System.out.println(statement.toString());
                    } catch (SQLException ex) {
                    }
                }

                try {
                    statement.executeUpdate();
//                    if (flag) {
//                    }
                } catch (SQLException ex) {
                }
            }
        %>
        <div id="form">
            <div id="top"><h1 id="heading">Welcome To Database Creator</h1></div>
            <center> <input class="add" type="submit" onclick="location.href = 'home.html';" value="Home" ></center>

            <center>  <form action="" method="post">

                    <table>
                        <%
                            Connection con = ConnectDB.getConnection();

                            Statement stmt = con.createStatement();
                            //ResultSet rs = stmt.executeQuery("SELECT * FROM " + request.getParameter("tname"));

                            ResultSet rs = stmt.executeQuery("SELECT * FROM   "+request.getParameter("tname"));
                            if (rs.next()) {
                                ResultSetMetaData rsmd = rs.getMetaData();
                                int size = rsmd.getColumnCount();
                        %>
                        <input  type="hidden" name="count" value="1"/>
                        <%
                            for (int i = 1; i <= size; i++) {
                        %>
                        <input type="checkbox" name="cols" value=<%=rsmd.getColumnName(i)%> /><label class="text"><%=rsmd.getColumnName(i)%></label><input class="name"  type="text" name="value"/>
                        <%
                                }
                            }
                        %>
                        <center><tr><td><label class="text">Select where clause</label> <input class="name"id="tname" name="clause" ></td></tr></center>
                            <center><tr><td><input class="submit" type="submit" value="Update" name="retrieve" ></td></tr></center>

                    </table>
                </form></center>
        </div>
    </body>
</html>
