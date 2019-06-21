<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImageUpload.aspx.cs" Inherits="admin_ImageUpload" %>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>TTK Technology</title>
    <meta name="description" content="File Upload widget with multiple file selection, drag&amp;drop support, progress bars, validation and preview images, audio and video for jQuery. Supports cross-domain, chunked and resumable file uploads and client-side image resizing. Works with any server-side platform (PHP, Python, Ruby on Rails, Java, Node.js, Go etc.) that supports standard HTML form file uploads.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <blockquote>
            <table id="ExistImages"></table>
        </blockquote>
        <form id="form1" runat="server">
            <div class="form-group">
                <label for="exampleFormControlFile1">Upload image</label>
                <asp:FileUpload ID="fulImageUpload" runat="server" CssClass="form-control-file" /><br />
                <asp:LinkButton ID="lbnSubmit" runat="server" CssClass="btn btn-success" OnClick="lbnSubmit_Click">Upload</asp:LinkButton><br />
                <asp:Label ID="lblUploadResult" runat="server" Text=""></asp:Label>
            </div>
        </form>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Notes</h3>
            </div>
            <div class="panel-body">
                <ul>
                    <li>The maximum file size for uploads in this demo is <strong>20 MB</strong> (default file size is unlimited).</li>
                    <li>Only image files (<strong>JPG, GIF, PNG</strong>) are allowed in this demo (by default there is no file type restriction).</li>
                    <li>Uploaded files will be deleted automatically after <strong>5 minutes or less</strong> (demo files are stored in memory).</li>
                </ul>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            var hostURL = $("#<%=Host_URL.ClientID%>").text();
            var imagesData = $("#<%=Images_Data.ClientID%>").text();
            var arr = imagesData.split(';');
            $.each(arr, function (index, value) {
                if (value != "") {
                    var img = "<img style='width: 50px;' src='" + hostURL + "/" + value + "'>";
                    $('#ExistImages').append('<tr id="cell-' + index + '"><td style="padding: 5px;">' + img + '</td><td style="padding: 5px;"><a onclick="RemoveImage(\'' + value + '\', \'' + index + '\');" style="cursor: pointer;">Remove</a></td></tr>');
                }
            });

            var serviceURL = $("#<%=Service_URL.ClientID%>").text();
            $('#fileupload').attr('action', serviceURL + '/UploadImage');
        });

        function RemoveImage(image, index) {
            var id = getUrlVars()["id"];
            var serviceURL = $("#<%=Service_URL.ClientID%>").text();
            $.ajax({
                type: 'POST',
                url: serviceURL + '/RemoveImage?id=' + id + '&image=' + image + '&table=products',
                async: false,
                success: function (data) {
                    $('#cell-' + index).remove();
                },
                error: function (e) {
                    console.log(e);
                }
            });
        }

        function getUrlVars()
        {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for(var i = 0; i < hashes.length; i++)
            {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }
    </script>
    <div runat="server" id="Images_Data" style="display: none;"></div>
    <div runat="server" id="Service_URL" style="display: none;"></div>
    <div runat="server" id="Host_URL" style="display: none;"></div>
    <div runat="server" id="Service_URL_Name" style="display: none;"></div>
</body>
</html>
