# Synchronous-FIFO
A parameterized Synchronous FIFO memory controller implemented in Verilog. This design features a single-clock architecture with chip-select (cs) control and configurable Depth/Width. It utilizes an $N+1$ bit pointer technique to accurately detect Full and Empty states via MSB comparison, verified by a testbench covering various R/W scenarios.
