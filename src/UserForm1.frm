Option Explicit

Private newID As String                     ' Unique BMP ID.
Private BMPTYPE As String
Private DataLoad As Boolean                 ' Loads data from spreadsheet if (True).
Private LengthConstraint(3) As Double       ' Save properties of LENGTH decision variable.
Private DepthConstraint(3) As Double        ' Save properties of DEPTH decision variable.
Private WidthConstraint(3) As Double        '
Private WeirConstraint(3) As Double         '
Private NumUnitConstraint(3) As Double      'Save properties of Num Unit decision variable.
Private DecayRates() As String              ' Matrix of pollutant decay rates.
Private ConstantRates() As String           ' Matrix of pollutant K' value
Private ConstantCs() As String              ' Matrix of pollutant C* value
Private RemovalRates() As String            ' Matrix of underdrain removal rates.
Private ReleaseCurve(24) As Double          ' Matrix of hourly cistern release values (per capita).

Public Property Let SetBMPID(myVal As String)

    ' Sets the BMP ID value.
    ' An initialized BMP ID is used for editing an existing BMP.
    newID = myVal

End Property

Public Property Let SetDataLoad(myVal As String)

    ' Sets the BMP ID value.
    ' An initialized BMP ID is used for editing an existing BMP.
    DataLoad = myVal

End Property

Private Sub AnnualMaintenance_Change()
'If FileUtility.ValidateName(AnnualMaintenance.Value) And IsNumeric(AnnualMaintenance.Value) = True Then

'Else
 '   MsgBox "Please check that the value is a number and does not contain any other characters."
    
'End If
End Sub



 Private Sub CABMPType_Change()
 
 Select Case CABMPType.Value
 
    Case "DIFFICULT INSTALLATION IN HIGHLY URBAN SETTINGS"
        CAF.Value = "3"
        
    Case "NEW BMP IN DEVELOPED AREA"
        CAF.Value = "2"
        
    Case "NEW BMP IN PARTIALLY DEVELOPED AREA"
        CAF.Value = "1.5"
        
    Case "NEW BMP IN UNDEVELOPED AREA"
        CAF.Value = "1"
        
End Select



End Sub

Private Sub PopulateCABMPType()

           With CABMPType
    
        .AddItem "DIFFICULT INSTALLATION IN HIGHLY URBAN SETTINGS"
        .AddItem "NEW BMP IN DEVELOPED AREA"
        .AddItem "NEW BMP IN PARTIALLY DEVELOPED AREA"
        .AddItem "NEW BMP IN UNDEVELOPED AREA"
        
      End With
          
End Sub

Private Sub BMPDefaultCommand_Click()

Dim BMPindxrange As Range
Dim OB1 As Variant
Dim OB2 As Variant



    If cboBMPType = "BIORETENTION" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C5")
         txtOHeight.Value = BMPindxrange.Offset(0, 1)
         txtODiam.Value = BMPindxrange.Offset(0, 2)
             Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
   
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
        If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    End If
    
    If cboBMPType = "DRYPOND" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C6")
         txtOHeight.Value = BMPindxrange.Offset(0, 1)
         txtODiam.Value = BMPindxrange.Offset(0, 2)
            Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
    
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
        If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    End If
    
    If cboBMPType = "ENHANCEDBIORETENTION" Then
    Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C7")
    'txtOHeight.Value = BMPindxrange.Offset(0, 1)
    'txtODiam.Value = BMPindxrange.Offset(0, 2)
         Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
         If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    
    End If
    If cboBMPType = "INFILTRATIONBASIN" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C8")
         txtOHeight.Value = BMPindxrange.Offset(0, 1)
         txtODiam.Value = BMPindxrange.Offset(0, 2)
            Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
    
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
         If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    End If
    
     If cboBMPType = "INFILTRATIONCHAMBER" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C9")
        txtOHeight.Value = BMPindxrange.Offset(0, 1)
        txtODiam.Value = BMPindxrange.Offset(0, 2)
    
       Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                    optRWeir.Value = True
                 Else
                     optRWeir.Value = False
                 End If
            Set OB2 = BMPindxrange.Offset(0, 4)
            If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
    
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
         If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    
    
    End If
    
    If cboBMPType = "INFILTRATIONTRENCH" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C10")
        txtOHeight.Value = BMPindxrange.Offset(0, 1)
        txtODiam.Value = BMPindxrange.Offset(0, 2)
        Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
   
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
         If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    
    End If
       
     If cboBMPType = "POROUSPAVEMENT" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C11")
        txtOHeight.Value = BMPindxrange.Offset(0, 1)
        txtODiam.Value = BMPindxrange.Offset(0, 2)
        Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
        If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    
    End If
       
    If cboBMPType = "SANDFILTER" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C12")
        txtOHeight.Value = BMPindxrange.Offset(0, 1)
        txtODiam.Value = BMPindxrange.Offset(0, 2)
        Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
        If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    
    End If
    
    If cboBMPType = "SUBSURFACEGRAVELWETLAND" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C13")
         txtOHeight.Value = BMPindxrange.Offset(0, 1)
         txtODiam.Value = BMPindxrange.Offset(0, 2)
         Set OB1 = BMPindxrange.Offset(0, 3)
               If OB1 = "Yes" Then
                    optRWeir.Value = True
                 Else
                    optRWeir.Value = False
                End If
                Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                    optTWeir.Value = True
                Else
                    optTWeir.Value = False
                End If
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
         If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
    
    End If
    
    If cboBMPType = "WETPOND" Then
        Set BMPindxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C14")
         txtOHeight.Value = BMPindxrange.Offset(0, 1)
         txtODiam.Value = BMPindxrange.Offset(0, 2)
            Set OB1 = BMPindxrange.Offset(0, 3)
                If OB1 = "Yes" Then
                optRWeir.Value = True
             Else
                optRWeir.Value = False
            End If
            Set OB2 = BMPindxrange.Offset(0, 4)
                 If OB2 = "Yes" Then
                optTWeir.Value = True
            Else
                optTWeir.Value = False
            End If
    
        txtWeirHeight.Value = BMPindxrange.Offset(0, 5)
        txtWeirValue.Value = BMPindxrange.Offset(0, 6)
        txtSoilDepth.Value = BMPindxrange.Offset(0, 7)
        txtSoilPorosity.Value = BMPindxrange.Offset(0, 8)
        txtVegA.Value = BMPindxrange.Offset(0, 9)
        txtSoilInfilt.Value = BMPindxrange.Offset(0, 10)
         If BMPindxrange.Offset(0, 11) = "Yes" Then
            cbxUD.Value = True
        ElseIf BMPindxrange.Offset(0, 11) = "No" Then
            cbxUD.Value = False
        End If
        txtUDDepth.Value = BMPindxrange.Offset(0, 12)
        txtUDPorosity.Value = BMPindxrange.Offset(0, 13)
        txtUDInfilt.Value = BMPindxrange.Offset(0, 14)
        'txtChamberVolume.Value = BMPindxrange.Offset(0, 15)
        'txtChamberNo.Value = BMPindxrange.Offset(0, 16)
    
     End If
     
End Sub
Private Sub CAF_Change()
Dim costindx As Range
Dim BMPMatchRange As Range

Set costindx = ThisWorkbook.Worksheets("BMPDefaultCost").Range("D5")
Set BMPMatchRange = ThisWorkbook.Worksheets("BMPDefaultCost").Range("C4")
       Do While BMPMatchRange.Value <> ""
            If cboBMPType.Value = "POROUS PAVEMENT" Then
                Set BMPMatchRange = ThisWorkbook.Worksheets("BMPDefaultCost").Range("C11")
                txtTotalVolumeCost.Value = BMPMatchRange.Offset(0, 1).Value * CAF.Value
                AnnualMaintenance.Value = BMPMatchRange.Offset(0, 2).Value
                Exit Sub
            End If
            If cboBMPType.Value = BMPMatchRange.Value Then
                txtTotalVolumeCost.Value = BMPMatchRange.Offset(0, 1).Value * CAF.Value
                AnnualMaintenance.Value = BMPMatchRange.Offset(0, 2).Value
                Exit Sub
            End If
         Set BMPMatchRange = BMPMatchRange.Offset(1, 0)
       Loop

        
If FileUtility.ValidateName(CAF.Value) And IsNumeric(CAF.Value) = True Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If

End Sub

Private Sub Parameters_Explain_Click()
frmEquationParameters.Show

End Sub

Private Sub cboPorousPavement_Change()
Dim costindx As Range
Dim hourindx As Range

Set costindx = ThisWorkbook.Worksheets("BMPDefaultCost").Range("D5")
Set hourindx = ThisWorkbook.Worksheets("BMPDefaultCost").Range("E5")

If CAF.Value = "" Then
    CAF.Value = 1
End If

    Select Case cboPorousPavement
        Case "POROUS ASPHALT PAVEMENT"
            txtTotalVolumeCost.Value = costindx.Offset(6, 0).Value * CAF.Value
            AnnualMaintenance.Value = hourindx.Value
        Case "PERVIOUS CONCRETE"
            txtTotalVolumeCost.Value = costindx.Offset(7, 0).Value * CAF.Value
            AnnualMaintenance.Value = hourindx.Value
    End Select
End Sub

Private Sub cmdDefaultPollutants_Click()
Dim indxrange As Range
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim m As Integer
Dim n As Integer
Dim p As Integer
Dim q As Integer
Dim r As Integer



Set indxrange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C4")
Do While indxrange.Value <> ""
    If cboBMPType.Text = indxrange Then
        Exit Do
    Else
        Set indxrange = indxrange.Offset(1, 0)
    End If
Loop
    

 For i = 0 To lstDecayRates.ListCount - 1
        If lstDecayRates.List(i) = "TP" Then
            DecayRates(i) = indxrange.Offset(0, 17)
            Exit For
        End If
Next i

 For j = 0 To lstDecayRates.ListCount - 1
        If lstDecayRates.List(j) = "TN" Then
            DecayRates(j) = indxrange.Offset(0, 19)
            Exit For
        End If
Next j

For k = 0 To lstDecayRates.ListCount - 1
        If lstDecayRates.List(k) = "ZN" Then
            DecayRates(k) = indxrange.Offset(0, 21)
            Exit For
        End If
Next k

For m = 0 To lstDecayRates.ListCount - 1
        If lstDecayRates.List(m) = "TSS" Then
            DecayRates(m) = indxrange.Offset(0, 23)
            Exit For
        End If
Next m

For n = 0 To lstRemovalRates.ListCount - 1
        If lstRemovalRates.List(n) = "TP" Then
            RemovalRates(n) = indxrange.Offset(0, 18)
            Exit For
        End If
Next n

For p = 0 To lstRemovalRates.ListCount - 1
        If lstRemovalRates.List(p) = "TN" Then
            RemovalRates(p) = indxrange.Offset(0, 20)
            Exit For
        End If
Next p

For q = 0 To lstRemovalRates.ListCount - 1
        If lstRemovalRates.List(q) = "ZN" Then
            RemovalRates(q) = indxrange.Offset(0, 22)
            Exit For
        End If
Next q

For r = 0 To lstRemovalRates.ListCount - 1
        If lstRemovalRates.List(r) = "TSS" Then
            RemovalRates(r) = indxrange.Offset(0, 24)
            Exit For
        End If
Next r

lstDecayRates.ListIndex = 0
txtDecayRate.Value = indxrange.Offset(0, 17)
lstRemovalRates.ListIndex = 0
txtRemovalRate.Value = indxrange.Offset(0, 18)


End Sub



Private Sub cmdNumUnitConstraint_Click()
    Dim oneline As Variant
    Dim tmp() As String
    Dim x As frmNumDV
    Set x = New frmNumDV

    ' Load in default values.
    x.numSwitch.Value = NumUnitConstraint(0)
    x.txtMin.Value = NumUnitConstraint(1)
    x.txtMax.Value = NumUnitConstraint(2)
    x.txtStep.Value = NumUnitConstraint(3)

    ' Get value from form.
    oneline = x.GetVal
    
    ' If canceled, exit this subroutine.
    If Trim(oneline) = "" Then Exit Sub
    
    ' If contraitns set, save to form.
    If Len(oneline > 0) And (oneline <> "") Then
        tmp = Split(oneline, ",")
        NumUnitConstraint(0) = tmp(0)
        NumUnitConstraint(1) = tmp(1)
        NumUnitConstraint(2) = tmp(2)
        NumUnitConstraint(3) = tmp(3)
    End If
    

End Sub

Private Sub SpecifyBMP_Click()

    SelectedBMP = txtBMPName.Value
    SelectedJunction = cboSub.Value
    SelectedDSJunction = cboDSConnection.Value
    
    If SelectedJunction = "" Or SelectedDSJunction = "" Then
    
     MsgBox ("Please select BMP Location and/or Downstream Junction or BMP!")
            Exit Sub
    End If
    frmSpecifyBMP_DArea.Show
    
End Sub







Private Sub imgSubstrate_Click()

End Sub

Private Sub txtChamberNo_Change()
If FileUtility.ValidateName(txtChamberNo.Value) And IsNumeric(txtChamberNo.Value) = True Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtChamberVolume_Change()
If FileUtility.ValidateName(txtChamberVolume.Value) And IsNumeric(txtChamberVolume.Value) = True Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtODiam_Change()
If FileUtility.ValidateName(txtODiam.Value) And IsNumeric(txtODiam.Value) = True Then

    Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
    End If
End Sub

Private Sub txtOHeight_Change()
 If FileUtility.ValidateName(txtOHeight.Value) And IsNumeric(txtOHeight.Value) = True Then

    Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
    End If
End Sub

Private Sub txtReleaseOption_Change()
If FileUtility.ValidateName(txtReleaseOption.Value) And IsNumeric(txtReleaseOption.Value) = True Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtSoilDepth_Change()
If FileUtility.ValidateName(txtSoilDepth.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtSoilInfilt_Change()
If FileUtility.ValidateName(txtSoilInfilt.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtSoilPorosity_Change()
If FileUtility.ValidateName(txtSoilPorosity.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtTotalVolumeCost_Change()
If FileUtility.ValidateName(txtTotalVolumeCost.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtUDDepth_Change()
If FileUtility.ValidateName(txtUDDepth.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtUDInfilt_Change()
If FileUtility.ValidateName(txtUDInfilt.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtUDPorosity_Change()
If FileUtility.ValidateName(txtUDPorosity.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtVegA_Change()
If FileUtility.ValidateName(txtVegA.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtWeirHeight_Change()
If FileUtility.ValidateName(txtWeirHeight.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub txtWeirValue_Change()
If FileUtility.ValidateName(txtWeirValue.Value) Then

Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
End Sub

Private Sub UpdateEffectiveDepth_Click()
    Dim Du As Double
    Dim L As Double
    Dim W As Double
    Dim Vchamber As Double
 
    'Combined storage volume= Vchamber +(Du*L*W-Vchamber)*Vfrac
    'Effective storage depth= Combined storage volume/(L*W*Vfrac)
    Du = Val(txtUDDepth.Value)
    L = Val(txtBMPLength.Value)
    W = Val(txtBMPWidth.Value)
    Vchamber = Val(txtChamberVolume.Value) * Val(txtChamberNo.Value)
    If (Du * L * W - Vchamber) > 0 Then
    
        txtUDDepth.Value = (Vchamber + (Du * L * W - Vchamber) * Val(txtUDPorosity.Value)) / (L * W * Val(txtUDPorosity.Value))
        txtUDDepth.Value = Format(Val(txtUDDepth.Value), "#,##0.0")
    Else
        MsgBox ("Please check the volume of chamber or number of chambers, then update the effective depth again")
    End If
    
    
End Sub

''Yi Xu
''Modify to save the data
'Private Sub UserForm_Initialize()
'
'
'    Dim myID As String
'    Dim indxrange As Range
'    Dim PollutantOrderRange As Range
'
'    myID = ActiveSheet.Shapes(Application.Caller).Name
'
'    ' Insert a list of available BMPs.
'    Call PopulateBMPTypes
'    Call PopulateCABMPType
'
'
'    ' Gets pollutant definitions.
'    Call PopulateDefault_c765
'    Call PopulateDefault_c766
'    Call PopulateDefault_c767
'    Call PopulateDefault_c770
'
'    ' Check if this is a new BMP.
'    Set indxrange = ThisWorkbook.Worksheets("c725").Range("C5")
'    Set indxrange = Range(indxrange, indxrange.End(xlDown)).Find(myID)
'
'    If Not indxrange Is Nothing Then
'
'        ' Find BMP row and set as ActiveCell.
'        ' Read in BMP parameters.
'Set indxrange = ThisWorkbook.Worksheets("c725").Range("C5")
'            Call Read_c725_SurfaceDimensions(ThisWorkbook.Worksheets("c725").Range(indxrange.Address))
'            Call Read_c730_ReleaseControl(ThisWorkbook.Worksheets("c730").Range(indxrange.Address))
'            Call Read_c732_OrificeControl(ThisWorkbook.Worksheets("c732").Range(indxrange.Address))
'            Call Read_c733_WeirControl(ThisWorkbook.Worksheets("c733").Range(indxrange.Address))
'            'If BMPTYPE = "B" Then Call Read_c735_ClassBDimensions(ThisWorkbook.Worksheets("c735").Range(indxRange.Address))
'            Call Read_c740_SubstrateProperties(ThisWorkbook.Worksheets("c740").Range(indxrange.Address))
'            'Call Read_c745_GrowthIndex(ThisWorkbook.Worksheets("c745").Range(indxrange.Address))
'            Call Read_c765_DecayRate(ThisWorkbook.Worksheets("c765").Range(indxrange.Address))
'            Call Read_c766_ConstantRate(ThisWorkbook.Worksheets("c766").Range(indxrange.Address))
'            Call Read_c767_ConstantC(ThisWorkbook.Worksheets("c767").Range(indxrange.Address))
'            Call Read_c770_RemovalRate(ThisWorkbook.Worksheets("c770").Range(indxrange.Address))
'            Call Read_c805_Objectives(ThisWorkbook.Worksheets("c805").Range(indxrange.Address))
'            Call Read_c810_DecisionVariables(ThisWorkbook.Worksheets("c810").Range(indxrange.Address))
'            cboSub = indxrange.Offset(0, 1)
'            cboDSConnection = indxrange.Offset(0, 2)
'
'            If cboBMPType = "" Then
'                cboBMPType = "BIORETENTION"
'            End If
'
'    Else
'
'            Call PopulateDefault_c725
'            Call PopulateDefault_c730
'            Call PopulateDefault_c732
'            Call PopulateDefault_c733
'            'Call PopulateDecault_c735
'            Call PopulateDefault_c740
'            'Call PopulateDefault_c745
'            Call PopulateDefault_c810
'            Call PopulateDefault_c805
'            Call PopulateSubbasins
'
'            Call BMPDefaultCommand_Click
'
'            Set PollutantOrderRange = ThisWorkbook.Worksheets("c705").Range("D5")
'                If PollutantOrderRange = "TP" And PollutantOrderRange.Offset(1, 0) = "TN" And PollutantOrderRange.Offset(2, 0) = "ZN" And PollutantOrderRange.Offset(3, 0) = "TSS" Then
'                    Call cmdDefaultPollutants_Click
'                End If
'
'
'            'Call PopulateConnectivity
'
'
'    End If
'
'    txtBMPName.Enabled = True
'    Label92.Font.Size = 24
'    Label92.TextAlign = fmTextAlignCenter
'
'    ' Resets the data load flag.
'    DataLoad = False
'    txtBMPName.Enabled = False
'
'
'
'
'
'End Sub

Private Sub cboBMPType_Change()
    ' Modified by Yi Xu 2014-2015
    
    ' Set BMP type parameters and change screens.
    ' Add new BMPs for Region 1
Dim costindx As Range
Dim hourindx As Range
Dim x As Integer
Dim PollutantOrderRange As Range
Dim BMPMatchRange As Range


    Select Case cboBMPType.Value
        
        Case "BIORETENTION", "DRYPOND", "WETPOND", "INFILTRATIONTRENCH", "SANDFILTER", "INFILTRATIONBASIN"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            imgClassARainBarrel.Visible = False
            imgClassASurface.Visible = True
           ' imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = False
            
            txtOHeight.Enabled = True
            txtODiam.Enabled = True
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            lblMaxLength.Caption = "BMP Length (ft.)"
            lblMaxWidth.Caption = "BMP Width (ft.)"
            
            'cmdWidthConstraint.Visible = False
            BMPMultiPage.Pages(1).Enabled = True
            BMPMultiPage.Pages(2).Enabled = True
            

        Case "RAINBARREL"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            imgClassARainBarrel.Visible = True
            imgClassASurface.Visible = False
         '   imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = False
            
            txtOHeight.Enabled = True
            txtODiam.Enabled = True
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            lblMaxLength.Caption = "Maximum Diameter (ft.)"
            lblMaxWidth.Caption = "Number of Units"
            
            'cmdWidthConstraint.Visible = True
            BMPMultiPage.Pages(1).Enabled = False
            BMPMultiPage.Pages(2).Enabled = False
            

        Case "CISTERN"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            imgClassARainBarrel.Visible = True
            imgClassASurface.Visible = False
        '    imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = False
            
            txtOHeight.Enabled = True
            txtODiam.Enabled = True
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            lblMaxLength.Caption = "Maximum Diameter (ft.)"
            lblMaxWidth.Caption = "Number of Units"
            
           ' cmdWidthConstraint.Visible = True
            BMPMultiPage.Pages(1).Enabled = False
            BMPMultiPage.Pages(2).Enabled = False
            

     '   Case "GREENROOF"
        '    BMPTYPE = "A"
        '    fmClassA.Visible = True
        '    fmClassB.Visible = False
        '    fmReleaseOptions.Visible = False
        '    imgClassARainBarrel.Visible = False
        '    imgClassASurface.Visible = False
        '    imgClassAGreenRoof.Visible = True
        '    imgClassAPorousPavement.Visible = False
        '    imgHydroSeperator.Visible = False
            
        '    imgSubsurfaceGravelWetland.Visible = False
        '    imgEnhancedBioretention.Visible = False
        '    imgInfiltrationChamber.Visible = False
            
        '    txtOHeight.Enabled = True
        '    txtODiam.Enabled = True
        '    optRWeir.Enabled = True
        '    optTWeir.Enabled = True
        '    txtWeirHeight.Enabled = True
        '    txtWeirValue.Enabled = True
        '    txtSoilInfilt.Enabled = True
        '    txtSoilPorosity.Enabled = True
        '    txtVegA.Enabled = True
            
        '    txtChamberVolume.Visible = False
        '    txtChamberNo.Visible = False
        '    labChamberStorageVolume.Visible = False
        '    labNumChamber.Visible = False
        '    UpdateEffectiveDepth.Enabled = False
            
        '    lblMaxLength.Caption = "BMP Length (ft.)"
        '    lblMaxWidth.Caption = "BMP Width (ft.)"
        '
        '  '  cmdWidthConstraint.Visible = False
        '    BMPMultiPage.Pages(1).Enabled = True
        '    BMPMultiPage.Pages(2).Enabled = True
        '

        Case "POROUSPAVEMENT"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            imgClassARainBarrel.Visible = False
            imgClassASurface.Visible = False
         '   imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = True
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = False
            
            txtOHeight.Enabled = True
            txtODiam.Enabled = True
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            
            lblMaxLength.Caption = "BMP Length (ft.)"
            lblMaxWidth.Caption = "BMP Width (ft.)"
            
           ' cmdWidthConstraint.Visible = False
            BMPMultiPage.Pages(1).Enabled = True
            BMPMultiPage.Pages(2).Enabled = True
            
            
            

        Case "HYDRODYNAMICSEPERATOR"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            imgClassARainBarrel.Visible = False
            imgClassASurface.Visible = False
        '    imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = True
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = False
            
            txtOHeight.Enabled = True
            txtODiam.Enabled = True
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            
            lblMaxLength.Caption = "Maximum Diameter (ft.)"
            lblMaxWidth.Caption = "Number of Units"
            
           ' cmdWidthConstraint.Visible = True
            BMPMultiPage.Pages(1).Enabled = False
            BMPMultiPage.Pages(2).Enabled = False
            
            
'        ' NOTE: Swale BMP still needs to get implemented.
'        Case "SWALE"
'            BMPTYPE = "B"
'            fmClassA.Visible = False
'            fmClassB.Visible = True
'            fmReleaseOptions.Visible = False
            
            
        ' Add new four BMPs for Region 1
        ' Yi Xu, 2015
        
        Case "SUBSURFACEGRAVELWETLAND"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            
            imgClassARainBarrel.Visible = False
            
            imgClassASurface.Visible = False
          '  imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = True
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = False
            
        
            txtOHeight.Enabled = False
            txtODiam.Enabled = False
            
            lblWeirValue.Caption = "Draining time (hr)"
            Label40.Caption = "Ponding Depth (ft)"
            optRWeir.Enabled = False
            optTWeir.Enabled = False
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            lblMaxLength.Caption = "BMP Length (ft.)"
            lblMaxWidth.Caption = "BMP Width (ft.)"
            
            'cmdWidthConstraint.Visible = False
            BMPMultiPage.Pages(1).Enabled = True
            BMPMultiPage.Pages(2).Enabled = True
            
            
        Case "ENHANCEDBIORETENTION"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            
            imgClassARainBarrel.Visible = False
            
            imgClassASurface.Visible = False
           ' imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = True
            imgInfiltrationChamber.Visible = False
            
            txtOHeight.Enabled = False
            txtODiam.Enabled = False
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = False
            txtChamberNo.Visible = False
            labChamberStorageVolume.Visible = False
            labNumChamber.Visible = False
            UpdateEffectiveDepth.Enabled = False
            
            
            lblMaxLength.Caption = "BMP Length (ft.)"
            lblMaxWidth.Caption = "BMP Width (ft.)"
            
            'cmdWidthConstraint.Visible = False
            BMPMultiPage.Pages(1).Enabled = True
            BMPMultiPage.Pages(2).Enabled = True
            
            
        Case "INFILTRATIONCHAMBER"
            BMPTYPE = "A"
            fmClassA.Visible = True
            fmClassB.Visible = False
            
            imgClassARainBarrel.Visible = False
            
            imgClassASurface.Visible = False
          '  imgClassAGreenRoof.Visible = False
            imgClassAPorousPavement.Visible = False
            imgHydroSeperator.Visible = False
            
            imgSubsurfaceGravelWetland.Visible = False
            imgEnhancedBioretention.Visible = False
            imgInfiltrationChamber.Visible = True
            
            txtOHeight.Enabled = True
            txtODiam.Enabled = True
            optRWeir.Enabled = True
            optTWeir.Enabled = True
            txtWeirHeight.Enabled = True
            txtWeirValue.Enabled = True
            txtSoilInfilt.Enabled = True
            txtSoilPorosity.Enabled = True
            txtVegA.Enabled = True
            
            txtChamberVolume.Visible = True
            txtChamberNo.Visible = True
            labChamberStorageVolume.Visible = True
            labNumChamber.Visible = True
            txtChamberVolume.Enabled = True
            txtChamberNo.Enabled = True
            UpdateEffectiveDepth.Enabled = True
            

            lblMaxLength.Caption = "BMP Length (ft.)"
            lblMaxWidth.Caption = "BMP Width (ft.)"
            
            'cmdWidthConstraint.Visible = False
            BMPMultiPage.Pages(1).Enabled = True
            BMPMultiPage.Pages(2).Enabled = True
            
        
    End Select
    

    

       
        
End Sub
Private Sub PopulatePorousPavement()
    cboPorousPavement.Clear
    
    With cboPorousPavement
        .AddItem "POROUS ASPHALT PAVEMENT"
        .AddItem "PERVIOUS CONCRETE"
    End With

End Sub
Private Sub optRWeir_Click()

    If optRWeir.Value = True Then
        lblWeirValue.Caption = "Crest Width (B, ft)"
    End If
    
End Sub

Private Sub optTWeir_Click()

    If optTWeir.Value = True Then
        lblWeirValue.Caption = "Vertex Angle (Theta, degrees)"
    End If
    
End Sub

Private Sub lstDecayRates_Change()

    ' Get the item indx.
    Dim indx As Integer
    indx = lstDecayRates.ListIndex

    ' Update selected decay rate on form.
    txtDecayRate.Value = DecayRates(indx)

End Sub


Private Sub lstRemovalRates_Change()
    
    ' Get the item indx.
    Dim indx As Integer
    indx = lstRemovalRates.ListIndex
    
    ' Updated selected removal rate on form.
    txtRemovalRate.Value = RemovalRates(indx)
    
End Sub

Private Sub txtDecayRate_AfterUpdate()

    ' Get the item indx.
    Dim indx As Integer
    indx = lstDecayRates.ListIndex
    
    ' Save the new decay rate.
    DecayRates(indx) = txtDecayRate.Value
    
    If FileUtility.ValidateName(txtDecayRate.Value) And IsNumeric(txtDecayRate.Value) = True Then

    Else
    MsgBox "Please check that the value is a number and does not contain any other characters."
    
End If
    
End Sub

Private Sub txtConstantRate_AfterUpdate()

    ' Get the item indx.
    Dim indx As Integer
    'indx = lstConstantRates.ListIndex
    
    ' Save the new constant K.
    'ConstantRates(indx) = txtConstantRate.Value
End Sub

Private Sub txtConstantC_AfterUpdate()
    ' Get the item indx.
    Dim indx As Integer
    'indx = lstConstantCs.ListIndex
    
    ' Save the new constant C.
    'ConstantCs(indx) = txtConstantC.Value
    
End Sub

Private Sub txtRemovalRate_AfterUpdate()

    ' Get the item indx.
    Dim indx As Integer
    indx = lstRemovalRates.ListIndex
    
    ' Save the new decay rate.
    RemovalRates(indx) = txtRemovalRate.Value
    
    
    If FileUtility.ValidateName(txtRemovalRate.Value) And IsNumeric(txtRemovalRate.Value) = True Then

    Else
        MsgBox "Please check that the value is a number and does not contain any other characters."
    
    End If
End Sub

Private Sub cmdCancel_Click()
    Unload Me
End Sub



Private Sub cmdReleaseCurve_Click()

    Dim x As Integer
    Dim FormStatus As Boolean
    Dim myForm As frmReleaseCurve
    Set myForm = New frmReleaseCurve

    ' Load in the existing values.
    For x = 1 To 24
        FormStatus = myForm.SetReleaseCurve(x, ReleaseCurve(x))
    Next x
    
    ' Show the form.
    myForm.Show
    
    ' Save the new values.
    For x = 1 To 24
        ReleaseCurve(x) = myForm.GetReleaseCurve(x)
    Next x
    
End Sub

Private Sub cmdLengthConstraint_Click()

    Dim oneline As Variant
    Dim tmp() As String
    Dim x As frmConstraints
    Set x = New frmConstraints

    ' Load in default values.
    x.cbxSwitch.Value = LengthConstraint(0)
    x.txtMin.Value = LengthConstraint(1)
    x.txtMax.Value = LengthConstraint(2)
    x.txtStep.Value = LengthConstraint(3)

    ' Get value from form.
    oneline = x.GetVal
    
    ' If canceled, exit this subroutine.
    If Trim(oneline) = "" Then Exit Sub
    
    ' If contraitns set, save to form.
    If Len(oneline > 0) And (oneline <> "") Then
        tmp = Split(oneline, ",")
        LengthConstraint(0) = tmp(0)
        LengthConstraint(1) = tmp(1)
        LengthConstraint(2) = tmp(2)
        LengthConstraint(3) = tmp(3)
    End If
    
    ' Write the max length to the form.
    If LengthConstraint(0) > 0 Then
        txtBMPLength.Value = tmp(2)
    End If
    
End Sub

Private Sub cmdDepthConstraint_Click()

    Dim tmp() As String
    Dim x As frmConstraints
    Set x = New frmConstraints

    ' Load in default values.
    x.cbxSwitch.Value = DepthConstraint(0)
    x.txtMin.Value = DepthConstraint(1)
    x.txtMax.Value = DepthConstraint(2)
    x.txtStep.Value = DepthConstraint(3)

    ' Get value from form.
    oneline = x.GetVal
    
    ' If canceled then exit subroutine.
    If Trim(oneline) = "" Then Exit Sub
    
    ' If contraitns set, save to form.
    If Len(oneline > 0) And (oneline <> "") Then
        tmp = Split(oneline, ",")
        DepthConstraint(0) = tmp(0)
        DepthConstraint(1) = tmp(1)
        DepthConstraint(2) = tmp(2)
        DepthConstraint(3) = tmp(3)
    End If
    
    ' Write the max depth to the form.
    If DepthConstraint(0) > 0 Then
        txtSoilDepth.Value = tmp(2)
    End If
    
End Sub

Private Sub cmdWidthConstraint_Click()

    Dim tmp() As String
    Dim x As frmConstraints
    Set x = New frmConstraints

    ' Load in default values.
    x.cbxSwitch.Value = WidthConstraint(0)
    x.txtMin.Value = WidthConstraint(1)
    x.txtMax.Value = WidthConstraint(2)
    x.txtStep.Value = WidthConstraint(3)

    ' Get value from form.
    oneline = x.GetVal
    
    ' If canceled then exit subroutine.
    If Trim(oneline) = "" Then Exit Sub
    
    ' If contraitns set, save to form.
    If Len(oneline > 0) And (oneline <> "") Then
        tmp = Split(oneline, ",")
        WidthConstraint(0) = tmp(0)
        WidthConstraint(1) = tmp(1)
        WidthConstraint(2) = tmp(2)
        WidthConstraint(3) = tmp(3)
    End If
    
    ' Write the max depth to the form.
    If WidthConstraint(0) > 0 Then
        txtBMPWidth.Value = tmp(2)
    End If
    
End Sub

Private Sub cmdWeirConstraint_Click()
    Dim tmp() As String
    Dim x As frmConstraints
    Set x = New frmConstraints

    ' Load in default values.
    x.cbxSwitch.Value = WeirConstraint(0)
    x.txtMin.Value = WeirConstraint(1)
    x.txtMax.Value = WeirConstraint(2)
    x.txtStep.Value = WeirConstraint(3)

    ' Get value from form.
    oneline = x.GetVal
    
    ' If canceled then exit subroutine.
    If Trim(oneline) = "" Then Exit Sub
    
    ' If contraitns set, save to form.
    If Len(oneline > 0) And (oneline <> "") Then
        tmp = Split(oneline, ",")
        WeirConstraint(0) = tmp(0)
        WeirConstraint(1) = tmp(1)
        WeirConstraint(2) = tmp(2)
        WeirConstraint(3) = tmp(3)
    End If
    
    ' Write the max depth to the form.
    If WeirConstraint(0) > 0 Then
        txtWeirHeight.Value = tmp(2)
    End If
End Sub

Function GenerateNewID() As Boolean
   
    ' Initialize function to true.
    GenerateNewID = True
    
    ' Make sure a BMP name was entered.
    If txtBMPName.Value = "" Then
        MsgBox ("Please enter a BMP name!")
        GenerateNewID = False
        Exit Function
    End If
    
    ' Make sure a BMP name does not contain any spaces.
    If InStr(txtBMPName.Value, " ") > 0 Then
        MsgBox ("BMP name cannot contain any spaces!")
        GenerateNewID = False
        Exit Function
    End If
    
End Function

Private Sub PopulateBMPTypes()

    ' Populate a list of available BMPs.
    With cboBMPType
    'type A
        .AddItem "BIORETENTION"
        '.AddItem "CISTERN"
        'type C
        '.AddItem "Conduit"
        .AddItem "DRYPOND"
        .AddItem "ENHANCEDBIORETENTION"
        ' .AddItem "GREENROOF"
        '.AddItem "HYDRODYNAMICSEPERATOR"
        .AddItem "INFILTRATIONBASIN"
        .AddItem "INFILTRATIONCHAMBER"
        'type X
        '.AddItem "Junction"
         .AddItem "INFILTRATIONTRENCH"
         .AddItem "POROUSPAVEMENT"
        '.AddItem "RAINBARREL"
        .AddItem "SANDFILTER"
        .AddItem "SUBSURFACEGRAVELWETLAND"
        '.AddItem "SWALE"
        .AddItem "WETPOND"
     
    End With

End Sub




Private Sub cboSub_Change()

    Dim bmpRange As Range
    Dim subRange As Range
    Dim x As Integer
    
    ' Add the selected subbasin.
   ' cboDSConnection.Clear
    'cboDSConnection.AddItem cboSub.Value
    
    ' Add list of BMPs within the selected subbasin.
    
    'X = 0
    'Set bmpRange = ThisWorkbook.Worksheets("c725").Range("C5")
    'While bmpRange.Offset(X, 0).Value <> ""
        'If bmpRange.Offset(X, 1).Value = cboSub.Value Then
            'cboDSConnection.AddItem bmpRange.Offset(X, 0).Value
            
        'End If
        'X = X + 1
    'Wend
    
    Dim Xlshapes As Shape
    Dim i As Integer
    
   cboDSConnection.Clear
   
      
    For Each Xlshapes In ActiveSheet.Shapes
        If Left(Xlshapes.name, 8) = "Junction" Or Left(Xlshapes.name, 3) = "BMP" Then
        
            If Xlshapes.name <> txtBMPName.Value Then
                cboDSConnection.AddItem Xlshapes.name
            End If
            
        End If
    Next
    
  
        
    
End Sub

Private Sub Write_c725_SurfaceDimensions(newID As String, indxrange As Range)

    ' Write general BMP information.
    ' NOTE: Not specifically used in Card 725.
    Dim ETRange As Range
    
    'indxRange.Value = newID
    indxrange.Value = txtBMPName.Value
    indxrange.Offset(0, 1).Value = cboSub.Value
    indxrange.Offset(0, 2).Value = cboDSConnection.Value
    If indxrange.Offset(0, 3).Value = "" Then
        indxrange.Offset(0, 3).Value = "0"
    End If
    
    'indxrange.Offset(0, 3).Value = txtDrainageArea.Value
   ' indxrange.Offset(0, 3).Value = BMP_Drainage_Area
    indxrange.Offset(0, 4).Value = cboBMPType.Value
    
    ' Write general release information.
    indxrange.Offset(0, 5).Value = txtBMPWidth.Value
    If True Then
        indxrange.Offset(0, 6).Value = txtBMPLength.Value
    Else
        indxrange.Offset(0, 6).Value = txtBMPLength.Value
    End If
    
    ' Set the release options (People / Dry Days).
    Select Case cboBMPType.Value
        Case "RAINBARREL"
            indxrange.Offset(0, 7).Value = 2
            indxrange.Offset(0, 8).Value = "0"
            indxrange.Offset(0, 9).Value = txtReleaseOption.Value
        Case "CISTERN"
            indxrange.Offset(0, 7).Value = 1
            indxrange.Offset(0, 8).Value = txtReleaseOption.Value
            indxrange.Offset(0, 9).Value = "0"
        Case Else
            indxrange.Offset(0, 7).Value = 3
            indxrange.Offset(0, 8).Value = "0"
            indxrange.Offset(0, 9).Value = "0"
    End Select
    
    ' Number of orifices and weirs limited to 1.
    Select Case cboBMPType.Value
        Case "HYDRODYNAMICSEPERATOR"
            indxrange.Offset(0, 10).Value = "0"
            indxrange.Offset(0, 11).Value = "0"
        Case Else
            indxrange.Offset(0, 10).Value = "1"
            indxrange.Offset(0, 11).Value = "1"
    End Select
    
    'Update for the latest version of SUSTAIN
    'Yi Xu
    
    
    Set ETRange = ThisWorkbook.Worksheets("BMPDefaultParameters").Range("C4")
    Do While ETRange <> ""
        If ETRange.Value = cboBMPType.Value Then
            indxrange.Offset(0, 12).Value = ETRange.Offset(0, 25)
        End If
    Set ETRange = ETRange.Offset(1, 0)
    Loop
    
    indxrange.Offset(0, 13).Value = 0
    indxrange.Offset(0, 14).Value = 0
    indxrange.Offset(0, 15).Value = 0
    indxrange.Offset(0, 16).Value = "no_curve"
    'indxrange.Offset(0, 17).Value = BMPLandUse
    

End Sub

Private Sub Write_c725a_SurfaceDimensions(newID As String, indxrange As Range)

Dim Num_Landuses As Integer
Dim indxlutext, indxluc725a As Range
Dim x As Integer
Dim lutext As String
    ' Write general BMP land use information.
    ' NOTE: Not specifically used in Card 725.
    
    'indxRange.Value = newID
    indxrange.Value = txtBMPName.Value
    indxrange.Offset(0, 1).Value = cboSub.Value
    indxrange.Offset(0, 2).Value = cboDSConnection.Value
    
    If indxrange.Offset(0, 3).Value = "" Then
        indxrange.Offset(0, 3).Value = "0"
    End If
    
    If indxrange.Offset(0, 3).Value = "0" Then
    
    'indxrange.Offset(0, 3).Value = txtDrainageArea.Value
   ' indxrange.Offset(0, 3).Value = BMP_Drainage_Area
    
    Num_Landuses = ThisWorkbook.Worksheets("Watershed Sketch").Range("NumLanduses")
    Dim i As Integer
    For i = 0 To (Num_Landuses - 1)
        indxrange.Offset(0, i + 4).Value = 0
    Next i
    
     
        
        Set indxlutext = ThisWorkbook.Worksheets("SubbasinInput").Range("F4")
        Set indxluc725a = ThisWorkbook.Worksheets("c725a").Range("F4")
    
    
        If Num_Landuses > 0 Then
           For x = 1 To Num_Landuses
                lutext = indxlutext.Offset(0, x)
                indxluc725a.Offset(0, x) = lutext
                     
           Next x
        End If
            
   
   End If
   
    
End Sub

Private Sub Write_c730_ReleaseControl(newID As String, indxrange As Range)

Dim y As Integer

    ' Write the current release curve.
    ' Default value of (0) for non-cistern BMPs.
    indxrange.Value = newID
    For y = 1 To 24
        indxrange.Offset(0, y).Value = ReleaseCurve(y)
    Next y
    
End Sub

Private Sub Write_c732_OrificeControl(newID As String, indxrange As Range)

    ' Write BMP ID.
    indxrange.Value = newID
    
    ' SerialID will populate during input file generation.
    Select Case cboBMPType.Value
        Case "HYDRODYNAMICSEPERATOR"
            indxrange.Offset(0, 1).Value = "0"
        Case Else
            indxrange.Offset(0, 1).Value = "1"
    End Select
    
    ' Hard coded values for compatability with BMPDSS_v1.
    indxrange.Offset(0, 2).Value = "Orif1"
    indxrange.Offset(0, 3).Value = "Circular"
    indxrange.Offset(0, 4).Value = "Vertical"
    
    ' Exit type discharge coefficients.
    If OptionButton1.Value = True Then indxrange.Offset(0, 5).Value = 1
    If OptionButton2.Value = True Then indxrange.Offset(0, 5).Value = 0.61
    If OptionButton3.Value = True Then indxrange.Offset(0, 5).Value = 0.5
    
    ' Dimensional information.
    indxrange.Offset(0, 6).Value = txtOHeight.Value
    indxrange.Offset(0, 7).Value = txtODiam.Value
    
    ' Hard coded values for compatability with BMPDSS_v1.
    indxrange.Offset(0, 8).Value = "0"
    indxrange.Offset(0, 9).Value = "0"
    indxrange.Offset(0, 10).Value = "1"
    indxrange.Offset(0, 11).Value = "1"
    indxrange.Offset(0, 12).Value = "0"
    
End Sub

Private Sub Write_c733_WeirControl(newID As String, indxrange As Range)
    
    ' Write BMP ID.
    indxrange.Value = newID
    
    ' SerialID will populate during input file generation.
    Select Case cboBMPType.Value
        Case "HYDRODYNAMICSEPERATOR"
            indxrange.Offset(0, 1).Value = "0"
        Case Else
            indxrange.Offset(0, 1).Value = "1"
    End Select
    
    '
    indxrange.Offset(0, 2).Value = "Weir1"
    
    ' Write weir dimensional information.
    indxrange.Offset(0, 4).Value = txtWeirHeight.Value
    If optRWeir.Value = True Then
        indxrange.Offset(0, 3).Value = "Rectangular"
        If cboBMPType.Value = "SUBSURFACEGRAVELWETLAND" Then
            indxrange.Offset(0, 5).Value = 100
            indxrange.Offset(0, 10).Value = txtWeirValue.Value
        Else
            indxrange.Offset(0, 5).Value = txtWeirValue.Value
        End If
        indxrange.Offset(0, 6).Value = "0"
    Else
        indxrange.Offset(0, 3).Value = "Triangular"
        indxrange.Offset(0, 5).Value = "0"
        indxrange.Offset(0, 6).Value = txtWeirValue.Value
    End If

    ' Hard coded values for compatability with BMPDSS_v1.
    indxrange.Offset(0, 7).Value = "1"
    indxrange.Offset(0, 8).Value = "1"
    indxrange.Offset(0, 9).Value = "0"

End Sub

Public Sub Write_c740_SubstrateProperties(newID As String, indxrange As Range)

    indxrange.Value = newID
    
    ' Infiltration method hard-coded as Holton=2.
    indxrange.Offset(0, 1).Value = 2
    indxrange.Offset(0, 2).Value = txtSoilDepth.Value
    'indxrange.Offset(0, 3).Value = txtSoilPorosity.Value
    
    ' Values hard-coded for compatability with BMPDSS_v2.
    ' These parameters are for the Green-Ampt method.
    indxrange.Offset(0, 4).Value = 0.25
    indxrange.Offset(0, 5).Value = 0.1
    'indxRange.Offset(0, 6).Value = 0  'Remove the default Evap which is to be 0. It can be modified in the input file
    'indxRange.Offset(0, 7).Value = 0  'Remove the default ETRate which is to be 0. It can be modified iin the input file
    'indxrange.Offset(0, 6).Value = txtPollutantRouting.Value
    'indxrange.Offset(0, 7).Value = txtPollutantRemoval.Value
    indxrange.Offset(0, 6).Value = 1
    indxrange.Offset(0, 7).Value = 0
    
    ' Remaining soil parameters.
    indxrange.Offset(0, 8).Value = txtVegA.Value
    'indxrange.Offset(0, 9).Value = txtSoilInfilt.Value
    
    If cboBMPType.Value = "INFILTRATIONCHAMBER" Then
        indxrange.Offset(0, 3).Value = 0   'soil porosity
    Else
        indxrange.Offset(0, 3).Value = txtSoilPorosity.Value   'soil porosity
    End If
    
    If cboBMPType.Value = "SUBSURFACEGRAVELWETLAND" Then
        If txtWeirValue.Value <> 0 Then
             indxrange.Offset(0, 3).Value = txtSoilPorosity.Value   'soil porosity
             indxrange.Offset(0, 9).Value = Val(txtWeirHeight.Value) * 12 / Val(txtWeirValue.Value)    'infiltration rate in/hr
             
        Else
            MsgBox ("Please enter draining time!")

        End If
    Else
        indxrange.Offset(0, 3).Value = txtSoilPorosity.Value   'soil porosity
        indxrange.Offset(0, 9).Value = txtSoilInfilt.Value   'Soil infiltration rate
        
    End If
    
    ' If statement handles underdrain switch parameter.
    
    indxrange.Offset(0, 11).Value = txtUDDepth.Value
    indxrange.Offset(0, 12).Value = txtUDPorosity.Value
    indxrange.Offset(0, 13).Value = txtUDInfilt.Value
    If cbxUD.Value = True Then
        indxrange.Offset(0, 10).Value = 1
    Else
        indxrange.Offset(0, 10).Value = 0
    End If

    ' Values hard-coded for compatability with BMPDSS_v2.
    ' These parameters are for the Green-Ampt method.
    indxrange.Offset(0, 14).Value = 3
    indxrange.Offset(0, 15).Value = 4
    indxrange.Offset(0, 16).Value = 7
    indxrange.Offset(0, 17).Value = 0
    indxrange.Offset(0, 18).Value = 0
    indxrange.Offset(0, 19).Value = 0

End Sub

Private Sub Write_c745_GrowthIndex(newID As String, indxrange As Range)

    indxrange.Value = newID
    indxrange.Offset(0, 1).Value = 0.2
    indxrange.Offset(0, 2).Value = 0.2
    indxrange.Offset(0, 3).Value = 0.2
    indxrange.Offset(0, 4).Value = 0.2
    indxrange.Offset(0, 5).Value = 0.2
    indxrange.Offset(0, 6).Value = 0.2
    indxrange.Offset(0, 7).Value = 0.2
    indxrange.Offset(0, 8).Value = 0.2
    indxrange.Offset(0, 9).Value = 0.2
    indxrange.Offset(0, 10).Value = 0.2
    indxrange.Offset(0, 11).Value = 0.2
    indxrange.Offset(0, 12).Value = 0.2

End Sub

Private Sub Write_c747_SoilInitialization(newID As String, indxrange As Range)
    
    indxrange.Value = newID
    indxrange.Offset(0, 1).Value = 0
    indxrange.Offset(0, 2).Value = 0.15
    
    
End Sub

Private Sub Write_c765_DecayRate(newID As String, indxrange As Range)

    'indxRange.Offset(0, 1).Value = txtTSSDecay.Value
    'indxRange.Offset(0, 2).Value = txtBODDecay.Value
    'indxRange.Offset(0, 3).Value = txtTNDecay.Value
    'indxRange.Offset(0, 4).Value = txtTPDecay.Value
    'indxRange.Offset(0, 5).Value = txtZnDecay.Value
    
    Dim x As Integer
    
    indxrange.Value = newID
    For x = 0 To UBound(DecayRates)
        indxrange.Offset(0, x + 1).Value = DecayRates(x)
    Next x
    
End Sub

Private Sub Write_c766_ConstantRate(newID As String, indxrange As Range)

Dim x As Integer
    indxrange.Value = newID
    For x = 0 To UBound(ConstantRates)
        indxrange.Offset(0, x + 1).Value = ConstantRates(x)
    Next x
    
End Sub
Private Sub Write_c767_ConstantC(newID As String, indxrange As Range)
    indxrange.Value = newID
    Dim x As Integer
    
    For x = 0 To UBound(ConstantCs)
        indxrange.Offset(0, x + 1).Value = ConstantCs(x)
    Next x
End Sub

Private Sub Write_c770_RemovalRate(newID As String, indxrange As Range)

Dim x As Integer

    'indxRange.Offset(0, 1).Value = txtUDTSSRate.Value
    'indxRange.Offset(0, 2).Value = txtUDBODRate.Value
    'indxRange.Offset(0, 3).Value = txtUDTNRate.Value
    'indxRange.Offset(0, 4).Value = txtUDTPRate.Value
    'indxRange.Offset(0, 5).Value = txtUDZnRate.Value
    
    indxrange.Value = newID
    For x = 0 To UBound(RemovalRates)
        indxrange.Offset(0, x + 1).Value = RemovalRates(x)
    Next x

End Sub



Private Sub Write_c810_DecisionVariables(newID As String, indxrange As Range)

    indxrange.Value = newID
    
    ' LENGTH.
    indxrange.Offset(0, 1).Value = LengthConstraint(0)
    indxrange.Offset(0, 2).Value = LengthConstraint(1)
    indxrange.Offset(0, 3).Value = LengthConstraint(2)
    indxrange.Offset(0, 4).Value = LengthConstraint(3)
    
    'SOIL DEPTH.
    indxrange.Offset(0, 5).Value = DepthConstraint(0)
    indxrange.Offset(0, 6).Value = DepthConstraint(1)
    indxrange.Offset(0, 7).Value = DepthConstraint(2)
    indxrange.Offset(0, 8).Value = DepthConstraint(3)
    
    ' NUMUNIT.
    indxrange.Offset(0, 9).Value = NumUnitConstraint(0)
    indxrange.Offset(0, 10).Value = NumUnitConstraint(1)
    indxrange.Offset(0, 11).Value = NumUnitConstraint(2)
    indxrange.Offset(0, 12).Value = NumUnitConstraint(3)
    
    ' WEIR.
    indxrange.Offset(0, 13).Value = WeirConstraint(0)
    indxrange.Offset(0, 14).Value = WeirConstraint(1)
    indxrange.Offset(0, 15).Value = WeirConstraint(2)
    indxrange.Offset(0, 16).Value = WeirConstraint(3)
    
End Sub

Private Sub Write_c805_Objectives(newID As String, indxrange As Range)

    indxrange.Value = newID
    indxrange.Offset(0, 1).Value = txtLinearCost.Value
    indxrange.Offset(0, 2).Value = txtBMPLength.Value
    indxrange.Offset(0, 3).Value = txtAreaCost.Value
    'It doesn't matter if it is a circle, since the BMP area and total volume are not listed in the inputfile.
    'BMP area and total volume will be calculated in SUSTAIN.
    indxrange.Offset(0, 4).Value = Val(txtBMPLength.Value) * Val(txtBMPWidth.Value)
    indxrange.Offset(0, 24).Value = txtTotalVolumeCost.Value
    indxrange.Offset(0, 6).Value = Val(txtBMPLength.Value) * Val(txtBMPWidth.Value) * (Val(txtWeirHeight.Value) + Val(txtSoilDepth.Value) + Val(txtUDDepth.Value))
    indxrange.Offset(0, 7).Value = txtMediaVolumeCost.Value
    indxrange.Offset(0, 8).Value = Val(txtBMPLength.Value) * Val(txtBMPWidth.Value) * Val(txtSoilDepth.Value)
    indxrange.Offset(0, 9).Value = txtUnderDrainVolumeCost.Value
    'indxrange.Offset(0, 10).Value = txtUnitCost.Value
    indxrange.Offset(0, 11).Value = txtConstantCost.Value
    indxrange.Offset(0, 12).Value = txtPercentCost.Value
    indxrange.Offset(0, 13).Value = txtLengthExp.Value
    indxrange.Offset(0, 14).Value = txtAreaExp.Value
    indxrange.Offset(0, 15).Value = txtTotalVolExp.Value
    indxrange.Offset(0, 16).Value = txtMediaVolExp.Value
    indxrange.Offset(0, 17).Value = txtUDVolExp.Value
    indxrange.Offset(0, 18).Value = CABMPType.Value
    indxrange.Offset(0, 19).Value = CAF.Value
    indxrange.Offset(0, 20).Value = AnnualMaintenance.Value
    ' BMP Depth (indxrange.offset(0,21)
    'Storage Depth and/or Effective Depth (indxrange.offset(0,22)
    
    If cbxUD.Value = True Then
        indxrange.Offset(0, 21) = Val(txtWeirHeight.Value) + Val(txtSoilDepth.Value) + Val(txtUDDepth.Value)
        indxrange.Offset(0, 22) = Val(txtWeirHeight.Value) + (Val(txtSoilDepth.Value) * Val(txtSoilPorosity.Value)) + (Val(txtUDDepth.Value) * Val(txtUDPorosity.Value))
    Else
         indxrange.Offset(0, 21) = Val(txtWeirHeight.Value) + Val(txtSoilDepth.Value)
         indxrange.Offset(0, 22) = Val(txtWeirHeight.Value) + (Val(txtSoilDepth.Value) * Val(txtSoilPorosity.Value))
    End If
    'Depth Ratio
    If indxrange.Offset(0, 21).Value > 0 Then
        indxrange.Offset(0, 23) = indxrange.Offset(0, 22).Value / indxrange.Offset(0, 21).Value
    Else
        indxrange.Offset(0, 23).Value = 0
    End If
    'New Cost
        indxrange.Offset(0, 5) = indxrange.Offset(0, 23).Value * txtTotalVolumeCost.Value
        
    If cboBMPType = "POROUSPAVEMENT" Then
        indxrange.Offset(0, 25).Value = cboPorousPavement.Value
    End If
    
    
End Sub

Private Sub Read_c725_SurfaceDimensions(indxrange As Range)

    ' Get BMP ID.
    newID = indxrange.Value
    txtBMPName.Value = newID
    
    ' Write general BMP information.
    ' NOTE: Not specifically used in Card 725.
    Call PopulateSubbasins
    'cboSub.Value = indxrange.Offset(0, 1).Value
    'cboDSConnection.Value = indxrange.Offset(0, 2).Value
    'txtDrainageArea.Value = indxrange.Offset(0, 3).Value
    cboBMPType.Value = indxrange.Offset(0, 4).Value
    
    ' Write general release information.
    txtBMPWidth.Value = indxrange.Offset(0, 5).Value
    txtBMPLength.Value = indxrange.Offset(0, 6).Value

    ' Set the release options (People / Dry Days).
    Select Case cboBMPType.Value
        Case "RAINBARREL": txtReleaseOption.Value = indxrange.Offset(0, 9).Value
        Case "CISTERN": txtReleaseOption.Value = indxrange.Offset(0, 8).Value
        Case Else: txtReleaseOption.Value = 0
    End Select

End Sub

Private Sub Read_c730_ReleaseControl(indxrange As Range)

    ' Read hourly cistern per capita release values.
    Dim x As Integer
    For x = 1 To 24
        ReleaseCurve(x) = indxrange.Offset(0, x).Value
    Next x
    
End Sub

Private Sub Read_c732_OrificeControl(indxrange As Range)

    ' Read dimensional information.
    Select Case CDbl(indxrange.Offset(0, 5).Value)
        Case 1: OptionButton1.Value = True
        Case 0.61: OptionButton2.Value = True
        Case 0.5: OptionButton3.Value = True
    End Select
    
    ' Get diameter and orifice height above bed.
    txtOHeight.Value = indxrange.Offset(0, 6).Value
    txtODiam.Value = indxrange.Offset(0, 7).Value
    
End Sub

Private Sub Read_c733_WeirControl(indxrange As Range)
    
    ' Read weir dimensional information.
    

    txtWeirHeight.Value = indxrange.Offset(0, 4).Value
    If indxrange.Offset(0, 3).Value = "Rectangular" Then
        optRWeir.Value = True
        txtWeirValue.Value = indxrange.Offset(0, 5).Value
    Else
        optTWeir.Value = True
        txtWeirValue.Value = indxrange.Offset(0, 6).Value
    End If
    
        If cboBMPType = "SUBSURFACEGRAVELWETLAND" Then
        txtWeirValue = indxrange.Offset(0, 10).Value
    End If

    '' Hard coded values for compatability with BMPDSS_v1.
    'indxRange.Offset(0, 7).Value = "0"
    'indxRange.Offset(0, 8).Value = "0"
    'indxRange.Offset(0, 9).Value = "0"

End Sub

Private Sub Read_c740_SubstrateProperties(indxrange As Range)

    ' Infiltration method hard-coded as Holton=2.
    indxrange.Offset(0, 1).Value = 2
    txtSoilDepth.Value = indxrange.Offset(0, 2).Value
    txtSoilPorosity.Value = indxrange.Offset(0, 3).Value
    
    '' Values hard-coded for compatability with BMPDSS_v2.
    '' These parameters are for the Green-Ampt method.
    'indxRange.Offset(0, 4).Value = 0
    'indxRange.Offset(0, 5).Value = 0
    'indxRange.Offset(0, 6).Value = 0
    'indxRange.Offset(0, 7).Value = 0
    
    'txtPollutantRouting.Value = indxrange.Offset(0, 6).Value
    'txtPollutantRemoval.Value = indxrange.Offset(0, 7).Value
    
    ' Remaining soil parameters.
    txtVegA.Value = indxrange.Offset(0, 8).Value
    txtSoilInfilt.Value = indxrange.Offset(0, 9).Value
    
    
    ' If statement handles underdrain switch parameter.
    txtUDDepth.Value = indxrange.Offset(0, 11).Value
    txtUDPorosity.Value = indxrange.Offset(0, 12).Value
    txtUDInfilt.Value = indxrange.Offset(0, 13).Value
    If indxrange.Offset(0, 10).Value = 1 = True Then
        cbxUD.Value = True
    Else
        cbxUD.Value = False
    End If

    '' Values hard-coded for compatability with BMPDSS_v2.
    '' These parameters are for the Green-Ampt method.
    'indxRange.Offset(0, 14).Value = 0
    'indxRange.Offset(0, 15).Value = 0
    'indxRange.Offset(0, 16).Value = 0

End Sub

Private Sub Read_c745_GrowthIndex(indxrange As Range)

    txtGrowthJan.Value = indxrange.Offset(0, 1).Value
    txtGrowthFeb.Value = indxrange.Offset(0, 2).Value
    txtGrowthMar.Value = indxrange.Offset(0, 3).Value
    txtGrowthApr.Value = indxrange.Offset(0, 4).Value
    txtGrowthMay.Value = indxrange.Offset(0, 5).Value
    txtGrowthJun.Value = indxrange.Offset(0, 6).Value
    txtGrowthJul.Value = indxrange.Offset(0, 7).Value
    txtGrowthAug.Value = indxrange.Offset(0, 8).Value
    txtGrowthSep.Value = indxrange.Offset(0, 9).Value
    txtGrowthOct.Value = indxrange.Offset(0, 10).Value
    txtGrowthNov.Value = indxrange.Offset(0, 11).Value
    txtGrowthDec.Value = indxrange.Offset(0, 12).Value

End Sub

Private Sub Read_c765_DecayRate(indxrange As Range)

    Dim C As Range
    Dim x As Integer
    
    ' Set range starting position.
    Set indxrange = indxrange.Offset(0, 1)
    Set indxrange = Range(indxrange, indxrange.End(xlToRight))
    
    ' Resize the array.
    ReDim DecayRates(indxrange.Cells.Count - 1)
    
    ' Read in values.
    x = 0
    For Each C In indxrange.Cells
        DecayRates(x) = C.Value
        x = x + 1
    Next C
    
    ' Initialize text box.
    'txtDecayRate.Text = 0

End Sub

Private Sub Read_c766_ConstantRate(indxrange As Range)
    
    Dim C As Range
    Dim x As Integer
    

    
    ' Set range starting position
    Set indxrange = indxrange.Offset(0, 1)
    Set indxrange = Range(indxrange, indxrange.End(xlToRight))
    
    ' Resize the array
    ReDim ConstantRates(indxrange.Cells.Count - 1)
    
    ' Read in values.
    x = 0
    For Each C In indxrange.Cells
        ConstantRates(x) = C.Value
        x = x + 1
    Next C
    
    ' Initialize text box.
    'txtConstantRate.Text = 0
    
End Sub

Private Sub Read_c767_ConstantC(indxrange As Range)
    
    Dim C As Range
    Dim x As Integer
    
    ' set range starting position
    Set indxrange = indxrange.Offset(0, 1)
    Set indxrange = Range(indxrange, indxrange.End(xlToRight))
    
    ' Resize the array
    ReDim ConstantCs(indxrange.Cells.Count - 1)
    
    ' Read in values.
    x = 0
    For Each C In indxrange.Cells
        ConstantCs(x) = C.Value
        x = x + 1
    Next C
    
    'txtConstantC.Text = 0
    
End Sub

Private Sub Read_c770_RemovalRate(indxrange As Range)
  
    Dim C As Range
    Dim x As Integer
  
    ' Set range starting position.
    Set indxrange = indxrange.Offset(0, 1)
    Set indxrange = Range(indxrange, indxrange.End(xlToRight))
    
    ' Resize the array.
    ReDim RemovalRates(indxrange.Cells.Count - 1)
    
    ' Read in values.
    x = 0
    For Each C In indxrange.Cells
        RemovalRates(x) = C.Value
        x = x + 1
    Next C
    
    ' Initialize text box.
    'txtRemovalRate.Text = 0
End Sub

Private Sub Read_c810_DecisionVariables(indxrange As Range)

    ' Read in the length constraints.
    LengthConstraint(0) = indxrange.Offset(0, 1).Value
    LengthConstraint(1) = indxrange.Offset(0, 2).Value
    LengthConstraint(2) = indxrange.Offset(0, 3).Value
    LengthConstraint(3) = indxrange.Offset(0, 4).Value

    ' Read in the depth constraints.
    DepthConstraint(0) = indxrange.Offset(0, 5).Value
    DepthConstraint(1) = indxrange.Offset(0, 6).Value
    DepthConstraint(2) = indxrange.Offset(0, 7).Value
    DepthConstraint(3) = indxrange.Offset(0, 8).Value
    
    ' Read in the depth constraints.
    WidthConstraint(0) = indxrange.Offset(0, 9).Value
    WidthConstraint(1) = indxrange.Offset(0, 10).Value
    WidthConstraint(2) = indxrange.Offset(0, 11).Value
    WidthConstraint(3) = indxrange.Offset(0, 12).Value
    
    ' Read in the depth constraints.
    WeirConstraint(0) = indxrange.Offset(0, 13).Value
    WeirConstraint(1) = indxrange.Offset(0, 14).Value
    WeirConstraint(2) = indxrange.Offset(0, 15).Value
    WeirConstraint(3) = indxrange.Offset(0, 16).Value

End Sub

Private Sub Read_c805_Objectives(indxrange As Range)

    txtLinearCost.Value = indxrange.Offset(0, 1).Value
    txtBMPLength.Value = indxrange.Offset(0, 2).Value
    txtAreaCost.Value = indxrange.Offset(0, 3).Value
    CAF.Value = indxrange.Offset(0, 19).Value
    'txtArea.Value = indxrange.Offset(0, 4).Value
    txtTotalVolumeCost.Value = indxrange.Offset(0, 24).Value
    'txtTotalVolume.Value = indxrange.Offset(0, 6).Value
    txtMediaVolumeCost.Value = indxrange.Offset(0, 7).Value
    'txtSoilMediaVolume.Value = indxrange.Offset(0, 8).Value
    txtUnderDrainVolumeCost.Value = indxrange.Offset(0, 9).Value
    'txtUnitCost.Value = indxrange.Offset(0, 10).Value
    txtConstantCost.Value = indxrange.Offset(0, 11).Value
    txtPercentCost.Value = indxrange.Offset(0, 12).Value
    txtLengthExp.Value = indxrange.Offset(0, 13).Value
    txtAreaExp.Value = indxrange.Offset(0, 14).Value
    txtTotalVolExp.Value = indxrange.Offset(0, 15).Value
    txtMediaVolExp.Value = indxrange.Offset(0, 16).Value
    txtUDVolExp.Value = indxrange.Offset(0, 17).Value
    CABMPType.Value = indxrange.Offset(0, 18).Value
    CAF.Value = indxrange.Offset(0, 19).Value
    AnnualMaintenance.Value = indxrange.Offset(0, 20).Value
    
    If cboBMPType = "POROUSPAVEMENT" Then
        cboPorousPavement.Value = indxrange.Offset(0, 25).Value
    End If
    
    
    
    

End Sub

Private Sub PopulateDefault_c725()

    cboBMPType.Value = "BIORETENTION"
   
End Sub

Private Sub PopulateDefault_c730()

    ' Initial values for cistern per capita release.
    Dim x As Integer
    For x = 1 To 24
        ReleaseCurve(x) = 0
    Next x
    
End Sub

Private Sub PopulateDefault_c732()
    
    ' Initial orifice values.
    txtOHeight.Value = 0
    txtODiam.Value = 0
    OptionButton1.Value = True
    
End Sub

Private Sub PopulateDefault_c733()

    ' Set rectangular weir as the default.
    txtWeirHeight.Value = 0
    optRWeir.Value = True
    txtWeirValue.Value = 0
    optTWeir.Value = False

End Sub

Private Sub PopulateDefault_c735()

End Sub

Private Sub PopulateDefault_c740()

    txtSoilDepth.Value = 0
    txtSoilPorosity.Value = 0
    txtVegA.Value = 0
    txtSoilInfilt.Value = 0
    
    If cboBMPType.Value = "SUBSURFACEGRAVELWETLAND" Then
        If txtWeirValue.Value <> 0 Then
            txtSoilInfilt.Value = Val(txtWeirHeight.Value) * 12 / Val(txtWeirValue.Value)   'in/hr
        Else
            MsgBox ("Please enter draining time!")
        End If
    Else
        txtSoilInfilt.Value = 0
    End If
    
    
    txtUDDepth.Value = 0
    txtUDPorosity.Value = 0
    txtUDInfilt.Value = 0
    'txtPollutantRouting.Value = 0
    'txtPollutantRemoval.Value = 0
    
    cbxUD.Value = False
    
End Sub

Private Sub PopulateDefault_c745()

    ' Default growth index values.
    txtGrowthJan.Value = 0
    txtGrowthFeb.Value = 0
    txtGrowthMar.Value = 0
    txtGrowthApr.Value = 0
    txtGrowthMay.Value = 0
    txtGrowthJun.Value = 0
    txtGrowthJul.Value = 0
    txtGrowthAug.Value = 0
    txtGrowthSep.Value = 0
    txtGrowthOct.Value = 0
    txtGrowthNov.Value = 0
    txtGrowthDec.Value = 0

End Sub

Private Sub PopulateDefault_c765()

    Dim C As Range
    Dim indx As Integer
    Dim indxrange As Range
    
    ' Build the range of pollutants.
    Set indxrange = ThisWorkbook.Worksheets("c705").Range("C5")
    If indxrange.Offset(1, 0).Value <> "" Then
        Set indxrange = Range(indxrange, indxrange.End(xlDown))
    End If
    
    ' Resize the array of decay rates.
    ReDim DecayRates(indxrange.Cells.Count)
    
    ' Loop through list of pollutants.
    indx = 0
    For Each C In indxrange.Cells
        DecayRates(indx) = 0
        With lstDecayRates
            .AddItem C.Offset(0, 1).Value
        End With
        indx = indx + 1
    Next C
    
End Sub

Private Sub PopulateDefault_c766()
    
    Dim C As Range
    Dim indx As Integer
    Dim indxrange As Range
    
    ' Build the range of pollutants.
    Set indxrange = ThisWorkbook.Worksheets("c705").Range("C5")
    If indxrange.Offset(1, 0).Value <> "" Then
        Set indxrange = Range(indxrange, indxrange.End(xlDown))
    End If
    
    ' Resize the array of decay rates.
    ReDim ConstantRates(indxrange.Cells.Count)
    
    ' Loop through list of pollutants.
    indx = 0
    For Each C In indxrange.Cells
        ConstantRates(indx) = 0
        'With lstConstantRates
            '.AddItem c.Offset(0, 1).Value
        'End With
        indx = indx + 1
    Next C
End Sub

Private Sub PopulateDefault_c767()
    Dim C As Range
    Dim indx As Integer
    Dim indxrange As Range
    
    'Build the range of pollutants.
    Set indxrange = ThisWorkbook.Worksheets("c705").Range("C5")
    If indxrange.Offset(1, 0).Value <> "" Then
        Set indxrange = Range(indxrange, indxrange.End(xlDown))
    End If
    
    ' Resize the array of constant rate C
    ReDim ConstantCs(indxrange.Cells.Count)
    
    ' Loopp through list of pollutants.
    indx = 0
    For Each C In indxrange.Cells
        ConstantCs(indx) = 0
        'With lstConstantCs
            '.AddItem c.Offset(0, 1).Value
        'End With
        indx = indx + 1
    Next C
    
    
End Sub


Private Sub PopulateDefault_c770()

    Dim C As Range
    Dim indx As Integer
    Dim indxrange As Range
    
    ' Build the range of pollutants.
    Set indxrange = ThisWorkbook.Worksheets("c705").Range("C5")
    If indxrange.Offset(1, 0).Value <> "" Then
        Set indxrange = Range(indxrange, indxrange.End(xlDown))
    End If
    
    ' Resize the array of removal rates.
    ReDim RemovalRates(indxrange.Cells.Count)
    
    ' Loop through list of pollutants.
    indx = 0
    For Each C In indxrange.Cells
        RemovalRates(indx) = 0
        With lstRemovalRates
            .AddItem C.Offset(0, 1).Value
        End With
        indx = indx + 1
    Next C

End Sub

Private Sub PopulateDefault_c810()

    ' Initialize length decision variables.
    LengthConstraint(0) = 0
    LengthConstraint(1) = 0
    LengthConstraint(2) = 0
    LengthConstraint(3) = 0
    
    ' Initialize depth decision variables.
    DepthConstraint(0) = 0
    DepthConstraint(1) = 0
    DepthConstraint(2) = 0
    DepthConstraint(3) = 0
    
    ' Initialize width decision variable.
    WidthConstraint(0) = 0
    WidthConstraint(1) = 0
    WidthConstraint(2) = 0
    WidthConstraint(3) = 0
    
    ' Initialize Weir Height decision variable.
    WeirConstraint(0) = 0
    WeirConstraint(1) = 0
    WeirConstraint(2) = 0
    WeirConstraint(3) = 0
    
End Sub

Private Sub PopulateDefault_c805()

    ' Default cost values.
    txtLinearCost.Value = 0
    txtLinearCost.Visible = False
    Label69.Visible = False
    CAF.Value = 1
    'txtBMPLength.Value = 0
    txtAreaCost.Value = 0
    txtAreaCost.Visible = False
    Label73.Visible = False
    'txtArea.Value = 0
    'txtTotalVolumeCost.Value = 3.2
    'txtTotalVolume.Value = 0
    txtMediaVolumeCost.Value = 0
    txtMediaVolumeCost.Visible = False
    Label75.Visible = False
    'txtSoilMediaVolume.Value = 0
    txtUnderDrainVolumeCost.Value = 0
    txtUnderDrainVolumeCost.Visible = False
    Label77.Visible = False
    'txtUnitCost.Value = 0
    txtConstantCost.Value = 0
    txtConstantCost.Visible = False
    Label79.Visible = False
    txtPercentCost.Value = 0
    txtPercentCost.Visible = False
    Label80.Visible = False
    txtLengthExp.Value = 1
    txtLengthExp.Visible = False
    Label81.Visible = False
    txtAreaExp.Value = 1
    txtAreaExp.Visible = False
    Label82.Visible = False
    Label83.Visible = False
    txtTotalVolExp.Value = 1
    txtTotalVolExp.Visible = False
    txtMediaVolExp.Value = 1
    txtMediaVolExp.Visible = False
    Label84.Visible = False
    txtUDVolExp.Value = 1
    txtUDVolExp.Visible = False
    Label85.Visible = False
    
    

End Sub


Private Sub UserForm_Initialize()

Dim indxrange As Range


    Call PopulateBMPTypes
    Set indxrange = ThisWorkbook.Worksheets("3 - BMP Installation Data Entry").Range("C10")
    Call Read_c725(ThisWorkbook.Worksheets("3 - BMP Installation Data Entry").Range(indxrange.Address))
    
End Sub


Private Sub Read_c725(indxrange As Range)

    ' Get BMP ID.
    newID = indxrange.Value
    txtBMPName.Value = newID
    
    ' Write general BMP information.
    ' NOTE: Not specifically used in Card 725.

    'cboSub.Value = indxrange.Offset(0, 1).Value
    'cboDSConnection.Value = indxrange.Offset(0, 2).Value
    'txtDrainageArea.Value = indxrange.Offset(0, 3).Value
    cboBMPType.Value = indxrange.Offset(0, 4).Value
    
    ' Write general release information.
    txtBMPWidth.Value = indxrange.Offset(0, 5).Value
    txtBMPLength.Value = indxrange.Offset(0, 6).Value

    ' Set the release options (People / Dry Days).


End Sub

Private Sub cmdSave_Click()
Dim indxrange As Range
    Set indxrange = ThisWorkbook.Worksheets("3 - BMP Installation Data Entry").Range("C10")
    Call Write_c725(ThisWorkbook.Worksheets("3 - BMP Installation Data Entry").Range(indxrange.Address))
   
        Unload Me


End Sub

Private Sub Write_c725(indxrange As Range)

    ' Write general BMP information.
    ' NOTE: Not specifically used in Card 725.

    
    'indxRange.Value = newID
    indxrange.Value = txtBMPName.Value
   ' indxrange.Offset(0, 1).Value = cboSub.Value
   ' indxrange.Offset(0, 2).Value = cboDSConnection.Value
    If indxrange.Offset(0, 3).Value = "" Then
        indxrange.Offset(0, 3).Value = "0"
    End If
    
    'indxrange.Offset(0, 3).Value = txtDrainageArea.Value
   ' indxrange.Offset(0, 3).Value = BMP_Drainage_Area
    indxrange.Offset(0, 4).Value = cboBMPType.Value
    
    ' Write general release information.
    indxrange.Offset(0, 5).Value = txtBMPWidth.Value
    If True Then
        indxrange.Offset(0, 6).Value = txtBMPLength.Value
    Else
        indxrange.Offset(0, 6).Value = txtBMPLength.Value
    End If
    
    ' Set the release options (People / Dry Days).
    Select Case cboBMPType.Value
        Case "RAINBARREL"
            indxrange.Offset(0, 7).Value = 2
            indxrange.Offset(0, 8).Value = "0"
            indxrange.Offset(0, 9).Value = "0"
        Case "CISTERN"
            indxrange.Offset(0, 7).Value = 1
            indxrange.Offset(0, 8).Value = "0"
            indxrange.Offset(0, 9).Value = "0"
        Case Else
            indxrange.Offset(0, 7).Value = 3
            indxrange.Offset(0, 8).Value = "0"
            indxrange.Offset(0, 9).Value = "0"
    End Select
    
    ' Number of orifices and weirs limited to 1.
    Select Case cboBMPType.Value
        Case "HYDRODYNAMICSEPERATOR"
            indxrange.Offset(0, 10).Value = "0"
            indxrange.Offset(0, 11).Value = "0"
        Case Else
            indxrange.Offset(0, 10).Value = "1"
            indxrange.Offset(0, 11).Value = "1"
    End Select
    
    'Update for the latest version of SUSTAIN
    'Yi Xu
    
    
    
    
    indxrange.Offset(0, 13).Value = 0
    indxrange.Offset(0, 14).Value = 0
    indxrange.Offset(0, 15).Value = 0
    indxrange.Offset(0, 16).Value = "no_curve"
    'indxrange.Offset(0, 17).Value = BMPLandUse
    

End Sub
