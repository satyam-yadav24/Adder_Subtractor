`ifndef ENV_SV
	`define ENV_SV



class env extends uvm_env;

	scoreboard sco_bd;
	user_subscriber user_sbr;
	user_agent user_agt;
	user_config usr_cng;
	user_driver drv;
	//monitor mon;

	`uvm_component_utils(env);

	function new(string name="", uvm_component parent);
		super.new(name,parent);
		//`uvm_info(get_full_name(),"This is the env class",UVM_NONE);
	endfunction : new



	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_full_name(),"This is the build phase of env class",UVM_NONE);
		sco_bd 		= 	scoreboard::type_id::create("sco_bd",this);
		user_sbr 	= 	user_subscriber::type_id::create("user_sbr", this);
		user_agt 	= 	user_agent::type_id::create("user_agt",this);
		usr_cng 	= 	user_config::type_id::create("usr_cng");
		assert(usr_cng.randomize() with {is_active == UVM_ACTIVE;});
		//mon = monitor::type_id::create("mon",this);

		uvm_config_db#(user_config)::set(this, "user_agt", "CONFIG",usr_cng );
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		user_agt.mon.ap_port.connect(sco_bd.mon2sco_port);
		user_agt.drv.rsp_port.connect(sco_bd.drv2sco_port);
		user_agt.mon.ap_port.connect(user_sbr.mon2subr_port);
	endfunction


endclass : env

`endif