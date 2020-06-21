// Computer Architecture (CO224) - Lab 05
// Design: register write select multiplexer of Simple Processor
// Author: Deshan L.A.C
`timescale 1ns/100ps
module MUXREG (RESULT, READDATA, WRITESEL, IN);
    
    input WRITESEL;              //inputs for the multiplexer
    input [7:0] RESULT, READDATA;
    output reg [7:0] IN;//output and register for the multiplexer

    always @ (*)
     begin
        if(WRITESEL == 1)
     	   IN = READDATA;//write to register what is read from the memory
        else
           IN = RESULT;//else write the out result of the alu
     end
 
endmodule
