# Photodiode
Photodiode based radiation detector. First batch of boards built and tested some time ago.

Based on Elektor's published design but modified to use SMD components and a range of
photodiodes.

Current code is somewhat suboptimal as it polls the ADC continuously. Moving to a more interrupt-driven
approach would be sensible as it would allow sensor code to coexist with other code. Testing so far was done with a Chipkit Max32.

The use of multiple photodiodes for coincidence counting is also a possibility.
