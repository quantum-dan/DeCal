Private Sub CommandButton1_Click()
    Dim rPath As String
    Dim sustainPath As String
    Dim wdir As String
    wdir = ReturnWorkingDir
    rPath = Sheets("1 - Locate Executables").range("C8").Value
    sustainPath = Sheets("1 - Locate Executables").range("C11").Value
    VerifyAndProceed sustainPath, rPath, wdir
End Sub

Private Sub DefWorkingDir_Click()
   Sheets("1 - Locate Executables").range("C5").Value = GetWorkingDir
End Sub


Private Sub DefRPath_Click()
   Sheets("1 - Locate Executables").range("C8").Value = GetRFile
End Sub


Private Sub DefSUSTAINPath_Click()
   Sheets("1 - Locate Executables").range("C11").Value = GetSUSTAINFile
End Sub

Private Sub LoadProject_Click()
    ' Load in existing data
    On Error GoTo ErrorHandler
    ReadParams
    ReadBmpParams
    ReadTimeseries
    
ErrorHandler:
    MsgBox "Error " & Err.Number & ": " & Err.Description
End Sub

Private Sub SetDefaultPaths_Click()
    Dim wdir As String
    wdir = range("C5").Value
    range("C8").Value = wdir & "\r\r-3.1.2\bin\Rscript.exe"
    range("C11").Value = wdir & "\SUSTAIN\AdamsSUSTAINexe\SUSTAIN.exe"
End Sub