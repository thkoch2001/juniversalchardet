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

#define CHARDET_ENCODING_ISO_2022_JP    "ISO-2022-JP"
#define CHARDET_ENCODING_ISO_2022_CN    "ISO-2022-CN"
#define CHARDET_ENCODING_ISO_2022_KR    "ISO-2022-KR"
#define CHARDET_ENCODING_ISO_8859_5     "ISO-8859-5"
#define CHARDET_ENCODING_ISO_8859_7     "ISO-8859-7"
#define CHARDET_ENCODING_ISO_8859_8     "ISO-8859-8"
#define CHARDET_ENCODING_BIG5           "BIG5"
#define CHARDET_ENCODING_GB18030        "GB18030"
#define CHARDET_ENCODING_EUC_JP         "EUC-JP"
#define CHARDET_ENCODING_EUC_KR         "EUC-KR"
#define CHARDET_ENCODING_EUC_TW         "EUC-TW"
#define CHARDET_ENCODING_SHIFT_JIS      "SHIFT_JIS"
#define CHARDET_ENCODING_IBM855         "IBM855"
#define CHARDET_ENCODING_IBM866         "IBM866"
#define CHARDET_ENCODING_KOI8_R         "KOI8-R"
#define CHARDET_ENCODING_MACCYRILLIC    "MACCYRILLIC"
#define CHARDET_ENCODING_WINDOWS_1251   "WINDOWS-1251"
#define CHARDET_ENCODING_WINDOWS_1252   "WINDOWS-1252"
#define CHARDET_ENCODING_WINDOWS_1253   "WINDOWS-1253"
#define CHARDET_ENCODING_WINDOWS_1255   "WINDOWS-1255"
#define CHARDET_ENCODING_UTF_8          "UTF-8"
#define CHARDET_ENCODING_UTF_16BE       "UTF-16BE"
#define CHARDET_ENCODING_UTF_16LE       "UTF-16LE"
#define CHARDET_ENCODING_UTF_32BE       "UTF-32BE"
#define CHARDET_ENCODING_UTF_32LE       "UTF-32LE"
#define CHARDET_ENCODING_HZ_GB_2312     "HZ-GB-2312"
#define CHARDET_ENCODING_X_ISO_10646_UCS_4_3412 "X-ISO-10646-UCS-4-3412"
#define CHARDET_ENCODING_X_ISO_10646_UCS_4_2143 "X-ISO-10646-UCS-4-2143"

#define CHARDET_ENCODING_ISO_8859_2     "ISO-8859-2"
#define CHARDET_ENCODING_WINDOWS_1250   "WINDOWS-1250"
#define CHARDET_ENCODING_TIS_620        "TIS-620"


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
  SWIG_Object o;
  o = SWIG_NewPointerObj(*$1, $descriptor(chardet_t), 0);
  $result = SWIG_AppendOutput($result, o);
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
