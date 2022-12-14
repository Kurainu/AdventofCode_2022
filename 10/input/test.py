def day10(filepath, draw_screen=False):
    with open(filepath) as fin:
        lines = [line.split() for line in fin.readlines()]
 
    signal = [1]
    add_x = 0
    for line in lines:
        if line[0] == 'noop':
            signal.append(signal[-1] + add_x)
            add_x = 0
        elif line[0] == 'addx':
            signal.append(signal[-1] + add_x)
            signal.append(signal[-1])
            add_x = int(line[1])
 
    if not draw_screen:
        strength = 0
        for i in [20, 60, 100, 140, 180, 220]:
            strength += i * signal[i]
        return strength
    else:
        screen = ''
        for i in range(len(signal)-1):
            if signal[i+1] - 1 <= i % 40 <= signal[i+1] + 1:
                screen += '#'
            else:
                screen += '.'
        print()
        for i in range(40,241,40):
            print(screen[i-40:i])
 
 
 
print(day10('F:\\AdventofCode_2022\\10\\input\\part1.example'))

# def main():
#     assert day10('test10') == 13140
#     print(day10('input10'))
 
#     day10('test10', True)
#     day10('input10', True)
 
 
# if __name__ == '__main__':
#     main()