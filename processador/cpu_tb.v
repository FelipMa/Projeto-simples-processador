`timescale 1ns/10ps 

module cpu_tb;

reg clock;
reg [27:0] mir;
wire [31:0] out_c, out_b, out_ram_read, out_ram_write;

cpu dut (.clock(clock), .mir(mir), 
.out_c(out_c), .out_b(out_b), .out_ram_read(out_ram_read), .out_ram_write(out_ram_write));

initial
begin
clock = 1'b0;
mir = 28'd00;

$display("write 1 on mar and write mar(1) on addr 0001");
#10
mir = 28'b00_110001_10_0001_0000001101_0000; // mbr and pc must be enabled

toggleClock;
toggleClock;
toggleClock;

displayOut;

$display("read addr 0001, write on mdr, enable mdr(1) to b_bus, ula add 1 to b_bus, send to c_bus(2) and write on h and mar");
#10
mir = 28'b00_110101_01_0001_1000001111_0001; // mbr and pc must be enabled

toggleClock;
toggleClock;
toggleClock;

displayOut;

$display("write mar(2) on addr 0010");
#10
mir = 28'b00_000000_10_0010_0000001100_0000; // mbr and pc must be enabled

toggleClock;
toggleClock;
toggleClock;

displayOut;

$display("enable mdr(1) to b_bus, perform mdr(1) + h(2), write c_bus(3) on mar");
#10
mir = 28'b00_111100_00_0000_0000000001_0001; //

toggleClock;
toggleClock;
toggleClock;

displayOut;

$display("write mar on addr 0011");
#10
mir = 28'b00_000000_10_0011_0000001100_0000; // mbr and pc must be enabled

toggleClock;
toggleClock;
toggleClock;

displayOut;

end

task displayOut;
begin
#1 $display("out_c = %0d -- out_b = %0d -- out_ram_read = %0d -- out_ram_write = %0d",
out_c, out_b, out_ram_read, out_ram_write);
#1 $display("");
end
endtask

task toggleClock;
begin
#5 clock = ~clock;
#5 clock = ~clock;
end
endtask

endmodule
