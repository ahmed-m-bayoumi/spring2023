close all; clear;

% using the public simple cluster dataset
[inputs, targets] = simplecluster_dataset;
figure, plot(inputs(1,:), inputs(2,:), 'o');

% designing a self-organizing map with dimensions 8x8
net = selforgmap([8 8]);
net = train(net,inputs);

%plots
figure, plotsompos(net, inputs), hold on, plot(inputs(1,:), inputs(2,:), 'o'), hold off;
figure, plotsomhits(net, inputs)