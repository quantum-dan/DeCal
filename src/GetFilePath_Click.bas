Function GetWorkingDir() As String
Dim fldr As FileDialog
Dim sItem As String
Set fldr = Application.FileDialog(msoFileDialogFolderPicker)
With fldr
    .Title = "Select Working Directory"
    .AllowMultiSelect = False
    .InitialFileName = ActiveWorkbook.path
    If .Show <> -1 Then GoTo NextCode
    sItem = .SelectedItems(1)
End With
NextCode:
GetWorkingDir = sItem
Set fldr = Nothing
End Function


Function GetRFile() As String
Dim fldr As FileDialog
Dim sItem As String
Set fldr = Application.FileDialog(msoFileDialogFilePicker)
With fldr
    .Title = "Select Rscript executable"
    .AllowMultiSelect = False
    .InitialFileName = ActiveWorkbook.path
    If .Show <> -1 Then GoTo NextCode
    sItem = .SelectedItems(1)
End With
NextCode:
GetRFile = sItem
Set fldr = Nothing
End Function

Function GetSUSTAINFile() As String
Dim fldr As FileDialog
Dim sItem As String
Set fldr = Application.FileDialog(msoFileDialogFilePicker)
With fldr
    .Title = "Select Rscript executable"
    .AllowMultiSelect = False
    .InitialFileName = ActiveWorkbook.path
    If .Show <> -1 Then GoTo NextCode
    sItem = .SelectedItems(1)
End With
NextCode:
GetSUSTAINFile = sItem
Set fldr = Nothing
End Function
