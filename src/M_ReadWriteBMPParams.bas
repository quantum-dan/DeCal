Sub WriteBmpParams()
    ' All data - by putting it all in an array it is much easier to manipulate
    ' As the array includes the cell coordinates for each value, reading the data can be much more
    ' readily automated.
    Dim data(33), specifiers() As Variant
    
    ' Array of sheet, name, and cell--use to generate output array
    ' VBA won't allow enough line separators to give each array its own line.
    specifiers = Array(Array("3a - BMP Geometry", "BMP Type", "V13"), Array("3a - BMP Geometry", "Weir Type", "V23"), Array("3a - BMP Geometry", "Orifice Type", "V29"), Array("3a - BMP Geometry", "BMP Length", "D12"), Array("3a - BMP Geometry", "BMP Width", "G12"), Array("3a - BMP Geometry", "BMP Max Depth", "D14"), Array("3a - BMP Geometry", "BMP Right-Side Slope", "G14"), Array("3a - BMP Geometry", "BMP Left-Side Slope", "D16"), Array("3a - BMP Geometry", "BMP Longitudinal Slope", "G16"), Array("3a - BMP Geometry", "Manning's n", "D18"), Array("3a - BMP Geometry", "Depression Storage", "G18"), Array("3a - BMP Geometry", "Orifice Height", "D49"), Array("3a - BMP Geometry", "Orifice Diameter", "G49"), Array("3a - BMP Geometry", "Weir Height", "D60"), Array("3a - BMP Geometry", "Weir Width", "G60"), Array("3a - BMP Geometry", "Weir Theta", "G62"), Array("3a - BMP Geometry", "nCSTR", "G67"), Array("3b - BMP Subsurface Properties", "Infiltration Model", "V7"), _
                        Array("3b - BMP Subsurface Properties", "Consider Underdrain", "V14"), Array("3b - BMP Subsurface Properties", "Suction Head", "D9"), Array("3b - BMP Subsurface Properties", "Initial Deficit", "D11"), Array("3b - BMP Subsurface Properties", "Maximum Infiltration Rate", "G9"), Array("3b - BMP Subsurface Properties", "Infiltration Decay Constant", "G11"), _
                        Array("3b - BMP Subsurface Properties", "Dry Time", "G13"), Array("3b - BMP Subsurface Properties", "Vegetation Parameter", "D15"), Array("3b - BMP Subsurface Properties", "Maximum Volume", "G15"), Array("3b - BMP Subsurface Properties", "Soil Depth", "D22"), Array("3b - BMP Subsurface Properties", "Soil Porosity", "D24"), Array("3b - BMP Subsurface Properties", "Soil Field Capacity", "D26"), Array("3b - BMP Subsurface Properties", "Soil Wilting Point", "D28"), Array("3b - BMP Subsurface Properties", "Soil Infiltration Rate", "D30"), Array("3b - BMP Subsurface Properties", "Background Infiltration Rate", "D32"), Array("3b - BMP Subsurface Properties", "Underdrain Depth", "G24"), _
                        Array("3b - BMP Subsurface Properties", "Underdrain Void Fraction", "G26"))
                        
                        
    ' Make finalized output array, with values
    For ix = LBound(specifiers) To UBound(specifiers)
        'The odd syntax below seems to be necessary to avoid out of bounds errors
        data(ix) = ""
        For Each Item In specifiers(ix)
            data(ix) = data(ix) & Item & ","
        Next
        data(ix) = data(ix) & Sheets(specifiers(ix)(0)).Range(specifiers(ix)(2)).Value
    Next
    
    'Write to file
    Dim file_path, input_data As String
    Dim out_file, fso As Object
    file_path = ReturnWorkingDir() & "\data\bmpdata.csv"
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    Set out_file = fso.CreateTextFile(file_path)
    For Each Line In data
        out_file.WriteLine (Line)
    Next
    
    Set out_file = Nothing
    Set fso = Nothing
            
End Sub

Sub ReadBmpParams()
    ' Read in the data written to the file previously
    Dim input_data(33), data(33)
    Dim filepath As String
    'Dim fso, in_file As Object
    Dim index As Integer
    filepath = ReturnWorkingDir & "\data\bmpdata.csv"
    index = 0
    
    Open filepath For Input As #1
    
    Do Until EOF(1)
        Line Input #1, input_data(index)
        data(index) = Split(input_data(index), ",")
        index = index + 1
    Loop
    
    Close #1
    
    For Each Item In data
        Sheets(Item(0)).Range(Item(2)).Value = Item(3)
    Next
    
End Sub