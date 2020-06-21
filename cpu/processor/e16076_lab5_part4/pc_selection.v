// Computer Architecture (CO224) - Lab 05
// Design: pc value selecting of Simple Processor
// Author: Deshan L.A.C

module pc_selection (JUMP, BEQ, ZERO, SEL);
    
    input JUMP, BEQ, ZERO;//inputs 
    output  SEL;          //outputs just wires

    assign SEL = JUMP | BEQ & ZERO;//(jump) or (beq and zero) this calculate the selection 
 
endmodule
