% Project Spyn - Team 1 FSE100 Tue/Fri

% Ports
% Ultrasonic Sensor: 1
% Color Sensor: 2
% Touch Sensor: 4

% Speed Variables
fwdSpeed = -40;
bwdSpeed = 40;
turnSpeed = 20;
armSpeed = 20;

% System Variables
curState = 0;
scanning = false;
scanCount = 0;

brick.SetColorMode(2,2);

infinite = true

blueSenseCount = 0;
greenSenseCount = 0;

global key;
InitKeyboard();
manualControlEnabled = false;

% Main Loop
while infinite
    pause(0.25);
    distance = brick.UltrasonicDist(1);
    touchedL = brick.TouchPressed(3);
    touchedR = brick.TouchPressed(4);
    color = brick.ColorCode(2)
    blueSenseCount
    greenSenseCount
    
    manualControlEnabled;
    % Enter Manual Control
    if(key == 'm')
        manualControlEnabled = true;
        brick.StopMotor('AB', 'Brake');
    end
    
    % Autonomous Control
    if(manualControlEnabled == false)
        if color == 5
            blueSenseCount = 0;
            brick.StopMotor('AB', 'Brake')
            pause(4)
            brick.MoveMotorAngleRel('AB', -20, 270, 'Brake');
            brick.WaitForMotor('AB');
        
%         elseif color == 2
%             greenSenseCount = 0;
%             blueSenseCount = blueSenseCount + 1;
%             if blueSenseCount > 20
%                 brick.StopMotor('AB');
%                 manualControlEnabled = true;
%             end
            
        elseif color == 3
%             blueSenseCount = 0;
%             greenSenseCount = greenSenseCount + 1;
%             if greenSenseCount > 20
                brick.StopMotor('AB');
                manualControlEnabled = true;
%             end
            
        elseif(touchedL == 1 || touchedR == 1)
           [blueSenseCount, greenSenseCount] = reset()
           brick.StopMotor('AB');    
           brick.MoveMotorAngleRel('AB', 20, 270, 'Brake');
           brick.WaitForMotor('AB');
           brick.MoveMotorAngleRel('A', 20, 173, 'Brake');
           brick.MoveMotorAngleRel('B', -20, 173, 'Brake');
           brick.WaitForMotor('AB');
           
        elseif distance > 30.00
            [blueSenseCount, greenSenseCount] = reset()
            brick.MoveMotor('A', -70);
            brick.MoveMotor('B', -40);
           
        elseif distance > 20.00
            [blueSenseCount, greenSenseCount] = reset()
            brick.MoveMotor('A', -50);
            brick.MoveMotor('B', -45);
  
        elseif distance < 25.00
            [blueSenseCount, greenSenseCount] = reset()
            brick.MoveMotor('A', -45);
            brick.MoveMotor('B', -50);
            
        end
            
    end
    
    % Manual Control
    if(manualControlEnabled == true)
        switch key
        case 'w'
            brick.StopMotor('AB');
            brick.MoveMotor('A',fwdSpeed);
            brick.MoveMotor('B',fwdSpeed);
        case 's'
            brick.StopMotor('AB');
            brick.MoveMotor('A',bwdSpeed);
            brick.MoveMotor('B',bwdSpeed);
        case 'a'
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.MoveMotor('A',-turnSpeed);
            brick.MoveMotor('B',turnSpeed);
        case 'd'
            brick.StopMotor('AB');
            brick.MoveMotor('A',turnSpeed);
            brick.MoveMotor('B',-turnSpeed);
        case 'p'
            manualControlEnabled = false;
        case 'z'
            brick.StopMotor('AB');
        case 'c' %Move Up
            brick.MoveMotorAngleRel('D', armSpeed, 50, 'Coast');
        case 'v'
            brick.MoveMotorAngleRel('D', -armSpeed, 50, 'Coast');
        case 'q'
            brick.StopMotor('AB');
            infinite = false;
        end
            
    end
end
CloseKeyboard();

function [a, b] = reset()
    a = 0;
    b = 0;
    
end