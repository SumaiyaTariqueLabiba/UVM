class alu_test extends uvm_test;
  `uvm_component_utils(alu_test);
  
  alu_env environment;
  alu_sequence_base seq_base;
  alu_sequence_test seq_test;
  
  //constructor------------------------------------------------------------------------
  
  function new(string name = "alu_test", uvm_component parent); 
  super.new(name, parent);
  `uvm_info("Test_Class","Inside test constructor!", UVM_HIGH)
  endfunction: new
  
  
  
  //Build Phase-----------------------------------------------------------------------
  
  function void build_phase(uvm_phase phase);               
    super.build_phase(phase);
    `uvm_info("Test_Class","Inside test build phase!", UVM_HIGH)
    
    environment = alu_env::type_id::create("environment", this);   //containing env inside test (diagram)
    
  endfunction: build_phase
  
  
  
  //Connect phase--------------------------------------------------------------------
  
  function void connect_phase(uvm_phase phase);              
    super.connect_phase(phase);
    `uvm_info("Test_class","Inside test connect phase!", UVM_HIGH)
    
  endfunction: connect_phase
  
  
  
  //Run phase------------------------------------------------------------------------
   
  task run_phase(uvm_phase phase);                             
   super.run_phase(phase);
    `uvm_info("Test_class","Inside test run phase!", UVM_HIGH)
    
    phase.raise_objection(this);
    
      //base(reset) sequence               //From two created sequences in sequence.sv
      #10;
      seq_base = alu_sequence_base::type_id::create("seq_base");
      seq_base.start(environment.agent.sequencer);    //command to start(seq in env, env in agent, agrent in sqncer)

      //test sequence
      #10;
      repeat(100) begin  //repeat optional
      seq_test = alu_sequence_test::type_id::create("seq_test");
      seq_test.start(environment.agent.sequencer); 
      end
    
    phase.drop_objection(this);
    
  endtask: run_phase
  
  
  
endclass: alu_test 