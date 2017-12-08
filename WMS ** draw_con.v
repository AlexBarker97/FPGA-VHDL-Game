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
    input clk,
    input [10:0]characterPos_x,
    input [9:0]characterPos_y,
    input [10:0]foodPos_x,
    input [9:0]foodPos_y,
    input [10:0]seeker1Pos_x,
    input [9:0]seeker1Pos_y,
    input [10:0]seeker2Pos_x,
    input [9:0]seeker2Pos_y,
    input [10:0]linear1Pos_x,
    input [9:0]linear1Pos_y,
    input [10:0]linear2Pos_x,
    input [9:0]linear2Pos_y,
    input [10:0]bouncer1Pos_x,
    input [9:0]bouncer1Pos_y,
    input [10:0]draw_x,
    input [9:0]draw_y,
    input [7:0]characterSize,
    input [7:0] score,
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
    reg [3:0]seeker1_r = 0;
    reg [3:0]seeker1_g = 0;
    reg [3:0]seeker1_b = 0;
    reg [3:0]seeker2_r = 0;
    reg [3:0]seeker2_g = 0;
    reg [3:0]seeker2_b = 0;
    reg [3:0]linear1_r = 0;
    reg [3:0]linear1_g = 0;
    reg [3:0]linear1_b = 0;
    reg [3:0]linear2_r = 0;
    reg [3:0]linear2_g = 0;
    reg [3:0]linear2_b = 0;
    reg [3:0]bouncer1_r = 0;
    reg [3:0]bouncer1_g = 0;
    reg [3:0]bouncer1_b = 0;
    
    reg [7:0]address = 1;
    wire [11:0]spritebit;
    reg [11:0]address2 = 1;
    wire [11:0]spritebit2;
    reg [11:0]address3 = 1;
    wire [11:0]spritebit3;
    
    dist_mem_gen_0 sprite0
    (
    .a(address),
    .spo(spritebit)
    );
    
    dist_mem_gen_1 sprite2
    (
    .a(address2),
    .spo(spritebit2)
    );
    
    dist_mem_gen_1 sprite3
    (
    .a(address3),
    .spo(spritebit3)
    );
    
always@(posedge clk)
        begin
        if ((draw_x<11) | (draw_x>1428) | (draw_y<11) | (draw_y>888))
            begin
            bg_r <= 4'b0001;
            bg_g <= 4'b0000;
            bg_b <= 4'b0101;
            end
        else
            begin
            bg_r <= 4'b0011;
            bg_g <= 4'b0010;
            bg_b <= 4'b1010;
            end
            
        if (((characterPos_x-(characterSize/2)<draw_x) & (draw_x<(characterPos_x+(characterSize/2)))) & ((characterPos_y-(characterSize/2)<draw_y) & (draw_y<(characterPos_y+(characterSize/2)))))
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
            
        if (((foodPos_x-8<draw_x) & (draw_x<foodPos_x+8)) & ((foodPos_y-8<draw_y) & (draw_y<foodPos_y+8)))
            begin
            address <= 16*(draw_y-(foodPos_y-8))+(draw_x-(foodPos_x-8));
            food_b <= spritebit[3:0];
            food_g <= spritebit[7:4];
            food_r <= spritebit[11:8];
            end
        else
            begin
            food_r <= 4'b0000;
            food_g <= 4'b0000;
            food_b <= 4'b0000;
            end
            
        if (((seeker1Pos_x-10<draw_x) & (draw_x<seeker1Pos_x+10)) & ((seeker1Pos_y-10<draw_y) & (draw_y<seeker1Pos_y+10)))
            begin
            seeker1_r <= 4'b0000;
            seeker1_g <= 4'b1010;
            seeker1_b <= 4'b0000;
            end
        else
            begin
            seeker1_r <= 4'b0000;
            seeker1_g <= 4'b0000;
            seeker1_b <= 4'b0000;
            end
            
        if (((seeker2Pos_x-10<draw_x) & (draw_x<seeker2Pos_x+10)) & ((seeker2Pos_y-10<draw_y) & (draw_y<seeker2Pos_y+10)))
            begin
            seeker2_r <= 4'b0000;
            seeker2_g <= 4'b1111;
            seeker2_b <= 4'b0000;
            end
        else
            begin
            seeker2_r <= 4'b0000;
            seeker2_g <= 4'b0000;
            seeker2_b <= 4'b0000;
            end
            
        if (((linear1Pos_x-16<draw_x) & (draw_x<linear1Pos_x+16)) & ((linear1Pos_y-50<draw_y) & (draw_y<linear1Pos_y+50) & score>3))
            begin
            address2 <= 32*(draw_y-(linear1Pos_y-50))+(draw_x-(linear1Pos_x-16));
            linear1_b <= spritebit2[3:0];
            linear1_g <= spritebit2[7:4];
            linear1_r <= spritebit2[11:8];
            end
        else
            begin
            linear1_r <= 4'b0000;
            linear1_g <= 4'b0000;
            linear1_b <= 4'b0000;
            end
            
        if (((linear2Pos_x-16<draw_x) & (draw_x<linear2Pos_x+16)) & ((linear2Pos_y-50<draw_y) & (draw_y<linear2Pos_y+50) & score>3))
            begin
            address3 <= 32*(draw_y-(linear2Pos_y-50))+(draw_x-(linear2Pos_x-16));
            linear2_b <= spritebit3[3:0];
            linear2_g <= spritebit3[7:4];
            linear2_r <= spritebit3[11:8];
            end
        else
            begin
            linear2_r <= 4'b0000;
            linear2_g <= 4'b0000;
            linear2_b <= 4'b0000;
            end
            
        if (((bouncer1Pos_x-60<draw_x) & (draw_x<bouncer1Pos_x+60)) & ((bouncer1Pos_y-5<draw_y) & (draw_y<bouncer1Pos_y+5) & score>8))
            begin
            bouncer1_r <= 4'b0111;
            bouncer1_g <= 4'b1001;
            bouncer1_b <= 4'b1111;
            end
        else
            begin
            bouncer1_r <= 4'b0000;
            bouncer1_g <= 4'b0000;
            bouncer1_b <= 4'b0000;
            end
            
        if (cha_r == 0 && cha_g == 0 && cha_b == 0 && food_r==0 && food_g==0 && food_b==0 && seeker1_r==0 && seeker1_g==0 && seeker1_b==0 && seeker2_r==0 && seeker2_g==0 && seeker2_b==0 && linear1_r==0 && linear1_g==0 && linear1_b==0 && linear2_r==0 && linear2_g==0 && linear2_b==0 && bouncer1_r==0 && bouncer1_g==0 && bouncer1_b==0)
            begin
            r <= bg_r;
            g <= bg_g;
            b <= bg_b;
            end
        else
            begin
            if(cha_r==0 && cha_g==0 && cha_b==0 && seeker1_r==0 && seeker1_g==0 && seeker1_b==0 && seeker2_r==0 && seeker2_g==0 && seeker2_b==0 && linear1_r==0 && linear1_g==0 && linear1_b==0 && linear2_r==0 && linear2_g==0 && linear2_b==0 && bouncer1_r==0 && bouncer1_g==0 && bouncer1_b==0)
                begin
                r <= food_r;
                g <= food_g;
                b <= food_b;
                end
            else
                begin
                if(cha_r==0 && cha_g==0 && cha_b==0 && seeker2_r==0 && seeker2_g==0 && seeker2_b==0 && linear1_r==0 && linear1_g==0 && linear1_b==0 && linear2_r==0 && linear2_g==0 && linear2_b==0 && bouncer1_r==0 && bouncer1_g==0 && bouncer1_b==0)
                    begin
                    r <= seeker1_r;
                    g <= seeker1_g;
                    b <= seeker1_b;
                    end
                 else
                    begin
                    if(cha_r==0 && cha_g==0 && cha_b==0 && linear1_r==0 && linear1_g==0 && linear1_b==0 && linear2_r==0 && linear2_g==0 && linear2_b==0 && bouncer1_r==0 && bouncer1_g==0 && bouncer1_b==0)
                        begin
                        r <= seeker2_r;
                        g <= seeker2_g;
                        b <= seeker2_b;
                        end
                    else
                        begin
                        if(cha_r==0 && cha_g==0 && cha_b==0 && linear2_r==0 && linear2_g==0 && linear2_b==0 && bouncer1_r==0 && bouncer1_g==0 && bouncer1_b==0)
                            begin
                            r <= linear1_r;
                            g <= linear1_g;
                            b <= linear1_b;
                            end
                        else
                            begin
                            if(cha_r==0 && cha_g==0 && cha_b==0 && bouncer1_r==0 && bouncer1_g==0 && bouncer1_b==0)
                                begin
                                r <= linear2_r;
                                g <= linear2_g;
                                b <= linear2_b;
                                end
                            else
                                begin
                                if(cha_r==0 && cha_g==0 && cha_b==0)
                                    begin
                                    r <= bouncer1_r;
                                    g <= bouncer1_g;
                                    b <= bouncer1_b;
                                    end
                                else
                                    begin
                                    r <= cha_r;
                                    g <= cha_g;
                                    b <= cha_b;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
endmodule
