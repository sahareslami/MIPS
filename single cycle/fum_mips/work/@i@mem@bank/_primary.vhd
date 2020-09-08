library verilog;
use verilog.vl_types.all;
entity IMemBank is
    port(
        memread         : in     vl_logic;
        address         : in     vl_logic_vector(7 downto 0);
        readdata        : out    vl_logic_vector(31 downto 0)
    );
end IMemBank;
