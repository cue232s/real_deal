module PropertiesHelper
  def make_carousel(image_array)
  #     <div id="carousel-example-generic" class="carousel slide">
  #   <ol class="carousel-indicators">
  #     <% image_array.each_index do |index| %>
  #       <li data-target="#carousel-example-generic" data-slide-to="<%= index %>" class=<%= "active" if index == 0 %>></li>
  #     <% end %>
  #   </ol>
  #   <% @images.each_with_index do |image, index| %>
  #     <div class="carousel-inner">
  #       <div class="item<%= " active" if index == 0 %>">
  #         <%= image_tag image, class: "prop_img" %>         
  #       </div>
  #     </div>
  #   <% end %>
  #   <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
  #     <span class="icon-prev"></span>
  #   </a>
  #   <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
  #     <span class="icon-next"></span>
  #   </a>
  # </div>
  end
end
