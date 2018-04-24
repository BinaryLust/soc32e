set_time_format -unit ns -decimal_places 3

create_clock -name {clk} -period 10.000 [get_ports {clk}]

derive_clock_uncertainty

# multi-cycle paths

# multiplier path
set_multicycle_path -setup -end -from [get_registers {*aRegister* *bRegister* *executeControl*}] -to [get_registers {*external_mult_registers*}] 2

set_multicycle_path -hold  -end -from [get_registers {*aRegister* *bRegister* *executeControl*}] -to [get_registers {*external_mult_registers*}] 1

# shifter path
set_multicycle_path -setup -end -from [get_registers {*aRegister* *bRegister* *flags* *executeControl*}] -to [get_registers {*shifterResult* *shifterCarry*}] 2

set_multicycle_path -hold  -end -from [get_registers {*aRegister* *bRegister* *flags* *executeControl*}] -to [get_registers {*shifterResult* *shifterCarry*}] 1






# examples below ------------------------------------------------------------------

# from A Register, B Register, Carry and Alu Control to Alu Output Registers
#set_multicycle_path -setup -end -from [get_registers {*aluControl* *bReg* *aReg* *statusReg.carryFlag}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 2

#set_multicycle_path -hold  -end -from [get_registers {*aluControl* *bReg* *aReg* *statusReg.carryFlag}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 1


# from Instruction Register to Register File Data Input Registers
#set_multicycle_path -setup -end -from [get_registers {*iReg*}] -to [get_registers {*ram_block*}] 2

#set_multicycle_path -hold  -end -from [get_registers {*iReg*}] -to [get_registers {*ram_block*}] 1


# clock pins on any register to data in pins on specified register version
#set_multicycle_path -setup -end -from [get_clocks {clk}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 2

#set_multicycle_path -hold  -end -from [get_clocks {clk}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 1


# multiplier path
#set_multicycle_path -setup -end -from [get_clocks {clk}] -through [get_nets {alu|aluMultiplierlBlock*}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 3

#set_multicycle_path -hold  -end -from [get_clocks {clk}] -through [get_nets {alu|aluMultiplierlBlock*}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 2


# shifter path
#set_multicycle_path -setup -end -from [get_clocks {clk}] -through [get_nets {alu|aluShifterBlock*}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 3

#set_multicycle_path -hold  -end -from [get_clocks {clk}] -through [get_nets {alu|aluShifterBlock*}] -to [get_pins -hierarchical {zero*|d negative*|d resultHigh*|d overflow*|d resultLow*|d carryOut*|d}] 2

