## Module Explanations

### Top Capstone Module

The top capstone module connects all the subsystems together, managing the data flow from microphone input through FFT processing to the display. It also handles timing for audio sampling, FFT processing, and refreshing the display.

### Top VGA Module

The Top VGA module coordinates the display subsystem. It connects the VGA timing controller, graphics renderer, and frame buffers while managing all the interconnections needed to render the audio spectrum on screen.

### FFT Module

The FFT module transforms 16 audio samples into 16 frequency bins through four stages of butterfly operations. It is very math heavy and uses a state machine to progress through all stages of the data transformation.

### Butterfly Unit

The butterfly unit module is the building block for the FFT module. It's also very math heavy — essentially it combines two complex numbers using twiddle factors to extract frequency information. 

### Magnitude Module

The magnitude module is used to convert the complex output of the FFT into simple scalar values for visualization. 

### Microphone Module

The microphone module interfaces with an Analog-to-Digital Converter that converts analog microphone signals into digital samples. 

### Clock Divider

The clock divider allows different subsystems (audio sampling, FFT processing, display) to run at their required speeds from a single base clock by creating different clock signals.

### VGA Module

The VGA module handles low-level communication with the monitor by tracking pixel positions, generating pulses at the correct times, and only sending color during the active display period.

### Graphics Module

The graphics module divides the screen into 16 columns (one per frequency bin) and draws bars whose heights correspond to each frequency's magnitude. It also provides sensitivity adjustment via switches to control the visualization's responsiveness.

### Buffers Module

The buffers module implements double buffering in order to prevent screen flickering and ensures smooth transitions at the start of each new screen refresh.
