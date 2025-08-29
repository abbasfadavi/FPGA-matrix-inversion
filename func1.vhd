LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY func1 IS
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        in1_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        in1_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        in2_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        in2_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        out_re                            :   OUT   std_logic_vector(31 DOWNTO 0);
        out_im                            :   OUT   std_logic_vector(31 DOWNTO 0)
        );
END func1;


ARCHITECTURE rtl OF func1 IS

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

  COMPONENT nfp_add_single
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  COMPONENT nfp_hdlrecip_single
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in                          :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  COMPONENT nfp_uminus_single
    PORT( nfp_in                          :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  COMPONENT c_product_block
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_1_1                       :   IN    std_logic;
          In1_re                          :   IN    std_logic_vector(31 DOWNTO 0);
          In1_im                          :   IN    std_logic_vector(31 DOWNTO 0);
          in2_re                          :   IN    std_logic_vector(31 DOWNTO 0);
          in2_im                          :   IN    std_logic_vector(31 DOWNTO 0);
          out_re                          :   OUT   std_logic_vector(31 DOWNTO 0);
          out_im                          :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  -- Signals
  SIGNAL in1_re_1                         : std_logic_vector(31 DOWNTO 0);
  SIGNAL in1_im_1                         : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product4_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product4_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL Product3_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product3_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag_out1        : unsigned(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag_out2        : unsigned(31 DOWNTO 0);
  SIGNAL mergedInput                      : unsigned(63 DOWNTO 0);
  SIGNAL mergedDelay_regin                : unsigned(63 DOWNTO 0);
  SIGNAL mergedDelay_waddr                : unsigned(3 DOWNTO 0);
  SIGNAL mergedDelay_wrenb                : std_logic;
  SIGNAL mergedDelay_raddr                : unsigned(3 DOWNTO 0);
  SIGNAL mergedDelay_regout               : std_logic_vector(63 DOWNTO 0);
  SIGNAL mergedDelay_regout_unsigned      : unsigned(63 DOWNTO 0);
  SIGNAL mergedOutput                     : unsigned(63 DOWNTO 0);
  SIGNAL slicedInput                      : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi1_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag_out2_1      : std_logic_vector(31 DOWNTO 0);
  SIGNAL slicedInput_1                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi0_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Complex_to_Real_Imag_out1_1      : std_logic_vector(31 DOWNTO 0);
  SIGNAL mergedDelay_waddr_1              : unsigned(1 DOWNTO 0);
  SIGNAL mergedDelay_wrenb_1              : std_logic;
  SIGNAL mergedDelay_raddr_1              : unsigned(1 DOWNTO 0);
  SIGNAL Math_Reciprocal_out1_buff        : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product1_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product1_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL mergedOutput_1                   : unsigned(127 DOWNTO 0);
  SIGNAL slicedInput_2                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi0_y_1                       : unsigned(31 DOWNTO 0);
  SIGNAL Product4_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL slicedInput_3                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi1_y_1                       : unsigned(31 DOWNTO 0);
  SIGNAL Product3_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL Add_out1                         : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product2_out1                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Product2_out1_1                  : unsigned(31 DOWNTO 0);
  SIGNAL mergedInput_1                    : unsigned(127 DOWNTO 0);
  SIGNAL mergedDelay_regin_1              : unsigned(127 DOWNTO 0);
  SIGNAL mergedDelay_regout_1             : std_logic_vector(127 DOWNTO 0);
  SIGNAL mergedDelay_regout_unsigned_1    : unsigned(127 DOWNTO 0);
  SIGNAL slicedInput_4                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi3_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Product1_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL slicedInput_5                    : unsigned(31 DOWNTO 0);
  SIGNAL dtcsi2_y                         : unsigned(31 DOWNTO 0);
  SIGNAL Product2_out1_2                  : std_logic_vector(31 DOWNTO 0);
  SIGNAL Conjugate_imag_sig_after         : std_logic_vector(31 DOWNTO 0);
  SIGNAL c_product_out1_re                : std_logic_vector(31 DOWNTO 0);
  SIGNAL c_product_out1_im                : std_logic_vector(31 DOWNTO 0);

BEGIN
  Unfp_mul_comp_5 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => in1_im_1,
              nfp_in2 => in1_im_1,
              nfp_out => Product4_out1
              );

  Unfp_mul_comp_1_2 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => in1_re_1,
              nfp_in2 => in1_re_1,
              nfp_out => Product3_out1
              );

  UShiftRegisterRAM_Wrapper_2 : ShiftRegisterRAM_Wrapper_gen
    GENERIC MAP( AddrWidth => 4,
                 DataWidth => 64
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

  Unfp_mul_comp_2_2 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Complex_to_Real_Imag_out1_1,
              nfp_in2 => Math_Reciprocal_out1_buff,
              nfp_out => Product1_out1
              );

  Unfp_add_comp_2 : nfp_add_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Product3_out1_2,
              nfp_in2 => Product4_out1_2,
              nfp_out => Add_out1
              );

  Unfp_hdlrecip_comp : nfp_hdlrecip_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in => Add_out1,
              nfp_out => Math_Reciprocal_out1_buff
              );

  Unfp_mul_comp_3_2 : nfp_mul_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Math_Reciprocal_out1_buff,
              nfp_in2 => Complex_to_Real_Imag_out2_1,
              nfp_out => Product2_out1
              );

  UShiftRegisterRAM_Wrapper_ge : ShiftRegisterRAM_Wrapper_gen
    GENERIC MAP( AddrWidth => 2,
                 DataWidth => 128
                 )
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              wr_din => std_logic_vector(mergedDelay_regin_1),
              wr_addr => std_logic_vector(mergedDelay_waddr_1),
              wr_en => mergedDelay_wrenb_1,
              rd_addr => std_logic_vector(mergedDelay_raddr_1),
              rd_dout => mergedDelay_regout_1
              );

  Unfp_uminus_comp : nfp_uminus_single
    PORT MAP( nfp_in => Product2_out1_2,
              nfp_out => Conjugate_imag_sig_after
              );

  Uc_product : c_product_block
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              In1_re => Product1_out1_2,
              In1_im => Conjugate_imag_sig_after,
              in2_re => in2_re,
              in2_im => in2_im,
              out_re => c_product_out1_re,
              out_im => c_product_out1_im
              );

  rd_0_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        in1_re_1 <= X"00000000";
        in1_im_1 <= X"00000000";
      ELSIF enb = '1' THEN
        in1_re_1 <= in1_re;
        in1_im_1 <= in1_im;
      END IF;
    END IF;
  END PROCESS rd_0_process;


  Product4_out1_1 <= unsigned(Product4_out1);

  Product3_out1_1 <= unsigned(Product3_out1);

  Complex_to_Real_Imag_out1 <= unsigned(in1_re_1);

  Complex_to_Real_Imag_out2 <= unsigned(in1_im_1);

  mergedInput <= Complex_to_Real_Imag_out1 & Complex_to_Real_Imag_out2;

  -- Input register for RAM-based shift register mergedDelay
  mergedDelay_reginc_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_regin <= to_unsigned(0, 64);
      ELSIF enb = '1' THEN
        mergedDelay_regin <= mergedInput;
      END IF;
    END IF;
  END PROCESS mergedDelay_reginc_process;


  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 10
  -- 
  -- Write address counter for RAM-based shift register mergedDelay
  mergedDelay_wr_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_waddr <= to_unsigned(16#0#, 4);
      ELSIF enb = '1' THEN
        IF mergedDelay_waddr >= to_unsigned(16#A#, 4) THEN 
          mergedDelay_waddr <= to_unsigned(16#0#, 4);
        ELSE 
          mergedDelay_waddr <= mergedDelay_waddr + to_unsigned(16#1#, 4);
        END IF;
      END IF;
    END IF;
  END PROCESS mergedDelay_wr_process;


  mergedDelay_wrenb <= '1';

  -- Count limited, Unsigned Counter
  --  initial value   = 1
  --  step value      = 1
  --  count to value  = 10
  -- 
  -- Read address counter for RAM-based shift register mergedDelay
  mergedDelay_rd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_raddr <= to_unsigned(16#1#, 4);
      ELSIF enb = '1' THEN
        IF mergedDelay_raddr >= to_unsigned(16#A#, 4) THEN 
          mergedDelay_raddr <= to_unsigned(16#0#, 4);
        ELSE 
          mergedDelay_raddr <= mergedDelay_raddr + to_unsigned(16#1#, 4);
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
        mergedOutput <= to_unsigned(0, 64);
      ELSIF enb = '1' THEN
        mergedOutput <= mergedDelay_regout_unsigned;
      END IF;
    END IF;
  END PROCESS mergedDelay_regoutc_process;


  slicedInput <= mergedOutput(31 DOWNTO 0);

  dtcsi1_y <= slicedInput;
  Complex_to_Real_Imag_out2_1 <= std_logic_vector(resize(dtcsi1_y, 32));

  slicedInput_1 <= mergedOutput(63 DOWNTO 32);

  dtcsi0_y <= slicedInput_1;
  Complex_to_Real_Imag_out1_1 <= std_logic_vector(resize(dtcsi0_y, 32));

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 1
  -- 
  -- Write address counter for RAM-based shift register mergedDelay
  mergedDelay_wr_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_waddr_1 <= to_unsigned(16#0#, 2);
      ELSIF enb = '1' THEN
        IF mergedDelay_waddr_1 >= to_unsigned(16#1#, 2) THEN 
          mergedDelay_waddr_1 <= to_unsigned(16#0#, 2);
        ELSE 
          mergedDelay_waddr_1 <= mergedDelay_waddr_1 + to_unsigned(16#1#, 2);
        END IF;
      END IF;
    END IF;
  END PROCESS mergedDelay_wr_1_process;


  mergedDelay_wrenb_1 <= '1';

  -- Count limited, Unsigned Counter
  --  initial value   = 1
  --  step value      = 1
  --  count to value  = 1
  -- 
  -- Read address counter for RAM-based shift register mergedDelay
  mergedDelay_rd_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_raddr_1 <= to_unsigned(16#1#, 2);
      ELSIF enb = '1' THEN
        IF mergedDelay_raddr_1 >= to_unsigned(16#1#, 2) THEN 
          mergedDelay_raddr_1 <= to_unsigned(16#0#, 2);
        ELSE 
          mergedDelay_raddr_1 <= mergedDelay_raddr_1 + to_unsigned(16#1#, 2);
        END IF;
      END IF;
    END IF;
  END PROCESS mergedDelay_rd_1_process;


  Product1_out1_1 <= unsigned(Product1_out1);

  slicedInput_2 <= mergedOutput_1(127 DOWNTO 96);

  dtcsi0_y_1 <= slicedInput_2;
  Product4_out1_2 <= std_logic_vector(resize(dtcsi0_y_1, 32));

  slicedInput_3 <= mergedOutput_1(95 DOWNTO 64);

  dtcsi1_y_1 <= slicedInput_3;
  Product3_out1_2 <= std_logic_vector(resize(dtcsi1_y_1, 32));

  Product2_out1_1 <= unsigned(Product2_out1);

  mergedInput_1 <= Product4_out1_1 & Product3_out1_1 & Product2_out1_1 & Product1_out1_1;

  -- Input register for RAM-based shift register mergedDelay
  mergedDelay_reginc_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedDelay_regin_1 <= to_unsigned(0, 128);
      ELSIF enb = '1' THEN
        mergedDelay_regin_1 <= mergedInput_1;
      END IF;
    END IF;
  END PROCESS mergedDelay_reginc_1_process;


  mergedDelay_regout_unsigned_1 <= unsigned(mergedDelay_regout_1);

  -- Output register for RAM-based shift register mergedDelay
  mergedDelay_regoutc_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        mergedOutput_1 <= to_unsigned(0, 128);
      ELSIF enb = '1' THEN
        mergedOutput_1 <= mergedDelay_regout_unsigned_1;
      END IF;
    END IF;
  END PROCESS mergedDelay_regoutc_1_process;


  slicedInput_4 <= mergedOutput_1(31 DOWNTO 0);

  dtcsi3_y <= slicedInput_4;
  Product1_out1_2 <= std_logic_vector(resize(dtcsi3_y, 32));

  slicedInput_5 <= mergedOutput_1(63 DOWNTO 32);

  dtcsi2_y <= slicedInput_5;
  Product2_out1_2 <= std_logic_vector(resize(dtcsi2_y, 32));

  out_re <= c_product_out1_re;

  out_im <= c_product_out1_im;

END rtl;

