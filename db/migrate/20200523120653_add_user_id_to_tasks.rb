class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end

  # マイグレーションは可逆の関係でなくてはならない。つまり、マイグレーションを実行した後に元に戻したいときにどのように戻すか？
  # も書いていないと、どう戻せば良いかがわからなくなるためエラーがでる。なのでrollback用の意味でもdownへの記述が必要。
end
