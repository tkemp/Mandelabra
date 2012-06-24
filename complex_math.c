/*
 *  fractal_math.c
 *  Mandelabra
 *
 *  Created by Tim Kemp on 07/08/2010.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "complex_math.h"

cplx mult(cplx z, cplx w) {
	long double zReal = z.real;
	long double zImag = z.imag;
	long double wReal = w.real;
	long double wImag = w.imag;
	cplx result;

	result.real = (zReal * wReal) - (zImag * wImag);
	result.imag = (zImag * wReal) + (zReal * wImag);
	
	return result;
}

/*
 Note to self re: complex multiplication:
 
 (x + yi)(u + vi) = (xu – yv) + (xv + yu)i.
 Remember that (xu – yv), the real part of the product, is the product of the real parts 
 minus the product of the imaginary parts, but (xv + yu), the imaginary part of the product, 
 is the sum of the two products of one real part and the other imaginary part.
*/

cplx cplxAdd(cplx z, cplx w) {
	cplx result;
	
	result.real = z.real + w.real;
	result.imag = z.imag + w.imag;

	return result;
}

cplx cplxSub(cplx z, cplx w) {
	cplx result;
	
	result.real = z.real - w.real;
	result.imag = z.imag - w.imag;
	
	return result;
}

int isInRange(cplx z, cplx low, cplx high) {
	if ((z.real < low.real) || (z.imag < low.imag) || (z.real > high.real) || (z.imag > high.imag))
		return 0;
	else
		return 1;
}

long double modSqr(cplx z) {
	long double result = ((z.real * z.real) + (z.imag * z.imag));
	return result;
}

cplx vectorMult(cplx z, factor f) {
	cplx result;

	result.real = z.real * f.real;
	result.imag = z.imag * f.imag;
	
	return result;
}

cplx vectorDiv(cplx z, factor f) {
	cplx result;
	
	result.real = z.real / f.real;
	result.imag = z.imag / f.imag;
	
	return result;
}

int cplxEqual(cplx z, cplx w) {
	return ((z.real == w.real) && (z.imag == w.imag));
}