`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/18 16:51:07
// Design Name: 
// Module Name: SingleCPU
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


module SingleCPU(
    input CLK,
    input Start,
    input Stop,
    input Verify,
    input [31 : 0] AddfromExtern,
    input [31 : 0] NumfromExtern,
    output Halt,
    output [31 : 0] NumtoExtern
    );
    
    wire [31 : 0] PCIn_wire;
    wire [31 : 0] PCOri_wire;
    wire [31 : 0] PCPlus4_wire;
    wire [31 : 0] Instruct_wire;
    wire [31 : 0] ADD_wire;
    wire [31 : 0] SL2toJAG_wire;
    wire [31 : 0] SL2toADD_wire;
    wire [31 : 0] JAG_wire;
    wire [31 : 0] SignEx_wire;
    wire [31 : 0] ReadData1_wire;
    wire [31 : 0] ReadData2_wire;
    wire [31 : 0] RegWriteData_wire;
    wire [31 : 0] ALU_Mux_wire;
    wire [31 : 0] Branch_Mux_wire;
    wire [31 : 0] ALUGeneral_wire;
    wire [31 : 0] DataMemRead_wire;
    wire [31 : 0] MemWriteData_wire;
    wire [31 : 0] MemAdd_wire;
    wire [31 : 0] AddtoMem_wire;
    wire [31 : 0] NumtoMem_wire;
    
    wire [3 : 0] ALUControl_wire;
        
    wire [4 : 0] RegRead1_wire;
    wire [4 : 0] RegRead2_wire;
    wire [4 : 0] RegWrite_wire;
        
    wire ALUSrc_wire;
    wire RegDst_wire;
    wire RegWrite_en_wire;
    wire MemRead_en_wire;
    wire MemWrite_en_wire;
    wire IOPMemRead_en_wire;
    wire IOPMemWrite_en_wire;
    wire MemtoReg_en_wire;
    wire Jump_en_wire;
    wire Branch_en_wire;
    wire Halt_en_wire;
    wire ZF_wire;
    
    (* DONT_TOUCH = "1" *) ProgramCounter PC (
        .CLK_in( CLK ),
        .Start_en( Start ),
        .Halt_en( Halt_en_wire ),
        .Address_in( PCIn_wire ),
        .Address_out( PCOri_wire )
    );
    
    (* DONT_TOUCH = "1" *) ALU PCPlus4 (
        .ALUControl( 4'b0010 ),
        .Src1( PCOri_wire ),
        .Src2( 32'h00000004 ),
        .Result( PCPlus4_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    (* DONT_TOUCH = "1" *) InstructMem IM (
        .InstructAddress( PCOri_wire ),
        .Instruction( Instruct_wire )
    );
    
    (* DONT_TOUCH = "1" *) ALU SL2toJAG (
        .ALUControl( 4'b1100 ),
        .Src1( Instruct_wire ),
        .Src2( 32'h00000002 ),
        .Result( SL2toJAG_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    (* DONT_TOUCH = "1" *) JumpAddGenerator JAG (
        .PC4High4bits( PCPlus4_wire ),
        .SL2Low28bits( SL2toJAG_wire ),
        .Address_out( JAG_wire )
    );
    
    (* DONT_TOUCH = "1" *) Control CU (
        .Instruct( Instruct_wire ),
        .ALUControl( ALUControl_wire ),
        .RegRead1( RegRead1_wire ),
        .RegRead2( RegRead2_wire ),
        .RegWrite( RegWrite_wire ),
        .ALUSrc( ALUSrc_wire ),
        .RegDst( RegDst_wire ),
        .RegWrite_en( RegWrite_en_wire ),
        .MemRead_en( MemRead_en_wire ),
        .MemWrite_en( MemWrite_en_wire ),
        .MemtoReg_en( MemtoReg_en_wire ),
        .Jump_en( Jump_en_wire ),
        .Branch_en( Branch_en_wire ),
        .Halt_en( Halt_en_wire )
    );
    
    (* DONT_TOUCH = "1" *) SignExtend SE (
        .InstructLow16bits( Instruct_wire[15 : 0] ),
        .Data32bits( SignEx_wire )
    );
    
    (* DONT_TOUCH = "1" *) RegisterFile RF (
        .CLK_in( CLK ),
        .RegRead1( RegRead1_wire ),
        .RegRead2( RegRead2_wire ),
        .RegWrite( RegWrite_wire ),
        .RegWrite_en( RegWrite_en_wire ),
        .RegDst( RegDst_wire ),
        .RegWriteData( RegWriteData_wire ),
        .ReadData1( ReadData1_wire ),
        .ReadData2( ReadData2_wire )
    );
    
    (* DONT_TOUCH = "1" *) Mux ALU_Mux (
        .Condition( ALUSrc_wire ),
        .Data1( SignEx_wire ),
        .Data2( ReadData2_wire ),
        .Result( ALU_Mux_wire )
    );
    
    (* DONT_TOUCH = "1" *) ALU ALUGeneral (
        .ALUControl( ALUControl_wire ),
        .Src1( ReadData1_wire ),
        .Src2( ALU_Mux_wire ),
        .Result( ALUGeneral_wire ),
        .ZF( ZF_wire ),
        .SF(  )
    );
    
    (* DONT_TOUCH = "1" *) DataMem DM (
        .CLK_in( CLK ),
        .DataAddress( MemAdd_wire ),
        .Data_in( MemWriteData_wire ),
        .MemRead_en( (Start == 1 & Halt == 0) ? MemRead_en_wire : IOPMemRead_en_wire ),
        .MemWrite_en( (Start == 1) ? MemWrite_en_wire : IOPMemWrite_en_wire ),
        .Data_out( DataMemRead_wire )
    );
    
    (* DONT_TOUCH = "1" *) Mux Mem_ALU_Mux (
        .Condition( MemtoReg_en_wire ),
        .Data1( ALUGeneral_wire ),
        .Data2( DataMemRead_wire ),
        .Result( RegWriteData_wire )
    );
    
    (* DONT_TOUCH = "1" *) ALU SL2toADD (
        .ALUControl( 4'b1100 ),
        .Src1( SignEx_wire ),
        .Src2( 32'h00000002 ),
        .Result( SL2toADD_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    (* DONT_TOUCH = "1" *) ALU ADD (
        .ALUControl( 4'b0010 ),
        .Src1( SL2toADD_wire ),
        .Src2( PCPlus4_wire ),
        .Result( ADD_wire ),
        .ZF(  ),
        .SF(  )
    );
    
    (* DONT_TOUCH = "1" *) Mux Branch_Mux (
        .Condition( Branch_en_wire & ZF_wire ),
        .Data1( PCPlus4_wire ),
        .Data2( ADD_wire ),
        .Result( Branch_Mux_wire )
    );
    
    (* DONT_TOUCH = "1" *) Mux Jump_Mux (
        .Condition( Jump_en_wire ),
        .Data1( Branch_Mux_wire ),
        .Data2( JAG_wire ),
        .Result( PCIn_wire )
    );
    
    (* DONT_TOUCH = "1" *) IOPort IOP (
        .AddfromEx( AddfromExtern ),
        .AddtoMem( AddtoMem_wire ),
        .NumfromEx( NumfromExtern ),
        .NumtoMem( NumtoMem_wire ),
        .NumfromMem( DataMemRead_wire ),
        .NumtoEx( NumtoExtern ),
        .Stop_en( Stop ),
        .Verify_en( Verify ),
        .MemWrite_en( IOPMemWrite_en_wire ),
        .MemRead_en( IOPMemRead_en_wire )
    );
    
    (* DONT_TOUCH = "1" *) Mux MemWriteData_Mux (
        .Condition( Start ),
        .Data1( NumtoMem_wire ),
        .Data2( ReadData2_wire ),
        .Result( MemWriteData_wire )
    );
    
    (* DONT_TOUCH = "1" *) Mux MemAdd_Mux (
        .Condition( Start == 1 & Halt == 0 ),
        .Data1( AddtoMem_wire ),
        .Data2( ALUGeneral_wire ),
        .Result( MemAdd_wire )
    );
    
    assign Halt = Halt_en_wire;
    
endmodule
