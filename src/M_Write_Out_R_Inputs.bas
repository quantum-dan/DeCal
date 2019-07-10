Function Write_Out_R_Inputs()
Dim firstrow As Integer
firstrow = 14

'---------------------------------------------------------------------------------------------
' ABOUT:
' This code reads in user-supplied data from the "Time Series Data Entry' sheet
' And outputs it to text files that are read into R
'---------------------------------------------------------------------------------------------


'--------------------
' Initialize the strings identifying the path to write output files
'--------------------
Dim wd_path, R_input_path As String
' Make sure everything stays in the named directory.
wd_path = ReturnWorkingDir()
R_input_path = wd_path & "\data\"

'--------------------
' Initialize arrays for input data, file names, and fs objects
'--------------------
Dim v_in, dur, c_in, c_out, ppt_dt, ppt As Variant
Dim v_in_filename, dur_filename, c_in_filename, c_out_filename, ppt_dt_filename, ppt_filename As String
Dim v_in_fsobj, dur_fsobj, c_in_fsobj, c_out_fsobj, ppt_dt_fsobj, ppt_fsobj As Object


'--------------------
' Set fs objects
'--------------------
Set v_in_fsobj = CreateObject("Scripting.FileSystemObject")
Set dur_fsobj = CreateObject("Scripting.FileSystemObject")
Set c_in_fsobj = CreateObject("Scripting.FileSystemObject")
Set c_out_fsobj = CreateObject("Scripting.FileSystemObject")
Set ppt_dt_fsobj = CreateObject("Scripting.FileSystemObject")
Set ppt_fsobj = CreateObject("Scripting.FileSystemObject")


'--------------------
' Read in Data from Excel
'--------------------

' Find last rows with data
With Sheets("2 - Time Series Data Entry")
    v_in_LR = .Cells(Rows.Count, "B").End(xlUp).row
    dur_LR = .Cells(Rows.Count, "C").End(xlUp).row
    c_in_LR = .Cells(Rows.Count, "E").End(xlUp).row
    c_out_LR = .Cells(Rows.Count, "F").End(xlUp).row
    ppt_dt_LR = .Cells(Rows.Count, "H").End(xlUp).row
    ppt_LR = .Cells(Rows.Count, "I").End(xlUp).row
End With

' Read in to last row
v_in = Sheets("2 - Time Series Data Entry").range("B" & firstrow & ":B" & v_in_LR).Value
dur = Sheets("2 - Time Series Data Entry").range("C" & firstrow & ":C" & dur_LR).Value
c_in = Sheets("2 - Time Series Data Entry").range("E" & firstrow & ":E" & c_in_LR).Value
c_out = Sheets("2 - Time Series Data Entry").range("F" & firstrow & ":F2" & c_out_LR).Value
ppt_dt = Sheets("2 - Time Series Data Entry").range("H" & firstrow & ":H" & ppt_dt_LR).Value
ppt = Sheets("2 - Time Series Data Entry").range("I" & firstrow & ":I" & ppt_LR).Value


'--------------------
' Write out data to files
'--------------------

'--------------------
' v_in
' establish file path
v_in_filename = R_input_path & "v_in.csv"

' Initiralize text file objects
Dim v_in_txtFile As Object
Set v_in_txtFile = v_in_fsobj.CreateTextFile(v_in_filename)

'populate file with v_in values
v_in_txtFile.WriteLine "v_in.cf"
    For n = 1 To UBound(v_in)
    v_in_txtFile.WriteLine v_in(n, 1)
Next

'set objects to nothing
Set v_in_fsobj = Nothing
Set v_in_txtFile = Nothing



'--------------------
' dur
' establish file path
dur_filename = R_input_path & "dur.csv"

' Initiralize text file objects
Dim dur_txtFile As Object
Set dur_txtFile = dur_fsobj.CreateTextFile(dur_filename)

'populate file with dur values
dur_txtFile.WriteLine "dur.min"
    For n = 1 To UBound(dur)
    dur_txtFile.WriteLine dur(n, 1)
Next

'set objects to nothing
Set dur_fsobj = Nothing
Set dur_txtFile = Nothing



'--------------------
' c_in
' establish file path
c_in_filename = R_input_path & "c_in.csv"

' Initiralize text file objects
Dim c_in_txtFile As Object
Set c_in_txtFile = c_in_fsobj.CreateTextFile(c_in_filename)

'populate file with c_in values
c_in_txtFile.WriteLine "c_in.mg_per_L"
    For n = 1 To UBound(c_in)
    c_in_txtFile.WriteLine c_in(n, 1)
Next

'set objects to nothing
Set c_in_fsobj = Nothing
Set c_in_txtFile = Nothing


'--------------------
' c_out
' establish file path
c_out_filename = R_input_path & "c_out.csv"

' Initiralize text file objects
Dim c_out_txtFile As Object
Set c_out_txtFile = c_out_fsobj.CreateTextFile(c_out_filename)

'populate file with c_out values
c_out_txtFile.WriteLine "c_out.mg_per_L"
    For n = 1 To UBound(c_out)
    c_out_txtFile.WriteLine c_out(n, 1)
Next

'set objects to nothing
Set c_out_fsobj = Nothing
Set c_out_txtFile = Nothing


'--------------------
' ppt_dt
' establish file path
ppt_dt_filename = R_input_path & "ppt_dt.csv"

' Initiralize text file objects
Dim ppt_dt_txtFile As Object
Set ppt_dt_txtFile = ppt_dt_fsobj.CreateTextFile(ppt_dt_filename)

'populate file with ppt_dt values
ppt_dt_txtFile.WriteLine "ppt.dt"
For n = 1 To UBound(ppt_dt)
    ' Convert DT to MM/DD/YYYY HH:MM:SS
    ppt_dt(n, 1) = Format(ppt_dt(n, 1), "MM/DD/YYYY HH:MM:SS")
    ppt_dt_txtFile.WriteLine ppt_dt(n, 1)
Next

'set objects to nothing
Set ppt_dt_fsobj = Nothing
Set ppt_dt_txtFile = Nothing


'--------------------
' ppt
' establish file path
ppt_filename = R_input_path & "ppt.csv"

' Initiralize text file objects
Dim ppt_txtFile As Object
Set ppt_txtFile = ppt_fsobj.CreateTextFile(ppt_filename)

'populate file with ppt values
ppt_txtFile.WriteLine "ppt.in"
For n = 1 To UBound(ppt)
    ppt_txtFile.WriteLine ppt(n, 1)
Next

'set objects to nothing
Set ppt_fsobj = Nothing
Set ppt_txtFile = Nothing




End Function
