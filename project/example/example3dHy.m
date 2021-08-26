% This is an example for interp3d function in Hy field

% load the data
load('Hy.mat')
% Get the size of the file
field_size = size(Hy_yee);
% Save the results of interpolated values
result = zeros(field_size(1)-1,field_size(2)-1);

% Select the x-z plane when y is 1
for i = 1:100
    for j = 1:100
        result(i,j) = interp3d(Hy_yee,i,1,j,'Hy');
    end
end
% Get the true value in Hy_int
true =real(permute(Hy_int(2:101,1,2:101),[1 3 2]));
% Get the absolute and relative error
absolute_e = real(result-true);
relative_e = abs(real(absolute_e./true));
% Show the true value by imagesc function
figure(1) 
imagesc(real(true))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('z')
title('The known value for H_y fields in 3d');
% Show the interpolated value by imagesc function
figure(2) 
imagesc(real(result))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('z')
title('The interpolated value for H_y fields in 3d');
% Show the relative error by imagesc function
figure(3) 
imagesc(relative_e,[0 0.01])
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('z')
title('The relative error for H_y fields in 3d');



