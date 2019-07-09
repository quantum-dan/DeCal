Sub GenerateSUSTAINInputFile()
'Function reads in SUSTAIN card headers, appends necessary arguments to each card, then writes out a single SUSTAIN .inp file

    ' Establish card names
    Dim cards As Variant
    cards = Array("c700", "c705", "c710", "c715", "c725", "c735", "c740", "c745", "c747", "c761", "c765", "c766", "c767", "c770", "c790", "c795", "c800", "c815", "cINFINITY")

    
    'Establish important file path / directories
    Dim wd_path, card_path, inp_path, base_wd As String
    
    ' Cards are static and read from the main SUSTAIN directory.  inp_file is written to in the working directory.

    wd_path = ReturnWorkingDir()
    base_wd = Sheets("1 - Locate Executables").Range("C5").Value
    card_path = base_wd & "\SUSTAIN\SUSTAINCardHeaders"
    inp_file = wd_path & "\SUSTAIN\BMP_Cal_InputFile.inp"


    '----------------------------------------------------------------
    'c700: Header + Model Controls.  Also - establish the .inp file
        
        'Read in c700
            'Establish c700 file integer and file path
            Dim TextFile_c700 As Integer
            Dim FilePath_c700 As String
            TextFile_c700 = FreeFile
            FilePath_c700 = card_path & "\c700.txt"


            'Open the card header for read-in
            Open FilePath_c700 For Input As TextFile_c700

            'Store file content inside a variable
            FileContent_c700 = Input(LOF(TextFile_c700), TextFile_c700)
            Close TextFile_c700
        
        'Read in last day of simulation from R script
            'Establish last day text file integer and file path
            Dim TextFile_lastday As Integer
            Dim FilePath_lastday As String
            TextFile_lastday = FreeFile
            FilePath_lastday = wd_path & "\SUSTAIN\InputTSFiles\SimulationEndDate.txt"


            'Open the card header for read-in
            CreateIfNE (FilePath_lastday)
            
            Open FilePath_lastday For Input As TextFile_lastday

            'Store file content inside a variable
            FileContent_lastday = Input(LOF(TextFile_lastday), TextFile_lastday)
            Close TextFile_lastday
        
        ' Create .inp file and write out c700 to it
            'Establish input file integer and file path
            Dim TextFile_Inp As Integer
            Dim FilePath_Inp As String
            TextFile_Inp = FreeFile
            FilePath_Inp = inp_file
        
                        
            'Write c700 header to input file
            Open FilePath_Inp For Output As TextFile_Inp
            Print #TextFile_Inp, FileContent_c700
    
    
            'Write out c700 arguments to input file
            Print #TextFile_Inp, "0" & Chr(9) & wd_path & "\SUSTAIN\Output\"
            Print #TextFile_Inp, "2000" & Chr(9) & "10" & Chr(9) & "01"
            Print #TextFile_Inp, FileContent_lastday
            Print #TextFile_Inp, "5" & Chr(9) & "5" & Chr(9) & "1.5" & Chr(9) & "0" & Chr(9) & wd_path & "\SUSTAIN\Output\"
            Print #TextFile_Inp, "0"
            ' MONTHLY ET - FOR NOW JUST USING A VALUE OF 1 INCH / DAY - MAY WANT TO CHANGE TO NATINOAL AVERAGE
            Print #TextFile_Inp, "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1"
            
            
            'Save & Close Text File
            Close TextFile_Inp



    '----------------------------------------------------------------
    'c705: Pollutant Definition
        
        'Read in c705
            'Establish c705 file integer and file path
            Dim TextFile_c705 As Integer
            Dim FilePath_c705 As String
            TextFile_c705 = FreeFile
            FilePath_c705 = card_path & "\c705.txt"


            'Open the card header for read-in
            Open FilePath_c705 For Input As TextFile_c705

            'Store file content inside a variable
            FileContent_c705 = Input(LOF(TextFile_c705), TextFile_c705)
            Close TextFile_c705
        
        
        'Write out c705 to InputFile
                        
            'Write c705 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c705
    
        
            'Write out c705 arguments to input file
            
                ' Get Number of Monte Carlo Simulations (number of pollutants here)
                Dim nsims As Integer
                nsims = Sheets("4 - Calibration Parameters").Range("G5").Value
                For n = 1 To nsims
                    Print #TextFile_Inp, n & Chr(9) & "WQ" & n & Chr(9) & "1" & Chr(9) & "0" & Chr(9) & "0" & Chr(9) & "0" & Chr(9) & "0"
                Next

            
            'Save & Close Text File
            Close TextFile_Inp

    '----------------------------------------------------------------
    'c710: Land Use
        
        'Read in c710
            'Establish c710 file integer and file path
            Dim TextFile_c710 As Integer
            Dim FilePath_c710 As String
            TextFile_c710 = FreeFile
            FilePath_c710 = card_path & "\c710.txt"


            'Open the card header for read-in
            Open FilePath_c710 For Input As TextFile_c710

            'Store file content inside a variable
            FileContent_c710 = Input(LOF(TextFile_c710), TextFile_c710)
            Close TextFile_c710
        
        
        'Write out c710 to InputFile
                        
            'Write c710 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c710
    
        
            'Write out c710 arguments to input file
            Print #TextFile_Inp, "1" & Chr(9) & "LU" & Chr(9) & "1" & Chr(9) & wd_path & "\SUSTAIN\InputTSFiles\LU_Input_TS_5min.prn" & Chr(9) & "0" & Chr(9) & "0" & Chr(9) & "0"
            
            'Save & Close Text File
            Close TextFile_Inp
            
    '----------------------------------------------------------------
    'c715: BMP SITE Information
        
        'Read in c715
            'Establish c715 file integer and file path
            Dim TextFile_c715 As Integer
            Dim FilePath_c715 As String
            TextFile_c715 = FreeFile
            FilePath_c715 = card_path & "\c715.txt"


            'Open the card header for read-in
            Open FilePath_c715 For Input As TextFile_c715

            'Store file content inside a variable
            FileContent_c715 = Input(LOF(TextFile_c715), TextFile_c715)
            Close TextFile_c715
        
        
        'Write out c715 to InputFile
                        
            'Write c715 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c715
    
        
            'Write out c715 arguments to input file
            Print #TextFile_Inp, "1" & Chr(9) & "BMP" & Chr(9) & Sheets("3a - BMP Geometry").Range("V14").Value & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "0" & Chr(9) & "1" & Chr(9) & "0" & Chr(9)
            
            'Save & Close Text File
            Close TextFile_Inp
            
             
    '----------------------------------------------------------------
    'c725: CLASS-A BMP Site Parameters
        
        'Read in c725
            'Establish c725 file integer and file path
            Dim TextFile_c725 As Integer
            Dim FilePath_c725 As String
            TextFile_c725 = FreeFile
            FilePath_c725 = card_path & "\c725.txt"


            'Open the card header for read-in
            Open FilePath_c725 For Input As TextFile_c725

            'Store file content inside a variable
            FileContent_c725 = Input(LOF(TextFile_c725), TextFile_c725)
            Close TextFile_c725
        
        
        'Write out c725 to InputFile
                        
            'Write c725 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c725
    
        
            'Write out c725 arguments to input file
            
            ' IF BMP CLASS = A
            If Sheets("3a - BMP Geometry").Range("V15").Value = "A" Then
                Dim OrificeH, OrificeD, OrificeC As String
                Dim WeirType, WeirH, WeirW, WeirTHERA As String
                
                ' Save Orifice Info
                If Sheets("3a - BMP Geometry").Range("V24").Value = NO Then
                    OrificeH = "0"
                    OrificeD = "0"
                    OrificeC = "0"
                Else
                    OrificeH = Sheets("3a - BMP Geometry").Range("D49").Value
                    OrificeD = Sheets("3a - BMP Geometry").Range("G49").Value
                    OrificeC = Sheets("3a - BMP Geometry").Range("V23").Value
                End If
                
                ' Save Weir Info
                If Sheets("3a - BMP Geometry").Range("V29").Value = 1 Then
                    WeirType = "1"
                    WeirH = Sheets("3a - BMP Geometry").Range("D60").Value
                    WeirW = Sheets("3a - BMP Geometry").Range("G60").Value
                    WeirTHETA = "0"

                ElseIf Sheets("3a - BMP Geometry").Range("V29").Value = 2 Then
                    WeirType = "2"
                    WeirH = Sheets("3a - BMP Geometry").Range("D60").Value
                    WeirW = "0"
                    WeirTHETA = Sheets("3a - BMP Geometry").Range("G62").Value
                Else
                    WeirType = "0"
                    WeirH = "0"
                    WeirW = "0"
                    WeirTHETA = "0"
                End If
                Print #TextFile_Inp, "1" & Chr(9) & Sheets("3a - BMP Geometry").Range("G12").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D12").Value & Chr(9) & OrificeH & Chr(9) & OrificeD & Chr(9) & OrificeC & Chr(9) & "3" & Chr(9) & "0" & Chr(9) & "0" & Chr(9) & WeirType & Chr(9) & WeirH & Chr(9) & WeirW & Chr(9) & WeirTHETA & Chr(9) & 1 & Chr(9) & "0" & Chr(9) & "0" & Chr(9) & "0" & Chr(9) & "0"
            End If
            
            
            'Save & Close Text File
            Close TextFile_Inp
            
              
            
    '----------------------------------------------------------------
    'c735: CLASS-B BMP Site Parameters
        
        'Read in c735
            'Establish c735 file integer and file path
            Dim TextFile_c735 As Integer
            Dim FilePath_c735 As String
            TextFile_c735 = FreeFile
            FilePath_c735 = card_path & "\c735.txt"


            'Open the card header for read-in
            Open FilePath_c735 For Input As TextFile_c735

            'Store file content inside a variable
            FileContent_c735 = Input(LOF(TextFile_c735), TextFile_c735)
            Close TextFile_c735
        
        
        'Write out c735 to InputFile
                        
            'Write c735 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c735
    
        
            'Write out c735 arguments to input file
            
            If Sheets("3a - BMP Geometry").Range("V15").Value = "B" Then
                Print #TextFile_Inp, "1" & Chr(9) & Sheets("3a - BMP Geometry").Range("G12").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D12").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D14").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D16").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("G14").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("G16").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D18").Value & Chr(9) & 1
            End If
            
            'Save & Close Text File
            Close TextFile_Inp


    '----------------------------------------------------------------
    'c740: BMP Site BOTTOM SOIL/VEGETATION CHARACTERISTICS
        
        'Read in c740
            'Establish c740 file integer and file path
            Dim TextFile_c740 As Integer
            Dim FilePath_c740 As String
            TextFile_c740 = FreeFile
            FilePath_c740 = card_path & "\c740.txt"


            'Open the card header for read-in
            Open FilePath_c740 For Input As TextFile_c740

            'Store file content inside a variable
            FileContent_c740 = Input(LOF(TextFile_c740), TextFile_c740)
            Close TextFile_c740
        
        
        'Write out c740 to InputFile
                        
            'Write c740 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c740
    
        
            'Write out c740 arguments to input file
            Dim aveg, finfil, undswitch, unddepth, undvoid, undinfilt, suction, imdmax, maxinfilt, decaycons, drytime, maxvolume As Double
            
            ' Establish Infiltration model parameters
            If Sheets("3b - BMP Subsurface Properties").Range("V8").Value = 0 Then
                aveg = 0
                finfilt = Sheets("3b - BMP Subsurface Properties").Range("D30").Value
                undinfilt = Sheets("3b - BMP Subsurface Properties").Range("D32").Value
                suction = Sheets("3b - BMP Subsurface Properties").Range("D9").Value
                imdmax = Sheets("3b - BMP Subsurface Properties").Range("D11").Value
                maxinfilt = 0
                decaycons = 0
                drytime = 0
                maxvolume = 0
            ElseIf Sheets("3b - BMP Subsurface Properties").Range("V8").Value = 1 Then
                aveg = 0
                finfilt = Sheets("3b - BMP Subsurface Properties").Range("D30").Value
                undinfilt = Sheets("3b - BMP Subsurface Properties").Range("D32").Value
                suction = 0
                imdmax = 0
                maxinfilt = Sheets("3b - BMP Subsurface Properties").Range("G9").Value
                decaycons = Sheets("3b - BMP Subsurface Properties").Range("G11").Value
                drytime = Sheets("3b - BMP Subsurface Properties").Range("G13").Value
                maxvolume = Sheets("3b - BMP Subsurface Properties").Range("G15").Value
            Else
                aveg = Sheets("3b - BMP Subsurface Properties").Range("D15").Value
                finfilt = Sheets("3b - BMP Subsurface Properties").Range("D30").Value
                undinfilt = Sheets("3b - BMP Subsurface Properties").Range("D32").Value
                suction = 0
                imdmax = 0
                maxinfilt = 0
                decaycons = 0
                drytime = 0
                maxvolume = 0
            End If
              
           ' Establish underdrain model parameters
            If Sheets("3b - BMP Subsurface Properties").Range("V15").Value = 0 Then
                undswitch = 0
                unddepth = 0
                undvoid = 0
      
            Else
                undswitch = 1
                unddepth = Sheets("3b - BMP Subsurface Properties").Range("G24").Value
                undvoid = Sheets("3b - BMP Subsurface Properties").Range("G26").Value
            End If
                
            
            
            Print #TextFile_Inp, "1" & Chr(9) & Sheets("3b - BMP Subsurface Properties").Range("V8").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("G67").Value & Chr(9) & Sheets("4 - Calibration Parameters").Range("U4").Value - 1 & Chr(9) & Sheets("3b - BMP Subsurface Properties").Range("D22").Value & Chr(9) & Sheets("3b - BMP Subsurface Properties").Range("D24").Value & Chr(9) & Sheets("3b - BMP Subsurface Properties").Range("D26").Value & Chr(9) & Sheets("3b - BMP Subsurface Properties").Range("D28").Value & Chr(9) & aveg & Chr(9) & finfilt & Chr(9) & undswitch & Chr(9) & unddepth & Chr(9) & undvoid & Chr(9) & undinfilt & Chr(9) & suction & Chr(9) & imdmax & Chr(9) & maxinfilt & Chr(9) & decaycons & Chr(9) & drytime & Chr(9) & maxvolume
            'Save & Close Text File
            Close TextFile_Inp
            
            
            
    '----------------------------------------------------------------
    'c745: BMP Site HOLTAN GROWTH INDEX
        
        'Read in c745
            'Establish c745 file integer and file path
            Dim TextFile_c745 As Integer
            Dim FilePath_c745 As String
            TextFile_c745 = FreeFile
            FilePath_c745 = card_path & "\c745.txt"


            'Open the card header for read-in
            Open FilePath_c745 For Input As TextFile_c745

            'Store file content inside a variable
            FileContent_c745 = Input(LOF(TextFile_c745), TextFile_c745)
            Close TextFile_c745
        
        
        'Write out c745 to InputFile
                        
            'Write c745 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c745
    
        
            'Write out c745 arguments to input file
            
            If Sheets("3b - BMP Subsurface Properties").Range("V8").Value = 2 Then
            ' NOTE: These values are taken from Holtan 1971 and are for irrigated corn in Ohio...
                  Print #TextFile_Inp, "1" & Chr(9) & "0.1" & Chr(9) & "0.1" & Chr(9) & "0.16" & Chr(9) & "0.21" & Chr(9) & "0.33" & Chr(9) & "0.5" & Chr(9) & "0.7" & Chr(9) & "0.85" & Chr(9) & "0.95" & Chr(9) & "0.25" & Chr(9) & "0.1" & Chr(9) & "0.1"
            End If
            
            
            'Save & Close Text File
            Close TextFile_Inp
            
        
    '----------------------------------------------------------------
    'c747: BMP Site inital Moisutre Content
        
        'Read in c747
            'Establish c747 file integer and file path
            Dim TextFile_c747 As Integer
            Dim FilePath_c747 As String
            TextFile_c747 = FreeFile
            FilePath_c747 = card_path & "\c747.txt"


            'Open the card header for read-in
            Open FilePath_c747 For Input As TextFile_c747

            'Store file content inside a variable
            FileContent_c747 = Input(LOF(TextFile_c747), TextFile_c747)
            Close TextFile_c747
        
        
        'Write out c747 to InputFile
                        
            'Write c747 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c747
    
        
            'Write out c747 arguments to input file
            Print #TextFile_Inp, "1" & Chr(9) & "0.1" & Chr(9) & "0.05"
            
            'Save & Close Text File
            Close TextFile_Inp
            
             
    '----------------------------------------------------------------
    'c761: BUFFERSTRIP BMP Parameters
        
        'Read in c761
            'Establish c761 file integer and file path
            Dim TextFile_c761 As Integer
            Dim FilePath_c761 As String
            TextFile_c761 = FreeFile
            FilePath_c761 = card_path & "\c761.txt"


            'Open the card header for read-in
            Open FilePath_c761 For Input As TextFile_c761

            'Store file content inside a variable
            FileContent_c761 = Input(LOF(TextFile_c761), TextFile_c761)
            Close TextFile_c761
        
        
        'Write out c761 to InputFile
                        
            'Write c761 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c761
    
        
            'Write out c761 arguments to input file
            
            If Sheets("3a - BMP Geometry").Range("V15").Value = "D" Then
                Print #TextFile_Inp, "1" & Chr(9) & Sheets("3a - BMP Geometry").Range("G12").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D12").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("G18").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("G16").Value & Chr(9) & Sheets("3a - BMP Geometry").Range("D18").Value & Chr(9) & Sheets("4 - Calibration Parameters").Range("U4").Value - 1 & Chr(9) & "etmult_insert"
            End If
            
            'Save & Close Text File
            Close TextFile_Inp
                         
            
    '----------------------------------------------------------------
    'c765: BMP SITE Pollutant Decay/Loss rates
        
        'Read in c765
            'Establish c765 file integer and file path
            Dim TextFile_c765 As Integer
            Dim FilePath_c765 As String
            TextFile_c765 = FreeFile
            FilePath_c765 = card_path & "\c765.txt"


            'Open the card header for read-in
            Open FilePath_c765 For Input As TextFile_c765

            'Store file content inside a variable
            FileContent_c765 = Input(LOF(TextFile_c765), TextFile_c765)
            Close TextFile_c765
        
        
        'Write out c765 to InputFile
                        
            'Write c765 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c765
    
        
            'Write out c765 arguments to input file
            If Sheets("4 - Calibration Parameters").Range("T4").Value <> 2 Then
                ReDim ks(nsims) As Double
                Dim ks_txt As String
                For n = 1 To nsims
                    ks(n) = Sheets("4 - Calibration Parameters").Range("D10").Value + (Rnd * (Sheets("4 - Calibration Parameters").Range("G10").Value - Sheets("4 - Calibration Parameters").Range("D10").Value))
                    If n = 1 Then
                        ks_txt = CStr(Round(ks(n), 3))
                    Else
                        ks_txt = ks_txt & Chr(9) & CStr(Round(ks(n), 5))
                    End If
                Next
                Print #TextFile_Inp, "1" & Chr(9) & ks_txt
                'Save & Close Text File
                 Close TextFile_Inp
                 
                 
                'Write out a separate text file with just k values
                Dim TextFile_WQPars As Integer
                Dim FilePath_WQPars As String
                TextFile_WQPars = FreeFile
                FilePath_WQPars = wd_path & "\SUSTAIN\Output\WQPars.txt"

                Open FilePath_WQPars For Output As TextFile_WQPars
                Print #TextFile_WQPars, ks_txt
                Close TextFile_WQPars
                  
            End If
            
            'Save & Close Text File
            Close TextFile_Inp
            
            
    '----------------------------------------------------------------
    'c766: Pollutant K' values
        
        'Read in c766
            'Establish c766 file integer and file path
            Dim TextFile_c766 As Integer
            Dim FilePath_c766 As String
            TextFile_c766 = FreeFile
            FilePath_c766 = card_path & "\c766.txt"


            'Open the card header for read-in
            Open FilePath_c766 For Input As TextFile_c766

            'Store file content inside a variable
            FileContent_c766 = Input(LOF(TextFile_c766), TextFile_c766)
            Close TextFile_c766
        
        
        'Write out c766 to InputFile
                        
            'Write c766 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c766
    
        
            'Write out c766 arguments to input file
            If Sheets("4 - Calibration Parameters").Range("T4").Value = 2 Then
                ReDim k1s(nsims) As Double
                Dim k1s_txt As String
                For n = 1 To nsims
                    k1s(n) = Sheets("4 - Calibration Parameters").Range("D15").Value + (Rnd * (Sheets("4 - Calibration Parameters").Range("G15").Value - Sheets("4 - Calibration Parameters").Range("D15").Value))
                    If n = 1 Then
                        k1s_txt = CStr(Round(k1s(n), 3))
                    Else
                        k1s_txt = k1s_txt & Chr(9) & CStr(Round(k1s(n), 5))
                    End If
                Next
                Print #TextFile_Inp, "1" & Chr(9) & k1s_txt;
                
            End If
            
                                        
            'Save & Close Text File
            Close TextFile_Inp
            



    '----------------------------------------------------------------
    'c767: Pollutant C* values
        
        'Read in c767
            'Establish c767 file integer and file path
            Dim TextFile_c767 As Integer
            Dim FilePath_c767 As String
            TextFile_c767 = FreeFile
            FilePath_c767 = card_path & "\c767.txt"


            'Open the card header for read-in
            Open FilePath_c767 For Input As TextFile_c767

            'Store file content inside a variable
            FileContent_c767 = Input(LOF(TextFile_c767), TextFile_c767)
            Close TextFile_c767
        
        
        'Write out c767 to InputFile
                        
            'Write c767 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c767
    
        
            'Write out c767 arguments to input file
            If Sheets("4 - Calibration Parameters").Range("T4").Value = 2 Then
                ReDim Cs(nsims) As Double
                Dim Cs_txt As String
                For n = 1 To nsims
                    Cs(n) = Sheets("4 - Calibration Parameters").Range("D18").Value + (Rnd * (Sheets("4 - Calibration Parameters").Range("G18").Value - Sheets("4 - Calibration Parameters").Range("D18").Value))
                    If n = 1 Then
                        Cs_txt = CStr(Round(Cs(n), 3))
                    Else
                        Cs_txt = Cs_txt & Chr(9) & CStr(Round(Cs(n), 5))
                    End If
                Next
                Print #TextFile_Inp, "1" & Chr(9) & Cs_txt
            
                                        
                'Save & Close Text File
                Close TextFile_Inp
                    
                'Write out a separate text file with just k values
                Dim TextFile_WQPars2 As Integer
                Dim FilePath_WQPars2 As String
                TextFile_WQPars2 = FreeFile
                FilePath_WQPars2 = wd_path & "\SUSTAIN\Output\WQPars.txt"

                Open FilePath_WQPars2 For Output As TextFile_WQPars2
                Print #TextFile_WQPars2, k1s_txt
                Print #TextFile_WQPars2, Cs_txt
                Close TextFile_WQPars2
            
            
            End If
    
            'Save & Close Text File
            Close TextFile_Inp
            
    '----------------------------------------------------------------
    'c770: BMP Underdrain Pollutant Percent Removal --- EDITS TBD.....
        
        'Read in c770
            'Establish c770 file integer and file path
            Dim TextFile_c770 As Integer
            Dim FilePath_c770 As String
            TextFile_c770 = FreeFile
            FilePath_c770 = card_path & "\c770.txt"


            'Open the card header for read-in
            Open FilePath_c770 For Input As TextFile_c770

            'Store file content inside a variable
            FileContent_c770 = Input(LOF(TextFile_c770), TextFile_c770)
            Close TextFile_c770
        
        
        'Write out c770 to InputFile
                        
            'Write c770 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c770
    
        
            'Write out c770 arguments to input file
            
            ' INSERT
            ' CODE
            ' HERE
            
            
            'Save & Close Text File
            Close TextFile_Inp
            
            
    '----------------------------------------------------------------
    'c790: Land to BMP Routing Network
        
        'Read in c790
            'Establish c790 file integer and file path
            Dim TextFile_c790 As Integer
            Dim FilePath_c790 As String
            TextFile_c790 = FreeFile
            FilePath_c790 = card_path & "\c790.txt"


            'Open the card header for read-in
            Open FilePath_c790 For Input As TextFile_c790

            'Store file content inside a variable
            FileContent_c790 = Input(LOF(TextFile_c790), TextFile_c790)
            Close TextFile_c790
        
        
        'Write out c790 to InputFile
                        
            'Write c790 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c790
    
        
            'Write out c790 arguments to input file
            Print #TextFile_Inp, "1" & Chr(9) & "1" & Chr(9) & "1" & Chr(9) & "1"
            
            'Save & Close Text File
            Close TextFile_Inp
            
            
            
    '----------------------------------------------------------------
    'c795: BMP Site Routing Network
        
        'Read in c795
            'Establish c795 file integer and file path
            Dim TextFile_c795 As Integer
            Dim FilePath_c795 As String
            TextFile_c795 = FreeFile
            FilePath_c795 = card_path & "\c795.txt"


            'Open the card header for read-in
            Open FilePath_c795 For Input As TextFile_c795

            'Store file content inside a variable
            FileContent_c795 = Input(LOF(TextFile_c795), TextFile_c795)
            Close TextFile_c795
        
        
        'Write out c795 to InputFile
                        
            'Write c795 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c795
    
        
            'Write out c795 arguments to input file
            Print #TextFile_Inp, "1" & Chr(9) & "1" & Chr(9) & "0"
            
            'Save & Close Text File
            Close TextFile_Inp
            
            
            
    '----------------------------------------------------------------
    'c800: Optimzation Controls
        
        'Read in c800
            'Establish c800 file integer and file path
            Dim TextFile_c800 As Integer
            Dim FilePath_c800 As String
            TextFile_c800 = FreeFile
            FilePath_c800 = card_path & "\c800.txt"


            'Open the card header for read-in
            Open FilePath_c800 For Input As TextFile_c800

            'Store file content inside a variable
            FileContent_c800 = Input(LOF(TextFile_c800), TextFile_c800)
            Close TextFile_c800
        
        
        'Write out c800 to InputFile
                        
            'Write c800 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c800
    
        
            'Write out c800 arguments to input file
            Print #TextFile_Inp, "0" & Chr(9) & "0" & Chr(9) & "-99" & Chr(9) & "-99" & Chr(9) & "-99"
            
            
            'Save & Close Text File
            Close TextFile_Inp
            
             
            
    '----------------------------------------------------------------
    'c815: Assessment Point and Evaluation Factor
        
        'Read in c815
            'Establish c815 file integer and file path
            Dim TextFile_c815 As Integer
            Dim FilePath_c815 As String
            TextFile_c815 = FreeFile
            FilePath_c815 = card_path & "\c815.txt"


            'Open the card header for read-in
            Open FilePath_c815 For Input As TextFile_c815

            'Store file content inside a variable
            FileContent_c815 = Input(LOF(TextFile_c815), TextFile_c815)
            Close TextFile_c815
        
        
        'Write out c815 to InputFile
                        
            'Write c815 header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_c815
    
        
            'Write out c815 arguments to input file
            Print #TextFile_Inp, "1" & Chr(9) & "1" & Chr(9) & "2" & Chr(9) & "-99" & Chr(9) & "-99" & Chr(9) & "3" & Chr(9) & "-99" & Chr(9) & "-99" & Chr(9) & "Dummy_AAC"
            
            'Save & Close Text File
            Close TextFile_Inp
            
            
    '----------------------------------------------------------------
    'cINFINTY: closing line
        
        'Read in cINFINITY
            'Establish cINFINITY file integer and file path
            Dim TextFile_cINFINITY As Integer
            Dim FilePath_cINFINITY As String
            TextFile_cINFINITY = FreeFile
            FilePath_cINFINITY = card_path & "\cINFINITY.txt"


            'Open the card header for read-in
            Open FilePath_cINFINITY For Input As TextFile_cINFINITY

            'Store file content inside a variable
            FileContent_cINFINITY = Input(LOF(TextFile_cINFINITY), TextFile_cINFINITY)
            Close TextFile_cINFINITY
        
        
        'Write out cINFINITY to InputFile
                        
            'Write cINFINITY header to input file
            Open FilePath_Inp For Append As TextFile_Inp
            Print #TextFile_Inp, FileContent_cINFINITY
            
            'Save & Close Text File
            Close TextFile_Inp
            
End Sub
