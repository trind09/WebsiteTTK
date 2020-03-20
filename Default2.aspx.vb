
Partial Class Default2
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim url As String = TextBox1.Text
        If ValidateUrl(url) Then
            Response.Redirect(url)
        Else
            Response.Redirect(url)
            'Context.ApplicationInstance.CompleteRequest()
            'Label1.Text = ValidateUrl(url).ToString()
        End If
    End Sub

    Private Function ValidateUrl(url As String) As Boolean
        Dim uriResult As Uri
        Return Uri.TryCreate(url, UriKind.Absolute, uriResult) AndAlso (uriResult.Scheme = Uri.UriSchemeHttp OrElse uriResult.Scheme = Uri.UriSchemeHttps)
    End Function
End Class
