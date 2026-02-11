# Problem 6 Analysis: PLA Specifications

## Given Information from Problem 3
- **Prime Implicants**: {AB, A'B'D, A'C'D, BC'D}
- **Essential Prime Implicants**: {AB, A'B'D}
- **Variables**: A, B, C, D (4 variables)

## K-Map Coverage Analysis

### Prime Implicant Coverage:
1. **AB**: Covers minterms where AB=11 (row 11)
   - Covers: 1100, 1101, 1111, 1110 (all of row 11)

2. **A'B'D**: Covers minterms where A'B'=00 and D=1
   - Covers: 0001, 0011 (from row 00, columns 01 and 11)

3. **A'C'D**: Covers minterms where A'=1, C'=1, D=1 (i.e., A=0, C=0, D=1)
   - Covers: 0001, 0101 (B can be 0 or 1, but C must be 0)
   - Does NOT cover 0011 (because 0011 has C=1, not C=0)

4. **BC'D**: Covers minterms where BC'=01 and D=1
   - Covers: 0101, 1101 (from rows 01 and 11, column 01)

### Minterms from Problem 3:
- ABC'D = 1101
- ABC'D' = 1100
- A'BC'D = 0101
- A'B'C'D = 0001
- ABCD = 1111
- ABCD' = 1110
- A'B'CD = 0011

### Coverage Check:
- 1101: Covered by AB, BC'D
- 1100: Covered by AB (uniquely)
- 0101: Covered by A'C'D, BC'D
- 0001: Covered by A'B'D, A'C'D
- 1111: Covered by AB (uniquely)
- 1110: Covered by AB (uniquely)
- 0011: Covered by A'B'D ONLY (this makes A'B'D essential!)

### Minimal Cover:
- Essential: AB (covers 1100, 1101, 1110, 1111)
- Essential: A'B'D (covers 0001, 0011)
- Need to check: 0101 is covered by both A'C'D and BC'D

Since 0101 is covered by both A'C'D and BC'D, we need at least one of them.
However, A'C'D also covers 0001 and 0011, but those are already covered by A'B'D.

The minimal cover could be:
- Option 1: {AB, A'B'D, A'C'D} - covers all minterms
- Option 2: {AB, A'B'D, BC'D} - covers all minterms

Both have 3 product terms. Let's verify:
- Option 1: AB (covers row 11), A'B'D (covers 0001, 0011), A'C'D (covers 0001, 0011, 0101)
- Option 2: AB (covers row 11), A'B'D (covers 0001, 0011), BC'D (covers 0101, 1101)

Wait, BC'D covers 1101 which is already covered by AB. So Option 2 works.

Actually, let me reconsider. The essential prime implicants are:
- AB: essential (covers 1100, 1110 uniquely? No, but it's essential)
- A'B'D: essential (covers 0011 uniquely? Let me check...)

Actually, for a minimal cover, we need to check which minterms are uniquely covered:
- 1100: only AB
- 1110: only AB  
- 1111: only AB
- 0011: A'B'D and A'C'D both cover it
- 0001: A'B'D and A'C'D both cover it
- 0101: A'C'D and BC'D both cover it
- 1101: AB and BC'D both cover it

So AB is essential (covers 1100, 1110, 1111 uniquely).
A'B'D is essential if it covers something uniquely... but 0011 and 0001 are also covered by A'C'D.

Wait, let me check the K-map again from the description:
Row 00: 0, 1, 1, 0 (CD: 00, 01, 11, 10)
Row 01: 0, 1, 0, 0
Row 11: 1, 1, 1, 1
Row 10: 0, 0, 0, 0

So the 1s are at:
- 0001 (row 00, col 01)
- 0011 (row 00, col 11)
- 0101 (row 01, col 01)
- 1100 (row 11, col 00)
- 1101 (row 11, col 01)
- 1110 (row 11, col 10)
- 1111 (row 11, col 11)

AB covers: 1100, 1101, 1110, 1111 (all of row 11)
A'B'D covers: 0001, 0011
A'C'D covers: 0001, 0011, 0101
BC'D covers: 0101, 1101

For minimal cover:
- **AB** is essential (covers 1100, 1110, 1111 uniquely - these cannot be covered by any other prime implicant)
- **A'B'D** is essential (covers 0011 uniquely - this minterm cannot be covered by any other prime implicant)
- A'B'D also covers 0001
- We still need to cover **0101**
  - 0101 can be covered by A'C'D or BC'D
  - A'C'D covers 0001, 0101 (but 0001 already covered by A'B'D)
  - BC'D covers 0101, 1101 (but 1101 already covered by AB)

So the minimal cover requires:
- AB (essential)
- A'B'D (essential)
- One more term to cover 0101: either A'C'D or BC'D

**Minimal cover: {AB, A'B'D, A'C'D} OR {AB, A'B'D, BC'D}**

Both require **3 product terms**.

## PLA Specifications

For a PLA (Programmable Logic Array):
- **N**: Number of inputs (with both inverted and non-inverted forms available)
  - Since we have 4 variables (A, B, C, D), and each can be used in both true and complemented form
  - N = 4 (the number of distinct input variables)

- **M**: Number of AND gates (product terms)
  - This equals the number of product terms in the minimal sum-of-products
  - M = 3 (using minimal cover with 3 prime implicants)

- **K**: Number of OR gates (outputs)
  - Since this is a single-output function, K = 1

## Answer
**Smallest PLA: 4×3×1**

Where:
- N = 4 (inputs: A, B, C, D with both true and complemented forms)
- M = 3 (AND gates for 3 product terms in minimal cover)
- K = 1 (OR gate for single output)

