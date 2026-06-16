<h1 align="center">📡 UART RTL Design in VHDL</h1>

<h3 align="center">
Universal Asynchronous Receiver Transmitter (UART) <br>
Designed & Verified using VHDL and Vivado
</h3>

<p align="center">
<img src="https://img.shields.io/badge/Language-VHDL-blue.svg"/>
<img src="https://img.shields.io/badge/Tool-Xilinx%20Vivado-green.svg"/>
<img src="https://img.shields.io/badge/Simulation-Passed-success.svg"/>
<img src="https://img.shields.io/badge/RTL-UART-orange.svg"/>
</p>

---

## 🚀 Project Overview

This project implements a complete **UART (Universal Asynchronous Receiver Transmitter)** protocol in **VHDL**.

UART is one of the most widely used serial communication protocols for transmitting and receiving data between digital systems.

This design includes:
✅ UART Transmitter (9600 baud)
✅ UART Receiver (9600 baud)
✅ Top-level integration
✅ Testbench verification
✅ Loopback communication (TX → RX)
✅ Data transmission (01100001)
✅ Adjustable delay (100 ms → 1 ms)
✅ Simulation waveform analysis
✅ State-machine flowchart with legends 

---

# 📘 UART Architecture

The following flowchart illustrates the UART TX and RX FSM operation along with UART frame format.

<p align="center">
<img width="1536" height="1024" alt="UART flowchart" src="https://github.com/user-attachments/assets/2f059d1f-ade1-47b4-baf2-9850a710bc2b" />


</p>

---
# Simulation Results

## Waveform Output

Shows UART transmission and reception of multiple data bytes.

<img width="1891" height="526" alt="Screenshot 2026-06-16 212109" src="https://github.com/user-attachments/assets/444951e6-21fe-41d6-af9a-a3aa83b0ba54" />

---

## Console Output

Verification from testbench showing transmitted data equals received data.

<img width="1217" height="280" alt="Screenshot 2026-06-16 211929" src="https://github.com/user-attachments/assets/598a4325-3520-4387-b7e4-70f794989555" />

Example:
```text
sent = 97   received = 97  Status: PASS : Correct Data Received (01100001)
sent = 97   received = 97  Status: PASS : Correct Data Received (01100001)
sent = 97   received = 97  Status: PASS : Correct Data Received (01100001)
sent = 97   received = 97  Status: PASS : Correct Data Received (01100001)
```

# ⚙️ Project Files
---
```bash
UART/
│
├── UART_top.vhd        # Top module
├── UART_Tx.vhd         # UART transmitter
├── UART_Rx.vhd         # UART receiver
├── UART_top_tb.vhd     # Testbench
│
└── README.md
````

<img width="303" height="376" alt="Screenshot 2026-06-04 212659" src="https://github.com/user-attachments/assets/a44e33db-6937-406d-9443-cf10e262259c" />

# Simulation Verification

Verified successfully in Vivado Behavioral Simulation.

### Observed:

- Transmitted bytes are correctly received
- `data_in == data_out`
- `busy` asserted during transmission
- Receiver reconstructs serial data correctly

---

# Tools Used
- VHDL
- Xilinx Vivado Simulator

---

# Result
UART transmitter and receiver were successfully designed and verified through simulation.

✔ Correct Serial Transmission  
✔ Correct Data Reception  
✔ Functional Verification Passed  

---


## Author

**Rishikesh Gudla**

---

## License

This project is released for educational and research purposes. Feel free to use and modify the design for learning and experimentation.
