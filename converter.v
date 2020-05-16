`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2020 08:43:51 PM
// Design Name: 
// Module Name: converter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module converter(
    input clk1,
    input GPIO17,
    input [0:511] raw512,
    output [0:15] GPIO,
    input reset,
    input go,
    input kill,
    output reg done
    
    );
    reg [5:0] count = 6'h00;//converting from 512 to 16 requires 32 chunks
    reg [1:0] state_reg;
    parameter idle = 2'b00;
    parameter active = 2'b01;
    parameter finish = 2'b10;
    parameter abort = 2'b11;
    
    
    //512 bit FIFO signals
    reg RD512 = 0;
    //reg WR512 = 0;
    //wire [0:511] raw512;
    //wire FULL512;
    //wire EMPTY512;
    
    //16 bit FIFO signals
    reg RD16 = 0;
    reg WR16 = 0;
    reg [15:0] processed16;
    wire FULL16;
    wire EMPTY16;
    
    //assign led1 = EMPTY512;
    //assign led2 = FULL512;
    assign led3 = EMPTY16;
    assign led4 = FULL16;
    
    //-----Module Instantiations-----
    
    //FIFO buffer instantiations
    FIFO16bit piBuffer (
        .clk    (clk),
        .dataIn (processed16),
        .RD   (RD16),
        .WR   (WR16),
        .rst (reset),
        .dataOut (GPIO),
       .EMPTY (EMPTY16),
        .FULL (FULL16)  
    );
    
    //FIFO512bit resultsBuffer (
    //    .clk    (clk),
    //    .dataIn (dataIn),
    //    .RD   (RD512),
    //    .WR   (WR512),
    //    .rst (reset),
    //    .dataOut (raw512),
    //   .EMPTY (EMPTY512),
    //    .FULL (FULL512)  
    //);
    
    //edge detect instantiation
    AsyncEdgeDetect synchronizeWithPiGPIO17(
        .async_sig (GPIO17),
        .clk (clk),
        .rise(rise),
        .fall(fall)
        );
   
        
    clk_wiz_0 newClk(
    .clk_in1(clk1),
    .clk_out1(clk)
    );
    
    //-----Design Implementation
    
    //State Machine
    //always @( posedge clk or posedge reset )
    always @( posedge clk )
        begin
            if ( reset )
                state_reg <= idle;
            else
                case ( state_reg )
                    idle :
                        if ( go ) state_reg <= active;
                        
                    active :
                        if ( kill ) state_reg <= abort;
                        else if ( count == 6'd32 ) state_reg <= finish;
                    
                    finish : state_reg <= idle;
                    
                    abort : 
                        if( !kill ) state_reg <= idle;
                    default : state_reg <= idle;
                endcase
        end
    
    //Counter
    //always @( posedge clk or posedge reset )
    always @( posedge clk )   
        begin
            if ( reset ) begin
            //could tie the bugger reset lines into here
                count <= 6'h00;
                WR16 <= 0;
                RD512 <= 0;
            end
            else if ( state_reg == finish || state_reg == abort ) begin
                count <= 6'h00;
                WR16 <= 0;
                RD512 <= 0;
            end
            else if ( state_reg == active )
            //if count is 0 and RD is 0 then that is your first time so set RD high
            //else now increment count and set RD to 0 everytime because now data should be ready now need to use count and work through the 512 bit
                //could so an if statement checking if RD512 is empty then just continue waiting until that changes
                if ( count == 0 && RD512 == 0 ) RD512 <= 1; //set RD high since the new data needs to be loaded on it
                else begin
                    if ( RD512 == 1 ) RD512 <= 0; //set RD back to low
                    if ( count == 0 ) count <= 1;
                    else begin
                    WR16 <= 1;
                    case ( count )
                        6'b000001 : processed16 <= raw512[0:15];
                        6'b000010 : processed16 <= raw512[16:31];
                        6'b000011 : processed16 <= raw512[32:47];
                        6'b000100 : processed16 <= raw512[48:63];
                        6'b000101 : processed16 <= raw512[64:79];
                        6'b000110 : processed16 <= raw512[80:95];
                        6'b000111 : processed16 <= raw512[96:111];
                        6'b001000 : processed16 <= raw512[112:127];
                        6'b001001 : processed16 <= raw512[128:143];
                        6'b001010 : processed16 <= raw512[144:159];
                        6'b001011 : processed16 <= raw512[160:175];
                        6'b001100 : processed16 <= raw512[176:191];
                        6'b001101 : processed16 <= raw512[192:207];
                        6'b001110 : processed16 <= raw512[208:223];
                        6'b001111 : processed16 <= raw512[224:239];
                        6'b010000 : processed16 <= raw512[240:255];
                        6'b010001 : processed16 <= raw512[256:271];
                        6'b010010 : processed16 <= raw512[272:287];
                        6'b010011 : processed16 <= raw512[288:303];
                        6'b010100 : processed16 <= raw512[304:319];
                        6'b010101 : processed16 <= raw512[320:335];
                        6'b010110 : processed16 <= raw512[336:351];
                        6'b010111 : processed16 <= raw512[352:367];
                        6'b011000 : processed16 <= raw512[368:383];
                        6'b011001 : processed16 <= raw512[384:399];
                        6'b011010 : processed16 <= raw512[400:415];
                        6'b011011 : processed16 <= raw512[416:431];
                        6'b011100 : processed16 <= raw512[432:447];
                        6'b011101 : processed16 <= raw512[448:463];
                        6'b011110 : processed16 <= raw512[464:479];
                        6'b011111 : processed16 <= raw512[480:495];
                        6'b100000 : processed16 <= raw512[496:511];
                        default: processed16 <= 16'hffff;
                    endcase
                    count <= count + 1;
                    end
                end
        end
        
    //Done register
    //always @( posedge clk or posedge reset )
    always @( posedge clk )
        begin
            if ( reset ) 
                done <= 1'b0;
            else if ( state_reg == finish )
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    //Generate 512 input
    //always @( posedge clk ) begin
    //    if ( ~FULL512 && cnt < 128'hffffffffffffffffffffffffffffffff) begin//cnt must be less than big ass number
    //        if ( WR512 ) begin
    //            cnt <= cnt + 1;
    //            WR512 <= 0;
    //        end
    //        else begin
    //            dataIn <= cnt;
    //            //dataIn <= 512'h54686520717569636b2062726f776e20666f78206a756d706564206f766572207468652066656e636520616e642077656e7420746f207468652073746f726521;
    //            WR512 <= 1;
    //        end
    //    end
    //end
    //allow pi to read FIFO
    always @( posedge clk ) begin
        if ( rise && ~EMPTY16 ) begin
            RD16 <= 1;
        end
        else RD16 <= 0;
    end    
    
endmodule
