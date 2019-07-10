Private Sub GenerateInputFileandSynTS_Click()
    Save_parameters
    WriteParams
    Run_R_SyntheticTS_Script
    GenerateSUSTAINInputFile
    Worksheets(ActiveSheet.index + 1).Select
End Sub


Private Sub Worksheet_Calculate()
    If range("T4").Value <> 2 Then
        range("D10").Interior.ColorIndex = 0
        range("G10").Interior.ColorIndex = 0
        range("D15").Interior.ColorIndex = 15
        range("G15").Interior.ColorIndex = 15
        range("D18").Interior.ColorIndex = 15
        range("G18").Interior.ColorIndex = 15
    ElseIf range("T4").Value = 2 Then
        range("D10").Interior.ColorIndex = 15
        range("G10").Interior.ColorIndex = 15
        range("D15").Interior.ColorIndex = 0
        range("G15").Interior.ColorIndex = 0
        range("D18").Interior.ColorIndex = 0
        range("G18").Interior.ColorIndex = 0
    End If

End Sub