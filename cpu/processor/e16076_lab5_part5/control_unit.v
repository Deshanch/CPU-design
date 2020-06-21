// Computer Architecture (CO224) - Lab 05
// Design: control unit of Simple Processor
// Author: Deshan L.A.C

module control_unit(OPCODE, ALUOP, WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ, BNE, SHIFT_SEL, SHIFT);

     //ports declaration
    input [7:0]OPCODE;           
    output [2:0]ALUOP, SHIFT_SEL;               //initialize outputs
    output WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ, BNE, SHIFT;
    //register declaration
    reg [2:0]ALUOP, SHIFT_SEL;
    reg WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ, BNE, SHIFT; 
    //here according to the opcode operation write enable(WRITEENABLE) and multiplexer selections(SUBMUXSEL,IMMUXSEL) are outputing all ALUOP are given in pdf
    //here JUMP and BEQ are for j and beq
    always @ (*)//to run always depending on all
    begin
         #1;//1 time unit is given to this 
         case(OPCODE)
              8'b00000000://loadi
	      begin 
		   ALUOP = 3'b000;
		   WRITEENABLE = 1;//write enable is done
		   SUBMUXSEL = 0;//no 2's complement is happen
	           IMMUXSEL = 1;// for loadi to get immediate value
                   JUMP = 0;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end               //following are also same as enabling and not enabling
              8'b00000001://mov 
	      begin
		   ALUOP = 3'b000;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
		   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00000010: //add
	      begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00000011: //sub 
              begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 1;// for subtract to get 2's complement value
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
	      8'b00000100: //and
              begin
		   ALUOP = 3'b010;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00000101: //or
              begin
		   ALUOP = 3'b011;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00000110: //for jump
              begin
		   ALUOP = 3'bX;//for jump no alu opcode is given and it is don't care
		   WRITEENABLE = 0;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 1;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00000111: //for branch if equal
              begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 0;
		   SUBMUXSEL = 1;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 1;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00001010: //for branch not equal
              begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 0;
		   SUBMUXSEL = 1;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0; 
                   BNE = 1;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;
	      end
              8'b00001011: //for logical shift left
              begin
		   ALUOP = 3'bX;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 1;
                   JUMP = 0;
                   BEQ = 0; 
                   BNE = 0;
                   SHIFT_SEL = 3'b000;
                   SHIFT = 1;
	      end
              8'b00001100: //for logical shift right
              begin
		   ALUOP = 3'bX;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 1;
                   JUMP = 0;
                   BEQ = 0; 
                   BNE = 0;
                   SHIFT_SEL = 3'b001;
                   SHIFT = 1;
	      end
              8'b00001101: //for arithmetic shift right
              begin
		   ALUOP = 3'bX;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 1;
                   JUMP = 0;
                   BEQ = 0; 
                   BNE = 0;
                   SHIFT_SEL = 3'b011;
                   SHIFT = 1;
	      end
              8'b00001110: //for rotate right
              begin
		   ALUOP = 3'bX;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 1;
                   JUMP = 0;
                   BEQ = 0; 
                   BNE = 0;
                   SHIFT_SEL = 3'b101;
                   SHIFT = 1;
	      end
              default   : 
	      begin
	           ALUOP = 3'bX;//these are for other reserved controls
		   WRITEENABLE = 0;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   BNE = 0;
                   SHIFT_SEL = 3'bX;
                   SHIFT = 0;	 
	      end 
        endcase  
    end
endmodule
