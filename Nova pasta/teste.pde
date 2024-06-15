String[] nomes = {"Mercúrio", "Vênus", "Terra", "Marte", "Júpiter"};
float[] diametros = {0.004879, 0.012104, 0.012742, 0.006779, 0.142984};

void setup() {
  size(800, 400);  // Aumentei o tamanho para melhor visualização
  textAlign(CENTER, CENTER);  // Alinhamento central do texto
  fill(0);  // Cor do texto
}

void draw() {
  background(255);
  translate(width / 2, height / 2);  // Translada a origem para o centro da tela
  for (int i = 0; i < nomes.length; i++) {
    pushMatrix();
    float angle = map(i, 0, nomes.length, 0, TWO_PI);  // Calcula o ângulo para cada texto
    rotate(angle);  // Rotaciona o texto pelo ângulo calculado
    text(nomes[i] + ": " + diametros[i] + " milhões de km", 200, 0);  // Desenha o texto
    popMatrix();
  }
  text("FPS: " + nf(frameRate, 0, 2), 0, height / 2 - 20);  // Desenha o FPS sem rotação
}
