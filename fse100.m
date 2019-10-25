brick = legoev3;    

left = motor(brick, 'A');
right = motor(brick, 'B');         
chair = motor(brick, 'D');
ultrasonic = sonicSensor(brick);
touch = touchSensor(brick);

global key
PERIOD = 0.1;                           
SPEED = 0;     
distance = 0;
touched = false;

left.Speed = SPEED;
right.Speed = SPEED;

clearLCD(brick)
InitKeyboard()

infinite = true
manualControl = false;

while infinite
    if(key == 'e')
        manualControl = true;
        clearLCD(brick);
        writeLCD(brick, 'MC Enabled');
    end
    
    if(manualControl == true)
    switch key
        case 'w'
            stop(left);
            stop(right);
            SPEED = 50;
            left.Speed = SPEED;
            right.Speed = SPEED;
            start(left)
            start(right)
        case 's'
            stop(left);
            stop(right);
            SPEED = -50;
            left.Speed = SPEED;
            right.Speed = SPEED;
            start(left)
            start(right)
        case 'l'
            stop(left);
            stop(right);
            SPEED = 20;
            left.Speed = -SPEED;
            right.Speed = SPEED;
            start(left)
            start(right)
            pause(2);
            stop(left);
            stop(right);
        case 'r'
            stop(left);
            stop(right);
            SPEED = 20;
            left.Speed = SPEED;
            right.Speed = -SPEED;
            start(left)
            start(right)
            pause(2);
            stop(left);
            stop(right);
        case 'p'
            manualControl = false;
            clearLCD(brick);
            writeLCD(brick, 'MC not enabled!');
        case 'z'
            stop(left)
            stop(right)
        case 'q'
            stop(left)
            stop(right)
            infinite = false
    end
    else
        writeLCD(brick, 'MC not enabled!');
        touched = readTouch(touch);
        distance = readDistance(ultrasonic);
        disp(touched)
        disp(distance)
    end
    pause(PERIOD);
end

clear
