draw_self();
draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle); // Texto no meio do botão

// 2. Cor
draw_set_color(c_white); // Você pode usar c_white, c_red, c_yellow, c_lime, c_black, etc.
 
var dados = obj_controlador.pergunta_atual_dados;
if (indice < array_length(dados.opcoes)) {
    draw_text(x, y, dados.opcoes[indice]);
}