function [T, n_reach] = ConstraintExtend(T,n_near,n_target,TSR,check_self_collision,false_collision,robot,max_step,max_iteration,eps)

iterations = 1;

ns = n_near;
ns_old = n_near;

while true
    if n_target.q == ns.q
        n_reach = ns;
        break
    elseif (n_target.nodeDistance(ns) > n_target.nodeDistance(ns_old))
        n_reach = ns_old;
        break
    elseif iterations > max_iteration
        n_reach = ns;
        break
    end

    ns_old = ns;
    ns.parent_index = ns_old.node_index;
    ns.q = wrapToPi(ns.q + min(max_step, n_target.nodeDistance(ns)) * (n_target.q - ns.q) / n_target.nodeDistance(ns));

    % ns = ConstrainConfig(ns_old, ns);

    [ns, found] = ProjectConfig(ns_old,ns,TSR,robot,eps,max_step);

    % Collision Check
    if found
        if check_self_collision
            if ~ns.checkCol(robot,false_collision)
                [T,ns.node_index] = T.addNode(ns);
            end
        else
            [T,ns.node_index] = T.addNode(ns);
        end
    else

        n_reach = ns_old;
        break
    end

    iterations = iterations + 1;

    if ns.nodeDistance(ns_old) < 5*eps
        n_reach = ns_old;
        break
    end

end

end

