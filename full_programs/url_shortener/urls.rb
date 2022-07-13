require 'sequel'
require 'securerandom'

class UrlDatabase
  attr_reader :db, :urls

  def initialize(path)
    @db = Sequel.sqlite(path)
    @urls = @db[:urls]

    initialize_database unless @db.table_exists?(:urls)
  end

  def last_ten
    @urls.reverse_order(:created_at).limit(10).all
  end

  def add(long_url)
    id = @urls.insert(
      created_at: Time.now,
      long_url: long_url,
      short_slug: SecureRandom.hex(4).to_s,
      opens: 0
    )

    @urls.first(id: id)
  end

  def get(slug)
    @urls.where(short_slug: slug)
  end

  def visit(slug)
    url = get(slug)

    url.update(opens: url.first[:opens] + 1)
  end

  private

  def initialize_database
    @db.create_table :urls do
      primary_key :id
      DateTime :created_at
      String :long_url
      String :short_slug
      Integer :opens
    end
  end
end
