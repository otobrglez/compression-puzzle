FROM ubuntu

RUN dpkg --add-architecture i386 && \
    apt-get update -yy && \
    apt-get install libc6:i386 libcurl4:i386 libgtk-3-0:i386 libgdk-pixbuf2.0-0:i386 wget -yy


RUN mkdir -p /rebol && \
    cd /rebol && \
    wget http://www.rebol.com/downloads/v278/rebol-core-278-4-3.tar.gz && \
    tar -xvzf *.tar* && \
    ln -s /rebol/releases/rebol-core/rebol /bin/rebol

RUN mkdir -p /red && \
    cd /red && \
    wget https://static.red-lang.org/dl/auto/linux/red-latest && \
    chmod +x /red/red-latest && \
    ln -s /red/red-latest /bin/red
