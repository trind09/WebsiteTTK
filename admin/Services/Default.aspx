﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="admin_Services_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
        function CallMe() {
            $.ajax({
                type: 'POST',
                url: 'http://localhost:64538/admin/Services/WebService.asmx/HelloWorld',
                async: false,
                contentType: "application/json",
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    $("#div1").html(JSON.stringify(data));
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }
    </script>
</head>
<body>
    <input id="button" type="button" value="CallMe" onclick="CallMe();" />
    <div id="div1"></div>
</body>
</html>
