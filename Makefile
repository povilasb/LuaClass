LUA = lua

all: help

help:
	@echo ""
	@echo "Possible rules:"
	@echo "\thelp - prints this help."
	@echo "\tBasicSample - executes basic sample."
	@echo "\tConstructor - executes sample that demonstrates constructor \
use."
	@echo ""

BasicSample:
	$(LUA) samples/$@.lua


Constructor:
	$(LUA) samples/$@.lua


Super:
	$(LUA) samples/$@.lua


.PHONY: all BasicSample Constructor
