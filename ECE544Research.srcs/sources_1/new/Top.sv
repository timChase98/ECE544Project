//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/04/2020 09:37:14 PM
// Design Name:
// Module Name: Top
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


module Top
    #(parameter CWSIZE=12)(
    input logic CLK100MHZ,
    input logic [15:0] sw,
    input logic [4:0] btn,
    output logic [15:0] led,
    output logic [1:0] rgbR,
    output logic [1:0] rgbG,
    output logic rgbB,
    output logic [7:0] an,
    output logic [7:0] ca
    );

    logic [53:0] clockDiv;
    logic [31:0] sevenSegValue;

    logic [7:0] inputVal;
    logic [7:0] outputVal;
    logic [CWSIZE:0] codeword;
    logic [CWSIZE:0] damagedCodeword;

    logic errorDetected;
    logic errorCorrected;

    assign led = sw;
    assign rgbR = {rgbEN & errorDetected, rgbEN & errorDetected & ~errorCorrected};
    assign rgbG = { rgbEN & ~errorDetected, rgbEN & errorCorrected};
    assign rgbB = 0;
    assign rgbEN = clockDiv[15] & clockDiv[16]; // 25% pwm to dim led

    assign inputVal = sw[7:0];

    assign damagedCodeword = codeword ^ sw[15:8];

//    assign sevenSegValue = {outputVal, damagedCodeword}; // TMR
//    assign sevenSegValue = {inputVal, outputVal, 4'H0, damagedCodeword}; // Hamming SEC
    assign sevenSegValue = {inputVal, outputVal, 3'H0, damagedCodeword}; // Hamming DED

    SevenSegmentController ssc (sevenSegValue, clockDiv[21], clockDiv[16], an, ca);
    
//    HammingEncoderSEC8 cwg (clockDiv[15], inputVal, codeword);
//    HammingDecoderSEC8 cwd (clockDiv[15], damagedCodeword, outputVal, errorDetected);
    
    HammingEncoderSECDED8 cwg (clockDiv[15], inputVal, codeword);
    HammingDecoderSECDED8 cwd (clockDiv[15], damagedCodeword, outputVal, errorDetected, errorCorrected);
    
//    TMREncoder cwg (clockDiv[15], inputVal, codeword);
//    TMRDecoder cwd (clockDiv[15], damagedCodeword, outputVal, errorDetected);
    
    always @ ( posedge CLK100MHZ ) begin
        clockDiv = clockDiv + 1;
    end

endmodule
