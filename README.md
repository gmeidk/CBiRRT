<div id="top"></div>

<br>
<div align="center">
 <img src="https://user-images.githubusercontent.com/81641638/159668041-bec23a74-b4fd-4da7-a463-4c03a5275e22.png" alt="CBiRRT algorithm" height="750" width="750">

</div>
<h3 align="center">CBiRRT</h3>
<p align="center">CBiRRT algorithm for manipulator robot implemented in Matlab.</p>
<br>

<!-- ABOUT THE PROJECT -->
## About The Project

<br>
The Constrained Bidirectional Rapidly Exploring Random Tree (CBiRRT) Algorithm for path planning is implemented for a robot manipulator in Matlab. The implementation is carried out by referring to the following papers:<br>

<br>

 1. [Berenson, D., Srinivasa, S. and Kuffner, J. (2011) ‘Task Space Regions: A framework for pose-constrained manipulation planning’, The International Journal of Robotics Research, 30(12), pp. 1435–1460. doi: 10.1177/0278364910396389.](https://personalrobotics.cs.washington.edu/publications/berenson2011task.pdf)
 2. [Berenson, Dmitry & Srinivasa, Siddhartha & Ferguson, Dave & Kuffner, James. (2009). Manipulation planning on constraint manifolds. 625-632. 10.1109/ROBOT.2009.5152399.](https://www.ri.cmu.edu/pub_files/2009/5/berenson_dmitry_2009_2.pdf)
<br>

### Built With

* [MATLAB](https://it.mathworks.com/products/matlab.html)
* [Robotics System Toolbox](https://it.mathworks.com/products/robotics.html)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- FUNCTION DESCRIPTION -->
## Function description


### CBiRRT

<br>

    [path, debug] = CBiRRT(n_start,n_goal,robot,TSR,check_self_collision,max_step,eps,max_iteration)
In order to execute the **CBiRRT** function you must provide the following input parameters : <br>

<br>

| Input Parameter | Description | DataType |
| --- | :---: | :---: |
| `n_start` | starting configuration node | Node |
| `n_goal` | goal configuration node | Node |
| `robot` | robot model | rigidBodyTree|
| `TSR` | Task Space Region | TSR |
| `check_self_collision` | enable robot self collision | bool |
| `max_step` | max distance update configuration  | float |
| `eps` | TSR tolerance | float |
| `max_iteration` | stop condition | int |

<br>

The function provides the following outputs:

<br>

| Output | Description | DataType |
| --- | :---: | :---: |
| `path` | set of nodes that compose the path| array(Node) |
| `debug` | structure for debugging | struct |

<br>
The "CBiRRT" algorithm is composed by the following functions:<br>
<br>

 - *RandomConfig*
 - *NearestNeighbor*
 - *ConstraintExtend*
 - *ProjectConfig*

The listed functions are described in the papers cited previously <a href="#top">[1],[2]</a>.<br>
<br>

### ShowPath

    ShowPath(path,robot,new_fig)
Shows the path given as input in the operational space. 

<br>

### AnimatePath

    AnimatePath(path,robot,duration)
Sets the figure showing the starting configuration of the robot, the goal configuration and the animation of the robot during the computed path in the operational space.

<br>

### ShowTree

    ShowTree(robot,Ta,Tb)
Shows the nodes belonging to the two different trees in the operational space.

<br>

### Usage
An usage example is reported in the ***example.m*** file.

<br>

<!-- ROADMAP -->
## Roadmap




- [x] Implementation of the *Node* and *Tree* classes and their related functions.
- [x] Implementation of the *BiRRT* algorithm.
- [X] Implementation of the *TSR* class and of the *CBiRRT* algorithm.
- [X] Implementation of the robot self collision check.
- [X] Update README.
- [ ] Improve the algorithm's efficiency.
- [ ] Implement *ConstraintConfig* function and *TSR Chain*.
- [ ] Implement *AddRoot* function.
- [ ] Implement *SmoothPath* function.


<p align="right">(<a href="#top">back to top</a>)</p>

## MATLAB Simulation

https://user-images.githubusercontent.com/81641638/159668466-d4785f6d-5c7a-469f-95b6-5bf405e17f73.mp4


<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact


Alessandro Quatela - [@qualex97](https://bit.ly/3dP01Dp) - a.quatela1@studenti.poliba.it 

Giuseppe Roberto - [@gmeidk](https://bit.ly/30rueVT) - g.roberto1@studenti.poliba.it

Project Link: [https://github.com/gmeidk/CBiRRT](https://bit.ly/3JBkud8)

<p align="right">(<a href="#top">back to top</a>)</p>
