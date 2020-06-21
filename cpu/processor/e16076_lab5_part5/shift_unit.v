// Computer Architecture (CO224) - Lab 05
// Design: shifter unit of Simple Processor
// Author: Deshan L.A.C

module shift_unit(OPERAND1, REGOUT1, SHIFT_SEL, SHIFTED);//this is to do the given shift function

     //ports declaration 
    input [7:0]OPERAND1, REGOUT1; //initialize inputs
    input [2:0]SHIFT_SEL;          
    output reg[7:0]SHIFTED;        //initialize outputs
    
    always @ (*)//to run always depending on all
    begin 
         case(SHIFT_SEL)
              3'b000://logical shift left
	      begin
                   #1;//1 time unit is given to this 
		   case (OPERAND1)  
                        8'd0   : SHIFTED = {REGOUT1[7:0]};  
                        8'd1   : SHIFTED = {REGOUT1[6:0], 1'b0};
                        8'd2   : SHIFTED = {REGOUT1[5:0], 2'b00};
                        8'd3   : SHIFTED = {REGOUT1[4:0], 3'b000};
                        8'd4   : SHIFTED = {REGOUT1[3:0], 4'b0000};
                        8'd5   : SHIFTED = {REGOUT1[2:0], 5'b00000};
                        8'd6   : SHIFTED = {REGOUT1[1:0], 6'b000000};
                        8'd7   : SHIFTED = {REGOUT1[0], 7'b0000000};
                        8'd8   : SHIFTED = {8'b00000000};
                   endcase  
	      end               
              3'b001://logical shift right 
	      begin
		   #1;
                   case (OPERAND1)  
                        8'd0   : SHIFTED = {REGOUT1[7:0]};  
                        8'd1   : SHIFTED = {1'b0, REGOUT1[7:1]};
                        8'd2   : SHIFTED = {2'b00, REGOUT1[7:2]};
                        8'd3   : SHIFTED = {3'b000, REGOUT1[7:3]};
                        8'd4   : SHIFTED = {4'b0000, REGOUT1[7:4]};
                        8'd5   : SHIFTED = {5'b00000, REGOUT1[7:5]};
                        8'd6   : SHIFTED = {6'b000000, REGOUT1[7:6]};
                        8'd7   : SHIFTED = {7'b0000000, REGOUT1[7]};
                        8'd8   : SHIFTED = {8'b00000000};
                   endcase
	      end
              3'b011: //arithmetic shift right
	      begin
		   #1;
                   case (OPERAND1)  
                        8'd0   : SHIFTED = {REGOUT1[7:0]};  
                        8'd1   : SHIFTED = {REGOUT1[7], REGOUT1[7:1]};
                        8'd2   : SHIFTED = {{2{REGOUT1[7]}}, REGOUT1[7:2]};
                        8'd3   : SHIFTED = {{3{REGOUT1[7]}}, REGOUT1[7:3]};
                        8'd4   : SHIFTED = {{4{REGOUT1[7]}}, REGOUT1[7:4]};
                        8'd5   : SHIFTED = {{5{REGOUT1[7]}}, REGOUT1[7:5]};
                        8'd6   : SHIFTED = {{6{REGOUT1[7]}}, REGOUT1[7:6]};
                        8'd7   : SHIFTED = {{7{REGOUT1[7]}}, REGOUT1[7]};
                        8'd8   : SHIFTED = {{8{REGOUT1[7]}}};
                   endcase
	      end
              3'b101: //rotate right  
              begin
		   #1;
                   case (OPERAND1)  
                        8'd0   : SHIFTED = {REGOUT1[7:0]};  
                        8'd1   : SHIFTED = {REGOUT1[0], REGOUT1[7:1]};
                        8'd2   : SHIFTED = {REGOUT1[1], REGOUT1[0], REGOUT1[7:2]};
                        8'd3   : SHIFTED = {REGOUT1[2], REGOUT1[1], REGOUT1[0], REGOUT1[7:3]};
                        8'd4   : SHIFTED = {REGOUT1[3], REGOUT1[2], REGOUT1[1], REGOUT1[0], REGOUT1[7:4]};
                        8'd5   : SHIFTED = {REGOUT1[4], REGOUT1[3], REGOUT1[2], REGOUT1[1], REGOUT1[0], REGOUT1[7:5]};
                        8'd6   : SHIFTED = {REGOUT1[5], REGOUT1[4], REGOUT1[3], REGOUT1[2], REGOUT1[1], REGOUT1[0], REGOUT1[7:6]};
                        8'd7   : SHIFTED = {REGOUT1[6], REGOUT1[5], REGOUT1[4], REGOUT1[3], REGOUT1[2], REGOUT1[1], REGOUT1[0], REGOUT1[7]};
                        8'd8   : SHIFTED = {REGOUT1[7:0]};
                   endcase
	      end
              default   : //no time delays for other types of shifts
	      begin
	           SHIFTED = 8'bX;	 
	      end 
        endcase  
    end
endmodule
