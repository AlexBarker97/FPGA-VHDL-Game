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
    input [10:0]characterPos_x,
    input [9:0]characterPos_y,
    input [10:0]foodPos_x,
    input [9:0]foodPos_y,
    input [10:0]draw_x,
    input [9:0]draw_y,
    output reg[3:0]r,
    output reg[3:0]g,
    output reg[3:0]b
    );
    
    reg [3:0]bg_r = 0;
    reg [3:0]bg_g = 0;
    reg [3:0]bg_b = 0;
    reg [3:0]cha_r = 0;
    reg [3:0]cha_g = 0;
    reg [3:0]cha_b = 0;
    reg [3:0]food_r = 0;
    reg [3:0]food_g = 0;
    reg [3:0]food_b = 0;
    
    
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
            if (((characterPos_x<draw_x) & (draw_x<characterPos_x+32)) & ((characterPos_y<draw_y) & (draw_y<characterPos_y+32)))
                begin
                cha_r <= 4'b1111;
                cha_g <= 4'b0000;
                cha_b <= 4'b0000;
                end
            else
                begin
                cha_r <= 4'b0000;
                cha_g <= 4'b0000;
                cha_b <= 4'b0000;
                end
            end
        always@*
            begin
            if (((foodPos_x<draw_x) & (draw_x<foodPos_x+16)) & ((foodPos_y<draw_y) & (draw_y<foodPos_y+16)))
                begin
                food_r <= 4'b1111;
                food_g <= 4'b1111;
                food_b <= 4'b0000;
                end
            else
                begin
                food_r <= 4'b0000;
                food_g <= 4'b0000;
                food_b <= 4'b0000;
                end
            end
        always@*
            begin
            if (cha_r == 0 && cha_g == 0 && cha_b == 0 && food_r==0 && food_g==0 && food_b==0)
                begin
                r <= bg_r;
                g <= bg_g;
                b <= bg_b;
                end
            else
                begin
                if(food_r==0 && food_r==0 && food_r==0)
                    begin
                    r <= food_r;
                    g <= food_g;
                    b <= food_b;
                    end
                else
                    begin
                    r <= cha_r;
                    g <= cha_g;
                    b <= cha_b;
                    end
                end
            end
endmodule
