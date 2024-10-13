`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/18 20:18:32
// Design Name: 
// Module Name: ButtonDebounce
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


module ButtonDebounce(
    input CLK_in,
    input Button_in,
    output Button_out
    );
    
    reg [2 : 0] Button = 0;
    
    always@(posedge CLK_in) begin
        Button[0] <= Button_in;
        Button[1] <= Button[0];
        Button[2] <= Button[1];
    end
    
    assign Button_out = (Button[2] & Button[1] & Button[0]) | (~Button[2] & Button[1] & Button[0]);
    
endmodule
