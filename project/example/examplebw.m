% This is an example for bwinterp function

% Generate a 1d input vector
t = 0:0.001:.029;                      
x = sin(2*pi*30*t) + sin(2*pi*60*t);
n=length(x);

% Save the results of interpolated values
result = zeros(1,n-1);
for m=1:n-1
    result(m)=bwinterp(x,m);
end

% Get the true results by standard interpolation function
y = interp(x,4);
true = zeros(1,n-1);
for m=1:n-1
    true(m)=y(4*m-1);
end

% Show the figure for interpolated value and true value
figure(1)
plot(result,'-O')
hold on
plot(true,'-*')
hold off
legend('result','true')
xlabel('ni')
ylabel('value')
title('The values for result from new function and true value');

% Get the absolute and relative error
absolute_e = result-true;
relative_e = abs(absolute_e./true);

% Show the relative error
figure(2)
plot(relative_e)
legend('relative error')
xlabel('ni')
ylabel('value')
title('The relative error for 1d');


