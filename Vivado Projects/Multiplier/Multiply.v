`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/13 17:40:50
// Design Name: 
// Module Name: Multiply
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


module Multiply(
    input CLK_in,
    input [7 : 0] Src1,
    input [7 : 0] Src2,
    output reg [15 : 0] Result
    );
    
    integer i;
    initial begin Result <= 0; end
    
    reg [1 : 0] stage = 0;
    reg [2 : 0] count = 0;
    reg [7 : 0] temp;
    reg [15 : 0] result;
    reg [15 : 0] extend;
    
    always@(posedge CLK_in) begin
        case (stage)
            2'b00: begin
                count <= 0;
                result <= 0;
                temp <= Src2;
                extend <= { 8'h00, Src1 };
                stage <= 2'b01;
            end
            2'b01: begin
                if (count == 7) stage <= 2'b10;
                else begin
                    if (temp[0] == 1) result <= result + extend;
                    else result <= result;
                    temp <= temp >> 1;
                    extend <= extend << 1;
                    count <= count + 1;
                end
            end
            2'b10: begin
                Result <= result;
                stage <= 2'b00;
            end
        endcase
    end
    
endmodule
