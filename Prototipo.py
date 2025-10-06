from machine import Pin
from time import sleep

# --- CONFIGURAÇÃO DO BUZZER ---
# Altere este número para o pino GPIO onde você conectou o buzzer
BUZZER_PIN = 25 
buzzer = Pin(BUZZER_PIN, Pin.OUT)


# --- CONFIGURAÇÃO DO TECLADO ---
# Define o layout do teclado
KEYS = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['*', '0', '#']
]

# Define os pinos GPIO conectados às linhas e colunas do teclado
ROW_PINS = [2, 15, 19, 21]
COL_PINS = [5, 4, 18]

# Configura os pinos das linhas como SAÍDA (OUT)
row_pins = [Pin(pin_name, Pin.OUT) for pin_name in ROW_PINS]

# Configura os pinos das colunas como ENTRADA (IN) com resistor de pull-up
col_pins = [Pin(pin_name, Pin.IN, Pin.PULL_UP) for pin_name in COL_PINS]


# Função para verificar qual tecla foi pressionada
def scan_keypad():
    for r_idx, row_pin in enumerate(row_pins):
        # Ativa uma linha de cada vez, enviando um sinal BAIXO (0V)
        row_pin.value(0)
        
        # Verifica todas as colunas
        for c_idx, col_pin in enumerate(col_pins):
            if col_pin.value() == 0:  # Tecla pressionada
                sleep(0.05) # Debounce
                while col_pin.value() == 0:
                    pass # Espera a tecla ser solta
                return KEYS[r_idx][c_idx]
        
        # Desativa a linha
        row_pin.value(1)
        
    return None # Nenhuma tecla foi pressionada


# --- LOOP PRINCIPAL ---
print("ESP32 pronto! Pressione uma tecla para ouvir o buzzer.")
while True:
    key = scan_keypad()
    
    # Se uma tecla foi detectada...
    if key:
        print("Tecla Pressionada:", key)
        
        # --- FAZ O BUZZER APITAR ---
        buzzer.on()     # Liga o buzzer
        sleep(0.05)     # Espera 50 milissegundos (duração do apito)
        buzzer.off()    # Desliga o buzzer
        
    sleep(0.1)