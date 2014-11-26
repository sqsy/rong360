module CommonModel
  def attrs_with attrs
    attrs.each do |attr|
      attr_accessor attr
    end

    def initialize(props = {})
      props.each do |k, v|
        if attrs.member? key.to_sym
          self.send("#{key}=", value)
        end
      end
    end
  end
end
