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
    size: 40;
    color: rgb(255,255,255);
  }

  subtractStyles {
    background: rgb(0, 85, 170);
    rounding: 0.0;
  }

  subtractLabel {
    size: 50;
    color: rgb(255,255,255);
  }

  scrollbar {
    width: 25;
    control_height: 100;
    control_padding: 5;
    control_rounding: 5;
  }
  modalContent {
    width: 300.0;
    height: 300.0;
    background: rgb(255, 255, 255);
  }
  EOF

  template <<-EOF
  [template]
    vblock
      hblock
        label#count {
          :content="count"
          size="130" 
          :color="count_color"
        }
        modal { :active="over_20" @close="close_modal" }
          vblock { ...modalContent }
            text { content="okay" }
      hblock
        vblock#add { ...additionStyles }
          label { 
            content="Add"
            @click="increment" 
            ...additionLabel 
          }
        vblock#subtract { ...subtractStyles }
          label { 
            content="Subtract"
            @click="decrement" 
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
