`ifndef USR_AGT
	`define USR_AGT


class user_agent extends uvm_agent;

	monitor mon;
	user_driver drv;
	user_sequencer user_seqr;
	user_config usr_cng;



	`uvm_component_utils(user_agent);


	function new(string name ="", uvm_component parent);
		super.new(name, parent); 
		`uvm_info(get_full_name(),"this is the agent class ", UVM_NONE);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		//getting config in env file
		if(!uvm_config_db#(user_config)::get(this, "", "CONFIG",usr_cng ))
			`uvm_fatal(get_full_name(),"config class not received")

		if(usr_cng.is_active == UVM_ACTIVE) begin
			drv = user_driver::type_id::create("drv",this);
			user_seqr = user_sequencer::type_id::create("user_seqr",this);
		end
		
		mon = monitor::type_id::create("mon",this);

	endfunction


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(usr_cng.is_active == UVM_ACTIVE)begin
			drv.seq_item_port.connect(user_seqr.seq_item_export);
		end
		
		//drv.print();
		//`uvm_info(get_full_name(),"This is the connect phase of agent class", UVM_NONE);
	endfunction


endclass : user_agent

`endif