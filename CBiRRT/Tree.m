classdef Tree

    properties
        node_array
        isBackward
    end

    methods
        function obj = Tree(root_node, isBackward)
            obj.node_array = [root_node];
            if nargin == 2
                obj.isBackward = isBackward;
            elseif nargin == 1
                obj.isBackward = false;
            end

        end

        function [obj, node_index] = addNode(obj,node)
            if isa(node,'Node')
                node_index = length(obj.node_array) + 1;
                node.node_index = node_index;
                obj.node_array = [obj.node_array, node];
            else
                error("Input type must be 'Node'")
            end
        end
    end
end

