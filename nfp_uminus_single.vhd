LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY nfp_uminus_single IS
  PORT( nfp_in                            :   IN    std_logic_vector(31 DOWNTO 0);
        nfp_out                           :   OUT   std_logic_vector(31 DOWNTO 0)
        );
END nfp_uminus_single;


ARCHITECTURE rtl OF nfp_uminus_single IS

  -- Signals
  SIGNAL nfp_in_unsigned                  : unsigned(31 DOWNTO 0);
  SIGNAL XS                               : std_logic;
  SIGNAL XE                               : unsigned(7 DOWNTO 0);
  SIGNAL XM                               : unsigned(22 DOWNTO 0);
  SIGNAL Constant1_out1                   : std_logic;
  SIGNAL Constant_out1                    : std_logic;
  SIGNAL Switch_out1                      : std_logic;
  SIGNAL nfp_out_pack                     : unsigned(31 DOWNTO 0);

BEGIN
  nfp_in_unsigned <= unsigned(nfp_in);

  -- Split 32 bit word into FP sign, exponent, mantissa
  XS <= nfp_in_unsigned(31);
  XE <= nfp_in_unsigned(30 DOWNTO 23);
  XM <= nfp_in_unsigned(22 DOWNTO 0);

  Constant1_out1 <= '1';

  Constant_out1 <= '0';

  
  Switch_out1 <= Constant1_out1 WHEN XS = '0' ELSE
      Constant_out1;

  -- Combine FP sign, exponent, mantissa into 32 bit word
  nfp_out_pack <= Switch_out1 & XE & XM;

  nfp_out <= std_logic_vector(nfp_out_pack);

END rtl;

