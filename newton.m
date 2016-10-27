%% Newton's Method for Non-Linear System of Equations
function [y1 y2] = newton (x1)
y1 = x1(1) + 2*x1(2) - 2 ;
y2 = x1(1)^2 + 4*x1(2)^2 - 8 ;
end
