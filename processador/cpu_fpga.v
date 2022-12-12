module cpu_fpga (clk, s1, s2, s3, s4, s5, s6, s7, s8, s9,
led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12);

input clk, s1, s2, s3, s4, s5, s6, s7, s8, s9;
output led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12;

reg [27:0] mir;
wire [31:0] on_c, on_b, on_ram_read, on_ram_write;

cpu dut (.clock(clk), .mir(mir), 
.on_c(on_c), .on_b(on_b), .on_ram_read(on_ram_read), .on_ram_write(on_ram_write));

always @ (*)
begin
case({s1, s2, s3, s4, s5, s6, s7, s8, s9})
9'b100000000: mir = 28'b00_110001_00_0000_0000001000_0000;
9'b010000000: mir = 28'b00_000000_10_0001_0000000101_0000;
9'b001000000: mir = 28'b00_000000_01_0001_0000000111_0000;
9'b000100000: mir = 28'b00_110101_00_0000_1000001000_0001;
9'b000010000: mir = 28'b00_000000_10_0010_0000000101_0000;
9'b000001000: mir = 28'b00_000000_01_0010_0000000111_0000;
9'b000000100: mir = 28'b00_111100_00_0000_0000001000_0001;
9'b000000010: mir = 28'b00_000000_10_0100_0000000101_0000;
9'b000000001: mir = 28'b00_000000_01_0100_0000000111_0000;
default: mir = 28'b0;
endcase
end

assign led1 = on_c[2];
assign led2 = on_c[1];
assign led3 = on_c[0];

assign led4 = on_b[2];
assign led5 = on_b[1];
assign led6 = on_b[0];

assign led7 = on_ram_read[2];
assign led8 = on_ram_read[1];
assign led9 = on_ram_read[0];

assign led10 = on_ram_write[2];
assign led11 = on_ram_write[1];
assign led12 = on_ram_write[0];

endmodule