`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/01 16:43:33
// Design Name: 
// Module Name: Control
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


module Control(
    input [31 : 0] Instruct,
    output reg [31 : 0] MicroInstruct
    );
    
    always@(Instruct) begin
        MicroInstruct[31 : 0] = 32'h00000000;
        case (Instruct[31 : 26])
            6'b000000: begin     //R_type
                MicroInstruct[31 : 29] <= 3'b101;
                MicroInstruct[24 : 10] <= Instruct[25 : 11];
                case (Instruct[5 : 0])
                    6'b100000: begin MicroInstruct[28 : 25] <= 4'b0010; { MicroInstruct[0], MicroInstruct[2] } <= 2'b11; end     //add
                    6'b100010: begin MicroInstruct[28 : 25] <= 4'b0110; { MicroInstruct[0], MicroInstruct[2] } <= 2'b11; end     //sub
                    6'b100100: begin MicroInstruct[28 : 25] <= 4'b0000; { MicroInstruct[0], MicroInstruct[2] } <= 2'b11; end     //and
                    6'b100101: begin MicroInstruct[28 : 25] <= 4'b0001; { MicroInstruct[0], MicroInstruct[2] } <= 2'b11; end     //or
                    6'b101010: begin MicroInstruct[28 : 25] <= 4'b0111; { MicroInstruct[0], MicroInstruct[2] } <= 2'b11; end     //slt
                    6'b000000: begin     //sll
                        MicroInstruct[28 : 20] <= { 4'b1100, Instruct[20 : 16] };
                        MicroInstruct[2 : 1] <= 2'b11;
                    end
                endcase    
            end
            
            6'b001000: begin      //addi
                MicroInstruct[31 : 20] <= { 3'b101, 4'b0010, Instruct[25 : 21] };
                MicroInstruct[14 : 10] <= Instruct[20 : 16];
                MicroInstruct[2 : 1] <= 2'b11;
            end
            6'b001100: begin      //andi
                MicroInstruct[31 : 20] <= { 3'b101, 4'b0000, Instruct[25 : 21] };
                MicroInstruct[14 : 10] <= Instruct[20 : 16];
                MicroInstruct[2 : 1] <= 2'b11;
            end
            6'b001101: begin      //ori
                MicroInstruct[31 : 20] <= { 3'b101, 4'b0001, Instruct[25 : 21] };
                MicroInstruct[14 : 10] <= Instruct[20 : 16];
                MicroInstruct[2 : 1] <= 2'b11;
            end
            
            6'b100011: begin      //lw
                MicroInstruct[31 : 20] <= { 3'b111, 4'b0010, Instruct[25 : 21] };
                MicroInstruct[14 : 10] <= Instruct[20 : 16];
                { MicroInstruct[3 : 1], MicroInstruct[5] } <= 4'b1111;
            end
            6'b101011: begin      //sw
                MicroInstruct[31 : 15] <= { 3'b110, 4'b0010, Instruct[25 : 21], Instruct[20 : 16] };
                MicroInstruct[4] <= 1'b1;
            end
            
            6'b000100: begin      //beq
                MicroInstruct[31 : 15] <= { 3'b100, 4'b0110, Instruct[25 : 21], Instruct[20 : 16] };
                { MicroInstruct[0], MicroInstruct[7] } <= 2'b11;
            end
            6'b000111: begin      //bgtz
                MicroInstruct[31 : 15] <= { 3'b100, 4'b0110, Instruct[25 : 21], 5'b00000 };
                { MicroInstruct[0], MicroInstruct[7] } <= 2'b11;
            end
            
            6'b000010: begin MicroInstruct[6] <= 1; end    //j
            6'b111111: begin MicroInstruct[8] <= 1; end    //halt
        endcase
    end
    
endmodule
