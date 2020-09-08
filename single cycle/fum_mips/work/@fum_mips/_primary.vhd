library verilog;
use verilog.vl_types.all;
entity Fum_mips is
    port(
        initPc          : in     vl_logic_vector(31 downto 0)
    );
end Fum_mips;
