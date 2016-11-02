import prime
import optparse

def interact():
    k = 1
    while k != 0:
        print("1) Получить случайное простое число")
        print("2) Получить массив простых чисел")
        print("0) Выход")

        s = input("Ответ: ")
        if s.isdigit():
            k = int(s)
        else:
            print("Неверный ввод")
            continue

        if k == 1:
            print(prime.getRandomPrime())
        elif k == 2:
            s = input("Введите длину массива: ")
            if s.isdigit():
                length = int(s)
            else:
                print("Неверный ввод")
                continue

            if length > 0:
                print(prime.getRandomArray(length))
            else:
                print("Неверный диапазон")


opt = optparse.OptionParser('Lанная программа позволяет получить простые числа. Для справки используйте -h')

opt.add_option("-n", "--number", dest="count", type="int", help="количество чисел")
opt.add_option("-c", "--check", dest="check", type="int", help="проверить число на простоту")
opt.add_option("-a", "--after", dest="after", type="int", help="вернуть простое число, которое следует после")
opt.add_option("-i", "--interactive", action="store_true", dest="interact", help="войти в интерактивный режим")

opt.set_defaults(interact = False)

(options, args) = opt.parse_args()

if (not options):
    opt.print_usage()
    exit(0)

if (options.count != None) and (options.count > 0):
    print(", ".join(map(str, prime.getRandomArray(options.count))))

if (options.check != None) and (options.check > 1):
    print(prime.isPrime(options.check))

if (options.after != None) and (options.after > 1):
    print(prime.getNext(options.after))

if (options.interact):
    interact()
