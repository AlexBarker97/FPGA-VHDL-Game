`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2017 15:06:32
// Design Name: 
// Module Name: game_top
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
module game_top(
    input clk,
    input [11:0] switch,
    output reg [3:0] pix_r,
    output reg [3:0] pix_g,
    output reg [3:0] pix_b,
    output hsync,
    output vsync,
    output curr_x,
    output curr_y
    );
    vga_out vga(.clk(clk), .switch(switch), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y));
    wire pixclk;

  clk_wiz_0 instance_name(.clk_out1(pixclk), .clk_in1(clk)); 

    always@*
        begin
        if ((curr_x > 520) & (curr_x < 920) & (curr_y > 300) & (curr_y < 600))
            pix_r = switch[3:0];
            pix_g = switch[7:4];
            pix_b = switch[11:8];
        end
endmodule
