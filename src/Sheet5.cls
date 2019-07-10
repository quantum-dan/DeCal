Private Sub BMPSubstrateSubmit_Click()
    WriteBmpParams
    Worksheets(ActiveSheet.index + 1).Select
End Sub


Private Sub Worksheet_Calculate()
    
    'Grey out unneeded cells in the "Infiltration Model" and "Soil Substrate" sections based on dropdown menu selection
    
    With Sheets("3b - BMP Subsurface Properties")
    If .range("V8").Value = 0 Then
        'Green Ampt
        .range("D9").Interior.ColorIndex = 0
        .range("D11").Interior.ColorIndex = 0
        'Horton
        .range("G9").Interior.ColorIndex = 15
        .range("G11").Interior.ColorIndex = 15
        .range("G13").Interior.ColorIndex = 15
        .range("G15").Interior.ColorIndex = 15
        'Holtan
        .range("D15").Interior.ColorIndex = 15
    
    ElseIf .range("V8").Value = 1 Then
        'Green Ampt
        .range("D9").Interior.ColorIndex = 15
        .range("D11").Interior.ColorIndex = 15
        'Horton
        .range("G9").Interior.ColorIndex = 0
        .range("G11").Interior.ColorIndex = 0
        .range("G13").Interior.ColorIndex = 0
        .range("G15").Interior.ColorIndex = 0
        'Holtan
        .range("D15").Interior.ColorIndex = 15
    Else
        'Green Ampt
        .range("D9").Interior.ColorIndex = 15
        .range("D11").Interior.ColorIndex = 15
        'Horton
        .range("G9").Interior.ColorIndex = 15
        .range("G11").Interior.ColorIndex = 15
        .range("G13").Interior.ColorIndex = 15
        .range("G15").Interior.ColorIndex = 15
        'Holtan
        .range("D15").Interior.ColorIndex = 0

    End If



    'Grey out underdrain cells
    If .range("V15").Value = 0 Then
        .range("G24").Interior.ColorIndex = 15
        .range("G26").Interior.ColorIndex = 15
    Else
        .range("G24").Interior.ColorIndex = 0
        .range("G26").Interior.ColorIndex = 0
    End If
        
    End With
    
End Sub