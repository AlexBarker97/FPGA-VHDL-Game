`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2017 17:34:50
// Design Name: 
// Module Name: draw_con
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


module draw_con(
    input [10:0]blkpos_x,
    input [9:0]blkpos_y,
    input [10:0]draw_x,
    input [9:0]draw_y,
    output reg[3:0]r,
    output reg[3:0]g,
    output reg[3:0]b
    );
    
    reg [3:0]bg_r = 0;
    reg [3:0]bg_g = 0;
    reg [3:0]bg_b = 0;
    reg [3:0]blk_r = 0;
    reg [3:0]blk_g = 0;
    reg [3:0]blk_b = 0;
    
    always@*
            begin
            if ((draw_x<11) | (draw_x>1428) | (draw_y<11) | (draw_y>888))
                begin
                bg_r <= 4'b0000;
                bg_g <= 4'b1111;
                bg_b <= 4'b0000;
                end
            else
                begin
                bg_r <= 4'b0000;
                bg_g <= 4'b0000;
                bg_b <= 4'b1011;
                end
            end
        always@*
            begin
            if (((blkpos_x<draw_x) & (draw_x<blkpos_x+32)) & ((blkpos_y<draw_y) & (draw_y<blkpos_y+32)))
                begin
                blk_r <= 4'b1111;
                blk_g <= 4'b0000;
                blk_b <= 4'b0000;
                end
            else
                begin
                blk_r <= 4'b0000;
                blk_g <= 4'b0000;
                blk_b <= 4'b0000;
                end
            end
        always@*
            begin
            if (blk_r == 0 && blk_g == 0 && blk_b == 0)
                begin
                r <= bg_r;
                g <= bg_g;
                b <= bg_b;
                end
            else
                begin
                r <= blk_r;
                g <= blk_g;
                b <= blk_b;
                end
            end
endmodule
