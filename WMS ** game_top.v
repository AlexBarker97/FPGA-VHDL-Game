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
    reg [10:0]characterPos_x=700;
    reg [9:0] characterPos_y=450;
    reg [10:0]foodPos_x=50;
    reg [9:0]foodPos_y=50;
    reg [20:0] count;
    reg [7:0] characterSize=32;
    wire clk106;
    reg [20:0]slowclk=0;
    wire [3:0] draw_r;
    wire [3:0] draw_b;
    wire [3:0] draw_g;
    
    vga_out vga(.vsync(vsync), .hsync(hsync), .clk(clk106), .curr_x(curr_x), .curr_y(curr_y), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .draw_r(draw_r), .draw_g(draw_g), .draw_b(draw_b));
    draw_con draw(.r(draw_r), .g(draw_g), .b(draw_b), .characterPos_x(characterPos_x), .characterPos_y(characterPos_y), .foodPos_x(foodPos_x), .foodPos_y(foodPos_y), .characterSize(characterSize), .draw_x(curr_x), .draw_y(curr_y));
    
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
                characterPos_x <=700;
                characterPos_y <=450;
                characterSize <=32;
                foodPos_x<=100;
                foodPos_y<=100;
                end
             if(up)
                begin
                characterPos_y<= characterPos_y -5;
                end
             if(down)
                begin
                characterPos_y<= characterPos_y +5;
                end
            if(left)
                begin
                characterPos_x<= characterPos_x -5;
                end
            if(right)
                begin
                characterPos_x<= characterPos_x +5;
                end
            if((characterPos_x<(characterSize/2)+10) | (characterPos_x>(1429-(characterSize/2))) | (characterPos_y<(characterSize/2)+10) | (characterPos_y>(889-(characterSize/2))))
                begin
                characterPos_x <=700;
                characterPos_y <=450;
                characterSize <=32;
                foodPos_x<=100;
                                foodPos_y<=100;
                end
            if((foodPos_x-(8+(characterSize/2))<characterPos_x) && (characterPos_x<foodPos_x+(8+(characterSize/2))) && (foodPos_y-(8+(characterSize/2))<characterPos_y) && (characterPos_y<foodPos_y+(8+(characterSize/2))))
                begin
                foodPos_x<=30+$urandom_9;
                foodPos_y<=30+$urandom_8;
                characterSize<=characterSize+10;
                end
            end 
        
        
endmodule
