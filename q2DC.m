%Assume h = 1um for both x and y
m = 101;
    
n = 101;
hx = 1e-6;
hy = 70e-6/(n-1);
A = zeros(m*n, m*n);

% solve for 1D geometry
b = zeros(m*n,1);

% solve for the 2D interface
for i = 1:m
    for j = 1:n
        c = (i - 1)*n + j;      % Define row number of entry (x,y)
        if i == m || i == 1     
            A (c,c) = 1;
            k = (n-1)/7;
            cond = j>=k && j<=2*k|| j<=4*k && j>=3*k || j<=6*k && j>=5*k;   % Specify blank zones along y-axis
        if i == 1 && cond                                                   % V(x-1,y) = V(x,y) at the blank zone
            A(c,c) = -1;                                                    
            A(c,i*n + j) = 1;
        end   
        %elseif j == 1 
        %    A (c,c) = 1;
        %    A (c,c+1) = -1; 
        %    b (c) = 0;
        %elseif j == n
        %    A (c,c) = 1;
        %    A (c,c-n+1) = -1;
            
        %elseif i == m
        %    A (c,c) == 1;
        %elseif j == 1
        %    A (c,c) = 1;
        %elseif j == n
        %    A (c,c) = 1;
        else
            c1 = (i-2)*n + j;                                               %
            c2 = i*n + j;
            A(c, c-1:c+1) = [1 -4 1];   % Define the normal differential equation 
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

B = reshape(x,[n,m]);       % reshape into n rows and m columns
%B = vec2mat(x,n);
mesh(X,Y,B);
title('Potential Distribution');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Potential (V)');
