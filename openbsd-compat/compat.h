#ifndef __COMPAT_H__
#define __COMPAT_H__

#include <sys/types.h>

#include <stdio.h>

#include "entropy.h"

long long strtonum(const char *, long long, long long, const char **errstrp);
size_t strlcpy(char *, const char *, size_t);
size_t strlcat(char *, const char *, size_t);
char *fgetln(FILE *, size_t *);
unsigned int arc4random(void);
void arc4random_stir(void);
void arc4random_buf(void *, size_t);
u_int32_t arc4random_uniform(u_int32_t);
char *bdirname(const char *);

/*
 * fparseln() specific operation flags.
 */
#define FPARSELN_UNESCESC       0x01
#define FPARSELN_UNESCCONT      0x02
#define FPARSELN_UNESCCOMM      0x04
#define FPARSELN_UNESCREST      0x08
#define FPARSELN_UNESCALL       0x0f
char *fparseln(FILE *, size_t *, size_t *, const char[3], int);

/*
 * MAC OS X
 */
#ifdef __APPLE__
#define LOGIN_NAME_MAX MAXLOGNAME
#endif

#endif /* __COMPAT_H__ */
