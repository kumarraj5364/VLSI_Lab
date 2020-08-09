***************sram_6t_cell*************
.lib 'home/lxle/project2020/ngspice-32/scn4m_subm.lib/nom'
.global gnd Vdd
.param Vdd=5
*inverter1
M5 Q Qbar Vdd Vdd p w='0.6u' l='0.4u'
M1 Q Qbar gnd gnd n w='3.5u' l='0.4u'

*inverter2
M6 Qbar Q Vdd Vdd p w='0.6u' l='0.4u'
M2 Qbar Q gnd gnd n w='3.5u' l='0.4u'

*access transister
M3 Q wl bl gnd n w='.91u' l='0.4u'
M4 Qbar wl blb gnd n w='.91u' l='0.4u'

*precharge transister
M6 bl b1 Vdd Vdd p w='0.6u' l='0.4u'
M7 blb b2 Vdd Vdd p w='0.6u' l='0.4u'

*capacitor
Cbl bl gnd 1270f
Cblb blb gnd 1270f
Cwl wl gnd  2550f

*source
Vdd Vdd 0 dc 5 0.1

*initial condition
.nodeset V(Q)=0
.nodeset V(Qbar)=5
.param Q=0 Qbar=5

*data control
Vb1 b1 0 PULSE(0 5 5ns 1ns 1ns 20ns 50ns)
Vb2 b2 0 PULSE(0 5 5ns 1ns 1ns 20ns 50ns)
*access control
Vwl wl 0 PULSE(0 5 10ns 2ns 2ns 20ns 50ns)
.tran 5p 40n
.control 
run
plot Q,Qbar  $ data value
plot wl      $ access data
plot bl,blb  $ bit line data
plot b1,b2   $precharge
.endc
.end

