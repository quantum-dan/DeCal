Private Sub BMPSubstrateSubmit_Click()
    WriteBmpParams
    Worksheets(ActiveSheet.index + 1).Select
End Sub


Private Sub Worksheet_Calculate()
    
    'Grey out unneeded cells in the "Infiltration Model" and "Soil Substrate" sections based on dropdown menu selection
    
    With Sheets("3b - BMP Subsurface Properties")
    If .Range("V8").Value = 0 Then
        'Green Ampt
        .Range("D9").Interior.ColorIndex = 0
        .Range("D11").Interior.ColorIndex = 0
        'Horton
        .Range("G9").Interior.ColorIndex = 15
        .Range("G11").Interior.ColorIndex = 15
        .Range("G13").Interior.ColorIndex = 15
        .Range("G15").Interior.ColorIndex = 15
        'Holtan
        .Range("D15").Interior.ColorIndex = 15
    
    ElseIf .Range("V8").Value = 1 Then
        'Green Ampt
        .Range("D9").Interior.ColorIndex = 15
        .Range("D11").Interior.ColorIndex = 15
        'Horton
        .Range("G9").Interior.ColorIndex = 0
        .Range("G11").Interior.ColorIndex = 0
        .Range("G13").Interior.ColorIndex = 0
        .Range("G15").Interior.ColorIndex = 0
        'Holtan
        .Range("D15").Interior.ColorIndex = 15
    Else
        'Green Ampt
        .Range("D9").Interior.ColorIndex = 15
        .Range("D11").Interior.ColorIndex = 15
        'Horton
        .Range("G9").Interior.ColorIndex = 15
        .Range("G11").Interior.ColorIndex = 15
        .Range("G13").Interior.ColorIndex = 15
        .Range("G15").Interior.ColorIndex = 15
        'Holtan
        .Range("D15").Interior.ColorIndex = 0

    End If



    'Grey out underdrain cells
    If .Range("V15").Value = 0 Then
        .Range("G24").Interior.ColorIndex = 15
        .Range("G26").Interior.ColorIndex = 15
    Else
        .Range("G24").Interior.ColorIndex = 0
        .Range("G26").Interior.ColorIndex = 0
    End If
        
    End With
    
End Sub