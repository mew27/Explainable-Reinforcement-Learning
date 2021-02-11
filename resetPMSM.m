function in = resetPMSM(in)
% Reset function for PMSM control using RL example

% Copyright 2020 The MathWorks, Inc.

    % randomize reference signal
    blk = 'mcb_pmsm_foc_sim_RL/SpeedRef';
    refSpeedValues = [0.3,0.4,0.5];
    idx = randperm(length(refSpeedValues),1);
    refspeed = refSpeedValues(idx);
    in = setBlockParameter(in,blk,'After',num2str(refspeed));
end