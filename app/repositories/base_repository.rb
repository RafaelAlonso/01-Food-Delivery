require 'csv'

class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    load_from_csv if File.exist?(@csv_file_path)

    # Modo ternário
    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def all
    @elements
  end

  def find(id_to_find)
    @elements.find { |element| element.id == id_to_find }
  end

  def add(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    save_to_csv
  end

  private

  def load_from_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file_path, csv_options) do |row|
      @elements << @model.new(row)
    end
  end

end
