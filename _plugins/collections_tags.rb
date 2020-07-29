# Source: https://github.com/jekyll/jekyll/commit/76b55f814670968e1a6836d1933ab42f8654497c

module Jekyll
  class Site
    def doc_attr_hash(doc_attr, documents)
      # Build a hash map based on the specified document attribute
      # ( doc_attr => array of docs ) then sort each array in reverse order.
      hash = Hash.new { |h, key| h[key] = [] }

      documents.each do |d|
        d.data[doc_attr]&.each { |t| hash[t] << d }
      end

      hash.each_value { |docs| docs.sort!.reverse! }
      hash
    end

    # As doc_attr_hash, but for posts only
    def post_attr_hash(post_attr)
      doc_attr_hash(post_attr, posts.docs)
    end

    def tags
      doc_attr_hash('tags', documents)
    end

    def categories
      doc_attr_hash('categories', documents)
    end
  end

  # We also have to monkey-patch jekyll-archives plugin
  # Source: iBug (https://github.com/taoky/206hub/commit/a235e53964a9d0fd66eef3713af7deed0952cf03#diff-c567d700340847520807121daca70543)
  module Archives
    class Archives
      def tags
        @site.tags
      end

      def categories
        @site.categories
      end
    end
  end
end
