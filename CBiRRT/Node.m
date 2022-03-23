classdef Node

    properties
        q
        node_index
        parent_index
    end

    methods

        function obj = Node(q,node_index,parent_index)
            if nargin == 1
                obj.q = q;
                obj.node_index = 1;
                obj.parent_index = 0;
            elseif nargin == 2
                obj.q = q;
                obj.node_index = node_index;
                obj.parent_index = 0;
            elseif nargin == 3
                obj.q = q;
                obj.node_index = node_index;
                obj.parent_index = parent_index;
            end
        end

        function config = node2config(obj,robot)
            if strcmp(robot.DataFormat,'row')
                config = obj.q;
            else
                config = robot.homeConfiguration;
                for i = 1:length(obj.q)
                    config(i).JointPosition = obj.q(i);
                end
            end
        end

        function showNode(obj,robot)
            config = node2config(obj,robot);
            figure("Name",strcat('q = ', mat2str(obj.q))),
            show(robot,config);
        end

        function distance = nodeDistance(obj,node)
            q1 = obj.q;
            q2 = node.q;

            distance = 0;

            for i=1:length(q1)
                distance = distance + abs(angdiff(q1(i),q2(i)));
            end

        end

        function path = path(obj,Tree,isBackward)

            if ~isa(Tree,'Tree')
                error('Inavlid Data Type: Tree must be "Tree" class');
            end

            node = obj;
            path = [node];

            while node.parent_index >= 1
                parent = Tree.node_array(node.parent_index);
                path = [path, parent];
                node = parent;
            end

            if nargin == 3 & ~isBackward
                path = flip(path);
            end

        end

        function x = directKin(obj, robot)

            end_effector = robot.Bodies(end);
            end_effector = end_effector{1}.Name;

            x = getTransform(robot,obj.node2config(robot),end_effector);

        end

        function isWrapped = isWrapped(obj)
            isWrapped = (obj.q == wrapToPi(obj.q));
        end

        function collision = checkCol(obj,robot,false_collision)
            if strcmp(robot.DataFormat,'row')
                [collision, sepDist] = checkCollision(robot,obj.node2config(robot));
                if collision & ~isempty(false_collision)
                    [b1,b2] = find(isnan(sepDist));
                    if isequal([b1,b2],false_collision)
                        collision = false;
                    end
                end

            else
                collision = false;
            end
        end

    end

    methods(Static)
        function node = config2node(config, robot)
            if strcmp(robot.DataFormat,'row')
                node = Node(wrapToPi(config));
            else
                node = Node(wrapToPi([config.JointPosition]));
            end
        end

        function node = tform2node(robot,tform,weights)

            endeffector_name = robot.Bodies(end);
            endeffector_name = endeffector_name{1}.Name;

            ik = inverseKinematics('RigidBodyTree', robot);
            if nargin == 2
                weights = ones([1,length(robot.Bodies)]);
            end
            initialGuess = robot.homeConfiguration;
            config_sol = ik(endeffector_name,tform,weights,initialGuess);
            node = Node.config2node(config_sol,robot);
        end
    end
end

