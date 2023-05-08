function Y_pred = mlp_test_num(X, W1, W2, W3)
% MLP_TEST applies a trained multi-layer perceptron to new data.
%
% Inputs:
% - X: test data matrix (N x D)
% - W1, W2, W3: weight matrices for the three layers of the MLP
%
% Outputs:
% - Y_pred: predicted labels vector (N x 1)
    
%     % Apply MLP to test data
%     if exist('W3','var')
%         Z1 = X * W1;
%         A1 = sigmoid(Z1);
%         Z2 = A1 * W2;
%         A2 = sigmoid(Z2);
%         Z3 = A2 * W3;
%         Y_prob = sigmoid(Z3);
%     else
%         Z1 = X * W1;
%         A1 = sigmoid(Z1);
%         Z2 = A1 * W2;
%         Y_prob = sigmoid(Z2);
%     end
% 
%     % Convert output probabilities to class labels
%     [~, Y_pred] = max(Y_prob, [], 2);
%     Y_pred = Y_pred - 1; % Adjust indices to match class labels (0-9)
%     
% end
% 
% function y = sigmoid(x)
% % Sigmoid activation function
% y = 1 ./ (1 + exp(-x));
% end

 % Apply MLP to test data
    if exist('W3','var')
        Z1 = X * W1;
        A1 = sigmoid(Z1);
        Z2 = A1 * W2;
        A2 = sigmoid(Z2);
        Z3 = A2 * W3;
        A3 = sigmoid(Z3);
        [~, Y_pred] = max(A3, [], 2); % Find the class with the highest probability
    else
        Z1 = X * W1;
        A1 = sigmoid(Z1);
        Z2 = A1 * W2;
        A2 = sigmoid(Z2);
        [~, Y_pred] = max(A2, [], 2); % Find the class with the highest probability
    end
    
    Y_pred = Y_pred - 1; % Adjust the index to get the actual class labels (0-9)
    
end

function y = sigmoid(x)
% Sigmoid activation function
y = 1 ./ (1 + exp(-x));
end