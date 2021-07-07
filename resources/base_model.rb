class BaseModel

  def initialize(store)
    @store = store
  end

  def save(data)
    @store.transaction do
      @store[name] << data
    end
  end

  def get
    all_data = {}
    @store.transaction do
      all_data = @store[name]
    end
    all_data
  end

  private

  def name
    self.class.to_s.downcase
  end

end

