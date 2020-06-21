// Computer Architecture (CO224) - Lab 05
// Design: mux_shifter of Simple Processor
// Author: Deshan L.A.C

module mux_shift(RESULT, SHIFTED, WRITEDATA, SHIFT);//to select which value is sent to the register file to write the data

     //ports declaration 
    input [7:0]RESULT, SHIFTED; //input declaration 
    input SHIFT;          
    output reg[7:0]WRITEDATA; //initialize outputs

    always @ (*)//resting pc when reset is high is done at asynchronously and having 1 time delay
     begin
        if(SHIFT == 1)
     	   WRITEDATA = SHIFTED;//if shift is enable then give the shifte value 
        else
           WRITEDATA = RESULT;//else give the result of the alu
     end
    
endmodule
