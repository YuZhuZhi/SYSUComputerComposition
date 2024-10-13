`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/24 23:17:43
// Design Name: 
// Module Name: InstructMem
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


module InstructMem(
    input [31 : 0] InstructAddress,
    output [31 : 0] Instruction
    );
    
    reg [7 : 0] Instruct [0 : 200];
    
    initial begin
        $readmemb("H:/ViVado/Vivado Projects/SingleCPU/Bubble.txt", Instruct);
    end
    
    assign Instruction[31 : 24] = Instruct[InstructAddress + 0];
    assign Instruction[23 : 16] = Instruct[InstructAddress + 1];
    assign Instruction[15 : 8]  = Instruct[InstructAddress + 2];
    assign Instruction[7 : 0]   = Instruct[InstructAddress + 3];
    
endmodule
