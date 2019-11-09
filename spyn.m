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

% States
% 0: Normal
% 1: Reverse from wall
% 2: Scan for possible paths
% 3: Color Red Scanned, Pause robot
% 4: Color Blue Scanned, Pause robot, 
% Manual Control Variables
global key;
InitKeyboard();
manualControlEnabled = false;

% Passenger Pickup Variables
foundBlue = false;
foundGreen = false;

% Main Loop
while infinite
    pause(0.1);
    curState
    
    % Enter Manual Control
    if(key == 'm')
        manualControlEnabled = true;
        brick.StopMotor('AB');
    end
    
    % Autonomous Control
    if(manualControlEnabled == false)
        switch curState
            case 0
                Forward32(brick);
                bumpedRight = brick.TouchPressed(4)
                bumpedLeft = brick.TouchPressed(3)
                color = brick.ColorCode(2)
%                 if(bumpedRight == 1 || bumpedLeft == 1)
%                     brick.beep(1);
% %                     if(color == 2)
% %                         curState = 4;
% %                     elseif(color == 4)
% %                         curState = 1;
% %                     elseif(color == 5)
% %                         curState = 3;
% %                     else
%                     curState = 1;
%                     brick.StopMotor('AB');
%                 end
            if(bumpedLeft == 1 || bumpedRight == 1)
                brick.beep(1);
                curState = 1;
            end
            curState = 2;
            case 1
                brick.MoveMotorAngleRel('AB', bwdSpeed, 585, 'Coast');
                brick.WaitForMotor('AB');
                curState = 2;
            case 2
                % Check all sides
                distances = zeros(1,3);
                distances(1) = brick.UltrasonicDist(1)
                LeftTurn90(brick);
                LeftTurn90(brick);
                distances(2) = brick.UltrasonicDist(1)
                LeftTurn90(brick);
                distances(3) = brick.UltrasonicDist(1)
                
                % If all sides are below a threshold, pick a random one
                if(sum(distances>75) == 0)
                    RightTurn90(brick);
                else
                    r = randi(3)
                    while(distances(r) < 75)
                        r = randi(3)
                    end
                
                    switch r
                        case 1
                            LeftTurn90(brick);
                            LeftTurn90(brick);
                            curState = 0;
                        case    2
                            % Do Nothing
                        case 3
                            LeftTurn90(brick);
                            curState = 0;
                    end
                end
            case 3
                brick.StopMotor('AB');
                pause(4);
                curState = 0;
            case 4
                brick.StopMotor('AB');
                manualControlEnabled = true;
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
        case 'c'
            brick.MoveMotor('D', armSpeed);
            pause(0.25);
            brick.StopMotor('D');
        case 'v'
            brick.MoveMotor('D', -armSpeed);
            pause(0.25);
            brick.StopMotor('D');
        case 'q'
            brick.StopMotor('AB');
            infinite = false;
        end
            
    end
end
CloseKeyboard();