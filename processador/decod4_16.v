module decod4_16 (clock, b, s);

input clock;
input [3:0] b;
output reg [15:0] s;

always @(posedge clock)
begin
case (b)
	4'b0000: s <= 16'b0000000000000001;
	4'b0001: s <= 16'b0000000000000010;
	4'b0010: s <= 16'b0000000000000100;
	4'b0011: s <= 16'b0000000000001000;
	4'b0100: s <= 16'b0000000000010000;
	4'b0101: s <= 16'b0000000000100000;
	4'b0110: s <= 16'b0000000001000000;
	4'b0111: s <= 16'b0000000010000000;
	4'b1000: s <= 16'b0000000100000000;
	4'b1001: s <= 16'b0000001000000000;
	default: s <= 16'b0000000000000000;
endcase
end

endmodule