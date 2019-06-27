Function Get_datetime()
Dim Lresult As Date
Dim t As Date
Dim wd_path, r_path As String

wd_path = ReturnWorkingDir()
Sustain_file = wd_path & "\SUSTAIN\InputTSFiles\"
R_file = wd_path & "\plots\"
size_s = Sustain_file & "LU_Input_TS_5min.prn"
size_r = R_file & "SyntheticTS_First3months.pdf"
Rresult = FileDateTime(R_file & "InterArrivalTimeDistributionFit.pdf")
Lresult = FileDateTime(Sustain_file & "LU_Input_TS_5min.prn")
t = Now()


Worksheets("5 - Check Input Files").Range("D6").Value = "File Name"
Worksheets("5 - Check Input Files").Range("E6").Value = "Date/ Time Modified"
Worksheets("5 - Check Input Files").Range("F6").Value = "File Size (Bites)"
Worksheets("5 - Check Input Files").Range("D7").Value = "Sustain Files Updated"
Worksheets("5 - Check Input Files").Range("E7").Value = Lresult
Worksheets("5 - Check Input Files").Range("F7").Value = FileLen(size_s)
Worksheets("5 - Check Input Files").Range("D8").Value = "R Files Updated"
Worksheets("5 - Check Input Files").Range("E8").Value = Rresult
Worksheets("5 - Check Input Files").Range("F8").Value = FileLen(size_r)
Worksheets("5 - Check Input Files").Range("D4").Value = "Current Time"
Worksheets("5 - Check Input Files").Range("E4").Value = t


    


End Function


