// 1. Configurações de Texto
draw_set_font(fnt_jogo);
draw_set_halign(fa_center);
draw_set_valign(fa_top); // Importante resetar o alinhamento vertical

// 2. Enunciado da Pergunta (Seguro contra erros)
if (variable_instance_exists(id, "pergunta_atual_dados")) {
    var dados = pergunta_atual_dados;
    draw_set_color(c_black);
    draw_text_ext(room_width/2, 60, dados.enunciado, 25, 700);
}

// 3. Verificação de Segurança para as variáveis de vida
// Evita divisão por zero se vida_maxima ainda não existir ou for 0
var max_vida = (variable_instance_exists(id, "vida_maxima") && vida_maxima > 0) ? vida_maxima : 100;
// 1. Barras de Vida (Uso das variáveis corretas)
var perc_bom = (vida_bom / vida_maxima_bom) * 100;
var perc_mau = (vida_mau / vida_maxima_mau) * 100;

draw_healthbar(40, 20, 340, 45, perc_bom, c_black, c_red, c_lime, 0, true, true);
draw_healthbar(room_width-340, 20, room_width-40, 45, perc_mau, c_black, c_red, c_lime, 1, true, true);
// 5. Barra de Energia
draw_set_color(c_aqua);
// Garantimos que a barra não ultrapasse o tamanho máximo visual
var largura_energia = min(energia_bom * 3, 300); 
draw_rectangle(40, 50, 40 + largura_energia, 60, false);
draw_set_color(c_white);
draw_rectangle(40, 50, 340, 60, true);

// 6. RESET OBRIGATÓRIO (Evita que outros objetos fiquem desalinhados)
draw_set_halign(fa_left);
draw_set_valign(fa_top);