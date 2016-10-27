prompt = 'Give the number of steps (eg 100)';
n = input(prompt) + 1;
if isempty(n)
    n = 101;
end
%disp(n);
% Initialize a general 1D Poisson Equation Matrix
A = full(gallery('tridiag',n,1,-2,1));
A (1,:) = 0;
A (n, :) = 0;
A (1,1) = 1;
A (n,n) = 1;

b = zeros(n);
b(n) = 1; 

x = A\b;
%x = inv(A)*b;
y= 0:100e-6/(n-1):100e-6;
plot(y,x);
title('Potential Profile');
ylabel('Potential (V)');
xlabel('Distance (m)');

