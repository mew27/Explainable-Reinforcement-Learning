net.predict(input)
layer1_res = tanh(FC1*input(input_mask)'+ FC1_b);
layer2_res = tanh(FC2*layer1_res + FC2_b);
layer3_res = tanh(FC3*layer2_res + FC3_b)'