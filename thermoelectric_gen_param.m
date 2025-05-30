%% Thermoelectric Generator Model and Study
%Author: Charles Kennedy; Date: 11/7/2019

%Updated By Mohammad Azhar Naushad
%Not all the equations are used in the symulink model some are just for reference




%% From Practical datasheet
%Estimated Thermal and Electrical Characteristics
%-----------------------%Parameter Conditions:      min     typ     max
% Power Th=80°C, Tc=7°C @matched load       |     0.3     0.281    0.263 W
% Matched load Voltage Th=80°C, Tc=7°C      |     1.9     1.56     1.22 V
% Load Resistance Th=80°C, Tc=7°C           |     11.9    120.95   230 ohm 
% Current Th=80°C, Tc=7°C @matched load     |     0.158   0.188    0.218 A
% Seebek Co-efficient (alpha)               |     0.052 (Indium selenide)
% Temperature Difference (delta)            |     73.15            44                          
             

%% Temperature Conversions

%Kelvin (K) = Celsius (C) + 273.15
%
%Fahrenheit (F) = Celsius (C)*(1.8) + 32
%F = C*1.8 + 32

%% SIMULINK MODEL
%Th %Hot side temperature (Celsius)
Th = 80;
% Hot Side temperature (Kelvin)
Th = Th + 273.15;

%Tc %Cold Side Temperature (Celsius)
Tc = 7;
%Cold Side Temperature (Kelvin)
Tc = Tc + 273.15;

%delta_T %Temperature difference between the hot side and cold side
delta_T = Th - Tc;

%Vm %matched voltage
Vm = 1.9;

%Wm %Min Power
Wm = 0.303;

%R %internal Resistance
%RL %Load Resistance (matched to internal resistance where R=RL)
RL = (Vm^2)/Wm; 
R = RL;

%Seebeck Coefficient
alpha = 2*Vm/delta_T;

%if RL = mR where m is the ratio between the internal and load
m = 1;

%I %Electric current
Ie = (alpha*delta_T)/((1+m)*R); 
%  = (u(1)*u(3))/((1+m)*R)

%Im %Matched Load Current
Im = (alpha*delta_T)/(2*R);
%  = (u(1)*u(3))/(2*R)


%Isc %Short Circuit Current @Vl = 0     %Isc = 2*Im=(2*Wm)/Vm;
Isc = (Wm)/Vm;
Isc_1 = 2*Im;

%V %Output Voltage
V = -R*(Ie-Isc);
% = -u(2)*(u(1)-(2*Wm)/Vm)



%% Physical test model study

%Vo %Open Circuit Voltage
%Vl %Load Voltage
%Rl %load resistor 
%look at datasheet for appropriate size in Ohms
%Vr %Voltage drop across resistor 


%I_load %current from module
%I_load = Vr/Rl

%Ri %Internal Resistance
%Ri = (Vo * Vl)/I_load

%Pmax %Maximum Power Output
%Pmax = (Vo^2)/(4*Ri)






