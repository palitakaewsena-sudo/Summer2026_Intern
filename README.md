# 📡 CST Metasurface Simulation: Time-Domain Runtime Modeling & Array Optimization

## 1. Project Introduction

Welcome to the **Reflective Metasurface Simulation Study**, a comprehensive research-oriented project exploring electromagnetic behavior using **CST Studio Suite**. This repository serves as an educational and procedural guide for analyzing metasurface unit cells and expanding them into full antenna arrays. 

This project specifically utilizes the **Transient Solver (Time-Domain)** with **Plane Wave excitation** to analyze electromagnetic phenomena such as S-parameters ($S_{11}$, $S_{21}$), Transverse Electric (TE) / Transverse Magnetic (TM) polarization, and Radar Cross Section (RCS) response. It also investigates the tradeoff between mesh density, solver accuracy, and computational runtime.

---

## 2. Repository Structure

```text
cst-metasurface-study
├── README.md
├── unit_cell_base.cst
├── full_array_base.cst
├── report_task1_unit_cell_sweep.pdf
├── report_task2_unit_cell_optimization.pdf
├── report_task3_runtime_analysis.pdf
├── report_task4_runtime_mesh_accuracy.pdf
└── report_task5_full_array_16x16.pdf
```

---

## 3. Prerequisites

*   **Software:** CST Studio Suite (FIT/FDTD Time Domain Solver)
*   **Post-Processing:** MATLAB (for analyzing exported datasets)
*   **Knowledge Base:** Basic understanding of Electromagnetics, S-Parameters, and RCS.

---

## 4. Step-by-Step Simulation Guide

The workflow is divided into three distinct phases: analyzing a single periodic unit cell, understanding the computational constraints, and finally scaling to a massive full-array configuration.

---

## 5. Part 1 — Unit Cell Analysis

In this phase, we analyze the baseline unit cell to understand its isolated resonant behavior using the Frequency Domain and Transient Solvers.
**Base Model:** Open `unit_cell_base.cst`.

---

## 6. Task 1 — Parameter Sweep

We use the parameter sweep tool to manually evaluate the sensitivity of structural geometries.

*   **Navigate to:** `Home > Parameter Sweep`
*   **Create a new parameter:** We recommend exploring the parameter `L3`.
*   **Configure the Sweep Modes:** Use either **Step Width** or **Number of Samples** to define your iterations.
*   **Run the Simulation:** Execute the sweep.
*   **Observe Results:** Check the reflection response ($S_{11}$) under `1D Results > S-Parameters`.
*   **Validation:** Compare your output graphs with the reference data in `report_task1_unit_cell_sweep.pdf`.

---

## 7. Task 2 — Optimizer

After a manual sweep, we employ automated optimization algorithms to pinpoint exact resonances.

*   **Navigate to:** `Home > Optimizer`
*   **Select Algorithm:** Choose `Trust Region Framework` (TRF).
*   **Configure Goals:** Set up the optimization goals (e.g., minimizing $S_{11}$ at target frequencies) as specified in `report_task2_unit_cell_optimization.pdf`.
*   **Run Optimizer:** Allow the algorithm to converge on the optimal unit cell parameters.

---

## 8. Part 2 — Runtime & Mesh Knowledge Base

Understanding computational cost is critical before scaling to massive arrays. Please refer to:
*   `report_task3_runtime_analysis.pdf`
*   `report_task4_runtime_mesh_accuracy.pdf`

**Key Concepts Explained:**
*   **Mesh Cells:** The spatial discretization grid. A denser mesh captures finer geometry but dramatically increases hardware memory requirements.
*   **Accuracy vs. Runtime:** The solver accuracy threshold (e.g., -40 dB vs. -50 dB) dictates when the transient solver stops. Higher accuracy means exponentially longer solver runtimes.
*   **Solver Performance Tradeoff:** Balancing the spatial mesh density with time-domain accuracy is the primary tradeoff in RF engineering.

---

## 9. Part 3 — Full Array Simulation

We transition from isolated unit cells to massive periodic arrays to extract realistic Radar Cross Section (RCS) profiles.
**Base Model:** Open `full_array_base.cst`.

*   **Solver Selection:** Utilize the **Transient Solver** (Time Domain).
*   **Excitation Source:** Apply **Plane Wave excitation** to mimic incoming radar signals.

---

## 10. Methodological Pivot Warning

> [!WARNING]
> **Black-box optimization methods such as TRF or PSO become unstable and fail to converge efficiently on large full-array metasurface structures.** The simulation becomes excessively slow and resonance behavior becomes distorted due to extreme boundary coupling and mesh complexity. Therefore, this project abandons standard optimization in favor of a strictly **Sequential Parameter Sweep** and **Multi-Parameter Sweep** strategy.

---

## 11. Sequential Parameter Sweep Procedure

To tune the full array without triggering solver instability, follow this isolated tuning sequence.

### Step 1 (Low-Frequency Tuning)
*   **Fix Parameters:** `L3 = 0.95 mm`, `R = 1.15 mm`
*   **Sweep Parameter:** `L2 = 2.7 → 3.0 mm` (Step: `0.05 mm`)
*   **Target Resonance:** `24 GHz`
*   **Best Result:** `L2 = 2.9 mm`

### Step 2 (Mid-Band Tuning)
*   **Fix Parameters:** `L2 = 2.9 mm`, `R = 1.15 mm`
*   **Sweep Parameter:** `L3 = 0.8 → 1.1 mm` (Step: `0.05 mm`)
*   **Best Result:** `L3 = 1.1 mm`

### Step 3 (High-Frequency Tuning)
*   **Fix Parameters:** `L2 = 2.9 mm`, `L3 = 1.1 mm`
*   **Sweep Parameter:** `R = 1.1 → 1.2 mm` (Step: `0.05 mm`)
*   **Target Resonance:** `38 GHz`
*   **Best Result:** `R = 1.1 mm`

---

## 12. Multi-Parameter Sweep & Global Scale

To account for simultaneous coupling across the array, we introduce a global modifier variable called `scale`.

*   **Create Variable:** Define `scale`.
*   **Apply to Geometry:** e.g., `L2 = 2.9 mm + scale`.
*   **Initial Sweep:** Sweep `scale = 0 → 0.1 mm`.
    *   **Best Stable Value:** `scale = 0.1 mm`.
*   **Re-adjust High Frequency:** Sweep `R = 1.1 → 1.25 mm`.
    *   **Final Best:** `R = 1.15 mm`.
*   **Fine Tuning Run:** Sweep `scale = -0.1 → 0.1 mm` across the entire structure to lock in the final geometry.

---

## 13. Golden Parameters Equation

Following the sequential and multi-parameter scaling sweeps, the final optimized geometry for the full array is defined as:

```math
L_2 = 2.95\text{ mm}, \quad
L_3 = 1.1\text{ mm}, \quad
R = 1.15\text{ mm}
```

---

## 14. Array Scaling and MATLAB Export Checklist

With the parameters locked, scale the array from $5\times5$ up to $16\times16$ to analyze RCS saturation.

*   **Expansion:** Use the **Translate Structure** tool to expand the grid: `5x5 → 10x10 → 16x16`.
*   **Run Simulations:** Execute the Time Domain solver for all array sizes.
*   **Data Export Checklist:**
    *   S-Parameters: $S_{11}$, $S_{21}$
    *   TE/TM Polarization Data
    *   Bistatic RCS Abs
*   **Sample Frequencies:** Extract data specifically at `24 GHz`, `30 GHz`, and `38 GHz`.
*   **Formatting:** Export data as `.txt` or `.csv`.
*   **Units:** Export RCS in both logarithmic `dB(m²)` and `linear (m²)` formats.
*   **Post-Processing:** Load these exported files into **MATLAB** to plot and compare RCS curves across the different array sizes.

---

## 15. Notes for Beginners

*   **Beginner Tips:** Always run a quick, low-mesh simulation to verify port alignment and boundary conditions before launching a high-accuracy Time-Domain run.
*   **Runtime:** Large full-array simulations can take several hours depending on hardware. Use the runtime equations discussed in Part 2 to estimate computation times before clicking "Start".
*   **Mesh Density:** More mesh cells $\neq$ better data if the structure is simple. Keep mesh density localized around critical geometric gaps.
*   **Computational Cost:** Arrays over $16\times16$ require extensive RAM. Monitor your system's memory usage to prevent solver crashes.

---

## 16. Citation / Research Note

This repository contains data and methodologies resulting from active research in applied electromagnetics and metasurface design. If you utilize these workflows or datasets in your own studies, please ensure proper citation and acknowledge the procedural methodology outlined in this document.

---

## 📝 Author

palitakaewsena-sudo
