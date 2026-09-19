// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg  [1:0] t_sel;
  wire [7:0] t_dout;

  // TODO: instantiate DUT here
  lut dut (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut);
    end
  end

  initial begin
    // TODO: apply different input combinations
    t_sel = 2'b00;
    #5 t_sel = 2'b01;
    #5 t_sel = 2'b10;
    #5 t_sel = 2'b11;
    #5 $finish;
  end

  initial
     $monitor($time, " SEL=%b | DOUT=%b", t_sel, t_dout); // change as required

endmodule
