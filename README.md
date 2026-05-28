# RF and Metasurface Research Repository: Summer 2026 Internship

Welcome to the central repository for the RF, Metasurface, and Reconfigurable Intelligent Surface (RIS) simulation studies conducted during the Summer 2026 research internship. This repository serves as a consolidated research database hosting four distinct projects designed and simulated using CST Studio Suite and post-processed using MATLAB.

The investigations range from passive reflective metasurfaces with multi-band geometric tuning to active reconfigurable structures leveraging lumped PIN diodes and limiter diode networks for beam steering applications in the 5G and millimeter-wave (mmWave) spectrums.

---

## Repository Structure

The repository is structured as a monorepo containing four independent project directories. Each directory contains its respective 3D EM models, simulation outputs, MATLAB scripts, and detailed technical documentation.

```text
Summer2026_Intern/
├── .gitignore
├── README.md                              <-- Master repository documentation (this file)
├── cst-metasurface-study/                 <-- Project 1: Multi-band passive metasurface study
│   ├── README.md                          <-- Project-specific technical guide
│   ├── CST_model/                         <-- Unit cell and 16x16 array CST projects
│   ├── reports/                           <-- Task 1 to Task 5 simulation reports (PDF)
│   └── Ref/                               <-- Theoretical reference papers
├── metasurface-pindiode-lumped-modeling/  <-- Project 2: PIN diode lumped equivalent modeling
│   ├── README.md                          <-- Project-specific technical guide
│   ├── CST_Model_PIN_Diode/               <-- Active unit cell CST model with lumped elements
│   ├── report/                            <-- Active metasurface study report (PDF)
│   └── Ref/                               <-- Reference literature and diode datasheets
├── reconfigurable-reflectarray-20gh/      <-- Project 3: 20 GHz 1-bit reflectarray project
│   ├── README.md                          <-- Project-specific technical guide
│   ├── cst_models/                        <-- 8x8 array and active unit cell CST models
│   ├── matlab_scripts/                    <-- Beam steering pattern generation script
│   └── reports/                           <-- Phase analysis and design reports (PDF)
└── CST_I_shape_26GHz/                     <-- Project 4: 26 GHz active I-shape RIS project
    ├── README.md                          <-- Project-specific technical guide
    ├── i_shape_unitcell_26ghz_mlp7140/    <-- MLP7140 active unit cell CST model
    ├── scripts/                           <-- VBA macros for 32x32 array assembly & steering
    ├── data/                              <-- Measured and simulated phase matrices (TXT)
    ├── reports/                           <-- Full design and simulation report (PDF)
    └── datasheets/                        <-- MACOM diode datasheets (PDF)
```

---


## Projects Directory Overview

### 1. Passive Metasurface Study (`cst-metasurface-study`)
* **Objective**: Evaluate the electromagnetic performance of a passive multi-band reflective metasurface unit cell and scale the design to a $16 \times 16$ element finite array.
* **Key Features**:
  * Step-by-step instructions for parameter sweeps on critical geometric parameters (such as slot lengths and patch dimensions).
  * Implementation of automated geometric optimization using the Trust Region Framework (TRF).
  * Numerical mesh study highlighting performance and accuracy tradeoffs between Tetrahedral and Hexahedral meshing.
  * Finite array modeling illuminated by a Plane Wave source with bistatic Radar Cross Section (RCS) analysis at $24\text{ GHz}$, $30\text{ GHz}$, and $38\text{ GHz}$.
* **Access**: [Project README](file:///c:/Users/palit/Desktop/metasurface-array-cst-study/cst-metasurface-study/README.md)

### 2. PIN Diode Lumped Equivalent Modeling (`metasurface-pindiode-lumped-modeling`)
* **Objective**: Implement and analyze active PIN diode models using RLC lumped elements to evaluate dynamic resonance shifting and surface current profiles in 5G metasurfaces.
* **Key Features**:
  * Analytical representation of the forward-biased (ON) series R-L equivalent circuit and reverse-biased (OFF) parallel R-C-L equivalent circuit.
  * Step-by-step guidance on implementing dynamic parameter changes based on the CST bias state variable `Mode`.
  * Physical analysis of surface current distribution pathways showing dipole-like coupling in the ON state and field containment in the OFF state.
  * Comprehensive checks on plane wave angular stability under oblique incidence angles up to $45^\circ$.
* **Access**: [Project README](file:///c:/Users/palit/Desktop/metasurface-array-cst-study/metasurface-pindiode-lumped-modeling/README.md)

### 3. 20 GHz 1-Bit Reconfigurable Reflectarray (`reconfigurable-reflectarray-20gh`)
* **Objective**: Design an active unit cell operating at $20\text{ GHz}$ capable of a $180^\circ$ phase shift for 1-bit reconfigurable reflectarray antennas.
* **Key Features**:
  * Electromagnetic modeling of infinite periodic structures with Floquet port excitation.
  * Active PIN diode state analysis to achieve binary phase shifting (state 0/1) for beam scanning.
  * MATLAB scripts to compile reflection coefficients and model far-field radiation patterns for an $8 \times 8$ array based on phase matrices.
* **Access**: [Project README](file:///c:/Users/palit/Desktop/metasurface-array-cst-study/reconfigurable-reflectarray-20gh/README.md)

### 4. 26 GHz Active I-Shape RIS (`CST_I_shape_26GHz`)
* **Objective**: Model, assemble, and dynamically control a $32 \times 32$ Reconfigurable Intelligent Surface (RIS) using active I-shape patches and limiter diodes.
* **Key Features**:
  * Integration of the MACOM MLP7140 limiter diode equivalent circuits into the I-shape patch geometry.
  * Visual Basic for Applications (VBA) macro scripts to automatically construct the complete $32 \times 32$ RIS layout from a single cell.
  * Phase-mapping database representing active ON and OFF states for various incidence angles.
  * Script-based automated pattern update routines for advanced beam-forming and beam-steering.
* **Access**: [Project README](file:///c:/Users/palit/Desktop/metasurface-array-cst-study/CST_I_shape_26GHz/README.md)

---

## Software Dependencies and Toolboxes

Running the models and scripts hosted in this repository requires:

1. **CST Studio Suite (2021 or newer)**:
   * Transient Solver (FIT) with Hexahedral mesh configurations.
   * Frequency Domain Solver (FEM) with Tetrahedral mesh configurations.
   * Macro execution capabilities for VBA RIS assembly scripts.
2. **MATLAB (R2021a or newer)**:
   * Signal Processing Toolbox.
   * Antenna Toolbox.
   * Automated ASCII/CSV parsing and plotting utilities.

---

## Usage Instructions

To replicate any of the simulation studies:
1. Navigate to the desired project directory.
2. Open the respective `.cst` project file located inside the model subdirectory.
3. Review the parameter list and solver configurations against the parameters detailed in the project's specific `README.md`.
4. Run the electromagnetic solver and utilize the post-processing reports inside the `/reports` or `/report` folders for benchmark comparison.
