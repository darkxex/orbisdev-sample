ifndef ORBISDEV
$(error ORBISDEV, is not set)
endif

target ?= ps4_elf_sce
TargetFile=homebrew.elf

include $(ORBISDEV)/make/ps4sdk.mk
LinkerFlags+=  -lkernel_stub  -lSceLibcInternal_stub  -lSceSysmodule_stub -lSceSystemService_stub -lSceNet_stub -lSceUserService_stub -lScePigletv2VSH_stub -lSceVideoOut_stub -lSceGnmDriver_stub -lorbisGl2 -lorbis -lScePad_stub -lSceAudioOut_stub -lSceIme_stub  
CompilerFlags +=-D__PS4__ -D__ORBIS__
IncludePath += -I$(ORBISDEV)/include -I$(ORBISDEV)/usr/include/c++/v1 -I$(ORBISDEV)/usr/include/orbis
AUTH_INFO = 000000000000000000000000001C004000FF000000000080000000000000000000000000000000000000008000400040000000000000008000000000000000080040FFFF000000F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

install:
	@cp $(OutPath)/homebrew.self /usr/local/orbisdev/git/ps4sh/bin/hostapp
	@echo "Installed!"
oelf:
	touch liborbis.elf
	@rm liborbis.elf
	orbis-elf-create bin/homebrew.elf bin/homebrew.oelf
pkg:
	cp liborbis.elf /Users/bigboss/Downloads/sce/orbisdev505/tauon/sample/orbislinknfs/liborbis/bin/
eboot:
	python $(PS4SDK)/bin/make_fself.py --auth-info $(AUTH_INFO) bin/homebrew.oelf bin/homebrew.self
