`timescale 1ns / 1ps

module Time_Interval_Measure(
    input         sys_clk,
    input         rst_n,
    input         signal_start,
    input         signal_stop,
    
    output [31:0] interval_ticks
);

    reg [2:0] sync_start, sync_stop;
    
    always @(posedge sys_clk) begin
        if(!rst_n) begin
            sync_start <= 3'b0;
            sync_stop  <= 3'b0;
        end else begin
            sync_start <= {sync_start[1:0], signal_start};
            sync_stop  <= {sync_stop[1:0], signal_stop};
        end
    end

    wire pos_start = (sync_start[2:1] == 2'b01);
    wire pos_stop  = (sync_stop[2:1] == 2'b01);

    reg measure_pulse;

    always @(posedge sys_clk or negedge rst_n) begin
        if(!rst_n) begin
            measure_pulse <= 1'b0;
        end else begin
            if (pos_start) 
                measure_pulse <= 1'b1;
            else if (pos_stop) 
                measure_pulse <= 1'b0;
        end
    end

    wire [31:0] dummy_low;
    
    duty u_interval_counter (
        .clk_400m       (sys_clk),
        .rst_n          (rst_n),
        .signal_in      (measure_pulse),
        
        .high_cnt_r_out (interval_ticks),
        .low_cnt_r_out  (dummy_low)
    );

endmodule