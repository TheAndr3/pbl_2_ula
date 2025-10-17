# 🧮 Calculadora RPN com FPGA

## 📋 Descrição do Projeto

Este projeto implementa uma **calculadora RPN (Reverse Polish Notation)** completa usando FPGA, desenvolvida em Verilog com implementação puramente estrutural. A calculadora suporta operações aritméticas e lógicas básicas com exibição em múltiplas bases numéricas.

## ✨ Características Principais

- **Sistema RPN**: Implementação de notação polonesa reversa
- **Operações Suportadas**: Soma, subtração, multiplicação, divisão, AND, OR, XOR, NOT
- **Múltiplas Bases**: Exibição em decimal, hexadecimal e octal
- **Interface Intuitiva**: LEDs indicadores de estado e displays de 7 segmentos
- **Arquitetura Estruturada**: Implementação 100% estrutural em Verilog

## 🎯 Funcionalidades

### Operações Aritméticas
- **Soma (000)**: A + B
- **Subtração (001)**: A - B  
- **Multiplicação (010)**: A × B
- **Divisão (011)**: A ÷ B

### Operações Lógicas
- **AND (100)**: A AND B
- **OR (101)**: A OR B
- **XOR (110)**: A XOR B
- **NOT (111)**: NOT A

### Sistemas de Numeração
- **Decimal**: Base 10
- **Hexadecimal**: Base 16
- **Octal**: Base 8

## 🎮 Como Usar

### Entrada de Dados
1. **SW[7:0]**: Entrada do número (8 bits)
2. **SW[9:8]**: Seleção da base de exibição
   - `00`: Decimal
   - `01`: Hexadecimal  
   - `10`: Octal

### Controles
- **KEY[0]**: Push na pilha (ativo baixo)
- **KEY[1]**: Executar operação (ativo baixo)

### Fluxo de Operação RPN
1. **Estado 00**: Digite o primeiro número (A) e pressione KEY[0]
2. **Estado 01**: Digite o segundo número (B) e pressione KEY[0]
3. **Estado 10**: Digite o código da operação (000-111) e pressione KEY[0]
4. **Estado 11**: A operação é executada automaticamente

### Indicadores Visuais
- **LEDR[2]**: Flag Zero
- **LEDR[3]**: Flag Overflow
- **LEDR[4]**: Flag Carry Out
- **LEDR[5]**: Flag Erro
- **LEDR[6]**: Estado A (entrada primeiro número)
- **LEDR[7]**: Estado B (entrada segundo número)
- **LEDR[8]**: Estado Operação (entrada código)
- **LEDR[9]**: Estado Executar (processamento)

### Displays
- **HEX0-HEX2**: Exibição do resultado (unidade, dezena, centena)
- **HEX5**: Indicador da base selecionada (d/h/o)

## 🏗️ Arquitetura do Sistema

### Módulos Principais

```
calculadora_rpn_completa.v (Top-level)
├── sistema_rpn_completo.v (Sistema RPN)
│   ├── contador_push_2bits.v (Contador de estados)
│   ├── registrador_8bits.v (Registradores A, B, OP)
│   └── ula_8bits.v (Unidade Lógica Aritmética)
│       ├── somador_8bits.v
│       ├── subtrator_8bits.v
│       ├── multiplicador_8x8_recursivo.v
│       ├── divisao_5por4.v
│       ├── unidade_and_8bits.v
│       ├── unidade_or_8bits.v
│       ├── unidade_xor_8bits.v
│       └── unidade_not_8bits.v
├── conversor_bases.v (Conversão de bases)
│   ├── bin_to_bcd_8bit_v3.v
│   └── decodificador_7seg.v
└── base_7seg.v (Display da base)
```

### Primitivas Utilizadas
- **full_adder.v**: Somador completo
- **half_adder.v**: Meio somador
- **flip_flop_d.v**: Flip-flop tipo D
- **mux_2_para_1.v**: Multiplexador 2:1
- **mux_4_para_1.v**: Multiplexador 4:1
- **mux_8_para_1.v**: Multiplexador 8:1

## 🔧 Configuração do Projeto

### Requisitos
- **Quartus Prime**: Software de desenvolvimento FPGA
- **Placa FPGA**: Compatível com MAX 10 ou similar
- **Pinos de I/O**: Conforme especificado no arquivo `PBL1.qsf`

### Compilação
1. Abra o projeto `PBL1.qpf` no Quartus Prime
2. Execute a compilação completa (Ctrl+L)
3. Configure a placa FPGA
4. Carregue o arquivo `.sof` na placa

### Estrutura de Arquivos
```
projeto/
├── calculadora_rpn_completa.v    # Módulo principal
├── sistema_rpn_completo.v        # Sistema RPN
├── ula_8bits.v                   # ULA principal
├── contador_push_2bits.v         # Contador de estados
├── registrador_8bits.v           # Registradores
├── conversor_bases.v             # Conversão de bases
├── base_7seg.v                   # Display da base
├── decodificador_7seg.v          # Decodificador 7 segmentos
├── bin_to_bcd_8bit_v3.v         # Conversor BCD
├── somador_8bits.v               # Somador
├── subtrator_8bits.v             # Subtrator
├── multiplicador_8x8_recursivo.v # Multiplicador
├── divisao_5por4.v               # Divisor
├── unidade_and_8bits.v           # Operação AND
├── unidade_or_8bits.v            # Operação OR
├── unidade_xor_8bits.v           # Operação XOR
├── unidade_not_8bits.v           # Operação NOT
├── full_adder.v                  # Full adder
├── half_adder.v                  # Half adder
├── flip_flop_d.v                 # Flip-flop D
├── mux_2_para_1.v                # MUX 2:1
├── mux_4_para_1.v                # MUX 4:1
├── mux_8_para_1.v                # MUX 8:1
├── mux_2_para_1_8bits.v          # MUX 2:1 8 bits
├── mux_4_para_1_4bits.v          # MUX 4:1 4 bits
├── mux_4_para_1_7bits.v          # MUX 4:1 7 bits
├── mux_8_para_1_8bits.v          # MUX 8:1 8 bits
├── multiplicador_4x4.v           # Multiplicador 4x4
├── PBL1.qpf                      # Projeto Quartus
├── PBL1.qsf                      # Settings Quartus
└── PBL1.qws                      # Workspace Quartus
```

## 📊 Especificações Técnicas

### Entradas
- **SW[9:0]**: 10 chaves de entrada
- **KEY[1:0]**: 2 botões de controle
- **CLOCK_50**: Clock de 50 MHz

### Saídas
- **HEX[6:0]**: 6 displays de 7 segmentos
- **LEDR[9:0]**: 10 LEDs indicadores

### Largura de Dados
- **8 bits**: Números de entrada e resultado
- **16 bits**: Resultado da multiplicação (overflow detectado)

## 🐛 Tratamento de Erros

- **Divisão por zero**: Flag de erro ativada
- **Overflow**: Detectado em operações aritméticas
- **Resultado zero**: Flag zero ativada
- **Carry out**: Detectado em somas

## 🎓 Conceitos Implementados

### RPN (Reverse Polish Notation)
A notação polonesa reversa elimina a necessidade de parênteses, onde os operadores seguem os operandos.

**Exemplo**: `3 + 4` → `3 4 +`

### Implementação Estrutural
Todo o projeto foi desenvolvido usando apenas primitivas básicas:
- Portas lógicas (AND, OR, NOT, XOR)
- Flip-flops
- Multiplexadores
- Somadores

### Máquina de Estados
O sistema implementa uma máquina de estados para controlar o fluxo RPN:
- **Estado 00**: Entrada do primeiro operando
- **Estado 01**: Entrada do segundo operando  
- **Estado 10**: Entrada da operação
- **Estado 11**: Execução e reset

## 📈 Exemplos de Uso

### Exemplo 1: Soma Simples
```
Entrada: 5 + 3
1. Digite 5, pressione KEY[0] (Estado A)
2. Digite 3, pressione KEY[0] (Estado B)  
3. Digite 000, pressione KEY[0] (Soma)
4. Resultado: 8
```

### Exemplo 2: Operação Lógica
```
Entrada: 15 AND 7
1. Digite 15, pressione KEY[0]
2. Digite 7, pressione KEY[0]
3. Digite 100, pressione KEY[0] (AND)
4. Resultado: 7 (em binário: 1111 AND 0111 = 0111)
```

## 🔄 Histórico de Versões

- **v1.0**: Implementação básica da calculadora RPN
- **v1.1**: Adição de múltiplas bases numéricas
- **v1.2**: Otimização da arquitetura estrutural
- **v1.3**: Limpeza e organização do projeto

## 👥 Autores

Projeto desenvolvido para a disciplina de **TEC498 - Sistemas Digitais**.

## 📄 Licença

Este projeto é destinado para fins educacionais e acadêmicos.

---

**Desenvolvido com ❤️ usando Verilog e FPGA**
