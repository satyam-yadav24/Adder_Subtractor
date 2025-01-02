`ifndef MONITOR_SV
	`define MONITOR_SV


class monitor extends uvm_monitor;

	parameter DATA_WIDTH =4;
	

	user_seq_item sr;

	uvm_analysis_port #(user_seq_item) ap_port;
	
	
	`uvm_component_utils_begin(monitor)
	`uvm_component_utils_end



	virtual intf #(.DATA_WIDTH(DATA_WIDTH)) vif;

	function new(string name ="", uvm_component parent);
		super.new(name, parent);
		//`uvm_info(get_full_name(),"this is the monitor class ", UVM_NONE)
		ap_port = new("ap_port", this);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//`uvm_info(get_full_name(),"this is the build_phase of monitor class ", UVM_NONE)

		if(uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this,"","ADDER_SUB_INTF", vif))begin
			`uvm_info(get_full_name(),"Got interface in monitor ", UVM_NONE)
		end else begin
			`uvm_fatal(get_full_name(),"Did not get the interface in monitor")

		end

	endfunction


	task run_phase(uvm_phase phase);
		forever begin
			if(vif.rst)begin
				monitor_data();
			end 
			else begin
				`uvm_info(get_full_name(), "reset is driving zero", UVM_NONE)
				@(posedge vif.clk);
			end
		end
	endtask

	task monitor_data();
		sr = user_seq_item::type_id::create("sr");
		
			if(vif.en) begin
				@(posedge vif.clk);
				sr.data1   = vif.data1;
				sr.data2   = vif.data2;
				sr.en      = vif.en;
				sr.control = vif.control;
				sr.y_out   = vif.y_out;
				ap_port.write(sr);
			end
			else begin
				`uvm_info(get_name(), "dut is not active", UVM_HIGH)
				@(posedge vif.clk);
			end
	endtask



endclass : monitor

`endif