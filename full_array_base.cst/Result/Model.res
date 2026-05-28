MWS Result File Version 20150206
size=i:41

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:Directivity, constant Theta=90.rd1

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:RefSpectrum_pw.sig

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:solverstart
result=s:0
files=s:PBAConnectivity.axg

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:solverstart
result=s:0
files=s:PBAMeshFeedback.axg

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:World.fid

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:survivemeshadapt
result=s:1
files=s:model.gex

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:survivemeshadapt
result=s:1
files=s:PP.sid

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:survivemeshadapt
result=s:1
files=s:PP.fmm

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
files=s:ml_info.dat

type=s:HIDDENITEM
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:persistent
result=s:0
files=s:MCalcAccess.log

type=s:FOLDER
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:Low Frequency:4:3
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:Excitation Signals\default
files=s:signal_default_lf.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s:High Frequency:0:0
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:Excitation Signals\default
files=s:signal_default.sig

type=s:MESH_FEEDBACK
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:Mesh\Information\PBA
files=s:PBAMeshFeedback.rex
ylabel=s:Mesh Feedback

type=s:MESH_FEEDBACK
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:Mesh\Information\Connectivity
files=s:PBAConnectivity.rex
ylabel=s:Mesh Feedback

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Port signals\Plane wave
files=s:plw.sig

type=s:XYSIGNAL2
subtype=s:energy
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Energy\Energy [pw]
files=s:pw.eng

type=s:FARFIELD
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Farfields\farfield (f=24) [pw]
files=s:farfield (f=24)_pw.ffm
ylabel=s:farfield (f=24) [pw]

type=s:FARFIELD
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Farfields\farfield (f=30) [pw]
files=s:farfield (f=30)_pw.ffm
ylabel=s:farfield (f=30) [pw]

type=s:FARFIELD
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:Farfields\farfield (f=38) [pw]
files=s:farfield (f=38)_pw.ffm
ylabel=s:farfield (f=38) [pw]

type=s:XYSIGNAL2
subtype=s:complex
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Power\Excitation [pw]\Power Scattered
files=s:FarfieldMetaData_pw_RadPower.sig

type=s:XYSIGNAL2
subtype=s:linear
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Cross Sections\Total RCS [pw]
files=s:FarfieldMetaData_pw_TotRCS.sig

type=s:XYSIGNAL2
subtype=s:linear
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\Cross Sections\Total ACS [pw]
files=s:FarfieldMetaData_pw_TotACS.sig

type=s:FARFIELDPOLAR
subtype=s:farfield polar linear
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:Farfields\farfield (f=24) [pw]\farfield (f=24) [pw]
files=s:farfield (f=24) [pw].sig
xlabel=s:Theta / Degree
ylabel=s:dB(m^2)
title=s:Bistatic Scattering RCS Abs (Phi=0)

type=s:TABLE
subtype=s:farfield polar linear
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
treepath=s:Tables\1D Results\Directivity, constant Theta=90
files=s:Directivity, constant Theta=90.rt1
files=s:Directivity, constant Theta=90.rd1
title=s:Directivity, constant Theta=90
xlabel=s:Phi / Degree

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:rebuild
result=s:1
treepath=s:1D Results\AutomaticRunInformation
files=s:AutomaticRunInformation

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
parametric=s:P
treepath=s:1D Results\Port signals\Plane wave
files=s:plw.sig

type=s:XYSIGNAL2
subtype=s:energy
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
parametric=s:P
treepath=s:1D Results\Energy\Energy [pw]
files=s:pw.eng

type=s:XYSIGNAL2
subtype=s:complex
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
parametric=s:P
treepath=s:1D Results\Power\Excitation [pw]\Power Scattered
files=s:FarfieldMetaData_pw_RadPower.sig

type=s:XYSIGNAL2
subtype=s:linear
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
parametric=s:P
treepath=s:1D Results\Cross Sections\Total RCS [pw]
files=s:FarfieldMetaData_pw_TotRCS.sig

type=s:XYSIGNAL2
subtype=s:linear
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:surviveparchange
result=s:1
parametric=s:P
treepath=s:1D Results\Cross Sections\Total ACS [pw]
files=s:FarfieldMetaData_pw_TotACS.sig

type=s:RESULT_0D
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:surviveparchange
result=s:1
parametric=s:P
treepath=s:1D Results\AutomaticRunInformation
files=s:AutomaticRunInformation

type=s:FARFIELDPOLAR
subtype=s:farfield polar linear
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:Farfields\farfield (f=30) [pw]\farfield (f=30) [pw]
files=s:farfield (f=30) [pw].sig
xlabel=s:Theta / Degree
ylabel=s:m^2
title=s:Bistatic Scattering RCS Abs (Phi=0)

type=s:FARFIELDPOLAR
subtype=s:farfield polar linear
problemclass=s::8:1000
visibility=s:hidden
creation=s:internal
lifetime=s:solverstart
result=s:0
treepath=s:Farfields\farfield (f=38) [pw]\farfield (f=38) [pw]
files=s:farfield (f=38) [pw].sig
xlabel=s:Theta / Degree
ylabel=s:m^2
title=s:Bistatic Scattering RCS Abs (Phi=0)

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Arlon AD 250C (lossy)\Dispersive\Eps' (Fit)
files=s:Arlon AD 250C (lossy)_eps_re.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Arlon AD 250C (lossy)\Dispersive\Eps'' (Fit)
files=s:Arlon AD 250C (lossy)_eps_im.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Arlon AD 250C (lossy)\Dispersive\Eps TangD (Fit)
files=s:Arlon AD 250C (lossy)_eps_tgd.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Copper (annealed)\Surface Impedance\Z' (Fit)
files=s:Copper (annealed)_Z_re.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Copper (annealed)\Surface Impedance\Z'' (Fit)
files=s:Copper (annealed)_Z_im.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Copper (annealed)\Surface Impedance\Z' (Theory)
files=s:Copper (annealed)_Z_datalist_re.sig

type=s:XYSIGNAL2
subtype=s:user
problemclass=s::8:1000
visibility=s:visible
creation=s:internal
lifetime=s:persistent
result=s:0
treepath=s:1D Results\Materials\Copper (annealed)\Surface Impedance\Z'' (Theory)
files=s:Copper (annealed)_Z_datalist_im.sig

