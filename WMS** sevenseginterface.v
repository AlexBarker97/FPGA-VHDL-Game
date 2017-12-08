`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2017 15:09:20
// Design Name: 
// Module Name: sevenseginterface
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


module sevenseginterface(
        input clk,
        input [7:0] score, hiscore,
        output a, b, c, d, e, f, g,
        output [7:0] an
    );

    wire led_clk;
    reg [3:0] dig_sel;
    reg [3:0] dig0=0;
    reg [3:0] dig1=0;
    reg [3:0] dig2=0;
    reg [3:0] dig3=0;
    reg [3:0] dig4=0;
    reg [3:0] dig5=0;
    reg [3:0] dig6=0;
    reg [3:0] dig7=0;
    
    
    always@*
        begin
        dig0<=score%10;
        dig1<=(score-(score%10))/10;
        dig4<=hiscore%10;
        dig5<=(hiscore-(hiscore%10))/10;
        end
    
    reg [28:0] clk_count = 11'd0;
    
    always @(posedge clk)
        clk_count <= clk_count + 1'b1;
    
    assign led_clk = clk_count[16];
    
    
    reg [7:0] led_strobe = 8'b11111110;
    always @(posedge led_clk)
        led_strobe <= {led_strobe[6:0],led_strobe[7]};
        assign an = led_strobe;
    
    reg [2:0] led_index = 3'd0;
    always @(posedge led_clk)
        led_index <= led_index + 1'b1;
    
    always@*    
    case (led_index)
        3'd0: dig_sel = dig0;
        3'd1: dig_sel = dig1;
        3'd2: dig_sel = dig2;
        3'd3: dig_sel = dig3;
        3'd4: dig_sel = dig4;
        3'd5: dig_sel = dig5;
        3'd6: dig_sel = dig6;
        3'd7: dig_sel = dig7;
    endcase        
    
    sevenseg M1 (.num(dig_sel), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g));

endmodule
