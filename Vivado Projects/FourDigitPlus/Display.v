`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/20 17:49:12
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
    input CLK,
    input [7:0] Data,
    input isResult,
    output reg [3:0] seg,
    output reg [6:0] a_to_g
    );
    
    reg [3:0] temp;
    reg [7:0] x;
    
    always@(posedge CLK) begin
        if (isResult)
            case (temp)
                0: begin x = Data / 1000; seg = 4'b0111; end
                1: begin x = Data / 100 % 10; seg = 4'b1011; end
                2: begin x = Data / 10 % 10; seg = 4'b1101; end
                3: begin x = Data % 10; seg = 4'b1110; end
            endcase
        else
            case (temp)
                0: begin x = Data[7:4] / 10; seg = 4'b0111; end
                1: begin x = Data[7:4] % 10; seg = 4'b1011; end
                2: begin x = Data[3:0] / 10; seg = 4'b1101; end
                3: begin x = Data[3:0] % 10; seg = 4'b1110; end
            endcase
        temp = temp + 1;
        if (temp % 4 == 0)
            temp = 0;
    end
    
    always@(*) begin
        case (x)
            0: a_to_g = 7'b0000001;
            1: a_to_g = 7'b1001111;
            2: a_to_g = 7'b0010010;
            3: a_to_g = 7'b0000110;
            4: a_to_g = 7'b1001100;
            5: a_to_g = 7'b0100100;
            6: a_to_g = 7'b0100000;
            7: a_to_g = 7'b0001111;
            8: a_to_g = 7'b0000000;
            9: a_to_g = 7'b0000100;
        endcase
    
    end
    
endmodule

