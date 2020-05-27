FROM ubuntu:trusty

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git build-essential bison wget graphviz

RUN wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/flex/2.5.33-4/flex_2.5.33.orig.tar.gz && \
    tar xvf flex_2.5.33.orig.tar.gz && cd flex-2.5.33/ && ./configure && make && make install

# Doxygen
# ----
# Release-1.6.1 : eca519ca56a08923c07b999183fbd6f71627c68d # error: 'append' was not declared in this scope
# Release-1.6.2 : b16636fd4a4f817d489b6fdad72948d628f0e91f # error: 'append' was not declared in this scope
# Release-1.6.3 : 64617eab429b8f10443c1593182980b9aa34d001 # error: 'append' was not declared in this scope
# ----
# Release-1.7.0 : cd12af0a32d7ccaec5704a353b3655bb4e3c543d # error: 'append' was not declared in this scope
# Release-1.7.1 : 39f6f27c973162503764e379bf49b26f546fdf87 # error: 'append' was not declared in this scope
# Release-1.7.2 : 0d83fee12bc1ad4c6fd89892072225840703d373 # error: 'append' was not declared in this scope
# Release-1.7.3 : c96349d356703d8afc14a3ba703e42fdf6d40838 # error: 'append' was not declared in this scope
# Release-1.7.4 : e650cedae60f14e2021568205ad8f49c1fe21d1e
# Release-1.7.5 : 9ea9d701f13cd95a8feaec52dcd06892dacfb705 # patch FAILED
# Release-1.7.6 : b66f3a5bfb96a1441a36dd8e407679a39819a658 # patch FAILED
# ----
# Release-1.8.0?: e620712c9dd41c56bbd56d16a5a3469b96fafbf0 # patch FAILED
# Release-1.8.1 : c2a30cdda188a7a299e8b247d446b07ce93f026b # patch FAILED
# Release-1.8.2 : 037d5907c36d18ee1041acd336baddcaf9d5cd39 # patch FAILED
# ----

RUN git clone https://github.com/doxygen/doxygen && cd doxygen/ && git checkout e650cedae60f14e2021568205ad8f49c1fe21d1e && \
    wget http://www.normalesup.org/~fourmond/doxygen-ruby/ruby-doxygen-2.patch.gz && zcat ruby-doxygen-2.patch.gz | patch -p1 && \
    ./configure && make && make install

WORKDIR /src
CMD doxygen
