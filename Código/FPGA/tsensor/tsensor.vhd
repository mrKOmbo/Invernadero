library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tsensor is
PORT( CLK, SEL, RESET, ENABLE:IN STD_LOGIC;							
		DATA :INOUT STD_LOGIC;
	   ERROR:OUT STD_LOGIC;
	   ENTERO, DECIMAL, UNI : OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	   FIN:OUT STD_LOGIC
	 );  
end tsensor;

architecture Behavioral of tsensor is


signal tEnt:std_logic_vector(7  downto 0) := (others => '0');
signal tDec:std_logic_vector(7  downto 0) := (others => '0');
signal hEnt:std_logic_vector(7  downto 0) := (others => '0');
signal hDec:std_logic_vector(7  downto 0) := (others => '0');
signal enable_cont: std_logic := '0';
signal flanco_bajada: std_logic := '0';
signal reg: std_logic_vector(3  downto 0) := (others => '0');
signal reg_total: std_logic_vector(39 downto 0) := (others => '0');
signal sum: std_logic_vector(7  downto 0) := (others => '0');
signal cont: integer range 0 to 50_000_000*2 := 0;
signal cont2: integer range 0 to 50_000_000 - 1 := 0;
signal estados: integer range 0 to 15 := 0;
signal i: integer range 0 to 40 := 40;
signal counter: integer range 0 to 9999 := 0;

begin



selector_process: process(CLK)
    begin
	 
	 if sum = reg_total(7 downto 0) then
		tEnt <= reg_total(23 downto 16);
		tDec <= reg_total(15 downto 8);
		hEnt <= reg_total(39 downto 32);
		hDec <= reg_total(31 downto 24);
        if rising_edge(CLK) then
            if SEL = '0' then
                ENTERO <= hEnt;
                DECIMAL <= hDec;
                UNI <= "10010001";  
            else
                ENTERO <= tEnt;
                DECIMAL <= tDec;
                UNI <= "01100011";  
            end if;
        end if;
	end if;
    end process;	
			

process(CLK, RESET)
begin

if RESET = '1' then 
	estados <= 0;
	
		
elsif rising_edge(clk) then	
	
	case estados is
		when 0 => 
			DATA <= 'Z';
			fin <= '0';
			ERROR <= '0';
			if ENABLE = '1' then
				estados <= 1;
			else
				estados <= 0;
			end if;
			fin <= '0';
			
		when 1 => 
			DATA <= '0';
			enable_cont <= '1';
			if(cont = 50_000_000/55) then 
				enable_cont <= '0';
				estados <= 2;
			else
				estados <= 1;
			end if;
		
		
		when 2 => -- 
			DATA <= 'Z';
			if DATA = '0' then
				estados <= 3;
			else
				estados <= 2;
			end if;
			
		when 3 => 
			if flanco_bajada = '1' then
				estados <= 4;
			else
				estados <= 3;
			end if;
				
		when 4 => 
			enable_cont <= '1';
			if flanco_bajada = '1' then
				cont2 <= cont;
				estados <= 5;
				enable_cont <= '0';
			else
				estados <= 4;
			end if;
		
		when 5 => 
			if cont2 > 50_000_000/13888 and cont2 < 50_000_000/12500 then
				reg_total(i) <= '0';
					i <= i-1;
				if i = 0 then
					estados <= 6;
					i <= 40;
				else
					estados <= 4;
				end if;
			else
				reg_total(i) <= '1';
				i <= i-1;
				if i = 0 then
					estados <= 6;
					i <= 40;
				else
					estados <= 4;
				end if;
			end if;
			
		when 6 => 
			sum <= reg_total(39 downto 32) + reg_total(31 downto 24) + reg_total(23 downto 16) +  reg_total(15 downto 8);
			estados <= 7;
			
			
		when 7 => 
			if sum = reg_total(7 downto 0) then
				

				estados <= 8;
			else
				estados <= 12; 
			end if;
		
		when 8 => 
			enable_cont <= '1';
			if(cont = 50_000_000*2) then
				enable_cont <= '0';
				estados <= 9;
			else	
				estados <= 8;
			end if;
			
		when 9 => 
			FIN <= '1';
			if counter < 9999 then
                        counter <= counter + 1;
                    else
                        estados <= 10;
                    end if;

		when 10 => 
			counter <= 0;
			fin <= '0';
			estados <= 11;
		
		when 11 => 
			estados <= 0;

		when OTHERS => 
			ERROR <= '1';
			
	end case;
end if;
end process;
			
			
			
			
			

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			


process(CLK)
begin
	if rising_edge(CLK) then
		if(enable_cont = '1') then
			cont <= cont + 1;
		else 
			cont <= 0;
		end if;
	end if;
end process;		

			


process(CLK)
begin
	if rising_edge(CLK) then
		reg <= reg(2 downto 0)&DATA;
		if reg = "1100" then
			flanco_bajada <= '1';
		else
			flanco_bajada <= '0';
		end if;
	end if;
end process;
			
end Behavioral;

