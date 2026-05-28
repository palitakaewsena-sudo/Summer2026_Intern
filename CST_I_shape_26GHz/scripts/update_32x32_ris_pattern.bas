Sub Main()
    Dim ix As Integer, iy As Integer, n As Integer
    Dim m_var As String
    Dim row_pattern As String

    ' =========================================================================
    ' 🛠️ USER CONFIGURATION: MATCH YOUR ARRAY SIZE HERE
    ' =========================================================================
    Dim Nx As Integer, Ny As Integer
    Nx = 32  ' Number of elements along X-axis (Must match the length of row_pattern)
    Ny = 32  ' Number of elements along Y-axis
    
    ' Define the 1D pattern for a single row.
    ' EXAMPLE FOR 32x32: Length must be 32 characters
    row_pattern = "10011001100011001100110011001100" 
    
    ' EXAMPLE FOR 4x4 (Uncomment to use):
    ' Nx = 4 : Ny = 4 : row_pattern = "1001"
    ' =========================================================================

    ' Check if the defined Nx matches the actual length of the pattern string
    If Nx <> Len(row_pattern) Then
        MsgBox "Error: Nx (" & CStr(Nx) & ") does not match the row_pattern length (" & CStr(Len(row_pattern)) & ")!", 16, "Parameter Mismatch"
        Exit Sub
    End If

    n = 1 ' Initialize the element parameter counter at m1

    ' Loop through rows along the Y-axis
    For iy = 1 To Ny
        ' Loop through columns along the X-axis to extract state configuration
        For ix = 1 To Nx
            
            m_var = "m" & CStr(n)
            
            ' Extract a 1-character state (0 or 1) at position 'ix' from row_pattern
            StoreParameter m_var, Mid(row_pattern, ix, 1)
            
            n = n + 1
            
        Next ix
    Next iy

    ' Trigger a model rebuild to apply the new phase parameters to the diodes immediately
    Rebuild
End Sub