Function Graphs_i()


Dim wd_path, r_path As String
wd_path = ReturnWorkingDir()
InterArivalTimeDistributionFit = wd_path & "\plots\InterArrivalTimeDistributionFit.pdf"

ActiveWorkbook.FollowHyperlink (InterArivalTimeDistributionFit)


End Function