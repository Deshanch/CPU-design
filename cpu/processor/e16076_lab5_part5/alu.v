// Computer Architecture (CO224) - Lab 05
// Design: ALU of Simple Processor
// Author: Deshan L.A.C

module alu(DATA1, DATA2, RESULT, ZERO, SELECT);//just as method

        //ports declaration
	input [0:7]DATA1;           //initialize inputs for operand1
        input [0:7]DATA2;           //initialize inputs for operand2
        input [0:2]SELECT;          //select the operation
	output [0:7]RESULT;         //initialize outputs
        output ZERO;
        
        reg [0:7]RESULT;//reg is used as data type for variables to which values are assigned

        assign ZERO = ~(|RESULT);//always inverse of the result is assigned to the zero which is a one bit signal
	
	always @ (DATA1, DATA2, SELECT)//to run always when the arguments get changed   
	begin 
                case(SELECT)
                        3'b000    :
			begin 
				#1;                          //giving related timing delay
				RESULT = DATA2;             // If selection=000, output is taken by loadi, mov functions
			end
                        3'b001    : 
			begin
				#2;                           //giving related timing delay
				RESULT = DATA1 + DATA2;     // If selection=001, output is taken by add, sub functions
			end
                        3'b010    : 
			begin
				#1;                          //giving related timing delay
				RESULT = DATA1 & DATA2;     // If selection=010, output is taken by and functions
			end
			3'b011    : 
			begin
				#1;                           //giving related timing delay
				RESULT = DATA1 | DATA2;     // If selection=011, output is taken by or functions
			end
                        default   : 
			begin
				RESULT = 8'bX ;             // If selection is anything else, out is reserved so it is put 'don't cares' 
			end 
                endcase  
       end	
endmodule


	
	 
	
	
