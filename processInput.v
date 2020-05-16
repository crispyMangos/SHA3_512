`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2020 02:05:55 PM
// Design Name: 
// Module Name: processInput
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


module processInput(
    input clk,
    input [1599:0] state_in,
    output [1599:0] state_out,
    input dataDone,
    input [7:0] dataIn,
    input bufferWR,
    output [6:0] chunkCount,
    output done,
    output piBufferEmpty,
    input rst,
    input go,
    input kill
    );
    wire write;
    wire fall;
    wire EMPTY;
    wire FULL;
    wire RD;
    wire [7:0] byteToProcess;
    //wire [6:0] chunkCount;
    
    inputFIFO8bit piBuffer(
        .clk     ( clk           ),
        .dataIn  ( dataIn        ),
        .RD      ( RD            ),
        .WR      ( write         ),
        .rst     ( rst           ),
        .dataOut ( byteToProcess ),
        .EMPTY   ( EMPTY         ),
        .FULL    ( FULL          )
    );
    
    AsyncEdgeDetect edgeDetect(
        .async_sig ( bufferWR ),
        .clk       ( clk      ),
        .rise      ( write    ),
        .fall      ( fall     )
    );
    
    absorbInput absorb(
        .clk        ( clk           ),
        .reset      ( rst           ),
        .go         ( go            ),
        .kill       ( kill          ),
        .dataDone   ( dataDone      ),
        .dataIn     ( byteToProcess ),
        .state_in   ( state_in      ),
        .EMPTY      ( EMPTY         ),
        .state_out  ( state_out     ),
        .done       ( done          ),
        .RD         ( RD            ),
        .count ( chunkCount    )
    );
    
endmodule
