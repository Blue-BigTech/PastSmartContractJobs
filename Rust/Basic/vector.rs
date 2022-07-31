fn main() {
    let vec: Vec<i64> = vec![1,2,3,4,5];
    vec.len();
    vec[0];
    vec.push(6);
    vec.remove(0);
    println!("{:?}", vec);
}