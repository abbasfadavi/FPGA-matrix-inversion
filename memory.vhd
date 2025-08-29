LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memory IS
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        din_re                            :   IN    std_logic_vector(31 DOWNTO 0);
        din_im                            :   IN    std_logic_vector(31 DOWNTO 0);
        wr                                :   IN    std_logic;
        add1                              :   IN    std_logic_vector(15 DOWNTO 0);
        add2                              :   IN    std_logic_vector(15 DOWNTO 0);
        add3                              :   IN    std_logic_vector(15 DOWNTO 0);
        out1_re                           :   OUT   std_logic_vector(31 DOWNTO 0);
        out1_im                           :   OUT   std_logic_vector(31 DOWNTO 0);
        out2_re                           :   OUT   std_logic_vector(31 DOWNTO 0);
        out2_im                           :   OUT   std_logic_vector(31 DOWNTO 0);
        out3_re                           :   OUT   std_logic_vector(31 DOWNTO 0);
        out3_im                           :   OUT   std_logic_vector(31 DOWNTO 0)
        );
END memory;


ARCHITECTURE rtl OF memory IS

  -- Component Declarations
  COMPONENT singlePortRam_Wrapper_generi
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          reset_x                         :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_1_1                       :   IN    std_logic;
          din_re                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
          din_im                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);
          addr                            :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);
          we                              :   IN    std_logic;
          dout_re                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);
          dout_im                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)
          );
  END COMPONENT;

  -- Signals
  SIGNAL add1_unsigned                    : unsigned(15 DOWNTO 0);
  SIGNAL Data_Type_Conversion2_out1       : unsigned(9 DOWNTO 0);
  SIGNAL Single_Port_RAM_System_out1_re   : std_logic_vector(31 DOWNTO 0);
  SIGNAL Single_Port_RAM_System_out1_im   : std_logic_vector(31 DOWNTO 0);
  SIGNAL add2_unsigned                    : unsigned(15 DOWNTO 0);
  SIGNAL Data_Type_Conversion5_out1       : unsigned(9 DOWNTO 0);
  SIGNAL Single_Port_RAM_System1_out1_re  : std_logic_vector(31 DOWNTO 0);
  SIGNAL Single_Port_RAM_System1_out1_im  : std_logic_vector(31 DOWNTO 0);
  SIGNAL add3_unsigned                    : unsigned(15 DOWNTO 0);
  SIGNAL Data_Type_Conversion8_out1       : unsigned(9 DOWNTO 0);
  SIGNAL Single_Port_RAM_System2_out1_re  : std_logic_vector(31 DOWNTO 0);
  SIGNAL Single_Port_RAM_System2_out1_im  : std_logic_vector(31 DOWNTO 0);

BEGIN
  USingle_Port_RAM_System : singlePortRam_Wrapper_generi
    GENERIC MAP( AddrWidth => 10,
                 DataWidth => 32
                 )
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              din_re => din_re,
              din_im => din_im,
              addr => std_logic_vector(Data_Type_Conversion2_out1),
              we => wr,
              dout_re => Single_Port_RAM_System_out1_re,
              dout_im => Single_Port_RAM_System_out1_im
              );

  USingle_Port_RAM_System1 : singlePortRam_Wrapper_generi
    GENERIC MAP( AddrWidth => 10,
                 DataWidth => 32
                 )
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              din_re => din_re,
              din_im => din_im,
              addr => std_logic_vector(Data_Type_Conversion5_out1),
              we => wr,
              dout_re => Single_Port_RAM_System1_out1_re,
              dout_im => Single_Port_RAM_System1_out1_im
              );

  USingle_Port_RAM_System2 : singlePortRam_Wrapper_generi
    GENERIC MAP( AddrWidth => 10,
                 DataWidth => 32
                 )
    PORT MAP( clk => clk,
              reset_x => reset_x,
              enb => enb,
              enb_1_1_1 => enb_1_1_1,
              din_re => din_re,
              din_im => din_im,
              addr => std_logic_vector(Data_Type_Conversion8_out1),
              we => wr,
              dout_re => Single_Port_RAM_System2_out1_re,
              dout_im => Single_Port_RAM_System2_out1_im
              );

  add1_unsigned <= unsigned(add1);

  Data_Type_Conversion2_out1 <= add1_unsigned(9 DOWNTO 0);

  add2_unsigned <= unsigned(add2);

  Data_Type_Conversion5_out1 <= add2_unsigned(9 DOWNTO 0);

  add3_unsigned <= unsigned(add3);

  Data_Type_Conversion8_out1 <= add3_unsigned(9 DOWNTO 0);

  out1_re <= Single_Port_RAM_System_out1_re;

  out1_im <= Single_Port_RAM_System_out1_im;

  out2_re <= Single_Port_RAM_System1_out1_re;

  out2_im <= Single_Port_RAM_System1_out1_im;

  out3_re <= Single_Port_RAM_System2_out1_re;

  out3_im <= Single_Port_RAM_System2_out1_im;

END rtl;

