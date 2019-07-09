Sub WriteBmpParams()
    ' All data - by putting it all in an array it is much easier to manipulate
    Dim data() As Variant
    ' Geometry
    'Dim weirType, bmpType, orifice As Integer
    'Dim length, width, mdepth, rslope, lslope, longslope, manning, storage, oheight, odiam, wheight, wwidth, wtheta, ncstr As Double
    With Sheets("3a - BMP Geometry")
        'bmpType = .Range("V13").Value
        data(0, 0) = "BMP Type"
        data(0, 1) = .Range("V13").Value
        'weirType = .Range("V23").Value
        data(1, 0) = "Weir Type"
        data(1, 1) = .Range("V23").Value
        'orifice = .Range("V29").Value
        data(2, 0) = "Orifice Type"
        data(2, 1) = .Range("V29").Value
        'length = .Range("D12").Value
        data(3, 0) = "BMP Length"
        data(3, 1) = .Range("D12").Value
        'width = .Range("G12").Value
        data(4, 0) = "BMP Width"
        data(4, 1) = .Range("G12").Value
        'mdepth = .Range("D14").Value
        'rslope = .Range("G14").Value
        'lslope = .Range("D16").Value
        'longslope = .Range("G16").Value
        'manning = .Range("D18").Value
        'storage = .Range("G18").Value
        'oheight = .Range("D49").Value
        'odiam = .Range("G49").Value
        'wheight = .Range("D60").Value
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