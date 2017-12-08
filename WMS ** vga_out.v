`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2017 14:21:52
// Design Name: 
// Module Name: vga_out
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


module vga_out(
    input clk,
    input [3:0] draw_r,
    input [3:0] draw_g,
    input [3:0] draw_b,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output hsync,
    output vsync,
    output reg [10:0]curr_x,
    output reg [9:0]curr_y
    );
  
  reg [10:0] hcount =0;
  reg [9:0] vcount =0;
  reg [3:0] red;
  reg [3:0] green;
  reg [3:0] blue;
 
  always @(posedge clk)
    begin
    if(hcount==1903)
        begin
        hcount<=0;
        if(vcount==931)
            begin
            vcount<=0;
            end
        else
            begin
            vcount<=vcount+1;
            end
        end
    else
        begin
        hcount<=hcount+1;
        end
        if((383<hcount) & (hcount<1824) & (30<vcount) & (vcount<931))
            begin
            curr_x<=hcount-383;
            curr_y<=vcount-30;
            end
  end
 
assign hsync=(hcount<152)? 0:1;
assign vsync=(vcount<3)? 1:0;

assign pix_r=((383<hcount) & (hcount<1824) & (30<vcount) & (vcount<931))? red:0;
assign pix_g=((383<hcount) & (hcount<1824) & (30<vcount) & (vcount<931))? green:0;
assign pix_b=((383<hcount) & (hcount<1824) & (30<vcount) & (vcount<931))? blue:0;
  
always @ *
    begin  
    red<=draw_r;
    green<=draw_g;
    blue<=draw_b;
    end    

endmodule
