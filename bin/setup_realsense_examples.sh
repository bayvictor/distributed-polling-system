# Install ROS Kinetic full desktop environment
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-get update
sudo apt-get -y install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Install Intel RealSense SDK for Linux
sudo apt-key adv --keyserver keys.gnupg.net --recv-key D6FB2970 
sudo sh -c 'echo "deb http://realsense-alm-public.s3.amazonaws.com/apt-repo xenial main" > /etc/apt/sources.list.d/realsense-latest.list'
sudo apt update 
sudo apt install -y librealsense-object-recognition-dev librealsense-persontracking-dev librealsense-slam-dev libopencv-dev

# Download and compile ROS wrappers for Intel RealSense SDK for Linux
cd ~/src
mkdir realsense
cd realsense
mkdir -p catkin_ws/src
cd catkin_ws/src/
catkin_init_workspace 
git clone https://github.com/IntelRealSense/realsense_samples_ros
cd ..
catkin_make
source devel/setup.bash


