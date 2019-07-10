Private Sub CommandButton1_Click()
    Run_R_SyntheticTS_Script
    GenerateSUSTAINInputFile
    
End Sub

Private Sub CommandButton2_Click()
Run_SUSTAINOPT
End Sub

Private Sub CommandButton3_Click()
Run_R_CalibrateWQPars
End Sub

Private Sub ImportCalData_Click()
    CSV_Import
    Get_datetime_cdf
    ExportChart
    Save_final
End Sub

Private Sub NextButton_Click()
    Dim cell As range
    Set cell = range("T76")
    
    If (cell.Value < 10) Then
        cell.Value = cell.Value + 1
    Else
        MsgBox ("Last fit reached.")
    End If
End Sub

Private Sub PrevButton_Click()
    Dim cell As range
    Set cell = range("T76")
    
    If (cell.Value > 1) Then
        cell.Value = cell.Value - 1
    Else
        MsgBox ("First fit reached.")
    End If
End Sub