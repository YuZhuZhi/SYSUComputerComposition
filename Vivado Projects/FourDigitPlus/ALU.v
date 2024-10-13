`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/20 17:19:52
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [3:0] Data1,
    input [3:0] Data2,
    output [7:0] Result,
    output CF,
    output OF
    
    );
    wire G1,G2,G3,G4;
    wire P1,P2,P3,P4;
    
    assign G1 = Data1[0]&Data2[0];
    assign P1 = Data1[0]^Data2[0];
    assign G2 = Data1[1]&Data2[1];
    assign P2 = Data1[1]^Data2[1];
    assign G3 = Data1[2]&Data2[2];
    assign P3 = Data1[2]^Data2[2];
    assign G4 = Data1[3]&Data2[3];
    assign P4 = Data1[3]^Data2[3];
    
    wire C1, C2, C3, C4;
    assign C1 = G1;
    assign C2 = G2 | (P2 & (G1));
    assign C3 = G3 | (P3 & (G2 | (P2 & (G1))));
    assign C4 = G4 | (P4 & (G3|(P3 & (G2 | (P2 & (G1))))));
    
    assign Result[3] = P4 ^ C3;
    assign Result[2] = P3 ^ C2;
    assign Result[1] = P2 ^ C1;
    assign Result[0] = P1;
    
    assign CF = C4;
    assign OF = C3 ^ C4;
    
    
    
endmodule
