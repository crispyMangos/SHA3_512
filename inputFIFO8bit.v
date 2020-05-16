`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2020 11:51:33 AM
// Design Name: 
// Module Name: IOFIFO16bit
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


module inputFIFO8bit(
    input clk,
    input [7:0] dataIn,
    input RD,
    input WR,
    input rst,
    output reg [7:0] dataOut,
    output EMPTY,
    output FULL
    );
    
    wire [7:0] nextWrite;
    reg [7:0] FIFO [255:0];
    reg [7:0] readIndex = 0; 
    reg [7:0] writeIndex = 0;
    
    assign nextWrite = writeIndex + 1;
    assign EMPTY = (readIndex == writeIndex)? 1'b1:1'b0;
    assign FULL = (nextWrite == readIndex)? 1'b1:1'b0;
    
    always @(posedge clk) begin
        if ( rst ) begin 
            readIndex <= 0; 
            writeIndex <= 0;
        end
        else begin
        if ( RD == 1 && ~EMPTY ) begin
            dataOut <= FIFO[readIndex];
            readIndex <= readIndex + 1;
        end
        if ( WR == 1 && ~FULL ) begin
            FIFO[writeIndex] <= dataIn;
            writeIndex <= writeIndex + 1;
        end
        end
    end
    
    
endmodule
