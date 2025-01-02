# Adder_Subtractor 🔢

A simple Verilog-based project that implements a **4-bit Adder-Subtractor** circuit. This project demonstrates fundamental digital design concepts using Verilog and is perfect for those learning or revising basic arithmetic operations in hardware.

---

## 🌟 Features
- **4-Bit Addition and Subtraction**:
  - Performs addition and subtraction based on a control signal.
- **Control Signal**:
  - `0`: Addition Mode.
  - `1`: Subtraction Mode.
- Designed with modularity and reusability in mind.
- Fully synthesizable for FPGA or ASIC implementations.

---

## 🛠️ Project Structure
```plaintext
Adder_Subtractor/
├── Adder_Subtractor.v      # Main Verilog file implementing the circuit
├── testbench.v             # Testbench to verify functionality
├── README.md               # Documentation for the project
└── results/                # Directory for simulation results (e.g., waveforms, logs)



📜 How It Works
Inputs:

A (4-bit): First operand.
B (4-bit): Second operand.
Control (1-bit): Mode selector (0 for addition, 1 for subtraction).
Output:

Result (4-bit): The computed addition or subtraction.
Carry/Borrow: Indicates overflow/underflow during operations.
Logic:

In subtraction mode, B is passed through a 2’s complement converter before being added to A.




