`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 07:32:57 PM
// Design Name: 
// Module Name: HammingDecoder
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


module HammingDecoderSEC8(
    input logic clk,
    input logic [11:0] cw,
    output logic [7:0] dw,
    output logic errorDetected
    );
    
    logic [7:0] d;
    logic [3:0] c;
    logic [3:0] s;
    
    logic [11:0] errorCorrect;
    logic [11:0] corrected;
    
    assign d = {cw[11:8], cw[6:4], cw[2]};
    assign c = {cw[7], cw[3], cw[1:0]};
    
    assign s[0] =  d[0] ^ d[1] ^ d[3] ^ d[4] ^ d[6] ^ c[0];
    assign s[1] =  d[0] ^ d[2] ^ d[3] ^ d[5] ^ d[6] ^ c[1];
    assign s[2] =  d[1] ^ d[2] ^ d[3] ^ d[7] ^ c[2];
    assign s[3] =  d[4] ^ d[5] ^ d[6] ^ d[7] ^ c[3];
    
    assign errorDetected = (s == 4'H0) ? 1'b0 : 1'b1;
    
    always_comb begin
        case(s)
            4'H0 : errorCorrect = 12'b000000000000;
            4'H1 : errorCorrect = 12'b000000000001;
            4'H2 : errorCorrect = 12'b000000000010;
            4'H3 : errorCorrect = 12'b000000000100;
            4'H4 : errorCorrect = 12'b000000001000;
            4'H5 : errorCorrect = 12'b000000010000;
            4'H6 : errorCorrect = 12'b000000100000;
            4'H7 : errorCorrect = 12'b000001000000;
            4'H8 : errorCorrect = 12'b000010000000;
            4'H9 : errorCorrect = 12'b000100000000;
            4'HA : errorCorrect = 12'b001000000000;
            4'HB : errorCorrect = 12'b010000000000;
            4'HC : errorCorrect = 12'b100000000000;
            default : errorCorrect = 12'b000000000000;
        endcase 
    end
    
    assign corrected = cw ^ errorCorrect;
    
    always @(posedge clk) begin
        dw = {corrected[11:8], corrected[6:4], corrected[2]};
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 07:32:57 PM
// Design Name: 
// Module Name: HammingDecoder
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


module HammingDecoderSEC8(
    input logic clk,
    input logic [11:0] cw,
    output logic [7:0] dw,
    output logic errorDetected
    );
    
    logic [7:0] d;
    logic [3:0] c;
    logic [3:0] s;
    
    logic [11:0] errorCorrect;
    logic [11:0] corrected;
    
    assign d = {cw[11:8], cw[6:4], cw[2]};
    assign c = {cw[7], cw[3], cw[1:0]};
    
    assign s[0] =  d[0] ^ d[1] ^ d[3] ^ d[4] ^ d[6] ^ c[0];
    assign s[1] =  d[0] ^ d[2] ^ d[3] ^ d[5] ^ d[6] ^ c[1];
    assign s[2] =  d[1] ^ d[2] ^ d[3] ^ d[7] ^ c[2];
    assign s[3] =  d[4] ^ d[5] ^ d[6] ^ d[7] ^ c[3];
    
    assign errorDetected = (s == 4'H0) ? 1'b0 : 1'b1;
    
    always_comb begin
        case(s)
            4'H0 : errorCorrect = 12'b000000000000;
            4'H1 : errorCorrect = 12'b000000000001;
            4'H2 : errorCorrect = 12'b000000000010;
            4'H3 : errorCorrect = 12'b000000000100;
            4'H4 : errorCorrect = 12'b000000001000;
            4'H5 : errorCorrect = 12'b000000010000;
            4'H6 : errorCorrect = 12'b000000100000;
            4'H7 : errorCorrect = 12'b000001000000;
            4'H8 : errorCorrect = 12'b000010000000;
            4'H9 : errorCorrect = 12'b000100000000;
            4'HA : errorCorrect = 12'b001000000000;
            4'HB : errorCorrect = 12'b010000000000;
            4'HC : errorCorrect = 12'b100000000000;
            default : errorCorrect = 12'b000000000000;
        endcase 
    end
    
    assign corrected = cw ^ errorCorrect;
    
    always @(posedge clk) begin
        dw = {corrected[11:8], corrected[6:4], corrected[2]};
    end
    
endmodule


module HammingDecoderSECDED8(
    input logic clk,
    input logic [12:0] cw,
    output logic [7:0] dw,
    output logic errorDetected,
    output logic errorCorrected
    );
    
    logic gp;
    logic ed; 
    
    assign gp = cw[0] ^ cw[1] ^ cw[2] ^ cw[3] ^ cw[4] ^ cw[5] ^ cw[6] ^ cw[7] ^ cw[8] ^ cw[9] ^ cw[10] ^ cw[11] ^ cw[12];
    
    assign errorCorrected = gp & ed;
    assign errorDetected = ed;
    
    HammingDecoderSEC8 hd (clk, cw[11:0], dw, ed);
    
endmodule

