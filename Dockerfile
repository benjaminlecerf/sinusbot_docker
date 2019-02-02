#Docker unlimited Sinusbot instances
#Version: SinusBot Beta 0.14.0-be7bbc4
#Creator: https://www.sinusbot.com/
#Script Made By: Ralph
#Credits Qraktzyl

FROM ubuntu

#VOLUME ["/SinusBot"]

#Prerequisites
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install x11vnc xvfb libxcursor1 ca-certificates bzip2 libnss3 libegl1-mesa x11-xkb-utils libasound2 libglib2.0-0 curl wget python2.7 libssl-dev libffi-dev python-dev -y
RUN update-ca-certificates
RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+rx /usr/local/bin/youtube-dl
RUN mkdir /opt/ts3soundboard/

#Downloads
RUN cd /opt/ts3soundboard/ && wget https://www.sinusbot.com/pre/sinusbot-0.14.0-be7bbc4.tar.bz2
RUN cd /opt/ts3soundboard/ && wget http://dl.4players.de/ts/releases/3.1.9/TeamSpeak3-Client-linux_amd64-3.1.9.run

#Setting Up Files
ADD config.ini /opt/ts3soundboard/config.ini
RUN cd /opt/ts3soundboard/ && tar -xjvf sinusbot-0.14.0-be7bbc4.tar.bz2
RUN cd /opt/ts3soundboard/ && chmod 0755 TeamSpeak3-Client-linux_amd64-3.1.9.run
RUN sed -i 's/^MS_PrintLicense$//' /opt/ts3soundboard/TeamSpeak3-Client-linux_amd64-3.1.9.run
RUN cd /opt/ts3soundboard && ./TeamSpeak3-Client-linux_amd64-3.1.9.run
RUN cd /opt/ts3soundboard/ && rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so
RUN mkdir /opt/ts3soundboard/TeamSpeak3-Client-linux_amd64/plugins
RUN cd /opt/ts3soundboard/ && cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins/

#Adding Sinusbot User
RUN useradd -ms /bin/bash sinusbot
RUN chown -R sinusbot:sinusbot /opt/ts3soundboard
RUN su sinusbot

# Add a startup script
ADD run.sh /run.sh
RUN chmod 755 /*.sh

EXPOSE 8087
CMD ["/run.sh"]
