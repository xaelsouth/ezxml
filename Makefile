# Makefile
#
# Copyright 2004, 2005 Aaron Voisine <aaron@voisine.org>
# Copyright 2015-2023 Xael South <xael.south@yandex.com>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

CC = gcc
AR = ar
RM = rm -f
CFLAGS = -Wall -O2
OBJS = ezxml.o
LIB = libezxml.a
TEST = ezxmltest

.if defined(NOMMAP) || make(nommap)
CFLAGS += -D EZXML_NOMMAP
.endif
.if defined(DEBUG) || make(debug) || make(test)
CFLAGS += -O0 -g
.endif
.if make($(TEST)) || make(test)
CFLAGS += -D EZXML_TEST -D EZXML_PARSE_FILE
.endif

all: $(LIB)

$(LIB): $(OBJS)
	$(AR) rcs $(LIB) $(OBJS)

test: $(TEST)

debug: all

nommap: all

$(TEST): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

ezxml.o: ezxml.h ezxml.c

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	$(RM) $(OBJS) $(LIB) $(TEST) *~

