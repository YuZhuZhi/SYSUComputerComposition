`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 13:23:47
// Design Name: 
// Module Name: IOPort
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


module IOPort(
    input [31 : 0] AddfromEx,
    output [31 : 0] AddtoMem,
    input [31 : 0] NumfromEx,
    output [31 : 0] NumtoMem,
    input [31 : 0] NumfromMem,
    output [31 : 0] NumtoEx,
    
    input Stop_en,
    input Verify_en,
    output MemWrite_en,
    output MemRead_en
    );
    
    assign MemWrite_en = (Stop_en == 0 & Verify_en == 1) ? 1 : 0;
    assign MemRead_en = (Stop_en == 0) ? 0 : 1;
    
    assign NumtoMem = (Stop_en == 0 & Verify_en == 1) ? NumfromEx : 32'bz;
    assign NumtoEx = (Stop_en == 1) ? NumfromMem : 32'bz;
    assign AddtoMem = AddfromEx;
    
endmodule
