function Y_pred = mlp_test(X, W1, W2, W3)
% MLP_TEST applies a trained multi-layer perceptron to new data.
%
% Inputs:
% - X: test data matrix (N x D)
% - W1, W2, W3: weight matrices for the three layers of the MLP
%
% Outputs:
% - Y_pred: predicted labels vector (N x 1)
    
    % Apply MLP to test data
    if exist('W3','var')
        Z1 = X * W1;
        A1 = sigmoid(Z1);
        Z2 = A1 * W2;
        A2 = sigmoid(Z2);
        Z3 = A2 * W3;
        Y_pred = sigmoid(Z3) >= 0.5;
    else
        Z1 = X * W1;
        A1 = sigmoid(Z1);
        Z2 = A1 * W2;
        Y_pred = sigmoid(Z2) >= 0.5;
    end
    
end

function y = sigmoid(x)
% Sigmoid activation function
y = 1 ./ (1 + exp(-x));
end