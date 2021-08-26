function [intval] = interp2d(fmatrix, xi,yi,fname)
%INTERP2D Returns the interpolation value for two dimensions
%   Y = INTERP2D(X,N,M,FIELD) Returns the interpolation value for X 
%   at location (N,M) in a FIELD.  
%   X is a NxN matrix of field values to interpolate within and (N,M) are 
%   the position to specify where to interpolate.
%   % Example:
%   %   Interpolate an electric field at (50,50).
%
%   y = linspace(0,10,100);
%   z = y;
%   [Y_mesh, Z_mesh] = meshgrid(y,z);
%   field = sin(Y_mesh) + cos(Z_mesh);
%   interp2d(field,50,50,'E')


% Check the format of inputs
validateattributes(fmatrix,{'single','double'},{'2d'},'interp2d');
validateattributes(xi,{'numeric'},{'>=',1,'finite','integer','scalar'},'interp2d');
validateattributes(yi,{'numeric'},{'>=',1,'finite','integer','scalar'},'interp2d');

% Get the size of the input field
% At least 9*9
fsize=size(fmatrix);

% Check the length of input
if 9 > fsize(1) || 9 > fsize(2)
	error('size of data matrix must be at least 9*9.');
end

% Check the row number of target point
if xi > fsize(1)-1
	error('The interpolation position must be within the range of the matrix.');
end

% Check the input for field name
if fname~='E' & fname~='H'
	error('The field name should be E or H.');
end


% For electirc fields
if fname=='E'
    % Here are 3 cases. We only select 9 points to reduce operation.
    % Check the column number of target point
    if yi > fsize(2)
        error('The interpolation position must be within the range of the matrix.');
    end
    % When xi at the upper edge
    if xi<5
        input=fmatrix(1:9,yi);
        intval=bwinterp(input',xi);
    end
    % When xi in the middle
    if xi>4 && xi<fsize(1)-3
        input=fmatrix(xi-4:xi+4,yi);
        intval=bwinterp(input',5);
    end
    % When xi at the lower edge
    if xi>fsize(1)-4
        input=fmatrix(fsize(1)-8:fsize(1),yi);
        intval=bwinterp(input',xi-fsize(1)+9);
    end
end
% For magnetic fields
if fname=='H'
    % Check the column number of target point
    if yi > fsize(2)-1
        error('The interpolation position must be within the range of the matrix.');
    end
    temp_input=zeros(1,9);
    % When yi at the left edge
    if yi<5
        for i=1:9
            if xi<5
                input=fmatrix(1:9,i);
                temp_input(i)=bwinterp(input',xi);
            end
            if xi>4 && xi<fsize(1)-3
                input=fmatrix(xi-4:xi+4,i);
                temp_input(i)=bwinterp(input',5);
            end
            if xi>fsize(1)-4
                input=fmatrix(fsize(1)-8:fsize(1),i);
                temp_input(i)=bwinterp(input',xi-fsize(1)+9);
            end
        end
        intval=bwinterp(temp_input,yi);
    end
    % When yi in the middle
    if yi>4 && yi<fsize(2)-3
        for i=1:9
            if xi<5
                input=fmatrix(1:9,yi-5+i);
                temp_input(i)=bwinterp(input',xi);
            end
            if xi>4 && xi<fsize(1)-3
                input=fmatrix(xi-4:xi+4,yi-5+i);
                temp_input(i)=bwinterp(input',5);
            end
            if xi>fsize(1)-4
                input=fmatrix(fsize(1)-8:fsize(1),yi-5+i);
                temp_input(i)=bwinterp(input',xi-fsize(1)+9);
            end
        end
        intval=bwinterp(temp_input,5);
    end
    % When yi at the right edge
    if yi>fsize(2)-4
        for i=1:9
            if xi<5
                input=fmatrix(1:9,fsize(2)-9+i);
                temp_input(i)=bwinterp(input',xi);
            end
            if xi>4 && xi<fsize(1)-3
                input=fmatrix(xi-4:xi+4,fsize(2)-9+i);
                temp_input(i)=bwinterp(input',5);
            end
            if xi>fsize(1)-4
                input=fmatrix(fsize(1)-8:fsize(1),fsize(2)-9+i);
                temp_input(i)=bwinterp(input',xi-fsize(1)+9);
            end
        end
        intval=bwinterp(temp_input,yi-fsize(2)+9);
    end  
end