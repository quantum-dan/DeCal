Sub VerifyAndProceed(sustainPath As String, rPath As String)
    ' Verify that the paths make sense (end with the correct file name)
    Dim sustainExp1, sustainExp2, rExp As String
    sustainExp1 = "SUSTAINOPT.exe"
    sustainExp2 = "SUSTAIN.exe"
    rExp = "Rscript.exe"
    Dim sustainValid, rValid As Boolean
    sustainValid = (Len(sustainPath) >= Len(sustainExp1) And Right(sustainPath, Len(sustainExp1)) = sustainExp1) Or (Len(sustainPath) >= Len(sustainExp2) And Right(sustainPath, Len(sustainExp2)) = sustainExp2)
    rValid = Len(rPath) >= Len(rExp) And Right(rPath, Len(rExp)) = rExp
    If (sustainValid And rValid) Then
        Proceed
    Else
        ' Warn user
        Dim message As String
        message = "Warning: your specified paths have the following issues:" & Chr(10)
        If (Not sustainValid) Then
            message = message & "The SUSTAIN file path should end with either SUSTAIN.exe or SUSTAINOPT.exe." & Chr(10)
        End If
        If (Not rValid) Then
            message = message & "The Rscript file path should end with Rscript.exe." & Chr(10)
        End If
        message = message & "You should confirm that the paths are correct.  Are you sure they are correct?  Press `No` to go back and change them."
        Dim response As Integer
        response = MsgBox(message, vbYesNo)
        If (response = 6) Then
            Proceed
        End If
    End If
End Sub

Sub Proceed()
    Make_File_Struct
    Save_parameters
    Worksheets(ActiveSheet.Index + 1).Select
End Sub