`timescale 1ns / 1ps

module duty(
    input              clk_400m,   // 参考时钟
    input              rst_n,      // 复位
    input              signal_in,  // 输入脉冲
    output reg [31:0]  high_cnt_r_out,
    output reg [31:0]  low_cnt_r_out
);

    // 1. 三级同步，彻底消除亚稳态并提取边沿
    reg [2:0] sig_sync;
    always @(posedge clk_400m) begin
        sig_sync <= {sig_sync[1:0], signal_in};
    end

    wire pos_edge = (sig_sync[2:1] == 2'b01);
    wire neg_edge = (sig_sync[2:1] == 2'b10);
    wire is_high  = sig_sync[1]; // 当前同步后的电平状态

    // 2. 核心计数器
    reg [31:0] h_cnt_tmp;
    reg [31:0] l_cnt_tmp;
    
    always @(posedge clk_400m or negedge rst_n) begin
        if (!rst_n) begin
            h_cnt_tmp <= 32'd0;
            l_cnt_tmp <= 32'd0;
            high_cnt_r_out <= 32'd0;
            low_cnt_r_out  <= 32'd0;
        end else begin
            if (pos_edge) begin
                // 【上升沿到了】：说明刚结束了一个低电平周期，且一个完整周期结束了
                high_cnt_r_out <= h_cnt_tmp;
                low_cnt_r_out  <= l_cnt_tmp;
                h_cnt_tmp <= 32'd1;  // 开始计新的高电平
                l_cnt_tmp <= 32'd0;
            end 
            else if (neg_edge) begin
                // 【下降沿到了】：说明高电平结束了
                l_cnt_tmp <= 32'd1;  // 开始计新的低电平
            end 
            else begin
                // 【维持阶段】：根据电平直接累加，没有任何状态切换开销
                if (is_high) 
                    h_cnt_tmp <= h_cnt_tmp + 1'b1;
                else 
                    l_cnt_tmp <= l_cnt_tmp + 1'b1;
            end

            // 3. 超时自动归零 (处理 0% 或 100% 占空比)
            // 如果单次计数超过 1 秒 (400M 次)，强制更新并复位，防止数据卡死
            if (h_cnt_tmp >= 400_000_000) begin
                high_cnt_r_out <= 400_000_000;
                low_cnt_r_out  <= 32'd0;
                h_cnt_tmp      <= 32'd0;
            end
            if (l_cnt_tmp >= 400_000_000) begin
                high_cnt_r_out <= 32'd0;
                low_cnt_r_out  <= 400_000_000;
                l_cnt_tmp      <= 32'd0;
            end
        end
    end

endmodule