Sub CSV_Import()

Dim ws_cout_mod, ws_cout_mod_mse, ws_cout_obs, ws_stats As Worksheet
Dim outdir, file_cout_mod, file_cout_obs, file_stats As String

Set ws_cout_mod = ActiveWorkbook.Sheets("Output - Modeled Cout EMCs")
Set ws_cout_mod_mse = ActiveWorkbook.Sheets("Output - Modeled Cout MSE")
Set ws_stats = ActiveWorkbook.Sheets("Output - Parameter GOF")
Set ws_cout_obs = ActiveWorkbook.Sheets("Output - Obs. Cout EMCs")

' Delete any data in the output files
ws_cout_mod.Cells.ClearContents
ws_cout_mod_mse.Cells.ClearContents
ws_cout_obs.Cells.ClearContents
ws_stats.Cells.ClearContents

outdir = ReturnWorkingDir() & "\data\"

file_cout_mod = outdir & "SimulatedCoutEMCs.csv"
file_cout_mod_mse = outdir & "SimulatedCoutEMCs_mse.csv"
file_cout_obs = outdir & "ObservedCoutEMCs.csv"
file_stats = outdir & "SimulationPerformanceStats.csv"


' Read In Modeled Couts

With ws_cout_mod.QueryTables.Add(Connection:="TEXT;" & file_cout_mod, Destination:=ws_cout_mod.range("A1"))
     .TextFileParseType = xlDelimited
     .TextFileCommaDelimiter = True
     .Refresh
End With



' Read In Observed Couts
With ws_cout_obs.QueryTables.Add(Connection:="TEXT;" & file_cout_obs, Destination:=ws_cout_obs.range("A1"))
     .TextFileParseType = xlDelimited
     .TextFileCommaDelimiter = True
     .Refresh
End With


' Read In Modeled Couts
With ws_stats.QueryTables.Add(Connection:="TEXT;" & file_stats, Destination:=ws_stats.range("A1"))
     .TextFileParseType = xlDelimited
     .TextFileCommaDelimiter = True
     .Refresh
End With


End Sub



Sub ExportChart()
    Dim objChrt As ChartObject
    Dim myChart As Chart
    Dim t As Date
    
    Set objChrt = Sheets("7 - Post Processing").ChartObjects(1)
    Set myChart = objChrt.Chart
    Dim score As String
    score = Sheets("7 - Post Processing").range("P15")

    If score = "N/A" Then
        params_filename = R_file & "Plot_K-" & Format(Now(), "DD-MMM-YYYY_hhmm_AMPM") & ".png"
    Else
         params_filename = R_file & "Plot_KC-" & Format(Now(), "DD-MMM-YYYY_hhmm_AMPM") & ".png"
    End If
    
    
    R_file = ReturnWorkingDir() & "\plots\"
    

    myChart.Export Filename:=R_file & "\" & params_filename, Filtername:="PNG"

    MsgBox "Plot saved"
End Sub
Function Save_final()

Dim wd_path, R_input_path As String
R_file = ReturnWorkingDir() & "\plots\"




Dim params As Variant
Dim params_filename As String
Dim params_fsobj As Object

Set params_fsobj = CreateObject("Scripting.FileSystemObject")

Dim score As String
score = Sheets("7 - Post Processing").range("P15")

If score = "N/A" Then
    params_filename = R_file & "K_values-" & Format(Now(), "DD-MMM-YYYY_hhmm_AMPM") & ".csv"
Else
     params_filename = R_file & "KC_values-" & Format(Now(), "DD-MMM-YYYY_hhmm_AMPM") & ".csv"
End If




Dim params_txtFile As Object
Set params_txtFile = params_fsobj.CreateTextFile(params_filename)


params_txtFile.WriteLine "Selected K Value"
params_txtFile.WriteLine Sheets("7 - Post Processing").range("P13")
params_txtFile.WriteLine "Selected C* Value"
params_txtFile.WriteLine Sheets("7 - Post Processing").range("P15").Value
params_txtFile.WriteLine "RMSE"
params_txtFile.WriteLine Sheets("7 - Post Processing").range("P14").Value
params_txtFile.WriteLine "KS Value"
params_txtFile.WriteLine Sheets("7 - Post Processing").range("P16").Value
params_txtFile.Close
Set params_txtFile = Nothing
Set params_fsobj = Nothing

End Function