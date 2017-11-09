sudo apt-get install llvm-dev -y
sudo apt-get install python3-dev -y
#python3 /tmp/get-pip.py

#pip3 install sugartensor tensorflow scikit-learn matplotlib numpy scipy panda fbprophet jupyter
pip3 install  librosa
python3 recognize.py asset/data/LibriSpeech/test-clean/1089/134686/1089-134686-0000.flac
 python3 recognize.py asset/data/LibriSpeech/test-clean/1089/134686/1089-134686-0001.flac


