/* Created by Language version: 6.2.0 */
/* VECTORIZED */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "scoplib.h"
#undef PI
 
#include "md1redef.h"
#include "section.h"
#include "md2redef.h"

#if METHOD3
extern int _method3;
#endif

#undef exp
#define exp hoc_Exp
extern double hoc_Exp();
 
#define _threadargscomma_ _p, _ppvar, _thread, _nt,
#define _threadargs_ _p, _ppvar, _thread, _nt
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 /* Thread safe. No static _p or _ppvar. */
 
#define t _nt->_t
#define dt _nt->_dt
#define gchr2_max _p[0]
#define irr _p[1]
#define ilit _p[2]
#define gchr2 _p[3]
#define flux _p[4]
#define s1 _p[5]
#define s2 _p[6]
#define s3 _p[7]
#define s4 _p[8]
#define s5 _p[9]
#define s6 _p[10]
#define a1 _p[11]
#define a3 _p[12]
#define b2 _p[13]
#define b4 _p[14]
#define Ds1 _p[15]
#define Ds2 _p[16]
#define Ds3 _p[17]
#define Ds4 _p[18]
#define Ds5 _p[19]
#define Ds6 _p[20]
#define v _p[21]
#define _g _p[22]
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 static int hoc_nrnpointerindex =  -1;
 static Datum* _extcall_thread;
 static Prop* _extcall_prop;
 /* external NEURON variables */
 /* declaration of user functions */
 static int _hoc_fdep();
 static int _hoc_rates();
 static int _hoc_vdep();
 static int _mechtype;
extern int nrn_get_mechtype();
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _extcall_prop = _prop;
 }
 static _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range();
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 ret(1.);
}
 /* connect user functions to hoc names */
 static IntFunc hoc_intfunc[] = {
 "setdata_opto", _hoc_setdata,
 "fdep_opto", _hoc_fdep,
 "rates_opto", _hoc_rates,
 "vdep_opto", _hoc_vdep,
 0, 0
};
#define fdep fdep_opto
#define vdep vdep_opto
 extern double fdep();
 extern double vdep();
 /* declare global and static user variables */
#define N N_opto
 double N = 50;
#define U1 U1_opto
 double U1 = -4.1;
#define U0 U0_opto
 double U0 = 43;
#define a6 a6_opto
 double a6 = 0.00033;
#define a4 a4_opto
 double a4 = 0.025;
#define a31 a31_opto
 double a31 = 0.0135;
#define a30 a30_opto
 double a30 = 0.022;
#define a2 a2_opto
 double a2 = 1;
#define a10 a10_opto
 double a10 = 5;
#define b40 b40_opto
 double b40 = 1.1;
#define b3 b3_opto
 double b3 = 1;
#define b21 b21_opto
 double b21 = 0.0048;
#define b20 b20_opto
 double b20 = 0.011;
#define b1 b1_opto
 double b1 = 0.13;
#define e e_opto
 double e = 0;
#define gamma gamma_opto
 double gamma = 0.05;
#define phot_e phot_e_opto
 double phot_e = 4.22648e-019;
#define phi_0 phi_0_opto
 double phi_0 = 1e+016;
#define sigma sigma_opto
 double sigma = 1e-008;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "sigma_opto", "um2",
 "U0_opto", "mV",
 "e_opto", "mV",
 "a10_opto", "/ms",
 "a2_opto", "/ms",
 "a30_opto", "/ms",
 "a31_opto", "/ms",
 "a4_opto", "/ms",
 "a6_opto", "/ms",
 "b1_opto", "/ms",
 "b20_opto", "/ms",
 "b21_opto", "/ms",
 "b3_opto", "/ms",
 "b40_opto", "/ms",
 "phi_0_opto", "/s/cm2",
 "phot_e_opto", "J",
 "gchr2_max_opto", "S/cm2",
 "irr_opto", "mW/mm2",
 "ilit_opto", "mA/cm2",
 "gchr2_opto", "S/cm2",
 "flux_opto", "/s/cm2",
 0,0
};
 static double delta_t = 0.01;
 static double s60 = 0;
 static double s50 = 0;
 static double s40 = 0;
 static double s30 = 0;
 static double s20 = 0;
 static double s10 = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "sigma_opto", &sigma_opto,
 "U0_opto", &U0_opto,
 "U1_opto", &U1_opto,
 "gamma_opto", &gamma_opto,
 "N_opto", &N_opto,
 "e_opto", &e_opto,
 "a10_opto", &a10_opto,
 "a2_opto", &a2_opto,
 "a30_opto", &a30_opto,
 "a31_opto", &a31_opto,
 "a4_opto", &a4_opto,
 "a6_opto", &a6_opto,
 "b1_opto", &b1_opto,
 "b20_opto", &b20_opto,
 "b21_opto", &b21_opto,
 "b3_opto", &b3_opto,
 "b40_opto", &b40_opto,
 "phi_0_opto", &phi_0_opto,
 "phot_e_opto", &phot_e_opto,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(), nrn_init(), nrn_state();
 static void nrn_cur(), nrn_jacob();
 
static int _ode_count(), _ode_map(), _ode_spec(), _ode_matsol();
 
#define _cvode_ieq _ppvar[0]._i
 /* connect range variables in _p that hoc is supposed to know about */
 static char *_mechanism[] = {
 "6.2.0",
"opto",
 "gchr2_max_opto",
 0,
 "irr_opto",
 "ilit_opto",
 "gchr2_opto",
 "flux_opto",
 0,
 "s1_opto",
 "s2_opto",
 "s3_opto",
 "s4_opto",
 "s5_opto",
 "s6_opto",
 0,
 0};
 
static void nrn_alloc(_prop)
	Prop *_prop;
{
	Prop *prop_ion, *need_memb();
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 23, _prop);
 	/*initialize range parameters*/
 	gchr2_max = 0.036;
 	_prop->param = _p;
 	_prop->param_size = 23;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 1, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 
}
 static _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _thread_cleanup(Datum*);
 _opto_reg() {
	int _vectorized = 1;
  _initlists();
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 3);
  _extcall_thread = (Datum*)ecalloc(2, sizeof(Datum));
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 0, _thread_cleanup);
  hoc_register_dparam_size(_mechtype, 1);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 opto C:/Users/Radu/Documents/GitHub/OptobionicVision/Six_State_Model/opto.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static _modl_cleanup(){ _match_recurse=1;}
static rates();
 extern double *_nrn_thread_getelm();
 
#define _MATELM1(_row,_col) *(_nrn_thread_getelm(_so, _row + 1, _col + 1))
 
#define _RHS1(_arg) _rhs[_arg+1]
  
#define _linmat1  1
 static int _spth1 = 1;
 static int _cvspth1 = 0;
 
static int _ode_spec1(), _ode_matsol1();
 static int _slist1[6], _dlist1[6]; static double *_temp1;
 static int states();
 
static int states (void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt)
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<6;_i++){
  	_RHS1(_i) = -_dt1*(_p[_slist1[_i]] - _p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates ( _threadargs_ ) ;
   /* ~ s1 <-> s2 ( a1 , 0.0 )*/
 f_flux =  a1 * s1 ;
 b_flux =  0.0 * s2 ;
 _RHS1( 5) -= (f_flux - b_flux);
 _RHS1( 4) += (f_flux - b_flux);
 
 _term =  a1 ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 4 ,5)  -= _term;
 _term =  0.0 ;
 _MATELM1( 5 ,4)  -= _term;
 _MATELM1( 4 ,4)  += _term;
 /*REACTION*/
  /* ~ s1 <-> s3 ( 0.0 , b1 )*/
 f_flux =  0.0 * s1 ;
 b_flux =  b1 * s3 ;
 _RHS1( 5) -= (f_flux - b_flux);
 _RHS1( 3) += (f_flux - b_flux);
 
 _term =  0.0 ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 3 ,5)  -= _term;
 _term =  b1 ;
 _MATELM1( 5 ,3)  -= _term;
 _MATELM1( 3 ,3)  += _term;
 /*REACTION*/
  /* ~ s2 <-> s3 ( a2 , 0.0 )*/
 f_flux =  a2 * s2 ;
 b_flux =  0.0 * s3 ;
 _RHS1( 4) -= (f_flux - b_flux);
 _RHS1( 3) += (f_flux - b_flux);
 
 _term =  a2 ;
 _MATELM1( 4 ,4)  += _term;
 _MATELM1( 3 ,4)  -= _term;
 _term =  0.0 ;
 _MATELM1( 4 ,3)  -= _term;
 _MATELM1( 3 ,3)  += _term;
 /*REACTION*/
  /* ~ s3 <-> s4 ( a3 , b2 )*/
 f_flux =  a3 * s3 ;
 b_flux =  b2 * s4 ;
 _RHS1( 3) -= (f_flux - b_flux);
 _RHS1( 2) += (f_flux - b_flux);
 
 _term =  a3 ;
 _MATELM1( 3 ,3)  += _term;
 _MATELM1( 2 ,3)  -= _term;
 _term =  b2 ;
 _MATELM1( 3 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ s4 <-> s5 ( 0.0 , b3 )*/
 f_flux =  0.0 * s4 ;
 b_flux =  b3 * s5 ;
 _RHS1( 2) -= (f_flux - b_flux);
 _RHS1( 1) += (f_flux - b_flux);
 
 _term =  0.0 ;
 _MATELM1( 2 ,2)  += _term;
 _MATELM1( 1 ,2)  -= _term;
 _term =  b3 ;
 _MATELM1( 2 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
  /* ~ s4 <-> s6 ( a4 , 0.0 )*/
 f_flux =  a4 * s4 ;
 b_flux =  0.0 * s6 ;
 _RHS1( 2) -= (f_flux - b_flux);
 
 _term =  a4 ;
 _MATELM1( 2 ,2)  += _term;
 _term =  0.0 ;
 _MATELM1( 2 ,0)  -= _term;
 /*REACTION*/
  /* ~ s5 <-> s6 ( 0.0 , b4 )*/
 f_flux =  0.0 * s5 ;
 b_flux =  b4 * s6 ;
 _RHS1( 1) -= (f_flux - b_flux);
 
 _term =  0.0 ;
 _MATELM1( 1 ,1)  += _term;
 _term =  b4 ;
 _MATELM1( 1 ,0)  -= _term;
 /*REACTION*/
  /* ~ s6 <-> s1 ( a6 , 0.0 )*/
 f_flux =  a6 * s6 ;
 b_flux =  0.0 * s1 ;
 _RHS1( 5) += (f_flux - b_flux);
 
 _term =  a6 ;
 _MATELM1( 5 ,0)  -= _term;
 _term =  0.0 ;
 _MATELM1( 5 ,5)  += _term;
 /*REACTION*/
   /* s1 + s2 + s3 + s4 + s5 + s6 = N */
 _RHS1(0) =  N;
 _MATELM1(0, 0) = 1;
 _RHS1(0) -= s6 ;
 _MATELM1(0, 1) = 1;
 _RHS1(0) -= s5 ;
 _MATELM1(0, 2) = 1;
 _RHS1(0) -= s4 ;
 _MATELM1(0, 3) = 1;
 _RHS1(0) -= s3 ;
 _MATELM1(0, 4) = 1;
 _RHS1(0) -= s2 ;
 _MATELM1(0, 5) = 1;
 _RHS1(0) -= s1 ;
 /*CONSERVATION*/
   } return _reset;
 }
 
static int  rates ( _p, _ppvar, _thread, _nt ) double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt; {
   flux = irr / phot_e * ( 1e-1 ) ;
   a1 = a10 * ( flux / phi_0 ) ;
   b4 = b40 * ( flux / phi_0 ) ;
   if ( flux < phi_0 ) {
     a3 = a30 ;
     b2 = b20 ;
     }
   else {
     a3 = a30 + a31 * log ( flux / phi_0 ) ;
     b2 = b20 + b21 * log ( flux / phi_0 ) ;
     }
    return 0; }
 
static int _hoc_rates() {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r = 1.;
 rates ( _p, _ppvar, _thread, _nt ) ;
 ret(_r);
}
 
double vdep ( _p, _ppvar, _thread, _nt, _lv ) double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt; 
	double _lv ;
 {
   double _lvdep;
 _lvdep = ( 1.0 - exp ( _lv / U0 ) ) / ( U1 ) ;
   
return _lvdep;
 }
 
static int _hoc_vdep() {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  vdep ( _p, _ppvar, _thread, _nt, *getarg(1) ) ;
 ret(_r);
}
 
double fdep ( _p, _ppvar, _thread, _nt ) double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt; {
   double _lfdep;
 _lfdep = s3 + gamma * s4 ;
   
return _lfdep;
 }
 
static int _hoc_fdep() {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  fdep ( _p, _ppvar, _thread, _nt ) ;
 ret(_r);
}
 
/*CVODE ode begin*/
 static int _ode_spec1(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<6;_i++) _p[_dlist1[_i]] = 0.0;}
 rates ( _threadargs_ ) ;
 /* ~ s1 <-> s2 ( a1 , 0.0 )*/
 f_flux =  a1 * s1 ;
 b_flux =  0.0 * s2 ;
 Ds1 -= (f_flux - b_flux);
 Ds2 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s1 <-> s3 ( 0.0 , b1 )*/
 f_flux =  0.0 * s1 ;
 b_flux =  b1 * s3 ;
 Ds1 -= (f_flux - b_flux);
 Ds3 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s2 <-> s3 ( a2 , 0.0 )*/
 f_flux =  a2 * s2 ;
 b_flux =  0.0 * s3 ;
 Ds2 -= (f_flux - b_flux);
 Ds3 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s3 <-> s4 ( a3 , b2 )*/
 f_flux =  a3 * s3 ;
 b_flux =  b2 * s4 ;
 Ds3 -= (f_flux - b_flux);
 Ds4 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s4 <-> s5 ( 0.0 , b3 )*/
 f_flux =  0.0 * s4 ;
 b_flux =  b3 * s5 ;
 Ds4 -= (f_flux - b_flux);
 Ds5 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s4 <-> s6 ( a4 , 0.0 )*/
 f_flux =  a4 * s4 ;
 b_flux =  0.0 * s6 ;
 Ds4 -= (f_flux - b_flux);
 Ds6 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s5 <-> s6 ( 0.0 , b4 )*/
 f_flux =  0.0 * s5 ;
 b_flux =  b4 * s6 ;
 Ds5 -= (f_flux - b_flux);
 Ds6 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ s6 <-> s1 ( a6 , 0.0 )*/
 f_flux =  a6 * s6 ;
 b_flux =  0.0 * s1 ;
 Ds6 -= (f_flux - b_flux);
 Ds1 += (f_flux - b_flux);
 
 /*REACTION*/
   /* s1 + s2 + s3 + s4 + s5 + s6 = N */
 /*CONSERVATION*/
   } return _reset;
 }
 
/*CVODE matsol*/
 static int _ode_matsol1(void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
   b_flux = f_flux = 0.;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<6;_i++){
  	_RHS1(_i) = _dt1*(_p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates ( _threadargs_ ) ;
 /* ~ s1 <-> s2 ( a1 , 0.0 )*/
 _term =  a1 ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 4 ,5)  -= _term;
 _term =  0.0 ;
 _MATELM1( 5 ,4)  -= _term;
 _MATELM1( 4 ,4)  += _term;
 /*REACTION*/
  /* ~ s1 <-> s3 ( 0.0 , b1 )*/
 _term =  0.0 ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 3 ,5)  -= _term;
 _term =  b1 ;
 _MATELM1( 5 ,3)  -= _term;
 _MATELM1( 3 ,3)  += _term;
 /*REACTION*/
  /* ~ s2 <-> s3 ( a2 , 0.0 )*/
 _term =  a2 ;
 _MATELM1( 4 ,4)  += _term;
 _MATELM1( 3 ,4)  -= _term;
 _term =  0.0 ;
 _MATELM1( 4 ,3)  -= _term;
 _MATELM1( 3 ,3)  += _term;
 /*REACTION*/
  /* ~ s3 <-> s4 ( a3 , b2 )*/
 _term =  a3 ;
 _MATELM1( 3 ,3)  += _term;
 _MATELM1( 2 ,3)  -= _term;
 _term =  b2 ;
 _MATELM1( 3 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ s4 <-> s5 ( 0.0 , b3 )*/
 _term =  0.0 ;
 _MATELM1( 2 ,2)  += _term;
 _MATELM1( 1 ,2)  -= _term;
 _term =  b3 ;
 _MATELM1( 2 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
  /* ~ s4 <-> s6 ( a4 , 0.0 )*/
 _term =  a4 ;
 _MATELM1( 2 ,2)  += _term;
 _MATELM1( 0 ,2)  -= _term;
 _term =  0.0 ;
 _MATELM1( 2 ,0)  -= _term;
 _MATELM1( 0 ,0)  += _term;
 /*REACTION*/
  /* ~ s5 <-> s6 ( 0.0 , b4 )*/
 _term =  0.0 ;
 _MATELM1( 1 ,1)  += _term;
 _MATELM1( 0 ,1)  -= _term;
 _term =  b4 ;
 _MATELM1( 1 ,0)  -= _term;
 _MATELM1( 0 ,0)  += _term;
 /*REACTION*/
  /* ~ s6 <-> s1 ( a6 , 0.0 )*/
 _term =  a6 ;
 _MATELM1( 0 ,0)  += _term;
 _MATELM1( 5 ,0)  -= _term;
 _term =  0.0 ;
 _MATELM1( 0 ,5)  -= _term;
 _MATELM1( 5 ,5)  += _term;
 /*REACTION*/
   /* s1 + s2 + s3 + s4 + s5 + s6 = N */
 /*CONSERVATION*/
   } return _reset;
 }
 
/*CVODE end*/
 
static int _ode_count(_type) int _type;{ return 6;}
 
static int _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
     _ode_spec1 (_p, _ppvar, _thread, _nt);
 }}
 
static int _ode_map(_ieq, _pv, _pvdot, _pp, _ppd, _atol, _type) int _ieq, _type; double** _pv, **_pvdot, *_pp, *_atol; Datum* _ppd; { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 6; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 
static int _ode_matsol(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
 _cvode_sparse_thread(&_thread[_cvspth1]._pvoid, 6, _dlist1, _p, _ode_matsol1, _ppvar, _thread, _nt);
 }}
 
static void _thread_cleanup(Datum* _thread) {
   _nrn_destroy_sparseobj_thread(_thread[_cvspth1]._pvoid);
   _nrn_destroy_sparseobj_thread(_thread[_spth1]._pvoid);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  int _i; double _save;{
  s6 = s60;
  s5 = s50;
  s4 = s40;
  s3 = s30;
  s2 = s20;
  s1 = s10;
 {
   rates ( _threadargs_ ) ;
   s1 = N ;
   s2 = 0.0 ;
   s3 = 0.0 ;
   s4 = 0.0 ;
   s5 = 0.0 ;
   s6 = 0.0 ;
   }
 
}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
 initmodel(_p, _ppvar, _thread, _nt);
}}

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _v){double _current=0.;v=_v;{ {
   gchr2 = gchr2_max * fdep ( _threadargs_ ) * vdep ( _threadargscomma_ v ) ;
   ilit = - gchr2 * ( v - e ) ;
   }
 _current += ilit;

} return _current;
}

static void nrn_cur(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 _g = _nrn_current(_p, _ppvar, _thread, _nt, _v + .001);
 	{ _rhs = _nrn_current(_p, _ppvar, _thread, _nt, _v);
 	}
 _g = (_g - _rhs)/.001;
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
  }
 
}}

static void nrn_jacob(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml];
#if CACHEVEC
  if (use_cachevec) {
	VEC_D(_ni[_iml]) += _g;
  }else
#endif
  {
     _nd = _ml->_nodelist[_iml];
	NODED(_nd) += _g;
  }
 
}}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type) {
 double _break, _save;
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 _break = t + .5*dt; _save = t;
 v=_v;
{
 { {
 for (; t < _break; t += dt) {
  sparse_thread(&_thread[_spth1]._pvoid, 6, _slist1, _dlist1, _p, &t, dt, states, _linmat1, _ppvar, _thread, _nt);
  
}}
 t = _save;
 }}}

}

static terminal(){}

static _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(s6) - _p;  _dlist1[0] = &(Ds6) - _p;
 _slist1[1] = &(s5) - _p;  _dlist1[1] = &(Ds5) - _p;
 _slist1[2] = &(s4) - _p;  _dlist1[2] = &(Ds4) - _p;
 _slist1[3] = &(s3) - _p;  _dlist1[3] = &(Ds3) - _p;
 _slist1[4] = &(s2) - _p;  _dlist1[4] = &(Ds2) - _p;
 _slist1[5] = &(s1) - _p;  _dlist1[5] = &(Ds1) - _p;
_first = 0;
}
