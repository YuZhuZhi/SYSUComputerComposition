`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 00:39:45
// Design Name: 
// Module Name: External
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


module External(
    input CLK,
    input NextButton,
    input PreButton,
    input ResetButton,
    input VerifyButton,
    input StartSwitch,
    input StopSwitch,
    input [11 : 0] Number,
    output Halt,
    output Inputing,
    output Started,
    output Next,
    output Pre,
    output Verify,
    output [3 : 0] Segment,
    output [6 : 0] Position
    );
    
    wire CLK_div_wire;
    wire CLK_div2_wire;
    wire NextBD_wire;
    wire PreBD_wire;
    wire ResetBD_wire;
    wire VerifyBD_wire;
    (* KEEP = "TRUE" *) wire [3 : 0] Count_wire;
    (* KEEP = "TRUE" *) wire [31 : 0] Add_wire;
    (* KEEP = "TRUE" *) wire [31 : 0] NumfromCPU_wire;
    
    CLK_div CD (
        .CLK_in( CLK ),
        .CLK_out( CLK_div_wire )
    );
    
    CLK_div2 CD2 (
        .CLK_in( CLK ),
        .CLK_out( CLK_div2_wire )
    );
    
    (* DONT_TOUCH = "1" *) ButtonDebounce NextBD (
        .CLK_in( CLK_div_wire ),
        .Button_in( NextButton ),
        .Button_out( NextBD_wire )
    );
    
    (* DONT_TOUCH = "1" *) ButtonDebounce PreBD (
        .CLK_in( CLK_div_wire ),
        .Button_in( PreButton ),
        .Button_out( PreBD_wire )
    );
        
    (* DONT_TOUCH = "1" *) ButtonDebounce ResetBD (
        .CLK_in( CLK_div_wire ),
        .Button_in( ResetButton ),
        .Button_out( ResetBD_wire )
    );
    
    (* DONT_TOUCH = "1" *) ButtonDebounce VerifyBD (
        .CLK_in( CLK_div_wire ),
        .Button_in( VerifyButton ),
        .Button_out( VerifyBD_wire )
    );
    
    (* DONT_TOUCH = "1" *) Display DP (
        .CLK_in( CLK_div_wire ),
        .Data( (StopSwitch == 1) ? { Count_wire, NumfromCPU_wire[11 : 0] } : { Count_wire, Number } ),
        .segment( Segment ),
        .position( Position )
    );
    
    (* DONT_TOUCH = "1" *) AddGenerator AG (
        .CLK_in( CLK_div2_wire ),
        .Next( NextBD_wire ),
        .Pre( PreBD_wire ),
        .Verify( VerifyBD_wire ),
        .Reset( ResetBD_wire ),
        .Stop( StopSwitch ),
        .Address( Add_wire ),
        .Count( Count_wire )
    );
    
    (* DONT_TOUCH = "1" *) SingleCPU SCPU (
        .CLK( CLK_div_wire ),
        .Start( StartSwitch ),
        .Stop( StopSwitch ),
        .Verify( VerifyBD_wire ),
        .AddfromExtern( Add_wire ),
        .NumfromExtern( { 20'h00000, Number } ),
        .Halt( Halt ),
        .NumtoExtern( NumfromCPU_wire )
    );
    
    assign Inputing = !StopSwitch;
    assign Started = StartSwitch;
    assign Next = NextBD_wire;
    assign Pre = PreBD_wire;
    assign Verify = VerifyBD_wire;
    
endmodule
