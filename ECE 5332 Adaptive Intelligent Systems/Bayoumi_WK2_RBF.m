close all

P = linspace(-100,100,1000);
T = sin(P);

goal = 0.001;
spread = 2;
MN = 100;
DF = 1;

net = newrb(P, T, goal, spread, MN, DF);

y = sim(net,P);
figure('Name', 'Using 100 Neurons');
plot(P,T, 'b--');
hold on
plot(P,y);
legend('Sinewave Input','RBF Network Response');
