# Beam Focusing Through Back Propagation

## Introduction

This repository contains MATLAB scripts (and live scripts) which performs a simulation for beam forming in the Terahertz spectrum. Essentially, the method employed here is the Angular Spectrum Method (ASM), which propagates a wave by taking the Fouerier Transform of it and propagating the components of each individual frequency.

The work of which has been published in the following paper: [Spot Focusing Coma Correction by Linearly Polarized Dual-Transmitarray Antenna in the Terahertz Region](https://ieeexplore.ieee.org/document/10189182).

## Overview

### Usage

To use this, download the whole repository and each script can be ran as long as the functions are in the same folder as the scripts. 

### Functions

There are two MATLAB functions written which performs the backpropagation. The file **propTF.m** performs a forward propagation of an initial, defined field at the aperture/antenna plane, while the file **backpropTF.m** performs a backpropagation of a field at the focal plane.
