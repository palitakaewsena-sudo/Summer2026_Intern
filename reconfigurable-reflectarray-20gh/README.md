# 20 GHz Reconfigurable Reflectarray Metasurface using 1-Bit PIN Diode Phase Control

This repository houses the numerical designs, mathematical scripts, and comprehensive technical reports for a **20 GHz (K-band) Reconfigurable Reflectarray Metasurface (RRM)** utilizing **1-bit PIN diode phase control**. This project represents a graduate-level implementation of a Reconfigurable Intelligent Surface (RIS) capable of dynamic beam steering, beam splitting, and radar cross-section (RCS) manipulation.

By integrating solid-state PIN diodes into the geometric gaps of high-performance **I-shaped patch elements** printed on a low-loss **Rogers RO4003C** substrate, this reflectarray achieves binary ($180^\circ$) phase quantization. This allows researchers and RF engineers to control the wavefront of reflected electromagnetic waves using digital coding sequences (e.g., `01100110`, `01001011`, `00110011`).

---

## 1. Overview / Introduction

Reconfigurable reflectarrays have emerged as a pivotal technology for next-generation wireless communications (5G-Advanced and 6G) and radar systems. Unlike conventional phased arrays that require complex, bulky, and lossy corporate feed networks comprising phase shifters and amplifiers, a reconfigurable reflectarray metasurface is illuminated by a spatial feed (such as a horn antenna) and manipulates the reflected wavefront via locally controlled reactive elements.

```
       [ Spatial Feed Horn ]
                 |
                 | (Incident Wave)
                 v
   .----------------------------.  <- 1-Bit Reconfigurable Metasurface
   | [0]  [1]  [1]  [0]  [0]  [1] |     (Phase states controlled via PIN diodes)
   '----------------------------'
                 \       /
                  \     /
          [ Scattered Steered Beams ]
```

In this repository, the unit cell is designed around an **I-shaped patch element**. The I-shape geometry is chosen for its highly tunable inductive and capacitive properties. By placing a PIN diode across its central slot/gap, the active element modifies the surface impedance of the patch upon switching between its **ON** and **OFF** states. Under normal incidence at 20 GHz, the phase response transitions between two distinct states with a phase difference of approximately $180^\circ$, enabling **1-bit phase quantization** with minimal reflection loss.

---

## 2. Repository Structure

The repository is structured to separate full-wave electromagnetic models, scripting utilities for digital coding matrix synthesis, and engineering reports.

```text
reconfigurable-reflectarray-20ghz/
│
├── cst_models/
│   ├── unit_cell/
│   │   ├── unit_cell_base.cst            # Base unit cell geometry without active diodes
│   │   ├── unit_cell_mlp7140.cst         # Unit cell integrated with MLP7140-11 PIN diode
│   │   └── unit_cell_ma4agp907.cst        # Unit cell integrated with MA4AGP907 PIN diode
│   │
│   └── full_array_8x8/
│       ├── array_8x8_mlp7140.cst         # 8x8 array model using MLP7140-11 diodes
│       └── array_8x8_ma4agp907.cst       # 8x8 array model using MA4AGP907 diodes
│
├── matlab_scripts/
│   └── generate_coding_pattern.m         # Mathematical coding synthesis & Array Factor analysis
│
├── reports/
│   ├── task07_unit_cell_design.pdf       # Initial electromagnetic characterization report
│   ├── task08_mlp7140_analysis.pdf       # Floquet port analysis for MLP7140 diode unit cell
│   ├── task09_parametric_sweep_ct.pdf    # Parametric sweep analysis of parasitic capacitances
│   └── task10_ma4agp907_ecm.pdf          # Equivalent Circuit Model (ECM) validation for MA4AGP907
│
└── README.md                             # Academic repository documentation
```

---

## 3. Design Parameters

The metasurface is designed using a high-frequency laminate substrate and optimized for operation at K-band.

| Parameter | Symbol | Value | Unit / Description |
| :--- | :---: | :---: | :--- |
| **Operating Frequency** | $f_0$ | 20.0 | GHz (K-band) |
| **Free-space Wavelength** | $\lambda_0$ | 15.0 | mm |
| **Unit Cell Period** | $p$ | 7.5 | mm ($0.5\lambda_0$ to prevent grating lobes) |
| **Substrate Material** | - | Rogers RO4003C | High-frequency hydrocarbon ceramic laminate |
| **Relative Permittivity** | $\epsilon_r$ | 3.55 | $\pm 0.05$ tolerance |
| **Loss Tangent** | $\tan\delta$ | 0.0027 | Low-loss dielectric dissipation |
| **Substrate Thickness** | $h$ | 1.524 | mm (60 mil standard thickness) |
| **Copper Conductivity** | $\sigma$ | $5.8 \times 10^7$ | S/m (Standard annealed copper) |
| **Copper Cladding Thickness** | $t$ | 35 | $\mu$m (1 oz copper) |
| **Unit Cell Element** | - | I-shaped patch | Optimized for strong inductive/capacitive coupling |

---

## 4. PIN Diode Equivalent Circuit Parameters

To achieve reconfigurability, solid-state PIN diodes are modeled as equivalent lumped elements (resistive path in ON state, capacitive path in OFF state) within the central gap of the I-shaped patch. This repository analyzes two distinct diode models: the packaged silicon PIN diode (**Aeroflex/Metelics MLP7140-11**) and the GaAs monolithic PIN diode (**MACOM MA4AGP907**).

```
          ON State (Forward Biased)                OFF State (Reverse Biased)
          
                 Rs                                       Ct
            ---[===]---                              ----||----
```

### Equivalent Circuit Model (ECM) Specifications

*   **Aeroflex/Metelics MLP7140-11 (Silicon PIN Diode)**
    *   **ON State**: Series resistance $R_s = 2.0\ \Omega$ (representing high forward-bias conductivity).
    *   **OFF State**: Total junction capacitance $C_t = 0.10\ \text{pF}$ (representing reverse-bias capacitive isolation).
    *   **Physical Gap**: The patch element has a central gap width of $0.28\ \text{mm}$ where the diode is mounted.
*   **MACOM MA4AGP907 (GaAs PIN Diode)**
    *   **ON State**: Series resistance $R_s = 4.2\ \Omega$ or $5.2\ \Omega$ (higher ohmic resistance due to GaAs contact structure).
    *   **OFF State**: Total junction capacitance $C_t = 0.025\ \text{pF}$ (ultra-low parasitic capacitance, allowing superior high-frequency isolation).
    *   **Physical Gap**: The patch element gap width is set to $0.33\ \text{mm}$.

### Diode Comparative Analysis Table

| Diode Model | Semiconductor | State | Rs ($\Omega$) | Ct (pF) | Mounting Gap (mm) | Key RF Characteristic |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **MLP7140-11** | Silicon (Si) | ON<br>OFF | 2.0<br>— | —<br>0.10 | 0.28 | Low ON-state loss; higher OFF-state parasitics. |
| **MA4AGP907** | Gallium Arsenide | ON<br>OFF | 4.2 / 5.2<br>— | —<br>0.025 | 0.33 | Ultra-low capacitance; moderate ON-state loss. |

---

## 5. Step-by-Step Workflow

The implementation of the reconfigurable reflectarray metasurface is divided into three major research phases:

```
[Phase 1: Unit Cell Design] ──> [Phase 2: Mathematical Coding] ──> [Phase 3: Full Array Validation]
  - Floquet Port Analysis          - Snell's Law & Wavefronts         - Open Boundary Simulation
  - PIN Diode ECM Integration      - Complex-Plane Quantization       - Near-to-Farfield Transform
  - Oblique Angle Sweep            - 8x8 Coding Matrix Synthesis      - Directivity & SLL Evaluation
```

1.  **Unit Cell Characterization**: Design the I-shaped copper patch on Rogers RO4003C substrate with a ground plane backplate to ensure complete reflection ($S_{11} \approx 0\text{ dB}$ for lossless case).
2.  **Active Element Integration**: Incorporate the lumped element representation of the PIN diodes in the central gap of the unit cell in CST Studio Suite.
3.  **Floquet Port Simulation**: Analyze the infinite periodic array response to find the exact resonance behavior and extract the reflection phase for both states.
4.  **Incident Angle Sweep**: Perform parametric sweeps over oblique angles ($\theta_i$) to map angular phase sensitivity.
5.  **Coding Pattern Synthesis**: Use MATLAB to generate phase profiles according to Generalized Snell's Law and project them to 1-bit binary values using complex-plane vector quantization.
6.  **Full Array CST Assembly**: Instantiate an $8 \times 8$ finite metasurface in CST, mapping the synthesized digital bits (0 or 1) to individual lumped elements.
7.  **Excitation & Scattering Analysis**: Apply a plane-wave excitation source, execute full-wave simulations, and record the bistatic scattering pattern using farfield monitors.
8.  **Physical Diagnostics**: Extract surface current distributions to physically validate the switching states and verify the wavefront redirection mechanism.

---

## 6. Unit Cell Simulation Procedure

### Floquet Port & Boundary Conditions
To accurately analyze the unit cell behavior as part of a larger array, the structure is simulated within an infinite periodic environment. 

*   **Boundary Conditions**: The boundaries in the lateral plane ($x$- and $y$-axes) are configured as **Periodic Boundaries**. This mathematically duplicates the single unit cell along a grid of period $p = 7.5\ \text{mm}$, capturing mutual coupling between adjacent elements in an infinite array approximation.
*   **Excitation Source**: A **Floquet Port** is placed at a distance of $z \approx \lambda_0$ above the metasurface. The Floquet port excites the structure with orthogonal plane waves: $TE_{00}$ (Transverse Electric) and $TM_{00}$ (Transverse Magnetic) modes.

```
                  [ Floquet Port (Zmax) ]
                            |
                 ~~~~~ (Plane Wave) ~~~~~
                            v
      |<- - - - - - - - -  p = 7.5 mm - - - - - - - - ->|
    - +-------------------------------------------------+ -
      |                  I-Shaped Patch                 |  |
      |                 .-------------.                 |  |
      |                 |  .-------.  |                 |  |
      |                 |  | [Gap] |  |                 |  |  Copper element
      |                 |  '-------'  |                 |  |  (35 um thickness)
      |                 '-------------'                 |  |
    - +-------------------------------------------------+ -
      |                                                 |  |  Rogers RO4003C
      |               Substrate Medium                  |  |  Substrate
      |                                                 |  |  (h = 1.524 mm)
    - +-------------------------------------------------+ -
      |                 Ground Plane                    |  |  Perfect conductor
    - +-------------------------------------------------+ -
      |               (Periodic Boundary)               |
```

### Reflection Phase Extraction
The reflection coefficient ($S_{11}$) is computed directly at the Floquet port. The reference plane is de-embedded to the top surface of the reflectarray patch. The complex reflection coefficient is defined as:

$$S_{11}(\omega) = |S_{11}(\omega)| e^{j\Phi(\omega)}$$

The key goal of the unit cell design is to find a geometry where:

$$\Delta\Phi = |\Phi_{ON}(20\text{ GHz}) - \Phi_{OFF}(20\text{ GHz})| \approx 180^\circ$$

while maintaining $|S_{11}| \approx 0\ \text{dB}$.

### Oblique Incidence & Angular Instability
In real-world reflectarray antennas, the feed horn illuminates the aperture from a focal point, meaning that the incident wave hits outer elements at oblique angles ($\theta_i \ne 0^\circ$). Under oblique incidence, the resonant frequency of the patch shifts due to spatial dispersion.

#### Measured Unit Cell Phase Performance (MLP7140-11 at 20 GHz)
*   **Normal Incidence ($\theta_i = 0^\circ$)**:
    *   **OFF State (0)**: $\Phi_{OFF} = -68.43^\circ$
    *   **ON State (1)**: $\Phi_{ON} = 113.57^\circ$
    *   **Phase Difference**: $\Delta\Phi \approx 182.0^\circ$ (Very close to the ideal $180^\circ$ difference).
*   **Oblique Incidence ($\theta_i = 30^\circ$ in the E-plane)**:
    *   **OFF State (0)**: $\Phi_{OFF} = -23.07^\circ$
    *   **ON State (1)**: $\Phi_{ON} = -103.50^\circ$
    *   **Phase Difference**: $\Delta\Phi \approx 80.4^\circ$
    *   *Analysis*: A severe phase degradation occurs (dropping from $182^\circ$ to $80.4^\circ$), known as **angular instability**. This is a major design constraint, as it introduces substantial phase errors across the reflectarray aperture, raising side lobe levels and reducing the overall antenna aperture efficiency.

---

## 7. MATLAB Coding Pattern Generation

### Generalized Snell's Law (GSL)
To steer the reflected beam to a desired elevation angle $\theta_s$ and azimuth angle $\phi_s$, a spatial phase gradient must be introduced across the metasurface plane. For normal incidence ($\theta_i = 0$), Generalized Snell’s Law dictates the required continuous phase distribution $\Phi_{req}(x_m, y_n)$ at element $(m, n)$:

$$\Phi_{req}(x_m, y_n) = -k_0 \left( x_m \sin\theta_s \cos\phi_s + y_n \sin\theta_s \sin\phi_s \right)$$

where $x_m = \left(m - \frac{M+1}{2}\right)p$ and $y_n = \left(n - \frac{N+1}{2}\right)p$ are the physical coordinates of the $(m,n)$-th unit cell, and $k_0 = \frac{2\pi}{\lambda_0}$ is the free-space wave number.

### Complex-Plane Vector-Distance Phase Quantization
Conventional 1-bit quantization maps continuous phases to $0$ if they fall in $[0, \pi)$ and to $1$ if they fall in $[\pi, 2\pi)$. However, because the actual simulated reflection phases of the ON and OFF states ($\Phi_{ON}$, $\Phi_{OFF}$) do not lie exactly at $0^\circ$ and $180^\circ$ (and change with incident angle), conventional thresholding introduces massive phase errors.

This project implements the **Complex-Plane Vector-Distance Quantization** algorithm. The continuous requested phase $\Phi_{req}$ is transformed into a unit phasor on the complex plane:

$$V_{req}(m, n) = e^{j\Phi_{req}(x_m, y_n)}$$

The active states of the PIN diode are represented by their complex phasors:

$$V_0 = e^{j\Phi_{OFF}}, \quad V_1 = e^{j\Phi_{ON}}$$

The Euclidean distance between the requested phasor and each candidate phasor is computed:

$$d_0 = |V_{req}(m, n) - V_0| = \sqrt{ (\cos\Phi_{req} - \cos\Phi_{OFF})^2 + (\sin\Phi_{req} - \sin\Phi_{OFF})^2 }$$

$$d_1 = |V_{req}(m, n) - V_1| = \sqrt{ (\cos\Phi_{req} - \cos\Phi_{ON})^2 + (\sin\Phi_{req} - \sin\Phi_{ON})^2 }$$

The optimal coding bit $B(m, n) \in \{0, 1\}$ is selected by minimizing the distance:

$$B(m, n) = \text{argmin}_{i \in \{0, 1\}} (d_i)$$

This reduces quantization noise and optimizes beam efficiency under realistic, non-ideal phase states.

```
                         Imag (j)
                            ^
                            |      * V_req
                            |     /
                  V_1 *     |    / d_0
                  (ON) \    |   /
                        \   |  v
                         \  | /
  ------------------------\-+-------------------> Real
                           \|* V_0 (OFF)
                            |
```

### Example Coding Sequences & Array Factor Analysis
Using `matlab_scripts/generate_coding_pattern.m`, various $8 \times 8$ coding matrices are synthesized. Standard 1D coding sequences are used to evaluate different scattering properties:

*   **`01100110`**: A gradient pattern with a spatial period of $2p = 15\ \text{mm}$. This pattern splits normal incident waves into two symmetric beams directed at:
    $$\theta_s = \pm \arcsin\left(\frac{\lambda_0}{2 \cdot (2p)}\right) = \pm \arcsin(0.5) = \pm 30^\circ$$
*   **`00110011`**: Double-element coding sequence. It increases the spatial period, shifting the scattering peaks closer to the broadside direction.
*   **`01001011`**: An asymmetric digital pattern designed for direct single-beam steering at oblique angles.

---

## 8. Full Array CST Simulation

### Boundary Conditions & Excitation
For the full array simulation, the model transitions from periodic approximations to a finite, real-world metasurface:

*   **Boundary Conditions**: All boundaries ($x$, $y$, $z$) are set to **Open (add space)**. This simulates the $8 \times 8$ metasurface in free space, accounting for edge diffractions and finite size effects.
*   **Excitation Source**: A **Plane Wave** source is implemented to illuminate the entire array uniformly, representing a plane wave source arriving from the far field (normal incidence, $\theta_i = 0^\circ$).
*   **Lumped Elements Configuration**: The $8 \times 8$ reflectarray comprises 64 individual I-shaped patch elements. A lumped R-C circuit is placed in the gap of each patch. The values of these lumped elements are mapped cell-by-cell in CST to represent either the ON state ($R_s$) or the OFF state ($C_t$), matching the exact 2D coding matrix generated by MATLAB.

```
                      [ Incident Plane Wave ]
                             |  |  |  |
                             v  v  v  v
                  .---------------------------.
                  | [0] [1] [1] [0] [0] [1]...| <- Finite 8x8 Metasurface
                  '---------------------------'
                 /                             \
                /                               \
         [ Scat_Beam_1 ]                 [ Scat_Beam_2 ]
```

### Farfield Monitor Setup
A **Farfield Monitor** is defined at the operating frequency of $20\ \text{GHz}$. This allows the extraction of:
*   Bistatic Radar Cross Section (RCS) in $\text{dBm}^2$
*   Realized Gain (dBi) and Directivity
*   Co-polarization ($x$-polarized) and cross-polarization ($y$-polarized) scattering fields.

---

## 9. Result Verification

To ensure academic and numerical rigor, a multi-layered verification scheme is applied:

### Array Factor (AF) vs. Full-Wave CST Simulation
The farfield scattering patterns obtained via the analytical MATLAB script (which sums the array factor under a Huygens-Fresnel point-source approximation) are directly compared with the full-wave CST finite element/transient solvers.

*   *Agreement*: The main beam positions match closely.
*   *Discrepancies*: CST models show slightly higher side lobe levels and filled nulls. This is expected and physically accurate, as full-wave CST simulations account for:
    1.  **Mutual Coupling**: Electromagnetic coupling between the closely spaced I-shaped patches ($p = 0.5\lambda_0$).
    2.  **Edge Effects**: High scattering and diffraction from the boundaries of the finite $8 \times 8$ aperture.
    3.  **Element Factor**: The individual directional radiation pattern of the I-shaped patch, which suppresses wide-angle scattering.

### Surface Current Verification
By analyzing the surface current density ($\mathbf{J}_s$ in $\text{A/m}$) on the I-shaped patches at $20\ \text{GHz}$:
*   **ON State**: High current concentration flows directly through the low-resistance lumped resistor ($R_s = 2.0\ \Omega$ or $4.2\ \Omega$), completing a conductive path across the patch gap. This alters the effective electrical length of the element.
*   **OFF State**: The current is blocked by the high impedance of the lumped capacitor ($C_t = 0.10\ \text{pF}$ or $0.025\ \text{pF}$), resulting in high displacement currents across the gap and strong electric field hot-spots.

```
         ON State Surface Currents                    OFF State Surface Currents
             .--------------.                             .--------------.
             |====>  || ===>|                             |====>  ||     |
             |====> [Rs]===>|                             |====>  ||     |  Current blocked
             |====>  || ===>|                             |====>  ||     |  at gap
             '--------------'                             '--------------'
```

### Specular Backscattering vs. Forward Scattering
For a reflective ground plane, a normal incident wave is reflected entirely back to the specular direction ($\theta = 0^\circ$). By applying a gradient coding sequence like `01100110`, the specular reflection is suppressed. The backscattering power is redistributed into two symmetrical off-axis beams (forward-diffuse scattering), verifying the RCS reduction capability of the 1-bit metasurface.

---

## 10. Important Caveats and Deep Analysis Notes

Graduate-level electromagnetic researchers must consider these critical physical behaviors:

### 1. Angular Phase Instability
The reflection phase of a periodic metasurface is highly dependent on the incidence angle ($\theta_i$). At oblique incidence:
*   The effective path length in the dielectric substrate changes.
*   New spatial resonance modes are excited on the I-shaped patches.
*   For the MLP7140-11 silicon diode, the phase difference drops to **$80.4^\circ$ at $\theta_i = 30^\circ$**. This causes severe degradation of the phase gradient, leading to beam widening, steering angle errors, and reduced gain.

### 2. Side Lobe and Grating Lobe Formations
*   **Quantization Loss**: Because the continuous phase is quantized to just two states ($0^\circ$ and $180^\circ$), a theoretical quantization loss of at least $3.9\ \text{dB}$ is introduced, which raises the overall **Side Lobe Level (SLL)**.
*   **Grating Lobes**: If a coding sequence groups identical states together (e.g., `00001111`), the effective period becomes large ($P_{eff} > \lambda_0$). This generates unwanted **grating lobes** in the visible region, diverting power from the desired steering angle.

### 3. Dissipative Losses (Ohmic & Dielectric)
Unlike passive metasurfaces, active reflectarrays suffer from ohmic losses in the PIN diodes:
*   The series resistance $R_s$ in the ON state dissipates power through Joule heating:
    $$P_{loss} = I_{surface}^2 R_s$$
*   For the MA4AGP907 diode, the higher $R_s = 4.2\ \Omega$ / $5.2\ \Omega$ results in a deeper reflection dip ($|S_{11}| \approx -2.5\ \text{dB}$ at resonance), whereas the MLP7140-11 ($R_s = 2.0\ \Omega$) exhibits lower insertion loss ($|S_{11}| \approx -1.1\ \text{dB}$).
*   Rogers RO4003C loss tangent ($\tan\delta = 0.0027$) introduces additional dielectric losses, which must be carefully modeled.

---

## 11. Expected Results

When reproducing these simulations, the following quantitative behaviors should be observed:

*   **Reflection Magnitude ($S_{11}$)**:
    *   *OFF State*: $|S_{11}| > -0.6\ \text{dB}$ at 20 GHz (indicating high efficiency and low capacitive leakage).
    *   *ON State*: $|S_{11}| > -1.5\ \text{dB}$ (MLP7140-11) and $> -2.8\ \text{dB}$ (MA4AGP907) due to diode series resistance.
*   **Reflection Phase Difference ($\Delta\Phi$)**:
    *   Normal incidence phase shift: $180^\circ \pm 5^\circ$ at exactly 20.0 GHz.
*   **Scattering Pattern (Pattern: `01100110`)**:
    *   Suppression of the specular broadside beam ($\theta = 0^\circ$) by $> 15\ \text{dB}$.
    *   Two symmetric scattering lobes directed at $\theta_s \approx \pm 30^\circ$ with equal amplitude.

---

## 12. Software Requirements

To run the models and scripts in this repository, you need:

1.  **CST Studio Suite** (Version 2021 or newer)
    *   Schematic and 3D modeling environments.
    *   Transient Solver or Frequency Domain Solver with Floquet port capability.
2.  **MATLAB** (Version R2020a or newer)
    *   No specialized toolboxes are required (uses standard vector operations and plotting libraries).
3.  **PDF Reader** (to open technical reports in `/reports`).

---

## 13. How to Reproduce

### Step 1: Coding Pattern Generation (MATLAB)
1.  Navigate to the `matlab_scripts/` directory.
2.  Open and run the script `generate_coding_pattern.m` in MATLAB.
3.  The command window will print the synthesized 1-bit coding matrices for both 1D gradient and customized steering.
4.  The generated figures will display the 1-bit phasor locations on the complex plane and the normalized farfield Array Factor.

### Step 2: Unit Cell Characterization (CST)
1.  Open CST Studio Suite and load the base model `cst_models/unit_cell/unit_cell_base.cst`.
2.  Verify the substrate properties (Rogers RO4003C, $h = 1.524\ \text{mm}$) and periodic boundaries.
3.  Load the active unit cell models:
    *   `unit_cell_mlp7140.cst` (Silicon PIN)
    *   `unit_cell_ma4agp907.cst` (GaAs PIN)
4.  Run the **Frequency Domain Solver** with Floquet port excitation.
5.  Extract the reflection amplitude and phase under 1D results ($S$-parameters) for the ON and OFF states.

### Step 3: Full Array Simulation (CST)
1.  Load the full $8 \times 8$ array models:
    *   `cst_models/full_array_8x8/array_8x8_mlp7140.cst`
    *   `cst_models/full_array_8x8/array_8x8_ma4agp907.cst`
2.  Inspect the 64 lumped elements. Note how their ON/OFF states correspond to the coding sequence (e.g., `01100110`).
3.  Run the **Time Domain Solver** under plane wave excitation.
4.  Once completed, go to **Farfields** in the CST navigation tree at 20 GHz to visualize the 3D scattering lobes. Compare the beam angles with the analytical calculations from the MATLAB script.

---

## 14. Citation / Reference Style Section

If you use these simulation models, coding scripts, or technical reports in your academic research or coursework, please cite this repository using the following format:

### IEEE Style
```text
P. Kaewsena, "20 GHz Reconfigurable Reflectarray Metasurface using 1-Bit PIN Diode Phase Control," GitHub Repository, May 2026. [Online]. Available: https://github.com/palitakaewsena-sudo/Summer2026_Intern
```

### BibTeX Format
```bibtex
@misc{reflectarray20ghz2026,
  author       = {Kaewsena, Palita},
  title        = {20 GHz Reconfigurable Reflectarray Metasurface using 1-Bit PIN Diode Phase Control},
  year         = {2026},
  publisher    = {GitHub},
  journal      = {GitHub Repository},
  howpublished = {\url{https://github.com/palitakaewsena-sudo/Summer2026_Intern}}
}
```

---

## 15. License Section

This project is licensed under the **MIT License** - see below for details:

```text
MIT License

Copyright (c) 2026 Palita Kaewsena

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 16. Acknowledgement Section

The author wishes to express sincere gratitude to the academic advisors and engineering mentors of the **Summer 2026 Research Internship Program**. Their invaluable guidance, physical insights on PIN diode modeling, and support in electromagnetic simulation techniques made this research codebase possible. Special thanks are also extended to the department's antenna laboratory for providing the licensing and server resources necessary for CST Studio Suite full-wave computations.
