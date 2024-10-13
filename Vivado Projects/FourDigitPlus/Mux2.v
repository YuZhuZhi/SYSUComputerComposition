`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/27 17:20:49
// Design Name: 
// Module Name: Mux2
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


module Mux2(
    input [7:0] Data1,
    input [7:0] Data2,
    input Sel,
    output reg [7:0] Mux_Result
    );
    
    always@(*) begin
        if (Sel == 0)
            Mux_Result <= Data1;
        if (Sel == 1)
            Mux_Result <= Data2;
    end
    
endmodule
