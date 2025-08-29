LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY c_product IS
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        In1_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        In1_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        in2_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        in2_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        out_re                            :   OUT   std_logic_vector(31 DOWNTO 0);
        out_im                            :   OUT   std_logic_vector(31 DOWNTO 0)
        );
END c_product;


ARCHITECTURE rtl OF c_product IS

  -- Component Declarations
  COMPONENT nfp_mul_single
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  COMPONENT ShiftRegisterRAM_Wrapper_gen
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_1_1                       :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)
          );
  END COMPONENT;

  COMPONENT nfp_sub_single
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  COMPONENT nfp_add_single
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  -- Signals
  SIGNAL Complex_to_Real_Imag_out2        : std_logic_vector(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag1_out1       : std_logic_vector(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag1_out2       : std_logic_vector(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag_out1        : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product4_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product4_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL Product2_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product2_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL Product1_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product1_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL Product3_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product3_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL mergedInput                      : unsigned(127 DOWNTO 0);
  SIGNAL mergedDelay_regin                : unsigned(127 DOWNTO 0);
  SIGNAL mergedDelay_waddr                : unsigned(2 DOWNTO 0);
  SIGNAL mergedDelay_wrenb                : std_logic;
  SIGNAL mergedDelay_raddr                : unsigned(2 DOWNTO 0);
  SIGNAL mergedDelay_regout               : std_logic_vector(127 DOWNTO 0);
  SIGNAL mergedDelay_regout_unsigned      : unsigned(127 DOWNTO 0);
  SIGNAL mergedOutput                     : unsigned(127 DOWNTO 0);
  SIGNAL slicedInput                      : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi2_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Product1_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL slicedInput_1                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi1_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Product2_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL Add1_out1                        : std_logic_vector(31 DOWNTO 0);
  SIGNAL slicedInput_2                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi3_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Product3_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL slicedInput_3                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi0_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Product4_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL Add2_out1                        : std_logic_vector(31 DOWNTO 0);

BEGIN
  Unfp_mul_comp : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Complex_to_Real_Imag_out2,
              nfp_in2 => Complex_to_Real_Imag1_out1,
              nfp_out => Product4_out1
              );

  Unfp_mul_comp_1 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Complex_to_Real_Imag_out2,
              nfp_in2 => Complex_to_Real_Imag1_out2,
              nfp_out => Product2_out1
              );

  Unfp_mul_comp_2 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Complex_to_Real_Imag_out1,
              nfp_in2 => Complex_to_Real_Imag1_out1,
              nfp_out => Product1_out1
              );

  Unfp_mul_comp_3 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Complex_to_Real_Imag_out1,
              nfp_in2 => Complex_to_Real_Imag1_out2,
              nfp_out => Product3_out1
              );

  UShiftRegisterRAM_Wrapper : ShiftRegisterRAM_Wrapper_gen
    GENERIC MAP( AddrWidth => 3,
                 DataWidth => 128
                 )
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              wr_din => std_logic_vector(mergedDelay_regin),
              wr_addr => std_logic_vector(mergedDelay_waddr),
              wr_en => mergedDelay_wrenb,
              rd_addr => std_logic_vector(mergedDelay_raddr),
              rd_dout => mergedDelay_regout
              );

  Unfp_sub_comp : nfp_sub_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Product1_out1_2,
              nfp_in2 => Product2_out1_2,
              nfp_out => Add1_out1
              );

  Unfp_add_comp : nfp_add_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Product3_out1_2,
              nfp_in2 => Product4_out1_2,
              nfp_out => Add2_out1
              );

  rd_6_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Complex_to_Real_Imag_out2 <= X"00000000";
      ELSIF enb = '1' THEN
        Complex_to_Real_Imag_out2 <= In1_im;
      END IF;
    END IF;
  END PROCESS rd_6_process;


  rd_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Complex_to_Real_Imag1_out1 <= X"00000000";
      ELSIF enb = '1' THEN
        Complex_to_Real_Imag1_out1 <= in2_re;
      END IF;
    END IF;
  END PROCESS rd_2_process;


  rd_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Complex_to_Real_Imag1_out2 <= X"00000000";
      ELSIF enb = '1' THEN
        Complex_to_Real_Imag1_out2 <= in2_im;
      END IF;
    END IF;
  END PROCESS rd_3_process;


  rd_5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Complex_to_Real_Imag_out1 <= X"00000000";
      ELSIF enb = '1' THEN
        Complex_to_Real_Imag_out1 <= In1_re;
      END IF;
    END IF;
  END PROCESS rd_5_process;


  Product4_out1_1 <= unsigned(Product4_out1);

  Product2_out1_1 <= unsigned(Product2_out1);

  Product1_out1_1 <= unsigned(Product1_out1);

  Product3_out1_1 <= unsigned(Product3_out1);

  mergedInput <= Product4_out1_1 & Product2_out1_1 & Product1_out1_1 & Product3_out1_1;

  -- Input register for RAM-based shift register mergedDelay
  mergedDelay_reginc_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_regin <= to_unsigned(0, 128);
      ELSIF enb = '1' THEN
        mergedDelay_regin <= mergedInput;
      END IF;
    END IF;
  END PROCESS mergedDelay_reginc_process;


  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 3
  -- 
  -- Write address counter for RAM-based shift register mergedDelay
  mergedDelay_wr_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_waddr <= to_unsigned(16#0#, 3);
      ELSIF enb = '1' THEN
        IF mergedDelay_waddr >= to_unsigned(16#3#, 3) THEN 
          mergedDelay_waddr <= to_unsigned(16#0#, 3);
        ELSE 
          mergedDelay_waddr <= mergedDelay_waddr + to_unsigned(16#1#, 3);
        END IF;
      END IF;
    END IF;
  END PROCESS mergedDelay_wr_process;


  mergedDelay_wrenb <= '1';

  -- Count limited, Unsigned Counter
  --  initial value   = 1
  --  step value      = 1
  --  count to value  = 3
  -- 
  -- Read address counter for RAM-based shift register mergedDelay
  mergedDelay_rd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_raddr <= to_unsigned(16#1#, 3);
      ELSIF enb = '1' THEN
        IF mergedDelay_raddr >= to_unsigned(16#3#, 3) THEN 
          mergedDelay_raddr <= to_unsigned(16#0#, 3);
        ELSE 
          mergedDelay_raddr <= mergedDelay_raddr + to_unsigned(16#1#, 3);
        END IF;
      END IF;
    END IF;
  END PROCESS mergedDelay_rd_process;


  mergedDelay_regout_unsigned <= unsigned(mergedDelay_regout);

  -- Output register for RAM-based shift register mergedDelay
  mergedDelay_regoutc_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedOutput <= to_unsigned(0, 128);
      ELSIF enb = '1' THEN
        mergedOutput <= mergedDelay_regout_unsigned;
      END IF;
    END IF;
  END PROCESS mergedDelay_regoutc_process;


  slicedInput <= mergedOutput(63 DOWNTO 32);

  dtcsi2_y <= slicedInput;
  Product1_out1_2 <= std_logic_vector(resize(dtcsi2_y, 32));

  slicedInput_1 <= mergedOutput(95 DOWNTO 64);

  dtcsi1_y <= slicedInput_1;
  Product2_out1_2 <= std_logic_vector(resize(dtcsi1_y, 32));

  slicedInput_2 <= mergedOutput(31 DOWNTO 0);

  dtcsi3_y <= slicedInput_2;
  Product3_out1_2 <= std_logic_vector(resize(dtcsi3_y, 32));

  slicedInput_3 <= mergedOutput(127 DOWNTO 96);

  dtcsi0_y <= slicedInput_3;
  Product4_out1_2 <= std_logic_vector(resize(dtcsi0_y, 32));

  out_re <= Add1_out1;

  out_im <= Add2_out1;

END rtl;

