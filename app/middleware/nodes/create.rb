module Nodes
  class Create
    def self.call(book, chapter)
      new(book, chapter).call
    end

    def initialize(book, chapter)
      @book = book
      @chapter = chapter
      @graph = Graphviz::Graph.new
    end

    def call
      chapter.present? ? generate_chapter_graph : generate_book_graph
      Graphviz.output(graph, path: "#{Rails.root}/public/#{graph_name}", format: 'svg')

      graph_name
    end

    private

      attr_reader :book, :chapter, :graph

      def generate_chapter_graph
        chapter.scenes.each do |scene|
          node = graph.add_node(scene.title)
          scene.inbound_links. each do |link|
            node.add_node(link.target.title)
          end
        end
      end

      def generate_book_graph
        book.chapters.each do |chapter|
          node = graph.add_node(chapter.title)
          node.attributes[:shape] = "box3d"
          node.attributes[:color] = "red"
        end
      end


      def graph_name
        @graph_name ||= "graphs/#{SecureRandom.hex(8)}.svg"
      end

  end
end
