
class JekyllPageBoilerplate::Tags
  
  FILE_DATE_FORMATE = '%Y-%m-%d'
  FILL_SCAN = /\{{2}\s{0,}([^\{\}\.\s]+)\s{0,}\}{2}/

  def self.[] *args
    self.new *args
  end

  def initialize *args, **params
    @tags = {}
    add(*args, params)
  end
  
  def []= key, val
    @tags[key.to_s] = val
  end

  def add *args, **params
    args.map! {|h| h.transform_keys(&:to_s).compact }
    params.transform_keys!(&:to_s).compact!
    @tags.merge!(*args, params)
    self
  end

  def [] key
    key = key.to_s
    @tags[key] ||= fetch(*key.split(/\s*=\s*|\s*,\s*/))
  end

  def fill *keys, safe: false
    keys.map!(&:to_s)
    keys.each do |k|
      @tags[k].scan(FILL_SCAN).flatten.uniq.each do |tag|
        @tags[k].gsub! /\{{2}\s{0,}#{tag.to_s}\s{0,}\}{2}/, self[tag].to_s
      end
    end
    if safe
      keys.each do |k|
        @tags[k] = safe(k)
      end
    end
    self
  end

  def safe key
    self[key].to_s.downcase.gsub(/[^0-9a-z\.\-\/]+/, '-')
  end

  def fetch key, *params
    case key
    when 'safe'
      safe(params.join(','))
    when 'time'
      Time.now.to_s
    when 'date'
      Time.now.strftime(FILE_DATE_FORMATE)
    when 'random'
      SecureRandom.hex(*params.map(&:to_i))
    else
      ''
    end
  end


  def method_missing key
    @tags[key.to_s]
  end
end
