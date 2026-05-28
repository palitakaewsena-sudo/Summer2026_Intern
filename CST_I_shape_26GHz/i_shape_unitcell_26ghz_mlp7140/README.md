# CST Studio Suite: I-Shape Metasurface Unit Cell with PIN Diode

This repository contains the design, simulation files, and configuration parameters for an **I-shape unit cell** for metasurface applications. The design is modeled and simulated using **CST Studio Suite 2021** (Microwave Studio).

It features active reconfigurability via an integrated **PIN diode** equivalent circuit, allowing dynamic control of the metasurface's electromagnetic response.

---

## 📐 Unit Cell Geometry & Design Parameters

The metasurface unit cell is designed with an I-shaped conductive pattern on a substrate. The key geometric and material parameters defined in the project are:

| Parameter | Description | Value |
| :--- | :--- | :--- |
| `p` | Unit cell period / pitch | **5.5 mm** |
| `l` | Length of the I-shape resonator | **5.5 mm** |
| `w` | Width of the I-shape resonator | **3.8 mm** |
| `h` | Height / thickness of the resonator | **0.5 mm** |
| `g` | Gap distance in the resonator | **0.15 mm** |
| `q` | Edge Clearance | **0.635 mm** |

### ⚡ PIN Diode Equivalent Circuit Model
The active tuning of the metasurface is modeled using a lumped element equivalent circuit representing a PIN diode:
- **`Rs` (Series Resistance):** `2.0 Ω` (representing the ON-state or active state resistance)
- **`Ct` (Capacitance):** `0.12 pF` (representing the OFF-state junction capacitance)
- **`Lv` (Parasitic Inductance):** `0.25 nH`

---

## 💻 Simulation & Solver Setup

- **Software version:** CST Studio Suite 2021.1
- **Solver Type:** Frequency Domain Solver (High Frequency)
- **Mesh Type:** Tetrahedral Mesh
- **Excitation:** Plane wave illumination with variable spherical angles (`theta` and `phi`, default set to `0°` for normal incidence).

---

## 📂 Repository Structure

The repository maintains the essential source files required to load the model in CST, omitting bulky mesh caches and results to keep the repository lightweight:

```text
├── I_shape_unitcell_MLP7140-11.cst  # Main CST Studio project file
├── Model/                           # Model definition directory
│   ├── Model.prj                    # Project configuration and solver state
│   ├── Parameters.json              # Simulation parameter metadata
│   ├── PC_integration.json          # Simulia Power'By integration schema
│   ├── 3D/                          # CAD history and 3D geometry files
│   │   ├── Model.mod                # 3D modeling history
│   │   └── Model.alc                # Material and layout definitions
│   └── DS/                          # Schematic design sheet files (if any)
├── .gitignore                       # Custom Git ignore rules for CST Studio
└── README.md                        # This documentation file
```

---

## 🚀 How to Use

1. **Prerequisites:** Ensure you have **CST Studio Suite 2021** (or a compatible newer version) installed.
2. **Clone the Repository:**
   ```bash
   git clone https://github.com/palitakaewsena-sudo/CST_I_shape.git
   ```
3. **Open the Project:**
   - Launch CST Studio Suite.
   - Open [I_shape_unitcell_MLP7140-11.cst](file:///c:/Users/palit/Desktop/I_shape_unitcell_MLP7140-11/I_shape_unitcell_MLP7140-11.cst) directly.
   - CST will automatically link with the `Model` folder to load the 3D geometry, materials, and parameters.
4. **Run Simulation:**
   - Open the **Frequency Domain Solver** from the Simulation tab.
   - Configure the desired frequency range and boundary conditions (typically unit cell boundary conditions for periodic structures).
   - Click **Start** to run the simulation.
