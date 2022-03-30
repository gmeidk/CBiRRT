function AnimatePath(path,robot,duration)

figure("WindowState","maximized"), hold on,

subplot(2,2,1), title('test'),
robot.show(node2config(path(1),robot),'PreservePlot',false,'FastUpdate',false);

subplot(2,2,3)
robot.show(node2config(path(length(path)),robot),'PreservePlot',false,...
    'FastUpdate',false);

subplot(2,2,[2,4]), hold on,
ShowPath(path,robot,false),

if nargin == 2
    duration = 3;
end

step = duration/length(path);

for i=1:length(path)
    node = path(i);
    % disp(node.q)
    subplot(2,2,[2,4]), hold on;
    robot.show(node2config(node,robot),'PreservePlot',false,'FastUpdate',false);
    pause(step)

end
end