# Counter Decoder Comparison Summary

## Testbench Verification

✅ **The testbench is correct!** It properly:
- Instantiates both modules (p11_6 and p11_7)
- Provides clock and reset signals
- Runs for ~50 clock cycles (enough to see multiple counter cycles)
- Dumps waveforms for analysis
- Monitors outputs at clock edges

## Key Differences Explained

### Program 11-6 (Combinational Decoder)

**Code Structure:**
```verilog
always @ (posedge CLK)        // Counter updates
    Q <= Q + 1;

always @ (Q) begin             // Decoder reacts to Q changes
    S_L = 8'b11111111;        // Blocking assignment
    for (i=0; i<=7; i=i+1)
        if (i == Q) S_L[i] = 0;
end
```

**Behavior:**
- When `Q` changes on clock edge → `always @(Q)` triggers immediately
- `S_L` updates **in the same clock cycle** as `Q`
- **No delay** between counter and decoder output

### Program 11-7 (Registered Decoder)

**Code Structure:**
```verilog
always @ (posedge CLK) begin
    Q <= Q + 1;               // Counter updates
    S_L <= 8'b11111111;       // Decoder also updates
    for (i=0; i<=7; i=i+1)
        if (i == Q) S_L[i] <= 0;  // Nonblocking assignment
end
```

**Behavior:**
- Both `Q` and `S_L` update on clock edge
- But nonblocking assignments use **current** values for RHS evaluation
- So `S_L` uses the **old** value of `Q` (from previous cycle)
- **One clock cycle delay** between counter and decoder output

## Waveform Analysis

From the simulation output:

| Time | S_L_comb | S_L_reg | Meaning |
|------|----------|---------|---------|
| 6000ps | 01111111 (Q=7) | 11111111 (init) | Reset state |
| 16000ps | 10111111 (Q=6) | 01111111 (Q=7) | S_L_reg shows previous Q |
| 26000ps | 11011111 (Q=5) | 10111111 (Q=6) | One cycle behind |
| 36000ps | 11101111 (Q=4) | 11011111 (Q=5) | Consistent delay |

**Pattern:** `S_L_reg` always shows what `S_L_comb` showed in the previous cycle.

## Why This Happens

In p11_7, when the clock edge arrives:
1. **RHS evaluation phase:** All right-hand sides are evaluated using current values
   - `Q + 1` uses current `Q` (e.g., Q=0)
   - `i == Q` in the loop uses current `Q` (still Q=0)
2. **Update phase:** All left-hand sides are updated
   - `Q` becomes 1
   - `S_L` reflects Q=0 (the value used during evaluation)

This is the standard behavior of nonblocking assignments in Verilog!

## Conclusion

- **p11_6:** Combinational decoder - immediate response, no delay
- **p11_7:** Registered decoder - one cycle delay, better for timing closure

Both are correct implementations, just with different timing characteristics!




