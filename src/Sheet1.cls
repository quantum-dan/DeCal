Private Sub CommandButton1_Click()
    Dim rPath As String
    Dim sustainPath As String
    rPath = Sheets("1 - Locate Executables").Range("C8").Value
    sustainPath = Sheets("1 - Locate Executables").Range("C11").Value
    VerifyAndProceed sustainPath, rPath
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
