This project implements a **Gauss–Jordan-based matrix inversion algorithm** on FPGA using **VHDL**.  
It supports **complex numbers with floating-point representation** and is optimized for **low resource utilization and high performance**.

## Key Features
- **Algorithm:** Gauss–Jordan elimination for matrix inversion
- **Data Type:** Complex (IEEE-754 floating-point)
- **Optimized for:** Low LUT usage, pipelining, and parallel operations
- **Applications:** MIMO systems, Radar, Image processing, Signal reconstruction

## Results
| Matrix Size | Latency (ns) | DSPs | LUTs | FFs  | BRAM |
|-------------|-------------:|-----:|-----:|-----:|-----:|
| 16×16       | 287 ns       | 42   | 15k  | 9k   | 13   |
| 32×32       | 1.6 ms       | 42   | 15k  | 9k   | 29   |
| 64×64       | 12 ms        | 42   | 15k  | 9k   | 103  |



