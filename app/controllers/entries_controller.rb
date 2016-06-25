class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    # r = Blog.where("? <= id", 2)
    # # r.each do |b|
    # r.find_each(batch_size: 2) do |b|
    #   p b
    # end

    # ■■■LEFT OUTER JOINで子テーブルの先読み（eager_load）
    # SELECT *
    #   FROM entries E LEFT OUTER JOIN comments C ON C.entry_id = E.id
    #  WHERE E.id IN (3, 4, 5)
    # r = Entry.eager_load(:comments).where(id: [*3..5])
    #
    # r.each do |b|
    #   p b
    #   b.comments.each do |c|
    #     puts "======="
    #     p c
    #   end
    # end

    # ■■include同様、2段階（孫テーブルまで）先読みもいける
    # r = Blog.eager_load(entries: :comments).where(id: [*3..5])

    # 子テーブルでの絞り込みもいける
    # SELECT *
    #   FROM blogs B
    #        LEFT OUTER JOIN entries E ON E.blog_id = B.id
    #        LEFT OUTER JOIN comments C ON C.entry_id = E.id
    #  WHERE E.id IN (1, 2)
    # r = Blog.eager_load(entries: :comments).where(entries: {id: [1, 2]})

    # 子/孫テーブルの絞り込み条件をハッシュで渡せない場合でも references をかまさなくて良いみたい（includesとは違う点）
    # r = Blog.eager_load(entries: :comments).where("comments.id <= ?", 2)
    #
    # r.each do |b|       # eachで全ての結果を取得（キャッシュアップ）する
    # # r.find_each do |b|    # find_each は、「1000件ずつ取得し、1件ずつ処理する」のでメモリーにはやさしい
    #   puts "###### Blog #{b.id}"
    #   p b
    #   b.entries.each do |e|
    #     puts "  ====== Entry #{e.id}"
    #     p e
    #
    #     e.comments.each do |c|
    #       puts "    -------"
    #       p c
    #     end
    #   end
    # end

    # ■■■SQL2回で子テーブルの先読み（include）
    # SELECT * FROM entries WHERE id = 1
    # SELECT * FROM comments WHERE entry_id IN (1)
    # r = Entry.includes(:comments)
    #         .where(id: params[:id])
    #
    # r.each do |e|
    #   p e
    #   p e.comments
    # end

    # ■■includeを使う（2段階）
    # SELECT * FROM blogs WHERE (2 <= id)
    # SELECT * FROM entries WHERE blog_id IN (2, 3)
    # SELECT * FROM comments WHERE entry_id IN (1, 2)
    # r = Blog.includes(entries: :comments).where("? <= id", 2)

    # ■■さらに子テーブルで絞り込んでみると、LEFT OUTER JOINを使うようだ
    # SELECT *
    #   FROM blogs B
    #        LEFT OUTER JOIN entries E ON E.blog_id = B.id     ←OUTERになっているが、ここはINNERでも結果は同じ
    #        LEFT OUTER JOIN comments C ON C.entry_id = E.id
    #  WHERE E.id = 1    ←子テーブルentriesのidで絞り込んでいる
    # r = Blog.includes(entries: :comments).where(entries: { id: 1 })

    # ハッシュで絞り込み条件を渡せないときはreferences(:子テーブル名)をかます必要があるっぽい。
    # 生成されるSQLは上のとほぼ同じ。
    # r = Blog.includes(entries: :comments).references(:entries).where("entries.id < ?", 2)


    # ■■さらに孫テーブルで絞り込んでみる。やはりLEFT OUTER JOINを使う。
    # SELECT *
    #   FROM blogs B
    #        LEFT OUTER JOIN entries E ON E.blog_id = B.id
    #        LEFT OUTER JOIN comments C ON C.entry_id = E.id
    #  WHERE C.id IN (1, 2, 3)    ←孫テーブルcommentsのidで絞り込んでいる
    # r = Blog.includes(entries: :comments).where(comments: { id: [*1..3] })
    #
    # r.each do |b|
    #   puts "###### Blog #{b.id}"
    #   p b
    #   b.entries.each do |e|
    #     puts "  ====== Entry #{e.id}"
    #     p e
    #
    #     e.comments.each do |c|
    #       puts "    -------"
    #       p c
    #     end
    #   end
    # end

    # r には Blog がセットされる
    # r = Blog.includes(entries: :comments).find_by_id(1)
    #
    # r.entries.each do |e|
    #   p e
    # end
    # p r
    # p r.entries.count
    # puts r.blank?


    # ■■■SQL2回で子テーブルの先読み（preload）
    # SELECT * FROM blogs WHERE id IN (1, 2)
    # SELECT * FROM entries WHERE blog_id IN (1, 2)
    # r = Blog.preload(:entries).where(id: [1, 2])
    #
    # r.each do |b|
    #   p b
    #   p b.entries
    # end

    # ■preloadは子テーブル側で絞り込めない
    # r = Blog.preload(:entries).where(entrires: { id: [1, 2] } )
    # => ActiveRecord::StatementInvalid
    # referencesをかましてもダメ。
    # r = Blog.preload(:entries).references(:entries).where(entries: { id: [1, 2] } )
    # => Mysql2::Error: Unknown column 'entries.id'


    # ■■■INNER JOIN（joins）
    #
    # SELECT blogs.*, entries.title AS entry_title, entries.body
    #   FROM blogs
    #        INNER JOIN entries
    #        ON entries.blog_id = blogs.id
    #  WHERE blogs.id = 1
    #
    # - 1レコード1インスタンスで返却される
    # - JOINしたテーブルのカラムはselectで明示的に指定しないと見えない
    # r = Blog.joins(:entries)
    #         .where(id: 1)
    #         .select("blogs.*, entries.title AS entry_title, entries.body")
    # r = Blog.joins(entries: :comments)
    #         .where(entries: { id: [*1..3] })
    #         .select("blogs.*, entries.title AS entry_title, entries.body, comments.body AS comment_body")
    #         .explain    # EXPLAIN
    # puts r              # explain結果は文字列

    # r.each do |e|
    #   p e             # Blogの属性しか見えない
    #   p e.attributes  # Blog以外の属性が格納されていることが分かる
    #
    #   # blogsテーブルの属性も、entriesテーブルの属性も読める
    #   puts "blog title: #{e.title}, entry title: #{e.entry_title}"
    #   # puts "blog title: #{e.title}, entry title: #{e.entry_title}, comment body: #{e.comment_body}"
    # end


  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :body)
    end
end
