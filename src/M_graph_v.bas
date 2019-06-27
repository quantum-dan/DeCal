Function Graphs_v()


Dim wd_path, r_path As String
wd_path = ReturnWorkingDir()

VolumeDistributionFit = wd_path & "\plots\VolumeDistributionFit.pdf"

ActiveWorkbook.FollowHyperlink (VolumeDistributionFit)

End Function