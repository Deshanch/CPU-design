// Computer Architecture (CO224) - Lab 05
// Design: sign extender with keft shift of Simple Processor
// Author: Deshan L.A.C

module SignExtendAndShift(UNEXTENDED,EXTNDED_SHIFT);
    input [7:0] UNEXTENDED;
    output reg[31:0] EXTNDED_SHIFT;

    //assign EXTNDED_SHIFT = { {24{UNEXTENDED[7]}}, UNEXTENDED }<<2;
    always @(*)//by just adding wires
    begin
         EXTNDED_SHIFT = { {24{UNEXTENDED[7]}}, UNEXTENDED };//sign extension is done here
         EXTNDED_SHIFT = {EXTNDED_SHIFT[29:0],2'b00 };       //multiply by 4 or <<2 is done by giving two zeros to the end of the wire
    end
endmodule

