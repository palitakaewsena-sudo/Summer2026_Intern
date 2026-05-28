'Language "WWB-COM"

Option Explicit

Sub Main()
    Dim ix As Integer, iy As Integer, n As Integer
    Dim dx As Double, dy As Double
    Dim shift_x As Double, shift_y As Double

    Dim x1 As Double, y1 As Double, z1 As Double
    Dim x2 As Double, y2 As Double, z2 As Double
    Dim m_var As String

    ' =========================================================================
    ' 🛠️ USER CONFIGURATION: CHANGE YOUR ARRAY SIZE HERE
    ' =========================================================================
    Dim Nx As Integer, Ny As Integer
    Nx = 32  ' Number of elements along the X-axis (Change as desired, e.g., 4, 8, 16, 32)
    Ny = 32  ' Number of elements along the Y-axis (Change as desired, e.g., 4, 8, 16, 32)
    ' =========================================================================

    ' --- Define Unit Cell Spacing / Pitch (5.5 x 5.5 mm) --- 
    dx = 5.5 [cite: 338]
    dy = 5.5 [cite: 338]

    ' --- Initial Coordinates of the first PIN Diode (Extracted from unitcell.txt) --- [cite: 339]
    Dim start_x1 As Double, start_x2 As Double
    Dim start_y1 As Double, start_y2 As Double
    Dim start_z1 As Double, start_z2 As Double

    start_x1 = 0.0 [cite: 339]
    start_x2 = 0.0 ' Adjusted to 0 to align with the actual physical center [cite: 339]
    start_y1 = -0.075 [cite: 339]
    start_y2 = 0.075 [cite: 339]
    start_z1 = 0.324 [cite: 339]
    start_z2 = 0.324 [cite: 339]

    n = 1 ' Element counter for diodes [cite: 339]

    ' --- The loops now dynamically change based on Nx and Ny values ---
    For iy = 1 To Ny
        For ix = 1 To Nx [cite: 340]

            ' Create digital phase state control parameters: m1, m2, ..., m_n
            m_var = "m" & CStr(n) [cite: 340]
            StoreParameter m_var, "1" [cite: 340]

            ' Calculate translation offset (Shift) for each cell in the array grid
            shift_x = (ix - 1) * dx [cite: 340]
            shift_y = -(iy - 1) * dy [cite: 341]

            ' --- Structural Replication Process (Skipping the initial unit block at 1,1) --- [cite: 341]
            If Not (ix = 1 And iy = 1) Then [cite: 341]

                ' Duplicate Substrate layer
                With Transform [cite: 341]
                    .Reset [cite: 342]
                    .Name "component1:Sub" [cite: 342]
                    .Vector Replace(CStr(shift_x), ",", "."), Replace(CStr(shift_y), ",", "."), "0" [cite: 342]
                    .MultipleObjects "True" [cite: 342]
                    .Repetitions "1" [cite: 342]
                    .Transform "Shape", "Translate" [cite: 343]
                End With [cite: 343]

                ' Duplicate front-side Copper patch
                With Transform [cite: 343]
                    .Reset [cite: 343]
                    .Name "component1:Copper" [cite: 344]
                    .Vector Replace(CStr(shift_x), ",", "."), Replace(CStr(shift_y), ",", "."), "0" [cite: 344]
                    .MultipleObjects "True" [cite: 344]
                    .Repetitions "1" [cite: 344]
                    .Transform "Shape", "Translate" [cite: 344]
                End With [cite: 345]

                ' Duplicate Ground plane layer
                With Transform [cite: 345]
                    .Reset [cite: 345]
                    .Name "component1:Ground" [cite: 345]
                    .Vector Replace(CStr(shift_x), ",", "."), Replace(CStr(shift_y), ",", "."), "0" [cite: 346]
                    .MultipleObjects "True" [cite: 346]
                    .Repetitions "1" [cite: 346]
                    .Transform "Shape", "Translate" [cite: 346]
                End With [cite: 346]

            End If [cite: 347]

            ' --- Calculate absolute coordinates for PIN Diode ports in each cell ---
            x1 = start_x1 + shift_x [cite: 347]
            y1 = start_y1 + shift_y [cite: 347]
            z1 = start_z1 [cite: 347]

            x2 = start_x2 + shift_x [cite: 347]
            y2 = start_y2 + shift_y [cite: 348]
            z2 = start_z2 [cite: 348]

            ' --- Generate Lumped Element structure (PIN Diode) in CST Environment ---
            With LumpedElement [cite: 348]
                 .Reset [cite: 348]
                 .SetName "PIN_Diode_" & CStr(n) [cite: 348]
                 .Folder "Folder1" [cite: 349]
                 .SetType "RLCSerial" [cite: 349]
                 .SetR "Rs*" & m_var [cite: 349]
                 .SetL "Lv" [cite: 349]
                 .SetC "Ct*(1-" & m_var & ")" [cite: 349]
                 .SetGs "0" [cite: 350]
                 .SetI0 "1e-14" [cite: 350]
                 .SetT "300" [cite: 350]
                 .SetMonitor "True" [cite: 350]
                 .SetRadius "0.0" [cite: 350]
                 .CircuitFileName "" [cite: 350]
                 .CircuitId "1" [cite: 351]
                 .UseCopyOnly "False" [cite: 351]
                 .UseRelativePath "False" [cite: 351]

                 ' Input terminal coordinates (Formatted to handle international decimal point notation)
                 .SetP1 "False", Replace(CStr(x1), ",", "."), Replace(CStr(y1), ",", "."), Replace(CStr(z1), ",", ".") [cite: 351]
                 .SetP2 "False", Replace(CStr(x2), ",", "."), Replace(CStr(y2), ",", "."), Replace(CStr(z2), ",", ".") [cite: 352]

                 .SetInvert "False" [cite: 352]
                 .Wire "" [cite: 352]
                 .Position "end1" [cite: 352]
                 .Create [cite: 352]
            End With [cite: 353]

            n = n + 1 [cite: 353]
        Next ix [cite: 353]
    Next iy [cite: 353]

End Sub