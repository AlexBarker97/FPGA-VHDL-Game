`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2017 17:23:52
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
    input up,
    input down,
    input left,
    input right,
    input centre,
    output [3:0]pix_r,
    output [3:0]pix_g,
    output [3:0]pix_b,
    output hsync,
    output vsync
    );
    
    
    wire [10:0]curr_x;
    wire [9:0]curr_y;
    reg [10:0] blkpos_x;
    reg [9:0] blkpos_y;
    reg [20:0] count;
    wire clk106;
    reg [20:0]slowclk=0;
    wire [3:0] draw_r;
    wire [3:0] draw_b;
    wire [3:0] draw_g;
    
    vga_out vga(.vsync(vsync), .hsync(hsync), .clk(clk106), .curr_x(curr_x), .curr_y(curr_y), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .draw_r(draw_r), .draw_g(draw_g), .draw_b(draw_b));
    draw_con draw(.r(draw_r), .g(draw_g), .b(draw_b), .blkpos_x(blkpos_x), .blkpos_y(blkpos_y), .draw_x(curr_x), .draw_y(curr_y));
    
      clk_wiz_0 instance_name
       (
        // Clock out ports
        .clk_out1(clk106),     // output clk_out1
       // Clock in ports
        .clk_in1(clk));   
        
        always@(posedge clk)
            begin
            count <= count +1;
            if(count==1666666)
                begin
                count=0;
                slowclk<= !slowclk;
                end
            end
            
         always@(posedge slowclk)
             begin
             if(centre)
                begin
                blkpos_x <=700;
                blkpos_y <=450;
                end
             if(up)
                begin
                blkpos_y<= blkpos_y -4;
                end
             if(down)
                begin
                blkpos_y<= blkpos_y +4;
                end
            if(left)
                begin
                blkpos_x<= blkpos_x -4;
                end
            if(right)
                begin
                blkpos_x<= blkpos_x +4;
                end
            if((blkpos_x<11) | (blkpos_x>1396) | (blkpos_y<11) | (blkpos_y>854))
                begin
                blkpos_x <=700;
                blkpos_y <=450;
                end
            end   
endmodule
