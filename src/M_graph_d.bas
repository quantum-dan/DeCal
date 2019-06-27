Function Graphs_d()


Dim wd_path, r_path As String
wd_path = ReturnWorkingDir()


DurationDistributionFit = wd_path & "\plots\DurationDistributionFit.pdf"

ActiveWorkbook.FollowHyperlink (DurationDistributionFit)


End Function
