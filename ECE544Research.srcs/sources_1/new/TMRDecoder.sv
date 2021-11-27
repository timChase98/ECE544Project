`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 02:41:33 PM
// Design Name: 
// Module Name: TMREncoder
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


module TMRDecoder(
    input logic clk,
    input logic [23:0] cw,
    output logic [7:0] dw,
    output logic errorDetected
    );
    
    logic [7:0] tmrVote;
    logic [7:0] tmrErrorDetect;
    
    genvar i;
    generate
        for(i=0; i<8; i++) begin
            assign tmrVote[i] = cw[i] & cw[i+8] | cw[i] & cw[i+16] | cw[i+8] & cw[i+16];
            assign tmrErrorDetect[i] = cw[i] & cw[i+8] & cw[i+16] | ~cw[i] & ~cw[i+8] & ~cw[i+16];
            
        end
    endgenerate
    
    assign errorDetected = (tmrErrorDetect == 0) ? 1'b0 : 1'b1;
    
    always @(posedge clk) begin
        dw <= tmrVote;
    end
endmodule
