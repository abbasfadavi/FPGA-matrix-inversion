LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.my_inverse_pac.ALL;

ENTITY nfp_hdlrecip_single IS
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        nfp_in                            :   IN    std_logic_vector(31 DOWNTO 0);
        nfp_out                           :   OUT   std_logic_vector(31 DOWNTO 0)
        );
END nfp_hdlrecip_single;


ARCHITECTURE rtl OF nfp_hdlrecip_single IS

  -- Signals
  SIGNAL nfp_in_unsigned                  : unsigned(31 DOWNTO 0);
  SIGNAL S_S                              : std_logic;
  SIGNAL E_E                              : unsigned(7 DOWNTO 0);
  SIGNAL M_M                              : unsigned(22 DOWNTO 0);
  SIGNAL Delay4_reg_rsvd                  : std_logic_vector(0 TO 13);
  SIGNAL Delay4_reg_next                  : std_logic_vector(0 TO 13);
  SIGNAL Delay4_out1                      : std_logic;
  SIGNAL Delay2_reg_rsvd                  : std_logic_vector(0 TO 1);
  SIGNAL Delay2_reg_next                  : std_logic_vector(0 TO 1);
  SIGNAL Delay2_out1                      : std_logic;
  SIGNAL Delay7_out1                      : std_logic;
  SIGNAL Constant8_out1                   : std_logic;
  SIGNAL Constant7_out1                   : unsigned(7 DOWNTO 0);
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL Delay4_out1_1                    : std_logic;
  SIGNAL Logical_Operator2_out1           : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL Add_out1                         : unsigned(7 DOWNTO 0);
  SIGNAL Delay3_out1                      : unsigned(7 DOWNTO 0);
  SIGNAL Add_add_cast                     : unsigned(7 DOWNTO 0);
  SIGNAL Constant1_out1                   : unsigned(7 DOWNTO 0);
  SIGNAL Delay8_reg_rsvd                  : vector_of_unsigned8(0 TO 13);
  SIGNAL Delay8_reg_next                  : vector_of_unsigned8(0 TO 13);
  SIGNAL Delay8_out1                      : unsigned(7 DOWNTO 0);
  SIGNAL CompareTo_Zero3_out1             : std_logic;
  SIGNAL Constant_out1                    : std_logic;
  SIGNAL Delay10_reg_rsvd                 : std_logic_vector(0 TO 12);
  SIGNAL Delay10_reg_next                 : std_logic_vector(0 TO 12);
  SIGNAL Delay10_out1                     : std_logic;
  SIGNAL Logical_Operator4_out1           : std_logic;
  SIGNAL Logical_Operator4_out1_1         : std_logic;
  SIGNAL CompareTo_Constant_out1          : std_logic;
  SIGNAL Delay5_out1                      : std_logic;
  SIGNAL Logical_Operator_out1_1          : std_logic;
  SIGNAL Delay2_out1_1                    : std_logic;
  SIGNAL Constant4_out1                   : unsigned(7 DOWNTO 0);
  SIGNAL Constant4_out1_dtc               : signed(8 DOWNTO 0);
  SIGNAL Constant3_out1                   : unsigned(7 DOWNTO 0);
  SIGNAL Constant3_out1_dtc               : signed(8 DOWNTO 0);
  SIGNAL Switch1_out1                     : signed(8 DOWNTO 0);
  SIGNAL Sum_sub_cast                     : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_temp                     : signed(31 DOWNTO 0);
  SIGNAL Sum_out1                         : signed(8 DOWNTO 0);
  SIGNAL Delay1_out1                      : signed(8 DOWNTO 0);
  SIGNAL Constant6_out1                   : std_logic;
  SIGNAL Constant_out1_1                  : std_logic;
  SIGNAL Switch5_out1                     : std_logic;
  SIGNAL Bit_Concat_out1                  : unsigned(23 DOWNTO 0);
  SIGNAL Delay3_out1_1                    : unsigned(23 DOWNTO 0);
  SIGNAL Bit_Slice8_out1                  : std_logic;
  SIGNAL Constant13_out1                  : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice7_out1                  : std_logic;
  SIGNAL Constant12_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch12_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice6_out1                  : std_logic;
  SIGNAL Constant11_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch11_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice5_out1                  : std_logic;
  SIGNAL Constant10_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch10_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice4_out1                  : std_logic;
  SIGNAL Constant9_out1                   : signed(8 DOWNTO 0);
  SIGNAL Switch9_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice3_out1                  : std_logic;
  SIGNAL Constant8_out1_1                 : signed(8 DOWNTO 0);
  SIGNAL Switch8_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice2_out1                  : std_logic;
  SIGNAL Constant7_out1_1                 : signed(8 DOWNTO 0);
  SIGNAL Switch7_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice1_out1                  : std_logic;
  SIGNAL Constant6_out1_1                 : signed(8 DOWNTO 0);
  SIGNAL Switch6_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice_out1                   : std_logic;
  SIGNAL Constant5_out1                   : signed(8 DOWNTO 0);
  SIGNAL Switch5_out1_1                   : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice26_out1                 : std_logic;
  SIGNAL Constant4_out1_1                 : signed(8 DOWNTO 0);
  SIGNAL Switch4_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice25_out1                 : std_logic;
  SIGNAL Constant3_out1_1                 : signed(8 DOWNTO 0);
  SIGNAL Switch3_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice24_out1                 : std_logic;
  SIGNAL Constant2_out1                   : signed(8 DOWNTO 0);
  SIGNAL Switch2_out1                     : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice27_out1                 : std_logic;
  SIGNAL Constant1_out1_1                 : signed(8 DOWNTO 0);
  SIGNAL Switch1_out1_1                   : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice15_out1                 : std_logic;
  SIGNAL Constant124_out1                 : signed(8 DOWNTO 0);
  SIGNAL Switch116_out1                   : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice16_out1                 : std_logic;
  SIGNAL Constant28_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch17_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice17_out1                 : std_logic;
  SIGNAL Constant26_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch18_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice28_out1                 : std_logic;
  SIGNAL Constant27_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch19_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice29_out1                 : std_logic;
  SIGNAL Constant29_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch28_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice30_out1                 : std_logic;
  SIGNAL Constant30_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch29_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice31_out1                 : std_logic;
  SIGNAL Constant31_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch30_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice32_out1                 : std_logic;
  SIGNAL Constant32_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch31_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice33_out1                 : std_logic;
  SIGNAL Constant33_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch32_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice34_out1                 : std_logic;
  SIGNAL Constant34_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch33_out1                    : signed(8 DOWNTO 0);
  SIGNAL Bit_Slice35_out1                 : std_logic;
  SIGNAL Constant35_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch34_out1                    : signed(8 DOWNTO 0);
  SIGNAL Constant36_out1                  : signed(8 DOWNTO 0);
  SIGNAL Switch35_out1                    : signed(8 DOWNTO 0);
  SIGNAL Sum1_sub_temp                    : signed(31 DOWNTO 0);
  SIGNAL Sum1_out1                        : signed(8 DOWNTO 0);
  SIGNAL Delay1_reg_rsvd                  : vector_of_signed9(0 TO 12);
  SIGNAL Delay1_reg_next                  : vector_of_signed9(0 TO 12);
  SIGNAL Delay1_out1_1                    : signed(8 DOWNTO 0);
  SIGNAL Unary_Minus_in0                  : signed(9 DOWNTO 0);
  SIGNAL Unary_Minus_out1                 : signed(8 DOWNTO 0);
  SIGNAL Delay4_out1_2                    : signed(8 DOWNTO 0);
  SIGNAL Constant_out1_2                  : unsigned(24 DOWNTO 0);
  SIGNAL Constant_out1_3                  : unsigned(24 DOWNTO 0);
  SIGNAL Constant_out1_4                  : unsigned(24 DOWNTO 0);
  SIGNAL Constant_out1_5                  : unsigned(24 DOWNTO 0);
  SIGNAL x0_out1                          : unsigned(24 DOWNTO 0);
  SIGNAL shift_arithmetic_zerosig         : signed(8 DOWNTO 0);
  SIGNAL shift_arithmetic_selsig          : signed(8 DOWNTO 0);
  SIGNAL dynamic_shift_zerosig            : signed(8 DOWNTO 0);
  SIGNAL dynamic_shift_selsig             : signed(8 DOWNTO 0);
  SIGNAL Shift_Arithmetic_out1            : unsigned(23 DOWNTO 0);
  SIGNAL Delay_out1                       : unsigned(23 DOWNTO 0);
  SIGNAL Bit_Shift_out1                   : unsigned(23 DOWNTO 0);
  SIGNAL Bit_Slice_out1_1                 : unsigned(22 DOWNTO 0);
  SIGNAL Data_Type_Conversion_out1        : unsigned(22 DOWNTO 0);
  SIGNAL Product_mul_temp                 : unsigned(47 DOWNTO 0);
  SIGNAL Product_out1                     : unsigned(24 DOWNTO 0);
  SIGNAL Delay1_out1_2                    : unsigned(24 DOWNTO 0);
  SIGNAL Sum_sub_cast_1                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_cast_2                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_temp_1                   : signed(31 DOWNTO 0);
  SIGNAL Sum_out1_1                       : unsigned(24 DOWNTO 0);
  SIGNAL Delay4_out1_3                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay3_out1_2                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay5_out1_1                    : unsigned(24 DOWNTO 0);
  SIGNAL Product1_mul_temp                : unsigned(49 DOWNTO 0);
  SIGNAL Product1_out1                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay2_out1_2                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay_reg_rsvd                   : vector_of_unsigned23(0 TO 2);
  SIGNAL Delay_reg_next                   : vector_of_unsigned23(0 TO 2);
  SIGNAL Delay_out1_1                     : unsigned(22 DOWNTO 0);
  SIGNAL Product_mul_temp_1               : unsigned(47 DOWNTO 0);
  SIGNAL Product_out1_1                   : unsigned(24 DOWNTO 0);
  SIGNAL Delay1_out1_3                    : unsigned(24 DOWNTO 0);
  SIGNAL Sum_sub_cast_3                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_cast_4                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_temp_2                   : signed(31 DOWNTO 0);
  SIGNAL Sum_out1_2                       : unsigned(24 DOWNTO 0);
  SIGNAL Delay4_out1_4                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay3_out1_3                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay5_out1_2                    : unsigned(24 DOWNTO 0);
  SIGNAL Product1_mul_temp_1              : unsigned(49 DOWNTO 0);
  SIGNAL Product1_out1_1                  : unsigned(24 DOWNTO 0);
  SIGNAL Delay2_out1_3                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay_reg_rsvd_1                 : vector_of_unsigned23(0 TO 2);
  SIGNAL Delay_reg_next_1                 : vector_of_unsigned23(0 TO 2);
  SIGNAL Delay_out1_2                     : unsigned(22 DOWNTO 0);
  SIGNAL Product_mul_temp_2               : unsigned(47 DOWNTO 0);
  SIGNAL Product_out1_2                   : unsigned(24 DOWNTO 0);
  SIGNAL Delay1_out1_4                    : unsigned(24 DOWNTO 0);
  SIGNAL Sum_sub_cast_5                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_cast_6                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_temp_3                   : signed(31 DOWNTO 0);
  SIGNAL Sum_out1_3                       : unsigned(24 DOWNTO 0);
  SIGNAL Delay4_out1_5                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay3_out1_4                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay5_out1_3                    : unsigned(24 DOWNTO 0);
  SIGNAL Product1_mul_temp_2              : unsigned(49 DOWNTO 0);
  SIGNAL Product1_out1_2                  : unsigned(24 DOWNTO 0);
  SIGNAL Delay2_out1_4                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay_reg_rsvd_2                 : vector_of_unsigned23(0 TO 2);
  SIGNAL Delay_reg_next_2                 : vector_of_unsigned23(0 TO 2);
  SIGNAL Delay_out1_3                     : unsigned(22 DOWNTO 0);
  SIGNAL Product_mul_temp_3               : unsigned(47 DOWNTO 0);
  SIGNAL Product_out1_3                   : unsigned(24 DOWNTO 0);
  SIGNAL Delay1_out1_5                    : unsigned(24 DOWNTO 0);
  SIGNAL Sum_sub_cast_7                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_cast_8                   : signed(31 DOWNTO 0);
  SIGNAL Sum_sub_temp_4                   : signed(31 DOWNTO 0);
  SIGNAL Sum_out1_4                       : unsigned(24 DOWNTO 0);
  SIGNAL Delay4_out1_6                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay3_out1_5                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay5_out1_4                    : unsigned(24 DOWNTO 0);
  SIGNAL Product1_mul_temp_3              : unsigned(49 DOWNTO 0);
  SIGNAL Product1_out1_3                  : unsigned(24 DOWNTO 0);
  SIGNAL Delay2_out1_5                    : unsigned(24 DOWNTO 0);
  SIGNAL Data_Type_Conversion1_out1       : unsigned(24 DOWNTO 0);
  SIGNAL Bit_Slice23_out1                 : std_logic;
  SIGNAL Constant23_out1                  : signed(2 DOWNTO 0);
  SIGNAL Bit_Slice22_out1                 : std_logic;
  SIGNAL Constant24_out1                  : signed(2 DOWNTO 0);
  SIGNAL Switch23_out1                    : signed(2 DOWNTO 0);
  SIGNAL Bit_Slice21_out1                 : std_logic;
  SIGNAL Constant22_out1                  : signed(2 DOWNTO 0);
  SIGNAL Switch22_out1                    : signed(2 DOWNTO 0);
  SIGNAL Constant21_out1                  : signed(2 DOWNTO 0);
  SIGNAL Switch21_out1                    : signed(2 DOWNTO 0);
  SIGNAL Delay3_out1_6                    : signed(2 DOWNTO 0);
  SIGNAL Subtract_sub_temp                : signed(31 DOWNTO 0);
  SIGNAL Subtract_out1                    : signed(9 DOWNTO 0);
  SIGNAL Constant_out1_6                  : unsigned(7 DOWNTO 0);
  SIGNAL Subtract1_add_cast               : signed(31 DOWNTO 0);
  SIGNAL Subtract1_add_temp               : signed(31 DOWNTO 0);
  SIGNAL Subtract1_out1                   : signed(9 DOWNTO 0);
  SIGNAL Delay9_out1                      : signed(9 DOWNTO 0);
  SIGNAL Abs1_y                           : signed(10 DOWNTO 0);
  SIGNAL Abs1_out1                        : signed(9 DOWNTO 0);
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Compare_To_Zero1_out1            : std_logic;
  SIGNAL Data_Type_Conversion_out1_1      : unsigned(7 DOWNTO 0);
  SIGNAL Constant1_out1_2                 : unsigned(7 DOWNTO 0);
  SIGNAL Switch2_out1_1                   : unsigned(7 DOWNTO 0);
  SIGNAL Constant3_out1_2                 : unsigned(7 DOWNTO 0);
  SIGNAL Switch4_out1_1                   : unsigned(7 DOWNTO 0);
  SIGNAL Delay9_reg_rsvd                  : vector_of_unsigned23(0 TO 13);
  SIGNAL Delay9_reg_next                  : vector_of_unsigned23(0 TO 13);
  SIGNAL Delay9_out1_1                    : unsigned(22 DOWNTO 0);
  SIGNAL CompareTo_Zero1_out1             : std_logic;
  SIGNAL Constant3_out1_3                 : unsigned(7 DOWNTO 0);
  SIGNAL Constant2_out1_1                 : unsigned(7 DOWNTO 0);
  SIGNAL Switch1_out1_2                   : unsigned(7 DOWNTO 0);
  SIGNAL Delay4_out1_7                    : unsigned(7 DOWNTO 0);
  SIGNAL Constant_out1_7                  : unsigned(7 DOWNTO 0);
  SIGNAL Switch_out1                      : unsigned(7 DOWNTO 0);
  SIGNAL Delay1_out1_6                    : unsigned(7 DOWNTO 0);
  SIGNAL Switch3_out1_1                   : unsigned(7 DOWNTO 0);
  SIGNAL Switch4_out1_2                   : unsigned(7 DOWNTO 0);
  SIGNAL Delay3_out1_7                    : unsigned(7 DOWNTO 0);
  SIGNAL Constant_out1_8                  : unsigned(22 DOWNTO 0);
  SIGNAL CompareTo_Zero2_out1             : std_logic;
  SIGNAL Logical_Operator1_out1           : std_logic;
  SIGNAL Logical_Operator3_out1           : std_logic;
  SIGNAL Logical_Operator2_out1_1         : std_logic;
  SIGNAL LogicalOperator1_out1            : std_logic;
  SIGNAL Delay8_out1_1                    : std_logic;
  SIGNAL Compare_To_Zero_out1             : std_logic;
  SIGNAL Delay_out1_4                     : unsigned(24 DOWNTO 0);
  SIGNAL Abs_y                            : signed(3 DOWNTO 0);
  SIGNAL Abs_out1                         : signed(2 DOWNTO 0);
  SIGNAL Bit_Slice_out1_2                 : unsigned(2 DOWNTO 0);
  SIGNAL dynamic_shift_cast               : unsigned(7 DOWNTO 0);
  SIGNAL Shift_Arithmetic_out1_1          : unsigned(24 DOWNTO 0);
  SIGNAL Bit_Shift_out1_1                 : unsigned(24 DOWNTO 0);
  SIGNAL Delay1_out1_7                    : unsigned(24 DOWNTO 0);
  SIGNAL Switch_out1_1                    : unsigned(24 DOWNTO 0);
  SIGNAL Delay12_out1                     : unsigned(24 DOWNTO 0);
  SIGNAL Bit_Slice1_out1_1                : unsigned(22 DOWNTO 0);
  SIGNAL Compare_To_Zero2_out1            : std_logic;
  SIGNAL Bit_Slice5_out1_1                : std_logic;
  SIGNAL Bit_Slice3_out1_1                : std_logic;
  SIGNAL Logical_Operator2_out1_2         : std_logic;
  SIGNAL Bit_Slice4_out1_1                : std_logic;
  SIGNAL Logical_Operator1_out1_1         : std_logic;
  SIGNAL Logical_Operator_out1_2          : std_logic;
  SIGNAL Switch7_out1_1                   : std_logic;
  SIGNAL Bit_Slice2_out1_1                : unsigned(22 DOWNTO 0);
  SIGNAL Constant2_out1_2                 : unsigned(22 DOWNTO 0);
  SIGNAL Sum_out1_5                       : unsigned(22 DOWNTO 0);
  SIGNAL Switch6_out1_1                   : unsigned(22 DOWNTO 0);
  SIGNAL Bit_Shift2_out1                  : unsigned(22 DOWNTO 0);
  SIGNAL Switch3_out1_2                   : unsigned(22 DOWNTO 0);
  SIGNAL Switch1_out1_3                   : unsigned(22 DOWNTO 0);
  SIGNAL Constant4_out1_2                 : unsigned(22 DOWNTO 0);
  SIGNAL Switch5_out1_2                   : unsigned(22 DOWNTO 0);
  SIGNAL Constant1_out1_3                 : unsigned(22 DOWNTO 0);
  SIGNAL Delay16_out1                     : unsigned(22 DOWNTO 0);
  SIGNAL Bit_Set_out1                     : unsigned(22 DOWNTO 0);
  SIGNAL Switch2_out1_2                   : unsigned(22 DOWNTO 0);
  SIGNAL Delay17_out1                     : unsigned(22 DOWNTO 0);
  SIGNAL Switch1_out1_4                   : unsigned(22 DOWNTO 0);
  SIGNAL Switch2_out1_3                   : unsigned(22 DOWNTO 0);
  SIGNAL Delay6_out1                      : unsigned(22 DOWNTO 0);
  SIGNAL nfp_out_pack                     : unsigned(31 DOWNTO 0);

BEGIN
  nfp_in_unsigned <= unsigned(nfp_in);

  -- Split 32 bit word into FP sign, exponent, mantissa
  S_S <= nfp_in_unsigned(31);
  E_E <= nfp_in_unsigned(30 DOWNTO 23);
  M_M <= nfp_in_unsigned(22 DOWNTO 0);

  Delay4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_reg_rsvd(0) <= '0';
        Delay4_reg_rsvd(1) <= '0';
        Delay4_reg_rsvd(2) <= '0';
        Delay4_reg_rsvd(3) <= '0';
        Delay4_reg_rsvd(4) <= '0';
        Delay4_reg_rsvd(5) <= '0';
        Delay4_reg_rsvd(6) <= '0';
        Delay4_reg_rsvd(7) <= '0';
        Delay4_reg_rsvd(8) <= '0';
        Delay4_reg_rsvd(9) <= '0';
        Delay4_reg_rsvd(10) <= '0';
        Delay4_reg_rsvd(11) <= '0';
        Delay4_reg_rsvd(12) <= '0';
        Delay4_reg_rsvd(13) <= '0';
      ELSIF enb = '1' THEN
        Delay4_reg_rsvd(0) <= Delay4_reg_next(0);
        Delay4_reg_rsvd(1) <= Delay4_reg_next(1);
        Delay4_reg_rsvd(2) <= Delay4_reg_next(2);
        Delay4_reg_rsvd(3) <= Delay4_reg_next(3);
        Delay4_reg_rsvd(4) <= Delay4_reg_next(4);
        Delay4_reg_rsvd(5) <= Delay4_reg_next(5);
        Delay4_reg_rsvd(6) <= Delay4_reg_next(6);
        Delay4_reg_rsvd(7) <= Delay4_reg_next(7);
        Delay4_reg_rsvd(8) <= Delay4_reg_next(8);
        Delay4_reg_rsvd(9) <= Delay4_reg_next(9);
        Delay4_reg_rsvd(10) <= Delay4_reg_next(10);
        Delay4_reg_rsvd(11) <= Delay4_reg_next(11);
        Delay4_reg_rsvd(12) <= Delay4_reg_next(12);
        Delay4_reg_rsvd(13) <= Delay4_reg_next(13);
      END IF;
    END IF;
  END PROCESS Delay4_process;

  Delay4_out1 <= Delay4_reg_rsvd(13);
  Delay4_reg_next(0) <= S_S;
  Delay4_reg_next(1) <= Delay4_reg_rsvd(0);
  Delay4_reg_next(2) <= Delay4_reg_rsvd(1);
  Delay4_reg_next(3) <= Delay4_reg_rsvd(2);
  Delay4_reg_next(4) <= Delay4_reg_rsvd(3);
  Delay4_reg_next(5) <= Delay4_reg_rsvd(4);
  Delay4_reg_next(6) <= Delay4_reg_rsvd(5);
  Delay4_reg_next(7) <= Delay4_reg_rsvd(6);
  Delay4_reg_next(8) <= Delay4_reg_rsvd(7);
  Delay4_reg_next(9) <= Delay4_reg_rsvd(8);
  Delay4_reg_next(10) <= Delay4_reg_rsvd(9);
  Delay4_reg_next(11) <= Delay4_reg_rsvd(10);
  Delay4_reg_next(12) <= Delay4_reg_rsvd(11);
  Delay4_reg_next(13) <= Delay4_reg_rsvd(12);

  Delay2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_reg_rsvd(0) <= '0';
        Delay2_reg_rsvd(1) <= '0';
      ELSIF enb = '1' THEN
        Delay2_reg_rsvd(0) <= Delay2_reg_next(0);
        Delay2_reg_rsvd(1) <= Delay2_reg_next(1);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1 <= Delay2_reg_rsvd(1);
  Delay2_reg_next(0) <= Delay4_out1;
  Delay2_reg_next(1) <= Delay2_reg_rsvd(0);

  Delay7_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay7_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay7_out1 <= Delay2_out1;
      END IF;
    END IF;
  END PROCESS Delay7_process;


  Constant8_out1 <= '1';

  Constant7_out1 <= to_unsigned(16#10#, 8);

  Delay4_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_1 <= '0';
      ELSIF enb = '1' THEN
        Delay4_out1_1 <= Relational_Operator_relop1;
      END IF;
    END IF;
  END PROCESS Delay4_1_process;


  Logical_Operator2_out1 <=  NOT Delay4_out1_1;

  Logical_Operator_out1 <= Constant8_out1 AND Logical_Operator2_out1;

  Delay3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1 <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        Delay3_out1 <= Add_out1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  Add_add_cast <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & Logical_Operator_out1;
  Add_out1 <= Delay3_out1 + Add_add_cast;

  
  Relational_Operator_relop1 <= '1' WHEN Add_out1 > Constant7_out1 ELSE
      '0';

  Constant1_out1 <= to_unsigned(16#00#, 8);

  Delay8_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay8_reg_rsvd(0) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(1) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(2) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(3) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(4) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(5) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(6) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(7) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(8) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(9) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(10) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(11) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(12) <= to_unsigned(16#00#, 8);
        Delay8_reg_rsvd(13) <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        Delay8_reg_rsvd(0) <= Delay8_reg_next(0);
        Delay8_reg_rsvd(1) <= Delay8_reg_next(1);
        Delay8_reg_rsvd(2) <= Delay8_reg_next(2);
        Delay8_reg_rsvd(3) <= Delay8_reg_next(3);
        Delay8_reg_rsvd(4) <= Delay8_reg_next(4);
        Delay8_reg_rsvd(5) <= Delay8_reg_next(5);
        Delay8_reg_rsvd(6) <= Delay8_reg_next(6);
        Delay8_reg_rsvd(7) <= Delay8_reg_next(7);
        Delay8_reg_rsvd(8) <= Delay8_reg_next(8);
        Delay8_reg_rsvd(9) <= Delay8_reg_next(9);
        Delay8_reg_rsvd(10) <= Delay8_reg_next(10);
        Delay8_reg_rsvd(11) <= Delay8_reg_next(11);
        Delay8_reg_rsvd(12) <= Delay8_reg_next(12);
        Delay8_reg_rsvd(13) <= Delay8_reg_next(13);
      END IF;
    END IF;
  END PROCESS Delay8_process;

  Delay8_out1 <= Delay8_reg_rsvd(13);
  Delay8_reg_next(0) <= E_E;
  Delay8_reg_next(1) <= Delay8_reg_rsvd(0);
  Delay8_reg_next(2) <= Delay8_reg_rsvd(1);
  Delay8_reg_next(3) <= Delay8_reg_rsvd(2);
  Delay8_reg_next(4) <= Delay8_reg_rsvd(3);
  Delay8_reg_next(5) <= Delay8_reg_rsvd(4);
  Delay8_reg_next(6) <= Delay8_reg_rsvd(5);
  Delay8_reg_next(7) <= Delay8_reg_rsvd(6);
  Delay8_reg_next(8) <= Delay8_reg_rsvd(7);
  Delay8_reg_next(9) <= Delay8_reg_rsvd(8);
  Delay8_reg_next(10) <= Delay8_reg_rsvd(9);
  Delay8_reg_next(11) <= Delay8_reg_rsvd(10);
  Delay8_reg_next(12) <= Delay8_reg_rsvd(11);
  Delay8_reg_next(13) <= Delay8_reg_rsvd(12);

  
  CompareTo_Zero3_out1 <= '1' WHEN Delay8_out1 = to_unsigned(16#00#, 8) ELSE
      '0';

  Constant_out1 <= '0';

  Delay10_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay10_reg_rsvd(0) <= '0';
        Delay10_reg_rsvd(1) <= '0';
        Delay10_reg_rsvd(2) <= '0';
        Delay10_reg_rsvd(3) <= '0';
        Delay10_reg_rsvd(4) <= '0';
        Delay10_reg_rsvd(5) <= '0';
        Delay10_reg_rsvd(6) <= '0';
        Delay10_reg_rsvd(7) <= '0';
        Delay10_reg_rsvd(8) <= '0';
        Delay10_reg_rsvd(9) <= '0';
        Delay10_reg_rsvd(10) <= '0';
        Delay10_reg_rsvd(11) <= '0';
        Delay10_reg_rsvd(12) <= '0';
      ELSIF enb = '1' THEN
        Delay10_reg_rsvd(0) <= Delay10_reg_next(0);
        Delay10_reg_rsvd(1) <= Delay10_reg_next(1);
        Delay10_reg_rsvd(2) <= Delay10_reg_next(2);
        Delay10_reg_rsvd(3) <= Delay10_reg_next(3);
        Delay10_reg_rsvd(4) <= Delay10_reg_next(4);
        Delay10_reg_rsvd(5) <= Delay10_reg_next(5);
        Delay10_reg_rsvd(6) <= Delay10_reg_next(6);
        Delay10_reg_rsvd(7) <= Delay10_reg_next(7);
        Delay10_reg_rsvd(8) <= Delay10_reg_next(8);
        Delay10_reg_rsvd(9) <= Delay10_reg_next(9);
        Delay10_reg_rsvd(10) <= Delay10_reg_next(10);
        Delay10_reg_rsvd(11) <= Delay10_reg_next(11);
        Delay10_reg_rsvd(12) <= Delay10_reg_next(12);
      END IF;
    END IF;
  END PROCESS Delay10_process;

  Delay10_out1 <= Delay10_reg_rsvd(12);
  Delay10_reg_next(0) <= Constant_out1;
  Delay10_reg_next(1) <= Delay10_reg_rsvd(0);
  Delay10_reg_next(2) <= Delay10_reg_rsvd(1);
  Delay10_reg_next(3) <= Delay10_reg_rsvd(2);
  Delay10_reg_next(4) <= Delay10_reg_rsvd(3);
  Delay10_reg_next(5) <= Delay10_reg_rsvd(4);
  Delay10_reg_next(6) <= Delay10_reg_rsvd(5);
  Delay10_reg_next(7) <= Delay10_reg_rsvd(6);
  Delay10_reg_next(8) <= Delay10_reg_rsvd(7);
  Delay10_reg_next(9) <= Delay10_reg_rsvd(8);
  Delay10_reg_next(10) <= Delay10_reg_rsvd(9);
  Delay10_reg_next(11) <= Delay10_reg_rsvd(10);
  Delay10_reg_next(12) <= Delay10_reg_rsvd(11);

  Logical_Operator4_out1 <= CompareTo_Zero3_out1 AND Delay10_out1;

  reduced_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Logical_Operator4_out1_1 <= '0';
      ELSIF enb = '1' THEN
        Logical_Operator4_out1_1 <= Logical_Operator4_out1;
      END IF;
    END IF;
  END PROCESS reduced_process;


  
  CompareTo_Constant_out1 <= '1' WHEN Delay8_out1 = to_unsigned(16#FF#, 8) ELSE
      '0';

  Delay5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay5_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay5_out1 <= CompareTo_Constant_out1;
      END IF;
    END IF;
  END PROCESS Delay5_process;


  Logical_Operator_out1_1 <= Logical_Operator4_out1_1 OR Delay5_out1;

  Delay2_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_out1_1 <= '0';
      ELSIF enb = '1' THEN
        Delay2_out1_1 <= Logical_Operator_out1_1;
      END IF;
    END IF;
  END PROCESS Delay2_1_process;


  Constant4_out1 <= to_unsigned(16#7D#, 8);

  Constant4_out1_dtc <= signed(resize(Constant4_out1, 9));

  Constant3_out1 <= to_unsigned(16#7E#, 8);

  Constant3_out1_dtc <= signed(resize(Constant3_out1, 9));

  
  Switch1_out1 <= Constant4_out1_dtc WHEN E_E = to_unsigned(16#00#, 8) ELSE
      Constant3_out1_dtc;

  Sum_sub_cast <= signed(resize(E_E, 32));
  Sum_sub_temp <= Sum_sub_cast - resize(Switch1_out1, 32);
  Sum_out1 <= Sum_sub_temp(8 DOWNTO 0);

  Delay1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1 <= to_signed(16#000#, 9);
      ELSIF enb = '1' THEN
        Delay1_out1 <= Sum_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  Constant6_out1 <= '0';

  Constant_out1_1 <= '1';

  
  Switch5_out1 <= Constant6_out1 WHEN E_E = to_unsigned(16#00#, 8) ELSE
      Constant_out1_1;

  Bit_Concat_out1 <= Switch5_out1 & M_M;

  Delay3_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_1 <= to_unsigned(16#000000#, 24);
      ELSIF enb = '1' THEN
        Delay3_out1_1 <= Bit_Concat_out1;
      END IF;
    END IF;
  END PROCESS Delay3_1_process;


  Bit_Slice8_out1 <= Delay3_out1_1(0);

  Constant13_out1 <= to_signed(16#018#, 9);

  Bit_Slice7_out1 <= Delay3_out1_1(1);

  Constant12_out1 <= to_signed(16#017#, 9);

  
  Switch12_out1 <= Constant13_out1 WHEN Bit_Slice8_out1 = '0' ELSE
      Constant12_out1;

  Bit_Slice6_out1 <= Delay3_out1_1(2);

  Constant11_out1 <= to_signed(16#016#, 9);

  
  Switch11_out1 <= Switch12_out1 WHEN Bit_Slice7_out1 = '0' ELSE
      Constant11_out1;

  Bit_Slice5_out1 <= Delay3_out1_1(3);

  Constant10_out1 <= to_signed(16#015#, 9);

  
  Switch10_out1 <= Switch11_out1 WHEN Bit_Slice6_out1 = '0' ELSE
      Constant10_out1;

  Bit_Slice4_out1 <= Delay3_out1_1(4);

  Constant9_out1 <= to_signed(16#014#, 9);

  
  Switch9_out1 <= Switch10_out1 WHEN Bit_Slice5_out1 = '0' ELSE
      Constant9_out1;

  Bit_Slice3_out1 <= Delay3_out1_1(5);

  Constant8_out1_1 <= to_signed(16#013#, 9);

  
  Switch8_out1 <= Switch9_out1 WHEN Bit_Slice4_out1 = '0' ELSE
      Constant8_out1_1;

  Bit_Slice2_out1 <= Delay3_out1_1(6);

  Constant7_out1_1 <= to_signed(16#012#, 9);

  
  Switch7_out1 <= Switch8_out1 WHEN Bit_Slice3_out1 = '0' ELSE
      Constant7_out1_1;

  Bit_Slice1_out1 <= Delay3_out1_1(7);

  Constant6_out1_1 <= to_signed(16#011#, 9);

  
  Switch6_out1 <= Switch7_out1 WHEN Bit_Slice2_out1 = '0' ELSE
      Constant6_out1_1;

  Bit_Slice_out1 <= Delay3_out1_1(8);

  Constant5_out1 <= to_signed(16#010#, 9);

  
  Switch5_out1_1 <= Switch6_out1 WHEN Bit_Slice1_out1 = '0' ELSE
      Constant5_out1;

  Bit_Slice26_out1 <= Delay3_out1_1(9);

  Constant4_out1_1 <= to_signed(16#00F#, 9);

  
  Switch4_out1 <= Switch5_out1_1 WHEN Bit_Slice_out1 = '0' ELSE
      Constant4_out1_1;

  Bit_Slice25_out1 <= Delay3_out1_1(10);

  Constant3_out1_1 <= to_signed(16#00E#, 9);

  
  Switch3_out1 <= Switch4_out1 WHEN Bit_Slice26_out1 = '0' ELSE
      Constant3_out1_1;

  Bit_Slice24_out1 <= Delay3_out1_1(11);

  Constant2_out1 <= to_signed(16#00D#, 9);

  
  Switch2_out1 <= Switch3_out1 WHEN Bit_Slice25_out1 = '0' ELSE
      Constant2_out1;

  Bit_Slice27_out1 <= Delay3_out1_1(12);

  -- handling denormalized signals
  Constant1_out1_1 <= to_signed(16#00C#, 9);

  
  Switch1_out1_1 <= Switch2_out1 WHEN Bit_Slice24_out1 = '0' ELSE
      Constant1_out1_1;

  Bit_Slice15_out1 <= Delay3_out1_1(13);

  Constant124_out1 <= to_signed(16#00B#, 9);

  
  Switch116_out1 <= Switch1_out1_1 WHEN Bit_Slice27_out1 = '0' ELSE
      Constant124_out1;

  Bit_Slice16_out1 <= Delay3_out1_1(14);

  Constant28_out1 <= to_signed(16#00A#, 9);

  
  Switch17_out1 <= Switch116_out1 WHEN Bit_Slice15_out1 = '0' ELSE
      Constant28_out1;

  Bit_Slice17_out1 <= Delay3_out1_1(15);

  Constant26_out1 <= to_signed(16#009#, 9);

  
  Switch18_out1 <= Switch17_out1 WHEN Bit_Slice16_out1 = '0' ELSE
      Constant26_out1;

  Bit_Slice28_out1 <= Delay3_out1_1(16);

  Constant27_out1 <= to_signed(16#008#, 9);

  
  Switch19_out1 <= Switch18_out1 WHEN Bit_Slice17_out1 = '0' ELSE
      Constant27_out1;

  Bit_Slice29_out1 <= Delay3_out1_1(17);

  Constant29_out1 <= to_signed(16#007#, 9);

  
  Switch28_out1 <= Switch19_out1 WHEN Bit_Slice28_out1 = '0' ELSE
      Constant29_out1;

  Bit_Slice30_out1 <= Delay3_out1_1(18);

  Constant30_out1 <= to_signed(16#006#, 9);

  
  Switch29_out1 <= Switch28_out1 WHEN Bit_Slice29_out1 = '0' ELSE
      Constant30_out1;

  Bit_Slice31_out1 <= Delay3_out1_1(19);

  Constant31_out1 <= to_signed(16#005#, 9);

  
  Switch30_out1 <= Switch29_out1 WHEN Bit_Slice30_out1 = '0' ELSE
      Constant31_out1;

  Bit_Slice32_out1 <= Delay3_out1_1(20);

  Constant32_out1 <= to_signed(16#004#, 9);

  
  Switch31_out1 <= Switch30_out1 WHEN Bit_Slice31_out1 = '0' ELSE
      Constant32_out1;

  Bit_Slice33_out1 <= Delay3_out1_1(21);

  Constant33_out1 <= to_signed(16#003#, 9);

  
  Switch32_out1 <= Switch31_out1 WHEN Bit_Slice32_out1 = '0' ELSE
      Constant33_out1;

  Bit_Slice34_out1 <= Delay3_out1_1(22);

  Constant34_out1 <= to_signed(16#002#, 9);

  
  Switch33_out1 <= Switch32_out1 WHEN Bit_Slice33_out1 = '0' ELSE
      Constant34_out1;

  Bit_Slice35_out1 <= Delay3_out1_1(23);

  Constant35_out1 <= to_signed(16#001#, 9);

  
  Switch34_out1 <= Switch33_out1 WHEN Bit_Slice34_out1 = '0' ELSE
      Constant35_out1;

  Constant36_out1 <= to_signed(16#000#, 9);

  
  Switch35_out1 <= Switch34_out1 WHEN Bit_Slice35_out1 = '0' ELSE
      Constant36_out1;

  Sum1_sub_temp <= resize(Delay1_out1, 32) - resize(Switch35_out1, 32);
  Sum1_out1 <= Sum1_sub_temp(8 DOWNTO 0);

  Delay1_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_reg_rsvd(0) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(1) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(2) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(3) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(4) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(5) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(6) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(7) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(8) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(9) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(10) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(11) <= to_signed(16#000#, 9);
        Delay1_reg_rsvd(12) <= to_signed(16#000#, 9);
      ELSIF enb = '1' THEN
        Delay1_reg_rsvd(0) <= Delay1_reg_next(0);
        Delay1_reg_rsvd(1) <= Delay1_reg_next(1);
        Delay1_reg_rsvd(2) <= Delay1_reg_next(2);
        Delay1_reg_rsvd(3) <= Delay1_reg_next(3);
        Delay1_reg_rsvd(4) <= Delay1_reg_next(4);
        Delay1_reg_rsvd(5) <= Delay1_reg_next(5);
        Delay1_reg_rsvd(6) <= Delay1_reg_next(6);
        Delay1_reg_rsvd(7) <= Delay1_reg_next(7);
        Delay1_reg_rsvd(8) <= Delay1_reg_next(8);
        Delay1_reg_rsvd(9) <= Delay1_reg_next(9);
        Delay1_reg_rsvd(10) <= Delay1_reg_next(10);
        Delay1_reg_rsvd(11) <= Delay1_reg_next(11);
        Delay1_reg_rsvd(12) <= Delay1_reg_next(12);
      END IF;
    END IF;
  END PROCESS Delay1_1_process;

  Delay1_out1_1 <= Delay1_reg_rsvd(12);
  Delay1_reg_next(0) <= Sum1_out1;
  Delay1_reg_next(1) <= Delay1_reg_rsvd(0);
  Delay1_reg_next(2) <= Delay1_reg_rsvd(1);
  Delay1_reg_next(3) <= Delay1_reg_rsvd(2);
  Delay1_reg_next(4) <= Delay1_reg_rsvd(3);
  Delay1_reg_next(5) <= Delay1_reg_rsvd(4);
  Delay1_reg_next(6) <= Delay1_reg_rsvd(5);
  Delay1_reg_next(7) <= Delay1_reg_rsvd(6);
  Delay1_reg_next(8) <= Delay1_reg_rsvd(7);
  Delay1_reg_next(9) <= Delay1_reg_rsvd(8);
  Delay1_reg_next(10) <= Delay1_reg_rsvd(9);
  Delay1_reg_next(11) <= Delay1_reg_rsvd(10);
  Delay1_reg_next(12) <= Delay1_reg_rsvd(11);

  Unary_Minus_in0 <=  - (resize(Delay1_out1_1, 10));
  Unary_Minus_out1 <= Unary_Minus_in0(8 DOWNTO 0);

  Delay4_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_2 <= to_signed(16#000#, 9);
      ELSIF enb = '1' THEN
        Delay4_out1_2 <= Unary_Minus_out1;
      END IF;
    END IF;
  END PROCESS Delay4_2_process;


  Constant_out1_2 <= to_unsigned(16#1000000#, 25);

  Constant_out1_3 <= to_unsigned(16#1000000#, 25);

  Constant_out1_4 <= to_unsigned(16#1000000#, 25);

  Constant_out1_5 <= to_unsigned(16#1000000#, 25);

  x0_out1 <= to_unsigned(16#0800000#, 25);

  shift_arithmetic_zerosig <= to_signed(16#000#, 9);

  
  shift_arithmetic_selsig <= Switch35_out1 WHEN Switch35_out1 >= shift_arithmetic_zerosig ELSE
      shift_arithmetic_zerosig;

  dynamic_shift_zerosig <= to_signed(16#000#, 9);

  
  dynamic_shift_selsig <= shift_arithmetic_selsig WHEN shift_arithmetic_selsig >= dynamic_shift_zerosig ELSE
      dynamic_shift_zerosig;

  Shift_Arithmetic_out1 <= Delay3_out1_1 sll to_integer(dynamic_shift_selsig);

  Delay_rsvd_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay_out1 <= to_unsigned(16#000000#, 24);
      ELSIF enb = '1' THEN
        Delay_out1 <= Shift_Arithmetic_out1;
      END IF;
    END IF;
  END PROCESS Delay_rsvd_process;


  Bit_Shift_out1 <= SHIFT_RIGHT(Delay_out1, 1);

  Bit_Slice_out1_1 <= Bit_Shift_out1(22 DOWNTO 0);

  Data_Type_Conversion_out1 <= Bit_Slice_out1_1;

  Product_mul_temp <= x0_out1 * Data_Type_Conversion_out1;
  Product_out1 <= Product_mul_temp(47 DOWNTO 23);

  Delay1_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1_2 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay1_out1_2 <= Product_out1;
      END IF;
    END IF;
  END PROCESS Delay1_2_process;


  Sum_sub_cast_1 <= signed(resize(Constant_out1_5, 32));
  Sum_sub_cast_2 <= signed(resize(Delay1_out1_2, 32));
  Sum_sub_temp_1 <= Sum_sub_cast_1 - Sum_sub_cast_2;
  Sum_out1_1 <= unsigned(Sum_sub_temp_1(24 DOWNTO 0));

  Delay4_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_3 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay4_out1_3 <= Sum_out1_1;
      END IF;
    END IF;
  END PROCESS Delay4_3_process;


  Delay3_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_2 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay3_out1_2 <= x0_out1;
      END IF;
    END IF;
  END PROCESS Delay3_2_process;


  Delay5_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay5_out1_1 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay5_out1_1 <= Delay3_out1_2;
      END IF;
    END IF;
  END PROCESS Delay5_1_process;


  Product1_mul_temp <= Delay4_out1_3 * Delay5_out1_1;
  Product1_out1 <= Product1_mul_temp(47 DOWNTO 23);

  Delay2_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_out1_2 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay2_out1_2 <= Product1_out1;
      END IF;
    END IF;
  END PROCESS Delay2_2_process;


  Delay_rsvd_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay_reg_rsvd(0) <= to_unsigned(16#000000#, 23);
        Delay_reg_rsvd(1) <= to_unsigned(16#000000#, 23);
        Delay_reg_rsvd(2) <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay_reg_rsvd(0) <= Delay_reg_next(0);
        Delay_reg_rsvd(1) <= Delay_reg_next(1);
        Delay_reg_rsvd(2) <= Delay_reg_next(2);
      END IF;
    END IF;
  END PROCESS Delay_rsvd_1_process;

  Delay_out1_1 <= Delay_reg_rsvd(2);
  Delay_reg_next(0) <= Data_Type_Conversion_out1;
  Delay_reg_next(1) <= Delay_reg_rsvd(0);
  Delay_reg_next(2) <= Delay_reg_rsvd(1);

  Product_mul_temp_1 <= Delay2_out1_2 * Delay_out1_1;
  Product_out1_1 <= Product_mul_temp_1(47 DOWNTO 23);

  Delay1_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1_3 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay1_out1_3 <= Product_out1_1;
      END IF;
    END IF;
  END PROCESS Delay1_3_process;


  Sum_sub_cast_3 <= signed(resize(Constant_out1_4, 32));
  Sum_sub_cast_4 <= signed(resize(Delay1_out1_3, 32));
  Sum_sub_temp_2 <= Sum_sub_cast_3 - Sum_sub_cast_4;
  Sum_out1_2 <= unsigned(Sum_sub_temp_2(24 DOWNTO 0));

  Delay4_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_4 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay4_out1_4 <= Sum_out1_2;
      END IF;
    END IF;
  END PROCESS Delay4_4_process;


  Delay3_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_3 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay3_out1_3 <= Delay2_out1_2;
      END IF;
    END IF;
  END PROCESS Delay3_3_process;


  Delay5_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay5_out1_2 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay5_out1_2 <= Delay3_out1_3;
      END IF;
    END IF;
  END PROCESS Delay5_2_process;


  Product1_mul_temp_1 <= Delay4_out1_4 * Delay5_out1_2;
  Product1_out1_1 <= Product1_mul_temp_1(47 DOWNTO 23);

  Delay2_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_out1_3 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay2_out1_3 <= Product1_out1_1;
      END IF;
    END IF;
  END PROCESS Delay2_3_process;


  Delay_rsvd_2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay_reg_rsvd_1(0) <= to_unsigned(16#000000#, 23);
        Delay_reg_rsvd_1(1) <= to_unsigned(16#000000#, 23);
        Delay_reg_rsvd_1(2) <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay_reg_rsvd_1(0) <= Delay_reg_next_1(0);
        Delay_reg_rsvd_1(1) <= Delay_reg_next_1(1);
        Delay_reg_rsvd_1(2) <= Delay_reg_next_1(2);
      END IF;
    END IF;
  END PROCESS Delay_rsvd_2_process;

  Delay_out1_2 <= Delay_reg_rsvd_1(2);
  Delay_reg_next_1(0) <= Delay_out1_1;
  Delay_reg_next_1(1) <= Delay_reg_rsvd_1(0);
  Delay_reg_next_1(2) <= Delay_reg_rsvd_1(1);

  Product_mul_temp_2 <= Delay2_out1_3 * Delay_out1_2;
  Product_out1_2 <= Product_mul_temp_2(47 DOWNTO 23);

  Delay1_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1_4 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay1_out1_4 <= Product_out1_2;
      END IF;
    END IF;
  END PROCESS Delay1_4_process;


  Sum_sub_cast_5 <= signed(resize(Constant_out1_3, 32));
  Sum_sub_cast_6 <= signed(resize(Delay1_out1_4, 32));
  Sum_sub_temp_3 <= Sum_sub_cast_5 - Sum_sub_cast_6;
  Sum_out1_3 <= unsigned(Sum_sub_temp_3(24 DOWNTO 0));

  Delay4_5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_5 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay4_out1_5 <= Sum_out1_3;
      END IF;
    END IF;
  END PROCESS Delay4_5_process;


  Delay3_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_4 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay3_out1_4 <= Delay2_out1_3;
      END IF;
    END IF;
  END PROCESS Delay3_4_process;


  Delay5_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay5_out1_3 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay5_out1_3 <= Delay3_out1_4;
      END IF;
    END IF;
  END PROCESS Delay5_3_process;


  Product1_mul_temp_2 <= Delay4_out1_5 * Delay5_out1_3;
  Product1_out1_2 <= Product1_mul_temp_2(47 DOWNTO 23);

  Delay2_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_out1_4 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay2_out1_4 <= Product1_out1_2;
      END IF;
    END IF;
  END PROCESS Delay2_4_process;


  Delay_rsvd_3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay_reg_rsvd_2(0) <= to_unsigned(16#000000#, 23);
        Delay_reg_rsvd_2(1) <= to_unsigned(16#000000#, 23);
        Delay_reg_rsvd_2(2) <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay_reg_rsvd_2(0) <= Delay_reg_next_2(0);
        Delay_reg_rsvd_2(1) <= Delay_reg_next_2(1);
        Delay_reg_rsvd_2(2) <= Delay_reg_next_2(2);
      END IF;
    END IF;
  END PROCESS Delay_rsvd_3_process;

  Delay_out1_3 <= Delay_reg_rsvd_2(2);
  Delay_reg_next_2(0) <= Delay_out1_2;
  Delay_reg_next_2(1) <= Delay_reg_rsvd_2(0);
  Delay_reg_next_2(2) <= Delay_reg_rsvd_2(1);

  Product_mul_temp_3 <= Delay2_out1_4 * Delay_out1_3;
  Product_out1_3 <= Product_mul_temp_3(47 DOWNTO 23);

  Delay1_5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1_5 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay1_out1_5 <= Product_out1_3;
      END IF;
    END IF;
  END PROCESS Delay1_5_process;


  Sum_sub_cast_7 <= signed(resize(Constant_out1_2, 32));
  Sum_sub_cast_8 <= signed(resize(Delay1_out1_5, 32));
  Sum_sub_temp_4 <= Sum_sub_cast_7 - Sum_sub_cast_8;
  Sum_out1_4 <= unsigned(Sum_sub_temp_4(24 DOWNTO 0));

  Delay4_6_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_6 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay4_out1_6 <= Sum_out1_4;
      END IF;
    END IF;
  END PROCESS Delay4_6_process;


  Delay3_5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_5 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay3_out1_5 <= Delay2_out1_4;
      END IF;
    END IF;
  END PROCESS Delay3_5_process;


  Delay5_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay5_out1_4 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay5_out1_4 <= Delay3_out1_5;
      END IF;
    END IF;
  END PROCESS Delay5_4_process;


  Product1_mul_temp_3 <= Delay4_out1_6 * Delay5_out1_4;
  Product1_out1_3 <= Product1_mul_temp_3(47 DOWNTO 23);

  Delay2_5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay2_out1_5 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay2_out1_5 <= Product1_out1_3;
      END IF;
    END IF;
  END PROCESS Delay2_5_process;


  Data_Type_Conversion1_out1 <= Delay2_out1_5;

  Bit_Slice23_out1 <= Data_Type_Conversion1_out1(22);

  Constant23_out1 <= to_signed(16#2#, 3);

  Bit_Slice22_out1 <= Data_Type_Conversion1_out1(23);

  Constant24_out1 <= to_signed(16#1#, 3);

  
  Switch23_out1 <= Constant23_out1 WHEN Bit_Slice23_out1 = '0' ELSE
      Constant24_out1;

  Bit_Slice21_out1 <= Data_Type_Conversion1_out1(24);

  Constant22_out1 <= to_signed(16#0#, 3);

  
  Switch22_out1 <= Switch23_out1 WHEN Bit_Slice22_out1 = '0' ELSE
      Constant22_out1;

  Constant21_out1 <= to_signed(-16#1#, 3);

  
  Switch21_out1 <= Switch22_out1 WHEN Bit_Slice21_out1 = '0' ELSE
      Constant21_out1;

  Delay3_6_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_6 <= to_signed(16#0#, 3);
      ELSIF enb = '1' THEN
        Delay3_out1_6 <= Switch21_out1;
      END IF;
    END IF;
  END PROCESS Delay3_6_process;


  Subtract_sub_temp <= resize(Delay4_out1_2, 32) - resize(Delay3_out1_6, 32);
  Subtract_out1 <= Subtract_sub_temp(9 DOWNTO 0);

  Constant_out1_6 <= to_unsigned(16#7F#, 8);

  Subtract1_add_cast <= signed(resize(Constant_out1_6, 32));
  Subtract1_add_temp <= resize(Subtract_out1, 32) + Subtract1_add_cast;
  Subtract1_out1 <= Subtract1_add_temp(9 DOWNTO 0);

  Delay9_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay9_out1 <= to_signed(16#000#, 10);
      ELSIF enb = '1' THEN
        Delay9_out1 <= Subtract1_out1;
      END IF;
    END IF;
  END PROCESS Delay9_process;


  
  Abs1_y <=  - (resize(Delay9_out1, 11)) WHEN Delay9_out1 < to_signed(16#000#, 10) ELSE
      resize(Delay9_out1, 11);
  Abs1_out1 <= Abs1_y(9 DOWNTO 0);

  
  Compare_To_Constant_out1 <= '1' WHEN Abs1_out1 >= to_signed(16#0FF#, 10) ELSE
      '0';

  
  Compare_To_Zero1_out1 <= '1' WHEN Delay9_out1 <= to_signed(16#000#, 10) ELSE
      '0';

  Data_Type_Conversion_out1_1 <= unsigned(Abs1_out1(7 DOWNTO 0));

  Constant1_out1_2 <= to_unsigned(16#00#, 8);

  
  Switch2_out1_1 <= Data_Type_Conversion_out1_1 WHEN Compare_To_Zero1_out1 = '0' ELSE
      Constant1_out1_2;

  Constant3_out1_2 <= to_unsigned(16#FF#, 8);

  
  Switch4_out1_1 <= Switch2_out1_1 WHEN Compare_To_Constant_out1 = '0' ELSE
      Constant3_out1_2;

  Delay9_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay9_reg_rsvd(0) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(1) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(2) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(3) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(4) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(5) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(6) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(7) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(8) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(9) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(10) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(11) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(12) <= to_unsigned(16#000000#, 23);
        Delay9_reg_rsvd(13) <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay9_reg_rsvd(0) <= Delay9_reg_next(0);
        Delay9_reg_rsvd(1) <= Delay9_reg_next(1);
        Delay9_reg_rsvd(2) <= Delay9_reg_next(2);
        Delay9_reg_rsvd(3) <= Delay9_reg_next(3);
        Delay9_reg_rsvd(4) <= Delay9_reg_next(4);
        Delay9_reg_rsvd(5) <= Delay9_reg_next(5);
        Delay9_reg_rsvd(6) <= Delay9_reg_next(6);
        Delay9_reg_rsvd(7) <= Delay9_reg_next(7);
        Delay9_reg_rsvd(8) <= Delay9_reg_next(8);
        Delay9_reg_rsvd(9) <= Delay9_reg_next(9);
        Delay9_reg_rsvd(10) <= Delay9_reg_next(10);
        Delay9_reg_rsvd(11) <= Delay9_reg_next(11);
        Delay9_reg_rsvd(12) <= Delay9_reg_next(12);
        Delay9_reg_rsvd(13) <= Delay9_reg_next(13);
      END IF;
    END IF;
  END PROCESS Delay9_1_process;

  Delay9_out1_1 <= Delay9_reg_rsvd(13);
  Delay9_reg_next(0) <= M_M;
  Delay9_reg_next(1) <= Delay9_reg_rsvd(0);
  Delay9_reg_next(2) <= Delay9_reg_rsvd(1);
  Delay9_reg_next(3) <= Delay9_reg_rsvd(2);
  Delay9_reg_next(4) <= Delay9_reg_rsvd(3);
  Delay9_reg_next(5) <= Delay9_reg_rsvd(4);
  Delay9_reg_next(6) <= Delay9_reg_rsvd(5);
  Delay9_reg_next(7) <= Delay9_reg_rsvd(6);
  Delay9_reg_next(8) <= Delay9_reg_rsvd(7);
  Delay9_reg_next(9) <= Delay9_reg_rsvd(8);
  Delay9_reg_next(10) <= Delay9_reg_rsvd(9);
  Delay9_reg_next(11) <= Delay9_reg_rsvd(10);
  Delay9_reg_next(12) <= Delay9_reg_rsvd(11);
  Delay9_reg_next(13) <= Delay9_reg_rsvd(12);

  
  CompareTo_Zero1_out1 <= '1' WHEN Delay9_out1_1 = to_unsigned(16#000000#, 23) ELSE
      '0';

  Constant3_out1_3 <= to_unsigned(16#FF#, 8);

  Constant2_out1_1 <= to_unsigned(16#00#, 8);

  
  Switch1_out1_2 <= Constant3_out1_3 WHEN CompareTo_Zero1_out1 = '0' ELSE
      Constant2_out1_1;

  Delay4_7_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay4_out1_7 <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        Delay4_out1_7 <= Switch1_out1_2;
      END IF;
    END IF;
  END PROCESS Delay4_7_process;


  Constant_out1_7 <= to_unsigned(16#FF#, 8);

  
  Switch_out1 <= Delay4_out1_7 WHEN Logical_Operator4_out1_1 = '0' ELSE
      Constant_out1_7;

  Delay1_6_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1_6 <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        Delay1_out1_6 <= Switch_out1;
      END IF;
    END IF;
  END PROCESS Delay1_6_process;


  
  Switch3_out1_1 <= Switch4_out1_1 WHEN Delay2_out1_1 = '0' ELSE
      Delay1_out1_6;

  
  Switch4_out1_2 <= Constant1_out1 WHEN Relational_Operator_relop1 = '0' ELSE
      Switch3_out1_1;

  Delay3_7_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay3_out1_7 <= to_unsigned(16#00#, 8);
      ELSIF enb = '1' THEN
        Delay3_out1_7 <= Switch4_out1_2;
      END IF;
    END IF;
  END PROCESS Delay3_7_process;


  Constant_out1_8 <= to_unsigned(16#000000#, 23);

  
  CompareTo_Zero2_out1 <= '1' WHEN Delay4_out1_7 = to_unsigned(16#00#, 8) ELSE
      '0';

  Logical_Operator1_out1 <= Delay5_out1 AND CompareTo_Zero2_out1;

  Logical_Operator3_out1 <=  NOT CompareTo_Zero2_out1;

  Logical_Operator2_out1_1 <= Delay5_out1 AND Logical_Operator3_out1;

  LogicalOperator1_out1 <= Logical_Operator2_out1_1 OR (Logical_Operator4_out1_1 OR Logical_Operator1_out1);

  Delay8_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay8_out1_1 <= '0';
      ELSIF enb = '1' THEN
        Delay8_out1_1 <= LogicalOperator1_out1;
      END IF;
    END IF;
  END PROCESS Delay8_1_process;


  
  Compare_To_Zero_out1 <= '1' WHEN Delay3_out1_6 < to_signed(16#0#, 3) ELSE
      '0';

  Delay_rsvd_4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay_out1_4 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay_out1_4 <= Delay2_out1_5;
      END IF;
    END IF;
  END PROCESS Delay_rsvd_4_process;


  
  Abs_y <=  - (resize(Delay3_out1_6, 4)) WHEN Delay3_out1_6 < to_signed(16#0#, 3) ELSE
      resize(Delay3_out1_6, 4);
  Abs_out1 <= Abs_y(2 DOWNTO 0);

  Bit_Slice_out1_2 <= unsigned(Abs_out1);

  dynamic_shift_cast <= resize(Bit_Slice_out1_2, 8);
  Shift_Arithmetic_out1_1 <= Delay_out1_4 sll to_integer(dynamic_shift_cast);

  Bit_Shift_out1_1 <= SHIFT_RIGHT(Delay2_out1_5, 1);

  Delay1_7_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay1_out1_7 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay1_out1_7 <= Bit_Shift_out1_1;
      END IF;
    END IF;
  END PROCESS Delay1_7_process;


  
  Switch_out1_1 <= Shift_Arithmetic_out1_1 WHEN Compare_To_Zero_out1 = '0' ELSE
      Delay1_out1_7;

  Delay12_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay12_out1 <= to_unsigned(16#0000000#, 25);
      ELSIF enb = '1' THEN
        Delay12_out1 <= Switch_out1_1;
      END IF;
    END IF;
  END PROCESS Delay12_process;


  Bit_Slice1_out1_1 <= Delay12_out1(22 DOWNTO 0);

  
  Compare_To_Zero2_out1 <= '1' WHEN Data_Type_Conversion_out1_1 > to_unsigned(16#00#, 8) ELSE
      '0';

  Bit_Slice5_out1_1 <= Delay12_out1(0);

  Bit_Slice3_out1_1 <= Delay12_out1(1);

  Logical_Operator2_out1_2 <= Bit_Slice5_out1_1 AND Bit_Slice3_out1_1;

  Bit_Slice4_out1_1 <= Delay12_out1(2);

  Logical_Operator1_out1_1 <= Bit_Slice5_out1_1 OR Bit_Slice4_out1_1;

  Logical_Operator_out1_2 <= Logical_Operator1_out1_1 AND Bit_Slice3_out1_1;

  
  Switch7_out1_1 <= Logical_Operator2_out1_2 WHEN Compare_To_Zero2_out1 = '0' ELSE
      Logical_Operator_out1_2;

  Bit_Slice2_out1_1 <= Delay12_out1(23 DOWNTO 1);

  Constant2_out1_2 <= to_unsigned(16#000001#, 23);

  Sum_out1_5 <= resize(resize(Bit_Slice2_out1_1, 32) + resize(Constant2_out1_2, 32), 23);

  
  Switch6_out1_1 <= Bit_Slice2_out1_1 WHEN Switch7_out1_1 = '0' ELSE
      Sum_out1_5;

  Bit_Shift2_out1 <= SHIFT_RIGHT(Switch6_out1_1, 1);

  
  Switch3_out1_2 <= Switch6_out1_1 WHEN Compare_To_Zero2_out1 = '0' ELSE
      Bit_Shift2_out1;

  
  Switch1_out1_3 <= Bit_Slice1_out1_1 WHEN Compare_To_Zero1_out1 = '0' ELSE
      Switch3_out1_2;

  Constant4_out1_2 <= to_unsigned(16#000000#, 23);

  
  Switch5_out1_2 <= Switch1_out1_3 WHEN Compare_To_Constant_out1 = '0' ELSE
      Constant4_out1_2;

  Constant1_out1_3 <= to_unsigned(16#000000#, 23);

  Delay16_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay16_out1 <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay16_out1 <= Delay9_out1_1;
      END IF;
    END IF;
  END PROCESS Delay16_process;


  Bit_Set_out1 <= Delay16_out1 OR to_unsigned(16#400000#, 23);

  
  Switch2_out1_2 <= Constant1_out1_3 WHEN Logical_Operator2_out1_1 = '0' ELSE
      Bit_Set_out1;

  Delay17_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay17_out1 <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay17_out1 <= Switch2_out1_2;
      END IF;
    END IF;
  END PROCESS Delay17_process;


  
  Switch1_out1_4 <= Switch5_out1_2 WHEN Delay8_out1_1 = '0' ELSE
      Delay17_out1;

  
  Switch2_out1_3 <= Constant_out1_8 WHEN Relational_Operator_relop1 = '0' ELSE
      Switch1_out1_4;

  Delay6_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset_x = '1' THEN
        Delay6_out1 <= to_unsigned(16#000000#, 23);
      ELSIF enb = '1' THEN
        Delay6_out1 <= Switch2_out1_3;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  -- Combine FP sign, exponent, mantissa into 32 bit word
  nfp_out_pack <= Delay7_out1 & Delay3_out1_7 & Delay6_out1;

  nfp_out <= std_logic_vector(nfp_out_pack);

END rtl;

