`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 22:14:57
// Design Name: 
// Module Name: Stage
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


module Stage(
    input CLK_in,
    input Halt_en,
    input [4 : 0] StageControl,
    output [4 : 0] Stage
    );
    
    reg [4 : 0] counter;
    initial counter <= 5'b10000;
    
    always@(posedge CLK_in) begin
        case (counter[4 : 0])
            5'b10000: begin counter = 5'b01000; end
            5'b01000: begin
                if (StageControl[2] == 1) begin counter = 5'b00100; end
                else if (StageControl[1] == 1) begin counter = 5'b00010; end
                else if (StageControl[0] == 1) begin counter = 5'b00001; end
                else begin counter = 5'b10000; end
            end
            5'b00100: begin
                if (StageControl[1] == 1) begin counter = 5'b00010; end
                else if (StageControl[0] == 1) begin counter = 5'b00001; end
                else begin counter = 5'b10000; end
            end
            5'b00010: begin
                if (StageControl[0] == 1) begin counter = 5'b00001; end
                else begin counter = 5'b10000; end
            end
            5'b00001: begin counter = 5'b10000; end
        endcase
    end
    
    assign Stage = (Halt_en == 1) ? 5'b10000 : counter;
    
endmodule
