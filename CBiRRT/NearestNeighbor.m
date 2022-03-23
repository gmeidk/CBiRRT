function n_near = NearestNeighbor(T,n_target)
    node_array = T.node_array;

    distance_matrix = cell2mat(arrayfun(@(node) node.nodeDistance(n_target), node_array, 'UniformOutput', false));

    [min_dist, n_index] = min(distance_matrix);

    n_near = node_array(n_index);
end

