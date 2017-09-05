class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  #implicit render
  def index
    @books = Book.all
  end
  #=> Rendering books/index.html.haml within layouts/application

  #explicit render
  def show
    @book = Book.find(params[:id])
    render 'unexpected'
  end
  #=> Rendering books/unexpected.html.haml within layouts/application

  def extra_curricular_activity
    @book = Book.find(params[:id])
    render 'show'
    @book.update_column(:title, 'Surprise Surprise')
  end

  #=> SQL (7.1ms)  UPDATE "books" SET "title" = 'Surprise Surprise' WHERE "books"."id" = $1  [["id", 1]]
  # two screenshots

  def double_render_error
    @books = Book.all
    render 'index'
    render 'show'
  end
  #=> AbstractController::DoubleRenderError - Render and/or redirect were called multiple times in this action. Please note that you may only call render OR redirect, and at most once per action.

  def blocks_double_render_error
    @books = Book.all
    render 'index' and return
    render 'show'
    @books.last.update_column(:title, 'Or am I?')
  end

  #=> Rendering books/index.html.haml within layouts/application
  #=> Book.last.title
  #=> "Surprise Surprise"

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def book_params
      params.require(:book).permit(:title, :description, :year_published)
    end
end
