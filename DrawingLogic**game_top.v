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
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output reg [3:0] draw_r,
    output reg [3:0] draw_g,
    output reg [3:0] draw_b,
    output hsync,
    output vsync,
    input curr_x,
    input curr_y
    );
    vga_out vga(.clk(clk), .switch(switch), .draw_r(draw_r), .draw_g(draw_g), .draw_b(draw_b), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync));
    drawcon draw(.r(pix_r),.g(pix_g),.b(pix_b),.draw_x(curr_x),.draw_y(curr_y));

wire pixclk;
      
    clk_wiz_0 instance_name
  (
  // Clock out ports
  .clk_out1(pixclk),
 // Clock in ports
  .clk_in1(clk)
  );
  
endmodule
