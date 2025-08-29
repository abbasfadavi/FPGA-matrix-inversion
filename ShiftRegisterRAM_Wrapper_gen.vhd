LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ShiftRegisterRAM_Wrapper_gen IS
  GENERIC( AddrWidth                      : integer := 1;
           DataWidth                      : integer := 1
           );
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        wr_din                            :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
        wr_addr                           :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
        wr_en                             :   IN    std_logic;
        rd_addr                           :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
        rd_dout                           :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)
        );
END ShiftRegisterRAM_Wrapper_gen;


ARCHITECTURE rtl OF ShiftRegisterRAM_Wrapper_gen IS

  -- Component Declarations
  COMPONENT SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)
          );
  END COMPONENT;

  -- Signals
  SIGNAL const_one                        : std_logic;
  SIGNAL filwait                          : std_logic;
  SIGNAL enb_1_1_1_delay1                 : std_logic;
  SIGNAL not_en1_delay1                   : std_logic;
  SIGNAL filmode                          : std_logic;
  SIGNAL filreg                           : std_logic;
  SIGNAL notfilreg                        : std_logic;
  SIGNAL ram_is_fastest_rate              : std_logic;
  SIGNAL enb_1_1_1_delay2                 : std_logic;
  SIGNAL enb_1_1_1_delay3                 : std_logic;
  SIGNAL not_en1_delay3                   : std_logic;
  SIGNAL not_en1                          : std_logic;
  SIGNAL not_en1_delay2                   : std_logic;
  SIGNAL not_en0                          : std_logic;
  SIGNAL ram_is_down2                     : std_logic;
  SIGNAL bypass1_and                      : std_logic;
  SIGNAL ram_is_down3                     : std_logic;
  SIGNAL wr_din_last_value                : unsigned(DataWidth - 1 DOWNTO 0);
  SIGNAL wr_addr_last_value               : unsigned(AddrWidth - 1 DOWNTO 0);
  SIGNAL wr_din_1                         : unsigned(DataWidth - 1 DOWNTO 0);
  SIGNAL wr_addr_1                        : unsigned(AddrWidth - 1 DOWNTO 0);
  SIGNAL wr_en_last_value                 : std_logic;
  SIGNAL rd_addr_last_value               : unsigned(AddrWidth - 1 DOWNTO 0);
  SIGNAL wr_en_1                          : std_logic;
  SIGNAL rd_addr_1                        : unsigned(AddrWidth - 1 DOWNTO 0);
  SIGNAL rd_dout_1                        : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL ram_is_down4                     : std_logic;
  SIGNAL rd_dout_last_value               : unsigned(DataWidth - 1 DOWNTO 0);
  SIGNAL rd_dout_bypass_1                 : unsigned(DataWidth - 1 DOWNTO 0);
  SIGNAL rd_dout_bypass_last_value        : unsigned(DataWidth - 1 DOWNTO 0);
  SIGNAL rd_dout_bypass_bypass            : unsigned(DataWidth - 1 DOWNTO 0);

BEGIN
  USimpleDualPortRAM_generic_1 : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => AddrWidth,
                 DataWidth => DataWidth
                 )
    PORT MAP( clk => clk,
              wr_din => std_logic_vector(wr_din_1),
              wr_addr => std_logic_vector(wr_addr_1),
              wr_en => wr_en_1,
              rd_addr => std_logic_vector(rd_addr_1),
              rd_dout => rd_dout_1
              );

  const_one <= '1';

  fil_wait_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        filwait <= '0';
      ELSIF enb = '1' THEN
        filwait <= const_one;
      END IF;
    END IF;
  END PROCESS fil_wait_process;

  ram_enb_delay1_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        enb_1_1_1_delay1 <= '1';
      ELSE
        enb_1_1_1_delay1 <= enb_1_1_1;
      END IF;
    END IF;
  END PROCESS ram_enb_delay1_process;

  not_en1_delay1 <= NOT enb_1_1_1_delay1;

  filmode <= filwait AND (not_en1_delay1 AND enb_1_1_1 AND enb);

  fil_hold_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        filreg <= '0';
      ELSIF filmode = '1' THEN
        filreg <= const_one;
      END IF;
    END IF;
  END PROCESS fil_hold_process;

  notfilreg <= NOT filreg;

  ram_is_fastest_rate <= enb_1_1_1 AND enb AND notfilreg;

  ram_enb_delay2_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        enb_1_1_1_delay2 <= '1';
      ELSE
        enb_1_1_1_delay2 <= enb_1_1_1_delay1;
      END IF;
    END IF;
  END PROCESS ram_enb_delay2_process;

  ram_enb_delay3_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        enb_1_1_1_delay3 <= '1';
      ELSE
        enb_1_1_1_delay3 <= enb_1_1_1_delay2;
      END IF;
    END IF;
  END PROCESS ram_enb_delay3_process;

  not_en1_delay3 <= NOT enb_1_1_1_delay3;

  not_en1 <= NOT enb_1_1_1;

  not_en1_delay2 <= NOT enb_1_1_1_delay2;

  not_en0 <= NOT enb;

  ram_is_down2 <= (enb_1_1_1 AND not_en1_delay1 AND enb_1_1_1_delay2 AND not_en1_delay3) OR (not_en1 AND 
    enb_1_1_1_delay1 AND not_en1_delay2 AND enb_1_1_1_delay3) OR (not_en1 AND enb_1_1_1_delay1 AND 
    enb_1_1_1_delay2 AND enb_1_1_1_delay3 AND enb) OR (enb_1_1_1 AND not_en1_delay1 AND enb_1_1_1_delay2 AND 
    enb_1_1_1_delay3 AND not_en0);

  bypass1_and <= ram_is_down2 AND enb_1_1_1;

  ram_is_down3 <= (enb_1_1_1 AND not_en1_delay1 AND not_en1_delay2 AND enb_1_1_1_delay3) OR (not_en1 AND 
    enb_1_1_1_delay1 AND not_en1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND 
    enb_1_1_1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND enb_1_1_1_delay2 AND 
    enb_1_1_1_delay3 AND enb);

  wr_din_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        wr_din_last_value <= (OTHERS => '0');
      ELSIF enb_1_1_1 = '1' THEN
        wr_din_last_value <= unsigned(wr_din);
      END IF;
    END IF;
  END PROCESS wr_din_bypass_process;

  wr_addr_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        wr_addr_last_value <= (OTHERS => '0');
      ELSIF enb_1_1_1 = '1' THEN
        wr_addr_last_value <= unsigned(wr_addr);
      END IF;
    END IF;
  END PROCESS wr_addr_bypass_process;

  wr_din_1 <= unsigned(wr_din) WHEN ram_is_fastest_rate = '1' ELSE
              wr_din_last_value;

  wr_addr_1 <= unsigned(wr_addr) WHEN ram_is_fastest_rate = '1' ELSE
               wr_addr_last_value;

  wr_en_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        wr_en_last_value <= '0';
      ELSIF enb_1_1_1 = '1' THEN
        wr_en_last_value <= wr_en;
      END IF;
    END IF;
  END PROCESS wr_en_bypass_process;

  rd_addr_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        rd_addr_last_value <= (OTHERS => '0');
      ELSIF enb_1_1_1 = '1' THEN
        rd_addr_last_value <= unsigned(rd_addr);
      END IF;
    END IF;
  END PROCESS rd_addr_bypass_process;

  wr_en_1 <= wr_en WHEN ram_is_fastest_rate = '1' ELSE
             wr_en_last_value;

  rd_addr_1 <= unsigned(rd_addr) WHEN ram_is_fastest_rate = '1' ELSE
               rd_addr_last_value;

  ram_is_down4 <= (enb_1_1_1 AND not_en1_delay1 AND not_en1_delay2 AND not_en1_delay3) OR (not_en1 AND 
    enb_1_1_1_delay1 AND not_en1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND 
    enb_1_1_1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND not_en1_delay2 AND 
    enb_1_1_1_delay3) OR NOT (enb_1_1_1 OR enb_1_1_1_delay1 OR enb_1_1_1_delay2 OR enb_1_1_1_delay3) OR 
    (not_en1 AND not_en1_delay1 AND enb_1_1_1_delay2 AND enb_1_1_1_delay3 AND not_en0);

  rd_dout_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        rd_dout_last_value <= (OTHERS => '0');
      ELSIF (bypass1_and OR (ram_is_down4 AND enb_1_1_1_delay2) OR (enb_1_1_1 AND enb_1_1_1_delay1 AND 
        enb_1_1_1_delay2 AND enb_1_1_1_delay3)) = '1' THEN
        rd_dout_last_value <= unsigned(rd_dout_1);
      END IF;
    END IF;
  END PROCESS rd_dout_bypass_process;

  rd_dout_bypass_1 <= unsigned(rd_dout_1) WHEN ((ram_is_fastest_rate OR bypass1_and OR ram_is_down3) AND 
    notfilreg) = '1' ELSE
                      rd_dout_last_value;

  rd_dout_bypass_2_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        rd_dout_bypass_last_value <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        rd_dout_bypass_last_value <= rd_dout_bypass_1;
      END IF;
    END IF;
  END PROCESS rd_dout_bypass_2_process;

  rd_dout_bypass_bypass <= rd_dout_bypass_1 WHEN (ram_is_fastest_rate OR ram_is_down2 OR filreg) = '1' ELSE
                           rd_dout_bypass_last_value;

  rd_dout <= std_logic_vector(rd_dout_bypass_bypass);

END rtl;

