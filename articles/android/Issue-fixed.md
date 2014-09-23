
#  How to fix “Error generating final archive: duplicate entry: AndroidManifest.xml”

I figured out what the problem was. I included a JAR file that had an AndroidManifest.xml file in it, which was conflicting with my own project's AndroidManifest.xml file. The solution in my instance was to rebuild the JAR file, making sure it excluded its own version of AndroidManifest.xml, then to re-include the new version of the JAR file into my project. You might need to clean the project after doing this.