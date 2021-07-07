class BaseModel

  def initialize(store)
    @store = store
  end

  def save(model, data)
    @store.transaction do
      puts data.transform_keys(&:to_sym)
      store[model] << data.transform_keys(&:to_sym)
    end
  end
end

