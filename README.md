# SNMP Simulator

This docker image starts up snmpsim.

The UDP port `161` should be mapped to the desired SNMP port.

By default this image contains an snmpwalk from `demo.snmplabs.com` under community name `demo`.

To use your own snmpwalks you should mount a folder with snmpwalks like this:
```bash
    docker run -v /somewhere/with/snmpwalks:/usr/local/snmpsim/data \
               -p 1611:161/udp \
               ghcr.io/robert0714/docker-snmpsim
```
The filename determines the SNMP community name.

If you want to run snmpsimd with more flags then you can use `EXTRA_FLAGS`, like this:
```bash
    docker run -v /somewhere/with/snmpwalks:/usr/local/snmpsim/data \
               -p 1611:161/udp \
               -e EXTRA_FLAGS="--v3-user=testing --v3-auth-key=testing123"
               ghcr.io/robert0714/docker-snmpsim
```
## Note
You might want to use some existing data files to get started quickly. Then, you can install snmpsim-data package as well. You can learn more about it in the [SNMP Simulator Data](https://www.pysnmp.com/snmpsim-data/).

## Test the Setup
* References: https://docs.lextudio.com/snmpsim/quick-start#test-the-setup
* Depending on how many data files are loaded, the Simulator initializes a number of agents. You can then try them out with Net-SNMP’s command-line tools which are usually shipped along with your operating system:
  ```bash
  $ snmpwalk -v2c -c apc-8932 127.0.0.1:1611 system
    SNMPv2-MIB::sysDescr.0 = STRING: APC Web/SNMP Management Card (MB:v4.1.0 PF:v6.7.2 PN:apc_hw05_aos_672.bin AF1:v6.7.2 AN1:apc_hw05_rpdu2g_672.bin MN:AP8932 HR:02 SN: 3F503A169043 MD:01/23/2019)
    SNMPv2-MIB::sysObjectID.0 = OID: SNMPv2-SMI::enterprises.318.1.3.4.6
    DISMAN-EVENT-MIB::sysUpTimeInstance = Timeticks: (165328680) 19 days, 3:14:46.80
    SNMPv2-MIB::sysContact.0 = STRING: Unknown
    SNMPv2-MIB::sysName.0 = STRING: pwr-dc01-pdu-rack3-01
    SNMPv2-MIB::sysLocation.0 = STRING: Unknown
    SNMPv2-MIB::sysServices.0 = INTEGER: 72
    SNMPv2-MIB::sysORLastChange.0 = Timeticks: (0) 0:00:00.00
    SNMPv2-MIB::sysORID.1 = OID: SNMPv2-MIB::snmpMIB
    SNMPv2-MIB::sysORID.2 = OID: SNMP-FRAMEWORK-MIB::snmpFrameworkMIBCompliance
    SNMPv2-MIB::sysORID.3 = OID: SNMP-MPD-MIB::snmpMPDCompliance
    SNMPv2-MIB::sysORID.4 = OID: SNMP-USER-BASED-SM-MIB::usmMIBCompliance
    SNMPv2-MIB::sysORID.5 = OID: SNMP-VIEW-BASED-ACM-MIB::vacmMIBCompliance
    SNMPv2-MIB::sysORDescr.1 = STRING: The MIB Module from SNMPv2 entities
    SNMPv2-MIB::sysORDescr.2 = STRING: SNMP Management Architecture MIB
    SNMPv2-MIB::sysORDescr.3 = STRING: Message Processing and Dispatching MIB
    SNMPv2-MIB::sysORDescr.4 = STRING: USM User MIB
    SNMPv2-MIB::sysORDescr.5 = STRING: VACM MIB
    SNMPv2-MIB::sysORUpTime.1 = Timeticks: (0) 0:00:00.00
    SNMPv2-MIB::sysORUpTime.2 = Timeticks: (0) 0:00:00.00
    SNMPv2-MIB::sysORUpTime.3 = Timeticks: (0) 0:00:00.00
    SNMPv2-MIB::sysORUpTime.4 = Timeticks: (0) 0:00:00.00
    SNMPv2-MIB::sysORUpTime.5 = Timeticks: (0) 0:00:00.00
  ```
* Simulation data are simple plain-text file, with `.snmprec` (or other) file extensions. Each line in represents a single SNMP object in form of pipe-separated fields `OID|TYPE|VALUE`.
  ```bash
  $ cat ./data/UPS/apc-8932.snmprec
    1.3.6.1.2.1.1.1.0|4x|415043205765622f534e4d50204d616e6167656d656e74204361726420284d423a76342e312e302050463a76362e372e3220504e3a6170635f687730355f616f735f3637322e62696e204146313a76362e372e3220414e313a6170635f687730355f7270647532675f3637322e62696e204d4e3a4150383933322048523a303220534e3a20334635303341313639303433204d443a30312f32332f3230313929
    1.3.6.1.2.1.1.2.0|6|1.3.6.1.4.1.318.1.3.4.6
    1.3.6.1.2.1.1.3.0|67|165328680
    1.3.6.1.2.1.1.4.0|4|Unknown
    1.3.6.1.2.1.1.5.0|4x|7077722d646330312d7064752d7261636b332d3031
    1.3.6.1.2.1.1.6.0|4|Unknown
    1.3.6.1.2.1.1.7.0|2|72
    1.3.6.1.2.1.1.8.0|67|0
    1.3.6.1.2.1.1.9.1.2.1|6|1.3.6.1.6.3.1
    1.3.6.1.2.1.1.9.1.2.2|6|1.3.6.1.6.3.10.3.1.1
    1.3.6.1.2.1.1.9.1.2.3|6|1.3.6.1.6.3.11.3.1.1
    1.3.6.1.2.1.1.9.1.2.4|6|1.3.6.1.6.3.15.2.1.1
    1.3.6.1.2.1.1.9.1.2.5|6|1.3.6.1.6.3.16.2.1.1
    1.3.6.1.2.1.1.9.1.3.1|4x|546865204d4942204d6f64756c652066726f6d20534e4d50763220656e746974696573
    1.3.6.1.2.1.1.9.1.3.2|4x|534e4d50204d616e6167656d656e7420417263686974656374757265204d4942
    1.3.6.1.2.1.1.9.1.3.3|4x|4d6573736167652050726f63657373696e6720616e64204469737061746368696e67204d4942
    1.3.6.1.2.1.1.9.1.3.4|4x|55534d2055736572204d4942
    1.3.6.1.2.1.1.9.1.3.5|4x|5641434d204d4942
    1.3.6.1.2.1.1.9.1.4.1|67|0
    1.3.6.1.2.1.1.9.1.4.2|67|0
    1.3.6.1.2.1.1.9.1.4.3|67|0
    1.3.6.1.2.1.1.9.1.4.4|67|0
    1.3.6.1.2.1.1.9.1.4.5|67|0
    ...
  ```
  The Simulator analyzes the parameters (such as SNMP community name or SNMPv3 context name and/or IP address) of SNMP query to determine which agent (whose data from a specific .snmprec file) to respond with.
## Simulate Existing SNMP Agent
* References: https://docs.lextudio.com/snmpsim/quick-start#simulate-existing-snmp-agent
## Simulate from MIB
* References: https://docs.lextudio.com/snmpsim/quick-start#simulate-from-mib
