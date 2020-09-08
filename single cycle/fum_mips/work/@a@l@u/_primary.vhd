library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        data1           : in     vl_logic_vector(31 downto 0);
        data2           : in     vl_logic_vector(31 downto 0);
        aluoperation    : in     vl_logic_vector(3 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        lt              : out    vl_logic;
        gt              : out    vl_logic
    );
end ALU;
