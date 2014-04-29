��    T      �      \      \  �  ]  |     �   �  �   t  ;   0	  �  l	  H   �
  �   :  �  �  
   �  �  �     {  �   �  "   C     f  �   |  e   I     �  �   �  +  i  �   �  �   6     �     �  �   �     r  �   u  -   ,  \  Z     �     �  
   �     �       .      �   O  �  �     �     �     �  O   �     C     V  �   Y     �  B     2   V     �     �     �     �  3  �  �      �   �   =   l!  ,   �!  ,  �!  I   #  4   N#  �   �#  �   M$  �   %  Y   �%  Y   &  N   j&  �   �&  �   y'  G   (  +   W(     �(     �(     �(     �(  �  �(     �*  �   �*     s+  $   �+     �+     �+     �+     ,      ,  �  9,  C  .  K   R/  �   �/  �   ~0  B   Q1  G  �1  B   �2  �   3  �  �3  
   L5  �  W5     �6  �   7     �7     �7  �   �7  X   �8     9  �    9  �   �9  �   �:  �   I;     <     <  �   !<  	   �<  �   �<  -   �=  V  �=     ?  !   !?     C?     P?     o?  0   �?  �   �?  �  �@     nD     �D     �D  <   �D     �D     �D  �   �D     �E  '   �E  0   F     AF     WF     jF     wF  B  �F  �   �G  �   YH  *   I  *   2I  �   ]I  Q   .J  $   �J  �   �J  �   �K  �   uL  @   M  =   QM  p   �M  �    N  �   �N  2   mO  !   �O     �O     �O     �O     �O  P  �O     MQ  �   SQ     2R     BR  #   XR     |R     �R     �R     �R   (XenServer) Configure the XenServer dom0 settings to allocate more memory to dom0. This can enable XenServer to handle larger numbers of virtual machines. We recommend 2940 MB of RAM for XenServer dom0. For instructions on how to do this, see `http://support.citrix.com/article/CTX126531 <http://support.citrix.com/article/CTX126531>`_. The article refers to XenServer 5.6, but the same information applies to XenServer 6.0. 10G networks are generally recommended for storage access when larger servers that can support relatively more VMs are used. A firewall provides a connection to the Internet. The firewall is configured in NAT mode. The firewall forwards HTTP requests and API calls from the Internet to the Management Server. The Management Server resides on the management network. A layer-2 access switch layer is established for each pod. Multiple switches can be stacked to increase port count. In either case, redundant pairs of layer-2 switches should be deployed. A layer-2 switch connects all physical servers and storage. A layer-3 switching layer is at the core of the data center. A router redundancy protocol like VRRP should be deployed. Typically high-end core switches also include firewall modules. Separate firewall appliances may also be used if the layer-3 switch does not have integrated firewall capabilities. The firewalls are configured in NAT mode. The firewalls provide the following functions: A single NFS server functions as both the primary and secondary storage. A staging system that models the production environment is strongly advised. It is critical if customizations have been applied to CloudStack. Allow adequate time for installation, a beta, and learning the system. Installs with basic networking can be done in hours. Installs with advanced networking usually take several days for the first attempt, with complicated installations taking longer. For a full production system, allow at least 4-8 weeks for a beta to work through all of the integration issues. You can get help from fellow users on the cloudstack-users mailing list. Bare Metal Be sure all the hotfixes provided by the hypervisor vendor are applied. Track the release of hypervisor patches through your hypervisor vendor’s support channel, and apply patches as soon as possible after they are released. CloudStack will not track or notify you of required hypervisor patches. It is essential that your hosts are completely up to date with the provided hypervisor patches. The hypervisor vendor is likely to refuse to support any system that is not up to date with patches. Best Practices Bonded NIC and redundant switches can be deployed for NFS. In NFS deployments, redundant switches and bonded NICs still result in one network (one CIDR block+ default gateway address). Choosing a Deployment Architecture Choosing a Hypervisor CloudStack supports many popular hypervisors. Your cloud can consist entirely of hosts running a single hypervisor, or you can use multiple hypervisors. Each cluster of hosts must run the same hypervisor. Conserve management traffic IP address by using link local network to communicate with virtual router DRS Data Center 1 houses the primary Management Server as well as zone 1. The MySQL database is replicated in real time to the secondary Management Server installation in Data Center 2. Deploying a cloud is challenging. There are many different technology choices to make, and CloudStack is flexible enough in its configuration that there are many possible ways to combine and configure the chosen technology. This section contains suggestions and requirements about cloud deployments. Each host should be configured to accept connections only from well-known entities such as the CloudStack Management Server or your network monitoring software. Each pod contains storage and computing servers. Each storage and computing server should have redundant NICs connected to separate layer-2 access switches. Feature FibreChannel Forwards HTTP requests and API calls from the Internet to the Management Server. The Management Server resides on the management network. HA Host capacity should generally be modeled in terms of RAM for the guests. Storage and CPU may be overprovisioned. RAM may not. RAM is usually the limiting factor in capacity designs. How many Management Servers will be deployed. In the large-scale redundant setup described in the previous section, storage traffic can overload the management network. A separate storage network is optional for deployments. Storage protocols such as iSCSI are sensitive to network delays. A separate storage network ensures guest network traffic contention does not impact storage performance. KVM - RHEL 6.2 Large-Scale Redundant Setup Local Disk Local disk as data disk Maintenance Best Practices Manual live migration of VMs from host to host Monitor host disk space. Many host failures occur because the host's root disk fills up from logs that were not rotated adequately. Monitor the total number of VM instances in each cluster, and disable allocation to the cluster if the total is approaching the maximum that the hypervisor can handle. Be sure to leave a safety margin to allow for the possibility of one or more hosts failing, which would increase the VM load on the other hosts as the VMs are redeployed. Consult the documentation for your chosen hypervisor to find the maximum permitted number of VMs per host, then use CloudStack global configuration settings to set this as the default limit. Monitor the VM activity in each cluster and keep the total number of VMs below a safe level that allows for the occasional host failure. For example, if there are N hosts in the cluster, and you want to allow for one host in the cluster to be down at any given time, the total number of VM instances you can permit in the cluster is at most (N-1) \* (per-host-limit). Once a cluster reaches this number of VMs, use the CloudStack UI to disable allocation to the cluster. Multi-Node Management Server Multi-Site Deployment N/A NIC bonding is straightforward to implement and provides increased reliability. Network Throttling No Primary storage mountpoints or LUNs should not exceed 6 TB in size. It is better to have multiple smaller primary storage elements per cluster than one large one. Process Best Practices Secondary storage servers are connected to the management network. Security groups in zones that use basic networking Separate Storage Network Setup Best Practices Small-Scale Deployment Snapshots of local disk The CloudStack Management Server is deployed on one or more front-end servers connected to a single MySQL database. Optionally a pair of hardware load balancers distributes requests from the web. A backup management server set may be deployed using MySQL replication at a remote site to add DR capabilities. The CloudStack platform scales well into multiple sites through the use of zones. The following diagram shows an example of a multi-site deployment. The Management Server cluster (including front-end load balancers, Management Server nodes, and the MySQL database) is connected to the management network through a pair of load balancers. The Management Server is connected to the management network. The administrator must decide the following. The architecture used in a deployment will vary depending on the size and purpose of the deployment. This section contains examples of deployment architecture, including a small-scale deployment useful for test and trial deployments and a fully-redundant large-scale setup for production deployments. The lack of up-do-date hotfixes can lead to data corruption and lost VMs. There are two ways to configure the storage network: These should be treated as suggestions and not absolutes. However, we do encourage anyone planning to build a cloud outside of these guidelines to seek guidance and advice on the project mailing lists. This diagram illustrates a setup with a separate storage network. Each server has four NICs, two connected to pod-level network switches and two connected to storage network switches. This diagram illustrates the differences between NIC bonding and Multipath I/O (MPIO). NIC bonding configuration involves only one network. MPIO involves two separate networks. This diagram illustrates the network architecture of a large-scale CloudStack deployment. This diagram illustrates the network architecture of a small-scale CloudStack deployment. Use multiple clusters per pod if you need to achieve a certain switch density. When exporting shares on primary storage, avoid data loss by restricting the range of IP addresses that can access the storage. See "Linux NFS on Local Disks and DAS" or "Linux NFS on iSCSI". When the cloud spans multiple zones, the firewalls should enable site-to-site VPN such that servers in different zones can directly reach each other. Whether MySQL replication will be deployed to enable disaster recovery. Whether or not load balancers will be used. Work load balancing XenServer 6.0.2 Yes Yes (Native) You might already have an installed base of nodes running a particular hypervisor, in which case, your choice of hypervisor has already been made. If you are starting from scratch, you need to decide what hypervisor software best suits your needs. A discussion of the relative advantages of each hypervisor is outside the scope of our documentation. However, it will help you to know which features of each hypervisor are supported by CloudStack. The following table provides this information. iSCSI iSCSI can take advantage of two separate storage networks (two CIDR blocks each with its own default gateway). Multipath iSCSI client can failover and load balance between separate storage networks. vSphere 4.1/5.0 |Example Of A Multi-Site Deployment| |Large-Scale Redundant Setup| |Multi-Node Management Server| |NIC Bonding And Multipath I/O| |Separate Storage Network| |Small-Scale Deployment| Project-Id-Version: Apache CloudStack Installation RTD
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2014-03-31 14:02-0400
PO-Revision-Date: 2014-04-28 06:44+0000
Last-Translator: parkermeng <jamemeng@126.com>
Language-Team: Chinese (China) (http://www.transifex.com/projects/p/apache-cloudstack-installation-rtd/language/zh_CN/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: zh_CN
Plural-Forms: nplurals=1; plural=0;
 (XenServer)可以设置它的dom0值来让其支持更多的虚拟机。我们推荐为dom0设置的内存数值为2940 MB。至于如何操作，可以参见如下URL：`http://support.citrix.com/article/CTX126531 <http://support.citrix.com/article/CTX126531>`_。这篇文章可同时适用于XenServer 5.6和6.0版本。 当需要支持运行较多的虚拟机运行时，推荐使用10G网络。 防火墙提供了到Internet互联网的连接.此防火墙被配置成NAT模式，它会将来自Internet的HTTP访问和API请求转发到管理节点服务器。而管理节点服务器的网络属于管理网络(MGMT). 每个机柜提供点（POD）都需要有一个二层接入交换机，也可以用多个交换机堆叠来增加提供点端口数量。在某些高可用情况下，还需要部署双冗余热备交换机。 一个二层交换机连接所有的物理服务器和存储机器 第三层交换（基于IP）处理于数据机房的核心位置，应该用如VRRP类似的冗余路由协议实现设备热备份。通常，我们也会在核心三层交换机上集成防火墙模块。如果没有此集成模块，独立防火墙亦可。防火墙一般会配置成NAT模式，它能提供如下功能： 单一的NFS服务器需要能同时提供主存储和二级存储 如果在CLOUDSTACK生产环境中使用了一些自定义的配置，那么，我们强烈建议进行每一个步骤的模型模拟测试。 我们需要为安装，学习和测试CLOUSSTACK预留合理的时间。一般来讲，简单网络模式的安装可以在几个小时内完成，但网络高级模式的首次安装通常需要花费几天的时间，按需安全则需要更长的时间。正式生产环境的部署，通常需要4-8周的测试周期以排除潜在问题，你也可从cloudstack-users的邮件列表里得到更多帮助。 Bare Metal 你必须保证随时应用了hypervisor开发商最新的系统补丁。你应该随时追踪hypervisor开发商的补丁发布情况，并且在有最新补丁发布之后，第一时间进行更新。CLOUDSTACK并不会提醒你hypervisor开发商的系统补丁更新情况。保持hypervisor的补丁更新是很重要的。hypervisor开发商也会趋向于拒绝为没有更新补丁的用户提供支持。 最佳实践 为NFS配置网卡绑定和冗余交换机。在这种基于NFS文件部署下，交换机和网卡都位于同一网络。（同一个CIDR块，同样的网关设置） 选择部署架构 选择一个Hypervisor CloudStack支持多许流行的Hypervisor，你可以在所有的宿主机上用同一种，也可以用不同的Hypervisor，但，在同一个CLOUDSTACK群集（Cluster）内，只可以用同一种Hypervisor。 使用本地链路与虚拟路由器（VR）直接通讯来保护管理网络的IP流量 DRS-分布式资源调度 在数据中心一内运行着第一个管理节点，存在一个区域。它的后端MYSQL数据库实时复制到数据中心二内的第二个管理节点。 部署云计算服务是一项挑战。目前在这个领域有很多不同的技术可供选择，CLOUDSTACK以其配置灵活性可以将不同的技术揉合在一起。这个章节包含一些在云计算部署中的建议以及相关依赖需求。 每一个主机都应该配置为只接受来自熟悉的安全连接---如CLOUDSTACK管理服务节点或相关的网络监控软件。 每一个机柜提供点（POD）包括存储节点服务器和计算节点服务器每一个存储和计算节点服务器都需要有冗余网卡连接到二层接入交换机的不同端口。 特性 光纤通道 将来自Internet的HTTP访问和API请求转发到管理节点服务器。而管理节点服务器的网络属于管理网络(MGMT). 高可用 宿主机的内存大小将限制客户虚拟机的数量。因为宿主机的存储和CPU均可过载让客户虚拟机使用，但是内存却不可以。故内存是在系统容量设计时要考虑的限制因素。 需要部署多少年管理节点服务器？ 在前一章节的大规模冗余部署情景中提及，存储网络的数据流量可以和管理网络合并使用。但是，最好将存储网络独立出来，因为存储网络使用的协议（如iSCSI）对网络延迟非常敏感,而一个独立的存储网络能够使其不受客户来宾网络(Guest Network)流量波动影响。 KVM - RHEL 6.2 带冗余的大规模安装部署 本地磁盘 用本地盘作为数据磁盘 维护最佳实践 手工在主机之间进行虚拟机的热迁移 监视宿主机的磁盘空闲空间。如果宿主机的相关日志记录没有设置轮循，那么日志记录文件会将宿主机的硬盘空间占用殆尽，从而导致很多宿主机问题的发生。 要随时监控每个集群里的虚拟机数量，如果总量快达到hypervisor允许的最大虚拟机数量时，不能再向此群集增虚机。并且，要注意预留一定的宿主机计算能力，以防止群集中有宿主机发生故障,因为发生故障的主机上的虚拟机需要重新部署在这些预留宿主机上。你需要向你的 hypervisor咨询，得到此 hypervisor能支持的最大虚拟机数量，并将此数值设置在CLOUDSTACK的全局设置里。监控每个群集里的虚拟机的活跃程序，并将活跃虚拟机保持在一个性能安全线内。这样，CLOUDSTACK就能允许偶尔的宿主机故障。举个示例：如果集群里有N个宿主机，而你只能让其中任一宿主机的停机时间不超过特定时间。那么，你能在此集群部署的最多虚拟主机数量值为：(N-1) \* (每宿主机最大虚拟量数量限值)。一旦达到此数量，必须在CLOUDSTACK的WEB UI里禁止向此群集增加新的虚拟机。 多节点管理服务器 多站点部署 无-N/A 网卡绑定技术可以明显的增加系统的可靠性。 Network Throttling 否 主存储的挂载文件或是共享存储的LUN不能超过6TB。如果有超大空间用于主存储，我们更建议将其划分为多个小的主存储挂载来供集群使用，而不是就只用一个超大主存储。 实施最佳实践 二级存储服务器接入管理网络 在区域内用于基本网络模式的安全组 独立的存储网络 最佳实践安装 小型部署 本地磁盘快照 CloudStack管理节点服务器可以部署多个前端节点同时只连接一个后端数据库。当然数据库方面也可以用负载均衡技术来分流来自WEB的连接请求。这样一来，备份的管理节点群就可以直接使用MYSQL的远端复制数据库来获得直接路由(Direct Routing)性能。 运用CloudStack的区域技术可以很容易的将其扩散为多站点模式。下面这个图就显示了一个多站点部署的示例 管理服务器节点集群通过两个负载均衡节点接入管理网络。（管理服务器集群包括前端负载均衡节点，管理节点及MYSQL数据库节点） 管理节点服务器连接至管理网络 系统管理人员必须作如下决定： 部署CLOUDSTACK的具体架构会因为规模及用途的不同而变化。这一章节会包含一些典型的布置构架：用于测试的小型构架，以及用于生产环境的全冗余大型构架。 不及时更新相关系统补丁可能会导致虚拟机数据损失或消失。 有两种方式配置存储网络： 这些内容应该被视为建议，而不是绝对要遵从的限制。然而，我们鼓励想要部署云计算的朋友们，除了这些建议内容之外，最好从CLOUDSTACK的项目邮件列表(MAIL LIST)中获取更多建议指南性内容。 这个图演示了一个独立的存储网络的结构。每一个物理服务器有四块网卡，其中两块连接到提供点层的交换机，而另外两块网卡连接到用于存储网络的交换机。 此图演示了网络绑定与多路径IO（MPIO）之间的区别，网卡绑定的配置仅涉及一个网段，而MPIO却包含两个独立的网段。 这个图演示了大规模部署的网络结构CloudStack部署 这个图演示了小型部署的网络结构CloudStack部署 如果需要增加交换机的利用率，你可以在同一个机柜提供点里部署多个cloudstack集群。 在主存储上导出共享数据时，为避免数据丢失，应该严格限制能访问此存储的IP地址范围。更多详情，可参考"Linux NFS on Local Disks and DAS" "Linux NFS on iSCSI"这些章节。  当CLOUDSTACK部署多个区域（Zone）时，防火墙之间应该设置L2L VPN（site-to-site VPN）,以便让各个管理节点之间直连互通 如何部署MYSQL复制以便启用灾备技术？ 是否需要部署负载均衡？ 工作于负载均衡 XenServer 6.0.2 是 是（原生） 如果你已运行了CLOUDSTACK，那么，你应该已选择好了一种Hypervisor。如果还处于草创规划阶段，那么你就需要选择一种来切合你的需求。各种Hypervisor的利弊讨论已不在本文档之列，但我们会提供每种的特性，希望能够帮到你。下面的表格就提供了这些信息： iSCSI iSCSI能同时利用两个独立的存储网络（两个不同的CIDR块，每个CIDR都有自己的默认网关）。支持多路径iSCSI的客户端能在两个独立的存储网络中实现热备切换和负载均衡。 vSphere 4.1/5.0 多站点部署示例 |带冗余的大规模安装部署| |多节点管理服务器| 网卡绑定与多路径IO |独立的存储网络| |小型部署| 