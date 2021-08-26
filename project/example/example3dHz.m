% This is an example for interp3d function in Hz field

% load the data
load('Hz.mat')
% Get the size of the file
field_size = size(Hz_yee);
% Save the results of interpolated values
result = zeros(field_size(1)-1,field_size(2)-1);
% Select the x-y plane when z is 1
for i = 1:100
    for j = 1:100
        result(i,j) = interp3d(Hz_yee,i,j,1,'Hz');
    end
end
% Get the true value in Hz_int
true=real(Hz_int(2:101,2:101,1));
% Get the absolute and relative error
absolute_e = real(result-true);
relative_e = abs(real(absolute_e./true));
% Show the true value by imagesc function
figure(1) 
imagesc(real(true))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('y')
title('The known value for H_z fields in 3d');
% Show the interpolated value by imagesc function
figure(2) 
imagesc(real(result))
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('y')
title('The interpolated value for H_z fields in 3d');
% Show the relative error by imagesc function
figure(3) 
imagesc(relative_e,[0 0.01])
colorbar
set(gca,"Ydir","normal"); 
xlabel('x');ylabel('y')
title('The relative error for H_z fields in 3d');




% result_2 = zeros(field_size(1)-1,field_size(2)-1);
% 
% for i = 1:100
%     for j = 1:100
%         result_2(i,j) = interp3d(Hz_yee,i,1,j,'Hz');
%     end
% end
% 
% true_2 =real(permute(Hz_int(2:101,1,2:101),[1 3 2]));
% absolute_2 = real(result_2-true_2);
% relative_2 = abs(real(absolute_2./true_2));
% 
% 
% figure(1) 
% imagesc(relative_2)
% colorbar
% set(gca,"Ydir","normal"); 
% xlabel('x');ylabel('z')
% title('The relative error for E_x fields in 3d');
% 
% figure(3) 
% imagesc(real(true_2))
% colorbar
% figure(5) 
% imagesc(real(result_2))
% colorbar
% figure(2) 
% imagesc(relative_2,[0 1])
% colorbar
% set(gca,"Ydir","normal"); 
% xlabel('x');ylabel('y')
% title('The relative error for H_x fields in 3d');
% 
% 
% 
% result_3 = zeros(field_size(1)-1,field_size(2)-1);
% 
% for i = 1:100
%     for j = 1:100
%         result_3(i,j) = interp3d(Hz_yee,1,i,j,'Hz');
%     end
% end
% true_3 =real(permute(Hz_int(1,2:101,2:101),[2 3 1]));
% absolute_3 = real(result_3-true_3);
% relative_3 = abs(real(absolute_3./true_3));
% 
% figure(21) 
% imagesc(relative_3')
% colorbar
% set(gca,"Ydir","normal"); 
% xlabel('y');ylabel('z')
% title('The relative error for E_x fields in 3d');
% 
% figure(23) 
% imagesc(real(true_3))
% colorbar
% figure(25) 
% imagesc(real(result_3))
% colorbar
% figure(22) 
% imagesc(relative_3',[0 0.01])
% colorbar
% set(gca,"Ydir","normal"); 
% xlabel('y');ylabel('z')
% title('The relative error for H_x fields in 3d');
% 
% 
