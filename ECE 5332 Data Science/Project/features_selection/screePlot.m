% Plot the scree plot
figure;
plot(1:length(explained), explained, 'o-', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Principal Component');
ylabel('Percentage of Variance Explained');
title('Scree Plot');
grid on;
