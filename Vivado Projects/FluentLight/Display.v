`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 17:29:32
// Design Name: 
// Module Name: Display
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


module Display(
    input CLK_in,
    input [1 : 0] Dir,
    output reg [15 : 0] Light
    );
    
    reg [4 : 0] Num;
    
    always@(posedge CLK_in) begin
        case (Dir)
            2'b00: begin Num = Num; end
            2'b01: begin Num = 0; end
            2'b10: begin if (Num == 0) begin Num = 16; end Num = Num - 1; end
            2'b11: begin Num = Num + 1; if (Num == 16) begin Num = 0; end end
        endcase
    end
    
    always@(*) begin
        case (Num)
            0: Light = 16'b1000000000000000;
            1: Light = 16'b0100000000000000;
            2: Light = 16'b0010000000000000;
            3: Light = 16'b0001000000000000;
            4: Light = 16'b0000100000000000;
            5: Light = 16'b0000010000000000;
            6: Light = 16'b0000001000000000;
            7: Light = 16'b0000000100000000;
            8: Light = 16'b0000000010000000;
            9: Light = 16'b0000000001000000;
            10: Light = 16'b0000000000100000;
            11: Light = 16'b0000000000010000;
            12: Light = 16'b0000000000001000;
            13: Light = 16'b0000000000000100;
            14: Light = 16'b0000000000000010;
            15: Light = 16'b0000000000000001;
        endcase
    end
    
endmodule
