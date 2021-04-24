FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

# ffmpeg, ffprobe
# mediainfo
RUN apt-get update  && \
    apt-get install -y ffmpeg x264 x265 bc mediainfo

# mp4art, mp4chaps
RUN apt-get install -y wget                                   && \
    wget --quiet http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb && \
    wget --quiet http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb && \
    dpkg -i libmp4v2-2_2.0.0~dfsg0-6_amd64.deb                && \
    dpkg -i mp4v2-utils_2.0.0~dfsg0-6_amd64.deb               && \
    apt-get remove -y wget                                    && \
    apt-get autoremove -y

# cleanup
RUN apt-get autoclean -y  && \
    rm -rf /var/lib/apt/lists/*

# AAXtoMP3
ADD AAXtoMP3 /usr/local/bin/AAXtoMP3

CMD         ["--help"]
ENTRYPOINT  ["AAXtoMP3"]
