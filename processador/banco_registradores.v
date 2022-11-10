module banco_registradores (clock, bbus_sig, cbus_sig, cbus_in, ram_data,
ram_addr, ram_wr_enable, bbus_out, h_out, mar_data, pc_data, mbr_data);
										
input clock;
input [3:0] bbus_sig;
input [9:0] cbus_sig;
input [31:0] cbus_in;
input [31:0] ram_data;
input [3:0] ram_addr;
input [1:0] ram_wr_enable;
output reg [31:0] bbus_out;
output [31:0] h_out;

output [31:0] mar_data; // data write
output [3:0] pc_data; // ram address
output [1:0] mbr_data; // ram write read enable

wire [15:0] decod_sig;

wire [31:0] b_bus_handler [5:0];

decod4_16 decod(.clock(clock), .b(bbus_sig), .s(decod_sig));

register MAR(
.clock(clock),
.data_in(cbus_in), // data to write on ram
.in_enable(cbus_sig[0]),
.out_enable(1'b1), // always writing (depends on wr sig)
.data_out(mar_data) //write on ram
);

register MDR(
.clock(clock),
.data_in(ram_data), // data read from ram
.in_enable(cbus_sig[1]),
.out_enable(decod_sig[1]),
.data_out(b_bus_handler[0]) // data read for b bus
);

register PC(
.clock(clock),
.data_in(ram_addr), // receive ram address
.in_enable(cbus_sig[2]),
.out_enable(1'b1), // always sending ram addres
.data_out(pc_data) // ram adress for ram
);
register MBR(
.clock(clock),
.data_in(ram_wr_enable), // receive ram wr signal
.in_enable(cbus_sig[3]),
.out_enable(1'b1), // always sending wr signal
.data_out(mbr_data) // ram wr signal
);

register SP(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[4]),
.out_enable(decod_sig[4]),
.data_out(b_bus_handler[1])
);

register LV(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[5]),
.out_enable(decod_sig[5]),
.data_out(b_bus_handler[2])
);

register CPP(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[6]),
.out_enable(decod_sig[6]),
.data_out(b_bus_handler[3])
);

register TOS(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[7]),
.out_enable(decod_sig[7]),
.data_out(b_bus_handler[4])
);

register OPC(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[8]),
.out_enable(decod_sig[8]),
.data_out(b_bus_handler[5])
);

register H(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[9]),
.out_enable(1'b1), // always enabled to ula
.data_out(h_out)
);

always @ (b_bus_handler, decod_sig)
begin
if (b_bus_handler[0] !== 32'bz)
	bbus_out = b_bus_handler[0];
else if (b_bus_handler[1] !== 32'bz)
	bbus_out = b_bus_handler[1];
else if (b_bus_handler[2] !== 32'bz)
	bbus_out = b_bus_handler[2];
else if (b_bus_handler[3] !== 32'bz)
	bbus_out = b_bus_handler[3];
else if (b_bus_handler[4] !== 32'bz)
	bbus_out = b_bus_handler[4];
else if (b_bus_handler[5] !== 32'bz)
	bbus_out = b_bus_handler[5];
else
	bbus_out = 32'bz;
end

endmodule