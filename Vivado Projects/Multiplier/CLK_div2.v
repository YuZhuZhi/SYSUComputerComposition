`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/20 17:06:28
// Design Name: 
// Module Name: CLK_div2
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


module CLK_div2 #(parameter N = 19999999)(
    input CLK_in,
    output CLK_out
    );
    
    reg [31:0] counter = 0;
    reg out = 0;
    
    always@(posedge CLK_in) begin
        if (counter == N - 1) counter <= 0;
        else counter <= counter + 1;
    end
    
    always@(posedge CLK_in) begin
        if (counter == N - 1) out <= !out;
    end
    
    assign CLK_out = out;
    
endmodule
