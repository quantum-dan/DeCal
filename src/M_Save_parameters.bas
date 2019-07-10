Function Save_parameters()

Dim wd_path, R_input_path As String
wd_path = Sheets("1 - Locate Executables").range("C5").Value
R_input_path = ReturnWorkingDir() & "\data\"



Dim params As Variant
Dim params_filename As String
Dim params_fsobj As Object

Set params_fsobj = CreateObject("Scripting.FileSystemObject")
    
params_filename = R_input_path & "params.csv"
Dim params_txtFile As Object
Set params_txtFile = params_fsobj.CreateTextFile(params_filename)



params_txtFile.WriteLine Sheets("1 - Locate Executables").range("C5")
params_txtFile.WriteLine Sheets("4 - Calibration Parameters").range("G5").Value
params_txtFile.WriteLine Sheets("4 - Calibration Parameters").range("D21").Value
params_txtFile.WriteLine Sheets("2 - Time Series Data Entry").range("C4").Value
params_txtFile.WriteLine Sheets("2 - Time Series Data Entry").range("G4").Value
params_txtFile.WriteLine Sheets("2 - Time Series Data Entry").range("I4").Value
params_txtFile.WriteLine Sheets("1 - Locate Executables").range("C14")

params_txtFile.Close
Set params_txtFile = Nothing
Set params_fsobj = Nothing


End Function






