`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2019 09:47:12 AM
// Design Name: 
// Module Name: memory_map
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


module memory_map(
    read_value,
    read_address,
    read_clk,
    write_address,
    write_value,
    write_clk
    );
    
    output reg read_value;
    input [15:0] read_address;
    input read_clk;
    input write_value;
    input [15:0] write_address;
    input write_clk;
    parameter WIDTH = 60;
    parameter LENGTH = 80;
    reg [WIDTH*LENGTH - 1: 0] map;
    
    always @(posedge write_clk) 
    begin
        map[write_address] = write_value;
    end
    
    always @(posedge read_clk)
    begin
        read_value = map[read_address];
    end
endmodule
