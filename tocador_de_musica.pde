import ddf.minim.*; //<>//
import ddf.minim.analysis.*;

void setup() {
  colorMode(RGB);
  size(600, 400);
  background(10);
  textAlign(CENTER);

  text("Por favor, selecione um arquivo de som.", width / 2, height / 2);

  play = loadImage("imagens/play.png"); 
  imageMode(CENTER);
  pausar = loadImage("imagens/pause.png"); 
  imageMode(CENTER);
  disquete = loadImage("imagens/disquete.png"); 
  imageMode(CENTER);

  estado = "Não iniciada";
  menu();
}

void draw()
{
  // println(mouseX + " : " + mouseY);

  // Delays the program until it loads the song file
  if (file_selected && musicaSelecionada == false) {
    musicaSelecionada = true;
    for (int i = 0; i < 70000; i++)
    {
      println(" i:" + i);
    }
  }

  // if file selected after that delay, run the rest
  if (musicaSelecionada == true) {
    background(10);
    particulas();

    oscilador();
    tempo();
    menu();
    texto();

    if (tocando)
    {
      estado = "Reproduzindo";
      player.play();
    } else {
      estado = "Música pausada.";
      player.pause();
    }

    if (mute)
    {
      som = "Música silenciada.";
      player.mute();
    } else {
      player.unmute();
      som = "Música com som.";
    }
  }
}
