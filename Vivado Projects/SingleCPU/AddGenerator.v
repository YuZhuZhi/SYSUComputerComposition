`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 15:06:21
// Design Name: 
// Module Name: AddGenerator
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


module AddGenerator(
    input CLK_in,
    input Next,
    input Pre,
    input Verify,
    input Reset,
    input Stop,
    output reg [31 : 0] Address,
    output [3 : 0] Count
    );
    
    (* KEEP = "TRUE" *)  reg [31 : 0] counter = 32'b0;
    
    always@(posedge CLK_in) begin
        if (Next == 1) begin
            counter = counter + 4;
            if (counter == 40) counter = 0;
            if (Stop == 1) Address = counter;
        end
        else if (Pre == 1) begin
            if (counter == 0) counter = 40;
            counter = counter - 4;
            if (Stop == 1) Address = counter;
        end
        else if (Reset == 1) begin
            counter = 0;
            Address = 0;
        end
        else if (Stop == 0 & Verify == 1) Address = counter;
    end
    
    assign Count = counter / 4;
    
endmodule
