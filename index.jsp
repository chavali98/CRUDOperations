/*This java project dynamically handles DDL and DML operators.It allows you to dynamically create a table of arbitary size(variable number of colmns)
and datatype.Based on the datatype an appropriate table is created which is manipulated via CRUD operators*/
<%-- 
    Document   : index
    Created on : Jan 7, 2020, 3:06:03 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <head>

        <title>OurDB</title>
        <meta charset="UTF-8">
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
            .sub{

                background-color: #4CAF50; /* Green */
                border: none;
                color: white;
                padding: 15px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                margin-left:auto;
                margin-right:auto;
                width:100%;
            }
            #form{
                background-color:rgba(0,0,0,0.3);
                margin: auto auto;
                height:400px;
                width: 600px;
                padding: 30px 30px;

            }
            #heading{
                text-align: center;
                size:50px;
                color:white;
                font-family: Arial Rounded MT Bold;
                padding: 30px;

            }
            .sub:hover {
                background: #434343;
                letter-spacing: 5px;
                -webkit-box-shadow: 0px 5px 40px -10px rgba(20,36,50,0.57);
                -moz-box-shadow: 0px 5px 40px -10px rgba(0,0,0,0.57);
                box-shadow: 5px 40px -10px rgba(0,0,0,0.57);
                transition: all 0.4s ease 0s;
            }
            .btn{
                margin-top: 50px;
            }

        </style>
    </head>
    <body>
         <div id="form">
        <div id="top"><h1 id="heading">Welcome To Database Creator</h1></div>
        <div class="btn">
        <input class="sub" type="submit" value="Create" name="create" onclick="location.href = 'createIt.jsp';" >
         <input class="sub" type="submit" value="Operations" name="Operations" onclick="location.href = 'tablename.html';">
    <!--     <input class="sub" type="submit" value="Retrive" name="retrive" onclick="location.href = 'retrive.html';" >
        <input class="sub" type="submit" value="Delete" name="delete" onclick="location.href = 'delete.html';"> -->
        </div>
        </div>
    </body>
</html>
