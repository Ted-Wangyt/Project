function [value] = interp3d(fmatrix3d, xi,yi,zi,fieldname)
%INTERP3D Returns the interpolation value for two dimensions
%   Y = INTERP3D(X,N,M,L,FIELD) Returns the interpolation value for X 
%   at location (N,M,L) in a FIELD.  
%   X is a NxNxN matrix of field values to interpolate within and (N,M,L) are 
%   the position to specify where to interpolate.


% Check the format of inputs
validateattributes(fmatrix3d,{'single','double'},{'3d'},'interp3d');
validateattributes(xi,{'numeric'},{'>=',1,'finite','integer','scalar'},'interp3d');
validateattributes(yi,{'numeric'},{'>=',1,'finite','integer','scalar'},'interp3d');
validateattributes(zi,{'numeric'},{'>=',1,'finite','integer','scalar'},'interp3d');

% Get the size of matrix
% The field is at least 9*9*9
fsize=size(fmatrix3d);

% Check the length of input
if 9 > fsize(1) || 9 > fsize(2) || 9 > fsize(3)
	error('size of data matrix must be at least 9*9*9.');
end

% Check the location of target point
if xi > fsize(1)-1 || yi > fsize(1)-1 || zi > fsize(1)-1
	error('The interpolation position must be within the range of the matrix.');
end

% Check for the field name
if fieldname~='Ex' & fieldname~='Ey' & fieldname~='Ez' & fieldname~='Hx' & fieldname~='Hy' & fieldname~='Hz'
	error('The field name should be Ex, Ey, Ez, Hx, Hy or Hz.');
end



% For electirc field

if fieldname == 'Ex'
    % Convert to a one-dimensional matrix and apply the bwinterp function
    value=bwinterp(fmatrix3d(:,yi,zi)', xi);
end
if fieldname == 'Ey'
    value=bwinterp(fmatrix3d(xi,:,zi), yi);
end
if fieldname == 'Ez'
    value=bwinterp(reshape(fmatrix3d(xi,yi,:),1,[]), zi);
end

% For magnetic field

if fieldname == 'Hx'
    % Set the field name for interp2d function
    fname='H';
    % Convert to a two-dimensional matrix and apply the interp2d function
    value=interp2d(permute(fmatrix3d(xi,:,:),[2 3 1]), yi,zi,fname);
end
if fieldname == 'Hy'
    fname='H';
    value=interp2d(permute(fmatrix3d(:,yi,:),[3 1 2]), zi,xi,fname);
end
if fieldname == 'Hz'
    fname='H';
    value=interp2d(fmatrix3d(:,:,zi), xi,yi,fname);
end
