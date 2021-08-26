% This file is an example for interp2d function

% Generate a 2d sample field
y = linspace(0,10,100);
z = y;
[Y_mesh, Z_mesh] = meshgrid(y,z);
field = sin(Y_mesh) + cos(Z_mesh);

% Get the size of the matrix
field_size = size(field);

% E fields
% Save the results of interpolated values for E field
result_E = zeros(field_size(1)-1,field_size(2));
for i=1:field_size(1)-1
    for j=1:field_size(2)
        result_E(i,j)=interp2d(field, i,j,'E');
    end
end

% Get the true results by standard interpolation function
true_E = zeros(field_size(1)-1,field_size(2));
for j=1:field_size(2)
    y = interp(field(:,j)',4);
    for i=1:field_size(1)-1
        true_E(i,j)=y(4*i-1);
    end
end

% Get the absolute and relative error
absolute_e_E = result_E-true_E;
relative_e_E = abs(absolute_e_E./true_E);

% Show the result by imagesc function
figure(1); 
imagesc(relative_e_E)
colorbar
% just to orient things similar to the report
set(gca,"Ydir","normal"); 
xlabel('y');ylabel('z')
title('The relative error for E fields in 2d');

% Save the results of interpolated values for H field
result_H = zeros(field_size(1)-1,field_size(2)-1);
for i=1:field_size(1)-1
    for j=1:field_size(2)-1
        result_H(i,j)=interp2d(field, i,j,'H');
    end
end
% Get the true result by standard interpolation function
true_H = zeros(field_size(1)-1,field_size(2)-1);

% Save the temporary interpolated value for H fields
temp = zeros(field_size(1)-1,field_size(2));
for j=1:field_size(2)
    y = interp(field(:,j)',4);
    for i=1:field_size(1)-1
        temp(i,j)=y(4*i-1);
    end
end
for i=1:field_size(1)-1
    y_temp = interp(temp(i,:),4);
    for j=1:field_size(2)-1
        true_H(i,j)=y_temp(4*j-1);
    end
end

% Get the absolute and relative error
absolute_e_H = result_H-true_H;
relative_e_H = abs(absolute_e_H./true_H);

% Show the relative error by imagesc function
figure(2); 
imagesc(relative_e_H)
colorbar
% just to orient things similar to the Peters pdf figure
set(gca,"Ydir","normal"); 
xlabel('y');ylabel('z')
title('The relative error for H fields in 2d');
