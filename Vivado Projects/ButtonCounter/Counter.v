`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/18 20:23:41
// Design Name: 
// Module Name: Counter
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


module Counter(
    input CLK_in,
    input Button_in,
    output [15 : 0] Number
    );
    
     reg [15 : 0] counter = 16'b0;
    
    always@(posedge CLK_in) begin
        if (Button_in == 1) counter <= counter + 1;
    end
    
    assign Number = counter;
    
endmodule
