module repetition_in_asserts(input bit clk);

  default clocking @(posedge clk);
  endclocking


  parameter enum { CONSECUTIVE, GOTO } repetition_kind = `REPETITION_KIND;


  if (repetition_kind == CONSECUTIVE) begin: consecutive

    bit start;
    bit busy;

    assert property (start |=> busy [*5]);

    // Make the traces more interesting
    assume property (start |=> busy [*3]);

  end
  if (repetition_kind == GOTO) begin: goto

    bit req;
    bit grant;
    bit busy;

    assert property (req ##1 grant [->1] |=> busy);

    // Make the traces more interesting
    assume property (req |-> !grant [*3]);

  end

endmodule
