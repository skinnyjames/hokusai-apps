class Counter < Hokusai::Block
  style <<~EOF
  [style]
  additionStyles {
    background: rgb(214, 49, 24);
    rounding: 0.0;
    outline: outline(1,4,4,1);
    outline_color: rgb(216, 26, 137);
  }

  additionLabel {
    size: 20;
    color: rgb(255,255,255);
  }

  subtractStyles {
    background: rgb(0, 85, 170);
    rounding: 0.0;
  }

  subtractLabel {
    size: 20;
    color: rgb(255,255,255);
  }
  EOF

  template <<-EOF
  [template]
    vblock { background="255,255,255" }
      hblock
        label#count {
          :content="count"
          size="130" 
          :color="count_color"
        }
      hblock
        vblock#add { ...additionStyles @click="increment"}
          label { 
            content="Add"
            ...additionLabel 
          }
        vblock#subtract { ...subtractStyles @click="decrement" }
          label { 
            content="Subtract"
            ...subtractLabel 
          }
  EOF

  uses(
    vblock: Hokusai::Blocks::Vblock,
    hblock: Hokusai::Blocks::Hblock,
    label: Hokusai::Blocks::Label,
    scrollbar: Hokusai::Blocks::Scrollbar,
    image: Hokusai::Blocks::Image,
    modal: Hokusai::Blocks::Modal,
    text: Hokusai::Blocks::Text
  )

  attr_accessor :count, :keys, :modal_open

  def count_positive
    count > 0
  end

  def over_20
    count > 20
  end

  def close_modal
    self.count = 0
  end

  def increment(event)
    self.count += 1
  end

  def decrement(event)
    self.count -= 1
  end

  def count_color
    self.count > 0 ? [0,0,255] : [255,0,0]
  end

  def initialize(**args)
    @count = 0
    @keys = ""
    @modal_open = false
    super(**args)
  end
end

Counter
