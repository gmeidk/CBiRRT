function [path, debug] = CBiRRT(n_start,n_goal,robot,TSR,check_self_collision,max_step,eps,max_iteration)

try
    tic
    old_toc = 0;

    bar = waitbar(0,'Ricerca in corso...', 'Name','CBiRRT - Quatela, Roberto', 'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(bar,'canceling',0);

    % if check_self_collision is true calculate the false collision array
    if check_self_collision
        false_collision = FindFalseCollision(robot);
        disp('False Collision occured in HomeConfiguration, those will be neglected.');
    else
        false_collision = [];
    end

    % check correctness of CBiRRT input params 
    CheckInputParams(n_start,n_goal,robot,TSR,check_self_collision,max_step,eps,max_iteration,false_collision);

    % algorithm initialization
    Ta = Tree(n_start, false);
    Tb = Tree(n_goal, true);

    iterations = 1;

    dist = zeros([1,max_iteration]);

    n_reach1_min = n_start;
    n_reach2_min = n_goal;
    min_dist = n_reach1_min.nodeDistance(n_reach2_min);
    n_reach1_min_back = false;


    time_it_old = 2;


    while true

        % stop condition 
        if (iterations > max_iteration) | getappdata(bar,'canceling')
            if n_reach1_min_back == Ta.isBackward
                path_a = n_reach1_min.path(Ta, n_reach1_min_back);
                path_b = n_reach2_min.path(Tb, ~n_reach1_min_back);
            else
                path_a = n_reach1_min.path(Tb, n_reach1_min_back);
                path_b = n_reach2_min.path(Ta, ~n_reach1_min_back);
            end

            if ~n_reach1_min_back
                path = [path_a, path_b];
            else
                path = [path_b, path_a];
            end
            disp("Soluzione non trovata");
            break
        end

        n_rand = RandomConfig(robot);

        n_a_near = NearestNeighbor(Ta,n_rand);

        [Ta, n_a_reach] = ConstraintExtend(Ta,n_a_near,n_rand,TSR,check_self_collision,false_collision,robot,max_step,Inf,eps);

        n_b_near = NearestNeighbor(Tb,n_a_reach);

        [Tb, n_b_reach] = ConstraintExtend(Tb,n_b_near,n_a_reach,TSR,check_self_collision,false_collision,robot,max_step,Inf,eps);

        % save the calculated distance (debug.history)
        dist(iterations) = nodeDistance(n_a_reach,n_b_reach);

        % save the best result obtained
        if dist(iterations) < min_dist
            n_reach1_min = n_a_reach;
            n_reach1_min_back = Ta.isBackward;
            n_reach2_min = n_b_reach;
            min_dist = dist(iterations);
        end

        % end condition
        if nodeDistance(n_a_reach,n_b_reach) <= max_step
            path_a = n_a_reach.path(Ta,Ta.isBackward);
            path_b = n_b_reach.path(Tb,Tb.isBackward);
            if Tb.isBackward
                path = [path_a, path_b];
            else
                path = [path_b, path_a];
            end
            break
        else
            [Ta, Tb] = Swap(Ta,Tb);
        end

        % estimation of remaining time displayed on the waitbar
        iterations = iterations + 1;
        time_it = time_it_old * 0.9 + 0.1 * (toc - old_toc);
        old_toc = toc;
        time_it_old = time_it;
        time_est = floor(time_it*(max_iteration-iterations));
        waitbar(iterations/max_iteration,bar,strjoin(["Ricerca in corso... (",iterations," iter, ",time_est," sec)"]));
    end

    % save the debug structure and close the waitbar
    debug = struct('history', dist, 'Ta', Ta, 'Tb', Tb, 'iterations', iterations, 'time_elapsed', toc);
    delete(bar);

% catch the error and stop the algorithm
catch exception
    delete(bar);
    msgbox(exception.message);
    rethrow(exception);
end

end

