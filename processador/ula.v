module ula (ulacode, AH, BB, data_out);

input [31:0] AH, BB;
input [5:0] ulacode;
output reg [31:0] data_out;

always @ (ulacode, AH, BB)
begin
case (ulacode)
//
6'b011000: data_out = AH;
//
6'b010100: data_out = BB;
//
6'b011010: data_out = ~AH;
//
6'b101100: data_out = ~BB;
//
6'b111100: data_out = AH + BB;
//
6'b111101: data_out = AH + BB + 1;
//
6'b111001: data_out = AH + 1;
//
6'b110101: data_out = BB + 1;
//
6'b111111: data_out = BB - AH;
//
6'b110110: data_out = BB - 1;
//
6'b111011: data_out = ~AH + 31'd1;
//
6'b001100: data_out = AH & BB;
//
6'b011100: data_out = AH | BB;
//
6'b010000: data_out = 32'd0;
//
6'b110001: data_out = 32'd1;
//
6'b110010: data_out = ~32'd1 + 32'd1;
//
default: data_out = BB;
endcase
end

endmodule