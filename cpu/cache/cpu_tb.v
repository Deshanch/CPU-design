// Computer Architecture (CO224) - Lab 05
// Design: Testbench of Simple Processor
// Author: Deshan L.A.C

//import files
`timescale 1ns/100ps
`include "cpu.v"
`include "data_memory.v"
`include "dcache.v"

module cpu_tb;//this is the register file
    //initialize the registers
    reg CLK, RESET;
    reg [31:0]INSTRUCTION;//32 bit size instruction
    wire [31:0] PC;//to get all 1024 address
    wire READ, WRITE, BUSYWAIT, MEM_READ, MEM_WRITE, MEM_BUSTWAIT;
    wire [5:0] MEM_ADDRESS;
    wire [7:0] WRITEDATA, READDATA, RESULT;
    wire [31:0] MEM_READDATA, MEM_WRITEDATA;
    reg [7:0] REGISTERS[0:1023];//register is having 1024 elements and each is size 8 bit
    
    cpu mycpu(CLK, RESET, INSTRUCTION, PC, READ, WRITE, RESULT, WRITEDATA, READDATA, BUSYWAIT);
    dcache mydatacache(CLK, RESET, READ, WRITE, RESULT, WRITEDATA, READDATA, BUSYWAIT, MEM_BUSTWAIT, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_READDATA, MEM_WRITEDATA);    
    data_memory mydatamemory(CLK, RESET, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READDATA, MEM_BUSTWAIT);  
    integer i;

    initial
    begin
   
    //new instruction set to check the lab 6
        /*{REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000010000000000000010;//loadi 1 0x02
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000001000000100000000000000001;//mov 2 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001010000000000000000100000010;//swd 1 2
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001011000000000000000100000011;//swi 1 0x03
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00001001000000110000000000000011;//lwi 3 0x03
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001000000001000000000000000001;//lwd 4 1
        {REGISTERS[24],REGISTERS[25],REGISTERS[26],REGISTERS[27]} = 32'b00000010000001010000001100000100;//add 5 3 4          final answer should be 
        {REGISTERS[28],REGISTERS[29],REGISTERS[30],REGISTERS[31]} = 32'b00000000000000010000000000000001;//loadi 1 0x01
        {REGISTERS[32],REGISTERS[33],REGISTERS[34],REGISTERS[35]} = 32'b00000000000000100000000000000010;//loadi 2 0x02
        {REGISTERS[36],REGISTERS[37],REGISTERS[38],REGISTERS[39]} = 32'b00000000000000110000000000000011;//loadi 3 0x03
        {REGISTERS[40],REGISTERS[41],REGISTERS[42],REGISTERS[43]} = 32'b00001010000000000000000100000010;//swd 1 2
        {REGISTERS[44],REGISTERS[45],REGISTERS[46],REGISTERS[47]} = 32'b00001010000000000000001000000011;//swd 2 3*/

        /*{REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000010000000000000010;//loadi 1 0x02
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000001000000100000000000000001;//mov 2 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001010000000000000000100000010;//swd 1 2
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001011000000000000000100100010;//swi 1 0x22
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00001001000001000000000001000010;//lwi 4 0x42     00100010
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001011000000000000001000000110;//swi 2 0x06
        //{REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001001000000000000001000000110;//lwi 2 0x06*/
//******************************************************************************************************************************************
       /* {REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000100000000000000010;//loadi 1 0x02
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000000000000110000000000000100;//mov 2 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001011000000000000001010001100;//swd 1 2
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001001000001000000000010001100;//swi 1 0x03
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00000000000000110000000010001010;//lwi 3 0x03
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001010000000000000001000000011;//lwd 4 1
        {REGISTERS[24],REGISTERS[25],REGISTERS[26],REGISTERS[27]} = 32'b00000010000001000000010000000001;//add 5 3 4          final answer should be 
        {REGISTERS[28],REGISTERS[29],REGISTERS[30],REGISTERS[31]} = 32'b00001000000001010000000000000011;//loadi 1 0x01
        {REGISTERS[32],REGISTERS[33],REGISTERS[34],REGISTERS[35]} = 32'b00000010000001010000010100000010;//loadi 2 0x02*/
//**************************************************************************************************************************************************
        //{REGISTERS[36],REGISTERS[37],REGISTERS[38],REGISTERS[39]} = 32'b00001000000001100000000000000001;//loadi 3 0x03
//******************************************************************************************************************************************
       /* {REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000000000000000001001;//loadi 1 0x02
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000000000000010000000000000001;//mov 2 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001010000000000000000000000001;//swd 1 2
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001011000000000000000100100000;//swi 1 0x03
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00001000000000100000000000000001;//lwi 3 0x03
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00000011000001000000000000000001;//lwd 4 1*/
//**************************************************************************************************************************************************
	    {REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000010000000000000010;//loadi 1 0x02
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000001000000100000000000000001;//mov 2 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001010000000000000000100000010;//swd 1 2
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001011000000000000000100100010;//swi 1 0x22
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00001001000001000000000001000010;//lwi 4 0x42     00100010
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001011000000000000001000000110;//swi 2 0x06

        CLK = 1'b1;

        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_tb);

        for (i=0;i<8; i=i+1) //can be used to observe the behaviour of stored registers
            begin
                $dumpvars(0, mydatacache.Data[i]);
                $dumpvars(0, mydatacache.Tag[i]);
                $dumpvars(0, mydatacache.Valid[i]);
                $dumpvars(0, mydatacache.Dirty[i]);
                $dumpvars(0, mycpu.regfile.REGISTERS[i]);
            end
        
        // assign values with time to input signals to see output 
        RESET = 1'b1;//initially reset all
        #2;
        RESET = 1'b0;
        //#40;
        //RESET = 1'b1;//in mid reset all
        //#2;
        //RESET = 1'b0;
        #1200;
        $finish;
    end
    
    // clock signal generation
    always
         #4 CLK = ~CLK;//changing clk period to 8 time units
        //#5 CLK = ~CLK;
    
         
    always @ (PC)//Instruction Memory Read
     begin
	  #2;//time delay for this
	  INSTRUCTION = {REGISTERS[PC],REGISTERS[PC+1],REGISTERS[PC+2],REGISTERS[PC+3]};//getting the instruction according to the pc value
     end
     
endmodule
