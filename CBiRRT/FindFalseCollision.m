function false_collision = FindFalseCollision(robot)

    [isColliding, sepDist] = robot.checkCollision(robot.homeConfiguration);

    if isColliding
        [b1,b2] = find(isnan(sepDist));
        false_collision = [b1, b2];

    else      
        false_collision = [];

    end

end