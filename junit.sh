#!/bin/bash

javac $1.java

java org.junit.runner.JUnitCore $1
