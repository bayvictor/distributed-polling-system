echo "Introduction to Intel® RealSense™ SDK for Linux
Getting Started
The following instructions will help get you started to quickly use the SDK

Prerequisites
Operating System
This release is validated using Ubuntu™* 16.04 on Intel® Joule™.

For the Intel Joule, download and install Ubuntu™ 16.04 using the instructions from this link here. More information about Intel Joule is available at https://software.intel.com/en-us/iot/hardware/joule
You can try this on other devices (such as Intel® NUC™), but these uses are not fully validated. To install Ubuntu 16.04 LTS Desktop, follow the instructions at https://www.ubuntu.com/download/desktop, or the instructions that came with your device.
Setting Time
The correct time must be set before following the instructions below. For instance, the Intel Joule module does not come supplied with a real-time-clock (RTC) battery, therefore you need to set the time manually before continuing installation.  The steps below can be used to automatically set the time from your internet connection:

Network Time Setup:

    1 $ "
sudo apt update -y --force-yes 
sudo apt install chrony ntpdate -y --force-yes 
sudo ntpdate ntp.ubuntu.com
echo "Or you can manually set the time on the command line (if the time is 4:47 PM, the 23rd day of January 2017):

Manually Setting Time:

    1 $ 

sudo date -s "16:47 1/23/2017"
Installation Instructions
Step 1: Setting up the repository
The following steps will add the RealSense repository to your Ubuntu device's package manager:

Adding repository:

    1 $ 
"
echo 'deb "http://realsense-alm-public.s3.amazonaws.com/apt-repo" xenial main' | sudo tee /etc/apt/sources.list.d/realsense-latest.list
sudo apt-key adv --keyserver keys.gnupg.net --recv-key D6FB2970 
sudo apt update 
echo "
Step 2: Installing Samples and Runtime
The following steps will install the SDK runtime and Person Tracking, Object Library, and SLAM samples:

Installing Samples and Runtime:

    1 $ 
"
sudo apt install librealsense-samples beignet-opencl-icd
echo "When the runtime and samples are installed, if your camera is plugged into, please unplug then replug it back to ensure all settings have been applied.

All samples installed to /usr/bin, with 'rs_' prefix (e.g. rs_slam_tutorial_1_gui)
Samples ending with 'gui' work with keyboard and mouse connected locally to device
Samples ending with 'web' start built-in webserver, allowing you to connect remotely to device from another computer
Samples without 'gui' or 'web' are console-only samples, with very basic command line interface.
See https://software.intel.com/sites/products/realsense/samples for detailed information about the samples
3. Optional Features
After the instructions above are completed, you can optionally install these additional features.

Installing Camera Access Utilities
You can install the camera access to determine if your camera is functioning correctly:

Camera Access Utilities Install

    1 $ "

sudo apt install librealsense-utils
cpp-capture
echo "
cpp-capture will preview live video from the ZR300 camera

Installing Development Kit
You can install the RealSense SDK to develop your own RealSense applications:

Development Kit Installation:

    1 $ "

sudo apt install -y --force-yes librealsense-object-recognition-dev librealsense-persontracking-dev librealsense-slam-dev
echo "
Here is how you can test that the SDK installed correctly, by building the RealSense samples from source:

Building Samples from Source:

    1 $ "
cd ~/src/realsense
sudo apt install -y --force-yes build-essential git cmake libjpeg-dev libopencv-dev
git clone http://github.com/IntelRealSense/realsense_samples
cd realsense_samples
 mkdir build
 cd build
 cmake ..
 make
echo "
  When the compilation completes, you will find all realsense_samples in your build folder, ready to run in-place

Individual Packages
Individual RealSense software packages can be installed to tailor development and runtime needs to the smallest subset required. Here is a list of the individual runtime and development packages provided:

librealsense1
librealsense-dev
librealsense-sdk0
librealsense-sdk-dev
librealsense-sdk-logger
librealsense-sdk-logger-dev
librealsense-sdk-projection0
librealsense-sdk-projection-dev
librealsense-object-recognition0
librealsense-object-recognition-dev
librealsense-persontracking0
librealsense-persontracking-dev
librealsense-slam2
librealsense-slam-dev
*All other trademarks or registered trademarks are the property of their respective owners. 


© 2017 Intel Corporation
Terms of Use
*Trademarks
Privacy
Cookies

"
echo "done!"


