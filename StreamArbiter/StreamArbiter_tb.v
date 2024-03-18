module StreamArbiter_tb;
reg               io_inputs_0_valid;
wire              io_inputs_0_ready;
reg      [19:0]   io_inputs_0_payload_addr;
reg      [3:0]    io_inputs_0_payload_id;
reg      [7:0]    io_inputs_0_payload_len;
reg      [2:0]    io_inputs_0_payload_size;
reg      [1:0]    io_inputs_0_payload_burst;
reg               io_inputs_1_valid;
wire              io_inputs_1_ready;
reg      [19:0]   io_inputs_1_payload_addr;
reg      [3:0]    io_inputs_1_payload_id;
reg      [7:0]    io_inputs_1_payload_len;
reg      [2:0]    io_inputs_1_payload_size;
reg      [1:0]    io_inputs_1_payload_burst;
reg               io_inputs_2_valid;
wire              io_inputs_2_ready;
reg      [19:0]   io_inputs_2_payload_addr;
reg      [3:0]    io_inputs_2_payload_id;
reg      [7:0]    io_inputs_2_payload_len;
reg      [2:0]    io_inputs_2_payload_size;
reg      [1:0]    io_inputs_2_payload_burst;
wire              io_output_valid;
reg               io_output_ready;
wire     [19:0]   io_output_payload_addr;
wire     [3:0]    io_output_payload_id;
wire     [7:0]    io_output_payload_len;
wire     [2:0]    io_output_payload_size;
wire     [1:0]    io_output_payload_burst;
wire     [1:0]    io_chosen;
wire     [2:0]    io_chosenOH;
reg               clk;
reg               reset;

wire fire0 = io_inputs_0_valid && io_inputs_0_ready;
wire fire1 = io_inputs_1_valid && io_inputs_1_ready;
wire fire2 = io_inputs_2_valid && io_inputs_2_ready;
wire fire  = io_output_valid && io_output_ready;

initial begin
   clk = 1;
   reset = 1;
   io_output_ready = 0;
   #60 reset = 0; 
   #200 io_output_ready <=  1;
   #200 io_output_ready <=  1;
   #200 io_output_ready <=  1;
   #1000 $finish;
end

always #10 clk = ~clk;

initial begin
 #60;
  io_inputs_0_valid <= 1;
  io_inputs_1_valid <= 1;
  io_inputs_2_valid <= 1;
end

always @(posedge clk or posedge reset) begin
    if(fire0) io_inputs_0_valid <= 0;
    if(fire1) io_inputs_1_valid <= 0;
    if(fire2) io_inputs_2_valid <= 0;
    if(fire) io_output_ready <= 0;
end
initial begin
        io_inputs_0_payload_addr = 19'b0;
        io_inputs_0_payload_id = 3'b0;
        io_inputs_0_payload_len = 'd255;
        io_inputs_0_payload_size = 'd2;
        io_inputs_0_payload_burst = 'd1;

        io_inputs_1_payload_addr = 19'b0;
        io_inputs_1_payload_id = 3'd1;
        io_inputs_1_payload_len = 'd255;
        io_inputs_1_payload_size = 'd2;
        io_inputs_1_payload_burst = 'd1;
        
        io_inputs_2_payload_addr = 19'b0;
        io_inputs_2_payload_id = 3'd2;
        io_inputs_2_payload_len = 'd255;
        io_inputs_2_payload_size = 'd2;
        io_inputs_2_payload_burst = 'd1;
   end
  
StreamArbiter u_StreamArbiter(
	.io_inputs_0_valid         	( io_inputs_0_valid          ),
	.io_inputs_0_ready         	( io_inputs_0_ready          ),
	.io_inputs_0_payload_addr  	( io_inputs_0_payload_addr   ),
	.io_inputs_0_payload_id    	( io_inputs_0_payload_id     ),
	.io_inputs_0_payload_len   	( io_inputs_0_payload_len    ),
	.io_inputs_0_payload_size  	( io_inputs_0_payload_size   ),
	.io_inputs_0_payload_burst 	( io_inputs_0_payload_burst  ),
	.io_inputs_1_valid         	( io_inputs_1_valid          ),
	.io_inputs_1_ready         	( io_inputs_1_ready          ),
	.io_inputs_1_payload_addr  	( io_inputs_1_payload_addr   ),
	.io_inputs_1_payload_id    	( io_inputs_1_payload_id     ),
	.io_inputs_1_payload_len   	( io_inputs_1_payload_len    ),
	.io_inputs_1_payload_size  	( io_inputs_1_payload_size   ),
	.io_inputs_1_payload_burst 	( io_inputs_1_payload_burst  ),
	.io_inputs_2_valid         	( io_inputs_2_valid          ),
	.io_inputs_2_ready         	( io_inputs_2_ready          ),
	.io_inputs_2_payload_addr  	( io_inputs_2_payload_addr   ),
	.io_inputs_2_payload_id    	( io_inputs_2_payload_id     ),
	.io_inputs_2_payload_len   	( io_inputs_2_payload_len    ),
	.io_inputs_2_payload_size  	( io_inputs_2_payload_size   ),
	.io_inputs_2_payload_burst 	( io_inputs_2_payload_burst  ),
	.io_output_valid           	( io_output_valid            ),
	.io_output_ready           	( io_output_ready            ),
	.io_output_payload_addr    	( io_output_payload_addr     ),
	.io_output_payload_id      	( io_output_payload_id       ),
	.io_output_payload_len     	( io_output_payload_len      ),
	.io_output_payload_size    	( io_output_payload_size     ),
	.io_output_payload_burst   	( io_output_payload_burst    ),
	.io_chosen                 	( io_chosen                  ),
	.io_chosenOH               	( io_chosenOH                ),
	.clk                       	( clk                        ),
	.reset                     	( reset                      )
);

initial begin
    $fsdbDumpfile("test.fsdb");
    $fsdbDumpvars(0);
    $fsdbDumpMDA();
    end
endmodule
