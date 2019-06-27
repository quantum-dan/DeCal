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
