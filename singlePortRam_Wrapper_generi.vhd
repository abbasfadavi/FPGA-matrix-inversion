LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY singlePortRam_Wrapper_generi IS
  GENERIC( AddrWidth                      : integer := 1;
           DataWidth                      : integer := 1
           );
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        din_re                            :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
        din_im                            :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
        addr                              :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
        we                                :   IN    std_logic;
        dout_re                           :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);
        dout_im                           :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)
        );
END singlePortRam_Wrapper_generi;


ARCHITECTURE rtl OF singlePortRam_Wrapper_generi IS

  -- Component Declarations
  COMPONENT SinglePortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          din_re                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
          din_im                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
          addr                            :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
          we                              :   IN    std_logic;
          dout_re                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);
          dout_im                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)
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
  SIGNAL bypass2_sel                      : std_logic;
  SIGNAL bypass1_and                      : std_logic;
  SIGNAL ram_is_down3                     : std_logic;
  SIGNAL bypass1_sel                      : std_logic;
  SIGNAL din_re_last_value                : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL din_re_1                         : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL din_im_1                         : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL din_im_last_value                : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL addr_last_value                  : unsigned(AddrWidth - 1 DOWNTO 0);
  SIGNAL addr_1                           : unsigned(AddrWidth - 1 DOWNTO 0);
  SIGNAL we_last_value                    : std_logic;
  SIGNAL we_1                             : std_logic;
  SIGNAL dout_re_1                        : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_im_1                        : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL ram_is_down4                     : std_logic;
  SIGNAL bypass1_en                       : std_logic;
  SIGNAL dout_re_last_value               : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_re_bypass_1                 : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_re_bypass_last_value        : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_re_bypass_bypass            : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_im_last_value               : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_im_bypass_1                 : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_im_bypass_last_value        : std_logic_vector(DataWidth - 1 DOWNTO 0);
  SIGNAL dout_im_bypass_bypass            : std_logic_vector(DataWidth - 1 DOWNTO 0);

BEGIN
  USinglePortRAM_generic_1 : SinglePortRAM_generic
    GENERIC MAP( AddrWidth => AddrWidth,
                 DataWidth => DataWidth
                 )
    PORT MAP( clk => clk,
              din_re => din_re_1,
              din_im => din_im_1,
              addr => std_logic_vector(addr_1),
              we => we_1,
              dout_re => dout_re_1,
              dout_im => dout_im_1
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

  bypass2_sel <= ram_is_fastest_rate OR ram_is_down2 OR filreg;

  bypass1_and <= ram_is_down2 AND enb_1_1_1;

  ram_is_down3 <= (enb_1_1_1 AND not_en1_delay1 AND not_en1_delay2 AND enb_1_1_1_delay3) OR (not_en1 AND 
    enb_1_1_1_delay1 AND not_en1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND 
    enb_1_1_1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND enb_1_1_1_delay2 AND 
    enb_1_1_1_delay3 AND enb);

  bypass1_sel <= (ram_is_fastest_rate OR bypass1_and OR ram_is_down3) AND notfilreg;

  din_re_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        din_re_last_value <= (OTHERS => '0');
      ELSIF enb_1_1_1 = '1' THEN
        din_re_last_value <= din_re;
      END IF;
    END IF;
  END PROCESS din_re_bypass_process;

  din_re_1 <= din_re WHEN ram_is_fastest_rate = '1' ELSE
              din_re_last_value;

  din_im_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        din_im_last_value <= (OTHERS => '0');
      ELSIF enb_1_1_1 = '1' THEN
        din_im_last_value <= din_im;
      END IF;
    END IF;
  END PROCESS din_im_bypass_process;

  addr_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        addr_last_value <= (OTHERS => '0');
      ELSIF enb_1_1_1 = '1' THEN
        addr_last_value <= unsigned(addr);
      END IF;
    END IF;
  END PROCESS addr_bypass_process;

  din_im_1 <= din_im WHEN ram_is_fastest_rate = '1' ELSE
              din_im_last_value;

  addr_1 <= unsigned(addr) WHEN ram_is_fastest_rate = '1' ELSE
            addr_last_value;

  we_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        we_last_value <= '0';
      ELSIF enb_1_1_1 = '1' THEN
        we_last_value <= we;
      END IF;
    END IF;
  END PROCESS we_bypass_process;

  we_1 <= we WHEN ram_is_fastest_rate = '1' ELSE
          we_last_value;

  ram_is_down4 <= (enb_1_1_1 AND not_en1_delay1 AND not_en1_delay2 AND not_en1_delay3) OR (not_en1 AND 
    enb_1_1_1_delay1 AND not_en1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND 
    enb_1_1_1_delay2 AND not_en1_delay3) OR (not_en1 AND not_en1_delay1 AND not_en1_delay2 AND 
    enb_1_1_1_delay3) OR NOT (enb_1_1_1 OR enb_1_1_1_delay1 OR enb_1_1_1_delay2 OR enb_1_1_1_delay3) OR 
    (not_en1 AND not_en1_delay1 AND enb_1_1_1_delay2 AND enb_1_1_1_delay3 AND not_en0);

  bypass1_en <= bypass1_and OR (ram_is_down4 AND enb_1_1_1_delay2) OR (enb_1_1_1 AND enb_1_1_1_delay1 AND 
    enb_1_1_1_delay2 AND enb_1_1_1_delay3);

  dout_re_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        dout_re_last_value <= (OTHERS => '0');
      ELSIF bypass1_en = '1' THEN
        dout_re_last_value <= dout_re_1;
      END IF;
    END IF;
  END PROCESS dout_re_bypass_process;

  dout_re_bypass_1 <= dout_re_1 WHEN bypass1_sel = '1' ELSE
                      dout_re_last_value;

  dout_re_bypass_2_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        dout_re_bypass_last_value <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        dout_re_bypass_last_value <= dout_re_bypass_1;
      END IF;
    END IF;
  END PROCESS dout_re_bypass_2_process;

  dout_re_bypass_bypass <= dout_re_bypass_1 WHEN bypass2_sel = '1' ELSE
                           dout_re_bypass_last_value;

  dout_im_bypass_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        dout_im_last_value <= (OTHERS => '0');
      ELSIF bypass1_en = '1' THEN
        dout_im_last_value <= dout_im_1;
      END IF;
    END IF;
  END PROCESS dout_im_bypass_process;

  dout_im_bypass_1 <= dout_im_1 WHEN bypass1_sel = '1' ELSE
                      dout_im_last_value;

  dout_im_bypass_2_process: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF reset_x = '1' THEN
        dout_im_bypass_last_value <= (OTHERS => '0');
      ELSIF enb = '1' THEN
        dout_im_bypass_last_value <= dout_im_bypass_1;
      END IF;
    END IF;
  END PROCESS dout_im_bypass_2_process;

  dout_im_bypass_bypass <= dout_im_bypass_1 WHEN bypass2_sel = '1' ELSE
                           dout_im_bypass_last_value;

  dout_re <= dout_re_bypass_bypass;

  dout_im <= dout_im_bypass_bypass;

END rtl;

