`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 17:03:17
// Design Name: 
// Module Name: FluentLight
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


module FluentLight(
    input CLK,
    input [1 : 0] speed,
    input RLSwitch,
    input PauseSwitch, 
    input Button_mid,
    
    output [15 : 0] light
    );
    
    wire CLK_wire;
    wire [1 : 0] Dir_wire;
    
    CLK_Div clk_div (
        .CLK_in( CLK ),
        .Sp( speed ),
        .CLK_out( CLK_wire )
    );
    
    Direct direct(
        .RightLeft( RLSwitch ),
        .Pause( PauseSwitch ),
        .Reset( Button_mid ),
        .Dir_Sel( Dir_wire )
    );
    
    Display display (
        .CLK_in( CLK_wire ),
        .Dir( Dir_wire ),
        .Light( light )
    );
    
endmodule
