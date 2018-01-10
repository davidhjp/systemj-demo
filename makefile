SJVERSION=2.2
SJDK=sjdk-$(SJVERSION)
SJDK_PKG=systemj-$(SJVERSION).tgz

SYSJC=$(SJDK)/bin/sysjc --silence
SYSJR=$(SJDK)/bin/sysjr

ifeq ($(WINDIR),)
	S=:
else
	S=\;
endif

all: bin/bs

$(SJDK):
	wget https://github.com/hjparker/systemj-release/releases/download/$(SJVERSION)/$(SJDK_PKG) ;\
		tar xaf $(SJDK_PKG)

# Build targets
bin/%: src/%.sysj $(SJDK)
	CLASSPATH=java $(SYSJC) -d $@ $<

# Run targets
%: bin/%
	CLASSPATH=$<$(S)java sysjr lcf/$@.xml

clean:
	rm -rf $(SJDK) bin $(SJDK_PKG)
