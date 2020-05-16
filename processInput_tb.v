module processInput_tb();
    reg clk;
    reg [1599:0] state_in;
    wire [1599:0] state_out;
    reg dataDone;
    reg [7:0] dataIn;
    reg bufferWR;
    wire [6:0] chunkCount;
    wire done;
    reg rst;
    reg go;
    wire EMPTY;
    reg kill;

    initial begin
        $display("processInput test bench");
        clk = 1;
        kill = 0;
        rst = 0;
        go = 0;
        state_in = 1600'h0;
        bufferWR = 0;
        dataDone = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd2;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd3;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd6;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd7;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd8;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd9;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd10;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd11;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'd15;
        bufferWR = 1;
        #10
        dataDone = 1;
        bufferWR = 0;
        go = 1;
        #10
        go = 0;
        #1000
        go = 1;
        #10
        go = 0;
        #2000
        #40 $finish;
    end

    always begin
        #5 clk = ~clk;  // timescale is 1ns so #5 provides 100MHz clock
    end

    processInput tb (
        .clk       ( clk       ), 
        .go        ( go        ),
        .rst     ( rst       ),
        .done      ( done      ),
        .piBufferEmpty(EMPTY),
        .kill      ( kill      ),
        .state_in  ( state_in  ),
        .state_out ( state_out ),
        .dataDone  ( dataDone  ),
        .dataIn    ( dataIn    ),
        .bufferWR  ( bufferWR ),
        .chunkCount ( chunkCount)
        );

endmodule