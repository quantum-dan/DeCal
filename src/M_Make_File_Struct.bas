
Function Make_File_Struct()
    Dim fso As Object
    Dim fldrpath, sustain_path As String

    Set fso = CreateObject("scripting.filesystemobject")
    fldr_path = ReturnWorkingDir()
    sub_fldr_plot = fldr_path & "\plots"
    sub_fldr_dat = fldr_path & "\data"
    sustain_path = fldr_path & "\SUSTAIN"
    If Not fso.folderexists(fldr_path) Then
        fso.createFolder (fldr_path)
        fso.createFolder (sub_fldr_plot)
        fso.createFolder (sub_fldr_dat)
        fso.createFolder (sustain_path)
        fso.createFolder (sustain_path & "\Output")
        fso.createFolder (sustain_path & "\InputTSFiles")
    End If
End Function