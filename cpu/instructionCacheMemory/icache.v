// Computer Architecture (CO224) - Lab 05
// Design: instruction cache of Simple Processor
// Author: Deshan L.A.C

`timescale 1ns/100ps
module icache (
	clock,
    reset,
    address,
    instruction,
    busywait,//instruction cache busywait
    mem_busywait,//busywait signal sent by the instruction memory
    mem_read,//read signal sent to the instruction memory
    mem_address,//address sent to the instruction memory
    mem_readdata//read data sent by the instruction memory
    );

    input            clock, reset, mem_busywait;
    input[9:0]       address;
    input[127:0]     mem_readdata;

    output reg [5:0] mem_address;
    output reg [31:0] instruction;
    output reg       busywait, mem_read;

    reg [127:0] Data [7:0];//Declare data cache array 8x128-bits  
    reg [2:0] Tag [7:0];//Declare tag array 8x3-bits 
    reg Valid [7:0];//Declare valid bit array 8x1-bits   

    wire [127:0] data;//Declare reg of 128-bits to get indexed data 
    wire [2:0]tag;//to get indexed tag
    wire valid, hit;//to get indexed valid bit and dirty bit
    reg tagCompared;//to store tag comparison
    //Detecting the busy wait signal

    always @(address)//assert the busywait when a new address is came to the instruction cache
    begin
        if (address != 10'b1111111100) 
        begin
            busywait = 1;
        end
    end 
    
    //Combinational part for indexing 
    assign #1 data = Data[address[6:4]];//to get index matched data block
    assign #1 tag = Tag[address[6:4]];//to get index matched tag
    assign #1 valid = Valid[address[6:4]];//to get index matched valid bit

    //tag comparison for hit deciding, etc.

    //word selecting parallel to tag comparison
    always @(*)
    begin
        #1; 
        if(hit)//here have to check the hit otherwise wrong instruction is operated in the system
        begin
           //read from correct word in the block according to the offset
            if(address[3:2] == 2'b00)
                instruction = data[31:0];
            if(address[3:2] == 2'b01)
                instruction = data[63:32];
            if(address[3:2] == 2'b10)
                instruction = data[95:64];
            if(address[3:2] == 2'b11)
                instruction = data[127:96];  
        end         
    end

    always @(*)//this has to be work always
    begin
        if (!hit)//if there is no hit not to take instruction
        begin
            instruction = 32'bx;
        end
    end

    always @(*)//this has to be work always
    begin
         #0.9;
        if(tag == address[9:7])
            tagCompared = 1;
        else
            tagCompared = 0;
    end 

    assign hit = tagCompared && valid;//to get the hit or miss 

    /* Cache Controller FSM Start */

    parameter IDLE = 2'b00, MEM_READ = 2'b01, CACHE_WRITE = 2'b10;//here only needs three states
    reg [1:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if (!hit && (address != 10'b1111111100))// hit=0  && address  
                    next_state = MEM_READ;

                else//this is for a hit
                    next_state = IDLE;
            
            MEM_READ:
                if (!mem_busywait)
                    next_state = CACHE_WRITE;//read from the memory and then write to cache and update 
                else    
                    next_state = MEM_READ;//if mem_busywait=0 then stay in the same state

            CACHE_WRITE:
                next_state = IDLE;//it is always idle state after cache is updated
            
        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                mem_read = 0;
                mem_address = 8'dx;
                //busywait = 0;
            end
         
            MEM_READ: 
            begin
                mem_read = 1;
                mem_address = {address[9:4]};//new address without offset is sent to the main memory to fetch new block of data
                //busywait = 1;
            end

            CACHE_WRITE: 
            begin
                mem_read = 0;
                mem_address = 32'dx;
                //busywait = 1;
                #1;//give an artificial time delay to 
                Data[address[6:4]] = mem_readdata;//write newly fetched block to the cache
                Tag[address[6:4]] = address[9:7];//update the tag
                Valid[address[6:4]] = 1;//update the valid bit to 1 as there is the needed data
            end
            
        endcase
    end

    // sequential logic for state transitioning 
    integer i;

    always @(posedge clock, reset)
    begin
        if(reset)
        begin
            state = IDLE;
            for (i=0;i<8; i=i+1)
            begin
                Data[i] = 128'dx;
                Tag[i] = 3'dx;
                Valid[i] = 1'd0;
                /*
                in reset i have put zero both Data and Tag,actually it must be dont care when it is reseting.but there is no issue for the operation as i have put valid=0 in reseting 
                so even there is a tag of matching the hit is zero for initial case as valid is zero.
                */
            end    
        end    

        else
            state = next_state;
            if(state == IDLE)
                busywait = 0;
    end

    /* Cache Controller FSM End */

endmodule
