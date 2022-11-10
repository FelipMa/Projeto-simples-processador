module register(clock, data_in, in_enable, out_enable, data_out);

input clock;
input [31:0] data_in;
input in_enable;
input out_enable;
output reg [31:0] data_out;

reg [31:0] data;

always @ (posedge clock)
begin
	if (in_enable)
		data <= data_in;
end

always @ (out_enable, data)
begin
	if (out_enable)
		data_out = data;
	else
		data_out = 32'bz;
end

endmodule