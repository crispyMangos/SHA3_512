`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2020 08:44:17 PM
// Design Name: 
// Module Name: FIFO16bit
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


module FIFO16bit(
    input clk,
    input [15:0] dataIn,
    input RD,
    input WR,
    input rst,
    output reg [0:15] dataOut,
    output EMPTY,
    output FULL
    );
    
    reg [0:15] FIFO [511:0];
    reg [8:0] readIndex = 0; 
    reg [8:0] writeIndex = 0;
    wire [8:0] nextWrite;
    
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
