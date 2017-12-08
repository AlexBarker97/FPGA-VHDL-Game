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
// Additional Comments:
// Seeker 1 = Dark Green
// Seeker 2 = Light Green
// 
//////////////////////////////////////////////////////////////////////////////////
module game_top(
    input clk,
    input up,
    input down,
    input left,
    input right,
    input centre,
    input [2:0] sw,
    output [3:0]pix_r,
    output [3:0]pix_g,
    output [3:0]pix_b,
    output hsync,
    output vsync,
    output sega,
    output segb,
    output segc,
    output segd,
    output sege,
    output segf,
    output segg, 
    output [7:0] an
    );
    
    reg [10:0] randomCount_x;
    reg [9:0] randomCount_y;
    wire [10:0]curr_x;
    wire [9:0]curr_y;
    reg [20:0] count;
    reg bouncerclk;
    reg [2:0]speed;
    
    reg [7:0] characterSize;
    reg [10:0]characterPos_x;
    reg [9:0] characterPos_y;
    reg [10:0]foodPos_x;
    reg [9:0]foodPos_y;
    reg [10:0]seeker1Pos_x;
    reg [9:0]seeker1Pos_y;
    reg [10:0]seeker2Pos_x;
    reg [9:0]seeker2Pos_y;
    reg [10:0]linear1Pos_x;
    reg [9:0]linear1Pos_y;
    reg [10:0]linear2Pos_x;
    reg [9:0]linear2Pos_y;
    reg [10:0]bouncer1Pos_x;
    reg [9:0]bouncer1Pos_y;
    
    reg [7:0] initialcharacterSize=32;    
    reg [10:0]initialcharacterPos_x=720;
    reg [9:0] initialcharacterPos_y=450;
    reg [10:0]initialfoodPos_x=700;
    reg [9:0]initialfoodPos_y=800;
    reg [10:0]initialseeker1Pos_x=150;
    reg [9:0]initialseeker1Pos_y=0;
    reg [10:0]initialseeker2Pos_x=1250;
    reg [9:0]initialseeker2Pos_y=0;
    reg [10:0]initiallinear1Pos_x=350;
    reg [9:0]initiallinear1Pos_y=60;
    reg [10:0]initiallinear2Pos_x=1000;
    reg [9:0]initiallinear2Pos_y=839;
    reg [10:0]initialbouncer1Pos_x=1369;
    reg [9:0]initialbouncer1Pos_y=450;

    reg [7:0] score;
    reg [7:0] hiscore;
    wire clk106;
    reg slowclk;
    wire [3:0] draw_r;
    wire [3:0] draw_b;
    wire [3:0] draw_g;
    
    vga_out vga(.vsync(vsync), .hsync(hsync), .clk(clk106), .curr_x(curr_x), .curr_y(curr_y), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b), .draw_r(draw_r), .draw_g(draw_g), .draw_b(draw_b));
    draw_con draw(.bouncer1Pos_x(bouncer1Pos_x), .bouncer1Pos_y(bouncer1Pos_y), .score(score), .clk(clk), .r(draw_r), .g(draw_g), .b(draw_b), .linear2Pos_x(linear2Pos_x), .linear2Pos_y(linear2Pos_y), .linear1Pos_x(linear1Pos_x), .linear1Pos_y(linear1Pos_y), .seeker2Pos_x(seeker2Pos_x), .seeker2Pos_y(seeker2Pos_y), .seeker1Pos_x(seeker1Pos_x), .seeker1Pos_y(seeker1Pos_y), .characterPos_x(characterPos_x), .characterPos_y(characterPos_y), .foodPos_x(foodPos_x), .foodPos_y(foodPos_y), .characterSize(characterSize), .draw_x(curr_x), .draw_y(curr_y));
    sevenseginterface seg(.hiscore(hiscore), .score(score), .a(sega), .b(segb), .c(segc), .d(segd), .e(sege), .f(segf), .g(segg), .an(an), .clk(clk));
    
      clk_wiz_0 instance_name
       (
        // Clock out ports
        .clk_out1(clk106),     // output clk_out1
       // Clock in ports
        .clk_in1(clk));   
        
        initial
            begin
            characterPos_x = initialcharacterPos_x;
            characterPos_y = initialcharacterPos_y;
            characterSize = initialcharacterSize;
            foodPos_x = initialfoodPos_x;
            foodPos_y = initialfoodPos_y;
            seeker1Pos_x = initialseeker1Pos_x;
            seeker1Pos_y = initialseeker1Pos_y;
            seeker2Pos_x = initialseeker2Pos_x;
            seeker2Pos_y = initialseeker2Pos_y;
            linear1Pos_x = initiallinear1Pos_x;
            linear1Pos_y = initiallinear1Pos_y;
            linear2Pos_x = initiallinear2Pos_x;
            linear2Pos_y = initiallinear2Pos_y;
            bouncer1Pos_x <= initialbouncer1Pos_x;              
            bouncer1Pos_y <= initialbouncer1Pos_y;

            score = 0; //initial score printed to right side of SevenSeg(Disp1)
            hiscore = 0; //highscore only resetting on reporogram of board printed to left side of SevenSeg(Disp2)
            slowclk = 0; //determining refresh rate of checking for inputs
            bouncerclk = 0; //bouncer movement direction
            
            speed = 0; //initial diffiulty modifier
            end
        
        always@(posedge clk)
            begin
            count <= count +1;
            if(count == 833333)
                begin
                count <= 0;
                slowclk <= !slowclk;
                end
            end
            
        always@(posedge slowclk)
            begin
            randomCount_x <= randomCount_x + 17;
            if(randomCount_x > 1330)
                begin
                randomCount_x <= 0;
                end
            end
            
        always@(posedge slowclk)
            begin
            randomCount_y <= randomCount_y + 29;
            if(randomCount_y > 800)
                begin
                randomCount_y <= 0;            
                end
            end
            
         always@(posedge slowclk)
             begin
             if(sw[1] == 0  && sw[2] ==0)
                begin
                speed <= 0;
                end
             else
                begin
                if(sw[1] == 1  && sw[2] ==0)  
                    begin
                    speed <= 1;
                    end
                else
                    begin
                    if(sw[1] == 0  && sw[2] ==1)
                        begin
                        speed <= 2;
                        end
                    else
                        begin
                        speed<=3; 
                        end
                    end
                end
             if(centre && sw[0])
                begin
                characterPos_x = initialcharacterPos_x;
            characterPos_y = initialcharacterPos_y;
            foodPos_x = initialfoodPos_x;
            foodPos_y = initialfoodPos_y;
            seeker1Pos_x = initialseeker1Pos_x;
            seeker1Pos_y = initialseeker1Pos_y;
            seeker2Pos_x = initialseeker2Pos_x;
            seeker2Pos_y = initialseeker2Pos_y;
            linear1Pos_x = initiallinear1Pos_x;
            linear1Pos_y = initiallinear1Pos_y;
            linear2Pos_x = initiallinear2Pos_x;
            linear2Pos_y = initiallinear2Pos_y;
            bouncer1Pos_x <= initialbouncer1Pos_x;              
            bouncer1Pos_y <= initialbouncer1Pos_y;
            characterSize = initialcharacterSize;
            score = 0;
                end
             else
                begin   
                    
                if((foodPos_x-(8+(characterSize/2))<characterPos_x) && (characterPos_x<foodPos_x+(8+(characterSize/2))) && (foodPos_y-(8+(characterSize/2))<characterPos_y) && (characterPos_y<foodPos_y+(8+(characterSize/2))))
                    begin
                    score<=score+1;
                    if(score==hiscore)
                        begin
                        hiscore<=score+1;
                        end
                    foodPos_x <= 70 + randomCount_x;
                    foodPos_y <= 70 + randomCount_y;
                    characterSize <= characterSize +3;
                    end
                if((characterPos_x<(characterSize/2)+10) | (characterPos_x>(1429-(characterSize/2))) | (characterPos_y<(characterSize/2)+10) | (characterPos_y>(889-(characterSize/2))))
                    begin
                    characterPos_x = initialcharacterPos_x;
                    characterPos_y = initialcharacterPos_y;
                    foodPos_x = initialfoodPos_x;
                    foodPos_y = initialfoodPos_y;
                    seeker1Pos_x = initialseeker1Pos_x;
                    seeker1Pos_y = initialseeker1Pos_y;
                    seeker2Pos_x = initialseeker2Pos_x;
                    seeker2Pos_y = initialseeker2Pos_y;
                    linear1Pos_x = initiallinear1Pos_x;
                    linear1Pos_y = initiallinear1Pos_y;
                    linear2Pos_x = initiallinear2Pos_x;
                    linear2Pos_y = initiallinear2Pos_y;
                    bouncer1Pos_x <= initialbouncer1Pos_x;              
                    bouncer1Pos_y <= initialbouncer1Pos_y;
                    characterSize = initialcharacterSize;
                    score=0;
                    end  
                else 
                    begin
                    if(((seeker1Pos_x-(10+(characterSize/2))<characterPos_x) && (characterPos_x<seeker1Pos_x+(10+(characterSize/2))) && (seeker1Pos_y-(10+(characterSize/2))<characterPos_y) && (characterPos_y<seeker1Pos_y+(10+(characterSize/2)))) |
                     (((seeker2Pos_x-(10+(characterSize/2))<characterPos_x) && (characterPos_x<seeker2Pos_x+(10+(characterSize/2))) && (seeker2Pos_y-(10+(characterSize/2))<characterPos_y) && (characterPos_y<seeker2Pos_y+(10+(characterSize/2)))))|
                     ((linear1Pos_x-(16+(characterSize/2))<characterPos_x) && (characterPos_x<linear1Pos_x+(16+(characterSize/2))) && (linear1Pos_y-(50+(characterSize/2))<characterPos_y) && (characterPos_y<linear1Pos_y+(50+(characterSize/2))) && score>3) |
                     (((linear2Pos_x-(16+(characterSize/2))<characterPos_x) && (characterPos_x<linear2Pos_x+(16+(characterSize/2))) && (linear2Pos_y-(50+(characterSize/2))<characterPos_y) && (characterPos_y<linear2Pos_y+(50+(characterSize/2))) && score>3))|
                     ((bouncer1Pos_x-(60+(characterSize/2))<characterPos_x) && (characterPos_x<bouncer1Pos_x+(60+(characterSize/2))) && (bouncer1Pos_y-(5+(characterSize/2))<characterPos_y) && (characterPos_y<bouncer1Pos_y+(5+(characterSize/2))) && score>8))
                        begin
                        characterPos_x = initialcharacterPos_x;
                        characterPos_y = initialcharacterPos_y;
                        foodPos_x = initialfoodPos_x;
                        foodPos_y = initialfoodPos_y;
                        seeker1Pos_x = initialseeker1Pos_x;
                        seeker1Pos_y = initialseeker1Pos_y;
                        seeker2Pos_x = initialseeker2Pos_x;
                        seeker2Pos_y = initialseeker2Pos_y;
                        linear1Pos_x = initiallinear1Pos_x;
                        linear1Pos_y = initiallinear1Pos_y;
                        linear2Pos_x = initiallinear2Pos_x;
                        linear2Pos_y = initiallinear2Pos_y;
                        bouncer1Pos_x <= initialbouncer1Pos_x;              
                        bouncer1Pos_y <= initialbouncer1Pos_y;
                        characterSize = initialcharacterSize;
                        score = 0;
                        end
                    else
                        begin
                        if(((linear2Pos_x-(16+10)<seeker1Pos_x) && (seeker1Pos_x<linear2Pos_x+(16+10)) && (linear2Pos_y-(50+10)<seeker1Pos_y) && (seeker1Pos_y<linear2Pos_y+(50+10)) && score>3) | 
                        ((linear1Pos_x-(16+10)<seeker1Pos_x) && (seeker1Pos_x<linear1Pos_x+(16+10)) && (linear1Pos_y-(50+10)<seeker1Pos_y) && (seeker1Pos_y<linear1Pos_y+(50+10)) && score>3)|
                        ((bouncer1Pos_x-(60+10)<seeker1Pos_x) && (seeker1Pos_x<bouncer1Pos_x+(60+10)) && (bouncer1Pos_y-(5+10)<seeker1Pos_y) && (seeker1Pos_y<bouncer1Pos_y+(5+10)) && score>8))
                            begin
                            seeker1Pos_x=initialseeker1Pos_x;
                            seeker1Pos_y=initialseeker1Pos_y;
                            end
                        if(((linear2Pos_x-(16+10)<seeker2Pos_x) && (seeker2Pos_x<linear2Pos_x+(16+10)) && (linear2Pos_y-(50+10)<seeker2Pos_y) && (seeker2Pos_y<linear2Pos_y+(50+10)) && score>3) |
                         ((linear1Pos_x-(16+10)<seeker2Pos_x) && (seeker2Pos_x<linear1Pos_x+(16+10)) && (linear1Pos_y-(50+10)<seeker2Pos_y) && (seeker2Pos_y<linear1Pos_y+(50+10)) && score>3)|
                         ((bouncer1Pos_x-(60+10)<seeker2Pos_x) && (seeker2Pos_x<bouncer1Pos_x+(60+10)) && (bouncer1Pos_y-(5+10)<seeker2Pos_y) && (seeker2Pos_y<bouncer1Pos_y+(5+10)) && score>8))
                            begin
                            seeker2Pos_x=initialseeker2Pos_x;
                            seeker2Pos_y=initialseeker2Pos_y;
                            end
                           
                        else
                            begin
                            if(score>0)
                                begin
                                if((characterPos_x < seeker1Pos_x))
                                    begin
                                    seeker1Pos_x <= seeker1Pos_x - (1 + speed);
                                    end  
                                if((characterPos_x > seeker1Pos_x))
                                    begin
                                    seeker1Pos_x <= seeker1Pos_x + (1 + speed);
                                    end 
                                if(characterPos_y < seeker1Pos_y)
                                    begin
                                    seeker1Pos_y <= seeker1Pos_y - (1 + speed);
                                    end  
                                if(characterPos_y > seeker1Pos_y)
                                    begin
                                    seeker1Pos_y <= seeker1Pos_y + (1 + speed);
                                    end
                                end
                            if(score>5)
                                begin    
                                if(characterPos_x < seeker2Pos_x)
                                    begin
                                    seeker2Pos_x <= seeker2Pos_x - (2 + speed);
                                    end  
                                if(characterPos_x > seeker2Pos_x)
                                    begin
                                    seeker2Pos_x <= seeker2Pos_x + (2 + speed);
                                    end 
                                if(characterPos_y < seeker2Pos_y)
                                    begin
                                    seeker2Pos_y <= seeker2Pos_y - (2 + speed);
                                    end  
                                if(characterPos_y > seeker2Pos_y)
                                    begin
                                    seeker2Pos_y <= seeker2Pos_y + (2 + speed);
                                    end
                                end
                            if(score>3)
                                begin
                                if(linear1Pos_y < 890)
                                    begin
                                    linear1Pos_y <= linear1Pos_y + (8 + (2 * speed));
                                    end  
                                else
                                    begin
                                    linear1Pos_y <= initiallinear1Pos_y;
                                    end
                                if(linear2Pos_y > 10)
                                    begin
                                    linear2Pos_y <= linear2Pos_y - (8 + (2 * speed));
                                    end  
                                else
                                    begin
                                    linear2Pos_y <= initiallinear2Pos_y;
                                    end
                                end
                            if(score>8)
                                begin
                                if(bouncerclk==0)
                                    begin
                                    bouncer1Pos_x<=bouncer1Pos_x - (8 + (2 * speed));
                                    if(bouncer1Pos_x<70)
                                        begin
                                        bouncerclk<=1;
                                        end
                                    end
                                else
                                    begin
                                    bouncer1Pos_x<=bouncer1Pos_x + (8 + (2 * speed));
                                    if(bouncer1Pos_x>1369)
                                        begin
                                        bouncerclk<=0;
                                        end
                                    end
                                end
                            if(up)
                                begin
                                characterPos_y<= characterPos_y - 6;
                                end
                            if(down)
                                begin
                                characterPos_y<= characterPos_y + 6;
                                end
                            if(left)
                                begin
                                characterPos_x<= characterPos_x - 6;
                                end
                            if(right)
                                begin
                                characterPos_x<= characterPos_x + 6;
                                end
                            end
                        end       
                    end
                end 
            end
endmodule
