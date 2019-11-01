function L = LeftTurn90(brick)
    % Left turn

    brick.MoveMotorAngleRel('A', -20, 173, 'Brake');
    brick.MoveMotorAngleRel('B', 20, 173 , 'Brake');
    brick.WaitForMotor('AB');

    L = true;
end 