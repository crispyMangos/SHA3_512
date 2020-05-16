module KeccakCore_tb();
    reg clk;
    reg dataDone = 0;
    reg [7:0] dataIn;
    reg bufferWR = 0;
    wire [15:0] GPIOout;
    wire done;
    reg rst = 0;
    reg go = 0;
    reg GPIO17 = 0;
    reg kill = 0;
    wire led1;

    initial begin
        $display("KeccakCore test bench");
        clk = 1;
        kill = 0;
        rst = 0;
        go = 0;
        bufferWR = 0;
        dataDone = 0;
        #10
        go = 1;
        bufferWR = 1;
        #10
        go = 0;
        bufferWR = 0;
        #10
        dataIn = 8'hff;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hff;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hff;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hff;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hff;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hff;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'heb;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbf;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbf;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hef;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hef;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hee;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hf1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h0e;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hf1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'he0;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hf1;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'he0;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h45;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hf4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'he5;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hdd;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hdd;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hd4;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h56;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h46;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h87;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h42;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h31;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h23;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h45;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'h31;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hab;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hce;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hab;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hda;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'heb;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hde;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbd;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hea;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hfe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbf;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hea;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbd;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hbe;
        bufferWR = 1;
        #10
        bufferWR = 0;
        #10
        dataIn = 8'hd0;
        bufferWR = 1;
        #10
        bufferWR = 0;
        //done sending data from pi
        dataDone = 1;
        #10;
        //dataDone = 0;
        //wait for processInput to go through all the data and XOR it if needed
        #5500
        //now pulse GPIO17 to simulate Pi getting data
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        GPIO17 = 0;
        #100
        GPIO17 = 1;
        #100
        
        #40 $finish;
    end

    always begin
        #5 clk = ~clk;  // timescale is 1ns so #5 provides 100MHz clock
    end

    KeccakCore tb (
        .clk       ( clk       ), 
        .reset(rst),
        .go(go),
        .kill(kill),
        .dataDone(dataDone),
        .GPIO(dataIn),
        .GPIOout(GPIOout),
        .piWR(bufferWR),
        .GPIO17(GPIO17),
        .led1()
        );

endmodule