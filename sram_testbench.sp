ram_6t_cell
*include library file
.lib /home/lxle/project2020/eda/ngspice-32/scn4m_subm.lib nom 
*include subcircuit
Xi bl blb wl Vdd gnd 6t_cell
.include 6t_cell.sp
*precharge transister
M7 bl pc Vdd Vdd p w='2.0u' l='0.4u'
M8 blb pc Vdd Vdd p w='2.0u' l='0.4u'
M9 bl pc blb Vdd p w='2.0u' l='0.4u'
*bit line load
M10 bl gnd Vdd gnd n w='0.6u' l='0.4u' m='127'
M11 Vdd gnd blb gnd n w='0.6u' l='0.4u' m='127'
*word line load
M12 Vdd wl Vdd gnd n w='0.6u' l='0.4u' m='255'
M13 Vdd wl gnd gnd n w='0.6u' l='0.4u' m='255'
*write operation
M14 bl w0 gnd gnd n w='0.2u' l='0.4u' 
M15 blb w1 gnd gnd n w='0.2u' l='0.4u'
*capacitor
Cbl bl gnd 1270f
Cblb blb gnd 1270f
Cwl wl gnd  2550f

*dc source
Vdd Vdd 0 5
*parameter
.global Vdd gnd
*initial condition
.nodeset v(Xi.q)=0
.nodeset v(Xi.qbar)=5

*data control (BIT)
Vpc pc 0 pulse(0 5 5n 1n 1n 30n 50n)
*access control
Vwl wl 0 pulse(0 5 10n 2n 2n 20n 50n)
*write pulse
Vwrite0 w0 0 pulse(0 5 180n 1n 1n 30n 160n)
Vwrite1 w1 0 pulse(0 5 100n 1n 1n 30n 160n)
*transient analysis
.tran 5p 400n
.control
run
plot  Xi.q Xi.qbar      $ data value
plot  v(wl)  v(pc)+6    $ word line and precharge
plot  v(bl) v(blb)      $ bit line data
.endc
.end

