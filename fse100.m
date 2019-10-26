global key
PERIOD = 0.1;

InitKeyboard()

infinite = true
manualControl = false;

brick.SetColorMode(1,2);
while infinite
    if(key == 'e')
        manualControl = true;
    end
    
    if(manualControl == true)
    switch key
        case 'w'
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.MoveMotor('A',50);
            brick.MoveMotor('B',50);
        case 's'
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.MoveMotor('A',-50);
            brick.MoveMotor('B',-50);
        case 'a'
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.MoveMotor('A',-20);
            brick.MoveMotor('B',20);
        case 'd'
            brick.StopMotor('A');
            brick.StopMotor('B');
            brick.MoveMotor('A',20);
            brick.MoveMotor('B',-20);
        case 'p'
            manualControl = false;
        case 'shift'
            brick.StopMotor('A');
            brick.StopMotor('B');
        case 'c'
            brick.MoveMotor('D', 5);
            pause(0.5);
            brick.StopMotor('D');
        case 'v'
            brick.MoveMotor('D', -5);
            pause(0.5);
            brick.StopMotor('D');
        case 'q'
            brick.StopMotor('A');
            brick.StopMotor('B');
            infinite = false
    end
    else
        distance = brick.UltrasonicDist(1);
        touched = brick.TouchPressed(4);
        color = brick.ColorCode(2);
        display(touched)
        display(distance)
        display(color)
    end
    touched = brick.TouchPressed(4);
    if(touched == true)
        brick.StopMotor('A');
        brick.StopMotor('B');
    end
    
    color = brick.ColorCode(2);
    switch color
        case 2
            playTone(brick, 250, 0.5, 20)
        case 3
            playTone(brick,500,0.5,30)
        case 4
            playTone(brick,750,0.5,40)
        case 5
            playTone(brick,1000,0.5,50)
        case 6
            playTone(brick, 1250, 0.5, 60)
    end
    
    distance = brick.UltrasonicDist(1);
    if(distance > 15)
        playTone(brick, 500, 0.5, 50)
        pause(0.25)
        playTone(brick, 750, 0.5, 10)
        pause(0.25)
        playTone(brick, 500, 0.5, 50)
        pause(0.25)
        playTone(brick, 750, 0.5, 10)
        pause(0.25)
    end
    pause(PERIOD);
end