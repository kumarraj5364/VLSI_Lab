*subcircuit for 6t_sram cell
.subckt 6t_cell bl blb wl Vdd gnd
*inverter1
M5 q qbar Vdd Vdd p w='0.6u' l='0.4u'
M1 q qbar gnd gnd n w='1.8u' l='0.4u'

*inverter2
M6 qbar q Vdd Vdd p w='0.6u' l='0.4u'
M2 qbar q gnd gnd n w='1.8u' l='0.4u'

*access transister
M3 q wl bl gnd n w='.9u' l='0.4u'
M4 qbar wl blb gnd n w='.9u' l='0.4u'
.ends 6t_cell

