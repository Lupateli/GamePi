// Este evento roda automaticamente quando uma animação chega ao fim
if (estado == "morte") {
    // 1. Para a velocidade de animação completamente
    image_speed = 0;
    
    // 2. Trava o personagem no ÚLTIMO FRAME (que é o índice 3 para 4 frames)
    image_index = 3;
    
    // 3. (Opcional) Você pode mudar a alpha para dar um efeito de fade out
    // image_alpha -= 0.01; // Coloque isso no Step, se quiser fade
}
// Evento Other > Animation End
if (estado == "ultimate") {
    sprite_index = spr_samuraiparado; // Volta para a animação parado
	estado = "idle";
    image_index = 0;
	image_speed = 0;
}

if (estado == "ataque") {
    estado = "idle";
    image_index = 0;
}