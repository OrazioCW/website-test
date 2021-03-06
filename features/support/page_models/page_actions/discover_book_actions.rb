module PageModels
  module DiscoverBookActions
    def search(search_word, view = :list)
      logger.info("Searching for books with search word '#{search_word}'")
      current_page.header.wait_until_search_input_visible
      current_page.header.search_input.click
      current_page.header.search_input.set search_word
      current_page.header.wait_until_search_button_visible
      current_page.header.search_button.click
      search_results_page.wait_for_book_results_sections
      switch_to_view(view)
    end

    def click_on_a_category
      @category_name = categories_page.select_random_category
      expect_page_displayed('Category')
      books_section.wait_until_books_visible
      @category_name
    end

    def select_book_to_view_details(book_type)
      search(return_search_word_for_book_type(book_type))
      book_type == :free ? books_section.click_details_free_book : books_section.click_details_random_book
    end

    def buy_sample_added_book(sample_isbn)
      book_details_page.load(isbn: sample_isbn, title: 'a_book_title')
      click_buy_now_in_book_details_page
    end

    def select_book_to_buy(book_type)
      search(return_search_word_for_book_type(book_type))

      if book_type == :free
        books_section.click_buy_now_free_book
      else
        books_section.click_buy_now_random_book
      end
    end

    def select_book_to_add_as_sample(book_type, page)
      isbn = isbn_for_book_type("sample_for_#{book_type}_book")
      if page == :search_results
        search(isbn)
        search_results_page.book_cover.click
      else
        page_model('Book Details').load(isbn: isbn, title: 'a_book_title')
      end
      isbn
    end

    def select_book_to_buy_on(page_name, book_type)
      if page_name =~ /Search results/i
        search(return_search_word_for_book_type(book_type))
      elsif page_name =~ /Book details/i
        page_model(page_name).load(isbn: isbn_for_book_type(book_type), title: 'a_book_title')
        book_title = book_details_page.title
        book_details_page.buy_now.click
        return book_title
      elsif page_name =~ /Category/i
        page_model(page_name).load(name: 'thriller-suspense')
      elsif current_page.header.tab(page_name).nil?
        page = page_model(page_name)
        page.load unless page.displayed?
      else
        click_navigation_link(page_name) unless page_model(page_name).displayed?
      end
      expect_page_displayed page_name

      if book_type == :free
        books_section.click_buy_now_free_book
      else
        books_section.click_buy_now_random_book
      end
    end

    def select_book_to_buy_from(page_name, book_type)
      if page_name =~ /Search results/i
        search(return_search_word_for_book_type(book_type))
      elsif page_name =~ /Book details/i
        search(return_search_word_for_book_type(book_type))
        book_type.to_sym == :free ? books_section.click_details_free_book : books_section.click_details_random_book
        book_title = book_details_page.title
        book_details_page.buy_now.click
        return book_title
      elsif page_name =~ /Category/i
        click_navigation_link('categories')
        categories_page.select_random_category
        switch_to_view(:list)
      elsif current_page.header.tab(page_name).nil?
        page = page_model(page_name)
        page.load unless page.displayed?
      else
        click_navigation_link(page_name) unless page_model(page_name).displayed?
        switch_to_view(:list)
      end
      book_type.to_sym == :free ? books_section.click_buy_now_free_book : books_section.click_buy_now_random_book
    end

    def select_book_from_grid_view(book_type)
      search(return_search_word_for_book_type(book_type), :grid)
      if book_type == :free
        books_section.click_buy_now_free_book
      else
        books_section.click_buy_now_random_book
      end
    end

    def buy_book_by_price(condition, price)
      search(return_search_word_for_book_type('paid'))
      if condition.eql?('more')
        select_random_book_more_expensive_than(price)
      elsif condition.eql?('less')
        select_random_book_cheaper_than(price)
      end
    end

    def select_book_by_isbn_to_read(isbn)
      search(isbn)
      books_section.books[0].click_view_details
      click_read_offline
    end

    def select_random_book
      book = books_section.random_purchasable_book
      book_isbn = book.isbn
      book.click_view_details
      book_isbn
    end
  end
end

World(PageModels::DiscoverBookActions)
