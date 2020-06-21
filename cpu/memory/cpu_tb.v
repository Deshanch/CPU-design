// Computer Architecture (CO224) - Lab 05
// Design: Testbench of Simple Processor
// Author: Deshan L.A.C

//import files
`include "cpu.v"
`include "memory.v"

module cpu_tb;//this is the register file
    //initialize the registers
    reg CLK, RESET;
    reg [31:0]INSTRUCTION;//32 bit size instruction
    wire [31:0] PC;//to get all 1024 address
    wire READ, WRITE, BUSYWAIT;
    wire [7:0] WRITEDATA, READDATA, RESULT;
    reg [7:0] REGISTERS[0:1023];//register is having 1024 elements and each is size 8 bit
    integer i;

    cpu mycpu(CLK, RESET, INSTRUCTION, PC, READ, WRITE, RESULT, WRITEDATA, READDATA, BUSYWAIT);
    data_memory mymemory(CLK, RESET, READ, WRITE, RESULT, WRITEDATA, READDATA, BUSYWAIT);     
  
    initial
    begin
        //these are instructions final answers is 4
        /*{REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000010000000000000101;//loadi 1 0x05
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000001000001110000000000000001;//mov 7 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00000000000000100000000000000111;//loadi 2 0x07
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00000001000001100000000000000010;//mov 6 2
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00000010000000110000000100000010;//add 3 1 2
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00000001000001000000000000000011;//mov 4 3
        {REGISTERS[24],REGISTERS[25],REGISTERS[26],REGISTERS[27]} = 32'b00000011000000000000011000000111;//sub 0 6 7
        {REGISTERS[28],REGISTERS[29],REGISTERS[30],REGISTERS[31]} = 32'b00000001000000010000000000000000;//mov 1 0
        {REGISTERS[32],REGISTERS[33],REGISTERS[34],REGISTERS[35]} = 32'b00000011000000100000011100000110;//sub 2 7 6
        {REGISTERS[36],REGISTERS[37],REGISTERS[38],REGISTERS[39]} = 32'b00000001000000010000000000000010;//mov 1 2
        {REGISTERS[40],REGISTERS[41],REGISTERS[42],REGISTERS[43]} = 32'b00000011000001010000000000000001;//sub 5 0 1
        {REGISTERS[44],REGISTERS[45],REGISTERS[46],REGISTERS[47]} = 32'b00000001000000000000000000000101;//mov 0 5       
        */
   
    //new instruction set to check the lab 6
        /*{REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000010000000000000010;//loadi 1 0x02
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000001000000100000000000000001;//mov 2 1
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001010000000000000000100000010;//swd 1 2
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001011000000000000000100000011;//swi 1 0x03
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00001001000000110000000000000011;//lwi 3 0x03
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001000000001000000000000000001;//lwd 4 1
        {REGISTERS[24],REGISTERS[25],REGISTERS[26],REGISTERS[27]} = 32'b00000010000001010000001100000100;//add 5 3 4          final answer should be 
        {REGISTERS[28],REGISTERS[29],REGISTERS[30],REGISTERS[31]} = 32'b00000000000000010000000000000001;//loadi 1 0x01
        {REGISTERS[32],REGISTERS[33],REGISTERS[34],REGISTERS[35]} = 32'b00000000000000100000000000000010;//loadi 1 0x02
        {REGISTERS[36],REGISTERS[37],REGISTERS[38],REGISTERS[39]} = 32'b00000000000000110000000000000011;//loadi 1 0x03
        {REGISTERS[40],REGISTERS[41],REGISTERS[42],REGISTERS[43]} = 32'b00001010000000000000000100000010;//swd 1 2
        {REGISTERS[44],REGISTERS[45],REGISTERS[46],REGISTERS[47]} = 32'b00001010000000000000001000000011;//swd 2 3*/

	{REGISTERS[0],REGISTERS[1],REGISTERS[2],REGISTERS[3]} = 32'b00000000000000010000000000000100;//loadi 1 0x04
        {REGISTERS[4],REGISTERS[5],REGISTERS[6],REGISTERS[7]} = 32'b00000000000000100000000000000101;//loadi 2 0x05
        {REGISTERS[8],REGISTERS[9],REGISTERS[10],REGISTERS[11]} = 32'b00001011000000000000001000000001;//swi 2 0x01
        {REGISTERS[12],REGISTERS[13],REGISTERS[14],REGISTERS[15]} = 32'b00001011000000000000000100001001;//swi 1 0x09
        {REGISTERS[16],REGISTERS[17],REGISTERS[18],REGISTERS[19]} = 32'b00001001000001000000000000000001;//lwi 4 0x01
        {REGISTERS[20],REGISTERS[21],REGISTERS[22],REGISTERS[23]} = 32'b00001001000001010000000000001001;//lwi 5 0x09
        {REGISTERS[24],REGISTERS[25],REGISTERS[26],REGISTERS[27]} = 32'b00000010000000000000010100000100;//add 0 5 4
        {REGISTERS[28],REGISTERS[29],REGISTERS[30],REGISTERS[31]} = 32'b00000000000001110000000000000001;//loadi 7 0x01
        {REGISTERS[32],REGISTERS[33],REGISTERS[34],REGISTERS[35]} = 32'b00001000000000110000000000000111;//lwd 3 7
        {REGISTERS[36],REGISTERS[37],REGISTERS[38],REGISTERS[39]} = 32'b00001010000000000000001000000001;//swd 2 1 
	{REGISTERS[40],REGISTERS[41],REGISTERS[42],REGISTERS[43]} = 32'b00001011000000000000001100100001;//swi 3 0x21
        {REGISTERS[44],REGISTERS[45],REGISTERS[46],REGISTERS[47]} = 32'b00000010000000110000001100000000;//add 3 3 0
	{REGISTERS[48],REGISTERS[49],REGISTERS[50],REGISTERS[51]} = 32'b00000000000000000000000000000001;//loadi 0 0x01
	{REGISTERS[52],REGISTERS[53],REGISTERS[54],REGISTERS[55]} = 32'b00001000000001010000000000000000;//lwd 5 0
	{REGISTERS[56],REGISTERS[57],REGISTERS[58],REGISTERS[59]} = 32'b00000010000001110000010100000000;//add 7 5 0

        CLK = 1'b1;

        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_tb);

	for (i=0;i<8; i=i+1) //can be used to observe the behaviour of stored registers
            begin
               // $dumpvars(0, mydatacache.Data[i]);
               // $dumpvars(0, mydatacache.Tag[i]);
               // $dumpvars(0, mydatacache.Valid[i]);
                //$dumpvars(0, mydatacache.Dirty[i]);
                $dumpvars(0, mycpu.regfile.REGISTERS[i]);
                //$dumpvars(0, myicache.Data[i]);
                //$dumpvars(0, myicache.Tag[i]);
                //$dumpvars(0, myicache.Valid[i]);
            end
        
        // assign values with time to input signals to see output 
        RESET = 1'b1;//initially reset all
        #2;
        RESET = 1'b0;
        //#40;
        //RESET = 1'b1;//in mid reset all
        //#2;
        //RESET = 1'b0;
        #1000;
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