'# MWS Version: Version 2021.1 - Nov 10 2020 - ACIS 30.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 15 fmax = 45
'# created = '[VERSION]2021.1|30.0.1|20201110[/VERSION]


'@ use template: FSS, Metamaterial - Unit Cell_3.cfg

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

'@ define material: Arlon AD 250C (lossy)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Material
     .Reset
     .Name "Arlon AD 250C (lossy)"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "GHz", "mm"
.Epsilon "2.5"
.Mu "1.0"
.Kappa "0.0"
.TanD "0.0013"
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
.ThermalConductivity "0.235"
.SetActiveMaterial "all"
.Colour "0.94", "0.82", "0.76"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ new component: component1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Component.New "component1"

'@ define brick: component1:Dielectric

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "Dielectric" 
     .Component "component1" 
     .Material "Arlon AD 250C (lossy)" 
     .Xrange "-L/2", "L/2" 
     .Yrange "-W/2", "W/2" 
     .Zrange "0", "0.76" 
     .Create
End With

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Dielectric", "1"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ define brick: component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "Arlon AD 250C (lossy)" 
     .Xrange "-(L2/2)", "(L2/2)" 
     .Yrange "-(L2/2)", "(L2/2)" 
     .Zrange "0", "0.035" 
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

'@ change material: component1:solid1 to: Copper (annealed)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.ChangeMaterial "component1:solid1", "Copper (annealed)"

'@ define brick: component1:solid2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-(L2-0.4)/2", "(L2-0.4)/2" 
     .Yrange "-(L2-0.4)/2", "(L2-0.4)/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ define cylinder: component1:solid3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Cylinder 
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .OuterRadius "R" 
     .InnerRadius "R-0.2" 
     .Axis "z" 
     .Zrange "0", "0.035" 
     .Xcenter "0" 
     .Ycenter "0" 
     .Segments "0" 
     .Create 
End With

'@ transform: rotate component1:solid1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid1" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ activate local coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "local"

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ activate local coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "local"

'@ transform: rotate component1:solid2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid2" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "45" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ boolean subtract shapes: component1:solid1_1, component1:solid2_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:solid1_1", "component1:solid2_1"

'@ boolean intersect shapes: component1:solid1, component1:solid1_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Intersect "component1:solid1", "component1:solid1_1"

'@ define brick: component1:solid4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-(L2)/2", "(L2)/2" 
     .Yrange "-(L2)/2", "(L2)/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ boolean subtract shapes: component1:solid4, component1:solid2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Subtract "component1:solid4", "component1:solid2"

'@ boolean add shapes: component1:solid1, component1:solid4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:solid1", "component1:solid4"

'@ define brick: component1:solid4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "Copper (annealed)" 
     .Xrange "-0.1", "0.1" 
     .Yrange "-(L3)/2", "(L3)/2" 
     .Zrange "0", "0.035" 
     .Create
End With

'@ transform: rotate component1:solid4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Origin "Free" 
     .Center "0", "0", "0" 
     .Angle "0", "0", "90" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Rotate" 
End With

'@ boolean add shapes: component1:solid4, component1:solid4_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:solid4", "component1:solid4_1"

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "20", "40"

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "5.7" 
     .ZmaxSpace "5.7" 
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

'@ change solver type

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
ChangeSolverType "HF Time Domain"

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0" 
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

'@ set mesh properties (Hexahedral)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "15" 
     .Set "StepsPerWaveFar", "15" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "20" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "15" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "2" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2020111021" 
End With

'@ define port: 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-1.65", "1.65"
     .Yrange "-1.65", "1.65"
     .Zrange "3.2932704833333", "3.2932704833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define port: 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmin"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-1.65", "1.65"
     .Yrange "-1.65", "1.65"
     .Zrange "-2.4982704833333", "-2.4982704833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-20"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .Xmin "periodic"
     .Xmax "periodic"
     .Ymin "periodic"
     .Ymax "periodic"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "True"
     .SetPeriodicBoundaryAngles "theta", "phi"
     .SetPeriodicBoundaryAnglesDirection "inward"
End With

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "7.5" 
     .ZmaxSpace "7.5" 
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

'@ define pml specials

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .ReflectionLevel "0.0001" 
     .MinimumDistanceType "Fraction" 
     .MinimumDistancePerWavelengthNewMeshEngine "4" 
     .MinimumDistanceReferenceFrequencyType "Center" 
     .FrequencyForMinimumDistance "30" 
     .SetAbsoluteDistance "0.0" 
End With

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
End With

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "15", "45"

'@ set mesh properties (Hexahedral)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Mesh 
     .MeshType "PBA" 
     .SetCreator "High Frequency"
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "Version", 1%
     'MAX CELL - WAVELENGTH REFINEMENT 
     .Set "StepsPerWaveNear", "15" 
     .Set "StepsPerWaveFar", "15" 
     .Set "WavelengthRefinementSameAsNear", "1" 
     'MAX CELL - GEOMETRY REFINEMENT 
     .Set "StepsPerBoxNear", "20" 
     .Set "StepsPerBoxFar", "1" 
     .Set "MaxStepNear", "0" 
     .Set "MaxStepFar", "0" 
     .Set "ModelBoxDescrNear", "maxedge" 
     .Set "ModelBoxDescrFar", "maxedge" 
     .Set "UseMaxStepAbsolute", "0" 
     .Set "GeometryRefinementSameAsNear", "0" 
     'MIN CELL 
     .Set "UseRatioLimitGeometry", "1" 
     .Set "RatioLimitGeometry", "15" 
     .Set "MinStepGeometryX", "0" 
     .Set "MinStepGeometryY", "0" 
     .Set "MinStepGeometryZ", "0" 
     .Set "UseSameMinStepGeometryXYZ", "1" 
End With 
With MeshSettings 
     .Set "PlaneMergeVersion", "2" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "FaceRefinementOn", "0" 
     .Set "FaceRefinementPolicy", "2" 
     .Set "FaceRefinementRatio", "2" 
     .Set "FaceRefinementStep", "0" 
     .Set "FaceRefinementNSteps", "2" 
     .Set "EllipseRefinementOn", "0" 
     .Set "EllipseRefinementPolicy", "2" 
     .Set "EllipseRefinementRatio", "2" 
     .Set "EllipseRefinementStep", "0" 
     .Set "EllipseRefinementNSteps", "2" 
     .Set "FaceRefinementBufferLines", "3" 
     .Set "EdgeRefinementOn", "1" 
     .Set "EdgeRefinementPolicy", "1" 
     .Set "EdgeRefinementRatio", "2" 
     .Set "EdgeRefinementStep", "0" 
     .Set "EdgeRefinementBufferLines", "3" 
     .Set "RefineEdgeMaterialGlobal", "0" 
     .Set "RefineAxialEdgeGlobal", "0" 
     .Set "BufferLinesNear", "3" 
     .Set "UseDielectrics", "1" 
     .Set "EquilibrateOn", "0" 
     .Set "Equilibrate", "1.5" 
     .Set "IgnoreThinPanelMaterial", "0" 
End With 
With MeshSettings 
     .SetMeshType "Hex" 
     .Set "SnapToAxialEdges", "1"
     .Set "SnapToPlanes", "1"
     .Set "SnapToSpheres", "1"
     .Set "SnapToEllipses", "1"
     .Set "SnapToCylinders", "1"
     .Set "SnapToCylinderCenters", "1"
     .Set "SnapToEllipseCenters", "1"
End With 
With Discretizer 
     .ConnectivityCheck "True"
     .UsePecEdgeModel "True" 
     .PointAccEnhancement "0" 
     .TSTVersion "0"
	  .PBAVersion "2020111021" 
End With

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "7.5" 
     .ZmaxSpace "7.5" 
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

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-80"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ switch working plane

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Plot.DrawWorkplane "false"

'@ switch bounding box

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Plot.DrawBox "False"

'@ delete port: port1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Port.Delete "1"

'@ delete port: port2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Port.Delete "2"

'@ change solver type

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
ChangeSolverType "HF Frequency Domain"

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0" 
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

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
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
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
     .XPeriodicShift "0.0"
     .YPeriodicShift "0.0"
     .ZPeriodicShift "0.0"
     .PeriodicUseConstantAngles "True"
     .SetPeriodicBoundaryAngles "theta", "phi"
     .SetPeriodicBoundaryAnglesDirection "inward"
     .UnitCellFitToBoundingBox "True"
     .UnitCellDs1 "0.0"
     .UnitCellDs2 "0.0"
     .UnitCellAngle "90.0"
End With

'@ define farfield monitor: farfield (f=24)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=24)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "24" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-1.65", "1.65", "-1.65", "1.65", "0", "0.795" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .EnableNearfieldCalculation "True" 
     .Create 
End With

'@ define farfield monitor: farfield (f=30)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=30)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "30" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-1.65", "1.65", "-1.65", "1.65", "0", "0.795" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .EnableNearfieldCalculation "True" 
     .Create 
End With

'@ define farfield monitor: farfield (f=38)

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Monitor 
     .Reset 
     .Name "farfield (f=38)" 
     .Domain "Frequency" 
     .FieldType "Farfield" 
     .MonitorValue "38" 
     .ExportFarfieldSource "False" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-1.65", "1.65", "-1.65", "1.65", "0", "0.795" 
     .SetSubvolumeOffset "10", "10", "10", "10", "10", "10" 
     .SetSubvolumeInflateWithOffset "False" 
     .SetSubvolumeOffsetType "FractionOfWavelength" 
     .EnableNearfieldCalculation "True" 
     .Create 
End With

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

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "False" 
     .SymmetricRange "False" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Efield" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

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

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Efield" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ define pml specials

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .ReflectionLevel "0.0001" 
     .MinimumDistanceType "Fraction" 
     .MinimumDistancePerWavelengthNewMeshEngine "4" 
     .MinimumDistanceReferenceFrequencyType "Center" 
     .FrequencyForMinimumDistance "30" 
     .SetAbsoluteDistance "0.0" 
End With

'@ define boundaries

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .OpenAddSpaceFactor "0.5"
End With

'@ define port: 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "17.348270483333"
     .Yrange "-17.348270483333", "4.1482704833333"
     .Zrange "3.2932704833333", "3.2932704833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define port: 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmin"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "17.348270483333"
     .Yrange "-17.348270483333", "4.1482704833333"
     .Zrange "-2.4982704833333", "-2.4982704833333"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "7.5" 
     .ZmaxSpace "7.5" 
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

'@ change solver type

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
ChangeSolverType "HF Time Domain"

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Efield" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "directional_circular" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "ludwig3" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Circular" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ define frequency range

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solver.FrequencyRange "15", "45"

'@ define background

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "7.5" 
     .ZmaxSpace "7.5" 
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

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "1"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "Efield" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ delete ports

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Port.Delete "1" 
Port.Delete "2"

'@ define plane wave properties

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With PlaneWave
     .Reset 
     .Normal "0", "0", "-1" 
     .EVector "1", "0", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "30" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-PLW"
     .StimulationPort "Plane wave"
     .StimulationMode "1"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ delete plane wave

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
PlaneWave.Delete

'@ define port: 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "33.848270483333"
     .Yrange "-33.848270483333", "4.1482704833333"
     .Zrange "8.295", "8.295"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define port: 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmin"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "33.848270483333"
     .Yrange "-33.848270483333", "4.1482704833333"
     .Zrange "-7.5", "-7.5"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ delete ports

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Port.Delete "1" 
Port.Delete "2"

'@ define plane wave properties

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With PlaneWave
     .Reset 
     .Normal "0", "0", "-1" 
     .EVector "1", "0", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "30" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-PLW"
     .StimulationPort "Plane wave"
     .StimulationMode "1"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ pick face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Pick.PickFaceFromId "component1:Dielectric", "1"

'@ align wcs with face

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.AlignWCSWithSelected "Face"

'@ transform: translate component1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Vector "3.3", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "15" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Transform 
     .Reset 
     .Name "component1" 
     .Vector "0", "-3.3", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "15" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_1"

'@ boolean add shapes: component1:Dielectric_10, component1:Dielectric_10_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10", "component1:Dielectric_10_1"

'@ boolean add shapes: component1:Dielectric_10_10, component1:Dielectric_10_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_10", "component1:Dielectric_10_11"

'@ boolean add shapes: component1:Dielectric_10_12, component1:Dielectric_10_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_12", "component1:Dielectric_10_13"

'@ boolean add shapes: component1:Dielectric_10_14, component1:Dielectric_10_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_14", "component1:Dielectric_10_15"

'@ boolean add shapes: component1:Dielectric_10_2, component1:Dielectric_10_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_2", "component1:Dielectric_10_3"

'@ boolean add shapes: component1:Dielectric_10_4, component1:Dielectric_10_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_4", "component1:Dielectric_10_5"

'@ boolean add shapes: component1:Dielectric_10_6, component1:Dielectric_10_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_6", "component1:Dielectric_10_7"

'@ boolean add shapes: component1:Dielectric_10_8, component1:Dielectric_10_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_8", "component1:Dielectric_10_9"

'@ boolean add shapes: component1:Dielectric_11, component1:Dielectric_11_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11", "component1:Dielectric_11_1"

'@ boolean add shapes: component1:Dielectric_11_10, component1:Dielectric_11_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_10", "component1:Dielectric_11_11"

'@ boolean add shapes: component1:Dielectric_11_12, component1:Dielectric_11_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_12", "component1:Dielectric_11_13"

'@ boolean add shapes: component1:Dielectric_11_14, component1:Dielectric_11_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_14", "component1:Dielectric_11_15"

'@ boolean add shapes: component1:Dielectric_11_2, component1:Dielectric_11_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_2", "component1:Dielectric_11_3"

'@ boolean add shapes: component1:Dielectric_11_4, component1:Dielectric_11_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_4", "component1:Dielectric_11_5"

'@ boolean add shapes: component1:Dielectric_11_6, component1:Dielectric_11_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_6", "component1:Dielectric_11_7"

'@ boolean add shapes: component1:Dielectric_11_8, component1:Dielectric_11_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_8", "component1:Dielectric_11_9"

'@ boolean add shapes: component1:Dielectric_12, component1:Dielectric_12_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12", "component1:Dielectric_12_1"

'@ boolean add shapes: component1:Dielectric_12_10, component1:Dielectric_12_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_10", "component1:Dielectric_12_11"

'@ boolean add shapes: component1:Dielectric_12_12, component1:Dielectric_12_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_12", "component1:Dielectric_12_13"

'@ boolean add shapes: component1:Dielectric_12_14, component1:Dielectric_12_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_14", "component1:Dielectric_12_15"

'@ boolean add shapes: component1:Dielectric_12_2, component1:Dielectric_12_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_2", "component1:Dielectric_12_3"

'@ boolean add shapes: component1:Dielectric_12_4, component1:Dielectric_12_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_4", "component1:Dielectric_12_5"

'@ boolean add shapes: component1:Dielectric_12_6, component1:Dielectric_12_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_6", "component1:Dielectric_12_7"

'@ boolean add shapes: component1:Dielectric_12_8, component1:Dielectric_12_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_8", "component1:Dielectric_12_9"

'@ boolean add shapes: component1:Dielectric_13, component1:Dielectric_13_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13", "component1:Dielectric_13_1"

'@ boolean add shapes: component1:Dielectric_13_10, component1:Dielectric_13_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_10", "component1:Dielectric_13_11"

'@ boolean add shapes: component1:Dielectric_13_12, component1:Dielectric_13_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_12", "component1:Dielectric_13_13"

'@ boolean add shapes: component1:Dielectric_13_14, component1:Dielectric_13_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_14", "component1:Dielectric_13_15"

'@ boolean add shapes: component1:Dielectric_13_2, component1:Dielectric_13_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_2", "component1:Dielectric_13_3"

'@ boolean add shapes: component1:Dielectric_13_4, component1:Dielectric_13_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_4", "component1:Dielectric_13_5"

'@ boolean add shapes: component1:Dielectric_13_6, component1:Dielectric_13_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_6", "component1:Dielectric_13_7"

'@ boolean add shapes: component1:Dielectric_13_8, component1:Dielectric_13_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_8", "component1:Dielectric_13_9"

'@ boolean add shapes: component1:Dielectric_14, component1:Dielectric_14_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14", "component1:Dielectric_14_1"

'@ boolean add shapes: component1:Dielectric_14_10, component1:Dielectric_14_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_10", "component1:Dielectric_14_11"

'@ boolean add shapes: component1:Dielectric_14_12, component1:Dielectric_14_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_12", "component1:Dielectric_14_13"

'@ boolean add shapes: component1:Dielectric_14_14, component1:Dielectric_14_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_14", "component1:Dielectric_14_15"

'@ boolean add shapes: component1:Dielectric_14_2, component1:Dielectric_14_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_2", "component1:Dielectric_14_3"

'@ boolean add shapes: component1:Dielectric_14_4, component1:Dielectric_14_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_4", "component1:Dielectric_14_5"

'@ boolean add shapes: component1:Dielectric_14_6, component1:Dielectric_14_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_6", "component1:Dielectric_14_7"

'@ boolean add shapes: component1:Dielectric_14_8, component1:Dielectric_14_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_8", "component1:Dielectric_14_9"

'@ boolean add shapes: component1:Dielectric_15, component1:Dielectric_15_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15", "component1:Dielectric_15_1"

'@ boolean add shapes: component1:Dielectric_15_10, component1:Dielectric_15_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_10", "component1:Dielectric_15_11"

'@ boolean add shapes: component1:Dielectric_15_12, component1:Dielectric_15_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_12", "component1:Dielectric_15_13"

'@ boolean add shapes: component1:Dielectric_15_14, component1:Dielectric_15_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_14", "component1:Dielectric_15_15"

'@ boolean add shapes: component1:Dielectric_15_2, component1:Dielectric_15_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_2", "component1:Dielectric_15_3"

'@ boolean add shapes: component1:Dielectric_15_4, component1:Dielectric_15_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_4", "component1:Dielectric_15_5"

'@ boolean add shapes: component1:Dielectric_15_6, component1:Dielectric_15_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_6", "component1:Dielectric_15_7"

'@ boolean add shapes: component1:Dielectric_15_8, component1:Dielectric_15_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_8", "component1:Dielectric_15_9"

'@ boolean add shapes: component1:Dielectric_16, component1:Dielectric_17

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_16", "component1:Dielectric_17"

'@ boolean add shapes: component1:Dielectric_18, component1:Dielectric_19

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_18", "component1:Dielectric_19"

'@ boolean add shapes: component1:Dielectric_1_1, component1:Dielectric_1_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_1", "component1:Dielectric_1_10"

'@ boolean add shapes: component1:Dielectric_1_11, component1:Dielectric_1_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_11", "component1:Dielectric_1_12"

'@ boolean add shapes: component1:Dielectric_1_13, component1:Dielectric_1_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_13", "component1:Dielectric_1_14"

'@ boolean add shapes: component1:Dielectric_1_15, component1:Dielectric_1_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_15", "component1:Dielectric_1_2"

'@ boolean add shapes: component1:Dielectric_1_3, component1:Dielectric_1_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_3", "component1:Dielectric_1_4"

'@ boolean add shapes: component1:Dielectric_1_5, component1:Dielectric_1_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_5", "component1:Dielectric_1_6"

'@ boolean add shapes: component1:Dielectric_1_7, component1:Dielectric_1_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_7", "component1:Dielectric_1_8"

'@ boolean add shapes: component1:Dielectric_1_9, component1:Dielectric_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_9", "component1:Dielectric_2"

'@ boolean add shapes: component1:Dielectric_20, component1:Dielectric_21

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_20", "component1:Dielectric_21"

'@ boolean add shapes: component1:Dielectric_22, component1:Dielectric_23

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_22", "component1:Dielectric_23"

'@ boolean add shapes: component1:Dielectric_24, component1:Dielectric_25

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_24", "component1:Dielectric_25"

'@ boolean add shapes: component1:Dielectric_26, component1:Dielectric_27

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_26", "component1:Dielectric_27"

'@ boolean add shapes: component1:Dielectric_28, component1:Dielectric_29

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_28", "component1:Dielectric_29"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_2_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_2_10"

'@ boolean add shapes: component1:Dielectric_2_11, component1:Dielectric_2_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_11", "component1:Dielectric_2_12"

'@ boolean add shapes: component1:Dielectric_2_13, component1:Dielectric_2_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_13", "component1:Dielectric_2_14"

'@ boolean add shapes: component1:Dielectric_2_15, component1:Dielectric_2_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_15", "component1:Dielectric_2_2"

'@ boolean add shapes: component1:Dielectric_2_3, component1:Dielectric_2_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_3", "component1:Dielectric_2_4"

'@ boolean add shapes: component1:Dielectric_2_5, component1:Dielectric_2_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_5", "component1:Dielectric_2_6"

'@ boolean add shapes: component1:Dielectric_2_7, component1:Dielectric_2_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_7", "component1:Dielectric_2_8"

'@ boolean add shapes: component1:Dielectric_2_9, component1:Dielectric_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_9", "component1:Dielectric_3"

'@ boolean add shapes: component1:Dielectric_30, component1:Dielectric_3_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_30", "component1:Dielectric_3_1"

'@ boolean add shapes: component1:Dielectric_3_10, component1:Dielectric_3_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_10", "component1:Dielectric_3_11"

'@ boolean add shapes: component1:Dielectric_3_12, component1:Dielectric_3_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_12", "component1:Dielectric_3_13"

'@ boolean add shapes: component1:Dielectric_3_14, component1:Dielectric_3_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_14", "component1:Dielectric_3_15"

'@ boolean add shapes: component1:Dielectric_3_2, component1:Dielectric_3_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_2", "component1:Dielectric_3_3"

'@ boolean add shapes: component1:Dielectric_3_4, component1:Dielectric_3_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_4", "component1:Dielectric_3_5"

'@ boolean add shapes: component1:Dielectric_3_6, component1:Dielectric_3_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_6", "component1:Dielectric_3_7"

'@ boolean add shapes: component1:Dielectric_3_8, component1:Dielectric_3_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_8", "component1:Dielectric_3_9"

'@ boolean add shapes: component1:Dielectric_4, component1:Dielectric_4_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4", "component1:Dielectric_4_1"

'@ boolean add shapes: component1:Dielectric_4_10, component1:Dielectric_4_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_10", "component1:Dielectric_4_11"

'@ boolean add shapes: component1:Dielectric_4_12, component1:Dielectric_4_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_12", "component1:Dielectric_4_13"

'@ boolean add shapes: component1:Dielectric_4_14, component1:Dielectric_4_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_14", "component1:Dielectric_4_15"

'@ boolean add shapes: component1:Dielectric_4_2, component1:Dielectric_4_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_2", "component1:Dielectric_4_3"

'@ boolean add shapes: component1:Dielectric_4_4, component1:Dielectric_4_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_4", "component1:Dielectric_4_5"

'@ boolean add shapes: component1:Dielectric_4_6, component1:Dielectric_4_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_6", "component1:Dielectric_4_7"

'@ boolean add shapes: component1:Dielectric_4_8, component1:Dielectric_4_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_8", "component1:Dielectric_4_9"

'@ boolean add shapes: component1:Dielectric_5, component1:Dielectric_5_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5", "component1:Dielectric_5_1"

'@ boolean add shapes: component1:Dielectric_5_10, component1:Dielectric_5_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_10", "component1:Dielectric_5_11"

'@ boolean add shapes: component1:Dielectric_5_12, component1:Dielectric_5_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_12", "component1:Dielectric_5_13"

'@ boolean add shapes: component1:Dielectric_5_14, component1:Dielectric_5_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_14", "component1:Dielectric_5_15"

'@ boolean add shapes: component1:Dielectric_5_2, component1:Dielectric_5_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_2", "component1:Dielectric_5_3"

'@ boolean add shapes: component1:Dielectric_5_4, component1:Dielectric_5_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_4", "component1:Dielectric_5_5"

'@ boolean add shapes: component1:Dielectric_5_6, component1:Dielectric_5_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_6", "component1:Dielectric_5_7"

'@ boolean add shapes: component1:Dielectric_5_8, component1:Dielectric_5_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_8", "component1:Dielectric_5_9"

'@ boolean add shapes: component1:Dielectric_6, component1:Dielectric_6_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6", "component1:Dielectric_6_1"

'@ boolean add shapes: component1:Dielectric_6_10, component1:Dielectric_6_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_10", "component1:Dielectric_6_11"

'@ boolean add shapes: component1:Dielectric_6_12, component1:Dielectric_6_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_12", "component1:Dielectric_6_13"

'@ boolean add shapes: component1:Dielectric_6_14, component1:Dielectric_6_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_14", "component1:Dielectric_6_15"

'@ boolean add shapes: component1:Dielectric_6_2, component1:Dielectric_6_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_2", "component1:Dielectric_6_3"

'@ boolean add shapes: component1:Dielectric_6_4, component1:Dielectric_6_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_4", "component1:Dielectric_6_5"

'@ boolean add shapes: component1:Dielectric_6_6, component1:Dielectric_6_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_6", "component1:Dielectric_6_7"

'@ boolean add shapes: component1:Dielectric_6_8, component1:Dielectric_6_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_8", "component1:Dielectric_6_9"

'@ boolean add shapes: component1:Dielectric_7, component1:Dielectric_7_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7", "component1:Dielectric_7_1"

'@ boolean add shapes: component1:Dielectric_7_10, component1:Dielectric_7_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_10", "component1:Dielectric_7_11"

'@ boolean add shapes: component1:Dielectric_7_12, component1:Dielectric_7_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_12", "component1:Dielectric_7_13"

'@ boolean add shapes: component1:Dielectric_7_14, component1:Dielectric_7_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_14", "component1:Dielectric_7_15"

'@ boolean add shapes: component1:Dielectric_7_2, component1:Dielectric_7_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_2", "component1:Dielectric_7_3"

'@ boolean add shapes: component1:Dielectric_7_4, component1:Dielectric_7_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_4", "component1:Dielectric_7_5"

'@ boolean add shapes: component1:Dielectric_7_6, component1:Dielectric_7_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_6", "component1:Dielectric_7_7"

'@ boolean add shapes: component1:Dielectric_7_8, component1:Dielectric_7_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_8", "component1:Dielectric_7_9"

'@ boolean add shapes: component1:Dielectric_8, component1:Dielectric_8_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8", "component1:Dielectric_8_1"

'@ boolean add shapes: component1:Dielectric_8_10, component1:Dielectric_8_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_10", "component1:Dielectric_8_11"

'@ boolean add shapes: component1:Dielectric_8_12, component1:Dielectric_8_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_12", "component1:Dielectric_8_13"

'@ boolean add shapes: component1:Dielectric_8_14, component1:Dielectric_8_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_14", "component1:Dielectric_8_15"

'@ boolean add shapes: component1:Dielectric_8_2, component1:Dielectric_8_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_2", "component1:Dielectric_8_3"

'@ boolean add shapes: component1:Dielectric_8_4, component1:Dielectric_8_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_4", "component1:Dielectric_8_5"

'@ boolean add shapes: component1:Dielectric_8_6, component1:Dielectric_8_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_6", "component1:Dielectric_8_7"

'@ boolean add shapes: component1:Dielectric_8_8, component1:Dielectric_8_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_8", "component1:Dielectric_8_9"

'@ boolean add shapes: component1:Dielectric_9, component1:Dielectric_9_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9", "component1:Dielectric_9_1"

'@ boolean add shapes: component1:Dielectric_9_10, component1:Dielectric_9_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_10", "component1:Dielectric_9_11"

'@ boolean add shapes: component1:Dielectric_9_12, component1:Dielectric_9_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_12", "component1:Dielectric_9_13"

'@ boolean add shapes: component1:Dielectric_9_14, component1:Dielectric_9_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_14", "component1:Dielectric_9_15"

'@ boolean add shapes: component1:Dielectric_9_2, component1:Dielectric_9_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_2", "component1:Dielectric_9_3"

'@ boolean add shapes: component1:Dielectric_9_4, component1:Dielectric_9_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_4", "component1:Dielectric_9_5"

'@ boolean add shapes: component1:Dielectric_9_6, component1:Dielectric_9_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_6", "component1:Dielectric_9_7"

'@ boolean add shapes: component1:Dielectric_9_8, component1:Dielectric_9_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_8", "component1:Dielectric_9_9"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_10"

'@ boolean add shapes: component1:Dielectric_10_10, component1:Dielectric_10_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_10", "component1:Dielectric_10_12"

'@ boolean add shapes: component1:Dielectric_10_14, component1:Dielectric_10_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_14", "component1:Dielectric_10_2"

'@ boolean add shapes: component1:Dielectric_10_4, component1:Dielectric_10_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_4", "component1:Dielectric_10_6"

'@ boolean add shapes: component1:Dielectric_10_8, component1:Dielectric_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_8", "component1:Dielectric_11"

'@ boolean add shapes: component1:Dielectric_11_10, component1:Dielectric_11_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_10", "component1:Dielectric_11_12"

'@ boolean add shapes: component1:Dielectric_11_14, component1:Dielectric_11_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_14", "component1:Dielectric_11_2"

'@ boolean add shapes: component1:Dielectric_11_4, component1:Dielectric_11_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_4", "component1:Dielectric_11_6"

'@ boolean add shapes: component1:Dielectric_11_8, component1:Dielectric_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_8", "component1:Dielectric_12"

'@ boolean add shapes: component1:Dielectric_12_10, component1:Dielectric_12_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_10", "component1:Dielectric_12_12"

'@ boolean add shapes: component1:Dielectric_12_14, component1:Dielectric_12_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_14", "component1:Dielectric_12_2"

'@ boolean add shapes: component1:Dielectric_12_4, component1:Dielectric_12_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_4", "component1:Dielectric_12_6"

'@ boolean add shapes: component1:Dielectric_12_8, component1:Dielectric_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_8", "component1:Dielectric_13"

'@ boolean add shapes: component1:Dielectric_13_10, component1:Dielectric_13_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_10", "component1:Dielectric_13_12"

'@ boolean add shapes: component1:Dielectric_13_14, component1:Dielectric_13_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_14", "component1:Dielectric_13_2"

'@ boolean add shapes: component1:Dielectric_13_4, component1:Dielectric_13_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_4", "component1:Dielectric_13_6"

'@ boolean add shapes: component1:Dielectric_13_8, component1:Dielectric_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_8", "component1:Dielectric_14"

'@ boolean add shapes: component1:Dielectric_14_10, component1:Dielectric_14_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_10", "component1:Dielectric_14_12"

'@ boolean add shapes: component1:Dielectric_14_14, component1:Dielectric_14_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_14", "component1:Dielectric_14_2"

'@ boolean add shapes: component1:Dielectric_14_4, component1:Dielectric_14_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_4", "component1:Dielectric_14_6"

'@ boolean add shapes: component1:Dielectric_14_8, component1:Dielectric_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_8", "component1:Dielectric_15"

'@ boolean add shapes: component1:Dielectric_15_10, component1:Dielectric_15_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_10", "component1:Dielectric_15_12"

'@ boolean add shapes: component1:Dielectric_15_14, component1:Dielectric_15_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_14", "component1:Dielectric_15_2"

'@ boolean add shapes: component1:Dielectric_15_4, component1:Dielectric_15_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_4", "component1:Dielectric_15_6"

'@ boolean add shapes: component1:Dielectric_15_8, component1:Dielectric_16

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_8", "component1:Dielectric_16"

'@ boolean add shapes: component1:Dielectric_18, component1:Dielectric_1_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_18", "component1:Dielectric_1_1"

'@ boolean add shapes: component1:Dielectric_1_11, component1:Dielectric_1_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_11", "component1:Dielectric_1_13"

'@ boolean add shapes: component1:Dielectric_1_15, component1:Dielectric_1_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_15", "component1:Dielectric_1_3"

'@ boolean add shapes: component1:Dielectric_1_5, component1:Dielectric_1_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_5", "component1:Dielectric_1_7"

'@ boolean add shapes: component1:Dielectric_1_9, component1:Dielectric_20

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_9", "component1:Dielectric_20"

'@ boolean add shapes: component1:Dielectric_22, component1:Dielectric_24

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_22", "component1:Dielectric_24"

'@ boolean add shapes: component1:Dielectric_26, component1:Dielectric_28

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_26", "component1:Dielectric_28"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_2_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_2_11"

'@ boolean add shapes: component1:Dielectric_2_13, component1:Dielectric_2_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_13", "component1:Dielectric_2_15"

'@ boolean add shapes: component1:Dielectric_2_3, component1:Dielectric_2_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_3", "component1:Dielectric_2_5"

'@ boolean add shapes: component1:Dielectric_2_7, component1:Dielectric_2_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_7", "component1:Dielectric_2_9"

'@ boolean add shapes: component1:Dielectric_30, component1:Dielectric_3_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_30", "component1:Dielectric_3_10"

'@ boolean add shapes: component1:Dielectric_3_12, component1:Dielectric_3_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_12", "component1:Dielectric_3_14"

'@ boolean add shapes: component1:Dielectric_3_2, component1:Dielectric_3_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_2", "component1:Dielectric_3_4"

'@ boolean add shapes: component1:Dielectric_3_6, component1:Dielectric_3_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_6", "component1:Dielectric_3_8"

'@ boolean add shapes: component1:Dielectric_4, component1:Dielectric_4_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4", "component1:Dielectric_4_10"

'@ boolean add shapes: component1:Dielectric_4_12, component1:Dielectric_4_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_12", "component1:Dielectric_4_14"

'@ boolean add shapes: component1:Dielectric_4_2, component1:Dielectric_4_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_2", "component1:Dielectric_4_4"

'@ boolean add shapes: component1:Dielectric_4_6, component1:Dielectric_4_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_6", "component1:Dielectric_4_8"

'@ boolean add shapes: component1:Dielectric_5, component1:Dielectric_5_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5", "component1:Dielectric_5_10"

'@ boolean add shapes: component1:Dielectric_5_12, component1:Dielectric_5_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_12", "component1:Dielectric_5_14"

'@ boolean add shapes: component1:Dielectric_5_2, component1:Dielectric_5_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_2", "component1:Dielectric_5_4"

'@ boolean add shapes: component1:Dielectric_5_6, component1:Dielectric_5_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_6", "component1:Dielectric_5_8"

'@ boolean add shapes: component1:Dielectric_6, component1:Dielectric_6_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6", "component1:Dielectric_6_10"

'@ boolean add shapes: component1:Dielectric_6_12, component1:Dielectric_6_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_12", "component1:Dielectric_6_14"

'@ boolean add shapes: component1:Dielectric_6_2, component1:Dielectric_6_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_2", "component1:Dielectric_6_4"

'@ boolean add shapes: component1:Dielectric_6_6, component1:Dielectric_6_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_6", "component1:Dielectric_6_8"

'@ boolean add shapes: component1:Dielectric_7, component1:Dielectric_7_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7", "component1:Dielectric_7_10"

'@ boolean add shapes: component1:Dielectric_7_12, component1:Dielectric_7_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_12", "component1:Dielectric_7_14"

'@ boolean add shapes: component1:Dielectric_7_2, component1:Dielectric_7_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_2", "component1:Dielectric_7_4"

'@ boolean add shapes: component1:Dielectric_7_6, component1:Dielectric_7_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_6", "component1:Dielectric_7_8"

'@ boolean add shapes: component1:Dielectric_8, component1:Dielectric_8_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8", "component1:Dielectric_8_10"

'@ boolean add shapes: component1:Dielectric_8_12, component1:Dielectric_8_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_12", "component1:Dielectric_8_14"

'@ boolean add shapes: component1:Dielectric_8_2, component1:Dielectric_8_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_2", "component1:Dielectric_8_4"

'@ boolean add shapes: component1:Dielectric_8_6, component1:Dielectric_8_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_6", "component1:Dielectric_8_8"

'@ boolean add shapes: component1:Dielectric_9, component1:Dielectric_9_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9", "component1:Dielectric_9_10"

'@ boolean add shapes: component1:Dielectric_9_12, component1:Dielectric_9_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_12", "component1:Dielectric_9_14"

'@ boolean add shapes: component1:Dielectric_9_2, component1:Dielectric_9_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_2", "component1:Dielectric_9_4"

'@ boolean add shapes: component1:Dielectric_9_6, component1:Dielectric_9_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_6", "component1:Dielectric_9_8"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_10_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_10_10"

'@ boolean add shapes: component1:Dielectric_10_14, component1:Dielectric_10_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_14", "component1:Dielectric_10_4"

'@ boolean add shapes: component1:Dielectric_10_8, component1:Dielectric_11_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_8", "component1:Dielectric_11_10"

'@ boolean add shapes: component1:Dielectric_11_14, component1:Dielectric_11_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_14", "component1:Dielectric_11_4"

'@ boolean add shapes: component1:Dielectric_11_8, component1:Dielectric_12_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_8", "component1:Dielectric_12_10"

'@ boolean add shapes: component1:Dielectric_12_14, component1:Dielectric_12_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_14", "component1:Dielectric_12_4"

'@ boolean add shapes: component1:Dielectric_12_8, component1:Dielectric_13_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_8", "component1:Dielectric_13_10"

'@ boolean add shapes: component1:Dielectric_13_14, component1:Dielectric_13_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_14", "component1:Dielectric_13_4"

'@ boolean add shapes: component1:Dielectric_13_8, component1:Dielectric_14_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_8", "component1:Dielectric_14_10"

'@ boolean add shapes: component1:Dielectric_14_14, component1:Dielectric_14_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_14", "component1:Dielectric_14_4"

'@ boolean add shapes: component1:Dielectric_14_8, component1:Dielectric_15_10

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_8", "component1:Dielectric_15_10"

'@ boolean add shapes: component1:Dielectric_15_14, component1:Dielectric_15_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_14", "component1:Dielectric_15_4"

'@ boolean add shapes: component1:Dielectric_15_8, component1:Dielectric_18

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_8", "component1:Dielectric_18"

'@ boolean add shapes: component1:Dielectric_1_11, component1:Dielectric_1_15

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_11", "component1:Dielectric_1_15"

'@ boolean add shapes: component1:Dielectric_1_5, component1:Dielectric_1_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_5", "component1:Dielectric_1_9"

'@ boolean add shapes: component1:Dielectric_22, component1:Dielectric_26

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_22", "component1:Dielectric_26"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_2_13

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_2_13"

'@ boolean add shapes: component1:Dielectric_2_3, component1:Dielectric_2_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_3", "component1:Dielectric_2_7"

'@ boolean add shapes: component1:Dielectric_30, component1:Dielectric_3_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_30", "component1:Dielectric_3_12"

'@ boolean add shapes: component1:Dielectric_3_2, component1:Dielectric_3_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_3_2", "component1:Dielectric_3_6"

'@ boolean add shapes: component1:Dielectric_4, component1:Dielectric_4_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4", "component1:Dielectric_4_12"

'@ boolean add shapes: component1:Dielectric_4_2, component1:Dielectric_4_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4_2", "component1:Dielectric_4_6"

'@ boolean add shapes: component1:Dielectric_5, component1:Dielectric_5_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5", "component1:Dielectric_5_12"

'@ boolean add shapes: component1:Dielectric_5_2, component1:Dielectric_5_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5_2", "component1:Dielectric_5_6"

'@ boolean add shapes: component1:Dielectric_6, component1:Dielectric_6_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6", "component1:Dielectric_6_12"

'@ boolean add shapes: component1:Dielectric_6_2, component1:Dielectric_6_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6_2", "component1:Dielectric_6_6"

'@ boolean add shapes: component1:Dielectric_7, component1:Dielectric_7_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7", "component1:Dielectric_7_12"

'@ boolean add shapes: component1:Dielectric_7_2, component1:Dielectric_7_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7_2", "component1:Dielectric_7_6"

'@ boolean add shapes: component1:Dielectric_8, component1:Dielectric_8_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8", "component1:Dielectric_8_12"

'@ boolean add shapes: component1:Dielectric_8_2, component1:Dielectric_8_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8_2", "component1:Dielectric_8_6"

'@ boolean add shapes: component1:Dielectric_9, component1:Dielectric_9_12

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9", "component1:Dielectric_9_12"

'@ boolean add shapes: component1:Dielectric_9_2, component1:Dielectric_9_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9_2", "component1:Dielectric_9_6"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_10_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_10_14"

'@ boolean add shapes: component1:Dielectric_10_8, component1:Dielectric_11_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_10_8", "component1:Dielectric_11_14"

'@ boolean add shapes: component1:Dielectric_11_8, component1:Dielectric_12_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_8", "component1:Dielectric_12_14"

'@ boolean add shapes: component1:Dielectric_12_8, component1:Dielectric_13_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_12_8", "component1:Dielectric_13_14"

'@ boolean add shapes: component1:Dielectric_13_8, component1:Dielectric_14_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_8", "component1:Dielectric_14_14"

'@ boolean add shapes: component1:Dielectric_14_8, component1:Dielectric_15_14

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_14_8", "component1:Dielectric_15_14"

'@ boolean add shapes: component1:Dielectric_15_8, component1:Dielectric_1_11

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_8", "component1:Dielectric_1_11"

'@ boolean add shapes: component1:Dielectric_1_5, component1:Dielectric_22

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_1_5", "component1:Dielectric_22"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_2_3

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_2_3"

'@ boolean add shapes: component1:Dielectric_30, component1:Dielectric_3_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_30", "component1:Dielectric_3_2"

'@ boolean add shapes: component1:Dielectric_4, component1:Dielectric_4_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4", "component1:Dielectric_4_2"

'@ boolean add shapes: component1:Dielectric_5, component1:Dielectric_5_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_5", "component1:Dielectric_5_2"

'@ boolean add shapes: component1:Dielectric_6, component1:Dielectric_6_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6", "component1:Dielectric_6_2"

'@ boolean add shapes: component1:Dielectric_7, component1:Dielectric_7_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_7", "component1:Dielectric_7_2"

'@ boolean add shapes: component1:Dielectric_8, component1:Dielectric_8_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8", "component1:Dielectric_8_2"

'@ boolean add shapes: component1:Dielectric_9, component1:Dielectric_9_2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_9", "component1:Dielectric_9_2"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_10_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_10_8"

'@ boolean add shapes: component1:Dielectric_11_8, component1:Dielectric_12_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_11_8", "component1:Dielectric_12_8"

'@ boolean add shapes: component1:Dielectric_13_8, component1:Dielectric_14_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_8", "component1:Dielectric_14_8"

'@ boolean add shapes: component1:Dielectric_15_8, component1:Dielectric_1_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_15_8", "component1:Dielectric_1_5"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_30

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_30"

'@ boolean add shapes: component1:Dielectric_4, component1:Dielectric_5

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_4", "component1:Dielectric_5"

'@ boolean add shapes: component1:Dielectric_6, component1:Dielectric_7

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6", "component1:Dielectric_7"

'@ boolean add shapes: component1:Dielectric_8, component1:Dielectric_9

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_8", "component1:Dielectric_9"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_11_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_11_8"

'@ boolean add shapes: component1:Dielectric_13_8, component1:Dielectric_15_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_13_8", "component1:Dielectric_15_8"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_4

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_4"

'@ boolean add shapes: component1:Dielectric_6, component1:Dielectric_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_6", "component1:Dielectric_8"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_13_8

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_13_8"

'@ boolean add shapes: component1:Dielectric_2_1, component1:Dielectric_6

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric_2_1", "component1:Dielectric_6"

'@ boolean add shapes: component1:Dielectric, component1:Dielectric_2_1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Solid.Add "component1:Dielectric", "component1:Dielectric_2_1"

'@ activate global coordinates

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
WCS.ActivateWCS "global"

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ delete plane wave

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
PlaneWave.Delete

'@ define port: 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "53.648270483333"
     .Yrange "-53.648270483333", "4.1482704833333"
     .Zrange "8.295", "8.295"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define port: 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmin"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "53.648270483333"
     .Yrange "-53.648270483333", "4.1482704833333"
     .Zrange "-7.5", "-7.5"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "All"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ define pml specials

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Boundary
     .ReflectionLevel "0.0001" 
     .MinimumDistanceType "Fraction" 
     .MinimumDistancePerWavelengthNewMeshEngine "4" 
     .MinimumDistanceReferenceFrequencyType "Center" 
     .FrequencyForMinimumDistance "30" 
     .SetAbsoluteDistance "0.0" 
End With

'@ modify port: 1

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "53.648270483333"
     .Yrange "-53.648270483333", "4.1482704833333"
     .Zrange "8.295", "8.295"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ modify port: 2

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmin"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-4.1482704833333", "53.648270483333"
     .Yrange "-53.648270483333", "4.1482704833333"
     .Zrange "-7.5", "-7.5"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ delete ports

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Port.Delete "1" 
Port.Delete "2"

'@ define plane wave properties

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With PlaneWave
     .Reset 
     .Normal "0.5", "0", "-0.866" 
     .EVector "0", "1", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "30" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ define time domain solver parameters

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-PLW"
     .StimulationPort "Plane wave"
     .StimulationMode "1"
     .SteadyStateLimit "-50"
     .MeshAdaption "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ define plane wave properties

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With PlaneWave
     .Reset 
     .Normal "-0.866", "0", "0.5" 
     .EVector "0", "1", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "30" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Cartesian" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ define plane wave properties

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With PlaneWave
     .Reset 
     .Normal "0", "0", "-1" 
     .EVector "0", "1", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "30" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "False" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

'@ define plane wave properties

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With PlaneWave
     .Reset 
     .Normal "0", "0", "-1" 
     .EVector "1", "0", "0" 
     .Polarization "Linear" 
     .ReferenceFrequency "30" 
     .PhaseDifference "-90.0" 
     .CircularDirection "Left" 
     .AxialRatio "0.0" 
     .SetUserDecouplingPlane "False" 
     .Store
End With

'@ farfield plot options

'[VERSION]2021.1|30.0.1|20201110[/VERSION]
With FarfieldPlot 
     .Plottype "Polar" 
     .Vary "angle1" 
     .Theta "0" 
     .Phi "0" 
     .Step "1" 
     .Step2 "1" 
     .SetLockSteps "True" 
     .SetPlotRangeOnly "False" 
     .SetThetaStart "0" 
     .SetThetaEnd "180" 
     .SetPhiStart "0" 
     .SetPhiEnd "360" 
     .SetTheta360 "True" 
     .SymmetricRange "True" 
     .SetTimeDomainFF "False" 
     .SetFrequency "24" 
     .SetTime "0" 
     .SetColorByValue "True" 
     .DrawStepLines "False" 
     .DrawIsoLongitudeLatitudeLines "False" 
     .ShowStructure "False" 
     .ShowStructureProfile "False" 
     .SetStructureTransparent "False" 
     .SetFarfieldTransparent "False" 
     .AspectRatio "Free" 
     .ShowGridlines "True" 
     .SetSpecials "enablepolarextralines" 
     .SetPlotMode "RCS" 
     .Distance "1" 
     .UseFarfieldApproximation "True" 
     .IncludeUnitCellSidewalls "True" 
     .SetScaleLinear "True" 
     .SetLogRange "40" 
     .SetLogNorm "0" 
     .DBUnit "0" 
     .SetMaxReferenceMode "abs" 
     .EnableFixPlotMaximum "False" 
     .SetFixPlotMaximumValue "1" 
     .SetInverseAxialRatio "False" 
     .SetAxesType "user" 
     .SetAntennaType "isotropic" 
     .Phistart "1.000000e+00", "0.000000e+00", "0.000000e+00" 
     .Thetastart "0.000000e+00", "0.000000e+00", "1.000000e+00" 
     .PolarizationVector "0.000000e+00", "1.000000e+00", "0.000000e+00" 
     .SetCoordinateSystemType "spherical" 
     .SetAutomaticCoordinateSystem "True" 
     .SetPolarizationType "Abs" 
     .SlantAngle 0.000000e+00 
     .Origin "bbox" 
     .Userorigin "0.000000e+00", "0.000000e+00", "0.000000e+00" 
     .SetUserDecouplingPlane "False" 
     .UseDecouplingPlane "False" 
     .DecouplingPlaneAxis "X" 
     .DecouplingPlanePosition "0.000000e+00" 
     .LossyGround "False" 
     .GroundEpsilon "1" 
     .GroundKappa "0" 
     .EnablePhaseCenterCalculation "False" 
     .SetPhaseCenterAngularLimit "3.000000e+01" 
     .SetPhaseCenterComponent "boresight" 
     .SetPhaseCenterPlane "both" 
     .ShowPhaseCenter "True" 
     .ClearCuts 

     .StoreSettings
End With

