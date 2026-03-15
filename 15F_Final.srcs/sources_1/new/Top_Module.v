`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/17 21:16:29
// Design Name: 
// Module Name: Top_Module
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


module Top_Module(
    input                 clk_in,
    input                 rst_n,
    input                 signal_in,
    input                 signal_in2,
    
    output   reg  [31:0]   dataout,
    output   wire [31:0]   dutyout_high,
    output   wire [31:0]   dutyout_low,
    output   wire [31:0]   interval_data
    );
    
wire              sys_clk;
wire              locked;
wire    [26:0]    freq_result;
wire    [27:0]    time_result;

parameter         THRESHOLD = 6_000;
    
clk_wiz_0 u_sys_mmcm(
    .clk_out1   (sys_clk),
    .reset      (!rst_n),
    .locked     (locked),
    .clk_in1    (clk_in)
);
    
Freq_Measure Freq_Measure(
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .locked(locked),
    .signal_in(signal_in),
    
    .freq_result(freq_result)
);
    
Time_Measure Time_Measure(
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .locked(locked),
    .signal_in(signal_in),
    
    .time_result(time_result)
);

duty duty(
    .clk_400m    (sys_clk),
    .rst_n       (rst_n),
    .signal_in   (signal_in),
    .high_cnt_r_out     (dutyout_high),
    .low_cnt_r_out     (dutyout_low)
);

Time_Interval_Measure u_interval_measure(
        .sys_clk        (sys_clk),
        .rst_n          (rst_n & locked),
        .signal_start   (signal_in),
        .signal_stop    (signal_in2),
        .interval_ticks (interval_data)
    );

always @(posedge sys_clk) begin
    if (!rst_n || !locked) begin
        dataout <= 30'b0;
    end 
    
    else begin
        if (time_result < THRESHOLD) begin
            dataout <= {3'b000, freq_result};
        end
        else begin
            dataout <= {2'b10, time_result};
        end 
    end 
end
    
endmodule
