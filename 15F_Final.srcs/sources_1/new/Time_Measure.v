`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/17 21:36:14
// Design Name: 
// Module Name: Time_Measure
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


module Time_Measure(
    input            sys_clk,
    input            rst_n,
    input            locked,
    input            signal_in,
    
    output reg[27:0] time_result
    );
    
reg [27:0]   time_cnt;
wire          pos_edge;

reg signal_d1;
reg signal_d2;
reg signal_d3;

parameter    CLK_FREQ = 400_000_000;
parameter    TIMEOUT_MAX = 27'h7FFFFFF;

assign  pos_edge = (signal_d2 == 1'b1 && signal_d3 == 1'b0);
    
always @(posedge sys_clk) begin
    if (!rst_n || !locked) begin
        signal_d1 <= 1'b0;
        signal_d2 <= 1'b0;
        signal_d3 <= 1'b0;
    end 
    else begin
        signal_d1 <= signal_in;
        signal_d2 <= signal_d1;
        signal_d3 <= signal_d2;
    end
end 

always @(posedge sys_clk) begin  
    if (!rst_n || !locked) begin
        time_cnt <= 1'b1;
        time_result <= 1'b0;
    end 
    else if (pos_edge) begin
        time_result <= time_cnt;
        time_cnt <= 1'b1;
    end 
    else if (time_cnt < TIMEOUT_MAX) begin
        time_cnt <= time_cnt + 1'b1;
    end 
    else begin
        time_result <= 1'b0;
    end
end
    
endmodule
