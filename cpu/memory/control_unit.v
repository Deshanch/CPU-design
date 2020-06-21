// Computer Architecture (CO224) - Lab 05
// Design: control unit of Simple Processor
// Author: Deshan L.A.C

module control_unit(INSTRUCTION, ALUOP, WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ, READ, WRITE, WRITESEL);

     //ports declaration
    input [31:0]INSTRUCTION;           
    output reg [2:0]ALUOP;               //initialize outputs
    output reg WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ, READ, WRITE, WRITESEL;
    
    //here according to the opcode operation write enable(WRITEENABLE) and multiplexer selections(SUBMUXSEL,IMMUXSEL) are outputing all ALUOP are given in pdf
    //here JUMP and BEQ are for j and beq

    always @ (*)//to run always depending on all
    begin
         #1;//1 time unit is given to this
         READ=1'b0; WRITE=1'b0;//initializing 
 
         case(INSTRUCTION[31:24])
              8'b00000000:
	      begin 
		   ALUOP = 3'b000;
		   WRITEENABLE = 1;//write enable is done//
		   SUBMUXSEL = 0;//no 2's complement is happen
	           IMMUXSEL = 1;// for loadi to get immediate value
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;//to select which signal is sent to the register write
	      end               //following are also same as enabling and not enabling
              8'b00000001: 
	      begin
		   ALUOP = 3'b000;
		   WRITEENABLE = 1;//
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
              8'b00000010: 
	      begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 1;//
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
              8'b00000011: 
              begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 1;//
		   SUBMUXSEL = 1;// for subtract to get 2's complement value
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
	      8'b00000100: 
              begin
		   ALUOP = 3'b010;
		   WRITEENABLE = 1;//
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
              8'b00000101: 
              begin
		   ALUOP = 3'b011;
		   WRITEENABLE = 1;//
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
              8'b00000110: //for jump
              begin
		   ALUOP = 3'bX;//for jump no alu opcode is given and it is don't care
		   WRITEENABLE = 0;//
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 1;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
              8'b00000111: //for branch if equal
              begin
		   ALUOP = 3'b001;
		   WRITEENABLE = 0;//
		   SUBMUXSEL = 1;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 1;
                   READ = 0;
                   WRITE = 0;
                   WRITESEL = 0;
	      end
////////////////////////////////////////////////////////////////////////////////////////////////////////////////// new signals for lab6
              8'b00001000: //for lwd
              begin
		   ALUOP = 3'b000;
		   WRITEENABLE = 1;
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 1;
                   WRITE = 0;
                   WRITESEL = 1;
	      end
              8'b00001001: //for lwi
              begin
		   ALUOP = 3'b000;
		   WRITEENABLE = 1;//
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 1;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 1;
                   WRITE = 0;
                   WRITESEL = 1;
	      end
              8'b00001010: //for swd
              begin
		   ALUOP = 3'b000;
		   WRITEENABLE = 0;//
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 1;
                   WRITESEL = 0;
	      end
              8'b00001011: //for swi
              begin
		   ALUOP = 3'b000;
		   WRITEENABLE = 0;
		   SUBMUXSEL = 0;//to check two registers are same subtraction is allowed
	           IMMUXSEL = 1;
                   JUMP = 0;
                   BEQ = 0;
                   READ = 0;
                   WRITE = 1;
                   WRITESEL = 0;
	      end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              default   : 
	      begin
	           ALUOP = 3'bX;//these are for other reserved controls
		   WRITEENABLE = 0;
		   SUBMUXSEL = 0;
	           IMMUXSEL = 0;
                   JUMP = 0;
                   BEQ = 0;	
                   READ = 0;
                   WRITE = 0; 
	      end 
        endcase  
    end
endmodule
