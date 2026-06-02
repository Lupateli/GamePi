draw_self();
draw_set_font(global.fonte_jogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle); // Texto no meio do botão

// 2. Cor
draw_set_color(c_white); // Você pode usar c_white, c_red, c_yellow, c_lime, c_black, etc.
 
var dados = obj_controlador.pergunta_atual_dados;
if (!is_undefined(dados)) {
    var alternativas = dados[$ "alternativas"];
    if (!is_undefined(alternativas) && indice < array_length(alternativas)) {
        draw_text_ext(x, y, alternativas[indice], -1, sprite_width - 45);
    }
}