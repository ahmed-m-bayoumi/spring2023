function f = ps_example2(x)
%PS_EXAMPLE objective function for patternsearch.

%   Copyright 2003-2021 The MathWorks, Inc.

for i = 1:size(x,1)

    f(i) = (1.5-x(i,1)+x(i,1)*x(i,2))^2 + (2.25-x(i,1)+x(i,1)*x(i,2))^2 + (2.625-x(i,1)+x(i,1)*x(i,2)^3)^2;

end