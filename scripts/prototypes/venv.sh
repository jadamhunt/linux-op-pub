#!/bin/bash

PWD=$(pwd |rev | cut -d'/' -f 1 | rev)
echo $PWD

virtualenv $PWD
