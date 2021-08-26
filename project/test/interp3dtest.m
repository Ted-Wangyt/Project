classdef interp3dtest < matlab.unittest.TestCase
    methods (Test)
        % Negative test case
        % The wrong input for field
        function testWrongData(test)
            % expect error
            expErrorId = 'interp3d:wrongLength';
            test.verifyError(@()interp3d([], 1,1,1,'Hx'),expErrorId);           
        end
        % The input 'fname' is wrong
        function testWrongField(test)
            for i=1:10
                for j=1:10
                    for k=1:10
                        A(i,j,k)=1;
                    end
                end
            end
            % expect error
            expErrorId = 'interp3d:wrongField';
            test.verifyError(@()interp3d(A,1,1,1,'test'),expErrorId);           
        end
    end
end
