module testbench;
	reg [0:7]OPERAND1;  //setting the registers
        reg [0:7]OPERAND2;  //valves get assigned laterly
        reg [0:2]ALUOP;
	wire [0:7]ALURESULT;//setting the wire

	alu myalu (OPERAND1, OPERAND2, ALURESULT, ALUOP);//this just like making objects in java,where we call to the module
 	
	initial 
	begin
		//see how signals vary using command line
		$monitor ($time, " OPERAND1 : %b, OPERAND2 : %b, ALUOP : %b, ALURESULT : %b", OPERAND1, OPERAND2, ALUOP, ALURESULT);//just as print function happen in t = 0
		//generate files needed to plot the waveform using GTKWave
		$dumpfile ("wavedata_alu.vcd");// GTKWave file is created
		$dumpvars (0, testbench);
	end
        initial 
	begin
		OPERAND1 = 8'b10001001;//'eight bit binary' value
		OPERAND2 = 8'b00111100;//'eight bit binary' value
		ALUOP = 3'b000;        //initial selection
		//the following selections occur after 10 ns in each  time(these are to check the code)
                #10          
                ALUOP = 3'b001;

                #10
                ALUOP = 3'b010;

		#10
                ALUOP = 3'b011;
		OPERAND2 = 8'b00101101;

		#10
                ALUOP = 3'b111;

		#10
                ALUOP = 3'b110;
	end
endmodule

module alu(DATA1, DATA2, RESULT, SELECT);//just as method

        //ports declaration
	input [0:7]DATA1;           //initialize inputs for operand1
        input [0:7]DATA2;           //initialize inputs for operand2
        input [0:2]SELECT;          //select the operation
	output [0:7]RESULT;         //initialize outputs
        
        reg [0:7]RESULT;//reg is used as data type for variables to which values are assigned
	
	always @ (DATA1, DATA2, SELECT)//to run always when the arguments get changed
	begin 
                case(SELECT)
                        3'b000    :
			begin 
				#1;                          //giving related timing delay
				RESULT <= DATA2;             // If selection=000, output is taken by loadi, mov functions
			end
                        3'b001    : 
			begin
				#2;                           //giving related timing delay
				RESULT <= DATA1 + DATA2;     // If selection=001, output is taken by add, sub functions
			end
                        3'b010    : 
			begin
				#1;                          //giving related timing delay
				RESULT <= DATA1 & DATA2;     // If selection=010, output is taken by and functions
			end
			3'b011    : 
			begin
				#1;                           //giving related timing delay
				RESULT <= DATA1 | DATA2;     // If selection=011, output is taken by or functions
			end
                        default   : 
			begin
				RESULT <= 8'bX ;             // If selection is anything else, out is reserved so it is put 'don't cares' 
			end 
                endcase  
       end	
endmodule


	
	 
	
	
