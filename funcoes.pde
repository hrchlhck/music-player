void menu() { //<>//
  // barra de cima
  textAlign(LEFT);
  fill(60); 
  rect(-1, 0, width+1, 55);

  fill(255);
  textSize(8.5);
  text("Pedro Horchulhack \n" + "2019 - " +year(), 450, 20);

  textSize(11);
  //botões
  if (tocando)
  {
    image(pausar, 20, 30);
  } else {
    image(play, 20, 30);
  }
  image(disquete, 70, 30); 

  //cria barra de informaçoes
  rectMode(CORNER); 
  fill(255); 
  rect(-1, 300, width+1, 100);
}

void texto()
{
  textAlign(LEFT);
  fill(0); 
  text("Música selecionada: " + Musica, 10, 330);

  fill(0); 
  text("Volume: " + som, 10, 350);

  fill(0); 
  text("Estado: " + estado, 10, 370);

  fill(0); 
  text("Tempo da música: " + tempoMusica / 60000 + " minutos", 10, 390);

  fill(0);
  text("Comandos:", 330, 330);

  fill(0);
  text("Seta para cima: silencia a música", 340, 350);

  fill(0);
  text("Seta para baixo: devolve o som à música", 340, 370);
}
void particulas()
{
  for (int w = 0; w < 600; w+= 10) {
    stroke(255);
    point(random(w+400), random(w+400));
  }
}

void fileSelected(File selection) {
  if (selection == null ) {
    println("Não houve a seleção de nenhum arquivo.");
  } else {

    origemMusica = selection.getPath();
    Musica = origemMusica.substring(origemMusica.lastIndexOf("\\") + 1);
    println("Você selecionou " + Musica);



    file_selected = true; 

    minim = new Minim(this);
    player = minim.loadFile(origemMusica, 2048);     
    fftLin = new FFT(player.bufferSize(), player.sampleRate());

    fftLin.linAverages(30);

    tempoMusica = player.length();
  }
}
// buttons
void mousePressed() {
  if ((mouseX > 50 && mouseX < 85) && (mouseY > 10 && mouseY < 50) && mouseButton == LEFT) {
    selectInput("Selecione um arquivo:", "fileSelected");
  }
  if (file_selected) {    
    if ((mouseX > 5 && mouseX < 40) && (mouseY > 10 && mouseY < 50) && mouseButton == LEFT)
    {
      // toggle
      tocando = !tocando;
    }
  } else if ((mouseX > 5 && mouseX < 50) && (mouseY > 10 && mouseY < 50)) {
    println("Não é possível realizar as operações pois nenhuma música foi selecionada.");
  }
}

// mute and unmute the song
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      mute = true;
    }
  }

  if (key == CODED)
  {
    if (keyCode == DOWN)
    {
      mute = false;
    }
  }
}

// creates the oscilator
void oscilador() {
  int i;

  fftLin.forward(player.mix);

  for (i = 0; i < fftLin.specSize(); i++)
  {

    stroke(i / 3, i, 255);
    line(i, 300, i, 300 - fftLin.getBand(i +10) * 5);
  }
}

// A line pass through the entire canvas horizontaly to show the time of the song
void tempo()
{
  float position = map(player.position(), 0, player.length(), 0, width);
  stroke(255, 0, 0); 
  line(position, 0, position, height + 55);
}
