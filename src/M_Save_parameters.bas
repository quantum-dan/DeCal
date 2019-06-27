Function Save_parameters()

Dim wd_path, R_input_path As String
wd_path = Sheets("1 - Locate Executables").Range("C5").Value
R_input_path = ReturnWorkingDir() & "\data\"



Dim params As Variant
Dim params_filename As String
Dim params_fsobj As Object

Set params_fsobj = CreateObject("Scripting.FileSystemObject")
    
params_filename = R_input_path & "params.csv"
Dim params_txtFile As Object
Set params_txtFile = params_fsobj.CreateTextFile(params_filename)



params_txtFile.WriteLine Sheets("1 - Locate Executables").Range("C5")
params_txtFile.WriteLine Sheets("4 - Calibration Parameters").Range("G5").Value
params_txtFile.WriteLine Sheets("4 - Calibration Parameters").Range("D21").Value
params_txtFile.WriteLine Sheets("2 - Time Series Data Entry").Range("C4").Value
params_txtFile.WriteLine Sheets("2 - Time Series Data Entry").Range("G4").Value
params_txtFile.WriteLine Sheets("2 - Time Series Data Entry").Range("I4").Value
params_txtFile.WriteLine Sheets("1 - Locate Executables").Range("C14")

params_txtFile.Close
Set params_txtFile = Nothing
Set params_fsobj = Nothing

End Function






