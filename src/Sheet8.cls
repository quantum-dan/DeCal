
Private Sub CommandButton1_Click()
    On Error GoTo ErrorHandler
    Get_datetime
ErrorHandler:
    MsgBox "Error occurred; it is likely that the previous page did not run correctly and the file was not generated." & Chr(10) & _
    "Error number: " & Err.Number & "; Description: " & Err.Description
End Sub


Private Sub CommandButton2_Click()
    Worksheets(ActiveSheet.index + 1).Select
End Sub


Private Sub CommandButton3_Click()
    On Error GoTo ErrorHandler
    Graphs_c
ErrorHandler:
    MsgBox "Error occurred; it is likely that the previous page did not run correctly and the file was not generated." & Chr(10) & _
    "Error number: " & Err.Number & "; Description: " & Err.Description
End Sub

Private Sub CommandButton4_Click()
    On Error GoTo ErrorHandler
    Graphs_i
ErrorHandler:
    MsgBox "Error occurred; it is likely that the previous page did not run correctly and the file was not generated." & Chr(10) & _
    "Error number: " & Err.Number & "; Description: " & Err.Description
End Sub

Private Sub CommandButton5_Click()
    On Error GoTo ErrorHandler
    Graphs_d
ErrorHandler:
    MsgBox "Error occurred; it is likely that the previous page did not run correctly and the file was not generated." & Chr(10) & _
    "Error number: " & Err.Number & "; Description: " & Err.Description
End Sub

Private Sub CommandButton6_Click()
    On Error GoTo ErrorHandler
    Graphs_v
ErrorHandler:
    MsgBox "Error occurred; it is likely that the previous page did not run correctly and the file was not generated." & Chr(10) & _
    "Error number: " & Err.Number & "; Description: " & Err.Description
End Sub