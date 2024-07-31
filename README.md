# Library Management Leo (LML)


Ось код без коментарів. код з коменталями у файлі .leo

{

    program library_management_kx0d8ki.aleo {
    struct Book {
        id: u32,
        title: string,
        author: string,
        borrowed: bool,
    }

    mapping books: {
        key: u32,
        value: Book
    }

    mapping next_id: {
        key: u32,
        value: u32
    }

    transition add_book(title: string, author: string) -> u32 {
        let id: u32 = get_or_use next_id[0u32] 1u32;
        let book: Book = Book { id, title, author, borrowed: false };
        set book into books[id];
        let next_id_value: u32 = id + 1u32;
        set next_id_value into next_id[0u32];
        return id;
    }

    transition delete_book(book_id: u32) {
        let book: Book = get books[book_id];
        assert book.borrowed == false;
        remove books[book_id];
    }

    transition borrow_book(book_id: u32) {
        let book: Book = get books[book_id];
        assert book.borrowed == false;
        let borrowed_book: Book = Book { id: book.id, title: book.title, author: book.author, borrowed: true };
        set borrowed_book into books[book_id];
    }

    transition return_book(book_id: u32) {
        let book: Book = get books[book_id];
        assert book.borrowed == true;
        let returned_book: Book = Book { id: book.id, title: book.title, author: book.author, borrowed: false };
        set returned_book into books[book_id];
    }
}


/////////////
про программу:
Програма Library Management на Leo створена для керування бібліотекою, надаючи можливість додавати, видаляти, позичати та повертати книги. 

Програма налічує в собі 4 функції, основними є add_book, delete_book.

Програма Library Management на мові Leo є ефективним інструментом для управління бібліотечними ресурсами, дозволяючи автоматизувати процеси додавання, видалення та керування станом книг, що сприяє зручному та ефективному використанню бібліотечних фондів.


Офіційний сайт https://www.aleo.org/ Leo: https://leo-lang.org/ Discord https://discord.gg/aleohq Twitter https://twitter.com/AleoHQ GitHub https://github.com/AleoHQ
