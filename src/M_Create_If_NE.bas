Sub CreateIfNE(path As String)
Set fso = CreateObject("Scripting.FileSystemObject")
If Not fso.FileExists(path) Then
    fso.CreateTextFile (path)
End If
End Sub