Private Sub CommandButton1_Click()
    Dim rPath As String
    Dim sustainPath As String
    Dim wdir As String
    wdir = ReturnWorkingDir
    rPath = Sheets("1 - Locate Executables").Range("C8").Value
    sustainPath = Sheets("1 - Locate Executables").Range("C11").Value
    VerifyAndProceed sustainPath, rPath, wdir
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

Private Sub LoadProject_Click()
    ' Load in existing data
    ReadParams
    ReadBmpParams
    ReadTimeseries
End Sub