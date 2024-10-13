`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/24 23:08:28
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
    input CLK_in,
    input Start_en,
    input Halt_en,
    input Write_en,
    input [31 : 0] Address_in,
    output reg [31 : 0] Address_out
    );
    
    reg [31 : 0] Address;
    
    initial Address <= 0;
    
    always@(posedge CLK_in) begin
        if (Start_en == 0) Address <= 0;
        else begin 
            if (Halt_en == 1) Address = Address;
            else Address = Address_in;
        end
    end
    
    always@(Write_en) begin
        if (Write_en == 1) Address_out = Address;
    end
    
endmodule
