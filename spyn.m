% Project Spyn - Team 1 FSE100 Tue/Fri

% Ports
% Ultrasonic Sensor: 1
% Color Sensor: 2
% Touch Sensor: 4

% Speed Variables
fwdSpeed = 40;
bwdSpeed = -40;
turnSpeed = 20;
armSpeed = 20;

% System Variables
curState = 0;
scanning = false;
scanCount = 0;

brick.SetColorMode(2,2);

infinite = true

global key;
InitKeyboard();
manualControlEnabled = false;

% Passenger Pickup Variables
foundBlue = false;
foundGreen = false;

% Main Loop
while infinite
    pause(0.25);
    distance = brick.UltrasonicDist(1);
    touchedL = brick.TouchPressed(3)
    touchedR = brick.TouchPressed(4)
    color = brick.ColorCode(2)
    manualControlEnabled;
    % Enter Manual Control
    if(key == 'm')
        manualControlEnabled = true;
        brick.StopMotor('AB', 'Brake');
    end
    % Autonomous Control
    if(manualControlEnabled == false)
        if color == 5
            brick.StopMotor('AB', 'Brake')
            pause(4)
            brick.MoveMotorAngleRel('AB', -20, 270, 'Brake');
            brick.WaitForMotor('AB');
        
        elseif color == 2
            manualControlEnabled = true;
            brick.StopMotor('AB');
            
        elseif color == 3
            brick.StopMotor('AB');
            brick.MoveMotorAngleRel('A', 20, 346, 'Brake');
            brick.MoveMotorAngleRel('B', -20, 346, 'Brake');
            brick.WaitForMotor('AB');
            brick.MoveMotorAngleRel('D', -10, 90, 'Brake');
            
        elseif(touchedL == 1 || touchedR == 1)
           brick.StopMotor('AB');    
           brick.MoveMotorAngleRel('AB', 20, 270, 'Brake');
           brick.WaitForMotor('AB');
           brick.MoveMotorAngleRel('A', 20, 173, 'Brake');
           brick.MoveMotorAngleRel('B', -20, 173, 'Brake');
           brick.WaitForMotor('AB');
           
        elseif distance >= 12 && distance <= 20
            brick.MoveMotor('A', -50);
            brick.MoveMotor('B', -40);
  
        elseif distance < 12
            brick.MoveMotor('A', -40);
            brick.MoveMotor('B', -50);
        
        elseif distance > 20
            brick.MoveMotor('A', -80);
            brick.MoveMotor('B', -40);
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
            brick.MoveMotorAngleRel('D', armSpeed, 60, 'Coast');
        case 'v'
            brick.MoveMotorAngleRel('D', -armSpeed, 60, 'Coast');
        case 'q'
            brick.StopMotor('AB');
            infinite = false;
        end
            
    end
end
CloseKeyboard();