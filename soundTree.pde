/*
A Processing Program to draw a simple L-System tree based on fft analysis of an audio file
 see - https://vimeo.com/137646134
 Copyright (C) 2015  Stephen Ball
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


Maxim maxim;
AudioPlayer loop;

//audio variables
boolean playing = false;
float[] powers = {
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
int bufferIndex = 0;

//tree variables
float ang;
float growth, tallness;


void setup() {
  //16:9 aspect
  size (960, 540);
  frameRate(24);
  background(255);
  
  //set up audio
  maxim = new Maxim(this);
  loop = maxim.loadFile("slowOct75bpm.wav");
  loop.setAnalysing(true);
  loop.volume(1);
  loop.cue(0);

  //set up tree
  ang = QUARTER_PI * 0.5;
  growth = 0.6;
  tallness = 100;
}

void draw() {
  if (playing) {
    float power = getRecentAverage();
    ang = map(power, 0.18, 0.25, PI + QUARTER_PI, PI + HALF_PI + QUARTER_PI);
    tallness = map(power, 0, 1, 200, height);
    growth = map(power, 0.18, 0.22, 0.6, 0.7);

    loop.play();
    background(255);
    //  tree(width * 0.25, height, tallness);
    tree(width * 0.35, height, tallness);
    //  tree(width * 0.75, height, tallness);
  } else {
    loop.stop();
  }
}


//function to return the moving average of the array
float getRecentAverage() {
  //store the fft power for this frame in the buffer
  powers[bufferIndex] = loop.getAveragePower();
  //advance the buffer index - it will wrap around and overwrite the oldest data first
  bufferIndex = (bufferIndex + 1) % powers.length;
  //work out the average by looping through the array
  float thisAverage = 0;
  for (int i = 0; i < powers.length; i++) {
    thisAverage = thisAverage + powers[i];
  }
  thisAverage = thisAverage/powers.length;
  //return it
  return thisAverage;
}

void keyPressed() {
  if (key ==' ') {
    playing = !playing;
  }
}


