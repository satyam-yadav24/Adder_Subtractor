
`ifndef DRIVER_SV
	`define DRIVER_SV


class user_driver extends uvm_driver #(user_seq_item);

	parameter DATA_WIDTH =4;
	virtual intf#(.DATA_WIDTH(DATA_WIDTH)) vif;

	`uvm_component_utils(user_driver);

	function new(string name ="", uvm_component parent);
		super.new(name, parent);
		//`uvm_info(get_full_name(),"this is the user_driver class ", UVM_NONE)
		//sr = user_seq_item::type_id::create("sr",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//`uvm_info(get_full_name(),"this is the build_phase of user_driver class ", UVM_NONE)
		if(uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "ADDER_SUB_INTF", vif))
			`uvm_info(get_full_name(),"Got interface in driver ", UVM_NONE)
		else
			`uvm_fatal(get_full_name(),"Did not get the interface in driver")

	endfunction
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		//`uvm_info(get_full_name(),"This is the connect phase of env class", UVM_NONE);

	endfunction

	task run_phase(uvm_phase phase);
		user_seq_item  sr;
		forever begin
			if(vif.rst) begin
				seq_item_port.get_next_item(sr);
				`uvm_info(get_full_name(), "DATA from driver", UVM_NONE)
				//sr.print();
				//============29 DEC ==============BEGIN
				drive_data(sr);
				//============29 DEC ==============END
				seq_item_port.item_done(sr);

				
			end
			else begin
				`uvm_info(get_name(),"reset is low", UVM_NONE)
				@(posedge vif.clk);
			end

		end
	endtask 


	task drive_data(user_seq_item sr);
		@(posedge vif.clk);
		vif.data1    <= sr.data1;
		vif.data2    <= sr.data2;
		vif.control  <= sr.control;
		vif.en       <= 1'b1;

		@(posedge vif.clk);
		vif.en   <= 1'b0; 

		@(posedge vif.clk);
		sr.y_out = vif.y_out;
		seq_item_port.put_response(sr);
		rsp_port.write(sr);                // it is used in connecting diffrent ports. here it is driver to dut ///////
	endtask

endclass : user_driver

`endif