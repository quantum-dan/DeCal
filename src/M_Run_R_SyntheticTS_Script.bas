Sub Run_R_SyntheticTS_Script()

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

' Read in other function arguments
Dim n_events As Integer
Dim r_thres, drytime As Double
Dim n_sims As Integer
n_events = Sheets("2 - Time Series Data Entry").Range("C4").Value
r_thres = Sheets("2 - Time Series Data Entry").Range("G4").Value
drytime = Sheets("2 - Time Series Data Entry").Range("I4").Value
n_sims = Sheets("4 - Calibration Parameters").Range("G5").Value


' Call R function with 2 arguments: the path to the "R" sub-directory and the path to the data directory containing params.csv
Dim path, Rdir As String
' Get the directory Rscript.exe is in by taking the path up to the last \
Rdir = Left(Rscrpt_path, InStrRev(Rscrpt_path, "\"))
'path = Rscrpt_path & " " & wd_path & "\R\output_test.R" & " " & wd_path
path = Chr(34) + Rscrpt_path + Chr(34) + " " + Rdir + "generate_synthetic_TS.R" + " " + ReturnWorkingDir() + "\data"
'path = Rscrpt_path + " " + "generate_synthetic_TS.r"
'Sheets("4 - Calibration Parameters").Range("G100").Value = path
errorCode = shell.Run(path, style, waitTillComplete)



End Sub