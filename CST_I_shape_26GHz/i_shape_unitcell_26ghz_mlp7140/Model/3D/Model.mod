'# MWS Version: Version 2021.1 - Nov 10 2020 - ACIS 30.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 22 fmax = 30
'# created = '[VERSION]2021.1|30.0.1|20201110[/VERSION]


'@ use template: FSS, Metamaterial - Unit Cell_11.cfg

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "H"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "F"
End With

'----------------------------------------------------------------------------

Plot.DrawBox True

With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .Rho "1.204"
     .ThermalType "Normal"
     .ThermalConductivity "0.026"
      .SpecificHeat "1005", "J/K/kg"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With

' define Floquet port boundaries

With FloquetPort
     .Reset
     .SetDialogTheta "0"
     .SetDialogPhi "0"
     .SetSortCode "+beta/pw"
     .SetCustomizedListFlag "False"
     .Port "Zmin"
     .SetNumberOfModesConsidered "2"
     .Port "Zmax"
     .SetNumberOfModesConsidered "2"
End With

MakeSureParameterExists "theta", "0"
SetParameterDescription "theta", "spherical angle of incident plane wave"
MakeSureParameterExists "phi", "0"
SetParameterDescription "phi", "spherical angle of incident plane wave"

' define boundaries, the open boundaries define floquet port

With Boundary
     .Xmin "unit cell"
     .Xmax "unit cell"
     .Ymin "unit cell"
     .Ymax "unit cell"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "False"
     .SetPeriodicBoundaryAngles "theta", "phi"
     .SetPeriodicBoundaryAnglesDirection "inward"
     .UnitCellFitToBoundingBox "True"
     .UnitCellDs1 "0.0"
     .UnitCellDs2 "0.0"
     .UnitCellAngle "90.0"
End With

' set tet mesh as default

With Mesh
     .MeshType "Tetrahedral"
End With

' FD solver excitation with incoming plane wave at Zmax

With FDSolver
     .Reset
     .Stimulation "List", "List"
     .ResetExcitationList
     .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)"
     .LowFrequencyStabilization "False"
End With

'----------------------------------------------------------------------------

With MeshSettings
     .SetMeshType "Tet"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "Tetrahedral"
End With

'set the solver type
ChangeSolverType("HF Frequency Domain")

'----------------------------------------------------------------------------

'@ define material: Rogers RT5880 (lossy)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Material
     .Reset
     .Name "Rogers RT5880 (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.2"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0009"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.20"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ new component: component1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Component.New "component1"

'@ define brick: component1:Sub

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "Sub" 
     .Component "component1" 
     .Material "Rogers RT5880 (lossy)" 
     .Xrange "-l/2", "l/2" 
     .Yrange "-l/2", "l/2" 
     .Zrange "0", "0.289" 
     .Create
End With

'@ define material: Copper (annealed)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Material
     .Reset
     .Name "Copper (annealed)"
     .Folder ""
.FrqType "static"
.Type "Normal"
.SetMaterialUnit "Hz", "mm"
.Epsilon "1"
.Mu "1.0"
.Kappa "5.8e+007"
.TanD "0.0"
.TanDFreq "0.0"
.TanDGiven "False"
.TanDModel "ConstTanD"
.KappaM "0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstTanD"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "Nth Order"
.DispersiveFittingSchemeMu "Nth Order"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.FrqType "all"
.Type "Lossy metal"
.SetMaterialUnit "GHz", "mm"
.Mu "1.0"
.Kappa "5.8e+007"
.Rho "8930.0"
.ThermalType "Normal"
.ThermalConductivity "401.0"
.SpecificHeat "390", "J/K/kg"
.MetabolicRate "0"
.BloodFlow "0"
.VoxelConvection "0"
.MechanicsType "Isotropic"
.YoungsModulus "120"
.PoissonsRatio "0.33"
.ThermalExpansionRate "17"
.Colour "1", "1", "0"
.Wireframe "False"
.Reflection "False"
.Allowoutline "True"
.Transparentoutline "False"
.Transparency "0"
.Create
End With

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Sub", "1"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define brick: component1:Copper

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "Copper" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-p/2", "p/2" 
     .Yrange "-p/2", "p/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "h/2", " p/2" 
     .Yrange "-(p/2 - w)", "(p/2 - w)" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ transform: rotate component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "180" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ boolean subtract shapes: component1:Copper, component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:Copper", "component1:solid1"

'@ boolean subtract shapes: component1:Copper, component1:solid1_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:Copper", "component1:solid1_1"

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Sub", "2"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define brick: component1:Ground

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "Ground" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-l/2", "l/2" 
     .Yrange "-l/2", "l/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "27", "19"

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "8", "20"

'@ define frequency domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "List", "List" 
     .ResetExcitationList 
     .AddToExcitationList "Zmax", "TE(0,0);TM(0,0)" 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "False" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .StoreSolutionCoefficients "True" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.3" 
     .UseCFIEForCPECIntEq "True" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .RemoveAllStopCriteria "Hex"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
     .RemoveAllStopCriteria "Tet"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
     .RemoveAllStopCriteria "Srf"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
     .SweepMinimumSamples "3" 
     .SetNumberOfResultDataSamples "1001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddSampleInterval "", "", "", "Automatic", "False" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .UseParallelization "True"
     .MaxCPUs "1024"
     .MaximumNumberOfCPUDevices "2"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "True" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .CalcFarFieldInRealGround "False" 
     .RealGroundModelType "Auto" 
     .PreconditionerType "Auto" 
     .ExtendThinWireModelByWireNubs "False" 
     .ExtraPreconditioning "False" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "0.500000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetRCSOptimizationProperties "True", "100", "0.00001" 
     .SetAccuracySetting "Custom" 
     .CalculateSParaforFieldsources "True" 
     .ModeTrackingCMA "True" 
     .NumberOfModesCMA "3" 
     .StartFrequencyCMA "-1.0" 
     .SetAccuracySettingCMA "Default" 
     .FrequencySamplesCMA "0" 
     .SetMemSettingCMA "Auto" 
     .CalculateModalWeightingCoefficientsCMA "True" 
End With

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .Xmin "unit cell"
     .Xmax "unit cell"
     .Ymin "unit cell"
     .Ymax "unit cell"
     .Zmin "electric"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "False"
     .SetPeriodicBoundaryAngles "theta", "phi"
     .SetPeriodicBoundaryAnglesDirection "inward"
     .UnitCellFitToBoundingBox "True"
     .UnitCellDs1 "0.0"
     .UnitCellDs2 "0.0"
     .UnitCellAngle "90.0"
End With

'@ clear picks

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "27", "19"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "0"
    .SetOrientation "Smart Mode"
    .SetDistance "1.058072"
    .SetViewVector "0.000000", "-0.000035", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "47", "35"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "1"
    .SetOrientation "Smart Mode"
    .SetDistance "1.571282"
    .SetViewVector "0.000000", "-0.000035", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "40", "26"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "2"
    .SetOrientation "Smart Mode"
    .SetDistance "1.478301"
    .SetViewVector "0.000000", "-0.000035", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "34"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "30"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "3"
    .SetOrientation "Smart Mode"
    .SetDistance "-2.642050"
    .SetViewVector "0.000000", "-0.000035", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "1", "1"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "4"
    .SetOrientation "Smart Mode"
    .SetDistance "2.207595"
    .SetViewVector "-0.000000", "-0.000035", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "4", "4"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "5"
    .SetOrientation "Smart Mode"
    .SetDistance "0.397112"
    .SetViewVector "-0.000000", "-0.000035", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ switch bounding box

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Plot.DrawBox "False"

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "13", "27"

'@ delete dimension 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "2"
End With

'@ delete dimension 3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "3"
End With

'@ delete dimension 0

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "0"
End With

'@ delete dimension 5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "5"
End With

'@ delete dimension 4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "4"
End With

'@ delete dimension 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "1"
End With

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "26", "18"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "6"
    .SetOrientation "Smart Mode"
    .SetDistance "0.376427"
    .SetViewVector "0.000000", "-0.000036", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "3", "3"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "7"
    .SetOrientation "Smart Mode"
    .SetDistance "1.453660"
    .SetViewVector "0.000000", "-0.000036", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "45", "32"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "8"
    .SetOrientation "Smart Mode"
    .SetDistance "1.327502"
    .SetViewVector "0.000000", "-0.000036", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "40", "26"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "9"
    .SetOrientation "Smart Mode"
    .SetDistance "1.298712"
    .SetViewVector "0.000000", "-0.000036", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "53", "38"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "10"
    .SetOrientation "Smart Mode"
    .SetDistance "1.028395"
    .SetViewVector "0.000000", "-0.000036", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "38"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "26"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "11"
    .SetOrientation "Smart Mode"
    .SetDistance "-3.007865"
    .SetViewVector "0.000000", "-0.000036", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "9"
End With

'@ delete dimension 11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "11"
End With

'@ delete dimension 7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "7"
End With

'@ delete dimension 8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "8"
End With

'@ delete dimension 6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "6"
End With

'@ delete dimension 10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "10"
End With

'@ switch working plane

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Plot.DrawWorkplane "false"

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "16", "36"

'@ define Floquet port boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FloquetPort
     .Reset
     .SetDialogTheta "0" 
     .SetDialogPhi "0" 
     .SetPolarizationIndependentOfScanAnglePhi "theta", "False"  
     .SetSortCode "+beta/pw" 
     .SetCustomizedListFlag "False" 
     .Port "Zmax" 
     .SetNumberOfModesConsidered "2" 
     .SetDistanceToReferencePlane "0.0" 
     .SetUseCircularPolarization "False" 
End With

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Ground", "7"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Ground", "6"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "12"
    .SetOrientation "Smart Mode"
    .SetDistance "0.809200"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Ground"
    .SetConnectedElement2 "component1:Ground"
    .Create
End With

Pick.ClearAllPicks

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "19"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Ground", "8"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "13"
    .SetOrientation "Smart Mode"
    .SetDistance "-1.274122"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Ground"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "13"
End With

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "3", "3"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "14"
    .SetOrientation "Smart Mode"
    .SetDistance "1.085347"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "45", "32"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "15"
    .SetOrientation "Smart Mode"
    .SetDistance "0.891388"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "50", "34"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "16"
    .SetOrientation "Smart Mode"
    .SetDistance "0.936426"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "34"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "30"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "17"
    .SetOrientation "Smart Mode"
    .SetDistance "0.836648"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "37", "27"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "18"
    .SetOrientation "Smart Mode"
    .SetDistance "1.285723"
    .SetViewVector "0.000000", "-0.000044", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "10", "1"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "19"
    .SetOrientation "Smart Mode"
    .SetDistance "-0.500083"
    .SetViewVector "-0.469838", "-0.342063", "-0.813784"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 19

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "19"
End With

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Sub", "1"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Sub", "1"

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ activate local coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "local"

'@ clear picks

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.ClearAllPicks

'@ define brick: component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-p/2", "p/2" 
     .Yrange "-p/2", "p/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define brick: component1:solid2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-(p-q)/2", "(p-q)/2" 
     .Yrange "-(p-q)/2", "(p-q)/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ boolean subtract shapes: component1:solid1, component1:solid2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:solid1", "component1:solid2"

'@ boolean subtract shapes: component1:Copper, component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:Copper", "component1:solid1"

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ define material: Rogers RT6010LM (lossy)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Material
     .Reset
     .Name "Rogers RT6010LM (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "10.7"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0023"
.TanDFreq "10.0"
.TanDGiven "True"
.TanDModel "ConstTanD"
.KappaM "0.0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "0.0"
.ThermalType "Normal"
.ThermalConductivity "0.78"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ change material: component1:Sub to: Rogers RT6010LM (lossy)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.ChangeMaterial "component1:Sub", "Rogers RT6010LM (lossy)"

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "22", "30"

'@ clear picks

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "91", "67"

'@ delete dimension 18

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "18"
End With

'@ delete dimension 15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "15"
End With

'@ delete dimension 12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "12"
End With

'@ delete dimension 17

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "17"
End With

'@ delete dimension 14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "14"
End With

'@ delete dimension 16

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "16"
End With

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "20"
    .SetOrientation "Smart Mode"
    .SetDistance "2.872200"
    .SetViewVector "-0.308118", "-0.329929", "-0.892306"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 20

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "20"
End With

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "101", "70"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "21"
    .SetOrientation "Smart Mode"
    .SetDistance "0.675491"
    .SetViewVector "-0.308118", "-0.329929", "-0.892306"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "4", "4"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "22"
    .SetOrientation "Smart Mode"
    .SetDistance "0.393064"
    .SetViewVector "-0.308118", "-0.329929", "-0.892306"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "101", "70"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "23"
    .SetOrientation "Smart Mode"
    .SetDistance "0.527030"
    .SetViewVector "0.000000", "-0.000032", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "91", "67"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "24"
    .SetOrientation "Smart Mode"
    .SetDistance "0.650989"
    .SetViewVector "0.000000", "-0.000032", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "82", "58"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "25"
    .SetOrientation "Smart Mode"
    .SetDistance "0.628669"
    .SetViewVector "0.000000", "-0.000032", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "62"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "50"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "26"
    .SetOrientation "Smart Mode"
    .SetDistance "-0.759817"
    .SetViewVector "0.000000", "-0.000032", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "3", "3"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "27"
    .SetOrientation "Smart Mode"
    .SetDistance "0.903415"
    .SetViewVector "0.000000", "-0.000032", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "4", "4"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "28"
    .SetOrientation "Smart Mode"
    .SetDistance "0.689031"
    .SetViewVector "0.000000", "-0.000038", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "1", "1"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "29"
    .SetOrientation "Smart Mode"
    .SetDistance "-1.911245"
    .SetViewVector "-1.000000", "-0.000038", "0.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Sub", "1"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Ground", "2"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "30"
    .SetOrientation "Smart Mode"
    .SetDistance "1.629446"
    .SetViewVector "-1.000000", "-0.000038", "0.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Ground"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 30

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "30"
End With

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Sub", "1"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Ground", "2"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "31"
    .SetOrientation "Smart Mode"
    .SetDistance "-0.508393"
    .SetViewVector "-1.000000", "-0.000038", "0.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Ground"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 23

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "23"
End With

'@ delete dimension 31

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "31"
End With

'@ delete dimension 24

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "24"
End With

'@ delete dimension 28

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "28"
End With

'@ delete dimension 27

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "27"
End With

'@ delete dimension 29

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "29"
End With

'@ delete dimension 22

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "22"
End With

'@ delete dimension 21

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "21"
End With

'@ delete dimension 26

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "26"
End With

'@ delete dimension 25

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "25"
End With

'@ define monitor: h-field (f=26)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=26)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "26" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-2.75", "2.75", "-2.75", "2.75", "-0.035", "0.289" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "20", "32"

'@ define monitor: e-field (f=20)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=20)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "20" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-2.75", "2.75", "-2.75", "2.75", "-0.035", "0.289" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ delete monitor: e-field (f=20)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Monitor.Delete "e-field (f=20)"

'@ define monitor: h-field (f=20.7)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=20.7)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "20.7" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-2.75", "2.75", "-2.75", "2.75", "-0.035", "0.289" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "22", "30"

'@ delete monitor: h-field (f=20.7)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Monitor.Delete "h-field (f=20.7)"

'@ clear picks

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.ClearAllPicks

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Sub", "1"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define brick: component1:gap

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "gap" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-p/2", "p/2" 
     .Yrange "-g/2", "g/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ boolean subtract shapes: component1:Copper, component1:gap

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:Copper", "component1:gap"

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ pick mid point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickMidpointFromId "component1:Copper", "119"

'@ pick mid point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickMidpointFromId "component1:Copper", "129"

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Sub", "1"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define lumped element: Folder1:PINDIode

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With LumpedElement
     .Reset 
     .SetName "PINDIode" 
     .Folder "Folder1" 
     .SetType "RLCSerial"
     .SetR "Rs*m1"
     .SetL "Lv"
     .SetC "Ct*(1-m1)"
     .SetGs "0"
     .SetI0 "1e-14"
     .SetT "300"
     .SetMonitor "True"
     .SetRadius "0.0"
     .CircuitFileName ""
     .CircuitId "1"
     .UseCopyOnly "True"
     .UseRelativePath "False"
     .SetP1 "True", "0", "-0.14", "0.035" 
     .SetP2 "True", "1.3877787807814e-17", "0.14", "0.035" 
     .SetInvert "False" 
     .Wire "" 
     .Position "end1" 
     .Create
End With

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "93"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Copper", "89"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "0"
    .SetOrientation "Smart Mode"
    .SetDistance "0.465342"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "94", "66"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "1"
    .SetOrientation "Smart Mode"
    .SetDistance "-0.916783"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "103", "75"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "2"
    .SetOrientation "Smart Mode"
    .SetDistance "0.946142"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "113", "78"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "3"
    .SetOrientation "Smart Mode"
    .SetDistance "0.546782"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "4", "4"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "4"
    .SetOrientation "Smart Mode"
    .SetDistance "0.486287"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "3", "3"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "5"
    .SetOrientation "Smart Mode"
    .SetDistance "1.401103"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "97", "70"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "6"
    .SetOrientation "Smart Mode"
    .SetDistance "-0.480657"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "1"
End With

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "94", "66"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "7"
    .SetOrientation "Smart Mode"
    .SetDistance "-1.034842"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "7"
End With

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Copper", "127", "93"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "8"
    .SetOrientation "Smart Mode"
    .SetDistance "1.180018"
    .SetViewVector "-0.000000", "-0.000066", "-1.000000"
    .SetConnectedElement1 "component1:Copper"
    .SetConnectedElement2 "component1:Copper"
    .Create
End With

Pick.ClearAllPicks

'@ delete dimension 4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "4"
End With

'@ delete dimension 6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "6"
End With

'@ delete dimension 3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "3"
End With

'@ delete dimension 0

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "0"
End With

'@ delete dimension 5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "5"
End With

'@ delete dimension 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "2"
End With

'@ delete dimension 8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "8"
End With

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Sub", "1"

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Ground", "2"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "9"
    .SetOrientation "Smart Mode"
    .SetDistance "-0.400957"
    .SetViewVector "-1.000000", "-0.000070", "0.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Ground"
    .Create
End With

Pick.ClearAllPicks

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Ground", "1", "1"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "10"
    .SetOrientation "Smart Mode"
    .SetDistance "1.184935"
    .SetViewVector "-1.000000", "-0.000070", "0.000000"
    .SetConnectedElement1 "component1:Ground"
    .SetConnectedElement2 "component1:Ground"
    .Create
End With

Pick.ClearAllPicks

'@ define monitor: h-field (f=26)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "h-field (f=26)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Hfield" 
     .MonitorValue "26" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-2.75", "2.75", "-2.75", "2.75", "-0.035", "0.324" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ delete lumped element: Folder1:PINDIode

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
LumpedElement.Delete "Folder1:PINDIode"

'@ pick mid point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickMidpointFromId "component1:Copper", "119"

'@ pick mid point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickMidpointFromId "component1:Copper", "129"

'@ define lumped element: Folder1:P1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With LumpedElement
     .Reset 
     .SetName "P1" 
     .Folder "Folder1" 
     .SetType "RLCSerial"
     .SetR "Rs*m1"
     .SetL "Lv"
     .SetC "Ct*(1-m1)"
     .SetGs "0"
     .SetI0 "1e-14"
     .SetT "300"
     .SetMonitor "True"
     .SetRadius "0.0"
     .CircuitFileName ""
     .CircuitId "1"
     .UseCopyOnly "True"
     .UseRelativePath "False"
     .SetP1 "True", "0", "-0.075", "0.324" 
     .SetP2 "True", "0", "0.075", "0.324" 
     .SetInvert "False" 
     .Wire "" 
     .Position "end1" 
     .Create
End With

'@ pick end point

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEndpointFromId "component1:Sub", "1"

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0.0" 
     .ZmaxSpace "0" 
     .ApplyInAllDirections "False" 
End With 

With Material 
     .Reset 
     .Rho "1.204"
     .ThermalType "Normal"
     .ThermalConductivity "0.026"
     .SpecificHeat "1005", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "m"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "1.0"
     .Mu "1.0"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstSigma"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.6", "0.6", "0.6" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeBackgroundMaterial
End With

'@ switch bounding box

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Plot.DrawBox "True"

'@ define port: 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-2.75", "2.75"
     .Yrange "-2.75", "2.75"
     .Zrange "3.2066197884615", "3.2066197884615"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "electric"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
End With

'@ define frequency domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "1", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "False" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .StoreSolutionCoefficients "True" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.3" 
     .UseCFIEForCPECIntEq "True" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .RemoveAllStopCriteria "Hex"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
     .RemoveAllStopCriteria "Tet"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
     .RemoveAllStopCriteria "Srf"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
     .SweepMinimumSamples "3" 
     .SetNumberOfResultDataSamples "1001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddSampleInterval "", "", "", "Automatic", "False" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .UseParallelization "True"
     .MaxCPUs "1024"
     .MaximumNumberOfCPUDevices "2"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "True" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .CalcFarFieldInRealGround "False" 
     .RealGroundModelType "Auto" 
     .PreconditionerType "Auto" 
     .ExtendThinWireModelByWireNubs "False" 
     .ExtraPreconditioning "False" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "0.500000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetRCSOptimizationProperties "True", "100", "0.00001" 
     .SetAccuracySetting "Custom" 
     .CalculateSParaforFieldsources "True" 
     .ModeTrackingCMA "True" 
     .NumberOfModesCMA "3" 
     .StartFrequencyCMA "-1.0" 
     .SetAccuracySettingCMA "Default" 
     .FrequencySamplesCMA "0" 
     .SetMemSettingCMA "Auto" 
     .CalculateModalWeightingCoefficientsCMA "True" 
End With

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .Xmin "unit cell"
     .Xmax "unit cell"
     .Ymin "unit cell"
     .Ymax "unit cell"
     .Zmin "electric"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "False"
     .SetPeriodicBoundaryAngles "theta", "phi"
     .SetPeriodicBoundaryAnglesDirection "inward"
     .UnitCellFitToBoundingBox "True"
     .UnitCellDs1 "0.0"
     .UnitCellDs2 "0.0"
     .UnitCellAngle "90.0"
End With

'@ define material: Rogers RT6010LM (lossy)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Material 
     .Reset 
     .Name "Rogers RT6010LM (lossy)"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.78"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "10.7"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.0023"
     .TanDFreq "26"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0.0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMu "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ delete port: port1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Port.Delete "1"

'@ define frequency domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "All+Floquet", "All" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalcBlockExcitationsInParallel "True", "True", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "False" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "False" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .StoreSolutionCoefficients "True" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.3" 
     .UseCFIEForCPECIntEq "True" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .RemoveAllStopCriteria "Hex"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Hex", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Hex", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Hex", "False"
     .RemoveAllStopCriteria "Tet"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Tet", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Tet", "False"
     .AddStopCriterion "All Probes", "0.05", "2", "Tet", "True"
     .RemoveAllStopCriteria "Srf"
     .AddStopCriterion "All S-Parameters", "0.01", "2", "Srf", "True"
     .AddStopCriterion "Reflection S-Parameters", "0.01", "2", "Srf", "False"
     .AddStopCriterion "Transmission S-Parameters", "0.01", "2", "Srf", "False"
     .SweepMinimumSamples "3" 
     .SetNumberOfResultDataSamples "1001" 
     .SetResultDataSamplingMode "Automatic" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddSampleInterval "", "", "", "Automatic", "False" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .UseParallelization "True"
     .MaxCPUs "1024"
     .MaximumNumberOfCPUDevices "2"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "True" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .CalcFarFieldInRealGround "False" 
     .RealGroundModelType "Auto" 
     .PreconditionerType "Auto" 
     .ExtendThinWireModelByWireNubs "False" 
     .ExtraPreconditioning "False" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "0.500000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetRCSOptimizationProperties "True", "100", "0.00001" 
     .SetAccuracySetting "Custom" 
     .CalculateSParaforFieldsources "True" 
     .ModeTrackingCMA "True" 
     .NumberOfModesCMA "3" 
     .StartFrequencyCMA "-1.0" 
     .SetAccuracySettingCMA "Default" 
     .FrequencySamplesCMA "0" 
     .SetMemSettingCMA "Auto" 
     .CalculateModalWeightingCoefficientsCMA "True" 
End With

'@ define material: Rogers RT6010LM (lossy)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Material 
     .Reset 
     .Name "Rogers RT6010LM (lossy)"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.78"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .Epsilon "10.7"
     .Mu "1.0"
     .Sigma "0.0"
     .TanD "0.0023"
     .TanDFreq "10"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0.0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "1st Order"
     .DispersiveFittingSchemeMu "1st Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.94", "0.82", "0.76" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ switch bounding box

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Plot.DrawBox "False"

'@ delete dimension 9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .RemoveDimension "9"
End With

'@ pick edge

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickEdgeFromId "component1:Sub", "10", "1"

'@ define distance dimension

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Dimension
    .Reset
    .CreationType "picks"
    .SetType "Distance"
    .SetID "11"
    .SetOrientation "Smart Mode"
    .SetDistance "0.370405"
    .SetViewVector "-1.000000", "-0.000076", "0.000000"
    .SetConnectedElement1 "component1:Sub"
    .SetConnectedElement2 "component1:Sub"
    .Create
End With

Pick.ClearAllPicks

