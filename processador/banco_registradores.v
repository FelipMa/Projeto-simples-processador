module banco_registradores (clock, bbus_sig, cbus_sig, cbus_in, ram_data,
ram_addr, ram_wr_enable, bbus_out, h_out, mar_data, pc_data, mbr_data);
										
input clock;
input [3:0] bbus_sig;
input [9:0] cbus_sig;
input [31:0] cbus_in;
input [31:0] ram_data;
input [3:0] ram_addr;
input [1:0] ram_wr_enable;
output [31:0] bbus_out;
output [31:0] h_out;

output [3:0] mar_data; // ram addr
output [1:0] pc_data; // ram write read enable
output [31:0] mbr_data; // data write

wire [15:0] decod_sig;

wire [31:0] b_bus_handler [5:0];

decod4_16 decod(.clock(clock), .b(bbus_sig), .s(decod_sig));

register MAR(
.clock(clock),
.data_in(ram_addr), // receive ram address
.in_enable(cbus_sig[0]),
.out_enable(1'b1), // always sending ram addres
.data_out(mar_data) // ram adress for ram
);

register MDR(
.clock(clock),
.data_in(ram_data), // data read from ram
.in_enable(cbus_sig[1]),
.out_enable(decod_sig[1]),
.data_out(bbus_out) // data read for b bus
);

register PC(
.clock(clock),
.data_in(ram_wr_enable), // receive ram wr signal
.in_enable(cbus_sig[2]),
.out_enable(1'b1), // always sending wr signal
.data_out(pc_data) // ram wr signal
);
register MBR(
.clock(clock),
.data_in(cbus_in), // data to write on ram
.in_enable(cbus_sig[3]),
.out_enable(1'b1), // always writing (depends on wr sig)
.data_out(mbr_data) //write on ram
);

register SP(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[4]),
.out_enable(decod_sig[4]),
.data_out(bbus_out)
);

register LV(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[5]),
.out_enable(decod_sig[5]),
.data_out(bbus_out)
);

register CPP(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[6]),
.out_enable(decod_sig[6]),
.data_out(bbus_out)
);

register TOS(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[7]),
.out_enable(decod_sig[7]),
.data_out(bbus_out)
);

register OPC(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[8]),
.out_enable(decod_sig[8]),
.data_out(bbus_out)
);

register H(
.clock(clock),
.data_in(cbus_in),
.in_enable(cbus_sig[9]),
.out_enable(1'b1), // always enabled to ula
.data_out(h_out)
);

endmodule