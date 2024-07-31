// Програма для керування бібліотекою
program library_management {

    // Структура для зберігання інформації про книгу
    struct Book {
        id: u32,
        title: string,
        author: string,
        is_borrowed: bool
    }

    // Перелік книг
    mapping books: u32 => Book;

    // Змінна для зберігання наступного ID книги
    mapping next_id: u32 => u32;

    // Функція 3
    transition add_book(title: string, author: string) -> u32 {
        // Отримання наступного ID
        let book_id = get_or_use next_id[0u32] 1u32;

        // Створення нової книги
        let new_book = Book {
            id: book_id,
            title: title,
            author: author,
            is_borrowed: false
        };

        // Збереження книги у мапінгу
        set books[book_id] = new_book;

        // Оновлення наступного ID
        set next_id[0u32] = book_id + 1u32;

        // Повернення ID нової книги
        return book_id;
    }

    // Функція 2
    transition delete_book(book_id: u32) {
        // Перевірка, чи існує книга
        let book = get books[book_id];
        assert book.is_some();

        // Видалення книги з мапінгу
        delete books[book_id];
    }

    // Функція 1
    transition borrow_book(book_id: u32) {
        // Отримання книги з мапінгу
        let book = get books[book_id];
        assert book.is_some();

        // Перевірка, чи книга не позичена
        let mut book_data = book.unwrap();
        assert !book_data.is_borrowed;

        // Відмітка книги як позиченої
        book_data.is_borrowed = true;

        // Оновлення книги у мапінгу
        set books[book_id] = book_data;
    }

    // Функція 4
    transition return_book(book_id: u32) {
        // Отримання книги з мапінгу
        let book = get books[book_id];
        assert book.is_some();

        // Перевірка, чи книга позичена
        let mut book_data = book.unwrap();
        assert book_data.is_borrowed;

        // Відмітка книги як повернутої
        book_data.is_borrowed = false;

        // Оновлення книги у мапінгу
        set books[book_id] = book_data;
    }
}
