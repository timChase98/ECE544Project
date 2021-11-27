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


module TMREncoder(
    input logic clk,
    input logic [7:0] d,
    output logic [23:0]dataOut
    );
    
    always @(posedge clk) begin
        dataOut = {d,d,d};
    end
endmodule
