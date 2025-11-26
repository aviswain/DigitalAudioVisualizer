# Digital Audio Visualizer
Forget the days when you couldn't see your music. Introducing my real-time, FFT-powered audio visualizer that transforms your microphone input into a live frequency-domain light show on VGA (because who needs expensive pre-built visualizers when you can build your own from scratch in SystemVerilog?). In all seriousness, this was one of the most fun and technically challenging projects I worked on, combining digital signal processing, FPGA hardware design, and real-time graphics to create something that actually works end-to-end.

![A video of me playing Define by Dom Dolla next to the audio visualizer](demo.gif)

*(If you are curious, the song I'm playing is Define by Dom Dolla)*

## Overall Architecture

```
Top Capstone Module (top_capstone.sv)
│
├── Microphone Module (microphone.sv)
│   └── ADC (external hardware)
│
├── Clock Divider (clock_divider.sv)
│
├── FFT Module (fft.sv)
│   └── Butterfly Unit (butterfly_unit.sv) [8 instances]
│
├── Magnitude Module (magnitude.sv)
│
└── Top VGA Module (top_vga.sv)
    ├── VGA Module (vga.sv)
    ├── Graphics Module (graphics.sv)
    └── Buffers Module (buffers.sv)
```

Apart from the source files I wrote, this project requires several pieces of technologies to work properly. The system runs on an FPGA (specifically Intel's DE10-Lite board) which provides the parallel processing capabilities needed for real-time FFT computation and VGA display generation. Audio input is captured through a microphone connected to the board's built-in ADC, and the system output requires a standard VGA monitor to display the visualization. Development was done using Intel Quartus Prime for synthesis, place-and-route, and programming the FPGA, while Questa Sim was used for RTL simulation and debugging. And of course, good music is essential since the visualizer won't work with bad music 😂.

## Fun parts about working on a team

While much of my growth was technical, this project also strengthened the friendships I had with my partners. We spent hours in the IEEE lab thinking, talking, and implementing, and were able to balance the stress with laughter and shared meals.

Some highlights:

- 🌙 Late-night lab sessions in the IEEE lab, debugging FFT stages and VGA timing while brainstorming solutions
- 🌯 Conversations while eating international food on the lawn at Ronald Reagan Hospital
- 🏗️ Thoughts about working on an offshore oil rig if nothing works out for us — joking about future careers and imagining life on the rigs
- 🤭 Turning frustrating bugs into inside jokes and shared memories 
- 👏 Collaborative problem-solving — hours spent whiteboarding, discussing trade-offs, and iterating on designs together

It was a great time.


