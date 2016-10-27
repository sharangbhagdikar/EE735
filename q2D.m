%Assume h = 1um for both x and y
prompt = 'Give number of steps in X direction';
m = input(prompt) + 1;
if isempty(m)
    m = 101;
end

prompt = 'Give number of steps in Y direction';
n = input(prompt) + 1;
if isempty(n)
    n = 11;
end

hx = 100e-6/(m-1);
hy = 10e-6/(n-1);
A = zeros(m*n, m*n);

% solve for 1D geometry
b = zeros(m*n,1);

% solve for the 2D interface
for i = 1:m
    for j = 1:n
        c = (i - 1)*n + j;
        if i == 1 || i == m  
            A (c,c) = 1;
        elseif j == 1
            A (c,c) = 1;
            A (c,c + 1) = -1;
            b (c) = 0;
        elseif j == n
            A (c,c) = 1;
            A (c,c-1) = -1;
            b(c) = 0;
        %elseif i == m
        %    A (c,c) == 1;
        %elseif j == 1
        %    A (c,c) = 1;
        %elseif j == n
        %    A (c,c) = 1;
        else
            c1 = (i-2)*n + j;
            c2 = i*n + j;
            A(c, c-1:c+1) = [1 -4 1];
            A(c, c1) = 1;
            A(c, c2) = 1;
        end
    end
end
%disp(A(12,11));

b((m*n-n+1):m*n,1) = 1;
%b (1:n,1) = 1;
        
x = A\b;
X = 0:hx:100e-6;
Y = 0:hy:10e-6;
B = reshape(x,[n,m]);
%B = vec2mat(x,n);
mesh(X,Y,B);
title('Potential Distribution');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Potential (V)');

