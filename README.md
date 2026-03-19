# Synchronous FIFO Buffer (Verilog)

A parameterized **Synchronous FIFO** memory controller implemented in Verilog. This design features a single-clock architecture with chip-select (cs) control and configurable Depth/Width. It utilizes an $N+1$ bit pointer technique to accurately detect Full and Empty states via MSB comparison, verified by a testbench covering various R/W scenarios.

##  Block Diagram
![FIFO Block Diagram](https://github.com/abhijith-d-1/Synchronous-FIFO/blob/262ec44a4e87a597fb20bc4eed9e83a429869350/Block%20diagram.png)

##  Data flow_mode
![Data flow_model](https://github.com/abhijith-d-1/Synchronous-FIFO/blob/262ec44a4e87a597fb20bc4eed9e83a429869350/Data%20flow_model.png)

## Features
* **Single-Clock Domain:** Synchronous read and write operations.
* **Parameterized Design:** Easily adjust `Depth` and `Width` during instantiation.
* **Chip Select (cs):** Enable/disable logic for power efficiency.
* **Status Flags:** Robust `full` and `empty` indicators to prevent data overflow/underflow.

## Architecture
The design uses an **extra-bit pointer method** ($N+1$ bits, where $N = \log_2(\text{Depth})$) to distinguish between a completely full and a completely empty FIFO without needing a dedicated counter:
* **Empty:** Occurs when `read_ptr == write_ptr`.
* **Full:** Occurs when the MSBs differ but the remaining bits match (indicating the write pointer has wrapped around).

## Simulation & Verification
The included testbench (`Sync_FIFO_tb.v`) verifies the design across three scenarios:
1.  **Scenario 1:** Basic sequential write followed by sequential read.
2.  **Scenario 2:** Simultaneous read and write operations.
3.  **Scenario 3:** Filling the FIFO to the `full` state and reading until `empty`.
