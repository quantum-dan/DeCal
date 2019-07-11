Sub Run_R_dataparse()

'runs an external R code through Shell

Dim shell As Object
Set shell = VBA.CreateObject("WScript.Shell")
Dim waitTillComplete As Boolean: waitTillComplete = True
Dim style As Integer: style = 1
Dim errorCode As Integer

' Read in working directory file path and path to R executable
Dim wd_path, Rscrpt_path As String
' This doesn't seem to be used?
wd_path = ReturnWorkingDir()
Rscrpt_path = Sheets("1 - Locate Executables").Range("C8").Value



' Call R function with 1 argument: the path to the "R" sub-directory
Dim path As String
path = Rscrpt_path + " " + "parse_data.r"
errorCode = shell.Run(path, style, waitTillComplete)



End Sub
