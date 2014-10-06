//Boot the server.  Remember ugens run on the server
s.boot;

a = {MouseX.kr().poll}.play;
a.free;
b = {MouseY.kr().poll}.play;
b.free;
/*
These ugens come with built in functions that allow you to manipulate the data comming from the mouse directly in the ugen.  The first two arguments in MouseX/Y allow you to map the mouse movement to a range of your choice:
*/
a = {MouseX.kr(minval:-500, maxval:859).poll}.play;
a.free;
/*
An additional argument allows you to apply a curve to the mouse data:
*/
b = {MouseY.kr(minval:20, maxval:20000,warp:1).poll}.play;
b.free;
/*
Finally, the mouse ugens come with a smoothing function to allow better interaction with audio rate ugens.  The lag argument controls the smoothing time, with bigger numbers giving greater smoothness but introducing a delay while smaller times give less delay but less time to smooth.
*/
b = {MouseY.kr(lag:3).poll}.play;
b.free;

/*
The MouseButton.kr ugen tracks the state of the mouse button.  It usually gives a 1 when pressed or 0 when not pressed but these can be adjusted with arguments.  Notice also the lag argument and its impact.
*/
a = {MouseButton.kr().poll}.play;
a.free;

a = {MouseButton.kr(minval:-500, maxval:500, lag:4).poll}.play;
a.free;

/*
USAGE
The mouseX/Y ugens can be used to modulate just about any argument in most ugens.
*/

//MouseX moduleates the frequency of the sawtooth wave between 200 and 5000 hz
a = { Saw.ar( freq:MouseX.kr(minval:200, maxval:5000, warp:1, lag:0.05) ) }.play;
a.free;

//MouseY modulates the frequency of a low pass filter between 80 and 10,000 hz
a = { LPF.ar( in:WhiteNoise.ar(), freq:MouseY.kr(minval:80, maxval:10000, warp:1) )}.play;
a.free;

/*
TESTING
MouseX/Y are also an excelent way to test the different arguments in ugens to see how they sound
*/

//Using MouseX to explore how the the mysterious formfreq or formant frequency sounds/works in the Formant ugen
a = { Formant.ar( fundfreq:300, formfreq:MouseX.kr(80, 5000) ) }.play;
a.free;

//How would you describe the effect of formfreq?  What is a good range?

//The Gendy ugens have unpredictable behaviors
a = { Gendy3.ar( ampdist:MouseX.kr(0, 7), durdist:MouseY.kr(0, 7), mul:0.2) }.play
a.free;
//Try some different ranges (be careful to keep the volume down initially as Gendy can behave unpredictabally)


/*
MOUSE BUTTON EXAMPLES
Since the mousebutton uben by default gives out a 1 or 0 it is handy to be used as a trigger often for envelopes:
*/
a = { LFTri.ar(MouseX.kr(minval:100, maxval:1000, warp:1, lag:0.01))*EnvGen.ar( envelope:Env.asr(attackTime:0.01, level:0.5, releaseTime:0.3, curve:-2), gate:MouseButton.kr(lag:0.001)) }.play;
a.free;

//Because we are using the asr envelope a 1 in the gate argument of the EnvGen ugen begins the envelope and a 0 releases it.

/*
You can use the K2A.ar ugen to convert any control signal to an audio signal.  In the following example I convert the MouseButton signal to audio rate to be used as an impulse to articulate a resonant filter.
*/
a = { Ringz.ar( K2A.ar(MouseButton.kr()), MouseY.kr(3000, 100), 2) }.play
a.free;


