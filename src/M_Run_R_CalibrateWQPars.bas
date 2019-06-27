Sub Run_R_CalibrateWQPars()

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

Dim n_sims As Integer
Dim flow_threshold As Double


n_sims = Sheets("4 - Calibration Parameters").Range("G5").Value
flow_threshold = Sheets("4 - Calibration Parameters").Range("D21").Value

Dim Rdir As String
' Get the directory Rscript.exe is in by taking the path up to the last \
Rdir = Left(Rscrpt_path, InStrRev(Rscrpt_path, "\"))
' Call R function with 1 argument: the path to the "R" sub-directory
Dim path As String
path = Chr(34) + Rscrpt_path + Chr(34) + " " + Rdir + "find_best_WQ_pars.r" + " " + ReturnWorkingDir() + "\data"
errorCode = shell.Run(path, style, waitTillComplete)



End Sub
