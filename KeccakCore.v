`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2020 11:31:48 AM
// Design Name: 
// Module Name: state_machine_1
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


module KeccakCore(
    input clk,
    input reset,
    input go,
    input kill,
    input dataDone,
    input [7:0] GPIO,
    output [15:0] GPIOout,
    input piWR,
    input GPIO17,
    //input goAsync,
    //input [1599:0] state_in,
    //input EMPTY,
    //output reg [1599:0] state_out,
    output led1
    //output reg RD,
    //output reg [6:0] count
    );
    reg [1599:0] paddingState = 0;
    reg paddingCount = 0;
    reg [3:0] state_reg = 0;
    reg done = 0;
    assign led1 = done;
    reg processInputDone = 0;
    reg processInputBusy = 0;
    reg paddingDone = 0;
    reg [1599:0] state = 0;
    wire goRise;
    wire goFall;
    
    wire rstRise;
    wire rstFall;
    
    wire killRise;
    wire killFall;
    
    wire dataDoneRise;
    wire dataDoneFall;
    
    wire [1599:0] processInput_state_out;
    reg [1599:0] processInput_state_in = 0;
    reg processInput_go = 0;
    
    wire [6:0] chunkCount;
    wire piBufferEmpty;
    wire processDone;
    
    reg keccak1go = 0;
    wire keccak1Done;
    reg [1599:0] keccak1_state_in = 0;
    wire [1599:0] keccak1_state_out;
    reg k1Done = 0;
    reg k1Busy = 0;
    
    reg keccak2go = 0;
    wire keccak2Done;
    reg [1599:0] keccak2_state_in = 0;
    wire [1599:0] keccak2_state_out;
    reg k2Done = 0;
    reg k2Busy = 0;
    
    reg [511:0] raw512 = 0;
    reg outDone = 0;
    reg outBusy = 0;
    wire outputDone;
    reg goConverter = 0;
    
    //parameters are local to each individual state machine
    parameter idle = 4'b0000;
    parameter waitState = 4'b0001;
    parameter processInput = 4'b0010;
    parameter keccak1 = 4'b0011;
    parameter padding = 4'b0100;
    parameter keccak2 = 4'b0101;
    parameter bufferToMatchClockDomains = 4'b0110;
    parameter outputState = 4'b0111;
    parameter finish = 4'b1000;
    parameter abort = 4'b1001;
    
    //------------Desgin implementation------------
    
    //State Machine
    always @( posedge clk )
        begin
            if ( reset )
                state_reg <= idle;
            else
                case ( state_reg )
                    idle : 
                        if ( goRise ) state_reg <= waitState;
                    
                    waitState : 
                        if ( dataDone ) state_reg <= processInput;
                    
                    processInput :
                        if ( processDone ) begin //need to work on how these are called cuz I am pretty sure they will run again when they move to the next step
                            state <= processInput_state_out;
                            if ( chunkCount == 72 ) state_reg <= keccak1;
                            else begin 
                                state_reg <= padding;
                                //paddingState <= processInput_state_out;
                            end
                        end
                    
                    keccak1 :
                        if ( keccak1Done ) begin 
                            state <= keccak1_state_out;
                            state_reg <= processInput;
                        end
                        
                    padding : if ( paddingDone ) begin
                        state_reg <= keccak2;
                        state <= paddingState;
                    end
                    keccak2 :
                        if ( keccak2Done ) begin 
                            state <= keccak2_state_out;
                            state_reg <= bufferToMatchClockDomains;
                        end
                    
                    bufferToMatchClockDomains : state_reg <= outputState;
                    
                    outputState : if ( outputDone ) state_reg <= finish;//need to work on output state just kinda bullshitted that
                    
                    finish : state_reg <= idle;
                    
                    abort : 
                        if( !kill ) state_reg <= idle;
                    default : state_reg <= idle;
                endcase
        end
    
    //Counter
    always @( posedge clk )   
        begin
            if ( state_reg == processInput ) begin
                if ( processDone ) begin//definately think this is called again evem after it is done
                    //processInputDone <= 1; 
                    processInputBusy <= 0;
                end
                else if ( ~processInputBusy ) begin
                    processInput_state_in <= state;
                    processInputBusy <= 1;
                    processInput_go <= 1;
                    //processInputDone <= 0;
                end
                else processInput_go <= 0;
            end
        end

//Counter
    always @( posedge clk )   
        begin
            if ( state_reg == keccak1 ) begin
                if ( keccak1Done ) begin//definately think this is called again evem after it is done
                    //k1Done <= 1; 
                    k1Busy <= 0;
                end
                else if ( ~processInputBusy ) begin
                    keccak1_state_in <= state;
                    k1Busy <= 1;
                    keccak1go <= 1;
                    //k1Done <= 0;
                end
                else keccak1go <= 0;
            end
        end 
    always @(posedge clk) begin
        if (state_reg == padding) begin
        if ( paddingDone ) paddingDone <= 0;
        else if ( paddingCount  == 0) begin 
            paddingState <= processInput_state_out;
            paddingCount <= 1;
        end
        else begin
            case ( chunkCount ) //maybe this needs to start at zero? that would shift 58  to 59 if it did
                1 : paddingState[1599:1592] <= state[1599:1592] ^ 8'h06;
                2 : paddingState[1591:1584] <= state[1591:1584] ^ 8'h06;
                3 : paddingState[1583:1576] <= state[1583:1576] ^ 8'h06;
                4 : paddingState[1575:1568] <= state[1575:1568] ^ 8'h06;
                5 : paddingState[1567:1560] <= state[1567:1560] ^ 8'h06;
                6 : paddingState[1559:1552] <= state[1559:1552] ^ 8'h06;
                7 : paddingState[1551:1544] <= state[1551:1544] ^ 8'h06;
                8 : paddingState[1543:1536] <= state[1543:1536] ^ 8'h06;
                9 : paddingState[1535:1528] <= state[1535:1528] ^ 8'h06;
                10 : paddingState[1527:1520] <= state[1527:1520] ^ 8'h06;
                11 : paddingState[1519:1512] <= state[1519:1512] ^ 8'h06;
                12 : paddingState[1511:1504] <= state[1511:1504] ^ 8'h06;
                13 : paddingState[1503:1496] <= state[1503:1496] ^ 8'h06;
                14 : paddingState[1495:1488] <= state[1495:1488] ^ 8'h06;
                15 : paddingState[1487:1480] <= state[1487:1480] ^ 8'h06;
                16 : paddingState[1479:1472] <= state[1479:1472] ^ 8'h06;
                17 : paddingState[1471:1464] <= state[1471:1464] ^ 8'h06;
                18 : paddingState[1463:1456] <= state[1463:1456] ^ 8'h06;
                19 : paddingState[1455:1448] <= state[1455:1448] ^ 8'h06;
                20 : paddingState[1447:1440] <= state[1447:1440] ^ 8'h06;
                21 : paddingState[1439:1432] <= state[1439:1432] ^ 8'h06;
                22 : paddingState[1431:1424] <= state[1431:1424] ^ 8'h06;
                23 : paddingState[1423:1416] <= state[1423:1416] ^ 8'h06;
                24 : paddingState[1415:1408] <= state[1415:1408] ^ 8'h06;
                25 : paddingState[1407:1400] <= state[1407:1400] ^ 8'h06;
                26 : paddingState[1399:1392] <= state[1399:1392] ^ 8'h06;
                27 : paddingState[1391:1384] <= state[1391:1384] ^ 8'h06;
                28 : paddingState[1383:1376] <= state[1383:1376] ^ 8'h06;
                29 : paddingState[1375:1368] <= state[1375:1368] ^ 8'h06;
                30 : paddingState[1367:1360] <= state[1367:1360] ^ 8'h06;
                31 : paddingState[1359:1352] <= state[1359:1352] ^ 8'h06;
                32 : paddingState[1351:1344] <= state[1351:1344] ^ 8'h06;
                33 : paddingState[1343:1336] <= state[1343:1336] ^ 8'h06;
                34 : paddingState[1335:1328] <= state[1335:1328] ^ 8'h06;
                35 : paddingState[1327:1320] <= state[1327:1320] ^ 8'h06;
                36 : paddingState[1319:1312] <= state[1319:1312] ^ 8'h06;
                37 : paddingState[1311:1304] <= state[1311:1304] ^ 8'h06;
                38 : paddingState[1303:1296] <= state[1303:1296] ^ 8'h06;
                39 : paddingState[1295:1288] <= state[1295:1288] ^ 8'h06;
                40 : paddingState[1287:1280] <= state[1287:1280] ^ 8'h06;
                41 : paddingState[1279:1272] <= state[1279:1272] ^ 8'h06;
                42 : paddingState[1271:1264] <= state[1271:1264] ^ 8'h06;
                43 : paddingState[1263:1256] <= state[1263:1256] ^ 8'h06;
                44 : paddingState[1255:1248] <= state[1255:1248] ^ 8'h06;
                45 : paddingState[1247:1240] <= state[1247:1240] ^ 8'h06;
                46 : paddingState[1239:1232] <= state[1239:1232] ^ 8'h06;
                47 : paddingState[1231:1224] <= state[1231:1224] ^ 8'h06;
                48 : paddingState[1223:1216] <= state[1223:1216] ^ 8'h06;
                49 : paddingState[1215:1208] <= state[1215:1208] ^ 8'h06;
                50 : paddingState[1207:1200] <= state[1207:1200] ^ 8'h06;
                51 : paddingState[1199:1192] <= state[1199:1192] ^ 8'h06;
                52 : paddingState[1191:1184] <= state[1191:1184] ^ 8'h06;
                53 : paddingState[1183:1176] <= state[1183:1176] ^ 8'h06;
                54 : paddingState[1175:1168] <= state[1175:1168] ^ 8'h06;
                55 : paddingState[1167:1160] <= state[1167:1160] ^ 8'h06;
                56 : paddingState[1159:1152] <= state[1159:1152] ^ 8'h06;
                57 : paddingState[1151:1144] <= state[1151:1144] ^ 8'h06;
                59 : paddingState[1143:1136] <= state[1143:1136] ^ 8'h06;//flipped this with 59
                58 : paddingState[1135:1128] <= state[1135:1128] ^ 8'h06;//Still need to figure this out
                60 : paddingState[1127:1120] <= state[1127:1120] ^ 8'h06;
                61 : paddingState[1119:1112] <= state[1119:1112] ^ 8'h06;
                62 : paddingState[1111:1104] <= state[1111:1104] ^ 8'h06;
                63 : paddingState[1103:1096] <= state[1103:1096] ^ 8'h06;
                64 : paddingState[1095:1088] <= state[1095:1088] ^ 8'h06;
                65 : paddingState[1087:1080] <= state[1087:1080] ^ 8'h06;
                66 : paddingState[1079:1072] <= state[1079:1072] ^ 8'h06;
                67 : paddingState[1071:1064] <= state[1071:1064] ^ 8'h06;
                68 : paddingState[1063:1056] <= state[1063:1056] ^ 8'h06;
                69 : paddingState[1055:1048] <= state[1055:1048] ^ 8'h06;
                70 : paddingState[1047:1040] <= state[1047:1040] ^ 8'h06;
                71 : paddingState[1039:1032] <= state[1039:1032] ^ 8'h06;
                72 : paddingState[1599:1592] <= state[1599:1592] ^ 8'h06;
                default : paddingState[7:0] <= state[7:0] ^ 8'h06;
            endcase
            paddingState[1031:1024] <= state[1031:1024] ^ 8'h80;
            paddingDone <= 1;
            paddingCount <= 0;
        end
        end
    end
    
    always @( posedge clk )   
        begin
            if ( state_reg == keccak2 ) begin
                if ( keccak2Done ) begin//definately think this is called again evem after it is done
                    //k2Done <= 1; 
                    k2Busy <= 0;
                end
                else if ( ~k2Busy ) begin
                    keccak2_state_in <= paddingState;
                    k2Busy <= 1;
                    keccak2go <= 1;
                    //k2Done <= 0;
                end
                else keccak2go <= 0;
            end
        end 
        
        always @( posedge clk )   
        begin
            if ( state_reg == outputState ) begin
                if ( outputDone ) begin//definately think this is called again evem after it is done
                    //outDone <= 1; 
                    outBusy <= 0;
                end
                else if ( ~outBusy ) begin
                    raw512 <= state[1599:1088];//this should truncate state down to the first 512 bits but need to double check
                    outBusy <= 1;
                    goConverter <= 1;
                    //outDone <= 0;
                end
                else goConverter <= 0;
            end
        end 
    //Done register
    always @( posedge clk )
        begin
            if ( reset ) 
                done <= 1'b0;
            else if ( state_reg == finish ) begin
                done <= 1'b1;
            end
            else
                done <= 1'b0;
        end
            
            
    //processInput instantiation
    processInput process(
        .clk ( clk ),
        .state_in (processInput_state_in),
        .state_out(processInput_state_out),
        .dataDone(dataDone),
        .dataIn(GPIO),
        .bufferWR(piWR),
        .chunkCount(chunkCount),
        .done(processDone),
        .piBufferEmpty(piBufferEmpty),
        .rst(rstRise),
        .go(processInput_go),
        .kill(killRise)
    );
    
    AsyncEdgeDetect edgeDetect_go(
        .async_sig ( go ),
        .clk       ( clk      ),
        .rise      ( goRise    ),
        .fall      ( goFall     )
    );
    AsyncEdgeDetect edgeDetect_rst(
        .async_sig ( reset ),
        .clk       ( clk      ),
        .rise      ( rstRise    ),
        .fall      ( rstFall     )
    );
    AsyncEdgeDetect edgeDetect_kill(
        .async_sig ( kill ),
        .clk       ( clk      ),
        .rise      ( killRise    ),
        .fall      ( killFall     )
    );
    
    AsyncEdgeDetect edgeDetect_dataDone(
        .async_sig ( dataDone ),
        .clk       ( clk      ),
        .rise      ( dataDoneRise    ),
        .fall      ( dataDoneFall     )
    );         
    
    KeccakF1600 keccakPerm1 (
        .clk(clk),
        .go(keccak1go),
        .reset(rstRise),
        .done(keccak1Done),
        .kill(killRise),
        .state(keccak1_state_in),
        .state_out(keccak1_state_out)
    );
    
    KeccakF1600 keccakPerm2 (
        .clk(clk),
        .go(keccak2go),
        .reset(rstRise),
        .done(keccak2Done),
        .kill(killRise),
        .state(keccak2_state_in),
        .state_out(keccak2_state_out)
    );
    
    converter converterOut (
        .clk1(clk),
        .GPIO17(GPIO17),
        .raw512(raw512),
        .GPIO(GPIOout),
        .reset(rstRise),
        .go(goConverter),
        .kill(killRise),
        .done(outputDone)
    );
            
endmodule
