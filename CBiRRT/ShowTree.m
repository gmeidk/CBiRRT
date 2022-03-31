function ShowTree(robot,Ta,Tb)

a_list = cell2mat(arrayfun(@(node) tform2trvec(node.directKin(robot)),...
    Ta.node_array, 'UniformOutput', false));
a_list = reshape(a_list,3,[]);

show(robot,Ta.node_array(1).node2config(robot)); hold on


plot3(a_list(1,1),a_list(2,1),a_list(3,1),'p','Color','r',...
    'MarkerSize',8,'MarkerFaceColor','#d62828'); hold on, grid on;
plot3(a_list(1,2:end),a_list(2,2:end),a_list(3,2:end),'o',...
    'Color','y','MarkerSize',5,'MarkerFaceColor','#e9c46a'); hold on,

if nargin == 3
    b_list = cell2mat(arrayfun(@(node) ...
        tform2trvec(node.directKin(robot)),...
        Tb.node_array, 'UniformOutput', false));
    b_list = reshape(b_list,3,[]);

    show(robot,Tb.node_array(1).node2config(robot)); hold on

    plot3(b_list(1,1),b_list(2,1),b_list(3,1),'p','Color','r',...
        'MarkerSize',8,'MarkerFaceColor','#d62828'); hold on,
    plot3(b_list(1,2:end),b_list(2,2:end),b_list(3,2:end),'o',...
        'Color','b','MarkerSize',5,'MarkerFaceColor','#184e77');
end
end