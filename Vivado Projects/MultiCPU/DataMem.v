`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/05 20:35:26
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input CLK_in,
    input [31 : 0] DataAddress,
    input [31 : 0] Data_in,
    input MemRead_en,
    input MemWrite_en,
    output [31 : 0] Data_out
    );
    
    reg [7 : 0] Data [0 : 63];
    integer i;
        initial begin
            for (i = 0; i <= 63; i = i + 1) Data[i] <= 0;
            Data[3] <= 8'h01;
            Data[7] <= 8'h20;
            Data[11] <= 8'h11;
            Data[15] <= 8'h13;
            Data[19] <= 8'h05;
            Data[23] <= 8'h21;
            Data[27] <= 8'h31;
            Data[31] <= 8'h04;
            Data[35] <= 8'h08;
            Data[39] <= 8'h25;
        end
    
    assign Data_out[7 : 0]   = (MemRead_en == 1) ? Data[DataAddress + 3] : 8'bz;
    assign Data_out[15 : 8]  = (MemRead_en == 1) ? Data[DataAddress + 2] : 8'bz;
    assign Data_out[23 : 16] = (MemRead_en == 1) ? Data[DataAddress + 1] : 8'bz;
    assign Data_out[31 : 24] = (MemRead_en == 1) ? Data[DataAddress + 0] : 8'bz;
    
    always@(negedge CLK_in) begin
        if (MemWrite_en == 1) begin
            Data[DataAddress + 0] <= Data_in[31:24];
            Data[DataAddress + 1] <= Data_in[23:16];
            Data[DataAddress + 2] <= Data_in[15:8];
            Data[DataAddress + 3] <= Data_in[7:0];
        end
    end
    
endmodule
