<%-- 
    Document   : retrieveIt
    Created on : Jan 7, 2020, 3:17:13 PM
    Author     : admin
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Classes.ConnectDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RetrieveIt</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                var max_fields = 50; //maximum input boxes allowed
                var wrapper = $(".input_fields_wrap"); //Fields wrapper
                var add_button = $(".add"); //Add button ID

                var x = 1; //initlal text box count
                $(add_button).click(function (e) { //on add input button click
                    e.preventDefault();
                    if (x < max_fields) { //max input box allowed
                        x++; //text box increment
                        $(wrapper).append('<div><label class="text">Field:</label><input class="name" type="text" name="myret[]"/><a href="#" class="remove_field">Remove</a></div>'); //add input box


                    }
                });

                $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
                    e.preventDefault();
                    $(this).parent('div').remove();
                    x--;
                });
            });
        </script>
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
                StringBuilder sb = retTable(response, request.getParameter("tname"), request.getParameterValues("cols"), request.getParameter("clause"));
                out.print(sb.toString());
            } else {
            }
        %>
        <%!
            public StringBuilder retTable(HttpServletResponse response, String name, String[] cols, String where) {
                boolean flag = false;
                String tablequery = "select ";
                ResultSet rs = null;
                Statement statement = null;
                Connection con = ConnectDB.getConnection();
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < cols.length - 1; i++) {
                    tablequery += cols[i] + ",";
                }
                if (!where.equals("")) {
                    tablequery += cols[cols.length - 1] + " from " + name + " where " + where;
                } else {
                    tablequery += cols[cols.length - 1] + " from " + name;
                }
                try {
                    statement = con.createStatement();
                } catch (SQLException ex) {
                }
                try {
                    rs = statement.executeQuery(tablequery);
                    sb.append("<table>");
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int size = rsmd.getColumnCount();
                    for (int i = 1; i <= size; i++) {
                        sb.append("<th>" + rsmd.getColumnName(i) + "</th>");
                    }
                    while (rs.next()) {
                        sb.append("<tr>");
                        for (int j = 1; j <= cols.length; j++) {
                            sb.append("<td>" + rs.getString(j) + "</td>");
                        }
                        sb.append("</tr>");
                    }
                    sb.append("</table>");
                } catch (SQLException ex) {
                }
                return sb;
            }
        %>
        <div id="form">
            <div id="top"><h1 id="heading">Welcome To Database Creator</h1></div>
            <center> <input class="add" type="submit" onclick="location.href = 'home.html';" value="Home" ></center>


            <center><form action="" method="post">
                    <table>
                        <%
                            Connection con = ConnectDB.getConnection();
                            Statement stmt = con.createStatement();
                            //ResultSet rs = stmt.executeQuery("SELECT * FROM " + request.getParameter("tname"));
                            ResultSet rs = stmt.executeQuery("SELECT * FROM  "+request.getParameter("tname"));
                            if (rs.next()) {
                                ResultSetMetaData rsmd = rs.getMetaData();
                                int size = rsmd.getColumnCount();
                        %>
                        <input  type="hidden" name="count" value="1"/>
                        <%
                            for (int i = 1; i <= size; i++) {
                        %>
                        <tr ><input type="checkbox" name="cols" value=<%=rsmd.getColumnName(i)%> /><label class="text"><%=rsmd.getColumnName(i)%></label></tr>
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
                        <center><tr><td><label class="text">Select where clause</label> <input class="name" name="clause" ></td></tr></center>
                        <center><tr><td><input class="submit" type="submit" value="Retrieve" name="retrieve" ></td></tr></center>

                    </table>
                </form></center>
        </div>
    </body>
</html>
