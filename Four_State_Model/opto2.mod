: 4 state model of optogenetics

NEURON {
	SUFFIX opto2
	: USEION na WRITE ina
	RANGE gchr2,ilit, irr, flux
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
	sigma = 1e-16 (cm2) :area of one chr2 molecule
	epsilon1  = 0.5    
	epsilon2  = 0.12   
	kd1   = 0.1    (/ms)
	kd2   = 0.05   (/ms)
	U0    = 43     (mV)
	U1    = -4.1     (mV)
	go1   = 1     (S/cm2) :WRONG
	go2   = 0.025      (S/cm2) :WRONG
	kr =.002(/ms)
	N =10
	e = 0 (mV)
	phot_e = 4.22648e-19 (J)
}

ASSIGNED {
	gchr2
	irr (mW/mm2)
	v  (mV)
	:e(mV)
	:ina  (mA/cm2)
	ilit (mA/cm2)
	ka1 (/ms)
	ka2 (/ms)
	e12 (/ms)
	e21  (/ms)
	flux (/s/cm2)
	: flux0 (/s/cm2)
}

STATE {
	No1
	No2
	Nc1
	Nc2
}

INITIAL{
	rates(v)
	No1=0
	No2=0
	Nc1=N
	Nc2=0	
}

BREAKPOINT{
	SOLVE states METHOD sparse
	UNITSOFF
	gchr2=(No1/N + (go2/go1)*No2/N)*(1-exp(v/U0))/U1
	UNITSON
	ilit  = gchr2_max*gchr2*(v-e)
	
}

KINETIC states{
rates(v)
~Nc1<->No1 (ka1,kd1)
~No1<->No2 (e12,e21)
~No2<->Nc2 (kd2,ka2)
~Nc2 <->Nc1 (kr,0)
CONSERVE Nc1+Nc2+No1+No2=N
}

UNITSOFF

PROCEDURE rates(v(mV)) {  :Computes rate and other constants at current v.
                      :Call once from HOC to initialize inf at resting v.
		flux=irr/phot_e*(1e-4)*sigma : /ms
		: flux0=1.0e-20/phot_e*(1e-1)
		if (flux > 0.024) {
		e12=.011+0.005*log(flux/0.024)
		e21=0.008+0.004*log(flux/0.024)
		} else {
		e12 = .011
		e21 = 0.008
		}
		ka1=epsilon1*flux
		ka2=epsilon2*flux
		}
		
FUNCTION vtrap(x,y) {  :Traps for 0 in denominator of rate eqns.
        if (fabs(x/y) < 1e-6) {
                vtrap = y*(1 - x/y/2)
        }else{
                vtrap = x/(exp(x/y) - 1)
        }
}
UNITSON
