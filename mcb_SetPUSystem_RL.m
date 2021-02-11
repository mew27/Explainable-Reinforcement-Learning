function PU_System = mcb_SetPUSystem(pmsm,inverter)
%% ************************************************************************
% File          :   PU System Parameters File
% Description   :   Set base values for Per-Unit system for Motor Control Blockset
% Authors       :   A. Ancelle, S. Sekhara, A. Selvaraj, H. Gulhane, D. Pandit, S. Narayan
% Copyright 2020 The MathWorks, Inc.
%% ************************************************************************
% Get Per-Unit System parameters
    PU_System.V_base   = (inverter.V_dc/sqrt(3));
    PU_System.I_base   = inverter.I_max;
    PU_System.N_base   = pmsm.N_base;

    PU_System.T_base   = (3/2)*pmsm.p*pmsm.FluxPM*PU_System.I_base;
    PU_System.P_base   = (3/2)*PU_System.V_base*PU_System.I_base;
    
end