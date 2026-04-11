draw_set_font(Font1);
draw_set_halign(fa_center);

// 1. Enunciado da Pergunta
var dados = pergunta_atual_dados;
draw_set_color(c_black);
draw_text_ext(room_width/2, 60, dados.enunciado, 25, 700);

// 2. Barras de Vida (Y = 20)
var perc_bom = (vida_bom / vida_maxima) * 100;
var perc_mau = (vida_mau / vida_maxima) * 100;

draw_healthbar(40, 20, 340, 45, perc_bom, c_black, c_red, c_lime, 0, true, true);
draw_healthbar(room_width-340, 20, room_width-40, 45, perc_mau, c_black, c_red, c_lime, 1, true, true);

// 3. Barra de Energia (Logo abaixo da vida do herói)
draw_set_color(c_aqua);
draw_rectangle(40, 50, 40 + (energia_bom * 3), 60, false);
draw_set_color(c_white);
draw_rectangle(40, 50, 340, 60, true);