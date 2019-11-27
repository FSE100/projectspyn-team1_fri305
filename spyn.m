% Project Spyn - Team 1 FSE100 Tue/Fri
% Authored by Alex L., Molly S., and Vinodh N.

% Ports:
% Ultrasonic Sensor: 1
% Color Sensor: 2
% Touch Sensor: 4

% Manual Control Speed Variables
fwdSpeed = -40;
bwdSpeed = 40;
turnSpeed = 20;
armSpeed = 20;

brick.SetColorMode(2,2);

infinite = true

blueSenseCount = 0;
greenSenseCount = 0;

global key;
InitKeyboard();
manualControlEnabled = false;

% Main Loop
while infinite
    % Pause to ensure that we don't overload the brain
    pause(0.25);
    
    % Read Sensor Values
    distance = brick.UltrasonicDist(1);
    touchedL = brick.TouchPressed(3);
    touchedR = brick.TouchPressed(4);
    color = brick.ColorCode(2);
    
    % Print variable values
    blueSenseCount
    greenSenseCount
    manualControlEnabled;
    
    % Enter Manual Control
    if(key == 'm')
        manualControlEnabled = true;
        brick.StopMotor('AB', 'Brake');
    end
    
    % Exit Program
    if(key == 'q')
        brick.StopMotor('AB');
        iqnfinite = false;
    end
    
    % Autonomous Control
    if(manualControlEnabled == false)
        % If we see red:
        if color == 5
            [blueSenseCount, greenSenseCount] = reset();
            brick.StopMotor('AB', 'Brake')
            pause(4)
            brick.MoveMotorAngleRel('AB', -20, 180, 'Brake');
            brick.WaitForMotor('AB');
        end
        
        % Main wall following code:
        % Sharp Left Turn:
        if distance > 30.00
            % [blueSenseCount, greenSenseCount] = reset();
            brick.MoveMotor('A', -70);
            brick.MoveMotor('B', -40);
        % Normal Left Turn:
        elseif distance > 20.00
            % [blueSenseCount, greenSenseCount] = reset();
            brick.MoveMotor('A', -50);
            brick.MoveMotor('B', -45);
        % Right Turn
        elseif distance < 25.00
            % [blueSenseCount, greenSenseCount] = reset();
            brick.MoveMotor('A', -45);
            brick.MoveMotor('B', -50);
            
        end
        
        % If we see blue:
        if color == 2
            greenSenseCount = 0;
            blueSenseCount = blueSenseCount + 1;
            if blueSenseCount >= 3
                brick.StopMotor('AB');
                manualControlEnabled = true;
            end
        % If we see green:
        elseif color == 3
            blueSenseCount = 0;
            greenSenseCount = greenSenseCount + 1;
            if greenSenseCount >= 3
                brick.StopMotor('AB');
                manualControlEnabled = true;
            end
            
        else
            [blueSenseCount, greenSenseCount] = reset();
            
        end
        
        % If either of the touch sensors are activated:
        if(touchedL == 1 || touchedR == 1)
           % [blueSenseCount, greenSenseCount] = reset();
           brick.StopMotor('AB');    
           brick.MoveMotorAngleRel('AB', 20, 270, 'Brake');
           brick.WaitForMotor('AB');
           brick.MoveMotorAngleRel('A', 20, 173, 'Brake');
           brick.MoveMotorAngleRel('B', -20, 173, 'Brake');
           brick.WaitForMotor('AB');
           % [blueSenseCount, greenSenseCount] = reset();
           brick.MoveMotor('A', -45);
           brick.MoveMotor('B', -50);
           
        end   
            
    end
    
    % Manual Control
    if(manualControlEnabled == true)
        switch key
        case 'w' % Forward
            brick.StopMotor('AB');
            brick.MoveMotor('A',fwdSpeed);
            brick.MoveMotor('B',fwdSpeed);
        case 's' % Backward
            brick.StopMotor('AB');
            brick.MoveMotor('A',bwdSpeed);
            brick.MoveMotor('B',bwdSpeed);
        case 'a' % Left
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.MoveMotor('A',-turnSpeed);
            brick.MoveMotor('B',turnSpeed);
        case 'd' % Right
            brick.StopMotor('AB');
            brick.MoveMotor('A',turnSpeed);
            brick.MoveMotor('B',-turnSpeed);
        case 'p' % Return to autonomous control
            [blueSenseCount, greenSenseCount] = reset();
            manualControlEnabled = false;
        case 'z' % Stop
            brick.StopMotor('AB');
        case 'c' % Move Arm Up
            brick.MoveMotorAngleRel('D', armSpeed, 50, 'Coast');
        case 'v' % Move Arm Down
            brick.MoveMotorAngleRel('D', -armSpeed, 50, 'Coast');
        case 'q' % Exit program
            brick.StopMotor('AB');
            infinite = false;
        end
            
    end
end

CloseKeyboard();

% Reset variable values
function [a, b] = reset()
    a = 0;
    b = 0;
    
end