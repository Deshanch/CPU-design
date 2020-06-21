// Computer Architecture (CO224) - Lab 05
// Design: data cache of Simple Processor
// Author: Deshan L.A.C

`timescale 1ns/100ps
module dcache (
	clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
    busywait,//cache busywait
    mem_busywait,//busywait signal sent by the main memory
    mem_read,//read signal sent to the main memory
    mem_write,//write signal sent to the main memory
    mem_address,//address sent to the main memory
    mem_readdata,//read data sent by the main memory
    mem_writedata//data to write sent to the main memory
    );

    input            clock, reset, read, write, mem_busywait;
    input[7:0]       address, writedata;
    input[31:0]      mem_readdata;

    output reg [5:0] mem_address;
    output reg [7:0] readdata;
    //output wire [7:0] readdata;
    output reg [31:0]mem_writedata;
    output reg       busywait, mem_read, mem_write;

    reg [31:0] Data [7:0];//Declare data cache array 8x32-bits  
    reg [2:0] Tag [7:0];//Declare tag array 8x3-bits 
    reg Valid [8:0];//Declare valid bit array 8x1-bits   
    reg Dirty [8:0];//Declare dirty bit array 8x1-bits

    ////reg [31:0] data;//Declare reg of 32-bits to get indexed data 
    wire [31:0] data;//Declare reg of 32-bits to get indexed data 
    wire [2:0]tag;//to get indexed tag
    wire valid, dirty, hit;//to get indexed valid bit and dirty bit
    //wire tagCompared;
    reg tagCompared;
    //Detecting the busy wait signal
    always @(read, write,address)//assert the busywait when read or write is enable by the control unit
    begin
        busywait = (read || write)? 1 : 0;
    end 
    
    //Combinational part for indexing 
    assign #1 data = Data[address[4:2]];//to get index matched data block
    assign #1 tag = Tag[address[4:2]];//to get index matched tag
    assign #1 valid = Valid[address[4:2]];//to get index matched valid bit
    assign #1 dirty = Dirty[address[4:2]];//to get index matched dirty bit 

    //tag comparison for hit deciding, etc.
   /* assign #0.9 tagCompared = (tag == address[7:5])? 1 : 0;//tag comparison
    assign hit = tagCompared && valid;//to get the hit or miss */

    //word selecting parallel to tag comparison
    always @(*)
    begin
        #1;
        //read from correct word in the block
        if((address[1:0] == 2'b00) && read)
            readdata = data[7:0];
        if((address[1:0] == 2'b01) && read)
            readdata = data[15:8];
        if((address[1:0] == 2'b10) && read)
            readdata = data[23:16];
        if((address[1:0] == 2'b11) && read)
            readdata = data[31:24];            
    end 
    
    always @(*)//htis has to be work always
    begin
         #0.9;
        if(tag == address[7:5])
            tagCompared = 1;
        else
            tagCompared = 0;
    end 

    assign hit = tagCompared && valid;//to get the hit or miss 
    
    /*
    There was an error for swd and lwd, but when using always block as written above no matter was happen and no need of putting 0.9 for the latency instead of #1,
    but this implementation has been translated to that time scale and latency for tag comparison has been changed to the 0.9
    that error happens due to the difference between "assign" and always(*) in asynchronous combinational logic circuit 
    */
    /*assign #1 readdata = ((address[1:0] == 2'b00) && read)? data[7:0]:
                         ((address[1:0] == 2'b01) && read)? data[15:8]:
                         ((address[1:0] == 2'b10) && read)? data[23:16]:data[31:24];*/

    //word writing to the cache
    always @(posedge clock)//as it happen at positive edge of the clock
    begin
        if(hit && write && !read)
        begin
            #1;
            Valid[address[4:2]] = 1;//update the valid bit to 1 as there is the needed data
            Dirty[address[4:2]] = 1;//update to the newly fetched data block so inconsistent with the memory
            //write to correct word in the block
            if(address[1:0] == 2'b00)
                Data[address[4:2]][7:0] = writedata;
            if(address[1:0] == 2'b01)
                Data[address[4:2]][15:8] = writedata;
            if(address[1:0] == 2'b10)
                Data[address[4:2]][23:16] = writedata;
            if(address[1:0] == 2'b11)
                Data[address[4:2]][31:24] = writedata;
        end          
    end

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001, MEM_WRITE = 3'b010, CACHE_WRITE = 3'b011;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((read || write) && !dirty && !hit)//(read or write)=1, dirty=0, hit=0  
                    next_state = MEM_READ;

                else if ((read || write) && dirty && !hit)//(read or write)=1, dirty=1, hit=0 
                    next_state = MEM_WRITE;

                else//this is for a hit
                    next_state = IDLE;
            
            MEM_READ:
                if (!mem_busywait)
                    next_state = CACHE_WRITE;//read from the memory and then write to cache and update 
                else    
                    next_state = MEM_READ;//if mem_busywait=0 then stay in the same state

            MEM_WRITE:
                if (!mem_busywait)
                    next_state = MEM_READ;//write to the memory and then read from the memory 
                else    
                    next_state = MEM_WRITE;//if mem_busywait=0 then stay in the same state

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
                mem_write = 0;
                mem_address = 8'dx;
                mem_writedata = 32'dx;
                //busywait = 0;
            end
         
            MEM_READ: 
            begin
                mem_read = 1;
                mem_write = 0;
                mem_address = {address[7:2]};//new address without offset is sent to the main memory to fetch new block of data
                mem_writedata = 32'dx;
                //busywait = 1;
            end

            MEM_WRITE: 
            begin
                mem_read = 0;
                mem_write = 1;
                mem_address = {tag, address[4:2]};//existing address in the cache table without offset is sent to the main memory to write old block of data if dirty=1
                mem_writedata = data;//full data block is sent to the memory
                //busywait = 1;
            end

            CACHE_WRITE: 
            begin
                mem_read = 0;
                mem_write = 0;
                mem_address = 32'dx;
                mem_writedata = 32'dx;
                //busywait = 1;
                #1;//give an artificial time delay to 
                Data[address[4:2]] = mem_readdata;//write newly fetched block to the cache
                Tag[address[4:2]] = address[7:5];//update the tag
                Valid[address[4:2]] = 1;//update the valid bit to 1 as there is the needed data
                Dirty[address[4:2]] = 0;//no update to the newly fetched data block so no inconsistent with the memory
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
                Data[i] = 32'dx;//set to dontcare
                Tag[i] = 3'dx;//set to dontcare
                Valid[i] = 1'd0;
                Dirty[i] = 1'd0;
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
