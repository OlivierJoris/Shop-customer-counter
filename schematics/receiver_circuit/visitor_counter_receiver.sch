EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Visitor counter receiver"
Date "2021-02-04"
Rev "2"
Comp ""
Comment1 ""
Comment2 "JORIS Olivier"
Comment3 "GOFFART Maxime"
Comment4 "CRUCIFIX Arnaud"
$EndDescr
$Comp
L Device:C C3
U 1 1 5FC5EAEF
P 3050 1950
F 0 "C3" H 3165 1996 50  0000 L CNN
F 1 "100nF" H 3165 1905 50  0000 L CNN
F 2 "" H 3088 1800 50  0001 C CNN
F 3 "~" H 3050 1950 50  0001 C CNN
	1    3050 1950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push B1
U 1 1 5FD45D23
P 3850 4800
F 0 "B1" V 3896 4752 50  0000 R CNN
F 1 "Reset" V 3805 4752 50  0000 R CNN
F 2 "" H 3850 5000 50  0001 C CNN
F 3 "~" H 3850 5000 50  0001 C CNN
	1    3850 4800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8350 4850 8350 4800
$Comp
L Device:R_Small_US R8
U 1 1 5FD5E972
P 8350 4700
F 0 "R8" V 8304 4768 50  0000 L CNN
F 1 "220" V 8395 4768 50  0000 L CNN
F 2 "" V 8350 4700 50  0001 C CNN
F 3 "~" V 8350 4700 50  0001 C CNN
	1    8350 4700
	0    1    1    0   
$EndComp
$Comp
L Device:LED D1
U 1 1 5FD57178
P 8350 5000
F 0 "D1" V 8389 4882 50  0000 R CNN
F 1 "HLMP-C515" V 8298 4882 50  0000 R CNN
F 2 "" H 8350 5000 50  0001 C CNN
F 3 "~" H 8350 5000 50  0001 C CNN
	1    8350 5000
	0    -1   -1   0   
$EndComp
Connection ~ 7700 5300
Wire Wire Line
	8150 3000 8200 3000
$Comp
L Display_Character:HDSP-7503 U3
U 1 1 5FC9CFD6
P 8800 2700
F 0 "U3" H 8800 3367 50  0000 C CNN
F 1 "LS0565SRWK" H 8800 3276 50  0000 C CNN
F 2 "Display_7Segment:HDSP-A151" H 8800 2150 50  0001 C CNN
F 3 "https://docs.broadcom.com/docs/AV02-2553EN" H 8400 3250 50  0001 C CNN
	1    8800 2700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7700 5300 7700 5000
Wire Wire Line
	7450 5300 7450 5000
Wire Wire Line
	7700 1800 7700 2200
Wire Wire Line
	7450 1800 7700 1800
Wire Wire Line
	7450 1800 7450 2200
$Comp
L eec:PIC16F1789-I_P U
U 1 1 5FC12645
P 6950 2400
F 0 "U" H 7550 2573 50  0001 C CNN
F 1 "PIC16F1789-I_P" H 7550 2574 50  0001 C BNN
F 2 "Microchip-PIC16F1789-I_P-*" H 6950 2800 50  0001 L CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/41675A.pdf" H 6950 2900 50  0001 L CNN
F 4 "Manufacturer URL" H 6950 3000 50  0001 L CNN "Component Link 1 Description"
F 5 "http://www.microchip.com/" H 6950 3100 50  0001 L CNN "Component Link 1 URL"
F 6 "Package Specification" H 6950 3200 50  0001 L CNN "Component Link 3 Description"
F 7 "http://www.microchip.com/stellent/groups/techpub_sg/documents/packagingspec/en012702.pdf" H 6950 3300 50  0001 L CNN "Component Link 3 URL"
F 8 "2.3 to 5.5 V" H 6950 3900 50  0001 L CNN "VCC Range"
F 9 "Rev. A" H 6950 2400 50  0001 C CNN "Datasheet Version"
F 10 "Through Hole" H 6950 2400 50  0001 C CNN "Mounting Technology"
F 11 "40-Lead Plastic Dual In-Line Package, Body 51.75 x 13.53 mm, Pitch 2.54 mm" H 6950 2400 50  0001 C CNN "Package Description"
F 12 "C04-016B, 04/2013" H 6950 2400 50  0001 C CNN "Package Version"
F 13 "Tube" H 6950 2400 50  0001 C CNN "Packing"
F 14 "IC" H 6950 2400 50  0001 C CNN "category"
F 15 "10490062" H 6950 2400 50  0001 C CNN "ciiva ids"
F 16 "yes" H 6950 2400 50  0001 C CNN "imported"
F 17 "14c9a75bf827425d" H 6950 2400 50  0001 C CNN "library id"
F 18 "Microchip" H 6950 2400 50  0001 C CNN "manufacturer"
F 19 "PDIP-P40" H 6950 2400 50  0001 C CNN "package"
F 20 "1396429688" H 6950 2400 50  0001 C CNN "release date"
F 21 "87B779B8-BAE6-4182-B993-E708CD3A73B9" H 6950 2400 50  0001 C CNN "vault revision"
	1    6950 2400
	1    0    0    -1  
$EndComp
Connection ~ 7450 1800
$Comp
L Device:R_Small_US R1
U 1 1 5FF5991A
P 3850 4050
F 0 "R1" V 3896 3982 50  0000 R CNN
F 1 "10k" V 3805 3982 50  0000 R CNN
F 2 "" V 3850 4050 50  0001 C CNN
F 3 "~" V 3850 4050 50  0001 C CNN
	1    3850 4050
	0    -1   -1   0   
$EndComp
$Comp
L Switch:SW_Push B3
U 1 1 5FED2EA9
P 4900 4800
F 0 "B3" V 4946 4752 50  0000 R CNN
F 1 "+" V 4855 4752 50  0000 R CNN
F 2 "" H 4900 5000 50  0001 C CNN
F 3 "~" H 4900 5000 50  0001 C CNN
	1    4900 4800
	0    -1   -1   0   
$EndComp
$Comp
L Switch:SW_Push B2
U 1 1 5FECD6BD
P 4250 4800
F 0 "B2" V 4296 4752 50  0000 R CNN
F 1 "Digit selector" V 4205 4752 50  0000 R CNN
F 2 "" H 4250 5000 50  0001 C CNN
F 3 "~" H 4250 5000 50  0001 C CNN
	1    4250 4800
	0    -1   -1   0   
$EndComp
Connection ~ 7450 5300
$Comp
L Connector_Generic_MountingPin:Conn_01x06_MountingPin Header
U 1 1 6011B099
P 10400 2600
F 0 "Header" H 10488 2514 50  0000 L CNN
F 1 "22-28-4060" H 10488 2423 50  0000 L CNN
F 2 "" H 10400 2600 50  0001 C CNN
F 3 "~" H 10400 2600 50  0001 C CNN
	1    10400 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R7
U 1 1 6013FC2D
P 9850 2050
F 0 "R7" V 9804 2118 50  0000 L CNN
F 1 "10k" V 9895 2118 50  0000 L CNN
F 2 "" V 9850 2050 50  0001 C CNN
F 3 "~" V 9850 2050 50  0001 C CNN
	1    9850 2050
	0    1    1    0   
$EndComp
Connection ~ 7700 1800
Wire Wire Line
	10200 2500 10100 2500
Wire Wire Line
	10100 2500 10100 1800
Wire Wire Line
	9850 1950 9850 1800
Connection ~ 9850 1800
Wire Wire Line
	9850 1800 10100 1800
Text GLabel 8150 3500 2    50   Input ~ 0
MCLR
Wire Wire Line
	10200 2400 9850 2400
Wire Wire Line
	9850 2150 9850 2400
Connection ~ 9850 2400
Wire Wire Line
	9850 2400 9700 2400
Text GLabel 9700 2400 0    50   Input ~ 0
MCLR
$Comp
L Display_Character:HDSP-7503 U2
U 1 1 5FC61E6A
P 6350 2700
F 0 "U2" H 6350 3367 50  0000 C CNN
F 1 "LS0565SRWK" H 6350 3276 50  0000 C CNN
F 2 "Display_7Segment:HDSP-A151" H 6350 2150 50  0001 C CNN
F 3 "https://docs.broadcom.com/docs/AV02-2553EN" H 5950 3250 50  0001 C CNN
	1    6350 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 2700 10200 2700
Wire Wire Line
	8150 3100 8150 3300
Wire Wire Line
	8200 3250 8200 3000
Wire Wire Line
	8200 3250 9750 3250
Wire Wire Line
	9750 3250 9750 2800
Wire Wire Line
	9750 2800 10200 2800
Wire Wire Line
	10000 2700 10000 3300
Wire Wire Line
	8150 3300 10000 3300
Wire Wire Line
	7700 5300 8350 5300
Wire Wire Line
	8150 4500 8350 4500
Wire Wire Line
	8350 4500 8350 4600
Wire Wire Line
	8350 5150 8350 5300
Connection ~ 8350 5300
Text Label 7500 3400 3    50   ~ 0
MCU1
Text Label 7600 3200 3    50   ~ 0
PIC16F1789-I-P
Wire Wire Line
	8350 5300 9100 5300
$Comp
L Device:R_Small_US R?
U 1 1 60210ABE
P 8350 2400
F 0 "R?" H 8350 2605 50  0001 C CNN
F 1 "R_Small_US" H 8350 2514 50  0001 C CNN
F 2 "" V 8350 2400 50  0001 C CNN
F 3 "~" V 8350 2400 50  0001 C CNN
	1    8350 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 60218FEF
P 8350 2500
F 0 "R?" H 8350 2705 50  0001 C CNN
F 1 "R_Small_US" H 8350 2614 50  0001 C CNN
F 2 "" V 8350 2500 50  0001 C CNN
F 3 "~" V 8350 2500 50  0001 C CNN
	1    8350 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6021AF56
P 8350 2600
F 0 "R?" H 8350 2805 50  0001 C CNN
F 1 "R_Small_US" H 8350 2714 50  0001 C CNN
F 2 "" V 8350 2600 50  0001 C CNN
F 3 "~" V 8350 2600 50  0001 C CNN
	1    8350 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6021CDAC
P 8350 2700
F 0 "R?" H 8350 2905 50  0001 C CNN
F 1 "R_Small_US" H 8350 2814 50  0001 C CNN
F 2 "" V 8350 2700 50  0001 C CNN
F 3 "~" V 8350 2700 50  0001 C CNN
	1    8350 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6021E8A5
P 8350 2800
F 0 "R?" H 8350 3005 50  0001 C CNN
F 1 "R_Small_US" H 8350 2914 50  0001 C CNN
F 2 "" V 8350 2800 50  0001 C CNN
F 3 "~" V 8350 2800 50  0001 C CNN
	1    8350 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 602203F2
P 8350 2900
F 0 "R?" H 8350 3105 50  0001 C CNN
F 1 "R_Small_US" H 8350 3014 50  0001 C CNN
F 2 "" V 8350 2900 50  0001 C CNN
F 3 "~" V 8350 2900 50  0001 C CNN
	1    8350 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6022232F
P 8350 3000
F 0 "R?" H 8350 3205 50  0001 C CNN
F 1 "R_Small_US" H 8350 3114 50  0001 C CNN
F 2 "" V 8350 3000 50  0001 C CNN
F 3 "~" V 8350 3000 50  0001 C CNN
	1    8350 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 2400 8150 2400
Wire Wire Line
	8150 2500 8250 2500
Wire Wire Line
	8150 2600 8250 2600
Wire Wire Line
	8150 2700 8250 2700
Wire Wire Line
	8150 2800 8250 2800
Wire Wire Line
	8150 2900 8250 2900
Wire Wire Line
	8450 2400 8500 2400
Wire Wire Line
	8450 2500 8500 2500
Wire Wire Line
	8450 2600 8500 2600
Wire Wire Line
	8450 2700 8500 2700
Wire Wire Line
	8450 2800 8500 2800
Wire Wire Line
	8450 3000 8500 3000
Wire Wire Line
	8200 3000 8250 3000
Connection ~ 8200 3000
Wire Wire Line
	9100 3000 9100 3100
Connection ~ 9100 3100
$Comp
L Device:R_Small_US R?
U 1 1 602669CB
P 6800 2400
F 0 "R?" H 6800 2605 50  0001 C CNN
F 1 "R_Small_US" H 6800 2514 50  0001 C CNN
F 2 "" V 6800 2400 50  0001 C CNN
F 3 "~" V 6800 2400 50  0001 C CNN
	1    6800 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6026DE10
P 6800 2500
F 0 "R?" H 6800 2705 50  0001 C CNN
F 1 "R_Small_US" H 6800 2614 50  0001 C CNN
F 2 "" V 6800 2500 50  0001 C CNN
F 3 "~" V 6800 2500 50  0001 C CNN
	1    6800 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 60270225
P 6800 2600
F 0 "R?" H 6800 2805 50  0001 C CNN
F 1 "R_Small_US" H 6800 2714 50  0001 C CNN
F 2 "" V 6800 2600 50  0001 C CNN
F 3 "~" V 6800 2600 50  0001 C CNN
	1    6800 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 602727B4
P 6800 2700
F 0 "R?" H 6800 2905 50  0001 C CNN
F 1 "R_Small_US" H 6800 2814 50  0001 C CNN
F 2 "" V 6800 2700 50  0001 C CNN
F 3 "~" V 6800 2700 50  0001 C CNN
	1    6800 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 60274C86
P 6800 2800
F 0 "R?" H 6800 3005 50  0001 C CNN
F 1 "R_Small_US" H 6800 2914 50  0001 C CNN
F 2 "" V 6800 2800 50  0001 C CNN
F 3 "~" V 6800 2800 50  0001 C CNN
	1    6800 2800
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 60277047
P 6800 2900
F 0 "R?" H 6800 3105 50  0001 C CNN
F 1 "R_Small_US" H 6800 3014 50  0001 C CNN
F 2 "" V 6800 2900 50  0001 C CNN
F 3 "~" V 6800 2900 50  0001 C CNN
	1    6800 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 602794B0
P 6800 3000
F 0 "R?" H 6800 3205 50  0001 C CNN
F 1 "R_Small_US" H 6800 3114 50  0001 C CNN
F 2 "" V 6800 3000 50  0001 C CNN
F 3 "~" V 6800 3000 50  0001 C CNN
	1    6800 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 2400 6700 2400
Wire Wire Line
	6900 2400 6950 2400
Wire Wire Line
	6900 2500 6950 2500
Wire Wire Line
	6900 2600 6950 2600
Wire Wire Line
	6900 2700 6950 2700
Wire Wire Line
	6900 2800 6950 2800
Wire Wire Line
	6900 2900 6950 2900
Wire Wire Line
	6900 3000 6950 3000
Wire Wire Line
	6650 3000 6700 3000
Wire Wire Line
	6650 2900 6700 2900
Wire Wire Line
	6650 2800 6700 2800
Wire Wire Line
	6650 2700 6700 2700
Wire Wire Line
	6650 2600 6700 2600
Wire Wire Line
	6650 2500 6700 2500
Wire Wire Line
	8450 2900 8500 2900
Text Label 8200 2250 0    39   ~ 0
R17->23
Text Label 6650 2250 0    39   ~ 0
R9->16
Text Label 8300 2350 0    39   ~ 0
220
Text Label 6750 2350 0    39   ~ 0
220
Wire Wire Line
	6050 3000 6050 3100
Connection ~ 6050 3100
Connection ~ 6050 5300
Wire Wire Line
	9100 2600 9100 3000
Connection ~ 9100 3000
Wire Wire Line
	9100 2600 10200 2600
$Comp
L Switch:SW_Push B4
U 1 1 5FED02E9
P 5150 4800
F 0 "B4" V 5196 4752 50  0000 R CNN
F 1 "-" V 5105 4752 50  0000 R CNN
F 2 "" H 5150 5000 50  0001 C CNN
F 3 "~" H 5150 5000 50  0001 C CNN
	1    5150 4800
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R2
U 1 1 60418A5A
P 4250 4050
F 0 "R2" V 4296 3982 50  0000 R CNN
F 1 "10k" V 4205 3982 50  0000 R CNN
F 2 "" V 4250 4050 50  0001 C CNN
F 3 "~" V 4250 4050 50  0001 C CNN
	1    4250 4050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R3
U 1 1 6041BAAC
P 4900 4050
F 0 "R3" V 4946 3982 50  0000 R CNN
F 1 "10k" V 4855 3982 50  0000 R CNN
F 2 "" V 4900 4050 50  0001 C CNN
F 3 "~" V 4900 4050 50  0001 C CNN
	1    4900 4050
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R4
U 1 1 6041EC40
P 5150 4050
F 0 "R4" V 5196 3982 50  0000 R CNN
F 1 "10k" V 5105 3982 50  0000 R CNN
F 2 "" V 5150 4050 50  0001 C CNN
F 3 "~" V 5150 4050 50  0001 C CNN
	1    5150 4050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3050 2100 3050 5300
Wire Wire Line
	7450 5300 7700 5300
$Comp
L Device:Battery_Cell BT?
U 1 1 601DC240
P 1300 2000
F 0 "BT?" H 1418 2096 50  0001 L CNN
F 1 "9V" H 1418 2050 50  0000 L CNN
F 2 "" V 1300 2060 50  0001 C CNN
F 3 "~" V 1300 2060 50  0001 C CNN
	1    1300 2000
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4149 D1
U 1 1 601E2F5B
P 1600 1800
F 0 "D1" H 1600 2017 50  0000 C CNN
F 1 "1N4149" H 1600 1926 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 1600 1625 50  0001 C CNN
F 3 "http://www.microsemi.com/document-portal/doc_view/11580-lds-0239" H 1600 1800 50  0001 C CNN
	1    1600 1800
	-1   0    0    -1  
$EndComp
$Comp
L Regulator_Linear:L7805 U1
U 1 1 601F4378
P 2300 1800
F 0 "U1" H 2300 2042 50  0000 C CNN
F 1 "L7805CV" H 2300 1951 50  0000 C CNN
F 2 "" H 2325 1650 50  0001 L CIN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/41/4f/b3/b0/12/d4/47/88/CD00000444.pdf/files/CD00000444.pdf/jcr:content/translations/en.CD00000444.pdf" H 2300 1750 50  0001 C CNN
	1    2300 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1_Small C1
U 1 1 601F6A65
P 1750 1900
F 0 "C1" H 1841 1946 50  0000 L CNN
F 1 "100uF" H 1841 1855 50  0000 L CNN
F 2 "" H 1750 1900 50  0001 C CNN
F 3 "~" H 1750 1900 50  0001 C CNN
	1    1750 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 1800 2650 1800
Connection ~ 3050 1800
Wire Wire Line
	2300 2100 2300 5300
Connection ~ 3050 5300
Connection ~ 2300 5300
Wire Wire Line
	2300 5300 2650 5300
Wire Wire Line
	1300 1800 1450 1800
Wire Wire Line
	1300 2100 1300 5300
$Comp
L Device:CP1_Small C2
U 1 1 602B13EA
P 2650 1900
F 0 "C2" H 2741 1946 50  0000 L CNN
F 1 "10uF" H 2741 1855 50  0000 L CNN
F 2 "" H 2650 1900 50  0001 C CNN
F 3 "~" H 2650 1900 50  0001 C CNN
	1    2650 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2000 2650 5300
Connection ~ 2650 5300
Wire Wire Line
	2650 5300 3050 5300
Connection ~ 1750 1800
Wire Wire Line
	1750 1800 2000 1800
Wire Wire Line
	1300 5300 1750 5300
Wire Wire Line
	1750 2000 1750 5300
Connection ~ 1750 5300
Wire Wire Line
	1750 5300 2300 5300
Connection ~ 2650 1800
Wire Wire Line
	2650 1800 3050 1800
Wire Wire Line
	3050 5300 3500 5300
$Comp
L Device:C C4
U 1 1 602DF859
P 3500 1950
F 0 "C4" H 3615 1996 50  0000 L CNN
F 1 "100nF" H 3615 1905 50  0000 L CNN
F 2 "" H 3538 1800 50  0001 C CNN
F 3 "~" H 3500 1950 50  0001 C CNN
	1    3500 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 2100 3500 5300
Connection ~ 3500 5300
Wire Wire Line
	6050 3100 6050 5300
Wire Wire Line
	9100 3100 9100 5300
Wire Wire Line
	7700 1800 9350 1800
$Comp
L Device:Q_Photo_NPN Q1
U 1 1 60317904
P 5650 3450
F 0 "Q1" H 5840 3496 50  0000 L CNN
F 1 "OP598A" H 5840 3405 50  0000 L CNN
F 2 "" H 5850 3550 50  0001 C CNN
F 3 "~" H 5650 3450 50  0001 C CNN
	1    5650 3450
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R24
U 1 1 6032266D
P 5750 3850
F 0 "R24" V 5796 3782 50  0000 R CNN
F 1 "10k" V 5705 3782 50  0000 R CNN
F 2 "" V 5750 3850 50  0001 C CNN
F 3 "~" V 5750 3850 50  0001 C CNN
	1    5750 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5750 3250 5750 1800
Connection ~ 5750 1800
Wire Wire Line
	5750 1800 7450 1800
$Comp
L Device:Q_Photo_NPN Q2
U 1 1 60349997
P 9250 3650
F 0 "Q2" H 9440 3696 50  0000 L CNN
F 1 "OP598A" H 9440 3605 50  0000 L CNN
F 2 "" H 9450 3750 50  0001 C CNN
F 3 "~" H 9250 3650 50  0001 C CNN
	1    9250 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R25
U 1 1 6034FE9F
P 9350 4050
F 0 "R25" V 9396 3982 50  0000 R CNN
F 1 "10k" V 9305 3982 50  0000 R CNN
F 2 "" V 9350 4050 50  0001 C CNN
F 3 "~" V 9350 4050 50  0001 C CNN
	1    9350 4050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9350 3950 9350 3900
Wire Wire Line
	9350 4150 9350 5300
Wire Wire Line
	9350 5300 9100 5300
Connection ~ 9100 5300
Wire Wire Line
	9350 3450 9350 1800
Connection ~ 9350 1800
Wire Wire Line
	9350 1800 9850 1800
Wire Wire Line
	8150 3900 9350 3900
Connection ~ 9350 3900
Wire Wire Line
	9350 3900 9350 3850
Wire Wire Line
	3050 1800 3500 1800
Wire Wire Line
	3850 1800 3850 3950
Connection ~ 3850 1800
Wire Wire Line
	3850 1800 4250 1800
Wire Wire Line
	3500 5300 3850 5300
Wire Wire Line
	3850 5000 3850 5300
Connection ~ 3850 5300
Wire Wire Line
	3850 5300 4250 5300
Wire Wire Line
	4250 3950 4250 1800
Connection ~ 4250 1800
Wire Wire Line
	4250 1800 4900 1800
Wire Wire Line
	4250 4550 4250 4400
Wire Wire Line
	4250 5000 4250 5300
Connection ~ 4250 5300
Connection ~ 4250 4400
Wire Wire Line
	4250 4400 4250 4150
Wire Wire Line
	4250 4400 6950 4400
Wire Wire Line
	4250 5300 4900 5300
Wire Wire Line
	4900 3950 4900 1800
Connection ~ 4900 1800
Wire Wire Line
	4900 1800 5150 1800
Wire Wire Line
	4900 5000 4900 5300
Connection ~ 4900 5300
Wire Wire Line
	4900 5300 5150 5300
Wire Wire Line
	4900 4600 4900 4300
Connection ~ 4900 4300
Wire Wire Line
	4900 4300 4900 4150
Wire Wire Line
	4900 4300 6950 4300
Wire Wire Line
	5150 4150 5150 4200
Connection ~ 5150 4200
Wire Wire Line
	5150 4200 5150 4600
Wire Wire Line
	5150 5000 5150 5300
Connection ~ 5150 5300
Wire Wire Line
	5150 5300 5750 5300
Wire Wire Line
	5150 3950 5150 1800
Connection ~ 5150 1800
Wire Wire Line
	5150 1800 5750 1800
Wire Wire Line
	5150 4200 6950 4200
Wire Wire Line
	5750 3650 5750 3700
Wire Wire Line
	5750 3950 5750 5300
Connection ~ 5750 5300
Wire Wire Line
	5750 5300 6050 5300
Wire Wire Line
	5750 3700 6950 3700
Connection ~ 5750 3700
Wire Wire Line
	5750 3700 5750 3750
Wire Wire Line
	6050 5300 7450 5300
Connection ~ 3500 1800
Wire Wire Line
	3500 1800 3850 1800
Wire Wire Line
	3850 4150 3850 4500
Wire Wire Line
	6950 4500 3850 4500
Connection ~ 3850 4500
Wire Wire Line
	3850 4500 3850 4600
$EndSCHEMATC
