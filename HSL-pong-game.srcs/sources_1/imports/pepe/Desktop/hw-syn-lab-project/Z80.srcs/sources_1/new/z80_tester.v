`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 11:07:32 AM
// Design Name: 
// Module Name: z80_tester
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


module z80_tester(
    input clk,
    input         PS2Data,
    input         PS2Clk,
    output wire [7:0] sw
);


    reg nWAIT,nINT,nNMI,nRESET,nBUSRQ = 1'b1;
    
//    reg nWAIT,nINT,nNMI,nRESET,nBUSRQ;
    
    reg CLK = 0;
    
    wire nM1,nMREQ,nIORQ,nRD,nWR,nRFSH,nHALT,nBUSACK;
    wire [15:0] A;
    wire [7:0] D;
    wire [7:0] io;
    wire [7:0] o;
    wire [15:0] keycodev;
    wire map_address;
    wire map_value;
    wire RamWE;
    assign RamWE = nIORQ==1 && nRD==1 && nWR==0;
    
    z80_top_direct_n cpu(nM1,nMREQ,nIORQ,nRD,nWR, nRFSH,nHALT,nBUSACK,nWAIT,nINT,nNMI,nRESET,nBUSRQ,CLK,A,D);
    keyboard key(keycodev, clk, PS2Data, PS2Clk);
    memory mem(D,A, map_address, map_value,RamWE,CLK);
    memory_map mem_map(_,_,_,map_value,map_address, CLK);
    assign io = 1 ? D : 7'bz; // To drive the inout net
    assign o = io; // To read from inout net
    
    // // // TEST
//    initial
//    begin
//        #0;
//        nWAIT = 1;
//        nINT = 1;
//        nNMI = 1;
//        nRESET = 1;
//        nBUSRQ = 1;
//        #100;
//        nRESET = 1;
//        #150;
//        nRESET = 1;
//        #160;
//        nNMI = 1;
//        #200;
//        nNMI = 1;
//     end

//    always
//        #5 CLK = ~CLK; 
endmodule
