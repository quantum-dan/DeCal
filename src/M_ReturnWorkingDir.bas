Function ReturnWorkingDir() As String
' Ensure consistency in file locations: everything goes under the project name
Dim wd As String
Dim name As String
wd = Sheets("1 - Locate Executables").range("C5").Value
name = Sheets("1 - Locate Executables").range("C14").Value
ReturnWorkingDir = wd & "\" & name
End Function