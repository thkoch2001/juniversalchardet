juniversalchardet


1. What is it?

juniversalchardet is a Java port of "universalchardet",
that is the encoding detector library of Mozilla.

The original code of universalchardet is available at
http://lxr.mozilla.org/seamonkey/source/extensions/universalchardet/


2. How to use it

(1) Construct an instance of org.mozilla.universalchardet.UniversalDetector.
(2) Feed some data (typically some thousand bytes) to the detector
    using UniversalDetector.handleData().
(3) Notify the detector of the end of data by using
    UniversalDetector.dataEnd().
(4) Get the detected encoding name by using
    UniversalDetector.getDetectedCharset().
(5) Don't forget to call UniversalDetector.reset() before you reuse
    the detector instance for another guess.


3. License

The library is subject to the Mozilla Public License Version 1.1.
Alternatively, the library may be used under the terms of either
the GNU General Public License Version 2 or later, or the GNU
Lesser General Public License 2.1 or later.


