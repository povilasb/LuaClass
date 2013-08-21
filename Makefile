LUA = lua

all: help

help:
	@echo ""
	@echo "Possible rules:"
	@echo "\thelp - prints this help."
	@echo "\tBasicSample - executes basic sample."
	@echo ""

BasicSample:
	$(LUA) samples/$@.lua


.PHONY: all BasicSample
