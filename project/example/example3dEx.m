% This is an example for interp3d function in Ex field

% load the data
load('Ex.mat')
% Get the size of the file
field_size = size(Ex_yee);
% Save the results of interpolated values for Ex field
result = zeros(field_size(1)-1,field_size(2)-1);

% Select the x-z plane when y is 1
for i = 1:100
    for j = 1:100
        result(i,j) = interp3d(Ex_yee,i,1,j,'Ex');
    end
end
% Get the true value in Ex_int
true = permute(Ex_int(2:101,1,1:100),[1 3 2]);
% Get the absolute and relative error
absolute_e = result-true;
relative_e = abs(real(absolute_e./true));

% Show the relative error by imagesc function
figure(1) 
imagesc(relative_e)
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('z')
title('The relative error for E_x fields in 3d');

% Show the true value by imagesc function
figure(2) 
imagesc(real(true))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('z')
title('The known value for E_x fields in 3d');

% Show the interpolated value by imagesc function
figure(3) 
imagesc(real(result))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('z')
title('The interpolated value for E_x fields in 3d');
