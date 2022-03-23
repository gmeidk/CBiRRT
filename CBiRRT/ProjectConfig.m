function [ns,found] = ProjectConfig(ns_old,ns,TSR,robot,eps,max_step)

    endeffector_name = robot.Bodies(end);
    endeffector_name = endeffector_name{1}.Name;

    while true

        T0_s = directKin(ns, robot);
        delta_x = displacement(TSR, T0_s);
        if norm(delta_x) < eps
            found = true;
            break
        end
        J = geometricJacobian(robot,node2config(ns,robot),endeffector_name);
        delta_qerr = pinv(J)*delta_x;
        ns.q = wrapToPi(ns.q - delta_qerr');
        if nodeDistance(ns,ns_old) > 2 * max_step
            ns=0;
            found = false;
            break
        end
    end
    


end

