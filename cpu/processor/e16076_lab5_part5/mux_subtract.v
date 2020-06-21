// Computer Architecture (CO224) - Lab 05
// Design: Multiplexer for subtraction of Simple Processor
// Author: Deshan L.A.C

module mux_subtract(SUBMUXSEL, REGOUT2, TWOSCOMP, NONIMMEDIATE);

     input SUBMUXSEL;                  //initialize inputs
     input [7:0]REGOUT2, TWOSCOMP;
     output [7:0]NONIMMEDIATE;         //initialize outputs

     reg [7:0]NONIMMEDIATE;            //this is named as this because this is the non immediate value to the next multiplexer

     always @ (*)
     begin
         if(SUBMUXSEL == 1)
         begin
		NONIMMEDIATE = TWOSCOMP;//if it is a subtraction then operate 2's complement
         end
         else if(SUBMUXSEL == 0)
         begin
		NONIMMEDIATE = REGOUT2;//if not give the original value
         end
     end
endmodule
