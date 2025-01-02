class parent_sequence extends uvm_sequence #(user_seq_item);

	`uvm_object_utils_begin(parent_sequence)
	`uvm_object_utils_end

		user_seq_item sq;

	function new(string name = "parent_sequence");
		super.new(name);	
		//`uvm_info(get_name(),"this is seq", UVM_NONE)
	endfunction : new



	task body();
		`uvm_info(get_full_name(),"this is user seq body task", UVM_NONE)
		repeat(5000) begin
			sq = user_seq_item::type_id::create("sq");
			start_item(sq);
			void'(sq.randomize());
			$display("********************************data randomizing*******************************");
			sq.print();			
			#10 
			finish_item(sq);
			get_response(sq);
			response_queue_depth = 5001;
		end

	endtask : body

endclass

