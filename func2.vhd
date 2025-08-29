LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.my_inverse_pac.ALL;

ENTITY func2 IS
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        In1_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        In1_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        In2_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        In2_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        In3_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        In3_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        out_re                            :   OUT   std_logic_vector(31 DOWNTO 0);
        out_im                            :   OUT   std_logic_vector(31 DOWNTO 0)
        );
END func2;


ARCHITECTURE rtl OF func2 IS

  -- Component Declarations
  COMPONENT c_product
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

  COMPONENT nfp_sub_single
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)
          );
  END COMPONENT;

  -- Signals
  SIGNAL Unit_Delay5_out1_re              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay5_out1_im              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Delay2_reg_re                    : vector_of_std_logic_vector32(0 TO 13);
  SIGNAL Delay2_reg_im                    : vector_of_std_logic_vector32(0 TO 13);
  SIGNAL Delay2_reg_next_re               : vector_of_std_logic_vector32(0 TO 13);
  SIGNAL Delay2_reg_next_im               : vector_of_std_logic_vector32(0 TO 13);
  SIGNAL Delay2_out1_re                   : std_logic_vector(31 DOWNTO 0);
  SIGNAL Delay2_out1_im                   : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay2_out1_re              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay2_out1_im              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay3_out1_re              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay3_out1_im              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay4_out1_re              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay4_out1_im              : std_logic_vector(31 DOWNTO 0);
  SIGNAL c_product_out1_re                : std_logic_vector(31 DOWNTO 0);
  SIGNAL c_product_out1_im                : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay1_out1_re              : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay1_out1_im              : std_logic_vector(31 DOWNTO 0);
  SIGNAL nfp_out_1_re                     : std_logic_vector(31 DOWNTO 0);
  SIGNAL nfp_out_1_im                     : std_logic_vector(31 DOWNTO 0);
  SIGNAL Delay_reg_re                     : vector_of_std_logic_vector32(0 TO 8);
  SIGNAL Delay_reg_im                     : vector_of_std_logic_vector32(0 TO 8);
  SIGNAL Delay_reg_next_re                : vector_of_std_logic_vector32(0 TO 8);
  SIGNAL Delay_reg_next_im                : vector_of_std_logic_vector32(0 TO 8);
  SIGNAL Delay_out1_re                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Delay_out1_im                    : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay_out1_re               : std_logic_vector(31 DOWNTO 0);
  SIGNAL Unit_Delay_out1_im               : std_logic_vector(31 DOWNTO 0);

BEGIN
  Uc_product_1 : c_product
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              In1_re => Unit_Delay3_out1_re,
              In1_im => Unit_Delay3_out1_im,
              in2_re => Unit_Delay4_out1_re,
              in2_im => Unit_Delay4_out1_im,
              out_re => c_product_out1_re,
              out_im => c_product_out1_im
              );

  Unfp_sub_comp_2 : nfp_sub_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Unit_Delay2_out1_re,
              nfp_in2 => Unit_Delay1_out1_re,
              nfp_out => nfp_out_1_re
              );

  Unfp_sub_comp_1 : nfp_sub_single
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              nfp_in1 => Unit_Delay2_out1_im,
              nfp_in2 => Unit_Delay1_out1_im,
              nfp_out => nfp_out_1_im
              );

  Unit_Delay5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Unit_Delay5_out1_re <= X"00000000";
        Unit_Delay5_out1_im <= X"00000000";
      ELSIF enb = '1' THEN
        Unit_Delay5_out1_re <= In3_re;
        Unit_Delay5_out1_im <= In3_im;
      END IF;
    END IF;
  END PROCESS Unit_Delay5_process;


  Delay2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_reg_re(0) <= X"00000000";
        Delay2_reg_im(0) <= X"00000000";
        Delay2_reg_re(1) <= X"00000000";
        Delay2_reg_im(1) <= X"00000000";
        Delay2_reg_re(2) <= X"00000000";
        Delay2_reg_im(2) <= X"00000000";
        Delay2_reg_re(3) <= X"00000000";
        Delay2_reg_im(3) <= X"00000000";
        Delay2_reg_re(4) <= X"00000000";
        Delay2_reg_im(4) <= X"00000000";
        Delay2_reg_re(5) <= X"00000000";
        Delay2_reg_im(5) <= X"00000000";
        Delay2_reg_re(6) <= X"00000000";
        Delay2_reg_im(6) <= X"00000000";
        Delay2_reg_re(7) <= X"00000000";
        Delay2_reg_im(7) <= X"00000000";
        Delay2_reg_re(8) <= X"00000000";
        Delay2_reg_im(8) <= X"00000000";
        Delay2_reg_re(9) <= X"00000000";
        Delay2_reg_im(9) <= X"00000000";
        Delay2_reg_re(10) <= X"00000000";
        Delay2_reg_im(10) <= X"00000000";
        Delay2_reg_re(11) <= X"00000000";
        Delay2_reg_im(11) <= X"00000000";
        Delay2_reg_re(12) <= X"00000000";
        Delay2_reg_im(12) <= X"00000000";
        Delay2_reg_re(13) <= X"00000000";
        Delay2_reg_im(13) <= X"00000000";
      ELSIF enb = '1' THEN
        Delay2_reg_re(0) <= Delay2_reg_next_re(0);
        Delay2_reg_im(0) <= Delay2_reg_next_im(0);
        Delay2_reg_re(1) <= Delay2_reg_next_re(1);
        Delay2_reg_im(1) <= Delay2_reg_next_im(1);
        Delay2_reg_re(2) <= Delay2_reg_next_re(2);
        Delay2_reg_im(2) <= Delay2_reg_next_im(2);
        Delay2_reg_re(3) <= Delay2_reg_next_re(3);
        Delay2_reg_im(3) <= Delay2_reg_next_im(3);
        Delay2_reg_re(4) <= Delay2_reg_next_re(4);
        Delay2_reg_im(4) <= Delay2_reg_next_im(4);
        Delay2_reg_re(5) <= Delay2_reg_next_re(5);
        Delay2_reg_im(5) <= Delay2_reg_next_im(5);
        Delay2_reg_re(6) <= Delay2_reg_next_re(6);
        Delay2_reg_im(6) <= Delay2_reg_next_im(6);
        Delay2_reg_re(7) <= Delay2_reg_next_re(7);
        Delay2_reg_im(7) <= Delay2_reg_next_im(7);
        Delay2_reg_re(8) <= Delay2_reg_next_re(8);
        Delay2_reg_im(8) <= Delay2_reg_next_im(8);
        Delay2_reg_re(9) <= Delay2_reg_next_re(9);
        Delay2_reg_im(9) <= Delay2_reg_next_im(9);
        Delay2_reg_re(10) <= Delay2_reg_next_re(10);
        Delay2_reg_im(10) <= Delay2_reg_next_im(10);
        Delay2_reg_re(11) <= Delay2_reg_next_re(11);
        Delay2_reg_im(11) <= Delay2_reg_next_im(11);
        Delay2_reg_re(12) <= Delay2_reg_next_re(12);
        Delay2_reg_im(12) <= Delay2_reg_next_im(12);
        Delay2_reg_re(13) <= Delay2_reg_next_re(13);
        Delay2_reg_im(13) <= Delay2_reg_next_im(13);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1_re <= Delay2_reg_re(13);
  Delay2_out1_im <= Delay2_reg_im(13);
  Delay2_reg_next_re(0) <= Unit_Delay5_out1_re;
  Delay2_reg_next_im(0) <= Unit_Delay5_out1_im;
  Delay2_reg_next_re(1) <= Delay2_reg_re(0);
  Delay2_reg_next_im(1) <= Delay2_reg_im(0);
  Delay2_reg_next_re(2) <= Delay2_reg_re(1);
  Delay2_reg_next_im(2) <= Delay2_reg_im(1);
  Delay2_reg_next_re(3) <= Delay2_reg_re(2);
  Delay2_reg_next_im(3) <= Delay2_reg_im(2);
  Delay2_reg_next_re(4) <= Delay2_reg_re(3);
  Delay2_reg_next_im(4) <= Delay2_reg_im(3);
  Delay2_reg_next_re(5) <= Delay2_reg_re(4);
  Delay2_reg_next_im(5) <= Delay2_reg_im(4);
  Delay2_reg_next_re(6) <= Delay2_reg_re(5);
  Delay2_reg_next_im(6) <= Delay2_reg_im(5);
  Delay2_reg_next_re(7) <= Delay2_reg_re(6);
  Delay2_reg_next_im(7) <= Delay2_reg_im(6);
  Delay2_reg_next_re(8) <= Delay2_reg_re(7);
  Delay2_reg_next_im(8) <= Delay2_reg_im(7);
  Delay2_reg_next_re(9) <= Delay2_reg_re(8);
  Delay2_reg_next_im(9) <= Delay2_reg_im(8);
  Delay2_reg_next_re(10) <= Delay2_reg_re(9);
  Delay2_reg_next_im(10) <= Delay2_reg_im(9);
  Delay2_reg_next_re(11) <= Delay2_reg_re(10);
  Delay2_reg_next_im(11) <= Delay2_reg_im(10);
  Delay2_reg_next_re(12) <= Delay2_reg_re(11);
  Delay2_reg_next_im(12) <= Delay2_reg_im(11);
  Delay2_reg_next_re(13) <= Delay2_reg_re(12);
  Delay2_reg_next_im(13) <= Delay2_reg_im(12);

  Unit_Delay2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Unit_Delay2_out1_re <= X"00000000";
        Unit_Delay2_out1_im <= X"00000000";
      ELSIF enb = '1' THEN
        Unit_Delay2_out1_re <= Delay2_out1_re;
        Unit_Delay2_out1_im <= Delay2_out1_im;
      END IF;
    END IF;
  END PROCESS Unit_Delay2_process;


  Unit_Delay3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Unit_Delay3_out1_re <= X"00000000";
        Unit_Delay3_out1_im <= X"00000000";
      ELSIF enb = '1' THEN
        Unit_Delay3_out1_re <= In1_re;
        Unit_Delay3_out1_im <= In1_im;
      END IF;
    END IF;
  END PROCESS Unit_Delay3_process;


  Unit_Delay4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Unit_Delay4_out1_re <= X"00000000";
        Unit_Delay4_out1_im <= X"00000000";
      ELSIF enb = '1' THEN
        Unit_Delay4_out1_re <= In2_re;
        Unit_Delay4_out1_im <= In2_im;
      END IF;
    END IF;
  END PROCESS Unit_Delay4_process;


  Unit_Delay1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Unit_Delay1_out1_re <= X"00000000";
        Unit_Delay1_out1_im <= X"00000000";
      ELSIF enb = '1' THEN
        Unit_Delay1_out1_re <= c_product_out1_re;
        Unit_Delay1_out1_im <= c_product_out1_im;
      END IF;
    END IF;
  END PROCESS Unit_Delay1_process;


  Delay_rsvd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay_reg_re(0) <= X"00000000";
        Delay_reg_im(0) <= X"00000000";
        Delay_reg_re(1) <= X"00000000";
        Delay_reg_im(1) <= X"00000000";
        Delay_reg_re(2) <= X"00000000";
        Delay_reg_im(2) <= X"00000000";
        Delay_reg_re(3) <= X"00000000";
        Delay_reg_im(3) <= X"00000000";
        Delay_reg_re(4) <= X"00000000";
        Delay_reg_im(4) <= X"00000000";
        Delay_reg_re(5) <= X"00000000";
        Delay_reg_im(5) <= X"00000000";
        Delay_reg_re(6) <= X"00000000";
        Delay_reg_im(6) <= X"00000000";
        Delay_reg_re(7) <= X"00000000";
        Delay_reg_im(7) <= X"00000000";
        Delay_reg_re(8) <= X"00000000";
        Delay_reg_im(8) <= X"00000000";
      ELSIF enb = '1' THEN
        Delay_reg_re(0) <= Delay_reg_next_re(0);
        Delay_reg_im(0) <= Delay_reg_next_im(0);
        Delay_reg_re(1) <= Delay_reg_next_re(1);
        Delay_reg_im(1) <= Delay_reg_next_im(1);
        Delay_reg_re(2) <= Delay_reg_next_re(2);
        Delay_reg_im(2) <= Delay_reg_next_im(2);
        Delay_reg_re(3) <= Delay_reg_next_re(3);
        Delay_reg_im(3) <= Delay_reg_next_im(3);
        Delay_reg_re(4) <= Delay_reg_next_re(4);
        Delay_reg_im(4) <= Delay_reg_next_im(4);
        Delay_reg_re(5) <= Delay_reg_next_re(5);
        Delay_reg_im(5) <= Delay_reg_next_im(5);
        Delay_reg_re(6) <= Delay_reg_next_re(6);
        Delay_reg_im(6) <= Delay_reg_next_im(6);
        Delay_reg_re(7) <= Delay_reg_next_re(7);
        Delay_reg_im(7) <= Delay_reg_next_im(7);
        Delay_reg_re(8) <= Delay_reg_next_re(8);
        Delay_reg_im(8) <= Delay_reg_next_im(8);
      END IF;
    END IF;
  END PROCESS Delay_rsvd_process;

  Delay_out1_re <= Delay_reg_re(8);
  Delay_out1_im <= Delay_reg_im(8);
  Delay_reg_next_re(0) <= nfp_out_1_re;
  Delay_reg_next_im(0) <= nfp_out_1_im;
  Delay_reg_next_re(1) <= Delay_reg_re(0);
  Delay_reg_next_im(1) <= Delay_reg_im(0);
  Delay_reg_next_re(2) <= Delay_reg_re(1);
  Delay_reg_next_im(2) <= Delay_reg_im(1);
  Delay_reg_next_re(3) <= Delay_reg_re(2);
  Delay_reg_next_im(3) <= Delay_reg_im(2);
  Delay_reg_next_re(4) <= Delay_reg_re(3);
  Delay_reg_next_im(4) <= Delay_reg_im(3);
  Delay_reg_next_re(5) <= Delay_reg_re(4);
  Delay_reg_next_im(5) <= Delay_reg_im(4);
  Delay_reg_next_re(6) <= Delay_reg_re(5);
  Delay_reg_next_im(6) <= Delay_reg_im(5);
  Delay_reg_next_re(7) <= Delay_reg_re(6);
  Delay_reg_next_im(7) <= Delay_reg_im(6);
  Delay_reg_next_re(8) <= Delay_reg_re(7);
  Delay_reg_next_im(8) <= Delay_reg_im(7);

  Unit_Delay_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Unit_Delay_out1_re <= X"00000000";
        Unit_Delay_out1_im <= X"00000000";
      ELSIF enb = '1' THEN
        Unit_Delay_out1_re <= Delay_out1_re;
        Unit_Delay_out1_im <= Delay_out1_im;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  out_re <= Unit_Delay_out1_re;

  out_im <= Unit_Delay_out1_im;

END rtl;

