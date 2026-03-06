use std::cmp::Ordering;
use std::io;
use std::io::Write;

use rand::Rng;

fn main() {
    println!("Guess the number (UwU)!");
    let secret_number = rand::thread_rng().gen_range(1..=100);
    loop {
        print!("Please input your guess: ");
        io::stdout().flush().expect("Failed to flush stdout");

        let mut guess = String::new();

        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");

        if guess.trim().to_lowercase() == "quit" {
            println!("Goodbye! 👋");
            break;
        }

        println!("You guessed: {guess}");
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("Please type a number!");
                continue;
            }
        };

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win! Congratulations! 🎉");
                break;
            }
        }
    }
}
