`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/20 17:01:57
// Design Name: 
// Module Name: Extern
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


module Extern(
    input CLK,
    input Button,
    input [15 : 0] Switch,
    output [1 : 0] Light,
    output [3 : 0] Segment,
    output [6 : 0] Position
    );
    
    wire CD_wire;
    wire CD2_wire;
    wire BD_wire;
    wire DS_wire;
    wire [15 : 0] Result_wire;
    
    CLK_div CD (
        .CLK_in( CLK ),
        .CLK_out( CD_wire )
    );
    
    CLK_div2 CD2 (
        .CLK_in( CLK ),
        .CLK_out( CD2_wire )
    );
    
    ButtonDebounce BD (
        .CLK_in( CD2_wire ),
        .Button_in( Button ),
        .Button_out( BD_wire )
    );
    
    Switch DS (
        .Button_in( BD_wire ),
        .Switch_out( DS_wire )
    );
    
    Display(
        .CLK_in( CD_wire ),
        .Data( DS_wire ? Result_wire : Switch ),
        .segment( Segment ),
        .position( Position )
    );
    
    Multiply(
        .CLK_in( CD_wire ),
        .Src1( Switch[15 : 8] ),
        .Src2( Switch[7 : 0] ),
        .Result( Result_wire )
    );
    
    assign Light = DS_wire ? 2'b10 : 2'b01;
    
endmodule
