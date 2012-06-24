/*
 *  fractal_math.h
 *  Mandelabra
 *
 *  Created by Tim Kemp on 07/08/2010.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include <stdio.h>

typedef struct cplx {
	long double real;
	long double imag;
} cplx;

typedef struct factor {
	long double real;
	long double imag;
} factor;

cplx mult(cplx z, cplx w);
cplx cplxAdd(cplx z, cplx w);
cplx cplxSub(cplx z, cplx w);
int isInRange(cplx z, cplx low, cplx high);
//cplx div(cplx z, cplx y);
long double modSqr(cplx z);
cplx vectorMult(cplx z, factor f);
cplx vectorDiv(cplx z, factor f);
int cplxEqual(cplx z, cplx w);