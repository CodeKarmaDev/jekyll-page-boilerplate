
module JekyllPageBoilerplate

  module List

    SPACER = '\n'
    REMOVE_SUFFIX = /\.\w+(?=[\s\n\r$])/

    def display
      return Dir.pwd
      return Dir.glob(
        "_boilerplates/**"
      ).inspect
    end

  end
end