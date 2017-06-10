openjdk-hsdis
=============

OpenJDK disassembler plugin for HotSpot JVM (based on binutils)

    History
    -------
    Recent versions of HotSpot (including current builds of JDK8 and JDK7)
    can load a plug-in disassembler for diagnosing code quality.

    This plugin comes from actual OpenJDK source repository (and is based on binutils
            tools for disassembler).

    Why this repository ?
    ---------------------
    This is just a "repackaging" of original hsdis based on source code from
    http://hg.openjdk.java.net/jdk8u/jdk8u/hotspot/file/tip/src/share/tools/hsdis/

    Build Debian package
    --------------------
    + Download this version of hsdis:
    ```
    git clone git://github.com/ezzuodp/hsdis.git
    cd hsdis
    ```

    + Install build-dependencies
    ```
    sudo apt-get install build-essential 
    ```

    + Build package
    ```
    make all
    cp ./build/${os}-${arch}/hsdis-${arch}.so ${JAVA_HOME}/jre/lib
    ```

    + Install hsdis
    ```
    cp ./build/${os}-${arch}/hsdis-${arch}.so ${JAVA_HOME}/jre/lib
    ```

    Enjoy your disassembler
    -----------------------
    ```
    JAVA command line add option "-XX:+PrintAssembly".
    ```
