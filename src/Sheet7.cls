Private Sub BMPGeomSubmit_Click()
    Worksheets(ActiveSheet.Index + 1).Select
End Sub

Private Sub Worksheet_Calculate()
    'Grey out unneeded cells in the "BMP Geometry" section based on dropdown menu selection
    'Also show/hide the different BMP diagrams by class
    If Range("V15").Value = "A" Then
        Range("D12").Interior.ColorIndex = 0
        Range("G12").Interior.ColorIndex = 0
        Range("D14").Interior.ColorIndex = 15
        Range("G14").Interior.ColorIndex = 15
        Range("D16").Interior.ColorIndex = 15
        Range("G16").Interior.ColorIndex = 15
        Range("D18").Interior.ColorIndex = 15
        Range("G18").Interior.ColorIndex = 15
        ' Show / Hide orifice Options
        If Range("V23").Value <> 5 Then
            Range("D49").Interior.ColorIndex = 0
            Range("G49").Interior.ColorIndex = 0
        ElseIf Range("V23").Value = 5 Then
            Range("D49").Interior.ColorIndex = 15
            Range("G49").Interior.ColorIndex = 15
        End If
        ' Show / Hide Weir Options
        If Range("V29").Value = 1 Then
            Range("D60").Interior.ColorIndex = 0
            Range("G60").Interior.ColorIndex = 0
            Range("G62").Interior.ColorIndex = 15
        ElseIf Range("V29").Value = 2 Then
            Range("D60").Interior.ColorIndex = 0
            Range("G60").Interior.ColorIndex = 15
            Range("G62").Interior.ColorIndex = 0
        Else
            Range("D60").Interior.ColorIndex = 15
            Range("G60").Interior.ColorIndex = 15
            Range("G62").Interior.ColorIndex = 15
        End If
        ActiveSheet.Shapes("ClassAPic").Visible = True
        ActiveSheet.Shapes("ClassBPic").Visible = False
        ActiveSheet.Shapes("ClassDPic").Visible = False
    ElseIf Range("V15").Value = "B" Then
        Range("D12").Interior.ColorIndex = 0
        Range("G12").Interior.ColorIndex = 0
        Range("D14").Interior.ColorIndex = 0
        Range("G14").Interior.ColorIndex = 0
        Range("D16").Interior.ColorIndex = 0
        Range("G16").Interior.ColorIndex = 0
        Range("D18").Interior.ColorIndex = 0
        Range("G18").Interior.ColorIndex = 15
        Range("D49").Interior.ColorIndex = 15
        Range("G49").Interior.ColorIndex = 15
        Range("D60").Interior.ColorIndex = 15
        Range("G60").Interior.ColorIndex = 15
        Range("G62").Interior.ColorIndex = 15
        ActiveSheet.Shapes("ClassAPic").Visible = False
        ActiveSheet.Shapes("ClassBPic").Visible = True
        ActiveSheet.Shapes("ClassDPic").Visible = False
    ElseIf Range("V15").Value = "D" Then
        Range("D12").Interior.ColorIndex = 0
        Range("G12").Interior.ColorIndex = 0
        Range("D14").Interior.ColorIndex = 15
        Range("G14").Interior.ColorIndex = 15
        Range("D16").Interior.ColorIndex = 15
        Range("G16").Interior.ColorIndex = 0
        Range("D18").Interior.ColorIndex = 0
        Range("G18").Interior.ColorIndex = 0
        Range("D49").Interior.ColorIndex = 15
        Range("G49").Interior.ColorIndex = 15
        Range("D60").Interior.ColorIndex = 15
        Range("G60").Interior.ColorIndex = 15
        Range("G62").Interior.ColorIndex = 15
        ActiveSheet.Shapes("ClassAPic").Visible = False
        ActiveSheet.Shapes("ClassBPic").Visible = False
        ActiveSheet.Shapes("ClassDPic").Visible = True
    Else
        Range("D12").Interior.ColorIndex = 15
        Range("G12").Interior.ColorIndex = 15
        Range("D14").Interior.ColorIndex = 15
        Range("G14").Interior.ColorIndex = 15
        Range("D16").Interior.ColorIndex = 15
        Range("G16").Interior.ColorIndex = 15
        Range("D18").Interior.ColorIndex = 15
        Range("G18").Interior.ColorIndex = 15
        Range("D49").Interior.ColorIndex = 15
        Range("G49").Interior.ColorIndex = 15
        ActiveSheet.Shapes("ClassAPic").Visible = False
        ActiveSheet.Shapes("ClassBPic").Visible = False
        ActiveSheet.Shapes("ClassDPic").Visible = False
    End If

End Sub
