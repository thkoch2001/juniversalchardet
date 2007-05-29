/***************************************************************
 * The author disclaims copyright to this source code.
 * In place of a legal notice, here is a blessing:
 *
 *    May you do good and not evil.
 *    May you find forgiveness for yourself and forgive others.
 *    May you share freely, never taking more than you give.
 *
 * Any feedback will be appreciated. mailto:k-tak@void.in
 ***************************************************************/
%module cchardet
%include typemaps.i
%include cstring.i

%{
#include <universalchardet.h>
%}

typedef void* chardet_t;

#define CHARDET_RESULT_OK		    0
#define CHARDET_RESULT_NOMEMORY		    (-1)
#define CHARDET_RESULT_INVALID_DETECTOR	    (-2)

%typemap(in) char *namebuf (char tmpbuf[CHARDET_MAX_ENCODING_NAME+1]) {
   $1 = tmpbuf;
}
%cstring_bounded_output(char *namebuf, CHARDET_MAX_ENCODING_NAME);

%apply (const char *STRING, size_t LENGTH) { (const char *input_str, unsigned int input_len) };

%typemap(in, numinputs=0) chardet_t *pdet(chardet_t ret) {
  ret = NULL;
  $1 = &ret;
}
%typemap(argout) chardet_t *pdet {
  PyObject *o;
  o = SWIG_NewPointerObj(*$1, $descriptor(chardet_t), 0);
  $result = SWIG_Python_AppendOutput($result, o);
}

int chardet_create(chardet_t* pdet);
void chardet_destroy(chardet_t det);
int chardet_handle_data(chardet_t det,
                        const char* input_str, unsigned int input_len);
int chardet_data_end(chardet_t det);
int chardet_reset(chardet_t det);

%rename(chardet_get_charset) my_get_charset;
%inline {
static void my_get_charset(chardet_t det, char* namebuf)
{
   int ret = 0;
   ret = chardet_get_charset(det, namebuf, CHARDET_MAX_ENCODING_NAME);
}
}
