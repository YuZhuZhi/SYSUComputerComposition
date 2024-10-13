`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 17:11:10
// Design Name: 
// Module Name: Direct
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


module Direct(
    input RightLeft,
    input Pause,
    input Reset,
    output reg [1 : 0] Dir_Sel
    );
    
    reg [1 : 0] temp;
    
    always@(*) begin
        if (Pause == 0) begin
            if (RightLeft == 0) Dir_Sel <= 2'b10;
            if (RightLeft == 1) Dir_Sel <= 2'b11;
            if (Reset == 1) Dir_Sel <= 2'b01;
        end
        else begin
            Dir_Sel <= 2'b00;
            if (Reset == 1) Dir_Sel <= 2'b01;
        end
    end
    

    
endmodule
