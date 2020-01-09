<%-- 
    Document   : operations
    Created on : Jan 7, 2020, 3:07:16 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style.css" type="text/css"/>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                var max_fields = 50; //maximum input boxes allowed
                var wrapper = $(".input_fields_wrap"); //Fields wrapper
                var add_button = $(".add_field_button"); //Add button ID

                var x = 1; //initlal text box count
                $(add_button).click(function (e) { //on add input button click
                    e.preventDefault();
                    if (x < max_fields) { //max input box allowed
                        x++; //text box increment
                        $(wrapper).append('<div><label>Field:</label><input type="text" name="mytext"/><label>Datatype:</label><input type="text" name="mytype"/><a href="#" class="remove_field">Remove</a></div>'); //add input box


                    }
                });

                $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
                    e.preventDefault();
                    $(this).parent('div').remove();
                    x--;
                });
            });
        </script>
    </head>
    <body>
        <form action="./databaseservlet" method="post">
            <table>
                <tr><td> <input class="submit" type="submit" value="Create" name="create" ></td>
                    <td><label>Table Name:</label>
                        <input id="tname" name="tname" ></td></tr>
                <tr>    <td><div class="input_fields_wrap">
                            <button class="add_field_button">Add More Fields</button>

                            <div><label>Field:</label><input type="text" name="mytext"><label>Datatype:</label>      <input type="text" name="mytype"></div>
                        </div></td>
                </tr>

            </table>
        </form>

    </body>
</html>