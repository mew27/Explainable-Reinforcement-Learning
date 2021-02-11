%% ************************************************************************
% Model         :   PMSM Field Oriented Control
% Description   :   Set Parameters for Motor, Inverter and Controllers
%               :   for simulating the FOC control algorithm for PMSM
% File name     :   mcb_pmsm_foc_sim_data.m

% Copyright 2020 The MathWorks, Inc.

%% Set PWM Switching frequency
PWM_frequency 	= 50e2;    %Hz  20e3       // converter s/w freq     ideally require 10e3 
T_pwm           = 1/PWM_frequency;  %s  // PWM switching time period

%% Set Sample Times
Ts          	= T_pwm;        %sec        // simulation time step for controller
Ts_simulink     = T_pwm/2;      %sec        // simulation time step for model simulation
Ts_motor        = T_pwm/2;      %Sec        // Simulation sample time
Ts_inverter     = T_pwm/2;      %sec        // simulation time step for average value inverter
Ts_speed        = 10*Ts;        %Sec        // Sample time for speed controller

%% Set data type for controller & code-gen
dataType = 'single';            % Floating point code-generation

%% System Parameters // Hardware parameters 

%pmsm = mcb_SetPMSMMotorParameters('Teknic2310P');
pmsm.PositionOffset = 0.165;

% For Maxon motor
pmsm.QEPSlits = 4096;       
pmsm.p = 7;         
pmsm.Rs = 0.293;            % ohms
pmsm.Ld = 87.678e-6;        % H
pmsm.Lq = 77.724e-6;        % H
pmsm.Ke = 5.7835;           % V/KRPM
pmsm.J = 83.5e-6;           % kgm^2
pmsm.B = 70.095e-6; 
pmsm.FluxPM     = (pmsm.Ke)/(sqrt(3)*2*pi*1000*pmsm.p/60);
%% Parameters below are not mandatory for offset computation

inverter = mcb_SetInverterParameters_RL('BoostXL-DRV8305');
inverter.I_max = 19.3/inverter.ADCGain;

target = mcb_SetProcessorDetails_RL('F28379D',PWM_frequency);

%% Derive Characteristics
pmsm.N_base = 3730;

%% PU System details // Set base values for pu conversion
PU_System = mcb_SetPUSystem_RL(pmsm,inverter);

%% Controller design // Get ballpark values!
PI_params = mcb.internal.SetControllerParameters(pmsm,inverter,PU_System,T_pwm,Ts,Ts_speed);

%Updating delays for simulation
PI_params.delay_Currents    = int32(Ts/Ts_simulink);
PI_params.delay_Position    = int32(Ts/Ts_simulink);
PI_params.delay_Speed       = int32(Ts_speed/Ts_simulink);
PI_params.delay_Speed1      = (PI_params.delay_IIR + 0.5*Ts)/Ts_speed;

%% Flag for testing closed loop performance across different reference speeds
testReferences = 1;

%% Misc parameters
maxAngleIn =1;
MechOfstInputType = pmsm.p;
NrPP = pmsm.p;