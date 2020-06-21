// Computer Architecture (CO224) - Lab 05
// Design: Multiplexer for immediate value selection of Simple Processor
// Author: Deshan L.A.C
`timescale 1ns/100ps
module mux_immediate(IMMUXSEL, IMMEDIATE, NONIMMEDIATE, OPERAND1);

     input IMMUXSEL;                    //initialize inputs
     input [7:0]IMMEDIATE, NONIMMEDIATE;//here inputs are immediate and non immediate values
     output [7:0]OPERAND1;              //initialize outputs

     reg [7:0]OPERAND1;

     always @ (*)
     begin
         if(IMMUXSEL == 1)
         begin
		OPERAND1 = IMMEDIATE;//if loadi then immediate value is loaded
         end
         else if(IMMUXSEL == 0)
         begin
		OPERAND1 = NONIMMEDIATE;//if not output of the subtract multipleser is loaded
         end
     end
endmodule
