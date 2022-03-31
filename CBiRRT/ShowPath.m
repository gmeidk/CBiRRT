function ShowPath(path,robot,new_fig)

path_T = cell2mat(arrayfun(@(node) tform2trvec(node.directKin(robot)), ...
    path,'UniformOutput', false));
path_T = reshape(path_T,3,[]);

if nargin == 3
    if new_fig 
        figure(),
    end
else
    figure(),
end

axis([-1 1 -1 1 -1 1]), view([135,8]);

plot3(path_T(1,:),path_T(2,:),path_T(3,:),'-.o','Color','b',...
    'MarkerSize',6,'MarkerFaceColor','#D9FFFF'), grid on;

end