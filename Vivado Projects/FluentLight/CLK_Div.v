`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 17:05:07
// Design Name: 
// Module Name: CLK_Div
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


module CLK_Div #(parameter N = 12500000)(
    input CLK_in,
    input [1 : 0] Sp,
    output CLK_out
    );
    
    reg [31 : 0] counter;
    reg [31 : 0] MAX;
    reg out;
    
    always@(*) begin
        if (Sp == 2'b00) begin
            MAX = N;
        end
        if (Sp == 2'b01) begin
            MAX = 2 * N;
        end
        if (Sp == 2'b10) begin
            MAX = 3 * N;
        end
        if (Sp == 2'b11) begin
            MAX = 4 * N;
        end
    end
    
    always@(posedge CLK_in) begin
        if (counter == MAX) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end
    
    always@(posedge CLK_in) begin
        if (counter == MAX) begin
                out <= !out;
        end
    end
    
    assign CLK_out = out;
    
endmodule
