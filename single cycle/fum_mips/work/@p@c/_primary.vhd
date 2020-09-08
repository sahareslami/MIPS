library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        pcin            : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        initPc          : in     vl_logic_vector(31 downto 0);
        pcout           : out    vl_logic_vector(31 downto 0)
    );
end PC;
