class user_config extends uvm_object;

	rand uvm_active_passive_enum is_active;

	`uvm_object_utils_begin(user_config)
		`uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
	`uvm_object_utils_end




	function new( string name = "user_config");
		super.new(name);
		//`uvm_info(get_full_name(),"this is the user_config class", UVM_NONE)
	endfunction


endclass : user_config