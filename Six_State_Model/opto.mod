: 4 state model of optogenetics

NEURON {
	SUFFIX opto
	: USEION na WRITE ina
	RANGE gchr2,gchr2_max,irr,flux,ilit
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
	gchr2_max = 0.036  (S/cm2)
	sigma = 1e-8	(um2)
	U0    = 43     	(mV)
	U1    = -4.1    
	gamma = 0.05
	N = 50
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
	phi_0 = 1e8 (/s)
	phot_e = 4.22648e-19 (J)
}

ASSIGNED {
	irr (mW/mm2)
	v  (mV)
	: ina  (mA/cm2)
	ilit (mA/cm2)
	gchr2 (S/cm2)
	flux (/ms)
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
	rates()
	s1=N
	s2=0
	s3=0
	s4=0
	s5=0
	s6=0
}

BREAKPOINT{
	SOLVE states METHOD sparse
	gchr2=gchr2_max*fdep()*vdep(v)
	: ina  = gchr2*(v+e)
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
CONSERVE s1+s2+s3+s4+s5+s6 = N
}

PROCEDURE rates() {
flux=irr*sigma/phot_e*(1e-12) : 6.62606e-34*299792458/(470e-9) i.e. hc/lambda = energy of one photon

if ((1e3)*flux < phi_0){
a1 = a10*((1e3)*flux/phi_0)
a3 = a30
b2 = b20
b4 = b40*((1e3)*flux/phi_0)
}
else
{
a1 = a10*((1e3)*flux/phi_0)
a3 = a30+a31*log((1e3)*flux/phi_0)
b2 = b20+b21*log((1e3)*flux/phi_0)
b4 = b40*((1e3)*flux/phi_0)
}
: a1 = a10+a10*((1e3)*flux/phi_0-1)*((1e3)*flux>phi_0)
: a3 = a30+a31*log((1e3)*flux/phi_0)*((1e3)*flux>phi_0)
: b2 = b20+b21*log((1e3)*flux/phi_0)*((1e3)*flux>phi_0)
: b4 = b40+b40*((1e3)*flux/phi_0-1)*((1e3)*flux>phi_0)
}

FUNCTION vdep(v (mV)) (){
vdep = (1-exp(v/U0))/(U1)
}

FUNCTION fdep() (){
fdep = s3+gamma*s4
}