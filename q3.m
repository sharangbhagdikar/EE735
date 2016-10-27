prompt = 'Give the number of steps (eg 100)';
n = input(prompt) + 1;
if isempty(n)
    n = 101;
end
%disp(n);
q = 1.6e-19;
h = 100e-6/(n-1);
epsilon = 8.85e-12;

A = full(gallery('tridiag',n,1,-2,1));
A (1,:) = 0;
A (n, :) = 0;
A (1,1) = 1;
A (n,n) = 1;

b = ones(n,1);
b = b*((q*(1e22)*(h^2))/epsilon);
b(1) = 0;
b(n) = 1;
%disp(b);
%b((n-1)*3/5 + 1) = +1129.9;

x = A\b;
%x = inv(A)*b;
y = 0:100e-6/(n-1):100e-6;
plot(y,x,'g-');
title('Potential Profile');
ylabel('Potential (V)');
xlabel('Distance (m)');

