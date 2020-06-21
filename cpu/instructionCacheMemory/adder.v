// Computer Architecture (CO224) - Lab 05
// Design: adder of Simple Processor
// Author: Deshan L.A.C
`timescale 1ns/100ps
module adder(STORE,EXTNDED_SHIFT, PCIN);
    input [31:0] STORE, EXTNDED_SHIFT;//inputs for the adder
    output [31:0] PCIN;               //outputs

    assign #2 PCIN = STORE + EXTNDED_SHIFT;//here with #2 delay (pc+4)+extended and shift valve is added
    
endmodule

