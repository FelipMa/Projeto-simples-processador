module shifter(control, data, data_out);

input [1:0] control;
input [31:0] data;
output reg [31:0] data_out;

always @ (control, data)
begin
case (control)
2'b10: data_out = data << 8; //shift left logical
2'b01: data_out = data >>> 1; //shift right arithmetic
default: data_out = data;
endcase
end
endmodule