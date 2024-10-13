`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/27 16:49:20
// Design Name: 
// Module Name: Top
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


module Top(
    input CLK,
    input [3:0] Data1,
    input [3:0] Data2,
    input Button_left,
    input Button_right,
    
    output [3:0] seg,
    output [6:0] a_to_g,
    
    output CF,
    output OF
    );
    
    wire clk_wire;
    wire [7:0] Result;
    wire [7:0] mux_result;
    reg display_switch;
    
    CLK_div clk_div (
        .CLK_in( CLK ),
        .CLK_out( clk_wire )
    );
    
    Display display (
        .CLK( clk_wire ),
        .Data( mux_result ),
        .isResult( display_switch ),
        .seg( seg ),
        .a_to_g( a_to_g )
        );
        
    Mux2 mux (
        .Data1( {Data1,Data2} ),
        .Data2( Result ),
        .Sel( display_switch ),
        .Mux_Result( mux_result )
      );
      
    always@(*) begin
        if (Button_left == 1)
            display_switch <= 0;
        if (Button_right == 1)
            display_switch <= 1;
    end
      
    ALU alu (
        .Data1( Data1 ),
        .Data2( Data2 ),
        .Result( Result ),
        .CF( CF ),
        .OF( OF )
    );

endmodule
