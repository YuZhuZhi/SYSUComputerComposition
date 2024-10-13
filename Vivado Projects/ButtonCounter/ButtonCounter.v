`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/18 20:17:37
// Design Name: 
// Module Name: ButtonCounter
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


module ButtonCounter(
    input CLK,
    input Button,
    
    output [3 : 0] Segment,
    output [6 : 0] Position
    );
    
    wire CLK_div_wire;
    wire CLK_div2_wire;
    wire ButtonBD_wire;
    wire [15 : 0] Number_wire;
    
    CLK_div CD (
        .CLK_in( CLK ),
        .CLK_out( CLK_div_wire )
    );
    
    CLK_div2 CD2 (
        .CLK_in( CLK ),
        .CLK_out( CLK_div2_wire )
    );
    
    ButtonDebounce BD (
        .CLK_in( CLK_div_wire ),
        .Button_in( Button ),
        .Button_out( ButtonBD_wire )
    );
    
    Counter CT (
        .CLK_in( CLK_div2_wire ),
        .Button_in( ButtonBD_wire ),
        .Number( Number_wire )
    );
    
    Display DP (
        .CLK_in( CLK_div_wire ),
        .Data( Number_wire ),
        .segment( Segment ),
        .position( Position )
    );
    
endmodule
