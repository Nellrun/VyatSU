/**
 * Created by Danill on 22.09.2016.
 */

import java.util.Arrays;
import java.util.Random;


public class Prime {

    /**
     * Функция для получения следующего простого числа после num
     * @param num любое натуральное число
     * @return Ближайшее  простое число, которое следует за num
     */
    private static int getNext(int num) {
        int i = num + 1;

        for(; !isPrime(i); i++) {}

        return i;
    }

    /**
     * Функция для генерации простого числа
     * @return Случайное простое число, которое находится между 0 и 99999999
     */
    public static int getRandomPrime() {
        Random r = new Random();
        return getNext(r.nextInt(999999999));
    }

    /**
     * Функция для проверки является ли число простым
     * @param n число, которое требудется проверить
     * @return true если число является простым и false если нет
     */
    private static boolean isPrime(int n) {
        for (int j = 2; j < Math.sqrt(n); j++) {
            if (n % j == 0) {
                return false;
            }
        }

        return true;
    }

    /**
     * Функция, которая возвращает отсортированный по возрастанию массив из простых чисел заданной длины
     * @param length Длина массива
     * @return отсортированный по возрастанию массив заполненный случайными чисоами
     */
    public static int[] getRandomArray(int length) {
        int[] arr = new int[length];

        for(int i = 0; i < length; i++) {
            arr[i] = getRandomPrime();
        }

        Arrays.sort(arr);

        return arr;
    }



}