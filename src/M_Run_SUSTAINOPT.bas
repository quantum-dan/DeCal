Sub Run_SUSTAINOPT()


    'Dim shell As Object
    'Set shell = VBA.CreateObject("WScript.Shell")
    'Dim waitTillComplete As Boolean: waitTillComplete = True
    'Dim style As Integer: style = 1
    'Dim errorCode As Integer
    
    ' Read in working directory file path and path to R executable
    Dim wd_path, Rscrpt_path As String
    wd_path = ReturnWorkingDir()
    sustain_path = Sheets("1 - Locate Executables").range("C11").Value
    
    
        
    ' Call SUSTAIN function with 2 arguments arguments: "0" and the path to the input file
    Dim command As String
    command = Chr(34) & sustain_path & Chr(34) & " 0 " & Chr(34) & wd_path & "\SUSTAIN\BMP_Cal_InputFile.inp" & Chr(34)
    'errorCode = shell.Run(command, style, waitTillComplete)

    Call shell(command, waitTillComplete)
    
End Sub