# Parameterized LRU Cache RTL Design

## Overview

This project implements a synthesizable **Least Recently Used (LRU) Cache** in Verilog. The cache stores recently accessed addresses and uses the **LRU replacement policy** to determine which entry should be evicted when the cache becomes full.

The design supports configurable cache entry width and cache depth through parameters and demonstrates key RTL design concepts such as memory management, hit/miss detection, cache replacement policies, and sequential logic design.

---

## Project Background

This project was developed as a solution to an RTL design coding challenge encountered during an online hardware design contest.

The objective was to design a synthesizable LRU cache capable of:

* Detecting cache hits and misses
* Maintaining access history
* Reordering cache entries based on usage
* Evicting the least recently used entry when the cache becomes full

The implementation was completed independently as a learning exercise to strengthen RTL design, debugging, and digital hardware problem-solving skills.

---

## Features

* Parameterized address width and cache depth
*  LRU replacement policy
* Hit and miss detection
* Automatic cache entry reordering
* Eviction notification and evicted address output
* Synthesizable RTL implementation


---

## Cache Organization

| Parameter | Description                 |
| --------- | --------------------------- |
| WIDTH     | Width of cache entry (bits) |
| DEPTH     | Number of cache entries     |

### Default Configuration

```text
WIDTH = 8
DEPTH = 4
```

Cache entries are maintained in LRU order:

```text
mem[0]       → Least Recently Used (LRU)
...
mem[DEPTH-1] → Most Recently Used (MRU)
```

---

## Functional Description

### Cache Hit

If the requested address already exists in the cache:

* `hit` is asserted
* No eviction occurs
* The accessed entry is moved to the MRU position

Example:

Initial Cache:

```text
A B C D
^       ^
LRU    MRU
```

Request:

```text
B
```

Updated Cache:

```text
A C D B
^       ^
LRU    MRU
```

---

### Cache Miss

If the requested address is not present:

* `hit` is deasserted
* New entry is inserted into the cache

---

### Cache Full Condition

When the cache is full and a miss occurs:

* The LRU entry is evicted
* `evict_valid` is asserted
* Evicted address appears on `evicted_addr`
* New address is inserted at the MRU position

Example:

Initial Cache:

```text
A B C D
```

Request:

```text
E
```

Evicted:

```text
A
```

Updated Cache:

```text
B C D E
```

---

## Port Description

| Signal       | Direction | Width | Description              |
| ------------ | --------- | ----- | ------------------------ |
| clk          | Input     | 1     | System clock             |
| rst          | Input     | 1     | Asynchronous reset       |
| req_valid    | Input     | 1     | Request valid signal     |
| req_addr     | Input     | WIDTH | Requested address        |
| hit          | Output    | 1     | Cache hit indicator      |
| evicted_addr | Output    | WIDTH | Evicted address          |
| evict_valid  | Output    | 1     | Eviction valid indicator |

---

## Design Flow

1. Receive request address
2. Search cache entries
3. Determine hit or miss
4. Update LRU ordering
5. Insert new entries when necessary
6. Evict least recently used entry if cache is full
7. Update outputs

---

## Directory Structure

```text
lru_cache/
│
├── rtl/
│   └── lru_cache.v
│
├── tb/
│   └── lru_cache_tb.sv
│
├── waveforms/
│   └── simulation_waveform.png
│
├── docs/
│   └── design_notes.md
│
└── README.md
```

---

## Simulation and Verification

The design can be simulated using:

* QuestaSim
* ModelSim
* Vivado Simulator
* Synopsys VCS
* Cadence Xcelium

Recommended verification scenarios:

* Cache insertion
* Cache hit detection
* Cache miss detection
* LRU reordering
* Eviction behavior
* Reset functionality

---

## Example Test Sequence

| Request | Result         |
| ------- | -------------- |
| A       | Miss           |
| B       | Miss           |
| C       | Miss           |
| D       | Miss           |
| B       | Hit            |
| E       | Miss + Evict A |
| C       | Hit            |
| F       | Miss + Evict D |

---

## Future Improvements

* Self-checking SystemVerilog testbench
* Functional coverage
* Assertion-based verification
* UVM verification environment
* Support for larger cache depths
* Configurable replacement policies (FIFO, Random, LFU)
* Synthesis and timing reports

---

## Skills Demonstrated

* Verilog RTL Design
* Digital Logic Design
* Cache Memory Concepts
* LRU Replacement Algorithms
* Parameterized Hardware Design
* Sequential Logic Design
* Hardware Debugging
* Problem Solving Through RTL Coding Challenges

---

## Learning Outcome

Through this project, I gained hands-on experience with:

* Designing synthesizable hardware structures
* Implementing cache replacement policies
* Managing memory arrays in Verilog
* Debugging RTL logic
* Developing solutions to RTL coding interview/contest problems

---

## Author

**Deeksha Shekhawat**

Electronics & Communication Engineering Student

Interested in RTL Design, Digital Design Verification, Computer Architecture, and VLSI Engineering.

GitHub: https://github.com/Deekshashekhawat
# Parameterized-LRU-Cache-RTL-Design
