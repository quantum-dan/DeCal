Private Sub LoadData_Click()
    ReadTimeseries
End Sub

Private Sub WriteOutTS_Click()
    Save_parameters
    WriteParams
    Write_Out_R_Inputs
    Worksheets(ActiveSheet.index + 1).Select
End Sub