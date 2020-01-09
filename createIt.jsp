<%-- 
    Document   : createIt
    Created on : Jan 7, 2020, 3:08:53 PM
    Author     : admin
--%>


<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Classes.ConnectDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta charset="UTF-8">
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
                        $(wrapper).append('<div><label class="text">Field:</label><input  class="name"  name="mytext"/>\n\
            <label class="text">Datatype:</label> <select name="type"><option value="varchar">Varchar</option><option value="int">Integer</option><option value="date">Date</option><option value="boolean">Boolean</option></select><a href="#" class="remove_field">Remove</a></div>'); //add input box


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
            .dropbtn {
                background-color: #4CAF50;
                color: white;
                padding: 16px;
                font-size: 16px;
                border: none;
            }

            /* The container <div> - needed to position the dropdown content */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            /* Dropdown Content (Hidden by Default) */
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f1f1f1;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            /* Links inside the dropdown */
            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }


        </style>
    </head>
    <body>
        <%
            if (request.getParameter("count") != null) {
                for(String s:request.getParameterValues("type")){
                    System.err.println(s);
                }
                createTable(response, request.getParameter("tname"), request.getParameterValues("mytext"), request.getParameterValues("type"));
            } else {
            }
        %>
        <%!
            public boolean createTable(HttpServletResponse response, String name, String[] cols, String[] type) {
                boolean flag = false;
                Statement statement = null;
                Connection con = ConnectDB.getConnection();

//                try {
//                    out = response.getWriter();
//
//                } catch (IOException ex) {
//                    Logger.getLogger(DatabaseServlet.class.getName()).log(Level.SEVERE, null, ex);
//                }
                String tablequery = "create table " + name + "(";
                for (int i = 0; i < cols.length - 1; i++) {
                    if (type[i].equals("varchar")) {
                        tablequery += cols[i] + " " + type[i] + "(100),";
                    } else {
                        tablequery += cols[i] + " " + type[i] + ",";
                    }
                }
                if (type[cols.length-1].equals("varchar")) {
                        tablequery += cols[cols.length-1] + " " + type[cols.length-1] + "(100))";
                    } else {
                        tablequery += cols[cols.length-1] + " " + type[cols.length-1] + ")";
                    }

                System.out.println(tablequery);
                try {
                    statement = con.createStatement();
                } catch (SQLException ex) {

                }
                try {
                    flag = statement.execute(tablequery);
                } catch (SQLException ex) {

                }
                return flag;
            }
        %>
               <div id="form">
            <div id="top"><h1 id="heading">Welcome To Database Creator</h1></div>
            <form action="" method="post">
                <center> <input class="add" type="submit" onclick="location.href = 'home.html';" value="Home" ></center>
                <center><label class="text">Table Name:</label><input class="name" name="tname" required></center>

                <center>  <table>
                        <tr>    <td><div class="input_fields_wrap">

                                    <input type="hidden" value="1" name="count"/>
                                    <label class="text">Field:</label><input class="name" type="text" name="mytext" required><label class="text">Datatype:</label>   
                                    <select name="type" >
                                        <option name="option" value="varchar">Varchar</option>
                                        <option name="option" value="int">Integer</option>
                                        <option name="option" value="date">Date</option>
                                        <option name="option" value="boolean">Boolean</option>

                                    </select>
                                </div>
                            </td>
                        </tr>

                    </table></center>
                <center>        <button class="add">Add More Fields</button></center>
                <center>           <input class="submit" type="submit" value="Create" name="create" ></center>
            </form>
        </div>


    </body>
</html>
