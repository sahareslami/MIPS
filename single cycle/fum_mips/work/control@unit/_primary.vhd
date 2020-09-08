library verilog;
use verilog.vl_types.all;
entity controlUnit is
    port(
        opcode          : in     vl_logic_vector(5 downto 0);
        functions       : in     vl_logic_vector(5 downto 0);
        RegDst          : out    vl_logic;
        jump            : out    vl_logic;
        branch          : out    vl_logic;
        memRead         : out    vl_logic;
        memtoReg        : out    vl_logic_vector(1 downto 0);
        isbeq           : out    vl_logic;
        memWrite        : out    vl_logic;
        alusrc          : out    vl_logic;
        RegWrite        : out    vl_logic;
        aluop           : out    vl_logic_vector(3 downto 0)
    );
end controlUnit;
