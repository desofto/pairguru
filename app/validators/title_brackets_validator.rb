class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    return if valid?(record.title)
    record.errors[:title] << 'Invalid'
  end

  private

  def valid?(title)
    pool = []
    counter = 0

    title.each_char do |char|
      case char
      when '(', '[', '{'
        pool.push(char)
        counter = 0
      when ')'
        return false if pool.pop != '(' || counter.zero?
      when ']'
        return false if pool.pop != '[' || counter.zero?
      when '}'
        return false if pool.pop != '{' || counter.zero?
      else
        counter += 1
      end
    end

    return pool.empty?
  end
end
