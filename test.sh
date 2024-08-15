#!/bin/bash
gc() { 
	#git-commit one-liner
	git add -A && git commit -m "$1" 
}

gc "test" 
