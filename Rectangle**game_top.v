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
    input left,
    input right,
    input up,
    input down,
    input centre,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output hsync,
    output vsync,
    input curr_x,
    input curr_y
    );

wire clk_out106;
wire clk_out60;
wire draw_r;
wire draw_g;
wire draw_b;
reg [20:0] count = 0;
reg slowclk = 0;
reg blkpos_x = 0;
reg blkpos_y = 0;

    vga_out vga(.clk(clk_out106), .draw_r(draw_r), .draw_g(draw_g), .draw_b(draw_b), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y));
    drawcon draw(.r(draw_r),.g(draw_g),.b(draw_b),.draw_x(curr_x),.draw_y(curr_y),.blkpos_x(blkpos_x),.blkpos_y(blkpos_y));

always@(posedge clk)
    begin
    count <= count + 1;
    if (count == 1666666)
        begin
        count <= 0;
        slowclk <= !slowclk;
        end
    end
    
always@(posedge slowclk)
    begin
    if (centre)
        blkpos_x <= 700;
        blkpos_y <= 450;
    if (up)
        blkpos_y <= blkpos_y + 4;
    if (down)
        blkpos_y <= blkpos_y - 4;
    if (left)
        blkpos_x <= blkpos_x - 4;
    if (right)
        blkpos_x <= blkpos_x + 4;
    if ((blkpos_x<11) | (blkpos_x>1396) | (blkpos_y<11) | (blkpos_y>854))
        blkpos_x <= 700;
        blkpos_y <= 450;
    end
        
clk_wiz_0 inst
(
// Clock out ports  
.clk_out1(clk_out106),
// Clock in ports
.clk_in1(clk)
);
  
endmodule
