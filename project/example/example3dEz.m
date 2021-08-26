% This is an example for interp3d function in Ez field

% load the data
load('gvvars.mat')
% Get the size of the file
field_size = size(Ez_yee);
% Save the results of interpolated values
result = zeros(field_size(1)-1,field_size(2)-1);

% Select the y-z plane when x is 1
for i = 1:100
    for j = 1:100
        result(i,j) = interp3d(Ez_yee,1,i,j,'Ez');
    end
end
% Get the true value in Ez_int
true =real(permute(Ez_int(1,1:100,2:101),[2 3 1]));
% Get the absolute and relative error
absolute = real(result-true);
relative = abs(real(absolute./true));

% Show the interpolated value by imagesc function
figure(1) 
imagesc(real(result))
colorbar
set(gca,"Ydir","normal"); 
xlabel('y');ylabel('z')
title('The interpolated value for E_z fields in 3d');
% Show the true value by imagesc function
figure(2) 
imagesc(real(true))
colorbar
set(gca,"Ydir","normal"); 
xlabel('y');ylabel('z')
title('The known value for E_z fields in 3d');
% Show the relative error by imagesc function
figure(3) 
imagesc(relative,[0 0.01])
colorbar
set(gca,"Ydir","normal"); 
xlabel('y');ylabel('z')
title('The relative error for E_z fields in 3d');
