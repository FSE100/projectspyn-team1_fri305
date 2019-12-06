while 1
    % C = color_pick_up_drop_off(brick)
    Forward32(brick);
    dis = zeros(1, 3);
    dis(1) = brick.UltrasonicDist(1);
    LeftTurn90(brick);
    LeftTurn90(brick);
    dis(2) = brick.UltrasonicDist(1);
    LeftTurn90(brick);
    dis(3) = brick.UltrasonicDist(1);
    if (sum(dis>81) == 0)
        % turn 180 from original direction
        RightTurn90(brick);
    end 
    r = randi(3);
    while dis(r) < 81
        r = randi(3);
    end 
    switch r 
        case 1
            % Turn 90 left from original direction
            LeftTurn90(brick);
            LeftTurn90(brick);
%       case 2
%             Turn 90 right from original direction
        case 3 
            % Continue in original direction
            LeftTurn90(brick);
    end 
end 