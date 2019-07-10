Private Sub GenerateInputFileandSynTS_Click()
    Save_parameters
    WriteParams
    Run_R_SyntheticTS_Script
    GenerateSUSTAINInputFile
    Worksheets(ActiveSheet.index + 1).Select
End Sub


Private Sub Worksheet_Calculate()
    If Range("T4").Value <> 2 Then
        Range("D10").Interior.ColorIndex = 0
        Range("G10").Interior.ColorIndex = 0
        Range("D15").Interior.ColorIndex = 15
        Range("G15").Interior.ColorIndex = 15
        Range("D18").Interior.ColorIndex = 15
        Range("G18").Interior.ColorIndex = 15
    ElseIf Range("T4").Value = 2 Then
        Range("D10").Interior.ColorIndex = 15
        Range("G10").Interior.ColorIndex = 15
        Range("D15").Interior.ColorIndex = 0
        Range("G15").Interior.ColorIndex = 0
        Range("D18").Interior.ColorIndex = 0
        Range("G18").Interior.ColorIndex = 0
    End If

End Sub