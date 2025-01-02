


class parent_test extends uvm_test;

	env en;
	parent_sequence pq;

	`uvm_component_utils_begin(parent_test)
	`uvm_component_utils_end

	function new(string name = "", uvm_component parent)
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = env::type_id::create("en", this);
	endfunction : build_phase



	task run_phase(uvm_phase phase);
		super.run_phase(phase);

		phase.raise_objection(this);
		pq = parent_sequence::type_id::create("pq");
		pq.start(env.user_agent.user_sequencer);
		#10ns;
		phase.drop_objection(this);
	endtask : run_phase

task generate_directed_tests(); 
	user_seq_item item; 
	// Example: Directed test for specific values 
	item = user_seq_item::type_id::create("item"); 
	item.data1 = 100; 
	item.data2 = 150; 
	item.control = 0; 
	env.user_agent.user_sequencer.start_item(item); 
	env.user_agent.user_sequencer.finish_item(item); 
	item = user_seq_item::type_id::create("item"); 
	item.data1 = 200; 
	item.data2 = 50; 
	item.control = 1; 
	env.user_agent.user_sequencer.start_item(item); 
	env.user_agent.user_sequencer.finish_item(item); 

endtask : generate_directed_tests



endclass