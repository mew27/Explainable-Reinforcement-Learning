reward = [];
net_result_prova;
mdl = 'mcb_pmsm_foc_sim_RL';
open_system(mdl)
test_references = 1;

for i = 1:5:95
    val = prctile([abs(FC1(:))' abs(FC1_b)' abs(FC2(:))' abs(FC2_b)' abs(FC3(:))' abs(FC3_b)'], i, 'all');
    quantize_weights;
    quantize_net
    out = sim(mdl);
    reward = [reward sum(out.rewarddata)];
    net_result_prova;
end

plot(i, reward);