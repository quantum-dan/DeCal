' Order of the parameters in params.csv in format Sheet, Cell
Public Const orderLen = 12
Function order(i, j) As String

    order = Array(Array("4 - Calibration Parameters", "C5"), _
                    Array("4 - Calibration Parameters", "G5"), _
                    Array("4 - Calibration Parameters", "T4"), _
                    Array("4 - Calibration Parameters", "D10"), _
                    Array("4 - Calibration Parameters", "G10"), _
                    Array("4 - Calibration Parameters", "D15"), _
                    Array("4 - Calibration Parameters", "G15"), _
                    Array("4 - Calibration Parameters", "D18"), _
                    Array("4 - Calibration Parameters", "G18"), _
                    Array("4 - Calibration Parameters", "D21"), _
                    Array("2 - Time Series Data Entry", "C4"), _
                    Array("2 - Time Series Data Entry", "G4"), _
                    Array("2 - Time Series Data Entry", "I4"))(i)(j)
                    
End Function

Sub ReadParams()
    ' Read in the data from params.csv
    Dim line, path As String
    path = ReturnWorkingDir & "\data\settings.csv"
    
    Open path For Input As #1
    For ix = 0 To orderLen
        Line Input #1, line
        Sheets(order(ix, 0)).range(order(ix, 1)).Value = line
    Next
    Close #1
End Sub

Sub WriteParams()
    Dim path As String
    path = ReturnWorkingDir & "\data\settings.csv"
    Open path For Output As #1
    For line = 0 To orderLen
        Print #1, Sheets(order(line, 0)).range(order(line, 1)).Value
    Next
    Close #1
End Sub