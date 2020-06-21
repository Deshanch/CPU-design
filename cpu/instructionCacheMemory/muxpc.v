// Computer Architecture (CO224) - Lab 05
// Design: pc slect multiplexer of Simple Processor
// Author: Deshan L.A.C
`timescale 1ns/100ps
module MUXPC (STORE, PCIN, SEL, PCOUT);
    
    input SEL;              //inputs for the multiplexer
    input [31:0] STORE, PCIN;
    output reg [31:0] PCOUT;//output and register for the multiplexer

   //assign PCOUT = (1'bX)?PCIN:STORE;  //this not work for the dont care conditions
    always @ (*)//resting pc when reset is high is done at asynchronously and having 1 time delay
     begin
        if(SEL == 1)//selection is one only for jump or branch if equal occasions
     	   PCOUT = PCIN;//this happen only when jump or branch if equal occasions are happened
        else
           PCOUT = STORE;//for other events
     end
 
endmodule
