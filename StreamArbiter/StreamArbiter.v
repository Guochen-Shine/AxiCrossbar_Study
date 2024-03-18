module StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [19:0]   io_inputs_0_payload_addr,
  input      [3:0]    io_inputs_0_payload_id,
  input      [7:0]    io_inputs_0_payload_len,
  input      [2:0]    io_inputs_0_payload_size,
  input      [1:0]    io_inputs_0_payload_burst,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [19:0]   io_inputs_1_payload_addr,
  input      [3:0]    io_inputs_1_payload_id,
  input      [7:0]    io_inputs_1_payload_len,
  input      [2:0]    io_inputs_1_payload_size,
  input      [1:0]    io_inputs_1_payload_burst,
  input               io_inputs_2_valid,
  output              io_inputs_2_ready,
  input      [19:0]   io_inputs_2_payload_addr,
  input      [3:0]    io_inputs_2_payload_id,
  input      [7:0]    io_inputs_2_payload_len,
  input      [2:0]    io_inputs_2_payload_size,
  input      [1:0]    io_inputs_2_payload_burst,
  output              io_output_valid,
  input               io_output_ready,
  output     [19:0]   io_output_payload_addr,
  output     [3:0]    io_output_payload_id,
  output     [7:0]    io_output_payload_len,
  output     [2:0]    io_output_payload_size,
  output     [1:0]    io_output_payload_burst,
  output     [1:0]    io_chosen,
  output     [2:0]    io_chosenOH,
  input               clk,
  input               reset
);

  wire       [5:0]    tmp_tmp_maskProposal_0_2;
  wire       [5:0]    tmp_tmp_maskProposal_0_2_1;
  wire       [2:0]    tmp_tmp_maskProposal_0_2_2;
  reg        [19:0]   tmp_io_output_payload_addr_1;
  reg        [3:0]    tmp_io_output_payload_id;
  reg        [7:0]    tmp_io_output_payload_len;
  reg        [2:0]    tmp_io_output_payload_size;
  reg        [1:0]    tmp_io_output_payload_burst;
  reg                 locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  wire                maskProposal_2;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire       [2:0]    tmp_maskProposal_0;
  wire       [5:0]    tmp_maskProposal_0_1;
  wire       [5:0]    tmp_maskProposal_0_2;
  wire       [2:0]    tmp_maskProposal_0_3;
  wire                io_output_fire;
  wire       [1:0]    tmp_io_output_payload_addr;
  wire                tmp_io_chosen;
  wire                tmp_io_chosen_1;

  assign tmp_tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 - tmp_tmp_maskProposal_0_2_1);
  assign tmp_tmp_maskProposal_0_2_2 = {maskLocked_1,{maskLocked_0,maskLocked_2}};
  assign tmp_tmp_maskProposal_0_2_1 = {3'd0, tmp_tmp_maskProposal_0_2_2};
  always @(*) begin
    case(tmp_io_output_payload_addr)
      2'b00 : begin
        tmp_io_output_payload_addr_1 = io_inputs_0_payload_addr;
        tmp_io_output_payload_id = io_inputs_0_payload_id;
        tmp_io_output_payload_len = io_inputs_0_payload_len;
        tmp_io_output_payload_size = io_inputs_0_payload_size;
        tmp_io_output_payload_burst = io_inputs_0_payload_burst;
      end
      2'b01 : begin
        tmp_io_output_payload_addr_1 = io_inputs_1_payload_addr;
        tmp_io_output_payload_id = io_inputs_1_payload_id;
        tmp_io_output_payload_len = io_inputs_1_payload_len;
        tmp_io_output_payload_size = io_inputs_1_payload_size;
        tmp_io_output_payload_burst = io_inputs_1_payload_burst;
      end
      default : begin
        tmp_io_output_payload_addr_1 = io_inputs_2_payload_addr;
        tmp_io_output_payload_id = io_inputs_2_payload_id;
        tmp_io_output_payload_len = io_inputs_2_payload_len;
        tmp_io_output_payload_size = io_inputs_2_payload_size;
        tmp_io_output_payload_burst = io_inputs_2_payload_burst;
      end
    endcase
  end

  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2);
  assign tmp_maskProposal_0 = {io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}};
  assign tmp_maskProposal_0_1 = {tmp_maskProposal_0,tmp_maskProposal_0};
  assign tmp_maskProposal_0_2 = (tmp_maskProposal_0_1 & (~ tmp_tmp_maskProposal_0_2));
  assign tmp_maskProposal_0_3 = (tmp_maskProposal_0_2[5 : 3] | tmp_maskProposal_0_2[2 : 0]);
  assign maskProposal_0 = tmp_maskProposal_0_3[0];
  assign maskProposal_1 = tmp_maskProposal_0_3[1];
  assign maskProposal_2 = tmp_maskProposal_0_3[2];
  assign io_output_fire = (io_output_valid && io_output_ready);
  assign io_output_valid = (((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2));
  assign tmp_io_output_payload_addr = {maskRouted_2,maskRouted_1};
  assign io_output_payload_addr = tmp_io_output_payload_addr_1;
  assign io_output_payload_id = tmp_io_output_payload_id;
  assign io_output_payload_len = tmp_io_output_payload_len;
  assign io_output_payload_size = tmp_io_output_payload_size;
  assign io_output_payload_burst = tmp_io_output_payload_burst;
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready);
  assign io_chosenOH = {maskRouted_2,{maskRouted_1,maskRouted_0}};
  assign tmp_io_chosen = io_chosenOH[1];
  assign tmp_io_chosen_1 = io_chosenOH[2];
  assign io_chosen = {tmp_io_chosen_1,tmp_io_chosen};
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      locked <= 1'b0;
      maskLocked_0 <= 1'b0;
      maskLocked_1 <= 1'b0;
      maskLocked_2 <= 1'b1;
    end else begin
      if(io_output_valid) begin
        maskLocked_0 <= maskRouted_0;
        maskLocked_1 <= maskRouted_1;
        maskLocked_2 <= maskRouted_2;
      end
      if(io_output_valid) begin
        locked <= 1'b1;
      end
      if(io_output_fire) begin
        locked <= 1'b0;
      end
    end
  end


endmodule



