class Entry < ActiveRecord::Base
  belongs_to :blog
  has_many :comments


  # 親子関係を持つデータの登録方法 【rails console使用】
  # ※http://qiita.com/jnchito/items/7f41ff3df900909952db

  # 1.parent.children.create/build ※buildはsaveしないので別途saveが必要
  # e = Entry.create(title: "title1", body: "b1\r\nb2")
  # c = e.comments.create(body: "nice!", status: "approved")

  # 2.parent.children << child
  # e = Entry.find_by_id(1)
  # c = Comment.new(body: "b1", status: "unapproved")
  # e.comments << c  ※この時点でsaveされる

  # ※parent.children = children
  #   = で配列を渡すと、既存のchildrenは全て削除される。

  # 3.child.parent = parent
  # c.entry = e
  # c.save

  # createと同時に親もセットするパターン
  # c = Comment.create(body: "b", status: "approved", entry: e)

  # 4.child.parent_id = parent_id
  # c.entry_id = 2
  # c.save
  # Entry.find(2).size  ※確認

  # createと同時に親idもセットするパターン
  # c = Comment.create(body: "b", status: "approved", entry_id: e.id)

end
