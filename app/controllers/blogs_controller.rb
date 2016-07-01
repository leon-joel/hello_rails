class BlogsController < ApplicationController
  before_action :set_blog, only: [:show ]

  def index
    raise IpAddressRejected
    @blogs = Blog.all
  end

  def index_no_entry
    # SG-RoR4.
    # まだEntryを書いていないBlogを表示してください。

    sql = <<-EOS.strip_heredoc
      SELECT B.*
        FROM blogs B
       WHERE NOT EXISTS (SELECT *
                           FROM entries E
                          WHERE B.id = E.blog_id);
    EOS

    ### SQL直接実行(1) … ActiveRecord::Resultが返される ⇒View側でどう使って良いのかよく分からない
    # con = ActiveRecord::Base.connection
    # r = con.select_all(sql)
    # p r
    # r.each { |b| p b }

    ### SQL直接実行(2) ---BlogのArrayが返される ⇒普通に使える
    # r = Blog.find_by_sql(sql)
    # puts r.class # -> Array
    # p r

    ### ActiveRecordのメソッドで組み立てる
    # SELECT *
    #   FROM blogs B
    #        LEFT OUTER JOIN entries E
    #        ON B.id = E.blog_id
    #  WHERE E.id IS NULL
    r = Blog.eager_load(:entries).where('entries.id IS NULL')
    @blogs = r
    @subtitle = 'まだEntryを書いていないBlog'

    render :index
  end

  def index_with_unapproved_comment
    # SG-RoR4.
    # statusがunapprovedであるCommentがあるEntryのあるBlogを表示してください。

    sql = <<-EOS.strip_heredoc
      SELECT B.*
        FROM blogs B
             INNER JOIN entries E ON E.blog_id = B.id
             INNER JOIN (SELECT entry_id
                           FROM comments
                          WHERE status = 'Unapproved'
                          GROUP BY entry_id) C ON C.entry_id = E.id
       GROUP BY B.id
    EOS

    # (1) 生SQL実行
    # r = Blog.find_by_sql(sql)
    # puts r.class # -> Array
    # p r

    # (2) ARで組み立て
    #     2段階INNER JOIN + statusで絞り込み + blogs.idでグループ化
    r = Blog.joins(entries: :comments)
            .where( comments: { status: "unapproved" } )
            .group(:id)

    @blogs = r
    @subtitle = '未承認コメントがあるBlog'

    render :index
  end

  def show
    # SG-RoR4.
    # Blogのid:1に紐づくすべてのCommentを表示してください。

    # SELECT *
    #   FROM comments C
    #        INNER JOIN entries E ON C.entry_id = E.id
    #        INNER JOIN blogs B ON E.blog_id = B.id
    #  WHERE B.id = params[:id]
    r = Comment
            .joins( { :entry => :blog } )
            .where(blogs: { id: params[:id] })
    r.each {|c| p c }
    @comments = r
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end
end
