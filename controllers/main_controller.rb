class MainController < Controller
  def index
    @test = "Las historia Romana"
    @arr = %w(Gladiadores two three)
  end
end
