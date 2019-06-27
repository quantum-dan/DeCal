Function GetChemDir() As String
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
GetChemDir = sItem
Set fldr = Nothing
End Function

