`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/20 16:55:14
// Design Name: 
// Module Name: Switch
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


module Switch(
    input Button_in,
    output reg Switch_out
    );
    
    reg [7 : 0] count = 0;
    
    always@(posedge Button_in) begin
        count = count + 1;
    end
    
    always@(count) begin
        if (count[0] == 0) Switch_out = 0;
        else Switch_out = 1;
    end
    
endmodule
