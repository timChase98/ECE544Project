`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 07:13:51 PM
// Design Name: 
// Module Name: HammingEncoder
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


module HammingEncoderSEC8(
    input logic clk,
    input logic [7:0] d,
    output logic [11:0]dataOut
    );
    
    logic [3:0] c; // check bits
    assign c[0] =  d[0] ^ d[1] ^ d[3] ^ d[4] ^ d[6];
    assign c[1] =  d[0] ^ d[2] ^ d[3] ^ d[5] ^ d[6];
    assign c[2] =  d[1] ^ d[2] ^ d[3] ^ d[7];
    assign c[3] =  d[4] ^ d[5] ^ d[6] ^ d[7];
    
    always @(posedge clk) begin
        dataOut = {d[7:4],c[3], d[3:1], c[2], d[0], c[1:0]};
    end
endmodule

module HammingEncoderSECDED8(
    input logic clk,
    input logic [7:0] d,
    output logic [13:0]dataOut
    );
  
    logic c;
    logic [11:0] cw; 
    HammingEncoderSEC8 he (clk, d, cw);
    
    assign c = cw[0] ^ cw[1] ^ cw[2] ^ cw[3] ^ cw[4] ^ cw[5] ^ cw[6] ^ cw[7] ^ cw[8] ^ cw[9] ^ cw[10] ^ cw[11];
    
    always @(posedge clk) begin
        dataOut = {c, cw};
    end
endmodule
