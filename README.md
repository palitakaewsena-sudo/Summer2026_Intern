# CST Metasurface Simulation: Time-Domain Runtime Modeling & Array Optimization

Welcome to the comprehensive reproduction guide for **CST Metasurface Simulation: Time-Domain Runtime Modeling & Array Optimization**. This project details the electromagnetic simulation study of reflective metasurface unit cells and full antenna arrays using CST Studio Suite (FIT/FDTD Time Domain Solver).

This guide is designed to be highly structured and beginner-friendly, providing clear methodologies to reproduce identical simulation results.

---

## 1. Project Overview & Objectives

*   **Context:** Electromagnetic simulation study of reflective metasurface unit cells and full antenna arrays using CST Studio Suite (FIT/FDTD Time Domain Solver).
*   **Core Objective 1 (Runtime Modeling):** Establish a generalized mathematical prediction model for total simulation time ($T_{total}$) based on Mesh Cell count ($N$) and Accuracy setting ($A$ in dB), aiming for a prediction error under 10%.
*   **Core Objective 2 (Metasurface Optimization):** Optimize geometric parameters ($L_2$, $L_3$, $R$) of a 5x5, 10x10, and 16x16 Full Array to align S-parameters and Radar Cross Section (RCS) response with target frequencies (24 GHz, 30 GHz, and 38 GHz) for downstream MATLAB analysis.

---

## 2. Module 1: Time Domain Solver Runtime Analysis & Modeling

### A. The Mathematical Model

The simulation profile is broken down into Setup Time and Solver Time using these precise equations. Understanding these components is critical for accurately predicting hardware resource allocation.

*   **Total Time Formula:**
    $$T_{total}(A,N) = T_{setup}(N) + T_{solver}(N,A)$$

*   **Setup Time (Meshing + Initialization):**
    $$T_{setup}(N) = T_0 + k_1 N + k_2 \sqrt{N}$$
    > **Note:** The $\sqrt{N}$ term explicitly corrects fitting errors in small-mesh regimes.

*   **Solver Time:**
    $$T_{solver}(N,A) = (\beta_0 + \beta_1 \ln(N)) \cdot N \cdot P(A)$$
    > **Note:** The $\ln(N)$ term accounts for performance degradation from cache misses and memory bandwidth bottlenecks.

*   **Accuracy Penalty Function:**
    $$P(A) = 0.8 + 0.0032 \cdot e^{0.0825 \cdot A}$$
    > **Note:** Reflects the non-linear, exponential convergence behavior of time-domain solvers.

### B. Benchmark Calibration Dataset

Use the following reference tables to cross-check your log data during the calibration phase.

**Accuracy Effect (Unit Cell Baseline):**
Model 1 (53,136 cells) and Model 2 (82,524 cells) ran from -20 dB to -80 dB accuracy. The solver time scales exponentially at higher accuracy levels.

| Accuracy ($A$) | Model 1 Solver Time (s) | Model 2 Solver Time (s) |
| :--- | :--- | :--- |
| -20 dB | ~27s | - |
| ... | ... | ... |
| -80 dB | ~95s | - |
*(Observe the jump from 27s to 95s for Model 1, demonstrating exponential scaling).*

**Array Scaling Effect (At Fixed Accuracy A = -50 dB):**
Grid scaling from Unit Cell $\rightarrow$ 2x2 $\rightarrow$ 3x3 $\rightarrow$ 4x4 $\rightarrow$ 6x6 $\rightarrow$ 8x8.

| Grid Size | Model 1 Cells ($N$) | Model 1 Total Time ($T_{total}$) | Model 2 Cells ($N$) | Model 2 Total Time ($T_{total}$) |
| :--- | :--- | :--- | :--- | :--- |
| Max (8x8) | 1,480,100 | 885s | 2,283,996 | 904s |

### C. Step-by-Step Calibration Workflow for Beginners

1.  **Run Small-Scale Simulations:** Execute at least 3 baseline setups: Unit Cell, 2x2 Array, and either a 4x4 or 6x6 Array.
2.  **Log File Extraction:** Open the CST Simulation/Message Log. Extract the following metrics:
    *   $N_{cells}$ (Mesh Cell count)
    *   $T_{meshing} + T_{initialization}$ (Combine these into $T_{setup}$)
    *   $T_{solver}$
    *   $A$ (Accuracy in dB)
3.  **Curve Fitting:**
    *   Solve the 3-variable system to isolate hardware constants $T_0, k_1, k_2$ from the Setup Time equation.
    *   Linearize the solver equation via:
        $$\frac{T_{solver}}{N \cdot P(A)} = \beta_0 + \beta_1 \ln(N)$$
    *   Apply a linear fit to extract $\beta_0, \beta_1$.
4.  **Prediction Validation:** Use the finalized equation to predict runtimes for massive grids (8x8, 10x10, 16x16) **before** executing them to ensure hardware feasibility.

---

## 3. Module 2: Metasurface Array Parameter Optimization

### A. Tuning Strategy & Methodological Pivot

*   **The Problem:** Standard Trust Region Framework (TRF) optimization and basic Particle Swarm Optimization (PSO) algorithms either failed to converge or consumed an impractical amount of time on Full Array configurations compared to isolated Unit Cells.
*   **The Solution:** Pivot to an intentional combination of **Sequential Parameter Sweep** and **Multi-Parameter Scale Sweep** to gain direct control over frequency shifts.

### B. Execution Workflow (5x5 Array Example)

Follow this strict step-by-step guide to tune the 5x5 array:

**Phase 1: Sequential Parameter Sweep**

*   **Step 1 (Low-Frequency / L2 Tuning):**
    *   Fix $L_3 = 0.95\text{ mm}$ and $R = 1.15\text{ mm}$.
    *   Sweep $L_2$ from $2.7$ to $3.0\text{ mm}$ (Step: $0.05\text{ mm}$).
    *   **Target:** Lock resonance at **24 GHz** (Optimal: $L_2 = 2.9\text{ mm}$).
*   **Step 2 (Inter-band Tuning / L3 Tuning):**
    *   Fix optimal $L_2$ and $R = 1.15\text{ mm}$.
    *   Sweep $L_3$ from $0.8$ to $1.1\text{ mm}$ (Step: $0.05\text{ mm}$).
    *   **Target:** Achieve targeted reflection depths (Optimal: $L_3 = 1.1\text{ mm}$).
*   **Step 3 (High-Frequency / R Tuning):**
    *   Fix optimal $L_2$ and $L_3$.
    *   Sweep $R$ from $1.1$ to $1.2\text{ mm}$ (Step: $0.05\text{ mm}$).
    *   **Target:** Pull high-frequency resonance to **38 GHz** (Optimal: $R = 1.1\text{ mm}$).

**Phase 2: Multi-Parameter Scale Sweep & Fine Tuning**

*   Introduce a global `scale` parameter variable directly added onto $L_2$, $L_3$, and $R$.
*   Vary `scale` from $-0.1\text{ mm}$ to $0.1\text{ mm}$ (Step: $0.05\text{ mm}$) to perform simultaneous fine adjustments across all structures.
*   **Final Optimal Parameter Set:**
    *   Fixed parameters: $L = 3.3\text{ mm}$, $W = 3.3\text{ mm}$, $s = 0.2\text{ mm}$, $d = 0.2\text{ mm}$, $h = 0.76\text{ mm}$
    *   Optimized parameters: **$L_2 = 2.95\text{ mm}$, $L_3 = 1.1\text{ mm}$, $R = 1.15\text{ mm}$**

### C. Data Export & MATLAB Integration

After optimizing, export the final datasets across the 5x5, 10x10, and 16x16 arrays for downstream processing:

1.  Export $S_{11}$ and $S_{21}$ magnitude/phase curves.
2.  Export Bistatic RCS profiles (both Magnitude and Linear format) specifically sampled at **24 GHz, 30 GHz, and 38 GHz**.
3.  Save all data as `.txt` or `.csv` files inside a designated `data_export/` directory for post-processing in MATLAB.

---

## 4. Lessons Learned & Troubleshooting

*   **Unit Cell vs. Full Array Optimization:** Unit Cell optimization techniques (like TRF) often break down when shifted directly onto Full Array models due to complex spatial boundary conditions and significant resource load. This necessitates alternative sweep-based approaches.
*   **Runtime Prediction Errors:** Unit Cell models initially output a higher baseline error in runtime prediction equations. This occurs because of higher relative hardware initialization overhead proportions that dilute the pure solver time in smaller models.
*   **Future Outlook:** We suggest testing the established runtime modeling algorithm across varied CPU/RAM hardware environments and validating its accuracy on ultra-large array formats ($>16\times16$).
