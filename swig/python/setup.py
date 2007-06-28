#!/usr/bin/env python
# -*- coding:utf-8 -*-
from distutils.core import setup
from distutils.core import Extension

LIB_NAME = 'cchardet'
LIB_VERSION = '1.0.2'
LIB_DESC = 'A Python binding of universalchardet'
LIB_AUTHOR = 'Kohei TAKETA'
LIB_AUTHOR_EMAIL = 'k-tak@void.in'
LIB_URL = 'http://code.google.com/p/juniversalchardet/'

setup(name=LIB_NAME,
      version=LIB_VERSION,
      description=LIB_DESC,
      author=LIB_AUTHOR,
      author_email=LIB_AUTHOR_EMAIL,
      url=LIB_URL,
      ext_modules=[Extension('_cchardet',
                             ['cchardet_wrap.c'],
                             libraries=['uchardet'])],
      py_modules=['cchardet']
      )
