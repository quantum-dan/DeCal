Sub ReadTimeseries()
    ' Read in stored timeseries data (tab 2)
    Dim columns()
    Dim firstrow, index, row, maxrow As Integer
    Dim datapath, item As String
    datapath = ReturnWorkingDir() & "\data\"
    columns = Array(Array("B", "v_in.csv"), _
                Array("C", "dur.csv"), _
                Array("E", "c_in.csv"), _
                Array("F", "c_out.csv"), _
                Array("H", "ppt_dt.csv"), _
                Array("I", "ppt.csv"))
    firstrow = 14
    With Sheets("2 - Time Series Data Entry")
    ' First, clear the existing data in the spreadsheet
    For index = LBound(columns) To UBound(columns)
        maxrow = .Cells(Rows.Count, columns(index)(0)).End(xlUp).row
        For row = firstrow To maxrow
            .Range(columns(index)(0) & row).Value = ""
        Next
    Next
    
    ' Now, import the data from the file
    For Each Entry In columns
        Open datapath & Entry(1) For Input As #1
        index = firstrow
        
        ' Ignore first line
        Line Input #1, item
        Do Until EOF(1)
            Line Input #1, item
            .Range(Entry(0) & index).Value = item
            index = index + 1
        Loop
        
        Close #1
    Next
    
    End With
End Sub