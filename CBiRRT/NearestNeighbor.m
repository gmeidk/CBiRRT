function n_near = NearestNeighbor(T,n_target)
    node_array = T.node_array;

    % matrix composed of the distances between the nodes of the tree 
    % and n_target
    distance_matrix = cell2mat(arrayfun(@(node) ...
        node.nodeDistance(n_target), node_array, 'UniformOutput', false));

    [min_dist, n_index] = min(distance_matrix);

    n_near = node_array(n_index);
end