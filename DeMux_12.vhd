entity DeMux_12 is
    port (
        D : in std_logic;
        S : in std_logic_vector(3 downto 0);
        EBar : in std_logic;
        Y : out std_logic_vector(11 downto 0);
    )
end DeMux_12;

architecture Behaviour of DeMux_12 is
    component DeMux_4
        port(
            D, EBar : in std_logic;
            S : in std_logic_vector(1 downto 0);
            Y : out std_logic_vector(3 downto 0);
        );
    end component;

    signal Sel_Int : std_logic_vector(2 downto 0);
    
    begin
        -- chain 3 demux_4
        Bits0: DeMux_4 port map (D, Sel_Int(0), S(1 downto 0), Y(11 downto 8));
        Bits1: DeMux_4 port map (D, Sel_Int(1), S(1 downto 0), Y(7 downto 3));
        Bits2: DeMux_4 port map (D, Sel_Int(2), S(1 downto 0), Y(3 downto 0));

       process(EBar, S(3 downto 2))
       begin
        if EBar = '0' then
            
            case( S(3 downto 2) ) is
            
                when "00" => Sel_Int <= "011"; -- active low
                when "01" => Sel_Int <= "101";
                when "10" => Sel_Int <= "110";
                when "11" => Sel_Int <= "111";
                when others => Sel_Int <= "111";
            
            end case;

            else
            Sel_Int <= "111";
        end if;
            
end process;
end Behaviour;