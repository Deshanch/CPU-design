// Computer Architecture (CO224) - Lab 05
// Design: CPU of Simple Processor
// Author: Deshan L.A.C

//import files
`include "control_unit.v"
`include "reg_file.v"
`include "two_s_complement.v"
`include "mux_subtract.v"
`include "mux_immediate.v"
`include "alu.v"
`include "muxpc.v"
`include "pc_selection.v"
`include "signextendshift.v"
`include "adder.v"

module cpu(CLK, RESET, INSTRUCTION, PC);
     //these all names are accoding to the project names
     input CLK, RESET;           //initialize inputs
     input [31:0]INSTRUCTION;
     output [31:0]PC;         //initialize outputs
     
     reg [31:0]PC, STORE;
     reg [7:0]OPCODE, DESTINATION, SOURCE1, SOURCE2;
     reg [2:0]WRITEREG, READREG1, READREG2;
     wire WRITEENABLE, SUBMUXSEL, IMMUXSEL, SEL, JUMP, BEQ, ZERO;//SUBMUXSEL->multiplexer for selecting 2's complement or not, IMMUXSEL->multiplexer for selecting immediate value or registered read value 
     wire [2:0]ALUOP;
     wire [7:0]RESULT, REGOUT1, REGOUT2, NONIMMEDIATE,OPERAND1,TWOSCOMP;
     wire [31:0]EXTNDED_SHIFT, PCIN, PCOUT;

     //connecting to each module
     control_unit control(OPCODE, ALUOP, WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ);
     reg_file regfile(RESULT, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);
     alu alupart(REGOUT1, OPERAND1, RESULT, ZERO, ALUOP);
     mux_immediate muximmediate(IMMUXSEL, SOURCE2, NONIMMEDIATE, OPERAND1);
     mux_subtract muxsubtract(SUBMUXSEL, REGOUT2, TWOSCOMP, NONIMMEDIATE);
     twoscomplement mytwoscomplement(REGOUT2,TWOSCOMP);
     SignExtendAndShift myseas(DESTINATION, EXTNDED_SHIFT);
     adder myadder(STORE,EXTNDED_SHIFT, PCIN);
     MUXPC myMUXPC(STORE, PCIN, SEL, PCOUT);
     pc_selection mypc_selection(JUMP, BEQ, ZERO, SEL);

     always @ (posedge CLK)//writing to pc when reset is not high is done at positive clock edge and having 1 time delay
     begin
     	if(RESET == 0)
     	begin
            #1;	 
            PC = PCOUT;
     	end 
	//else
	//begin 
            //PC = -4;
     	//end
     end

     always @ (*)//resting pc when reset is high is done at asynchronously and having 1 time delay
     begin
        if(RESET == 1)
     	begin
            #1;	 
            PC = -4;
     	end 
     end

     always @ (*)//updating the pc value parallaly to Instruction Memory Read and having 2 time delay
     begin
     	#2;
        STORE = PC+4;//this is extra register to do this parallaly to store updated value 
     end

     always @ (*)
     begin
     	//#1;//this is decoding
        {OPCODE, DESTINATION, SOURCE1, SOURCE2} = INSTRUCTION;//Decode process having 1 time delay 
        WRITEREG = DESTINATION;//getting least bits
        READREG1 = SOURCE1;//getting least bits
        READREG2 = SOURCE2;//getting least bits
     end
endmodule
