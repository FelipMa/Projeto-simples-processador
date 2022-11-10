module cpu (clock, mir, out_c, out_b, out_ram_read, out_ram_write);

input clock;
input [27:0] mir; // 00_000000_00_0000_0000000000_0000 - 2shif + 6ula + 2wr + 4addr + 10c + 4b = 28
output reg [31:0] out_c, out_b, out_ram_read, out_ram_write;


wire [31:0] dataout_ula;
wire [31:0] b_bus;
wire [31:0] c_bus;
wire [31:0] h_bus;
wire [3:0] ram_address;
wire [31:0] ram_data_write;
wire [31:0] ram_data_read;
wire [1:0] ram_wr_sig;


banco_registradores registers(
 .clock(clock),
 .bbus_sig(mir[3:0]),
 .cbus_sig(mir[13:4]),
 .cbus_in(c_bus),
 .ram_data(ram_data_read),
 .ram_addr(mir[17:14]),
 .ram_wr_enable(mir[19:18]),
 .bbus_out(b_bus),
 .h_out(h_bus), 
 .mar_data(ram_data_write),
 .pc_data(ram_address),
 .mbr_data(ram_wr_sig)
);

ram ram_mem(
.address_write(ram_address),
.data_write(ram_data_write),
.write_enable(ram_wr_sig[1]),

.address_read(ram_address),
.data_read(ram_data_read),
.read_enable(ram_wr_sig[0])
);

ula alu(
 .ulacode(mir[25:20]),
 .AH(h_bus),
 .BB(b_bus),
 .data_out(dataout_ula)
);

shifter shifter(
.control(mir[27:26]),
.data(dataout_ula),
.data_out(c_bus)
);

always @ (clock)
begin
out_c <= c_bus;
out_b <= b_bus;
out_ram_read <= ram_data_read;
out_ram_write <= ram_data_write;
end

endmodule