inputs  = [0 0; 0 1; 1 0; 1 1]'; 
targets = [0;1;1;0]';

net = feedforwardnet(1);
net = train(net, inputs, targets);
y   = hardlim(net(inputs));

perform(net, y, targets)

