require 'sequel'
require 'securerandom'

class TextDatabase
  def initialize(path)
    @db = Sequel.sqlite(path)
    @texts = @db[:texts]

    initialize_database unless @db.table_exists?(:texts)
  end

  def recent
    @texts.reverse_order(:created_at).limit(10).all.map { |post| Post.new(post) }
  end

  def get_all(slug)
    @texts.where(slug: slug).reverse_order(:version).all.map { |post| Post.new(post) }
  end

  def get_by_version(slug, version)
    Post.new(@texts.where(slug: slug, version: version).first)
  end

  def get_most_recent_by_slug(slug)
    Post.new(@texts.where(slug: slug).reverse_order(:version).first)
  end

  def add(text)
    id = @texts.insert(
      created_at: Time.now,
      slug: SecureRandom.hex(4).to_s,
      version: 0,
      text: text
    )

    saved_post = @texts.where(id: id).first

    Post.new(saved_post)
  end

  def update(slug, text)
    id = @texts.insert(
      created_at: Time.now,
      slug: slug,
      version: get_most_recent_by_slug(slug).version + 1,
      text: text
    )

    saved_post = @texts.where(id: id).first

    Post.new(saved_post)
  end

  def initialize_database
    @db.create_table :texts do
      primary_key :id
      DateTime :created_at
      String :slug
      Integer :version
      String :text, text: true
    end
  end
end

Post = Struct.new(:id, :created_at, :slug, :version, :text, keyword_init: true) do
  def show_url
    "/#{slug}"
  end

  def edit_url
    "/#{slug}/edit"
  end

  def versioned_url
    "/#{slug}/v/#{version}"
  end

  def all_url
    "/#{slug}/all"
  end
end
