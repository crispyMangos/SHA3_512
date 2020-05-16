`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2020 03:29:58 PM
// Design Name: 
// Module Name: KeccakF1600onLanes
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


module KeccakF1600(
    input clk,
    input go,
    input reset,
    output reg done,
    input kill,
    input [1599:0] state,
    output reg [1599:0] state_out
    );
    
    reg [5:0] round;
    reg [5:0] t_count = 0;
    reg [2:0] y_count = 0;
    reg [3:0] state_reg = 0;
    reg [63:0] A_lanes [4:0][4:0];
    reg [63:0] C_state [4:0];
    reg [63:0] D_state [4:0];
    reg [63:0] E_lanes [4:0][4:0];
    
    reg [63:0] t_lanes [4:0][4:0];
    reg t_x;
    reg t_y;
    reg [63:0] y_lanes [4:0][4:0];
    //reg [63:0] y_state_T [4:0];
    
    reg [63:0] j_lanes [4:0][4:0];
    
    parameter [0:1535] RC = {
        64'h0000000000000001,
        64'h0000000000008082,
        64'h800000000000808a, 
        64'h8000000080008000, 
        64'h000000000000808b, 
        64'h0000000080000001, 
        64'h8000000080008081, 
        64'h8000000000008009, 
        64'h000000000000008A, 
        64'h0000000000000088,
        64'h0000000080008009,
        64'h000000008000000A,
        64'h000000008000808B,
        64'h800000000000008B,
        64'h8000000000008089,
        64'h8000000000008003,
        64'h8000000000008002,
        64'h8000000000000080,
        64'h000000000000800A,
        64'h800000008000000A,
        64'h8000000080008081,
        64'h8000000000008080,
        64'h0000000080000001,
        64'h8000000080008008
        };  
    //parameters are local to each individual state machine
    parameter idle = 4'b0000;//0
    parameter A  = 4'b0001;//1
    parameter C  = 4'b0010;//2
    parameter D  = 4'b0011;//3
    parameter E  = 4'b0100;//4
    parameter t  = 4'b0101;//5
    parameter y  = 4'b0110;//6
    parameter j  = 4'b0111;//7
    parameter finish = 4'b1000;//8
    parameter abort = 4'b1001;//9
    
    //------------Desgin implementation------------

    //State Machine
    always @( posedge clk )
        begin
            if ( reset )
                state_reg <= idle;
            else
                case ( state_reg )
                    idle :
                        if ( go ) state_reg <= A;
                        
                    A :
                        if ( kill ) state_reg <= abort;
                        else state_reg <= C;
                        
                    C :
                        if ( kill ) state_reg <= abort;
                        else state_reg <= D;
                    
                    D :
                        if ( kill ) state_reg <= abort;
                        else state_reg <= E;
                    
                    E :
                        if ( kill ) state_reg <= abort;
                        else state_reg <= t;
                        
                    t :
                        if ( kill ) state_reg <= abort;
                        else state_reg <= y;//think i want 23
                        
                    y :
                        if ( kill ) state_reg <= abort;
                        else state_reg <= j;
                        
                    j : 
                        if ( kill ) state_reg <= abort;
                        else begin
                            if ( round == 5'd23 ) state_reg <= finish;//think i want 23
                            else state_reg <= C;
                        end
                    
                    finish : state_reg <= idle;
                    
                    abort : 
                        if( !kill ) state_reg <= idle;
                    default : state_reg <= idle;
                endcase
        end
    
    //State A
    always @( posedge clk )   
        begin
            if ( state_reg == A )
                //column 0
                A_lanes[0][0] <= {state[1543:1536], state[1551:1544], state[1559:1552], state[1567:1560], state[1575:1568], state[1583:1576], state[1591:1584], state[1599:1592]};
                A_lanes[1][0] <= {state[1479:1472], state[1487:1480], state[1495:1488], state[1503:1496], state[1511:1504], state[1519:1512], state[1527:1520], state[1535:1528]};
                A_lanes[2][0] <= {state[1415:1408], state[1423:1416], state[1431:1424], state[1439:1432], state[1447:1440], state[1455:1448], state[1463:1456], state[1471:1464]};
                A_lanes[3][0] <= {state[1351:1344], state[1359:1352], state[1367:1360], state[1375:1368], state[1383:1376], state[1391:1384], state[1399:1392], state[1407:1400]};
                A_lanes[4][0] <= {state[1287:1280], state[1295:1288], state[1303:1296], state[1311:1304], state[1319:1312], state[1327:1320], state[1335:1328], state[1343:1336]};
                A_lanes[0][1] <= {state[1223:1216], state[1231:1224], state[1239:1232], state[1247:1240], state[1255:1248], state[1263:1256], state[1271:1264], state[1279:1272]};
                A_lanes[1][1] <= {state[1159:1152], state[1167:1160], state[1175:1168], state[1183:1176], state[1191:1184], state[1199:1192], state[1207:1200], state[1215:1208]};
                A_lanes[2][1] <= {state[1095:1088], state[1103:1096], state[1111:1104], state[1119:1112], state[1127:1120], state[1135:1128], state[1143:1136], state[1151:1144]};
                A_lanes[3][1] <= {state[1031:1024], state[1039:1032], state[1047:1040], state[1055:1048], state[1063:1056], state[1071:1064], state[1079:1072], state[1087:1080]};
                A_lanes[4][1] <= {state[967:960], state[975:968], state[983:976], state[991:984], state[999:992], state[1007:1000], state[1015:1008], state[1023:1016]};
                A_lanes[0][2] <= {state[903:896], state[911:904], state[919:912], state[927:920], state[935:928], state[943:936], state[951:944], state[959:952]};
                A_lanes[1][2] <= {state[839:832], state[847:840], state[855:848], state[863:856], state[871:864], state[879:872], state[887:880], state[895:888]};
                A_lanes[2][2] <= {state[775:768], state[783:776], state[791:784], state[799:792], state[807:800], state[815:808], state[823:816], state[831:824]};
                A_lanes[3][2] <= {state[711:704], state[719:712], state[727:720], state[735:728], state[743:736], state[751:744], state[759:752], state[767:760]};
                A_lanes[4][2] <= {state[647:640], state[655:648], state[663:656], state[671:664], state[679:672], state[687:680], state[695:688], state[703:696]};
                A_lanes[0][3] <= {state[583:576], state[591:584], state[599:592], state[607:600], state[615:608], state[623:616], state[631:624], state[639:632]};
                A_lanes[1][3] <= {state[519:512], state[527:520], state[535:528], state[543:536], state[551:544], state[559:552], state[567:560], state[575:568]};
                A_lanes[2][3] <= {state[455:448], state[463:456], state[471:464], state[479:472], state[487:480], state[495:488], state[503:496], state[511:504]};
                A_lanes[3][3] <= {state[391:384], state[399:392], state[407:400], state[415:408], state[423:416], state[431:424], state[439:432], state[447:440]};
                A_lanes[4][3] <= {state[327:320], state[335:328], state[343:336], state[351:344], state[359:352], state[367:360], state[375:368], state[383:376]};
                A_lanes[0][4] <= {state[263:256], state[271:264], state[279:272], state[287:280], state[295:288], state[303:296], state[311:304], state[319:312]};
                A_lanes[1][4] <= {state[199:192], state[207:200], state[215:208], state[223:216], state[231:224], state[239:232], state[247:240], state[255:248]};
                A_lanes[2][4] <= {state[135:128], state[143:136], state[151:144], state[159:152], state[167:160], state[175:168], state[183:176], state[191:184]};
                A_lanes[3][4] <= {state[71:64], state[79:72], state[87:80], state[95:88], state[103:96], state[111:104], state[119:112], state[127:120]};
                A_lanes[4][4] <= {state[7:0], state[15:8], state[23:16], state[31:24], state[39:32], state[47:40], state[55:48], state[63:56]};
        end
    //state C
    always @( posedge clk )   
        begin
            if ( state_reg == C ) begin
                if ( round == 0 ) begin//pull lanes from A_lanes
                    C_state[0] <= A_lanes[0][0] ^ A_lanes[0][1] ^ A_lanes[0][2] ^ A_lanes[0][3] ^ A_lanes[0][4];
                    C_state[1] <= A_lanes[1][0] ^ A_lanes[1][1] ^ A_lanes[1][2] ^ A_lanes[1][3] ^ A_lanes[1][4];
                    C_state[2] <= A_lanes[2][0] ^ A_lanes[2][1] ^ A_lanes[2][2] ^ A_lanes[2][3] ^ A_lanes[2][4];
                    C_state[3] <= A_lanes[3][0] ^ A_lanes[3][1] ^ A_lanes[3][2] ^ A_lanes[3][3] ^ A_lanes[3][4];
                    C_state[4] <= A_lanes[4][0] ^ A_lanes[4][1] ^ A_lanes[4][2] ^ A_lanes[4][3] ^ A_lanes[4][4];
                end
                else begin//pull lanes from j_lanes
                    C_state[0] <= j_lanes[0][0] ^ j_lanes[0][1] ^ j_lanes[0][2] ^ j_lanes[0][3] ^ j_lanes[0][4];
                    C_state[1] <= j_lanes[1][0] ^ j_lanes[1][1] ^ j_lanes[1][2] ^ j_lanes[1][3] ^ j_lanes[1][4];
                    C_state[2] <= j_lanes[2][0] ^ j_lanes[2][1] ^ j_lanes[2][2] ^ j_lanes[2][3] ^ j_lanes[2][4];
                    C_state[3] <= j_lanes[3][0] ^ j_lanes[3][1] ^ j_lanes[3][2] ^ j_lanes[3][3] ^ j_lanes[3][4];
                    C_state[4] <= j_lanes[4][0] ^ j_lanes[4][1] ^ j_lanes[4][2] ^ j_lanes[4][3] ^ j_lanes[4][4];
                end
            end
        end
    
    //state D
    always @( posedge clk )   
        begin
            if ( state_reg == D ) begin
                D_state[0] <= C_state[4] ^ ( (C_state[1] >> 63) + (C_state[1] << 1) );//the rotation thing might be the other way
                D_state[1] <= C_state[0] ^ ( (C_state[2] >> 63) + (C_state[2] << 1) );
                D_state[2] <= C_state[1] ^ ( (C_state[3] >> 63) + (C_state[3] << 1) );
                D_state[3] <= C_state[2] ^ ( (C_state[4] >> 63) + (C_state[4] << 1) );
                D_state[4] <= C_state[3] ^ ( (C_state[0] >> 63) + (C_state[0] << 1) );
            end
        end
    
    //state E
    always @( posedge clk )   
        begin
            if ( state_reg == E ) begin
                if ( round == 0 ) begin//pull lanes from A_lanes
                    //row 0
                    E_lanes[0][0] <= D_state[0] ^ A_lanes[0][0];
                    E_lanes[0][1] <= D_state[0] ^ A_lanes[0][1];
                    E_lanes[0][2] <= D_state[0] ^ A_lanes[0][2];
                    E_lanes[0][3] <= D_state[0] ^ A_lanes[0][3];
                    E_lanes[0][4] <= D_state[0] ^ A_lanes[0][4];
                        
                    //row 1
                    E_lanes[1][0] <= D_state[1] ^ A_lanes[1][0];
                    E_lanes[1][1] <= D_state[1] ^ A_lanes[1][1];
                    E_lanes[1][2] <= D_state[1] ^ A_lanes[1][2];
                    E_lanes[1][3] <= D_state[1] ^ A_lanes[1][3];
                    E_lanes[1][4] <= D_state[1] ^ A_lanes[1][4];
                        
                    //row 2
                    E_lanes[2][0] <= D_state[2] ^ A_lanes[2][0];
                    E_lanes[2][1] <= D_state[2] ^ A_lanes[2][1];
                    E_lanes[2][2] <= D_state[2] ^ A_lanes[2][2];
                    E_lanes[2][3] <= D_state[2] ^ A_lanes[2][3];
                    E_lanes[2][4] <= D_state[2] ^ A_lanes[2][4];
                        
                    //row 3
                    E_lanes[3][0] <= D_state[3] ^ A_lanes[3][0];
                    E_lanes[3][1] <= D_state[3] ^ A_lanes[3][1];
                    E_lanes[3][2] <= D_state[3] ^ A_lanes[3][2];
                    E_lanes[3][3] <= D_state[3] ^ A_lanes[3][3];
                    E_lanes[3][4] <= D_state[3] ^ A_lanes[3][4];
                        
                    //row 4
                    E_lanes[4][0] <= D_state[4] ^ A_lanes[4][0];
                    E_lanes[4][1] <= D_state[4] ^ A_lanes[4][1];
                    E_lanes[4][2] <= D_state[4] ^ A_lanes[4][2];
                    E_lanes[4][3] <= D_state[4] ^ A_lanes[4][3];
                    E_lanes[4][4] <= D_state[4] ^ A_lanes[4][4];
                end
                else begin//pull lanes from j_lanes
                    //row 0
                    E_lanes[0][0] <= D_state[0] ^ j_lanes[0][0];
                    E_lanes[0][1] <= D_state[0] ^ j_lanes[0][1];
                    E_lanes[0][2] <= D_state[0] ^ j_lanes[0][2];
                    E_lanes[0][3] <= D_state[0] ^ j_lanes[0][3];
                    E_lanes[0][4] <= D_state[0] ^ j_lanes[0][4];
                        
                    //row 1
                    E_lanes[1][0] <= D_state[1] ^ j_lanes[1][0];
                    E_lanes[1][1] <= D_state[1] ^ j_lanes[1][1];
                    E_lanes[1][2] <= D_state[1] ^ j_lanes[1][2];
                    E_lanes[1][3] <= D_state[1] ^ j_lanes[1][3];
                    E_lanes[1][4] <= D_state[1] ^ j_lanes[1][4];
                        
                    //row 2
                    E_lanes[2][0] <= D_state[2] ^ j_lanes[2][0];
                    E_lanes[2][1] <= D_state[2] ^ j_lanes[2][1];
                    E_lanes[2][2] <= D_state[2] ^ j_lanes[2][2];
                    E_lanes[2][3] <= D_state[2] ^ j_lanes[2][3];
                    E_lanes[2][4] <= D_state[2] ^ j_lanes[2][4];
                        
                    //row 3
                    E_lanes[3][0] <= D_state[3] ^ j_lanes[3][0];
                    E_lanes[3][1] <= D_state[3] ^ j_lanes[3][1];
                    E_lanes[3][2] <= D_state[3] ^ j_lanes[3][2];
                    E_lanes[3][3] <= D_state[3] ^ j_lanes[3][3];
                    E_lanes[3][4] <= D_state[3] ^ j_lanes[3][4];
                        
                    //row 4
                    E_lanes[4][0] <= D_state[4] ^ j_lanes[4][0];
                    E_lanes[4][1] <= D_state[4] ^ j_lanes[4][1];
                    E_lanes[4][2] <= D_state[4] ^ j_lanes[4][2];
                    E_lanes[4][3] <= D_state[4] ^ j_lanes[4][3];
                    E_lanes[4][4] <= D_state[4] ^ j_lanes[4][4];
                end
            end
        end

    //state t
    always @( posedge clk )   
        begin
            if ( reset )
                t_count <= 5'd0;
            else if ( state_reg == finish || state_reg == abort || state_reg == y)
                t_count <= 5'd0;
            else
            //need to make sure all things of state E are copied to t
            if ( state_reg == t ) begin
                    t_lanes[0][2] <= ( E_lanes[1][0] >> 63 ) + ( E_lanes[1][0] << 1 );
                    t_lanes[2][1] <= ( E_lanes[0][2] >> 61 ) + ( E_lanes[0][2] << 3 );
                    t_lanes[1][2] <= ( E_lanes[2][1] >> 58 ) + ( E_lanes[2][1] << 6 );
                    t_lanes[2][3] <= ( E_lanes[1][2] >> 54 ) + ( E_lanes[1][2] << 10 );
                    t_lanes[3][3] <= ( E_lanes[2][3] >> 49 ) + ( E_lanes[2][3] << 15 );
                    t_lanes[3][0] <= ( E_lanes[3][3] >> 43 ) + ( E_lanes[3][3] << 21 );
                    t_lanes[0][1] <= ( E_lanes[3][0] >> 36 ) + ( E_lanes[3][0] << 28 );
                    t_lanes[1][3] <= ( E_lanes[0][1] >> 28 ) + ( E_lanes[0][1] << 36 );
                    t_lanes[3][1] <= ( E_lanes[1][3] >> 19 ) + ( E_lanes[1][3] << 45 );
                    t_lanes[1][4] <= ( E_lanes[3][1] >> 9 ) + ( E_lanes[3][1] << 55 );
                    t_lanes[4][4] <= ( E_lanes[1][4] >> 62 ) + ( E_lanes[1][4] << 2 );
                    t_lanes[4][0] <= ( E_lanes[4][4] >> 50 ) + ( E_lanes[4][4] << 14 );
                    t_lanes[0][3] <= ( E_lanes[4][0] >> 37 ) + ( E_lanes[4][0] << 27 );
                    t_lanes[3][4] <= ( E_lanes[0][3] >> 23 ) + ( E_lanes[0][3] << 41 );
                    t_lanes[4][3] <= ( E_lanes[3][4] >> 8 ) + ( E_lanes[3][4] << 56 );
                    t_lanes[3][2] <= ( E_lanes[4][3] >> 56 ) + ( E_lanes[4][3] << 8 );
                    t_lanes[2][2] <= ( E_lanes[3][2] >> 39 ) + ( E_lanes[3][2] << 25 );
                    t_lanes[2][0] <= ( E_lanes[2][2] >> 21 ) + ( E_lanes[2][2] << 43 );
                    t_lanes[0][4] <= ( E_lanes[2][0] >> 2 ) + ( E_lanes[2][0] << 62 );
                    t_lanes[4][2] <= ( E_lanes[0][4] >> 46 ) + ( E_lanes[0][4] << 18 );
                    t_lanes[2][4] <= ( E_lanes[4][2] >> 25 ) + ( E_lanes[4][2] << 39 );
                    t_lanes[4][1] <= ( E_lanes[2][4] >> 3 ) + ( E_lanes[2][4] << 61 );
                    t_lanes[1][1] <= ( E_lanes[4][1] >> 44 ) + ( E_lanes[4][1] << 20 );
                    t_lanes[1][0] <= ( E_lanes[1][1] >> 20 ) + ( E_lanes[1][1] << 44 );
                    t_lanes[0][0] <= E_lanes[0][0];
            end
            
        end

    //state y
    always @( posedge clk )   
        begin
            if ( reset )
                y_count <= 5'd0;
            else if ( state_reg == finish || state_reg == abort || state_reg == j )
                y_count <= 5'd0;
            else if ( state_reg == y ) begin
 
                    y_lanes[0][0] <= t_lanes[0][0] ^ ( (~t_lanes[1][0]) & t_lanes[2][0] );
                    y_lanes[0][1] <= t_lanes[0][1] ^ ( (~t_lanes[1][1]) & t_lanes[2][1] );
                    y_lanes[0][2] <= t_lanes[0][2] ^ ( (~t_lanes[1][2]) & t_lanes[2][2] );
                    y_lanes[0][3] <= t_lanes[0][3] ^ ( (~t_lanes[1][3]) & t_lanes[2][3] );
                    y_lanes[0][4] <= t_lanes[0][4] ^ ( (~t_lanes[1][4]) & t_lanes[2][4] );   

                    y_lanes[1][0] <= t_lanes[1][0] ^ ( (~t_lanes[2][0]) & t_lanes[3][0] );
                    y_lanes[1][1] <= t_lanes[1][1] ^ ( (~t_lanes[2][1]) & t_lanes[3][1] );
                    y_lanes[1][2] <= t_lanes[1][2] ^ ( (~t_lanes[2][2]) & t_lanes[3][2] );
                    y_lanes[1][3] <= t_lanes[1][3] ^ ( (~t_lanes[2][3]) & t_lanes[3][3] );
                    y_lanes[1][4] <= t_lanes[1][4] ^ ( (~t_lanes[2][4]) & t_lanes[3][4] );

                    y_lanes[2][0] <= t_lanes[2][0] ^ ( (~t_lanes[3][0]) & t_lanes[4][0] );
                    y_lanes[2][1] <= t_lanes[2][1] ^ ( (~t_lanes[3][1]) & t_lanes[4][1] );
                    y_lanes[2][2] <= t_lanes[2][2] ^ ( (~t_lanes[3][2]) & t_lanes[4][2] );
                    y_lanes[2][3] <= t_lanes[2][3] ^ ( (~t_lanes[3][3]) & t_lanes[4][3] );
                    y_lanes[2][4] <= t_lanes[2][4] ^ ( (~t_lanes[3][4]) & t_lanes[4][4] );

                    y_lanes[3][0] <= t_lanes[3][0] ^ ( (~t_lanes[4][0]) & t_lanes[0][0] );
                    y_lanes[3][1] <= t_lanes[3][1] ^ ( (~t_lanes[4][1]) & t_lanes[0][1] );
                    y_lanes[3][2] <= t_lanes[3][2] ^ ( (~t_lanes[4][2]) & t_lanes[0][2] );
                    y_lanes[3][3] <= t_lanes[3][3] ^ ( (~t_lanes[4][3]) & t_lanes[0][3] );
                    y_lanes[3][4] <= t_lanes[3][4] ^ ( (~t_lanes[4][4]) & t_lanes[0][4] );

                    y_lanes[4][0] <= t_lanes[4][0] ^ ( (~t_lanes[0][0]) & t_lanes[1][0] );
                    y_lanes[4][1] <= t_lanes[4][1] ^ ( (~t_lanes[0][1]) & t_lanes[1][1] );
                    y_lanes[4][2] <= t_lanes[4][2] ^ ( (~t_lanes[0][2]) & t_lanes[1][2] );
                    y_lanes[4][3] <= t_lanes[4][3] ^ ( (~t_lanes[0][3]) & t_lanes[1][3] );
                    y_lanes[4][4] <= t_lanes[4][4] ^ ( (~t_lanes[0][4]) & t_lanes[1][4] );
            
            end
        end

    //state j controls the round
    always @( posedge clk )   
        begin
            if ( reset )
                round <= 5'd0;
            else if ( state_reg == finish || state_reg == abort )
                round <= 5'd0;
            else if (state_reg == idle ) round <= 0;
            else if ( state_reg == j ) begin
                case ( round )
                    0 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[0:63];
                    1 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[64:127];
                    2 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[128:191];
                    3 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[192:255];
                    4 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[256:319];
                    5 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[320:383];
                    6 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[384:447];
                    7 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[448:511];
                    8 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[512:575];
                    9 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[576:639];
                    10 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[640:703];
                    11 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[704:767];
                    12 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[768:831];
                    13 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[832:895];
                    14 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[896:959];
                    15 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[960:1023];
                    16 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1024:1087];
                    17 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1088:1151];
                    18 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1152:1215];
                    19 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1216:1279];
                    20 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1280:1343];
                    21 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1344:1407];
                    22 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1408:1471];
                    23 : j_lanes[0][0] <= y_lanes[0][0] ^ RC[1472:1535];
                    default j_lanes[0][0] <= y_lanes[0][0];
                endcase
                //j_lanes[0][0] <= y_lanes[0][0];
                j_lanes[0][1] <= y_lanes[0][1];
                j_lanes[0][2] <= y_lanes[0][2];
                j_lanes[0][3] <= y_lanes[0][3];
                j_lanes[0][4] <= y_lanes[0][4];
                j_lanes[1][0] <= y_lanes[1][0];
                j_lanes[1][1] <= y_lanes[1][1];
                j_lanes[1][2] <= y_lanes[1][2];
                j_lanes[1][3] <= y_lanes[1][3];
                j_lanes[1][4] <= y_lanes[1][4];
                j_lanes[2][0] <= y_lanes[2][0];
                j_lanes[2][1] <= y_lanes[2][1];
                j_lanes[2][2] <= y_lanes[2][2];
                j_lanes[2][3] <= y_lanes[2][3];
                j_lanes[2][4] <= y_lanes[2][4];
                j_lanes[3][0] <= y_lanes[3][0];
                j_lanes[3][1] <= y_lanes[3][1];
                j_lanes[3][2] <= y_lanes[3][2];
                j_lanes[3][3] <= y_lanes[3][3];
                j_lanes[3][4] <= y_lanes[3][4];
                j_lanes[4][0] <= y_lanes[4][0];
                j_lanes[4][1] <= y_lanes[4][1];
                j_lanes[4][2] <= y_lanes[4][2];
                j_lanes[4][3] <= y_lanes[4][3];
                j_lanes[4][4] <= y_lanes[4][4];
                round <= round + 1;
            
            end
        end
    //Done register
    always @( posedge clk )
        begin
            if ( reset ) 
                done <= 1'b0;
            else if ( state_reg == finish ) begin
                done <= 1'b1;
                state_out[1599:1536] <= {j_lanes[0][0][7:0], j_lanes[0][0][15:8], j_lanes[0][0][23:16], j_lanes[0][0][31:24], j_lanes[0][0][39:32], j_lanes[0][0][47:40], j_lanes[0][0][55:48], j_lanes[0][0][63:56]};
                state_out[1535:1472] <= {j_lanes[1][0][7:0], j_lanes[1][0][15:8], j_lanes[1][0][23:16], j_lanes[1][0][31:24], j_lanes[1][0][39:32], j_lanes[1][0][47:40], j_lanes[1][0][55:48], j_lanes[1][0][63:56]};
                state_out[1471:1408] <= {j_lanes[2][0][7:0], j_lanes[2][0][15:8], j_lanes[2][0][23:16], j_lanes[2][0][31:24], j_lanes[2][0][39:32], j_lanes[2][0][47:40], j_lanes[2][0][55:48], j_lanes[2][0][63:56]};
                state_out[1407:1344] <= {j_lanes[3][0][7:0], j_lanes[3][0][15:8], j_lanes[3][0][23:16], j_lanes[3][0][31:24], j_lanes[3][0][39:32], j_lanes[3][0][47:40], j_lanes[3][0][55:48], j_lanes[3][0][63:56]};
                state_out[1343:1280] <= {j_lanes[4][0][7:0], j_lanes[4][0][15:8], j_lanes[4][0][23:16], j_lanes[4][0][31:24], j_lanes[4][0][39:32], j_lanes[4][0][47:40], j_lanes[4][0][55:48], j_lanes[4][0][63:56]};
                state_out[1279:1216] <= {j_lanes[0][1][7:0], j_lanes[0][1][15:8], j_lanes[0][1][23:16], j_lanes[0][1][31:24], j_lanes[0][1][39:32], j_lanes[0][1][47:40], j_lanes[0][1][55:48], j_lanes[0][1][63:56]};
                state_out[1215:1152] <= {j_lanes[1][1][7:0], j_lanes[1][1][15:8], j_lanes[1][1][23:16], j_lanes[1][1][31:24], j_lanes[1][1][39:32], j_lanes[1][1][47:40], j_lanes[1][1][55:48], j_lanes[1][1][63:56]};
                state_out[1151:1088] <= {j_lanes[2][1][7:0], j_lanes[2][1][15:8], j_lanes[2][1][23:16], j_lanes[2][1][31:24], j_lanes[2][1][39:32], j_lanes[2][1][47:40], j_lanes[2][1][55:48], j_lanes[2][1][63:56]};
                state_out[1087:1024] <= {j_lanes[3][1][7:0], j_lanes[3][1][15:8], j_lanes[3][1][23:16], j_lanes[3][1][31:24], j_lanes[3][1][39:32], j_lanes[3][1][47:40], j_lanes[3][1][55:48], j_lanes[3][1][63:56]};
                state_out[1023:960] <= {j_lanes[4][1][7:0], j_lanes[4][1][15:8], j_lanes[4][1][23:16], j_lanes[4][1][31:24], j_lanes[4][1][39:32], j_lanes[4][1][47:40], j_lanes[4][1][55:48], j_lanes[4][1][63:56]};
                state_out[959:896] <= {j_lanes[0][2][7:0], j_lanes[0][2][15:8], j_lanes[0][2][23:16], j_lanes[0][2][31:24], j_lanes[0][2][39:32], j_lanes[0][2][47:40], j_lanes[0][2][55:48], j_lanes[0][2][63:56]};
                state_out[895:832] <= {j_lanes[1][2][7:0], j_lanes[1][2][15:8], j_lanes[1][2][23:16], j_lanes[1][2][31:24], j_lanes[1][2][39:32], j_lanes[1][2][47:40], j_lanes[1][2][55:48], j_lanes[1][2][63:56]};
                state_out[831:768] <= {j_lanes[2][2][7:0], j_lanes[2][2][15:8], j_lanes[2][2][23:16], j_lanes[2][2][31:24], j_lanes[2][2][39:32], j_lanes[2][2][47:40], j_lanes[2][2][55:48], j_lanes[2][2][63:56]};
                state_out[767:704] <= {j_lanes[3][2][7:0], j_lanes[3][2][15:8], j_lanes[3][2][23:16], j_lanes[3][2][31:24], j_lanes[3][2][39:32], j_lanes[3][2][47:40], j_lanes[3][2][55:48], j_lanes[3][2][63:56]};
                state_out[703:640] <= {j_lanes[4][2][7:0], j_lanes[4][2][15:8], j_lanes[4][2][23:16], j_lanes[4][2][31:24], j_lanes[4][2][39:32], j_lanes[4][2][47:40], j_lanes[4][2][55:48], j_lanes[4][2][63:56]};
                state_out[639:576] <= {j_lanes[0][3][7:0], j_lanes[0][3][15:8], j_lanes[0][3][23:16], j_lanes[0][3][31:24], j_lanes[0][3][39:32], j_lanes[0][3][47:40], j_lanes[0][3][55:48], j_lanes[0][3][63:56]};
                state_out[575:512] <= {j_lanes[1][3][7:0], j_lanes[1][3][15:8], j_lanes[1][3][23:16], j_lanes[1][3][31:24], j_lanes[1][3][39:32], j_lanes[1][3][47:40], j_lanes[1][3][55:48], j_lanes[1][3][63:56]};
                state_out[511:448] <= {j_lanes[2][3][7:0], j_lanes[2][3][15:8], j_lanes[2][3][23:16], j_lanes[2][3][31:24], j_lanes[2][3][39:32], j_lanes[2][3][47:40], j_lanes[2][3][55:48], j_lanes[2][3][63:56]};
                state_out[447:384] <= {j_lanes[3][3][7:0], j_lanes[3][3][15:8], j_lanes[3][3][23:16], j_lanes[3][3][31:24], j_lanes[3][3][39:32], j_lanes[3][3][47:40], j_lanes[3][3][55:48], j_lanes[3][3][63:56]};
                state_out[383:320] <= {j_lanes[4][3][7:0], j_lanes[4][3][15:8], j_lanes[4][3][23:16], j_lanes[4][3][31:24], j_lanes[4][3][39:32], j_lanes[4][3][47:40], j_lanes[4][3][55:48], j_lanes[4][3][63:56]};
                state_out[319:256] <= {j_lanes[0][4][7:0], j_lanes[0][4][15:8], j_lanes[0][4][23:16], j_lanes[0][4][31:24], j_lanes[0][4][39:32], j_lanes[0][4][47:40], j_lanes[0][4][55:48], j_lanes[0][4][63:56]};
                state_out[255:192] <= {j_lanes[1][4][7:0], j_lanes[1][4][15:8], j_lanes[1][4][23:16], j_lanes[1][4][31:24], j_lanes[1][4][39:32], j_lanes[1][4][47:40], j_lanes[1][4][55:48], j_lanes[1][4][63:56]};
                state_out[191:128] <= {j_lanes[2][4][7:0], j_lanes[2][4][15:8], j_lanes[2][4][23:16], j_lanes[2][4][31:24], j_lanes[2][4][39:32], j_lanes[2][4][47:40], j_lanes[2][4][55:48], j_lanes[2][4][63:56]};
                state_out[127:64] <= {j_lanes[3][4][7:0], j_lanes[3][4][15:8], j_lanes[3][4][23:16], j_lanes[3][4][31:24], j_lanes[3][4][39:32], j_lanes[3][4][47:40], j_lanes[3][4][55:48], j_lanes[3][4][63:56]};
                state_out[63:0] <= {j_lanes[4][4][7:0], j_lanes[4][4][15:8], j_lanes[4][4][23:16], j_lanes[4][4][31:24], j_lanes[4][4][39:32], j_lanes[4][4][47:40], j_lanes[4][4][55:48], j_lanes[4][4][63:56]};
            end
            else
                done <= 1'b0;
        end
endmodule
