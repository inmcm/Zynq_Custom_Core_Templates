library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity example_core_lite_v1_0 is
	generic (
		-- Users to add parameters here
        
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 6
	);
	port (
		-- Users to add ports here
		
		-- External GPIO Inputs
        GPIO_IN : in std_logic_vector(31 downto 0);
        
        -- External GPIO Outputs
        GPIO_OUT : out std_logic_vector(31 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end example_core_lite_v1_0;

architecture arch_imp of example_core_lite_v1_0 is

	-- component declaration
	component example_core_lite_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6
		);
		port (
		-- Output register from ARM (i.e. Send commands and Data)
        SLV_REG00_OUT : out std_logic_vector(31 downto 0);
        SLV_REG01_OUT : out std_logic_vector(31 downto 0);
        SLV_REG02_OUT : out std_logic_vector(31 downto 0);
        SLV_REG03_OUT : out std_logic_vector(31 downto 0);
                
        -- Input register to ARM (i.e. Receive status and Data)
        SLV_REG04_IN : in std_logic_vector(31 downto 0);
        SLV_REG05_IN : in std_logic_vector(31 downto 0);
        SLV_REG06_IN : in std_logic_vector(31 downto 0);
        SLV_REG07_IN : in std_logic_vector(31 downto 0);
        SLV_REG08_IN : in std_logic_vector(31 downto 0);
        SLV_REG09_IN : in std_logic_vector(31 downto 0);
        SLV_REG10_IN : in std_logic_vector(31 downto 0);
        SLV_REG11_IN : in std_logic_vector(31 downto 0); 
				
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component example_core_lite_v1_0_S00_AXI;


    COMPONENT example_core
        PORT(
            SYS_CLK : IN std_logic;
            RST : IN std_logic;
            SELECT_IN : IN std_logic_vector(31 downto 0);
            INT_A : IN std_logic_vector(31 downto 0);
            INT_B : IN std_logic_vector(31 downto 0);          
            CNTR_OUT : OUT std_logic_vector(31 downto 0);
            ADD_C : OUT std_logic_vector(31 downto 0);
            MUL_C1 : OUT std_logic_vector(31 downto 0);
            MUL_C2 : OUT std_logic_vector(31 downto 0);
            REV_A : OUT std_logic_vector(31 downto 0);
            INV_B : OUT std_logic_vector(31 downto 0);
            SELECT_OUT : OUT std_logic_vector(31 downto 0)
            );
        END COMPONENT;

signal select_in_buf : std_logic_vector(31 downto 0);
signal int_a_buf : std_logic_vector(31 downto 0);
signal int_b_buf : std_logic_vector(31 downto 0);
signal cntr_out_buf : std_logic_vector(31 downto 0);
signal add_c_buf : std_logic_vector(31 downto 0);
signal mul_c1_buf : std_logic_vector(31 downto 0);
signal mul_c2_buf : std_logic_vector(31 downto 0);
signal rev_a_buf : std_logic_vector(31 downto 0);
signal inv_b_buf : std_logic_vector(31 downto 0);
signal select_out_buf : std_logic_vector(31 downto 0);



begin

-- Instantiation of Axi Bus Interface S00_AXI
example_core_lite_v1_0_S00_AXI_inst : example_core_lite_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    -- Output register from ARM (i.e. Send commands and Data)
        SLV_REG00_OUT => GPIO_OUT,
        SLV_REG01_OUT => select_in_buf,
        SLV_REG02_OUT => int_a_buf,
        SLV_REG03_OUT => int_b_buf,
                
        -- Input register to ARM (i.e. Receive status and Data)
        SLV_REG04_IN => GPIO_IN,
        SLV_REG05_IN => cntr_out_buf,
        SLV_REG06_IN => add_c_buf,
        SLV_REG07_IN => mul_c1_buf,
        SLV_REG08_IN => mul_c2_buf,
        SLV_REG09_IN => rev_a_buf,
        SLV_REG10_IN => inv_b_buf,
        SLV_REG11_IN => select_out_buf, 
		
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here
    Inst_example_core: example_core PORT MAP(
            SYS_CLK => s00_axi_aclk,
            RST => s00_axi_aresetn,
            SELECT_IN => select_in_buf,
            INT_A => int_a_buf,
            INT_B => int_b_buf,
            CNTR_OUT => cntr_out_buf,
            ADD_C => add_c_buf,
            MUL_C1 => mul_c1_buf,
            MUL_C2 => mul_c2_buf,
            REV_A => rev_a_buf,
            INV_B => inv_b_buf,
            SELECT_OUT => select_out_buf
        );
	-- User logic ends

end arch_imp;
