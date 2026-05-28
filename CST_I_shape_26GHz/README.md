# 26 GHz Reconfigurable Intelligent Surface (RIS) Top-Layer Simulation & Analysis

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023a%2B-orange.svg?style=flat-square&logo=mathworks)](https://www.mathworks.com/products/matlab.html)
[![CST Studio Suite](https://img.shields.io/badge/CST-Studio%20Suite-blue.svg?style=flat-square)](https://www.3ds.com/products-services/simulia/products/cst-studio-suite/)
[![mmWave](https://img.shields.io/badge/5G%20n258-26%20GHz-purple.svg?style=flat-square)](https://www.3gpp.org/)
[![Substrate](https://img.shields.io/badge/Substrate-Rogers%20RT6010-green.svg?style=flat-square)](https://www.rogerscorp.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

An industry-standard, automated engineering research repository for the design, synthesis, and full-wave electromagnetic simulation of a **26 GHz (5G mmWave n258 Band) Reconfigurable Intelligent Surface (RIS)**. This project implements a **32×32 (1024-element)** top-layer reflecting metasurface controlled via 1-bit digital phase quantization.

This repository features a fully integrated **co-simulation workflow** linking **MATLAB** (numerical beam steering, complex vector interpolation, and phase coding) and **CST Studio Suite** (VBA macros for automated geometry synthesis, equivalent RLC lumped element diode mapping, and real-time state updating).

---

## 📖 Executive Summary & Engineering Focus

At mmWave frequencies (specifically the n258 band at 26 GHz), path loss and blockage represent severe obstacles to reliable wireless links. Reconfigurable Intelligent Surfaces (RIS) offer a revolutionary paradigm by transforming the wireless environment from a passive, hostile medium into an active, software-controlled channel helper. 

This project focuses on the **Top-Layer reflecting surface** design:
* **Aperture Synthesis:** A 1024-element (32×32) spatial grid with a sub-wavelength unit cell pitch of $5.5\text{ mm}$ ($\approx 0.476\lambda$ at $26\text{ GHz}$).
* **Phase Resolution:** 1-bit digital quantization ($0^\circ$ and $180^\circ$ states) leveraging MACOM MLP7140 PIN limiter diodes to dynamically switch reflection phase.
* **Beam Steering:** Automated compensation of spatial phase delay to redirect an incident wave at $\theta_i$ to an arbitrary reflection angle $\theta_s$.
* **Database-Driven Interpolation:** A search-bound engine executing Complex Vector Interpolation on pre-simulated S-parameter lookup tables to estimate phase states for missing incident profiles without running redundant full-wave simulations.

---

## 📊 System Specifications

The physical, electrical, and structural parameters of the top-layer reflecting surface are summarized below:

| Parameter | Specification Value | Description / Engineering Rationale |
| :--- | :--- | :--- |
| **Center Frequency ($f_0$)** | $26.0\text{ GHz}$ | Core frequency for 5G FR2 n258 mmWave band |
| **Bandwidth** | $40\text{ MHz}$ | Operational channel bandwidth |
| **Array Geometry** | $32 \times 32$ elements | $1024$ active reflective unit cells |
| **Total Aperture Size** | $176\text{ mm} \times 176\text{ mm}$ | Physical footprint of the RIS panel |
| **Unit Cell Pitch ($d$)** | $5.5\text{ mm}$ | $0.476\lambda$ spacing to prevent grating lobes |
| **Phase States** | 1-bit Digital ($0$ / $1$) | State `1` (ON): $\approx 180^\circ$, State `0` (OFF): $\approx 0^\circ$ |
| **Substrate Material** | Rogers RT6010 | High-dielectric microwave laminate ($\varepsilon_r = 10.7$, $\tan\delta = 0.0023$) |
| **Substrate Thickness** | $0.254\text{ mm}$ | Low-profile top-layer design with thick copper backing |
| **Active Switch** | MACOM MLP7140 | PIN Limiter Diode modeled as RLC lumped elements |

---

## 📂 Repository Structure

The workspace is organized to support a seamless workflow between electromagnetic simulation and numerical computing:

```directory
CST_I_shape_26GHz/
├── README.md                                               # Comprehensive project documentation (Root)
├── datasheets/
│   └── MACOM_MLP71xx_Series_Limiter_Diodes.pdf             # Technical specifications for PIN Limiter Diode MLP7140
├── data/
│   └── unitcell_phases/                                    # High-fidelity S-parameter lookup tables from CST Unit Cell
│       ├── matrix_0_OFF.txt                                # Phase profile at 0° incident angle (OFF State)
│       ├── matrix_0_ON.txt                                 # Phase profile at 0° incident angle (ON State)
│       ├── matrix_15_OFF.txt                               # Phase profile at 15° incident angle (OFF State)
│       ├── matrix_15_ON.txt                                # Phase profile at 15° incident angle (ON State)
│       ├── matrix_30_OFF.txt                               # ...
│       ├── matrix_30_ON.txt
│       ├── matrix_45_OFF.txt
│       ├── matrix_45_ON.txt
│       ├── matrix_60_OFF.txt
│       └── matrix_60_ON.txt                                # Phase profile at 60° incident angle (ON State)
├── reports/
│   └── RIS_26GHz_TopLayer_Design_and_Simulation_Report.pdf # Detailed engineering design & simulation report
├── scripts/
│   ├── build_32x32_unbiased_ris_array.bas                  # CST Macro for automated 3D physical array reconstruction
│   ├── generate_beam_steering_pattern.m                    # MATLAB script for database lookup, vector interpolation & coding
│   └── update_32x32_ris_pattern.bas                        # CST Macro to dynamically load and rebuild binary coding matrices
└── i_shape_unitcell_26ghz_mlp7140/                         # Core directory for the 3D Master Unit Cell project files
    ├── .gitignore                                          # Specifies intentionally untracked files ignored by Git (CST cache/results)
    ├── I_shape_unitcell_MLP7140-11.cst                     # Master 3D unit cell simulation file in CST Studio Suite
    ├── README.md                                           # Sub-directory documentation for the unit cell model
    └── Model/                                              # Internal CST geometry database and history log files
