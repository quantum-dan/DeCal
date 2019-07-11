Function Get_datetime_cdf()
Dim Lresult As Date
Dim t As Date
Dim wd_path, r_path As String

Dim rngFound As Range
With Worksheets("Output - Parameter GOF")
    Set rngFound = .Range("A1:DD1").Find(What:="K_rmse", LookIn:=xlValues, LookAt:=xlWhole).Offset(1, 0)
End With
wd_path = ReturnWorkingDir()
Sustain_file = wd_path & "\SUSTAIN\InputTSFiles\"
R_file = wd_path & "\data\"

size_s = Sustain_file & "LU_Input_TS_5min.prn"
size_r = R_file & "SimulatedCoutEMCs.csv"
Rresult = FileDateTime(R_file & "SimulatedCoutEMCs.csv")
Lresult = FileDateTime(Sustain_file & "LU_Input_TS_5min.prn")
k_value = ThisWorkbook.Sheets("Output - Modeled Cout EMCs").Range("B3")
ks = ThisWorkbook.Sheets("Output - Modeled Cout EMCs").Range("D3")





t = Now()
Worksheets("7 - Post Processing").Range("O10").Value = "Current Time"
Worksheets("7 - Post Processing").Range("P10").Value = t
Worksheets("7 - Post Processing").Range("O11").Value = "File"
Worksheets("7 - Post Processing").Range("P11").Value = "Date-Time Updated"
Worksheets("7 - Post Processing").Range("Q11").Value = "File Size"
Worksheets("7 - Post Processing").Range("O12").Value = "Simulated R Out"
Worksheets("7 - Post Processing").Range("P12").Value = Rresult
Worksheets("7 - Post Processing").Range("Q12").Value = FileLen(size_r)
Worksheets("7 - Post Processing").Range("O13").Value = "Selected K Value"
Worksheets("7 - Post Processing").Range("P13").Value = k_value
Worksheets("7 - Post Processing").Range("O14").Value = "Cstar"


If Worksheets("Output - Modeled Cout EMCs").Range("C1").Value = "Cstar" Then
    Worksheets("7 - Post Processing").Range("P14").Value = ThisWorkbook.Sheets("Output - Modeled Cout EMCs").Range("C3")
Else
    Worksheets("7 - Post Processing").Range("P14").Value = "N/A"
End If
    

End Function



