`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 22:15:46
// Design Name: 
// Module Name: PCWriter
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


module PCWriter(
    input ZF,
    input [4 : 0] Stage,
    input [31 : 0] MicroInstruct,
    input [31 : 0] PCPlus4,
    input [31 : 0] JumpPC,
    input [31 : 0] BranchPC,
    output [31 : 0] NextPC
    );
    
    reg [31 : 0] counter;
    
    initial counter = 32'h00000000;
    
    always@(Stage) begin
        case(Stage)
            5'b10000: counter = PCPlus4;
            5'b01000: counter = (MicroInstruct[6]) ? JumpPC : PCPlus4;
            5'b00100: counter = (MicroInstruct[7] && ZF) ? BranchPC : PCPlus4;
            default: counter = PCPlus4;
        endcase
    end
    
    assign NextPC = counter;
    
endmodule
