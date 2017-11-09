echo "Installation
Configure your Ubuntu repositories
Configure your Ubuntu repositories to allow "restricted," "universe," and "multiverse." You can follow the Ubuntu guide for instructions on doing this.

Setup your sources.list
Setup your computer to accept software from packages.ros.org.
"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
echo "Mirrors
Source Debs are also available
Set up your keys
"

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
echo "If you experience issues connecting to the keyserver, you can try substituting hkp://pgp.mit.edu:80 or hkp://keyserver.ubuntu.com:80 in the previous command.

Installation
First, make sure your Debian package index is up-to-date:
"
sudo apt-get update -y 
echo "There are many different libraries and tools in ROS. We provided four default configurations to get you started. You can also install ROS packages individually.

In case of problems with the next step, you can use following repositories instead of the ones mentioned above ros-shadow-fixed

Desktop-Full Install: (Recommended) : ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators, navigation and 2D/3D perception " 
sudo apt-get install -y ros-lunar-desktop-full

echo "
or click here
Desktop Install: ROS, rqt, rviz, and robot-generic libraries
"

sudo apt-get install -y ros-lunar-desktop
echo "or click here
ROS-Base: (Bare Bones) ROS package, build, and communication libraries. No GUI tools.
"
sudo apt-get install -y ros-lunar-ros-base
echo "or click here
Individual Package: You can also install a specific ROS package (replace underscores with dashes of the package name):
sudo apt-get install ros-lunar-PACKAGE
e.g.
"
sudo apt-get install -y ros-lunar-slam-gmapping
echo "To find available packages, use:
"
apt-cache search ros-lunar

echo "Initialize rosdep
Before you can use ROS, you will need to initialize rosdep. rosdep enables you to easily install system dependencies for source you want to compile and is required to run some core components in ROS.
"

sudo rosdep init
rosdep update

echo "Environment setup
It's convenient if the ROS environment variables are automatically added to your bash session every time a new shell is launched:
"

echo "source /opt/ros/lunar/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo "If you have more than one ROS distribution installed, ~/.bashrc must only source the setup.bash for the version you are currently using.

If you just want to change the environment of your current shell, instead of the above you can type:
"

source /opt/ros/lunar/setup.bash

echo "
If you use zsh instead of bash you need to run the following commands to set up your shell:
"

echo "source /opt/ros/lunar/setup.zsh" >> ~/.zshrc
source ~/.zshrc
echo "
Dependencies for building packages
Up to now you have installed what you need to run the core ROS packages. To create and manage your own ROS workspaces, there are various tools and requirements that are distributed separately. For example, rosinstall is a frequently used command-line tool that enables you to easily download many source trees for ROS packages with one command.

To install this tool and other dependencies for building ROS packages, run:
"

sudo apt-get install -y --force-yes python-rosinstall python-rosinstall-generator python-wstool build-essential

echo "
Build farm status
The packages that you installed were built by the ROS build farm. You can check the status of individual packages here.

Tutorials
Now, to test your installation, please proceed to the ROS Tutorials.

Wiki: lunar/Installation/Ubuntu (last edited 2017-07-25 16:51:50 by DHood)
Except where otherwise noted, the ROS wiki is licensed under the 
Creative Commons Attribution 3.0 | Find us on Google+

"


