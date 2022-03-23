function CheckInputParams(n_start,n_goal,robot,TSR,check_self_collision,max_step,eps,max_iteration,false_collision)

if check_self_collision
    if ~strcmp(robot.DataFormat,'row')
        error("If check collision is true robot.DataFormat must be 'row'.");
    end
    
    if n_start.checkCol(robot,false_collision)
        error("If check collision is true start configuration must be without collision.");
    end

    if n_goal.checkCol(robot,false_collision)
        error("If check collision is true goal configuration must be without collision.");
    end

end

end

