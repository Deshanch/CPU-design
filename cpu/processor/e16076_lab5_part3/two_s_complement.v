// Computer Architecture (CO224) - Lab 05
// Design: 2's complement operator of Simple Processor
// Author: Deshan L.A.C

module twoscomplement (REGOUT2,TWOSCOMP);
  input  [7:0]REGOUT2;
  output [7:0]TWOSCOMP;//output for 2's complement result

  reg [7:0]TWOSCOMP;//register to store 2's complement result

  always @(*)
  begin
       TWOSCOMP = (~REGOUT2 + 'b1);//here bits comming from REGOUT2 is inverted and add 1 to it
  end
endmodule
