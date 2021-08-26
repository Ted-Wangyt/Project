% This is an example for interp3d function in Ey field

% load the data
load('gvvars.mat')
% Get the size of the file
field_size = size(Ey_yee);
% Save the results of interpolated values
result = zeros(field_size(1)-1,field_size(2)-1);

% Select the x-y plane when z is 1
for i = 1:100
    for j = 1:100
        result(i,j) = interp3d(Ey_yee,i,j,1,'Ey');
    end
end
result=result';
% Get the true value in Ey_int
true =real(Ey_int(2:101,1:100,1));
% Get the absolute and relative error
absolute_e = real(result-true);
relative_e = abs(real(absolute_e./true));

% Show the interpolated value by imagesc function
figure(1) 
imagesc(real(result))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('y')
title('The interpolated value for E_y fields in 3d');
% Show the true value by imagesc function
figure(2) 
imagesc(real(true))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('y')
title('The known value for E_y fields in 3d');
% Show the relative error by imagesc function
figure(3) 
imagesc(relative_e,[0 0.01])
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('y')
title('The relative error for E_y fields in 3d');

