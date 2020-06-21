// Computer Architecture (CO224) - Lab 05
// Design: CPU of Simple Processor
// Author: Deshan L.A.C

//import files
`timescale 1ns/100ps
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
`include "regWrite_mux.v"

module cpu(CLK, RESET, INSTRUCTION, PC, READ, WRITE, RESULT, REGOUT1, READDATA, BUSYWAIT);
     //these all names are accoding to the project names
     input CLK, RESET, BUSYWAIT;           //initialize inputs
     input [7:0] READDATA;
     input [31:0]INSTRUCTION;
     output READ, WRITE;
     output [7:0] RESULT, REGOUT1;
     output [31:0]PC;         //initialize outputs

     reg TEMP;//this is to control the writeenable signal 
     reg [31:0]PC, STORE;
     reg [7:0]OPCODE, DESTINATION, SOURCE1, SOURCE2;
     reg [2:0]WRITEREG, READREG1, READREG2;
     wire WRITEENABLE, SUBMUXSEL, IMMUXSEL, SEL, JUMP, BEQ, ZERO, READ, WRITE, WRITESEL;//SUBMUXSEL->multiplexer for selecting 2's complement or not, IMMUXSEL->multiplexer for selecting immediate value or registered read value 
     wire [2:0]ALUOP;
     wire [7:0]RESULT, REGOUT1, REGOUT2, NONIMMEDIATE, OPERAND1, TWOSCOMP, IN;
     wire [31:0]EXTNDED_SHIFT, PCIN, PCOUT;

     //connecting to each module
     control_unit control(INSTRUCTION, ALUOP, WRITEENABLE, SUBMUXSEL, IMMUXSEL, JUMP, BEQ, READ, WRITE, WRITESEL);//
     reg_file regfile(IN, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, TEMP, CLK, RESET);
     alu alupart(REGOUT1, OPERAND1, RESULT, ZERO, ALUOP);
     mux_immediate muximmediate(IMMUXSEL, SOURCE2, NONIMMEDIATE, OPERAND1);
     mux_subtract muxsubtract(SUBMUXSEL, REGOUT2, TWOSCOMP, NONIMMEDIATE);
     twoscomplement mytwoscomplement(REGOUT2,TWOSCOMP);
     SignExtendAndShift myseas(DESTINATION, EXTNDED_SHIFT);
     adder myadder(STORE,EXTNDED_SHIFT, PCIN);
     MUXPC myMUXPC(STORE, PCIN, SEL, PCOUT);
     pc_selection mypc_selection(JUMP, BEQ, ZERO, SEL);
     MUXREG mymuxreg(RESULT, READDATA, WRITESEL, IN);
    
     always @ (posedge CLK)//writing to pc when reset is not high is done at positive clock edge and having 1 time delay
     begin
        #1;
     	if(RESET == 0 && BUSYWAIT == 0)//write to the register is happened when reset is low and busywait is low
     	begin
            //#1;	 
            PC = PCOUT;
     	end 
	//else
	//begin 
            //PC = -4;
     	//end
     end
     
     always @ (*)
     begin
     	TEMP = WRITEENABLE && !(BUSYWAIT);//write to register always when the writeenable is high and bustwait is low
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
     	#1;//for the before lab this delay was #2 and for this lab this is time delay
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
