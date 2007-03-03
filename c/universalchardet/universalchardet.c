#include "universalchardet.h"

#include <stdio.h>


static void doit(FILE* fp)
{
    char buf[4096];
    char encoding[CHARDET_MAX_ENCODING_NAME];
    size_t len;
    int res = 0;
    chardet_t det = NULL;

    chardet_create(&det);

    do {
	len = fread(buf, 1, sizeof(buf), fp);
	res = chardet_handle_data(det, buf, len);
    } while (res==CHARDET_RESULT_OK && feof(fp)==0);

    chardet_data_end(det);

    chardet_get_charset(det, encoding, CHARDET_MAX_ENCODING_NAME);
    printf("Charset = %s\n", encoding);

    chardet_destroy(det);
}

int main(int argc, char* argv[])
{
    FILE* fp = NULL;

    if (argc > 1) {
	fp = fopen(argv[1], "rb");
	if (fp) {
	    doit(fp);
	    fclose(fp);
	} else {
	    printf("Can't open %s\n", argv[1]);
	    return 1;
	}
    } else {
	printf("USAGE: chardet filename\n");
	return 1;
    }

    return 0;
}

