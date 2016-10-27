capac = [];
%Assume h = 1um for both x and y
for m = 11:10:101
    
n = 101;
hx = 1e-6;
hy = 70e-6/(n-1);
A = zeros(m*n, m*n);

% solve for 1D geometry
b = zeros(m*n,1);

% solve for the 2D interface
for i = 1:m
    for j = 1:n
        c = (i - 1)*n + j;
        if i == m || i == 1
            A (c,c) = 1;
            k = (n-1)/7;
            cond = j>=k && j<=2*k|| j<=4*k && j>=3*k || j<=6*k && j>=5*k;
        if i == 1 && cond  
            A(c,c) = -1;
            A(c,i*n + j) = 1;
        end   
        
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
X = 0:hx:(m-1)*1e-6;
Y = 0:hy:70e-6;

B = reshape(x,[n,m]);
%disp(size(B));
capa = (B (1:n,2) - B (1:n,1))*8.85e-12;

capac = [capac,sum(capa)];
end
m = 11:10:101;
plot(m,capac,'bo-');
title('Capacitance as a function of distance');
xlabel('Distance (um)');
ylabel('Capacitance (Farad/length)');

