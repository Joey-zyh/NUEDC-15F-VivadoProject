`timescale 1ns / 1ps

module Freq_Measure(
    input            sys_clk,   // 400MHz
    input            rst_n,
    input            locked,
    input            signal_in, 
    
    output reg[31:0] freq_result // 改为32位，防止溢出
);

parameter CLK_FREQ = 400_000_000;

// 1. 边沿检测 (全部在 sys_clk 域)
reg [2:0] sig_sync;
always @(posedge sys_clk) begin
    if (!rst_n || !locked) 
        sig_sync <= 3'b0;
    else 
        sig_sync <= {sig_sync[1:0], signal_in};
end

wire pos_edge = (sig_sync[2:1] == 2'b01); // 抓上升沿

// 2. 产生 1秒 闸门
reg [31:0] timer_cnt;
reg        update_flag;

always @(posedge sys_clk) begin
    if (!rst_n || !locked) begin
        timer_cnt <= 0;
        update_flag <= 0;
    end else begin
        if (timer_cnt >= CLK_FREQ - 1) begin
            timer_cnt <= 0;
            update_flag <= 1; // 1秒时间到
        end else begin
            timer_cnt <= timer_cnt + 1;
            update_flag <= 0;
        end
    end
end

// 3. 计数与锁存
reg [31:0] edge_cnt;

always @(posedge sys_clk) begin
    if (!rst_n || !locked) begin
        edge_cnt <= 0;
        freq_result <= 0;
    end else begin
        if (update_flag) begin
            freq_result <= edge_cnt; // 锁存这一秒的计数值
            edge_cnt <= 0;           // 清零，准备下一秒
        end else if (pos_edge) begin
            edge_cnt <= edge_cnt + 1; // 只有检测到边沿才+1
        end
    end
end

endmodule