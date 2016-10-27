import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.Arrays;

/**
 * Created by Danill on 06.10.2016.
 */

public class Gui extends JFrame {

    private JButton randPrimeBut = new JButton("Получить простое число");
    private JButton randPrimeArrayBut = new JButton("Получить массив простых чисел");

    public Gui() {
        super("Лабораторная работа №3");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setSize(250, 150);

        this.setResizable(false);

        Container content = this.getContentPane();


//        content.setLayout();
        content.setLayout(new GridLayout(0, 1, 10, 10));
        content.add(randPrimeBut);
        content.add(randPrimeArrayBut);

        randPrimeArrayBut.addActionListener(new OnRandPrimeArrayButClick());
        randPrimeBut.addActionListener(new OnRandPrimeButClick());
    }

    class OnRandPrimeArrayButClick implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            String v = JOptionPane.showInputDialog("Введите размер массива (от 1 до 15):");

            try {
                int length = Integer.valueOf(v);
                if ( (length < 1) || (length > 15) ) {
                    throw new NumberFormatException();
                }
                JOptionPane.showMessageDialog(null, Arrays.toString(Prime.getRandomArray(length)));
            } catch (NumberFormatException except) {
                JOptionPane.showMessageDialog(null, "Введен неверный параметр");
            }
        }
    }

    class OnRandPrimeButClick implements  ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            JOptionPane.showMessageDialog(null, String.valueOf(Prime.getRandomPrime()));
        }
    }
}
