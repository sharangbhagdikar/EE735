% We will begin our guess with x = 2
x = 160;
i = 1;
y = x^2 - 4*cos(x);
while y(i) > 1e-10 || y(i) < -1e-10
    i = i + 1;
    x(i) = x(i-1) - (x(i-1)^2 - 4*cos(x(i-1)))/(2*x(i-1) + 4*sin(x(i-1)));
    y(i) = x(i)^2 - 4*cos(x(i));
    
end

z = 0:length(x) -1;
plot(z,x,'r-o');
title('Quadratic covergence of root X');
xlabel('Number of iterations');
ylabel('Value of X');
format long
disp(x(i));


    