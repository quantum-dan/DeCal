Private Sub BMPGeomSubmit_Click()
    WriteBmpParams
    Worksheets(ActiveSheet.index + 1).Select
End Sub

Private Sub Worksheet_Calculate()
    'Grey out unneeded cells in the "BMP Geometry" section based on dropdown menu selection
    'Also show/hide the different BMP diagrams by class
    With Sheets("3a - BMP Geometry")
    If .range("V15").Value = "A" Then
        .range("D12").Interior.ColorIndex = 0
        .range("G12").Interior.ColorIndex = 0
        .range("D14").Interior.ColorIndex = 15
        .range("G14").Interior.ColorIndex = 15
        .range("D16").Interior.ColorIndex = 15
        .range("G16").Interior.ColorIndex = 15
        .range("D18").Interior.ColorIndex = 15
        .range("G18").Interior.ColorIndex = 15
        ' Show / Hide orifice Options
        If .range("V23").Value <> 5 Then
            .range("D49").Interior.ColorIndex = 0
            .range("G49").Interior.ColorIndex = 0
        ElseIf .range("V23").Value = 5 Then
            .range("D49").Interior.ColorIndex = 15
            .range("G49").Interior.ColorIndex = 15
        End If
        ' Show / Hide Weir Options
        If .range("V29").Value = 1 Then
            .range("D60").Interior.ColorIndex = 0
            .range("G60").Interior.ColorIndex = 0
            .range("G62").Interior.ColorIndex = 15
        ElseIf .range("V29").Value = 2 Then
            .range("D60").Interior.ColorIndex = 0
            .range("G60").Interior.ColorIndex = 15
            .range("G62").Interior.ColorIndex = 0
        Else
            .range("D60").Interior.ColorIndex = 15
            .range("G60").Interior.ColorIndex = 15
            .range("G62").Interior.ColorIndex = 15
        End If
        .Shapes("ClassAPic").Visible = True
        .Shapes("ClassBPic").Visible = False
        .Shapes("ClassDPic").Visible = False
    ElseIf .range("V15").Value = "B" Then
        .range("D12").Interior.ColorIndex = 0
        .range("G12").Interior.ColorIndex = 0
        .range("D14").Interior.ColorIndex = 0
        .range("G14").Interior.ColorIndex = 0
        .range("D16").Interior.ColorIndex = 0
        .range("G16").Interior.ColorIndex = 0
        .range("D18").Interior.ColorIndex = 0
        .range("G18").Interior.ColorIndex = 15
        .range("D49").Interior.ColorIndex = 15
        .range("G49").Interior.ColorIndex = 15
        .range("D60").Interior.ColorIndex = 15
        .range("G60").Interior.ColorIndex = 15
        .range("G62").Interior.ColorIndex = 15
        .Shapes("ClassAPic").Visible = False
        .Shapes("ClassBPic").Visible = True
        .Shapes("ClassDPic").Visible = False
    ElseIf .range("V15").Value = "D" Then
        .range("D12").Interior.ColorIndex = 0
        .range("G12").Interior.ColorIndex = 0
        .range("D14").Interior.ColorIndex = 15
        .range("G14").Interior.ColorIndex = 15
        .range("D16").Interior.ColorIndex = 15
        .range("G16").Interior.ColorIndex = 0
        .range("D18").Interior.ColorIndex = 0
        .range("G18").Interior.ColorIndex = 0
        .range("D49").Interior.ColorIndex = 15
        .range("G49").Interior.ColorIndex = 15
        .range("D60").Interior.ColorIndex = 15
        .range("G60").Interior.ColorIndex = 15
        .range("G62").Interior.ColorIndex = 15
        .Shapes("ClassAPic").Visible = False
        .Shapes("ClassBPic").Visible = False
        .Shapes("ClassDPic").Visible = True
    Else
        .range("D12").Interior.ColorIndex = 15
        .range("G12").Interior.ColorIndex = 15
        .range("D14").Interior.ColorIndex = 15
        .range("G14").Interior.ColorIndex = 15
        .range("D16").Interior.ColorIndex = 15
        .range("G16").Interior.ColorIndex = 15
        .range("D18").Interior.ColorIndex = 15
        .range("G18").Interior.ColorIndex = 15
        .range("D49").Interior.ColorIndex = 15
        .range("G49").Interior.ColorIndex = 15
        .Shapes("ClassAPic").Visible = False
        .Shapes("ClassBPic").Visible = False
        .Shapes("ClassDPic").Visible = False
    End If
    
    End With

End Sub
