class BoardSerializer<ActiveModel::Serializer
  attributes :id, :name, :size, :surfer_id
  
  def surfer_id
    self.object.surfer.name
  end
end
