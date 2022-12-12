`timescale 1ns/10ps 

module cpu_fpga_tb;

reg clk, s1, s2, s3, s4, s5, s6, s7, s8, s9;
wire led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12;

cpu_fpga dut (clk, s1, s2, s3, s4, s5, s6, s7, s8, s9,
led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12);

initial begin
clk = 1'b0;
s1 = 1'b0;
s2 = 1'b0;
s3 = 1'b0;
s4 = 1'b0;
s5 = 1'b0;
s6 = 1'b0;
s7 = 1'b0;
s8 = 1'b0;
s9 = 1'b0;

$display("save 1 on mbr");
#10
s1 = 1'b1;

toggleClock;

displayOut;

$display("write mbr(1) on memory addr 0001");
#10
s2 = 1'b1;
s1 = 1'b0;

toggleClock;

displayOut;

$display("read memory addr 0001 (1), data goes to mdr after two clocks");
#10
s3 = 1'b1;
s2 = 1'b0;

toggleClock;
toggleClock;

displayOut;

$display("enable mdr(1) to b_bus, increment, and save on H and mbr registers, after two clocks");
#10
s4 = 1'b1;
s3 = 1'b0;

toggleClock;
toggleClock;

displayOut;

$display("write mbr(2) on memory addr 0010");
#10
s5 = 1'b1;
s4 = 1'b0;

toggleClock;

displayOut;

$display("read memory addr 0010 (2), data goes to mdr after two clocks");
#10
s6 = 1'b1;
s5 = 1'b0;

toggleClock;
toggleClock;

displayOut;

$display("enable mdr(2) to b_bus, perform H(2) + mdr(2), and save on mbr, after two clocks");
#10
s7 = 1'b1;
s6 = 1'b0;

toggleClock;
toggleClock;

displayOut;

$display("write mbr(4) on memory addr 0100");
#10
s8 = 1'b1;
s7 = 1'b0;

toggleClock;

displayOut;

$display("read memory addr 0100 (4), data goes to mdr after two clocks");
#10
s9 = 1'b1;
s8 = 1'b0;

toggleClock;
toggleClock;

displayOut;

end

task displayOut;
begin
#1 $display("led1 = %0d - led2 = %0d - led3 = %0d - led4 = %0d - led5 = %0d - led6 = %0d - led7 = %0d - led8 = %0d - led9 = %0d - led10 = %0d - led11 = %0d - led12 = %0d",
led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11, led12);
#1 $display("");
end
endtask

task toggleClock;
begin
#5 clk = ~clk;
#5 clk = ~clk;
end
endtask

endmodule