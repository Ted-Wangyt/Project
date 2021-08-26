function [intval] = bwinterp(avec, ni)
%BWINTERP Returns the interpolation value
%   Y = BWINTERP(X,N) Returns the interpolation value for X at location N.  
%   X is a 1xN matrix of field values to interpolate within and N is 
%   an index to specify where to interpolate.
%   % Example:
%
%   t = 0:0.001:.029;                       % Time vector
%   x = sin(2*pi*30*t) + sin(2*pi*60*t);    % Original Signal
%   n=length(x);
%   result = zeros(1,n-1);
%   for m=1:n-1
%       result(m)=bwinterp(x,m);            % Result for b new
%   end
%   y = interp(x,4);
%   true = zeros(1,n-1);
%   for m=1:n-1
%       true(m)=y(4*m-1);                   % Interpolated value
%   end
%   subplot(211);
%   stem(result);
%   title('result for b new');
%   subplot(212);
%   stem(true); 
%   title('interpolated value');

% Define error function
% For the cases that the target interpolation position is out of the range of the vector.
errorSize.message = 'The interpolation position must be within the range of the vector.';
errorSize.identifier = 'bwinterp:outofRange';

% For the cases length is less than 9
errorData.message = 'Length of data sequence must be at least 9.';
errorData.identifier = 'bwinterp:wrongLength';


% Check the format of inputs
validateattributes(avec,{'single','double'},{'vector'},'bwinterp');
validateattributes(ni,{'numeric'},{'>=',1,'finite','integer','scalar'},'bwinterp');

% Get the length of input vector
n=length(avec);

% Check the length of input
if 9 > n
    error(errorData);
	% error('Length of data sequence must be at least 9.');
end
if ni > n-1
    error(errorSize);
	% error('The interpolation position must be within the range of the vector.');
end

% The coefficient value for b
b_value = [-0.006777513830457   0.039457774230868  -0.142658093427599   0.609836360660665   0.609836360660665   -0.142658093427599   0.039457774230868  -0.006777513830457];
size_b = length(b_value);
b_new = zeros(1,n);
% For different cases of the location ni
if ni==1
    b_new=[0.389880694606290   0.752494454088264  -0.182115867658467   0.046235288061325  -0.006777513830457 zeros(1,n-ni-4)];
end
if ni==2
    b_new=[-0.077297572626776   0.570378586429797   0.616613874491122  -0.142658093427599   0.039457774230868   -0.006777513830457 zeros(1,n-ni-4)];
end
if ni==3
    b_new=[0.025902746569955  -0.135880579597142   0.609836360660665   0.609836360660665  -0.142658093427599    0.039457774230868  -0.006777513830457 zeros(1,n-ni-4)];
end
% The cases in middle
if size_b-5<ni && ni<n-3
    b_new=[zeros(1,ni-4) b_value zeros(1,n-ni-size_b+4)];
end
% The cases on the edge
if ni==n-3
    ni=3;
    b_new=flip([0.025902746569955  -0.135880579597142   0.609836360660665   0.609836360660665  -0.142658093427599    0.039457774230868  -0.006777513830457 zeros(1,n-ni-4)]);
end
if ni==n-2
    ni=2;
    b_new=flip([-0.077297572626776   0.570378586429797   0.616613874491122  -0.142658093427599   0.039457774230868   -0.006777513830457 zeros(1,n-ni-4)]);
end
if ni==n-1
    ni=1;
    b_new=flip([0.389880694606290   0.752494454088264  -0.182115867658467   0.046235288061325  -0.006777513830457 zeros(1,n-ni-4)]);
end
% The output
intval=b_new*avec';


        