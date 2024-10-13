`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/18 20:16:52
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
    input [15 : 0] Data,
    output reg [3 : 0] segment,
    output reg [6 : 0] position
    );
    
    reg [1 : 0] temp;
    reg [3 : 0] x;
    
    always@(posedge CLK_in) begin
        case (temp)
            0: begin x = Data[15 : 12]; segment = 4'b0111; end
            1: begin x = Data[11 : 8]; segment = 4'b1011; end
            2: begin x = Data[7 : 4]; segment = 4'b1101; end
            3: begin x = Data[3 : 0]; segment = 4'b1110; end
        endcase
        temp = temp + 1;
        if (temp % 4 == 0) temp = 0;
    end
    
    always@(*) begin
        case (x)
            4'h0: position = 7'b0000001;
            4'h1: position = 7'b1001111;
            4'h2: position = 7'b0010010;
            4'h3: position = 7'b0000110;
            4'h4: position = 7'b1001100;
            4'h5: position = 7'b0100100;
            4'h6: position = 7'b0100000;
            4'h7: position = 7'b0001111;
            4'h8: position = 7'b0000000;
            4'h9: position = 7'b0000100;
            4'hA: position = 7'b0001000;
            4'hB: position = 7'b0010000;
            4'hC: position = 7'b0110001;
            4'hD: position = 7'b0010001;
            4'hE: position = 7'b0110000;
            4'hF: position = 7'b0111000;
        endcase
    end
    
endmodule
