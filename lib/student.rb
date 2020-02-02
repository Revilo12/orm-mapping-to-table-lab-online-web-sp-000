class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
        CREATE TABLE students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER
        )
        SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
        SQL
    DB[:conn].execute(sql, self.name, self.grade)

    sql_row = <<-SQL 
            SELECT last_insert_rowid()
            SQL
    id = DB[:conn].execute(sql_row)
    @id = id
  end

end
