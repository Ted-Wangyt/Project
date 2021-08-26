% This is an example for interp3d function in Hx field

% load the data
load('Hx.mat')
% Get the size of the file
field_size = size(Hx_yee);
% Save the results of interpolated values
result = zeros(field_size(1)-1,field_size(2)-1);
% Select the y-z plane when x is 1
for i = 1:100
    for j = 1:100
        result(i,j) = interp3d(Hx_yee,1,i,j,'Hx');
    end
end
% Get the true value in Hx_int
true =real(permute(Hx_int(1,2:101,2:101),[2 3 1]));
% Get the absolute and relative error
absolute_e = real(result-true);
relative_e = abs(real(absolute_e./true));
% Show the true value by imagesc function
figure(1) 
imagesc(real(true))
colorbar
set(gca,"Ydir","normal"); 
xlabel('z');ylabel('y')
title('The known value for H_x fields in 3d');
figure(2) 
% Show the interpolated value by imagesc function
imagesc(real(result))
colorbar
set(gca,"Ydir","normal"); 
xlabel('z');ylabel('y')
title('The interpolated value for H_x fields in 3d');
% Show the relative error by imagesc function
figure(3) 
imagesc(relative_e,[0 0.01])
colorbar
set(gca,"Ydir","normal"); 
xlabel('z');ylabel('y')
title('The relative error for H_x fields in 3d');


