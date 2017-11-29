`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2017 17:36:44
// Design Name: 
// Module Name: drawcon
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


module drawcon(
    input [10:0]blkpos_x,
    input [9:0]blkpos_y,
    input [10:0]draw_x,
    input [9:0]draw_y,
    output reg [3:0] r,
    output reg [3:0] g,
    output reg [3:0] b
    );
    
    reg bg_r = 0;
    reg bg_g = 0;
    reg bg_b = 0;
    reg blk_r = 0;
    reg blk_g = 0;
    reg blk_b = 0;
    
    always@*
        begin
        if ((draw_x<11) | (draw_x>1428) | (draw_y<11) | (draw_y>888))
            begin
            r <= 4'b1111;
            g <= 4'b1111;
            b <= 4'b1111;
            end
        else
            begin
            r <= 4'b0000;
            g <= 4'b1000;
            b <= 4'b1011;
            end
        end
    always@*
        begin
        if (((blkpos_x<draw_x) & (draw_x<blkpos_x+32)) & ((blkpos_y<draw_y) & (draw_y<blkpos_y+32)))
            begin
            blk_r <= 4'b1011;
            blk_g <= 4'b1011;
            blk_b <= 4'b1011;
            end
        else
            begin
            blk_r <= 4'b0011;
            blk_g <= 4'b0011;
            blk_b <= 4'b0011;
            end
        end
    always@*
        begin
        if (blk_r == 0)
            begin
            r <= bg_r;
            end
        else
            begin
            r <= blk_r;
            end
        if (blk_g == 0)
            begin
            g <= bg_g;
            end
        else
            begin
            g <= blk_g;
            end
        if (blk_b == 0)
            begin
            b <= bg_b;
            end
        else
            begin
            b <= blk_b;
            end
        end
endmodule
