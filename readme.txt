juniversalchardet


1. What is it?

juniversalchardet is a Java port of "universalchardet",
that is the encoding detector library of Mozilla.

The original code of universalchardet is available at
http://lxr.mozilla.org/seamonkey/source/extensions/universalchardet/


2. Encodings that can be detected

- Chinese
  - ISO-2022-CN
  - Big5
  - EUC-CN
  - X-EUC-TW
  - GB18030
  - HZ-GB-2312

- Cyrillic
  - ISO-8859-5
  - KOI8-R
  - windows-1251
  - x-mac-cyrillic
  - IBM866
  - IBM855

- Greek
  - ISO-8859-7
  - windows-1253

- Hebrew
  - ISO-8859-8
  - windows-1255

- Japanese
  - ISO-2022-JP
  - Shift_JIS
  - EUC-JP

- Korean
  - ISO-2022-KR
  - EUC-KR

- Unicode
  - UTF-8
  - UTF-16BE / UTF-16LE
  - UTF-32BE / UTF-32LE / X-ISO-10646-UCS-4-3412 / X-ISO-10646-UCS-4-2143

- Others
  - ISO-8859-1


3. How to use it

(1) Construct an instance of org.mozilla.universalchardet.UniversalDetector.
(2) Feed some data (typically some thousand bytes) to the detector
    using UniversalDetector.handleData().
(3) Notify the detector of the end of data by using
    UniversalDetector.dataEnd().
(4) Get the detected encoding name by using
    UniversalDetector.getDetectedCharset().
(5) Don't forget to call UniversalDetector.reset() before you reuse
    the detector instance for another guess.


4. License

The library is subject to the Mozilla Public License Version 1.1.
Alternatively, the library may be used under the terms of either
the GNU General Public License Version 2 or later, or the GNU
Lesser General Public License 2.1 or later.


