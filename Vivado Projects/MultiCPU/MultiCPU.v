`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 16:23:54
// Design Name: 
// Module Name: MultiCPU
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


module MultiCPU(
    input CLK,
    input Start
    );
    
    wire ZF_wire;
    
    wire [4 : 0] Stage_wire;
    
    wire [31 : 0] InstructAddress_wire;
    wire [31 : 0] PCPlus4_wire;
    wire [31 : 0] JumpPC_wire;
    wire [31 : 0] BranchPC_wire;
    wire [31 : 0] SL2toPW_wire;
    wire [31 : 0] NextPC_wire;
    wire [31 : 0] Instruction_wire;
    wire [31 : 0] MicroInstruct_wire;
    wire [31 : 0] SignEx_wire;
    wire [31 : 0] ReadData1_wire;
    wire [31 : 0] ReadData2_wire;
    wire [31 : 0] ALU_Mux_wire;
    wire [31 : 0] ALUGeneral_wire;
    wire [31 : 0] SL2toBranch_wire;
    wire [31 : 0] DataMemRead_wire;
    wire [31 : 0] RegWriteData_wire;
    
    ProgramCounter PC (
        .CLK_in( CLK ),
        .Start_en( Start ),
        .Halt_en( MicroInstruct_wire[8] ),
        .Write_en( Stage_wire[4] ),
        .Address_in( NextPC_wire ),
        .Address_out( InstructAddress_wire )
    );
    
    ALU PCPlus4 (
        .ALUControl( 4'b0010 ),
        .Src1( InstructAddress_wire ),
        .Src2( 32'h00000004 ),
        .Result( PCPlus4_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    PCWriter PW (
        .ZF( ZF_wire ),
        .Stage( Stage_wire ),
        .MicroInstruct( MicroInstruct_wire ),
        .PCPlus4( PCPlus4_wire ),
        .JumpPC( { PCPlus4_wire[31 : 28], SL2toPW_wire[27 : 0] } ),
        .BranchPC( BranchPC_wire ),
        .NextPC( NextPC_wire )
    );
    
    InstructMem IM (
        .InstructAddress( InstructAddress_wire ),
        .Instruction( Instruction_wire )
    );
    
    SignExtend SE (
        .InstructLow16bits( Instruction_wire[15 : 0] ),
        .Data32bits( SignEx_wire )
    );
    
    Control CU (
        .Instruct( Instruction_wire ),
        .MicroInstruct( MicroInstruct_wire )
    );
    
    Stage SC (
        .CLK_in( CLK ),
        .Halt_en( MicroInstruct_wire[8] ),
        .StageControl( { 2'b11, MicroInstruct_wire[31 : 29] } ),
        .Stage( Stage_wire )
    );
    
    ALU SL2toPW (
        .ALUControl( 4'b1100 ),
        .Src1( Instruction_wire ),
        .Src2( 32'h00000080 ),
        .Result( SL2toPW_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    RegisterFile RF (
        .CLK_in( CLK ),
        .RegRead1( MicroInstruct_wire[24 : 20] ),
        .RegRead2( MicroInstruct_wire[19 : 15] ),
        .RegWrite( MicroInstruct_wire[14 : 10] ),
        .RegWrite_en( MicroInstruct_wire[2] & Stage_wire[0] ),
        .RegDst( MicroInstruct_wire[1] ),
        .RegWriteData( RegWriteData_wire ),
        .ReadData1( ReadData1_wire ),
        .ReadData2( ReadData2_wire )
    );
    
    Mux ALU_Mux (
        .Condition( MicroInstruct_wire[0] ),
        .Data1( SignEx_wire ),
        .Data2( ReadData2_wire ),
        .Result( ALU_Mux_wire )
    );
    
    ALU ALUGeneral (
        .ALUControl( MicroInstruct_wire[28 : 25] ),
        .Src1( ReadData1_wire ),
        .Src2( ALU_Mux_wire ),
        .Result( ALUGeneral_wire ),
        .ZF( ZF_wire ),
        .SF(  )
    );
    
    ALU SL2toBranch (
        .ALUControl( 4'b1100 ),
        .Src1( SignEx_wire ),
        .Src2( 32'h00000080 ),
        .Result( SL2toBranch_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    ALU ADD (
        .ALUControl( 4'b0010 ),
        .Src1( PCPlus4_wire ),
        .Src2( SL2toBranch_wire ),
        .Result( BranchPC_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    DataMem DM (
        .CLK_in( CLK ),
        .DataAddress( ALUGeneral_wire ),
        .Data_in( ReadData2_wire ),
        .MemRead_en( MicroInstruct_wire[3] ),
        .MemWrite_en( MicroInstruct_wire[4] & Stage_wire[1] ),
        .Data_out( DataMemRead_wire )
    );
    
    Mux Mem_ALU_Mux (
        .Condition( MicroInstruct_wire[5] ),
        .Data1( ALUGeneral_wire ),
        .Data2( DataMemRead_wire ),
        .Result( RegWriteData_wire )
    );
    
endmodule
