fn main() {
    let arr = [0,1,2,3];
    let slice = &arr[1 .. 3];
    borroing_slice(arr, slice);
}

fn borroing_slice(arr: [u8; 6], slice: &[u8]) {
    println!("{:?}", arr);
    println!("{:?}", slice);
}