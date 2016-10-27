%% General Newton's Non-Linear Equation Solver

%% Definitions
syms x1 x2 ;                    % Invoke symbols to be called to construct Jacobian
input = [x1;x2] ;               % Input arguments           
x0 = [5;-5] ;                   % Initial Guess. Tweak here to get different roots!

[y1, y2] = newton(input) ;      % Vector Function defined in a separate file

%[a,b] = solve([y1,y2],[x1,x2]);                % Uncomment to solve directly

%% Initialize the matrix
J_equ = jacobian([y1,y2], input) ;              % Jacobian in symbols
J     = subs (J_equ, input, x0) ;               % Jacobian
F     = -1*(subs([y1;y2], input, x0)) ;         % Vector Function
x = J\F + x0;
num_F = cast(F, 'double');
check = (num_F > 1e-10) | (num_F < -1e-10);

%% Iteration begins here
while ~(isempty(check(check==1)))               % Checks for presence of any '1' in logic vector
J     = subs (J_equ, input, x) ;                % Jacobian
F     = -1*(subs([y1;y2], input, x)) ;          % Vector Function
x = J\F + x;                                    % Solve Matrix here
num_F = cast(F, 'double');
check = (num_F > 1e-10) | (num_F < -1e-10);

end

disp(double(x))
