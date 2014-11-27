module CommonModel
  def attrs_with attrs
    attrs.each do |attr|
      attr_accessor attr
    end

    define_method :initialize, do |props|
      props.each do |k, v|
        if attrs.member? k.to_s
          self.send("#{k}=", v)
        end
      end
    end
  end
end
