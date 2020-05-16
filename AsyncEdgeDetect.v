`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2020 11:15:26 AM
// Design Name: 
// Module Name: edge_detect
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


module AsyncEdgeDetect (input async_sig,
                    input clk,
                    output reg rise,
                    output reg fall);

  reg [1:3] resync;

  always @(posedge clk)
  begin
    // detect rising and falling edges.
    rise <= resync[2] & !resync[3];
    fall <= resync[3] & !resync[2];
    // update history shifter.
    resync <= {async_sig , resync[1:2]};
  end

endmodule
