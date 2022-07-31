fn main() {
    let n = 3;
    if n > 0 {
        println!("greater than 0");
    } else if n < 0 {
        println!("less than 0");
    } else {
        println!("is 0");
    }

    for i in 0..6 {
        println!("{}", i);//0 1 2 3 4 5
    }

    let mut i = 0;
    while i < 4 {
        println!("{}", i);
        i += 1;
        if i == 3 {
            println!("exit");
            break;
            // continue;
        }
    }

    let i = 5;
    match i {
        0 => println!("0"),
        1 | 2 => println!("1,2"),
        3..=4 => println("3,4"),
        _ => println!("default")
    }
}
