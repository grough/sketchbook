import controlP5.*;

class GUI extends ControlP5 {
  GUI (PApplet sketch) {
    super(sketch);

    Group g1 = this.addGroup("g1")
      .setPosition(15, 15)
      //.setBackgroundHeight(100)
      ;

    this.addSlider("start")
      .setPosition(10, 10)
      .setSize(sketch.width / 2, 9)
      .setRange(0, 5)
      .setValue(0)
      .setGroup(g1)

      ;

    this.addSlider("rotations")
      .setPosition(10, 20)
      .setSize(sketch.width / 2, 9)
      .setRange(0, 8)
      .setValue(1.5)
      .setGroup(g1)

      ;

    this.addSlider("hue")
      .setPosition(10, 30)
      .setSize(sketch.width / 2, 9)
      .setRange(0, 1)
      .setValue(1)
      .setGroup(g1)

      ;

    this.addSlider("gamma")
      .setPosition(10, 40)
      .setSize(sketch.width / 2, 9)
      .setRange(0, 10)
      .setValue(1)
      .setGroup(g1)

      ;

    this.addSlider("colors")
      .setPosition(10, 50)
      .setSize(sketch.width / 2, 9)
      .setRange(0, 32)
      .setValue(16)
      .setGroup(g1)

      ;
  }
}
