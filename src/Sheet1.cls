Private Sub CommandButton1_Click()
    Make_File_Struct
    Save_parameters
    Worksheets(ActiveSheet.Index + 1).Select
End Sub

Private Sub DefWorkingDir_Click()
   Sheets("1 - Locate Executables").Range("C5").Value = GetWorkingDir
End Sub


Private Sub DefRPath_Click()
   Sheets("1 - Locate Executables").Range("C8").Value = GetRFile
End Sub


Private Sub DefSUSTAINPath_Click()
   Sheets("1 - Locate Executables").Range("C11").Value = GetSUSTAINFile
End Sub
