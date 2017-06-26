# Diary: MOCKING DATA STREAM GENERATION<br>
try to put all opensource codes found here in github together -- which polls, and indexes distributed item on the cloud.
<br><br>
A lot of existing codes here but our collections differ in below:<br>
1. Put all relevant codes together here, keep the original license and IP notes.<br>
2. When experimenting different branches, notes will be put for bugs, to do, or core value of certain branches here.<br>
<br><br>
The public open source experiments and evaluated notes will be noted by date in form of diary for later reference.
<br><br>
12/9/2016:<br>
We are focusing on only mocking data-stream generating here!<br>
1) search here in github for "tenant", ranked by stars, found top 10 worth further experiments.<br>
2) Is it working? If several of top 20 of them be added with "masks" for mocking a data-source of "mocking multitenant" source? This is opensource, safe and economic touch-stone for prototyping (may be proprietary) any analytic engine or advisor system as smoke test before real-data stream swimming.<br>
3) What elemments can be added to make tenant system "real"? (3.1) time-freq pattern trigger certain random push; (3.2) some geo-distributed random LBS added; (3.3) some PC t-shirt auto-tayloring; (3.4) some consuming pattern generated for (bandwidth, storage, load balance ); (3.5)list continue, added later for benefiting the community.<br>
4) Consuming resource simulation(CRS). (CPU core number, RAM size, ssd storage, hd storage, cloud-nas storage, time, network heat-map, micro-service kubenetes number, pod number, load balance iRule number; <any-pair>:D=="any keyword":"any random in ANY-RANGE" -pairing generator ).<br>
With above CRS in mind, smoothen out the better behavor (algorthm, curve-masks ) to generate the mocking tenant data.<br>
Later we can even generate specific "Mocking" CRS in any industrial domain, like POS, cellular network, Highway sensor network, retailer PC network, ATM network, sport-car motion sensor data; etc.<br>
We believe above "mocking" system data will nenefit the human being, and speed up innovations! So we calling full domain volunteers  adding his "mocking data water cocks" here!<br>
<br><br>

In any above "tenant" search hit branches, for modification meeting "mocking function", we have to add rest API, universal, simple "push data adapters" and "land-lord convention" for it qualified a "mocking tenant system" to act ! -- with a good API to the eco system!
<br><br>
<br><br>

Dec 12/2016:<br><br>
One of the answers for the above said open source "NETWORK SIMULATOR" is ns-3. <br><br>
On ns-3 a lot of simulation studies are done like ( a 24-hour Scenario of Luxembourg City for SUMO
Traffic simulations {https://www.researchgate.net/profile/Lara_Codeca/publication/276063017_LuST_a_24-hour_Scenario_of_Luxembourg_City_for_SUMO_Traffic_simulations/links/555080f608ae12808b381148.pdf}, which is using open source ns-3 to simulate a mid-size city, real traffic in a whole day).<br><br>
By reading through of it, this work can be used for any-nature "network simulation". While it's in node size 1k-10k network simulation, whether it's nodes and edges mapped to "high way shoulders" and "local roads", it can be mapped into any nodes/edges models, image those couples can be:<br><br>
1. in IC design automation (EDA), it can be : nodes = gates; edges = wires;<br>
2. In P2P mobile network design, it can be: nodes = cellphone-peers; edges = wifi connection;<br>
3. in drone IoT network, nodes = drones; edge01's = wifi; edge02's = cellular connection on 3G or 4G network.<br>
4. ...<br><br>
5. On "back bone network" for ISP, the "ns-3" teamplate can be sure to emulate when: nodes = switches and gateways; edges = wifi and cable connections.<br><br>

So with this success story, we put a reading note here to point out, the design of cloud can be automated like CHIP/IC design, on the same scale (node numbers, data flow), as well as time-to-market, which is mature and comparable!<br><br>

So far with above study of open-source works, any domain from the anology with "network simulation" mentioned above can simplify POC in a grate variety of domain modeling!<br>
As result, this "mocking network" by simulation, it can be nothing on IP, but a sharping stone for your IP, where all intelligence and labor on and being protected!<br>
<br><br>
Notes on setting up open source python scikit, -- the random-forest-algorithm:<br>
Install python pip, best practice:<br>
wget https://bootstrap.pypa.io/get-pip.py<br>
python 3 get-pip.py ## better on win7 use c:\Python27, instead of cygwin python.<br>
git clone git://github.com/scikit-learn/scikit-learn.git<br>
Refs:http://www.analyticsvidhya.com/blog/2<br>015/09/random-forest-algorithm-multiple-challenges/
<br><br>
Jan/05/2017:<br><br>
(1) Notes: data samples for tensorflow trainings from MIT: (79M pages, The 79 million images are stored in one giant binary file, 227Gb in size.):<br>
<br><br>
 1. Image bina
ry (227Gb)   Download ( 1. Image binary (227Gb)   Download source: http://horatio.cs.nyu.edu/mit/tiny/data/index.html).
<br><br>
(2) http://wiki.dbpedia.org/data-set-20: DBpedia: data generated from 2007 wikiPedia data dump. <br>

Jan 06, 2017<br>
For machine learning, there is a data collecting website:https://data.world/. It is so called social networking by dataset collectors, <br>
we see here there are a lot of public data sources (demographic data, etc), which can be used for training prototypes of machine learning model, <br>
like scikit-learn, spark, mahout, tensorflow, etc. Strongly recommended!  <br><br>
Because it's also a circle of data scientists, good for probling here! :) <br><br>

Jan 9, 2017<br>
Notes for interesting machine learning topics & advances:
1. Gan; 2. CNN+RNN innovation; 3. TensorFlow based conceptual revolution; 4. Search & ML; 5. GPU-oriented ML frame; 

Reading notes:
A. Thread： 我眼中的未来：视频、AI、个性化、传统企业和AR  , Posted：2016-11-28 07:51, source:http://www.huxiu.com/article/172387.html <br>


Jan 12, 2017<br>
“What I cannot create, I do not understand.” —Richard Feynman <br>
Above quotation is best one for goal of GAN !<br>

Notes on 3d shape trainning data: shapenet:https://shapenet.org/taxonomy-viewer <br>
A public article dealing with aboveShapeNet: https://arxiv.org/pdf/1607.00662.pdf, titled as :"Unsupervised Learning of 3D Structure from Images" <br>

Jan 13, 2017. <br> 
A. Readings in a article: The Neuroscience of Trust - Harvard Business Review: https://hbr.org/2017/01/the-neuroscience-of-trust, Paul J. Zak, FROM THE JANUARY–FEBRUARY 2017 ISSUE, 1. <br>
Compared with people at low-trust comp. Below is reading abstract:<br>
anies, people at high-trust companies report: 74% less stress, 106% more energy at work, 50% higher productivity, 13% fewer sick days, 76% more engagement, 29% more satisfaction with their lives, 40% less burnout.<br>
How to manage trust? (1)Recognize excellence; (2) Induce "challenge stress" with team goal; (3) push self motivatior, especially <br>
the younger and the inexperienced innovates more; (4). enable job crafting; trust employee work selection; (5) share info broadly; <br>
(6) intentional building relationship; (7) facilitate whole-person bonding progress; (8) show vulnerability;  <br><br>

B. Everyone is a dataset producer -- thus https://medium.com/@ilblackdragon/tensorflow-tutorial-part-1-c559c63c0cb1#.rnonq38mwthe era of machine learning is coming. <br>
<br><br>
Classical datasets: source:http://www.bigfastblog.com/how-to-get-experience-working-with-large-datasets <br>
Here’s a list of places that have data available, provided by  Geoff Webb.<br>
http://data.vancouver.ca<br><br> 
http://stats.oecd.org/index.aspx  <br> <br> 
http://data.un.org/Explorer.aspx <br>  <br> 
http://mdgs.un.org/unsd/mdg/Data.aspx <br>  
http://robjhyndman.com/TSDL <br>
http://www.ngdc.noaa.gov/ngdc.html <br>
http://www.data.gov <br>
http://www.data.gov.uk <br>
http://data.worldbank.org <br>
<br><br>
Some others I think are worth looking at are Wikipedia, Freebase and DBpedia. Freebase pulls its data from Wikipedia on a regular basis, as well as from TVRage, Metacritic, Bloomberg and CorpWatch. DBpedia also pulls data from Wikipedia, as well as YAGO, Wordnet and other sources.<br><br>
<br><br>
You can download a dump of the Freebase dataset here(http://download.freebase.com/datadumps/). More information on the these dump files can be found here(http://wiki.freebase.com/wiki/Data_dumps).<br><br><br><br>

Why tensorflow? <br><br> 
source:https://medium.com/@ilblackdragon/tensorf<br> low-tutorial-part-1-c559c63c0cb1#.rnonq38mw  <br>
Summary from above source, for "why tensorflow"?<br>    <br>
1. Stack a number of multiple models in one and <br> learn<br>  them together; <br>
2. text, images, cc(categorical & continues) variable<br> s in one model. <br> 
3. multi-target & multi-loss at the same time; <br> 
T.F. pipeline benefits: <br> 
My add-ons: train once (in powerful computer like GPU grid), run everywhere (including embedded devices). <br> 
<br> <br> 
<br> 

Jan 19, 2017. Notes in Simplicity in machine learning (crawler example, less OR, less NOT, but core-UNIQUE): <br> 
reading "In 2016, Googling Simpler is Better"(source:www.recruitingblogs.com/profiles/blogs/in-2016-googling-simpler-is-better
):<br>
resume "full stack" engineer node.js "san francisco" "gmail" , better than "old style" operators like inxxx(inanchor, inurl).<br>
<br><br> better machine learner keywords that must appear within:<br>
Email address details – gmail.com hotmail.com <br> 
Phone numbers including area codes or words like cell, mobile or Skype. <br> 
Phrases like – “reason for leaving” “references available” “home address” “work history” “dates of employment.” <br> 
 <br> 
 
 On Twitter, use “I work for” followed by the name of the company or “at [name of company]” such as “at Deloitte” to find employees who work there.<br>
On Google, type “top engineers to follow” and Twitter lists will show up.<br>
On Bing, type “contains:” to find pages hosting documents like word docs, PDFs and PowerPoint slide decks. “Those PDFs might be resumes. PowerPoints might have signatures and contact information,” he said.<br>
A critical tip: Don’t try to create the perfect search string <br>

Jan 24, 2017 <br>
Reading Notes on Feature Engineering use case on CPU: <br>
Public available source: https://www.researchgate.net/publication/266273948_Enhancing_Regression_Models_for_Complex_Systems_Using_Evolutionary_Techniques_for_Feature_Engineering <br> 
7 feature variables for power consumption of CPU: (U:usage%, T, freq, Volt, age, 
RAM access per cycle, T of RAM, Fan-speed) <br>
perf: CPU+RAM usage; IPMI (cpu+RAM T); 
cpufreq-utils:(CPU:fr+Vt); <br>
Details: Power consumption is measured with a current clamp
with the aim of validating our approach. CPU and main
memory utilization are monitored using hardware coun-
ters collected with perf monitoring tool. On board sen-
sors are checked via IPMI to get both CPU and mem-
ory temperatures and fan speed. CPU frequency and
voltage are monitored via cpufreq-utils Linux package.
To build a model that includes power dependance with
these variables, we use this software tool to modify
CPU DVFS modes during workload execution. Also
room temperature has been modifed in run-time with
the goal of finding non-traditional consumption sources
that are influenced by this variable. <br><br>

Jan 30, 2017<br>
(1)source:http://3ms.huawei.com/hi/group/2894399/thread_5194253.html<br>
谷歌正在与OpenPower Foundation合作，就是为了扩大选择范围。OpenPower Foundation的芯片设计任何人都可以使用和修改。<br>
(2) https://github.com/floydhub/dl-docker.git, good, it has all machine learning tools in one docker images. <br><br>

Feb 1, 2017 <br>
(1)YARN<br>
source:http://searchdatamanagement.techtarget.com/definition/Apache-Hadoop-YARN-Yet-Another-Resource-Negotiator <br>
Apache YARN is now characterized as a large-scale, distributed operating system for big data applications. <br>
Separating HDFS from MapReduce with YARN makes the Hadoop environment more suitable for operational applications that can't wait for batch jobs to finish. <br>
YARN offers a world beyond MapReduce: less-encumbered by complex programming protocols, faster, and at a lower cost.<br>
<br><br>
(2) Public dataset source is the jumpstart point for all machine learning. Google "datasets downloads" we get: <br>
2.1. http://www.data.world/data-sets,  besides data, it claims itself "The Data Social Network".<br>
<br><br>
Feb 6, 2017: Reading notes: <br>
GPU Hardware Powers MapD Big Data Management <br>
source: http://www.informationweek.com/infrastructure/pc-and-servers/gpu-hardware-powers-mapd-big-data-management/d/d-id/1327755?
When it comes to clickstream data, server log analysis or machine learning, there's a likely GPU-based system in IT's future.
<br>
Intel and AMD CPUs can move data at an optimum rate of 50-75 GB per second. The Nvidia and other brand GPUs can move it at 300-750 GB per second, The GPU hardware beneath the Core system can scan 6-8 TB per second. <br>
<br><br>
Quantum computing: <br>
source:https://www.wired.com/2017/01/d-wave-turns-open-source-democratize-quantum-computing/ <br>
D-Wave’s machines are designed for a single purpose: solving optimization problems. The classic example is known as the traveling salesman problem: calculating the shortest route that passes through a list of specific locations. <br>

Predicting the end of cloud computing: This Andreesen Horowitz VC believes the cloud will be replaced by edge computing.<br>
source:http://www.networkworld.com/article/3152800/cloud-computing/predicting-the-end-of-cloud-computing.html <br>
<br>

source:http://www.networkworld.com/article/3153047/internet-of-things/iot-product-development-is-broken-6-ways-developers-and-manufacturers-can-fix-it.html#tk.revfun_feat <br>
more than $868 billion in this year 2017 alone, the impact – and risks – of IoT adoption are already becoming apparent. <br>

Feb 14, 2017: Notes at reading : <br>
public source:https://msdn.microsoft.com/en-us/library/mt634286.aspx , "Create Data Features (Data Science End-to-End Walkthrough), example caculate Distant rather than GPS(x,y)". <br>
For this modeling task, rather than using the raw latitude and longitude values of the pickup and drop-off location, you'd like to have the distance in miles between the two locations. To create this feature, you'll compute the direct linear distance between two points, by using the haversine formula. <br>

--------------
March 14, 2017 <br>
Search in google for the reference code in opensource:<br>
time series matplotlib "__main__" predict filetype:py <br>
----------------
<br><br> March 22, 2017 <br>
<br> Reading notes: time serial + hierarchical + container + index topics: <br>
https://arxiv.org/pdf/1311.6785.pdf: partition into five communities is detected at Markov time t = 97.712 corresponding to the five roles in the Twitter network. B: The in- and out-degrees of the five clusters found reflect their characterisations as: references, engaged leaders, mediators, diversified listeners, and listeners. <br>

<br><br>March 23, 2017:<br> log path for ML scan of logs: <br>
1. source:http://stackoverflow.com/questions/30969435/where-is-the-docker-daemon-log<br>
DOcker log directories, It depends on your OS. Here are the few locations, with commands for few Operating Systems:
<br><br>
Ubuntu (old using upstart ) - /var/log/upstart/docker.log <br>
Ubuntu (new using systemd ) - journalctl -u docker.service <br>
Boot2Docker - /var/log/docker.log <br>
Debian GNU/Linux - /var/log/daemon.log <br>
CentOS - /var/log/daemon.log | grep docker <br>
CoreOS - journalctl -u docker.service <br>
Fedora - journalctl -u docker.service <br>
Red Hat Enterprise Linux Server - /var/log/messages | grep docker <br>
OpenSuSE - journalctl -u docker.service <br>
OSX - ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/log/d‌​ocker.log <br>
<br>
2. source:https://docs.openstack.org/juno/config-reference/content/section_nova-logs.html <br>

The corresponding log file of each Compute service is stored in the <b> /var/log/nova/ </b> directory of the host on which each service runs. <br>
<br><br>
Table 2.11. Log files used by Compute services layout break, so better refer to original url for right one). <br>
Log file ||	Service name (CentOS/Fedora/openSUSE/Red Hat Enterprise Linux/SUSE Linux Enterprise)	|| Service name (Ubuntu/Debian) <br>

api.log||openstack-nova-api||nova-api <br>
cert.log [a]||openstack-nova-cert||nova-cert <br>
compute.log||openstack-nova-compute||nova-compute <br>
conductor.log||openstack-nova-conductor||nova-conductor <br>
consoleauth.log||openstack-nova-consoleauth||nova-consoleauth <br>
network.log[b]||openstack-nova-network||nova-network <br>
nova-manage.log||nova-manage||nova-manage <br>
scheduler.log||openstack-nova-scheduler||nova-scheduler <br>
<br>

<br>
<br><br>
============================================  <br>
Reading for answer:
source:http://www.jianshu.com/p/3f4b89aaf057, 简书：
Q. Why matplotlib with plot() is not visible?  <br>
Answer:
1. 安装Tkinter 和 matplotlib

我的问题在于我原来的python居然没有Tkinter！！
  sudo apt-get install tk-dev
  pip uninstall -y matplotlib
  pip --no-cache-dir install -U matplotlib #这是最关键的

2. 设置agg

其实经过上面的步骤，已经可以画图了
补充2种设置agg方法

临时的
import matplotlib
matplotlib.use('TkAgg')
这个命令必须在第一次使用%pylab 或者import matplotlib.pyplot as plt之前使用
常见的agg有：Qt4Agg Qt5Agg TkAgg WX WXAgg Agg Cairo GDK PS PDF SVG

永久的
修改matplotlibrc文件
matplotlibrc文件的位置在：
[~/.virtualenvs/myenv]/lib/python2.7/site-packages/matplotlib/mpl-data/
修改位置：backend      : youragg
<br><br><p>

ML reading notes: <br>
04/14/2017<br>
https://www.slideshare.net/pfi/3d-volumetric-data-generation-with-generative-adversarial-networks
AutoCad default format: dwg <br>
Posibility of GAN applying to MAP recognition and extraction.  <br>
Urban Vertical Farming: Generative System for a Vegetable Growing Infrastructure - eVolo. source: https://www.pinterest.com/pin/144396731773989357/


05/11/2017:
The flexibility of "domain or the fly, id otf", will be vip for implementation. 
Borrowing the idea from adversarial network, we can form a new world from bionicle simulation of the evolution tree.

06/26/2017: Interesting Notes:
https://hackaday.io/project/12715-tritium-nuclear-battery-betaphotovoltaic, Interesting making of nuclei battery lasting 20 years at cost of $40, produce 1.6V at ~50 nanoamps. The author writes:
"This is a simple DIY nuclear battery. It uses a small, prepurchased Tritium tube that glows for 20+ years pressed against a tiny calculator solar panel and reflector to produce 1.6V at ~50 nanoamps for around $40. It will produce relatively constant current for years, decreasing with the 12-year halflife of Tritium. It can be used to charge capacitors which can then flash an LED briefly with a voltage boosting circuit. 

Tritium is an isotope of Hydrogen containing 2 neutrons. It is unstable and decays with a halflife of 12 years, emitting a 5.7 (average) keV electron (beta particle) and a ~10 keV neutrino. The neutrino is essentially lost energy as it cannot be harvested with this device. The beta particle collides with the phosphor coating on the tube walls to produce green photons which are produced for as long as the Tritium sample is decaying. 

Looking for feedback to improve design or to build new types of nuclear battery."



