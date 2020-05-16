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


module absorbInput(
    input clk,
    input reset,
    input go,
    input kill,
    input dataDone,
    input [7:0] dataIn,
    input [1599:0] state_in,
    input EMPTY,
    output reg [1599:0] state_out,
    output reg done,
    output reg RD,
    output reg [6:0] count
    );
    reg [6:0] chunkCount;
    reg [2:0] state_reg;
    reg [1599:0] tmp = 0;
    //parameters are local to each individual state machine
    parameter idle = 3'b000;
    parameter captureData = 3'b001;
    parameter XORstate = 3'b010;
    parameter finish = 3'b011;
    parameter abort = 3'b100;
    
    //------------Desgin implementation------------
    
    //State Machine
    always @( posedge clk )
        begin
            if ( reset )
                state_reg <= idle;
            else
                case ( state_reg )
                    idle :
                        if ( go ) state_reg <= captureData;
                        
                    captureData :
                        if ( kill ) state_reg <= abort;
                        else if ( chunkCount == 7'd73  || (dataDone && EMPTY)) state_reg <= finish;//I think dataDone && EMPTY need to reset chunkCount currently they dont do that
                    
                    finish : state_reg <= idle;
                    
                    abort : 
                        if( !kill ) state_reg <= idle;
                    default : state_reg <= idle;
                endcase
        end
    
    //captureData
    always @( posedge clk )   
        begin
            if ( reset )
                chunkCount <= 7'h00;
            else if ( state_reg == abort || state_reg == idle || state_reg == finish)//added the finish check this should now reset chunkCount when finished and still allow it to copy its value to count
                chunkCount <= 7'h00;//dont reset chunkCount until idle
            else if ( state_reg == captureData ) begin
                if ( EMPTY ) RD <= 0;
                if (~EMPTY) begin
                    if ( chunkCount == 0  || chunkCount == 1) begin 
                        tmp <= 0;
                        RD <= 1;//may take another clock for data to show up on output of buffer
                    end
                    else begin
                        RD <= 1;
                        case ( chunkCount )
                            2 : tmp[1599:1592] <= dataIn;
                            3 : tmp[1591:1584] <= dataIn;
                            4 : tmp[1583:1576] <= dataIn;
                            5 : tmp[1575:1568] <= dataIn;
                            6 : tmp[1567:1560] <= dataIn;
                            7 : tmp[1559:1552] <= dataIn;
                            8 : tmp[1551:1544] <= dataIn;
                            9 : tmp[1543:1536] <= dataIn;
                            10 : tmp[1535:1528] <= dataIn;
                            11 : tmp[1527:1520] <= dataIn;
                            12 : tmp[1519:1512] <= dataIn;
                            13 : tmp[1511:1504] <= dataIn;
                            14 : tmp[1503:1496] <= dataIn;
                            15 : tmp[1495:1488] <= dataIn;
                            16 : tmp[1487:1480] <= dataIn;
                            17 : tmp[1479:1472] <= dataIn;
                            18 : tmp[1471:1464] <= dataIn;
                            19 : tmp[1463:1456] <= dataIn;
                            20 : tmp[1455:1448] <= dataIn;
                            21 : tmp[1447:1440] <= dataIn;
                            22 : tmp[1439:1432] <= dataIn;
                            23 : tmp[1431:1424] <= dataIn;
                            24 : tmp[1423:1416] <= dataIn;
                            25 : tmp[1415:1408] <= dataIn;
                            26 : tmp[1407:1400] <= dataIn;
                            27 : tmp[1399:1392] <= dataIn;
                            28 : tmp[1391:1384] <= dataIn;
                            29 : tmp[1383:1376] <= dataIn;
                            30 : tmp[1375:1368] <= dataIn;
                            31 : tmp[1367:1360] <= dataIn;
                            32 : tmp[1359:1352] <= dataIn;
                            33 : tmp[1351:1344] <= dataIn;
                            34 : tmp[1343:1336] <= dataIn;
                            35 : tmp[1335:1328] <= dataIn;
                            36 : tmp[1327:1320] <= dataIn;
                            37 : tmp[1319:1312] <= dataIn;
                            38 : tmp[1311:1304] <= dataIn;
                            39 : tmp[1303:1296] <= dataIn;
                            40 : tmp[1295:1288] <= dataIn;
                            41 : tmp[1287:1280] <= dataIn;
                            42 : tmp[1279:1272] <= dataIn;
                            43 : tmp[1271:1264] <= dataIn;
                            44 : tmp[1263:1256] <= dataIn;
                            45 : tmp[1255:1248] <= dataIn;
                            46 : tmp[1247:1240] <= dataIn;
                            47 : tmp[1239:1232] <= dataIn;
                            48 : tmp[1231:1224] <= dataIn;
                            49 : tmp[1223:1216] <= dataIn;
                            50 : tmp[1215:1208] <= dataIn;
                            51 : tmp[1207:1200] <= dataIn;
                            52 : tmp[1199:1192] <= dataIn;
                            53 : tmp[1191:1184] <= dataIn;
                            54 : tmp[1183:1176] <= dataIn;
                            55 : tmp[1175:1168] <= dataIn;
                            56 : tmp[1167:1160] <= dataIn;
                            57 : tmp[1159:1152] <= dataIn;
                            58 : tmp[1151:1144] <= dataIn;
                            59 : tmp[1143:1136] <= dataIn;
                            60 : tmp[1135:1128] <= dataIn;
                            61 : tmp[1127:1120] <= dataIn;
                            62 : tmp[1119:1112] <= dataIn;
                            63 : tmp[1111:1104] <= dataIn;
                            64 : tmp[1103:1096] <= dataIn;
                            65 : tmp[1095:1088] <= dataIn;
                            66 : tmp[1087:1080] <= dataIn;
                            67 : tmp[1079:1072] <= dataIn;
                            68 : tmp[1071:1064] <= dataIn;
                            69 : tmp[1063:1056] <= dataIn;
                            70 : tmp[1055:1048] <= dataIn;
                            71 : tmp[1047:1040] <= dataIn;
                            72 : tmp[1039:1032] <= dataIn;
                            73 : tmp[1031:1024] <= dataIn;
                            default : tmp[7:0] <= dataIn;
                        endcase
                    end
                    chunkCount <= chunkCount + 1;
                    if (chunkCount == 73 || (dataDone && EMPTY)) RD <= 0;
                    end
                    end
        end
        
    //Done register
    always @( posedge clk )
        begin
            if ( reset ) 
                done <= 1'b0;
            else if ( state_reg == finish ) begin
                done <= 1'b1;
                state_out <= state_in ^ tmp;
                if ( chunkCount == 0 )count <= 0;
                else count <= chunkCount - 2; 
            end
            else
                done <= 1'b0;
                //count <= 0;
        end
            
endmodule
