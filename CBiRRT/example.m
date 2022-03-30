clc, clear all, close all;

load exampleRobots.mat
robot = loadrobot("universalUR3");
% robot = loadrobot("kinovaMicoM1N4S200");
% robot = loadrobot("kukaIiwa14");

% robot = puma1;

robot.DataFormat = 'row';

n_start = Node.tform2node(robot,trvec2tform([0.366,0.366,0]),[0.1, 0.1, 0.1, 1, 1, 1000]);
% n_start.showNode(robot);
n_start.directKin(robot)
n_goal = Node.tform2node(robot,trvec2tform([-0.5,-0.143,0]), [0.1, 0.1, 0.1, 1, 1, 1000]);
%n_goal.showNode(robot);
n_goal.directKin(robot)

% Parameter Definition

MAX_ITERATION = 200;
MAX_STEP = 0.1;
eps = 0.01;
CHECK_SELF_COLLISION = false;

% TSR Definition

Bw = [-Inf, Inf; -Inf, Inf; -0.027, 0.027; -Inf, Inf; -Inf, Inf; -Inf, Inf];
T0_w = trvec2tform([0.5, 0.5, 0]);
angle_z = -pi;
Tw_e = [cos(angle_z)    sin(angle_z)    0       0
        -sin(angle_z)   cos(angle_z)    0       0
        0                   0           1       0
        0                   0           0       1];

tsr = TSR(T0_w,Tw_e,Bw);

%% CBiRRT Algorithm

[path, debug] = CBiRRT(n_start,n_goal,robot,tsr,CHECK_SELF_COLLISION,MAX_STEP,eps,MAX_ITERATION);

%% Data Visualization

AnimatePath(path,robot);
ShowTree(robot,debug.Ta,debug.Tb);
% ShowPath(path,robot,true);

%% Distance History Visualization

figure(2)
plot(1:MAX_ITERATION,debug.history);