tmp_net = net.saveobj;


tmp_net.Layers(2,1).Weights = FC1;
tmp_net.Layers(2,1).Bias = FC1_b;

tmp_net.Layers(4,1).Weights = FC2;
tmp_net.Layers(4,1).Bias = FC2_b;

tmp_net.Layers(6,1).Weights = FC3;
tmp_net.Layers(6,1).Bias = FC3_b;

net = net.loadobj(tmp_net);

actor = agent.getActor;
actor = setModel(actor, net);
agent = setActor(agent, actor);