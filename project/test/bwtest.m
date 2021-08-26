classdef bwtest < matlab.unittest.TestCase
    methods (Test)
        % Negative test case
        % The target interpolation position is out of the range of the vector
        function testEmptyError(test)
            t = 0:1/1e3:.029;
            x = sin(2*pi*30*t) + sin(2*pi*60*t);
            % expect error
            expErrorId = 'bwinterp:outofRange';
            test.verifyError(@()bwinterp(x,50),expErrorId);            
        end
        % The length of ’avec’ is is less than 9
        function testWrongData(test)
            t = 0:1/1e3:.007;
            x = sin(2*pi*30*t) + sin(2*pi*60*t);
            % expect error
            expErrorId = 'bwinterp:wrongLength';
            test.verifyError(@()bwinterp(x,5),expErrorId);            
        end
        % The target interpolation position is not an integer
        function testNotInteger(test)
            t = 0:1/1e3:.029;
            x = sin(2*pi*30*t) + sin(2*pi*60*t);
            % expect error
            expErrorId = 'MATLAB:bwinterp:expectedInteger';
            test.verifyError(@()bwinterp(x,10.5),expErrorId);            
        end
        % The input ’avec’ is not a ‘single’ or ‘double’ vector
        function testFormatData(test)
            t = 0:1/1e3:.029;
            x = sin(2*pi*30*t) + sin(2*pi*60*t);
            % expect error
            expErrorId = 'MATLAB:bwinterp:invalidType';
            test.verifyError(@()bwinterp('test',5),expErrorId);            
        end
    end
end
