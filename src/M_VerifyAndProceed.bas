Sub VerifyAndProceed(sustainPath As String, rPath As String, wdir As String)
    ' Verify that the paths make sense (end with the correct file name)
    Dim sustainExp1, sustainExp2, rExp As String
    sustainExp1 = "SUSTAINOPT.exe"
    sustainExp2 = "SUSTAIN.exe"
    rExp = "Rscript.exe"
    Dim sustainValid, rValid As Boolean
    ' Check that both paths end with something appropriate
    sustainValid = (Len(sustainPath) >= Len(sustainExp1) And Right(sustainPath, Len(sustainExp1)) = sustainExp1) Or (Len(sustainPath) >= Len(sustainExp2) And Right(sustainPath, Len(sustainExp2)) = sustainExp2)
    rValid = Len(rPath) >= Len(rExp) And Right(rPath, Len(rExp)) = rExp
    If (sustainValid And rValid) Then
        If (InStr(wdir, " ") = 0) Then
        ' Make sure working directory doesn't have spaces
            proceed
        Else
            ' Require user to change their working directory to one  without spaces
            MsgBox ("Error: currently, SUSTAIN will not work if your working directory path has any spaces in it.  Please change your working directory to one without spaces.")
        End If
    Else
        ' Warn user about file paths, but they can proceed anyway in case the paths actually are correct but just unusual
        Dim message As String
        message = "Warning: your specified paths have the following issues:" & Chr(10)
        If (Not sustainValid) Then
            message = message & "The SUSTAIN file path should end with either SUSTAIN.exe or SUSTAINOPT.exe." & Chr(10)
        End If
        If (Not rValid) Then
            message = message & "The Rscript file path should end with Rscript.exe.  Note that, if this path is different, the equivalent to Rscript.exe must be in the same directory as the two included R scripts." & Chr(10)
        End If
        message = message & "You should confirm that the paths are correct.  Are you sure they are correct?  Press `No` to go back and change them."
        Dim response As Integer
        response = MsgBox(message, vbYesNo)
        If (response = 6) Then
            proceed
        End If
    End If
End Sub

Sub proceed()
    Make_File_Struct
    Save_parameters
    Worksheets(ActiveSheet.index + 1).Select
End Sub