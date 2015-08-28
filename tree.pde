//borrowed from processing examples (by Dan Shiffman)

void tree(float x, float y, float s) {
  pushMatrix();
  translate(x, y);
  //draw trunk;
  strokeWeight(s/10);
  stroke(100);
  strokeCap(PROJECT);
  line(0, 0, 0, -s);
  //move to the end of the trunk
  translate(0, -s);
  //start drawing branches
  branch(s);
  popMatrix();
}

void branch(float l) {
  l *= growth;
  if (l > 2) {

    //right branch (recursively draws more branches
    pushMatrix();
    pushStyle();
    strokeWeight(l/10);
    stroke(100);
    rotate(ang);
    line(0, 0, 0, -l);
    translate(0, -l);
    branch(l);
    popStyle();
    popMatrix();

    //left branch, does the same
    pushMatrix();
    pushStyle();
    strokeWeight(l/10);
    stroke(100);
    rotate(-ang);
    line(0, 0, 0, -l);
    translate(0, -l);
    branch(l);
    popStyle();
    popMatrix();
  }
}

