/*
 * SGI FREE SOFTWARE LICENSE B (Version 2.0, Sept. 18, 2008)
 * Copyright (C) 1991-2000 Silicon Graphics, Inc. All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice including the dates of first publication and
 * either this permission notice or a reference to
 * http://oss.sgi.com/projects/FreeB/
 * shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * SILICON GRAPHICS, INC. BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Except as contained in this notice, the name of Silicon Graphics, Inc.
 * shall not be used in advertising or otherwise to promote the sale, use or
 * other dealings in this Software without prior written authorization from
 * Silicon Graphics, Inc.
 */
/*
 *
 * OpenGL ES 1.0 CM port of GLU by Mike Gorchak <mike@malva.ua>
*/

#ifndef __gluglcurveval_h_
#define __gluglcurveval_h_

#include "glues.h"

#include "basiccrveval.h"

class CurveMap;

/*for internal evaluator callback stuff*/
#ifndef IN_MAX_BEZIER_ORDER
   #define IN_MAX_BEZIER_ORDER 40 /* XXX should be bigger than machine order */
#endif

#ifndef IN_MAX_DIMENSION
   #define IN_MAX_DIMENSION 4
#endif

typedef struct curveEvalMachine
{
   REAL uprime; // cached previously evaluated uprime
   int k; // the dimension
   REAL u1;
   REAL u2;
   int ustride;
   int uorder;
   REAL ctlpoints[IN_MAX_BEZIER_ORDER*IN_MAX_DIMENSION];
   REAL ucoeff[IN_MAX_BEZIER_ORDER]; // cache the polynomial values
} curveEvalMachine;

class OpenGLCurveEvaluator: public BasicCurveEvaluator
{
   long output_style;       // N_MESHFILL or N_MESHLINE or N_MESHPOINT

   public:
      OpenGLCurveEvaluator(void);
      virtual ~OpenGLCurveEvaluator(void);
      void range1f(long, REAL*, REAL*);
      void domain1f(REAL, REAL);
      void addMap(CurveMap*);

      void enable(long);
      void disable(long);
      void bgnmap1f(long);
      void map1f(long, REAL, REAL, long, long, REAL*);
      void mapgrid1f(long, REAL, REAL);
      void mapmesh1f(long, long, long);
      void evalpoint1i(long);
      void evalcoord1f(long, REAL);
      void endmap1f(void);

      void bgnline(void);
      void endline(void);

      void put_vertices_call_back(int flag)
      {
         output_triangles=flag;
      }
#ifdef _WIN32
      void putCallBack(GLenum which, void (APIENTRY* fn)());
#else
      void putCallBack(GLenum which, _GLUfuncptr fn);
#endif
      void set_callback_userData(void* data)
      {
         userData=data;
      }

      /*------------------begin for curveEvalMachine------------*/
      curveEvalMachine em_vertex;
      curveEvalMachine em_normal;
      curveEvalMachine em_color;
      curveEvalMachine em_texcoord;
      int vertex_flag;   // whether there is a vertex map or not
      int normal_flag;   // whether there is a normal map or not
      int color_flag;    // whether there is a color map or not
      int texcoord_flag; // whether there is a texture map or not

      REAL global_grid_u0;
      REAL global_grid_u1;
      int global_grid_nu;

      void inMap1f(int which, int dimension, REAL ulower, REAL uupper, int ustride, int uorder, REAL* ctlpoints);
      void inMap1fr(int which, int dimension, REAL ulower, REAL uupper, int ustride, int uorder, REAL* ctlpoints);
      void inPreEvaluate(int order, REAL vprime, REAL* coeff);
      void inDoDomain1(curveEvalMachine* em, REAL u, REAL* retPoint);
      void inDoEvalCoord1(REAL u);
      void inDoEvalCoord1r(REAL u, REAL* retPoint);
      void inMapMesh1f(int umin, int umax);
      void inMapMesh1fr(int umin, int umax);

      void (APIENTRY* beginCallBackN)(GLenum type);
      void (APIENTRY* endCallBackN)(void);
      void (APIENTRY* vertexCallBackN)(const GLfloat* vert);
      void (APIENTRY* normalCallBackN)(const GLfloat* normal);
      void (APIENTRY* colorCallBackN)(const GLfloat* color);
      void (APIENTRY* texcoordCallBackN)(const GLfloat* texcoord);

      void (APIENTRY* beginCallBackData)(GLenum type, void* data);
      void (APIENTRY* endCallBackData)(void* data);
      void (APIENTRY* vertexCallBackData)(const GLfloat* vert, void* data);
      void (APIENTRY* normalCallBackData)(const GLfloat* normal, void* data);
      void (APIENTRY* colorCallBackData)(const GLfloat* color, void* data);
      void (APIENTRY* texcoordCallBackData)(const GLfloat* texcoord, void* data);

      void* userData; // the opaque pointer for Data callback functions
      void beginCallBack(GLenum type, void* data);
      void endCallBack(void* data);
      void vertexCallBack(const GLfloat* vert, void *data);
      void normalCallBack(const GLfloat* normal, void* data);
      void colorCallBack(const GLfloat* color, void* data);
      void texcoordCallBack(const GLfloat* texcoord, void* data);

/*------------------end for curveEvalMachine------------*/

   private:
      int output_triangles; // true 1; false 0
};

#endif /* __gluglcurveval_h_ */
