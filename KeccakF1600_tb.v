module KeccakF1600_tb();
    reg clk;
    reg go;
    reg reset;
    wire done;
    reg kill;
    reg [1599:0] state;
    wire [1599:0] state_out;

    initial begin
        $display("KeccakF1600Lanes test bench");
        clk = 1;
        kill = 0;
        reset = 0;
        go = 0;
        state = 0;
        #10
        state = 1600'hfffffffffffefefefeffebfebfbebfefefeef10efef1e0f1e0fefefe45f4e5feddddd45646874231234531abceabdaebdebdeafebfeabebdbed0;
        
        go = 1;
        #10
        go = 0;
        #9000
        #40 $finish;
    end

    always begin
        #5 clk = ~clk;  // timescale is 1ns so #5 provides 100MHz clock
    end

    KeccakF1600 tb (
        .clk       ( clk       ), 
        .go        ( go        ),
        .reset     ( reset     ),
        .done      ( done      ),
        .kill      ( kill      ),
        .state     ( state     ),
        .state_out ( state_out )
        );

endmodule