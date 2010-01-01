
CC=g++
JAR=jar
JAVAC=javac

ICE_HOME=/opt/Ice-3.3
SERVER=target/bitserver
SLICE=slice/BitServer.ice
GENERATED_H=target/generated/BitServer.h
GENERATED_CXX=target/generated/BitServer.cpp
SERVER_H=server/BitServerI.h
SERVER_CXX=server/BitServerI.cpp
CXXFLAGS=-g -I$(ICE_HOME)/include -Itarget/generated/ -Iserver/
LDFLAGS=-L$(ICE_HOME)/lib -lIce -lIceUtil -Wl,--rpath=$(ICE_HOME)/lib

CLIENT=target/bitclient.jar
CLIENT_JAVA=client/renren/BitServerAdapter.java
CLIENT_CLASS=target/classes/renren/BitServerAdapter.class
GENERATED_JAVA=target/generated/renren/BitServer.java
GENERATED_CLASS=target/classes/renren/BitServerPrx.class

all: $(SERVER) $(CLIENT)

$(SERVER) : $(SERVER_CXX) $(SERVER_H) $(GENERATED_CXX) $(GENERATED_H)
	$(CC) $(CXXFLAGS) $(LDFLAGS) -o $(SERVER) $(SERVER_CXX) $(GENERATED_CXX)

$(GENERATED_H) : $(SLICE)
	if [ ! -d target/generated ]; then mkdir -p target/generated; fi
	$(ICE_HOME)/bin/slice2cpp -I$(ICE_HOME)/slice --output-dir=target/generated/ $^

$(GENERATED_CXX) : $(SLICE)
	if [ ! -d target/generated ]; then mkdir -p target/generated; fi
	$(ICE_HOME)/bin/slice2cpp -I$(ICE_HOME)/slice --output-dir=target/generated/ $^

$(CLIENT) : $(CLIENT_CLASS)
	$(JAR) cvf $@ -C target/classes .

$(GENERATED_CLASS) : $(GENERATED_JAVA)
	if [ ! -d target/classes ]; then mkdir -p target/classes/; fi
	$(JAVAC) -sourcepath target/generated/ -d target/classes/ -cp $(ICE_HOME)/lib/Ice.jar target/generated/renren/*.java

$(CLIENT_CLASS) : $(CLIENT_JAVA) $(GENERATED_CLASS)
	if [ ! -d target/classes ]; then mkdir -p target/classes/; fi
	$(JAVAC) -sourcepath client/ -d target/classes/ -cp $(ICE_HOME)/lib/Ice.jar:target/classes/ $<

$(GENERATED_JAVA) : $(SLICE)
	if [ ! -d target/generated ]; then mkdir -p target/generated; fi
	$(ICE_HOME)/bin/slice2java -I$(ICE_HOME)/slice --output-dir=target/generated/ $^

.PHONY clean:
	rm -rf target


