load('rlPMSMAgent.mat');
net = agent.getActor.getModel;

FC1 = net.Layers(2,1).Weights;
FC1_b = net.Layers(2,1).Bias;

FC2 = net.Layers(4,1).Weights;
FC2_b = net.Layers(4,1).Bias;

FC3 = net.Layers(6,1).Weights;
FC3_b = net.Layers(6,1).Bias;

input = [0.6, 0.34, 0.1, 0.2, 0.3, 0.75];

net.predict(input)
layer1_res = tanh(FC1*input'+ FC1_b);
layer2_res = tanh(FC2*layer1_res + FC2_b);
layer3_res = tanh(FC3*layer2_res + FC3_b)'