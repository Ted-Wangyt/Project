classdef interp2dtest < matlab.unittest.TestCase
    methods (Test)
        % Negative test case
        % The correct input for E
        function testEmptyError(test)
            y = linspace(0,10,100);
            z = y;
            [Y_mesh, Z_mesh] = meshgrid(y,z);
            field = sin(Y_mesh) + cos(Z_mesh);
            % expect error
            expOut = interp2d(field,99,100,'E');
            test.verifyEqual(interp2d(field,99,100,'E'),expOut);           
        end
        % The wrong input for H
        function testWrongData(test)
            y = linspace(0,10,100);
            z = y;
            [Y_mesh, Z_mesh] = meshgrid(y,z);
            field = sin(Y_mesh) + cos(Z_mesh);
            % expect error
            expErrorId = 'interp2d:outofRange';
            test.verifyError(@()interp2d(field,99,100,'H'),expErrorId);           
        end
        % The input 'fname' is not a 'E' or 'H'
        function testWrongField(test)
            y = linspace(0,10,100);
            z = y;
            [Y_mesh, Z_mesh] = meshgrid(y,z);
            field = sin(Y_mesh) + cos(Z_mesh);
            % expect error
            expErrorId = 'interp2d:wrongField';
            test.verifyError(@()interp2d(field,99,100,'test'),expErrorId);           
        end
    end
end
