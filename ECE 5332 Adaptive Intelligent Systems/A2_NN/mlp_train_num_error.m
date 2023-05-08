function [W1, W2, W3, error_plot] = mlp_train_num_error(X, Y, n_hidden_nodes, n_hidden_layers, eta, i)
% MLP_TRAIN trains a multi-layer perceptron with an arbitrary number of hidden nodes and up to two hidden layers.
%
% Inputs:
% - X: training data matrix (N x 64) [8x8 images reshaped into rows]
% - Y: training labels vector (N x 10) [one-hot encoded labels for numbers 0-9]
% - n_hidden_nodes: number of hidden nodes per hidden layer (1 x n_hidden_layers)
% - n_hidden_layers: number of hidden layers (1 or 2)
% - eta: learning rate for gradient descent
% - i: number of iterations for gradient descent
%
% Outputs:
% - W1, W2, W3: weight matrices for the three layers of the MLP
% - error_plot: vector with the error values for each iteration

% Initialize weight matrices randomly
if n_hidden_layers == 1
    W1 = rand(size(X, 2), n_hidden_nodes);
    W2 = rand(n_hidden_nodes, 10); % 10 output classes
else
    W1 = rand(size(X, 2), n_hidden_nodes(1));
    W2 = rand(n_hidden_nodes(1), n_hidden_nodes(2));
    W3 = rand(n_hidden_nodes(2), 10); % 10 output classes
end

error_plot = zeros(i, 1); % Initialize error storage

% Train MLP using backpropagation
for iter = 1:i
    % Forward pass
    if n_hidden_layers == 1
        Z1 = X * W1;
        A1 = sigmoid(Z1);
        Z2 = A1 * W2;
        A2 = sigmoid(Z2);
    else
        Z1 = X * W1;
        A1 = sigmoid(Z1);
        Z2 = A1 * W2;
        A2 = sigmoid(Z2);
        Z3 = A2 * W3;
        A3 = sigmoid(Z3);
    end
    
    % Calculate and store error
    if n_hidden_layers == 1
        error_plot(iter) = sum(sum((Y - A2).^2)) / 2;
    else
        error_plot(iter) = sum(sum((Y - A3).^2)) / 2;
    end
    
    % Backward pass
    if n_hidden_layers == 1
        delta2 = (A2 - Y) .* sigmoid_gradient(Z2);
        delta1 = (delta2 * W2') .* sigmoid_gradient(Z1);
        W2 = W2 - eta * (A1' * delta2);
        W1 = W1 - eta * (X' * delta1);
    else
        delta3 = (A3 - Y) .* sigmoid_gradient(Z3);
        delta2 = (delta3 * W3') .* sigmoid_gradient(Z2);
        delta1 = (delta2 * W2') .* sigmoid_gradient(Z1);
        W3 = W3 - eta * (A2' * delta3);
        W2 = W2 - eta * (A1' * delta2);
        W1 = W1 - eta * (X' * delta1);
    end
end
end

function y = sigmoid(x)
% Sigmoid activation function
y = 1 ./ (1 + exp(-x));
end

function y = sigmoid_gradient(x)
% Gradient of sigmoid activation function
y = sigmoid(x) .* (1 - sigmoid(x));
end
