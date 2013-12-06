: 6 state model of optogenetics

NEURON {
	POINT_PROCESS ChR2test2
	RANGE gchr2,gchr2_max,irr,flux
	RANGE ilit,reps,delay,on_dur,off_dur,irrMag
	ELECTRODE_CURRENT ilit
}

UNITS {
	(S)  = (siemens)
	(mV) = (millivolt)
	(mA) = (milliamp)
	(J) = (joules)
	(mW) = (milliwatt)
	(um) = (micrometer)
}

PARAMETER {
	gchr2_max = 36e-4  (S/cm2)
	U0    = 43     	(mV)
	U1    = -4.1
	gamma = 0.05
	e = 0 (mV)
	a10 = 5 (/ms)
	a2 = 1 (/ms)
	a30 = 0.022 (/ms)
	a31 = 0.0135 (/ms)
	a4 = 0.025 (/ms)
	a6 = 0.00033 (/ms)
	b1 = 0.13 (/ms)
	b20 = 0.011 (/ms)
	b21 = 0.0048 (/ms)
	b3 = 1 (/ms)
	b40 = 1.1 (/ms)
	phi_0 = 1e16 (/s/cm2)
	phot_e = 4.22648e-19 (J)
	: Light Stim Params
	delay = 100 (ms)
	on_dur = 100 (ms)
	off_dur = 100 (ms)
	reps = 1
	irrMag = 40 (mW/mm2)
}

ASSIGNED {
	v (mV)
	irr (mW/mm2)
	reps_left
	ilit (mA/cm2)
	gchr2 (S/cm2)
	flux (/s/cm2)
	a1 (/ms)
	a3 (/ms)
	b2 (/ms)
	b4 (/ms)
}

STATE {
	s1
	s2
	s3
	s4
	s5
	s6
}


INITIAL{
	irr = 0
	s1=1
	s2=0
	s3=0
	s4=0
	s5=0
	s6=0
	net_send(delay,1)
	reps_left = reps
	rates()
}

BREAKPOINT{
	SOLVE states METHOD sparse
	gchr2=gchr2_max*fdep()*vdep(v)
	ilit = gchr2*(v-e)
}

KINETIC states{
rates()
~ s1 <-> s2 (a1,0)
~ s1 <-> s3 (0,b1)
~ s2 <-> s3 (a2,0)
~ s3 <-> s4 (a3,b2)
~ s4 <-> s5 (0,b3)
~ s4 <-> s6 (a4,0)
~ s5 <-> s6 (0,b4)
~ s6 <-> s1 (a6,0)
CONSERVE s1+s2+s3+s4+s5+s6 = 1
}

NET_RECEIVE (w){
	if(flag == 1){ : turn on
	irr = irrMag
	reps_left = reps_left - 1
	net_send(on_dur,2)
	}
	
	if(flag == 2){ : turn off
	irr = 0
	if(reps_left > 0){
	net_send(off_dur,1)
	}
	
	}
}
PROCEDURE rates() {
flux=irr/phot_e*(1e-1) : 6.62606e-34*299792458/(470e-9) i.e. hc/lambda = energy of one photon

a1 = a10*(flux/phi_0)
b4 = b40*(flux/phi_0)

if (flux < phi_0){
a3 = a30
b2 = b20
}
else
{
a3 = a30+a31*log(flux/phi_0)
b2 = b20+b21*log(flux/phi_0)
}
}

FUNCTION vdep(v (mV)) (){
: vdep = (1-exp(v/U0))/(U1)
: vdep = 1
vdep = (10.6408-14.6408*exp(-v/42.7671))/v
}

FUNCTION fdep() (){
fdep = s3+gamma*s4
}