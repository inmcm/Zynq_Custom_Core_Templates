----------------------------------------------------------------------------------
-- Engineer: Calvin McCoy
-- 
-- Create Date:    10:49:19 03/04/2016 
-- Design Name:    Zynq Example Core
-- Module Name:    example_core - Behavioral 
-- Project Name:   Zynq Example Core Template
-- Target Devices: Zynq-7000
-- Tool versions: Vivado 2015.1
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity example_core is
    Port ( SYS_CLK : in  STD_LOGIC;
            RST : in  STD_LOGIC;        
            SELECT_IN : in  STD_LOGIC_VECTOR (31 downto 0);
            INT_A : in  STD_LOGIC_VECTOR (31 downto 0);
            INT_B : in  STD_LOGIC_VECTOR (31 downto 0);

            CNTR_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
            ADD_C : out  STD_LOGIC_VECTOR (31 downto 0);
            MUL_C1 : out  STD_LOGIC_VECTOR (31 downto 0);
            MUL_C2 : out  STD_LOGIC_VECTOR (31 downto 0);
            REV_A : out  STD_LOGIC_VECTOR (31 downto 0);
            INV_B : out  STD_LOGIC_VECTOR (31 downto 0);
            SELECT_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
 
end example_core;

architecture Behavioral of example_core is

signal unsigned_a : unsigned(31 downto 0) := (others => '0');
signal unsigned_b : unsigned(31 downto 0) := (others => '0');
signal product : unsigned(63 downto 0) := (others => '0');
signal sum : unsigned(31 downto 0) := (others => '0');

signal free_run_cntr : unsigned(31 downto 0);


begin

------------------------
-- Sync Statements
------------------------

Sync_Process : process(SYS_CLK)
begin
    if (SYS_CLK'event and SYS_CLK = '1') then
                
        if (RST = '0') then
            product <= (others => '0');
            sum <= (others => '0');
            free_run_cntr <= (others => '0');
        
        else
            product <= unsigned_a * unsigned_b;
            sum <= unsigned_a + unsigned_b;
            free_run_cntr <= free_run_cntr + 1;
            
        end if;
    end if;
end process;


------------------------
-- Async Statements
------------------------

-- Generate Bit Inversion of INT_B
INV_B <= NOT INT_B;

-- Bit Reverse of INT_A 
reverse_bits : for i in 0 to 31 generate
    REV_A(i) <= INT_A(31-i);  
end generate;

-- Arbitary Output Selector
with SELECT_IN select
    SELECT_OUT <=   X"12345678" when X"00000000",
                    X"ABABABAB" when X"00000001",
                    X"80000001" when X"00000002",
                    X"9ABCDEF0" when X"00000003",
                    X"C3C3C3C3" when X"FFFFFFFF",
                    X"81818181" when X"00000022",
                    X"99999999" when X"99999999",
                    X"ABABABAB" when X"F0000000",
                    X"12488421" when X"0007E000",           
                    X"FEEDABBA" when X"76543210",
                    X"A6AAE961" when X"3787A668",
                    X"FFFFFFFF" when others;

------------------------
-- Type Translation
------------------------
-- Output Conversion
MUL_C1 <= std_logic_vector(product(31 downto 0));
MUL_C2 <= std_logic_vector(product(63 downto 32));
ADD_C <= std_logic_vector(sum);
CNTR_OUT <= std_logic_vector(free_run_cntr);

-- Input Conversion
unsigned_a <= unsigned(INT_A);
unsigned_b <= unsigned(INT_B);
    
        
end Behavioral;






