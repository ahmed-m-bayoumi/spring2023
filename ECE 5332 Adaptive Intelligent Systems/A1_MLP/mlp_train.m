function [W1, W2, W3] = mlp_train(X, Y, n_hidden_nodes, n_hidden_layers, eta, i)
% MLP_TRAIN trains a multi-layer perceptron with an arbitrary number of hidden nodes and up to two hidden layers.
%
% Inputs:
% - X: training data matrix (N x D)
% - Y: training labels vector (N x 1)
% - n_hidden_nodes: number of hidden nodes per hidden layer (1 x n_hidden_layers)
% - n_hidden_layers: number of hidden layers (1 or 2)
% - eta: learning rate for gradient descent
% - i: number of iterations for gradient descent
%
% Outputs:
% - W1, W2, W3: weight matrices for the three layers of the MLP

% Initialize weight matrices randomly
if n_hidden_layers == 1
    W1 = rand(size(X, 2), n_hidden_nodes);
    W2 = rand(n_hidden_nodes, 1);
else
    W1 = rand(size(X, 2), n_hidden_nodes(1));
    W2 = rand(n_hidden_nodes(1), n_hidden_nodes(2));
    W3 = rand(n_hidden_nodes(2), 1);
end

% Train MLP using backpropagation
for i = 1:i
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

% function [W1, W2, W3] = mlp_train(X, Y_onehot, n_hidden_nodes, n_hidden_layers, eta, i)
% % MLP_TRAIN trains a multi-layer perceptron with an arbitrary number of hidden nodes and up to two hidden layers.
% %
% % Inputs:
% % - X: training data matrix (N x D)
% % - Y_onehot: training labels matrix with one-hot encoding (K x N)
% % - n_hidden_nodes: number of hidden nodes per hidden layer (1 x n_hidden_layers)
% % - n_hidden_layers: number of hidden layers (1 or 2)
% % - eta: learning rate for gradient descent
% % - i: number of iterations for gradient descent
% %
% % Outputs:
% % - W1, W2, W3: weight matrices for the three layers of the MLP
% 
% % Initialize weight matrices randomly
% if n_hidden_layers == 1
%     W1 = rand(size(X, 2), n_hidden_nodes);
%     W2 = rand(n_hidden_nodes, size(Y_onehot, 1));
% else
%     W1 = rand(size(X, 2), n_hidden_nodes(1));
%     W2 = rand(n_hidden_nodes(1), n_hidden_nodes(2));
%     W3 = rand(n_hidden_nodes(2), size(Y_onehot, 1));
% end
% 
% % Train MLP using backpropagation
% for iter = 1:i
%     % Forward pass
%     if n_hidden_layers == 1
%         Z1 = X * W1;
%         A1 = sigmoid(Z1);
%         Z2 = A1 * W2;
%         A2 = sigmoid(Z2);
%     else
%         Z1 = X * W1;
%         A1 = sigmoid(Z1);
%         Z2 = A1 * W2;
%         A2 = sigmoid(Z2);
%         Z3 = A2 * W3;
%         A3 = sigmoid(Z3);
%     end
%     
%     % Backward pass
%     if n_hidden_layers == 1
%         delta2 = (A2 - Y_onehot') .* sigmoid_gradient(Z2);
%         delta1 = (delta2 * W2') .* sigmoid_gradient(Z1);
%         W2 = W2 - eta * (A1' * delta2);
%         W1 = W1 - eta * (X' * delta1);
%     else
%         delta3 = (A3 - Y_onehot') .* sigmoid_gradient(Z3);
%         delta2 = (delta3 * W3') .* sigmoid_gradient(Z2);
%         delta1 = (delta2 * W2') .* sigmoid_gradient(Z1);
%         W3 = W3 - eta * (A2' * delta3);
%         W2 = W2 - eta * (A1' * delta2);
%         W1 = W1 - eta * (X' * delta1);
%     end
% end
% 
% end
% 
% function y = sigmoid(x)
% % Sigmoid activation function
% y = 1 ./ (1 + exp(-x));
% end
% 
% function y = sigmoid_gradient(x)
% % Gradient of sigmoid activation function
% y = sigmoid(x) .* (1 - sigmoid(x));
% end
