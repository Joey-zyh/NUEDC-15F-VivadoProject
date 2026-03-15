set_property IOSTANDARD LVCMOS33 [get_ports signal_in]
set_property PACKAGE_PIN W30 [get_ports signal_in]
set_property IOSTANDARD LVCMOS33 [get_ports signal_in2]
set_property PACKAGE_PIN W29 [get_ports signal_in2]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets signal_in_IBUF]

# ============================================================
# ZYNQ7035 LCD 约束文件 (ST7789)
# ============================================================

# ------------------------------------------------------------
# 1. SPI 接口信号 (SCL/SDA)
# ------------------------------------------------------------

# [SCL] SPI 时钟 -> AC23
set_property PACKAGE_PIN AC23 [get_ports SPI_0_0_sck_io]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_sck_io]

# [SDA/MOSI] SPI 数据输出 -> AC22
set_property PACKAGE_PIN AC22 [get_ports SPI_0_0_io0_io]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_io0_io]

# ------------------------------------------------------------
# ⚠️ 必须处理的未用 SPI 引脚
# 即使屏幕不用，Vivado 也要求这些端口必须有物理引脚，否则报错。
# 请在原理图上随便找两个没用的引脚填在这里。
# ------------------------------------------------------------

# [MISO] SPI 数据输入 (屏幕不需要，但必须分配)
set_property PACKAGE_PIN AA20 [get_ports SPI_0_0_io1_io]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_io1_io]

# [SS] SPI 硬件片选 (我们用 GPIO 做 CS，但这个硬件信号必须分配)
set_property PACKAGE_PIN Y20 [get_ports SPI_0_0_ss_io]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_ss_io]


# ------------------------------------------------------------
# 2. GPIO 控制信号 (RES, DC, CS, BLK)
# 对应 EMIO GPIO Width = 4
# 顺序对应 lcd.h 中的逻辑: 0->RES, 1->DC, 2->CS, 3->BLK
# ------------------------------------------------------------

# [GPIO 0] -> RES (复位) -> AE20
set_property PACKAGE_PIN AE20 [get_ports {GPIO_0_0_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GPIO_0_0_tri_io[0]}]

# [GPIO 1] -> DC (命令/数据) -> AD20
set_property PACKAGE_PIN AD20 [get_ports {GPIO_0_0_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GPIO_0_0_tri_io[1]}]

# [GPIO 2] -> CS (片选) -> AA19
set_property PACKAGE_PIN AA19 [get_ports {GPIO_0_0_tri_io[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GPIO_0_0_tri_io[2]}]

# [GPIO 3] -> BLK (背光) -> AA18
set_property PACKAGE_PIN AA18 [get_ports {GPIO_0_0_tri_io[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GPIO_0_0_tri_io[3]}]

# ------------------------------------------------------------
# 3. 废弃/未使用的 SPI 信号处理 (必须分配物理引脚)
# ------------------------------------------------------------

# [SS1] 硬件片选1 (ss1) - 多余的信号
set_property PACKAGE_PIN AC16 [get_ports SPI_0_0_ss1_o]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_ss1_o]

# [SS2] 硬件片选2 (ss2) - 多余的信号
set_property PACKAGE_PIN AC17 [get_ports SPI_0_0_ss2_o]
set_property IOSTANDARD LVCMOS33 [get_ports SPI_0_0_ss2_o]