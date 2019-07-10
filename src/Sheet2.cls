Private Sub LoadData_Click()
    ReadTimeseries
End Sub

Private Sub WriteOutTS_Click()
    If (ValidateTimeseries) Then
        Save_parameters
        WriteParams
        Write_Out_R_Inputs
        Worksheets(ActiveSheet.index + 1).Select
    End If
End Sub

Function ValidateTimeseries() As Boolean
    Dim firstrow, maxrow, minrows, index As Integer
    Dim sheet As String
    Dim proceed As Boolean
    proceed = True
    sheet = "2 - Time Series Data Entry"
    firstrow = 14
    minrows = 3
    index = 0
    ' Pairs: B,C; E,F; H,I
    ' This should really be a loop, but VBA was being highly uncooperative
    maxrow = LastRow(sheet, "B")
    If Not (maxrow = LastRow(sheet, "C") And (maxrow - firstrow + 1 >= minrows)) Then
        proceed = False
    Else
        maxrow = LastRow(sheet, "E")
        If Not (maxrow = LastRow(sheet, "F") And (maxrow - firstrow + 1 >= minrows)) Then
            proceed = False
        Else
            maxrow = LastRow(sheet, "H")
            If Not (maxrow = LastRow(sheet, "I") And (maxrow - firstrow + 1 >= minrows)) Then
                proceed = False
            End If
        End If
    End If
    If (Not proceed) Then
        If (MsgBox("Warning: for proper function, please ensure that each pair of timeseries has" & _
        " the same number of entries and that each timeseries has at least 3 entries.  It is recommended " & _
        "that you go back and update the timeseries accordingly.  Proceed anyway?", vbYesNo) = 6) Then
            ValidateTimeseries = True
        Else: ValidateTimeseries = False
        End If
    Else: ValidateTimeseries = True
    End If
End Function

Function LastRow(sheet As String, column As String) As Integer
    LastRow = Sheets(sheet).Cells(Rows.Count, column).End(xlUp).row
End Function