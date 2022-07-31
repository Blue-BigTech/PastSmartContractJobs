fn main() {
    let str: &str = "hello world";
    let mut string: String = String::from("Hello World");

    let slice = &string[.. 6];
    slice.len();

    string.push('l');
    string.push_str("! Bob");
    string = string.replace("Hello", "Bye");
    println!("{}", string);
}
