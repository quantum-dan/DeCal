Sub WriteBmpParams()
    ' All data - by putting it all in an array it is much easier to manipulate
    ' As the array includes the cell coordinates for each value, reading the data can be much more
    ' readily automated.
    Dim data(), specifiers() As Variant
    ' Geometry
    'Dim weirType, bmpType, orifice As Integer
    'Dim length, width, mdepth, rslope, lslope, longslope, manning, storage, oheight, odiam, wheight, wwidth, wtheta, ncstr As Double
    With Sheets("3a - BMP Geometry")
        'bmpType = .Range("V13").Value
        data(0, 0) = "BMP Type"
        data(0, 1) = "V13"
        data(0, 2) = .Range("V13").Value
        'weirType = .Range("V23").Value
        data(1, 0) = "Weir Type"
        data(1, 1) = "V23"
        data(1, 2) = .Range("V23").Value
        'orifice = .Range("V29").Value
        data(2, 0) = "Orifice Type"
        data(2, 1) = "V29"
        data(2, 2) = .Range("V29").Value
        'length = .Range("D12").Value
        data(3, 0) = "BMP Length"
        data(3, 1) = "D12"
        data(3, 2) = .Range("D12").Value
        'width = .Range("G12").Value
        data(4, 0) = "BMP Width"
        data(4, 1) = "G12"
        data(4, 2) = .Range("G12").Value
        'mdepth = .Range("D14").Value
        data(5, 0) = "BMP Max Depth"
        data(5, 1) = "D14"
        data(5, 2) = .Range("D14").Value
        'rslope = .Range("G14").Value
        data(6, 0) = "BMP Right-side Slope"
        data(6, 1) = "G14"
        data(6, 2) = .Range("G14").Value
        'lslope = .Range("D16").Value
        data(7, 0) = "BMP Left-side Slope"
        data(7, 1) = "D16"
        data(7, 2) = .Range("D16").Value
        'longslope = .Range("G16").Value
        data(8, 0) = "BMP Longitudinal Slope"
        data(8, 1) = "G16"
        data(8, 2) = .Range("G16").Value
        'manning = .Range("D18").Value
        data(9, 0) = "Manning's n"
        data(9, 1) = "D18"
        data(9, 2) = .Range("D18").Value
        'storage = .Range("G18").Value
        data(10, 0) = "Depression Storage"
        data(10, 1) = "G18"
        data(10, 2) = .Range("G18").Value
        'oheight = .Range("D49").Value
        data(11, 0) = "Orificde Height"
        data(11, 1) = "D49"
        data(11, 2) = .Range("D49").Value
        'odiam = .Range("G49").Value
        data(12, 0) = "Orifice Diameter"
        data(12, 1) = "G49"
        data(12, 2) = .Range("G49").Value
        'wheight = .Range("D60").Value
        data(13, 0) = "Weir Height"
        data(14, 0) = "D60"
        data(15, 0) = .Range("D60").Value
        'wwidth = .Range("G60").Value
        'wtheta = .Range("G62").Value
        'ncstr = .Range("G67").Value
    End With
    ' Subsurface
    'Dim model, underdrain As Integer
    'Dim shead, ideficit, maxinf, infdecay, drytime, vegparam, maxvol, sdepth, sporosity, sfcap, swp, sinfrate, binfrate, udepth, uvfrac As Double
    With Sheets("3b - BMP Subsurface Properties")
        'model = .Range("V7").Value
        'underdrain = .Range("V14").Value
        'shead = .Range("D9").Value
        'ideficit = .Range("D11").Value
        'maxinf = .Range("G9").Value
        'infdecay = .Range("G11").Value
        'drytime = .Range("G13").Value
        'vegparam = .Range("D15").Value
        'maxvol = .Range("G15").Value
        'sdepth = .Range("D22").Value
        'sporosity = .Range("D24").Value
        'sfcap = .Range("D26").Value
        'swp = .Range("D28").Value
        'sinfrate = .Range("D30").Value
        'binfrate = .Range("D32").Value
        'udepth = .Range("G24").Value
        'uvfrac = .Range("G26").Value
    End With
    
    'Write to file
    Dim file_path, input_data As String
    Dim out_file, fso As Object
    file_path = ReturnWorkingDir() & "\data\bmpdata.csv"
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    Set out_file = fso.CreateTextFile(file_path)
End Sub