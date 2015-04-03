/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is mozilla.org code.
 *
 * The Initial Developer of the Original Code is
 * Netscape Communications Corporation.
 * Portions created by the Initial Developer are Copyright (C) 1998
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Kohei TAKETA <k-tak@void.in>
 *   lnezda
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */
package org.mozilla.universalchardet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class TestDetector
{

	private final List<String> BINARY_EXTENSION = Arrays.asList("jar", "zip",
			"7z", "class", "png", "gif", "jpg");
    
	public static String getExtension(String filename) {
		return filename.replaceFirst("^.*?(\\.([^./\\\\]+)){0,1}$", "$2");
	}

	public static void main(String... args) throws IOException
    {
        if (args.length != 1) {
            System.err.println("Usage: java TestDetector FILENAME");
            System.exit(1);
        }
        
        final TestDetector testDetector = new TestDetector();
        
		for (final String filename : args) {
			File file = new File(filename);
			testDetector.detectFile(file);
		}
    }

	private final UniversalDetector detector;
	
	public TestDetector() {
		// (1)
		this.detector = new UniversalDetector(null);
	}

    public void detectFile(File file) throws IOException
    {
    	if(file.isDirectory()) {
    		for(File f : file.listFiles()) {
    			detectFile(f);
    		}
    		return;
    	}
    	
        final byte[] buf = new byte[4096];
        
		try (final FileInputStream fis = new FileInputStream(file);)
		{
			// (2)
			int nread;
			while ((nread = fis.read(buf)) > 0 && !detector.isDone()) {
				detector.handleData(buf, 0, nread);
			}
		}
        // (3)
        detector.dataEnd();

        // (4)
		String encoding = detector.getDetectedCharset();
		final String extension = getExtension(file.getName()).toLowerCase();
		if (encoding == null && BINARY_EXTENSION.contains(extension)) {
			encoding = "binary ?";
		}
		showResult(file, extension, encoding);

        // (5)
        detector.reset();
    }
    
	public void showResult(final File file,final String extension, final String encoding) {
		System.out.println(file + "\t" + extension + "\t"
				+ (encoding == null ? "##unknown##" : encoding));
	}
}
