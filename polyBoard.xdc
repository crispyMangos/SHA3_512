set_property CFGBVS VCCO [current_design];
set_property CONFIG_VOLTAGE 3.3 [current_design];

#Clock
set_property -dict { PACKAGE_PIN D13    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #PinNA
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];#set

#LED Array
#set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { goAsync }]; #PinLED0
set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { led1 }]; #PinLED1
#set_property -dict { PACKAGE_PIN B10    IOSTANDARD LVCMOS33 } [get_ports { led2 }]; #PinLED2
#set_property -dict { PACKAGE_PIN D10    IOSTANDARD LVCMOS33 } [get_ports { led3 }]; #PinLED3
#set_property -dict { PACKAGE_PIN B11    IOSTANDARD LVCMOS33 } [get_ports { led4 }]; #PinLED4
#set_property -dict { PACKAGE_PIN C11    IOSTANDARD LVCMOS33 } [get_ports { led5 }]; #PinLED5
#set_property -dict { PACKAGE_PIN D11    IOSTANDARD LVCMOS33 } [get_ports { led6 }]; #PinLED6
#set_property -dict { PACKAGE_PIN E11    IOSTANDARD LVCMOS33 } [get_ports { led7 }]; #PinLED7
#set_property -dict { PACKAGE_PIN C12    IOSTANDARD LVCMOS33 } [get_ports { led8 }]; #PinLED8
#set_property -dict { PACKAGE_PIN E12    IOSTANDARD LVCMOS33 } [get_ports { led9 }]; #PinLED9
#set_property -dict { PACKAGE_PIN C13    IOSTANDARD LVCMOS33 } [get_ports { led10 }]; #PinLED10
#set_property -dict { PACKAGE_PIN D13    IOSTANDARD LVCMOS33 } [get_ports { led11 }]; #PinLED11
#set_property -dict { PACKAGE_PIN D16    IOSTANDARD LVCMOS33 } [get_ports { led12 }]; #PinLED12
#set_property -dict { PACKAGE_PIN D15    IOSTANDARD LVCMOS33 } [get_ports { led13 }]; #PinLED13
#set_property -dict { PACKAGE_PIN D14    IOSTANDARD LVCMOS33 } [get_ports { led14 }]; #PinLED14
#set_property -dict { PACKAGE_PIN E16    IOSTANDARD LVCMOS33 } [get_ports { led15 }]; #PinLED15

#Raspberrry PI Bus
set_property -dict { PACKAGE_PIN J13    IOSTANDARD LVCMOS33 } [get_ports { GPIO[0] }]; #PinNA
set_property -dict { PACKAGE_PIN J14    IOSTANDARD LVCMOS33 } [get_ports { GPIO[1] }]; #PinNA
set_property -dict { PACKAGE_PIN K15    IOSTANDARD LVCMOS33 } [get_ports { GPIO[2] }]; #PinNA
set_property -dict { PACKAGE_PIN K16    IOSTANDARD LVCMOS33 } [get_ports { GPIO[3] }]; #PinNA
set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports { GPIO[4] }]; #PinNA
set_property -dict { PACKAGE_PIN M14    IOSTANDARD LVCMOS33 } [get_ports { GPIO[5] }]; #PinNA
set_property -dict { PACKAGE_PIN K13    IOSTANDARD LVCMOS33 } [get_ports { GPIO[6] }]; #PinNA
set_property -dict { PACKAGE_PIN L13    IOSTANDARD LVCMOS33 } [get_ports { GPIO[7] }]; #PinNA
set_property -dict { PACKAGE_PIN M12    IOSTANDARD LVCMOS33 } [get_ports { piWR }]; #PinNA
set_property -dict { PACKAGE_PIN M16    IOSTANDARD LVCMOS33 } [get_ports { go }]; #PinNA
set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports { kill }]; #PinNA
set_property -dict { PACKAGE_PIN P15    IOSTANDARD LVCMOS33 } [get_ports { reset }]; #PinNA
set_property -dict { PACKAGE_PIN P16    IOSTANDARD LVCMOS33 } [get_ports { dataDone }]; #PinNA
set_property -dict { PACKAGE_PIN R16    IOSTANDARD LVCMOS33 } [get_ports { goAsync }]; #PinNA
set_property -dict { PACKAGE_PIN T14    IOSTANDARD LVCMOS33 } [get_ports { GPIO17 }]; #PinNA
set_property -dict { PACKAGE_PIN T15    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[0] }]; #PinNA
set_property -dict { PACKAGE_PIN R7    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[1] }]; #PinNA
set_property -dict { PACKAGE_PIN R6    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[2] }]; #PinNA
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[3] }]; #PinNA
set_property -dict { PACKAGE_PIN R5    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[4] }]; #PinNA
set_property -dict { PACKAGE_PIN T10    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[5] }]; #PinNA
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[6] }]; #PinNA
set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[7] }]; #PinNA
set_property -dict { PACKAGE_PIN R8    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[8] }]; #PinNA
set_property -dict { PACKAGE_PIN P8    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[9] }]; #PinNA
set_property -dict { PACKAGE_PIN N6    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[10] }]; #PinNA
set_property -dict { PACKAGE_PIN M6    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[11] }]; #PinNA
set_property -dict { PACKAGE_PIN P9    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[12] }]; #PinNA
set_property -dict { PACKAGE_PIN N9    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[13] }]; #PinNA
set_property -dict { PACKAGE_PIN R11    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[14] }]; #PinNA
set_property -dict { PACKAGE_PIN R10    IOSTANDARD LVCMOS33 } [get_ports { GPIOout[15] }]; #PinNA
#set_property -dict { PACKAGE_PIN T13    IOSTANDARD LVCMOS33 } [get_ports { GPIO[31] }]; #PinNA
#set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { GPIO45 }]; #PinNA

#Shift Register Data Out
#set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { SR0 }]; #PinNA
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { SR1 }]; #PinNA
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { SR2 }]; #PinNA
#set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { SR3 }]; #PinNA
#set_property -dict { PACKAGE_PIN F2    IOSTANDARD LVCMOS33 } [get_ports { SR4 }]; #PinNA
#set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { SR5 }]; #PinNA
#set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { SR6 }]; #PinNA
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { SR7 }]; #PinNA
#set_property -dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports { SR8 }]; #PinNA
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { SR9 }]; #PinNA
#set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { SR10 }]; #PinNA
#set_property -dict { PACKAGE_PIN H3    IOSTANDARD LVCMOS33 } [get_ports { SR11 }]; #PinNA
#set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { SR12 }]; #PinNA
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { SR13 }]; #PinNA
#set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { SR14 }]; #PinNA
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { SR15 }]; #PinNA

#IO ADC Bank
#set_property -dict { PACKAGE_PIN C8    IOSTANDARD LVCMOS33 } [get_ports { P0 }]; #PinIO_ADC_BANK 0
#set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { N0 }]; #PinIO_ADC_BANK 0
#set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { P1 }]; #PinIO_ADC_BANK 1
#set_property -dict { PACKAGE_PIN A10    IOSTANDARD LVCMOS33 } [get_ports { N1 }]; #PinIO_ADC_BANK 1
#set_property -dict { PACKAGE_PIN A13    IOSTANDARD LVCMOS33 } [get_ports { P2 }]; #PinIO_ADC_BANK 2
#set_property -dict { PACKAGE_PIN A14    IOSTANDARD LVCMOS33 } [get_ports { N2 }]; #PinIO_ADC_BANK 2
#set_property -dict { PACKAGE_PIN B15    IOSTANDARD LVCMOS33 } [get_ports { P3 }]; #PinIO_ADC_BANK 3
#set_property -dict { PACKAGE_PIN A15    IOSTANDARD LVCMOS33 } [get_ports { N3 }]; #PinIO_ADC_BANK 3
#set_property -dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { P4 }]; #PinIO_ADC_BANK 4
#set_property -dict { PACKAGE_PIN A7    IOSTANDARD LVCMOS33 } [get_ports { N4 }]; #PinIO_ADC_BANK 4
#set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33 } [get_ports { P5 }]; #PinIO_ADC_BANK 5
#set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { N5 }]; #PinIO_ADC_BANK 5
#set_property -dict { PACKAGE_PIN C3    IOSTANDARD LVCMOS33 } [get_ports { P6 }]; #PinIO_ADC_BANK 6
#set_property -dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { N6 }]; #PinIO_ADC_BANK 6
#set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { P7 }]; #PinIO_ADC_BANK 7
#set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports { N7 }]; #PinIO_ADC_BANK 7
#set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { P8 }]; #PinIO_ADC_BANK 8
#set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { N8 }]; #PinIO_ADC_BANK 8
#set_property -dict { PACKAGE_PIN B12    IOSTANDARD LVCMOS33 } [get_ports { P9 }]; #PinIO_ADC_BANK 9
#set_property -dict { PACKAGE_PIN A12    IOSTANDARD LVCMOS33 } [get_ports { N9 }]; #PinIO_ADC_BANK 9
#set_property -dict { PACKAGE_PIN C14    IOSTANDARD LVCMOS33 } [get_ports { P10 }]; #PinIO_ADC_BANK 10
#set_property -dict { PACKAGE_PIN B14    IOSTANDARD LVCMOS33 } [get_ports { N10 }]; #PinIO_ADC_BANK 10
#set_property -dict { PACKAGE_PIN C16    IOSTANDARD LVCMOS33 } [get_ports { P11 }]; #PinIO_ADC_BANK 11
#set_property -dict { PACKAGE_PIN B16    IOSTANDARD LVCMOS33 } [get_ports { N11 }]; #PinIO_ADC_BANK 11
#set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { P12 }]; #PinIO_ADC_BANK 12
#set_property -dict { PACKAGE_PIN B5    IOSTANDARD LVCMOS33 } [get_ports { N12 }]; #PinIO_ADC_BANK 12
#set_property -dict { PACKAGE_PIN C7    IOSTANDARD LVCMOS33 } [get_ports { P13 }]; #PinIO_ADC_BANK 13
#set_property -dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports { N13 }]; #PinIO_ADC_BANK 13
#set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33 } [get_ports { P14 }]; #PinIO_ADC_BANK 14
#set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33 } [get_ports { N14 }]; #PinIO_ADC_BANK 14
#set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { P15 }]; #PinIO_ADC_BANK 15
#set_property -dict { PACKAGE_PIN D1    IOSTANDARD LVCMOS33 } [get_ports { N15 }]; #PinIO_ADC_BANK 15

#Buttons
#set_property -dict { PACKAGE_PIN H12    IOSTANDARD LVCMOS33 } [get_ports { btn0 }]; #PinBTN0
#set_property -dict { PACKAGE_PIN H13    IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #PinBTN1
#set_property -dict { PACKAGE_PIN E15    IOSTANDARD LVCMOS33 } [get_ports { rst }]; #PinRST

