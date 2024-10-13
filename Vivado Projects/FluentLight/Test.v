`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/24 00:05:00
// Design Name: 
// Module Name: Test
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


module Test(
    input CLK_in,
    input [1 : 0] Dir_Sel,
    output reg [3 : 0] Temp
    );
    
    always@(posedge CLK_in) begin
        case (Dir_Sel)
            2'b00: begin Temp = 4'b1000; end
            2'b01: begin Temp = 4'b0100; end
            2'b10: begin Temp = 4'b0010; end
            2'b11: begin Temp = 4'b0001; end
        endcase
    end
    
endmodule
