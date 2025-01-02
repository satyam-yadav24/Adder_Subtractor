`ifndef INTF_
	`define INTF_

interface intf#(parameter DATA_WIDTH=4);
	 logic 					rst;
	 logic 					clk;
	 logic 					en;
	 logic 					control;
	 logic [DATA_WIDTH-1:0] data1;
	 logic [DATA_WIDTH-1:0] data2;
	 logic [DATA_WIDTH:0] y_out;


	 //`uvm_config_db#(int)::set(get_full_name(),"")
	
endinterface :intf
`endif