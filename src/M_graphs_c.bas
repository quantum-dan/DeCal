Function Graphs_c()


Dim wd_path, r_path As String
wd_path = ReturnWorkingDir()

CinDistributionFit = wd_path & "\plots\CinDistributionFit.pdf"

ActiveWorkbook.FollowHyperlink (CinDistributionFit)

End Function