require 'measure'
require File.dirname(__FILE__)+'/xil/engine'
require File.dirname(__FILE__)+'/xil/style'
require File.dirname(__FILE__)+'/xil/xpdf'
require File.dirname(__FILE__)+'/xil/rpdf'
# require File.dirname(__FILE__)+'/xil/base'

raise Exception.new("ActionView::Template is needed") unless defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler

module Xil
  mattr_accessor :options
  @@options={:features=>[], :documents_path=>"#{Rails.root.to_s}/private/documents", :subdir_size=>4096, :document_model_name=>:documents, :template_model_name=>:templates, :company_variable=>:current_company, :crypt=>:rijndael}
end


module ActionView
  module TemplateHandlers
    
    class XIL < TemplateHandler
      include Compilable
      
      def compile(template)
        Xil::Engine.new(template).compile
      end

#       def cache_fragment(block, name = {}, options = nil)
#         @view.fragment_for(block, name, options) do
#           eval('csv_doc', block.binding)
#         end
#       end

    end

  end
  
end

# Register new Mime types
Mime::Type.register("application/pdf", :pdf) unless defined? Mime::PDF
Mime::Type.register("application/vnd.oasis.opendocument.text", :odt) unless defined? Mime::ODT
Mime::Type.register("application/vnd.oasis.opendocument.spreadsheet", :ods) unless defined? Mime::ODS
Mime::Type.register("application/vnd.oasis.opendocument.presentation", :odp) unless defined? Mime::ODP
Mime::Type.register("application/vnd.oasis.opendocument.graphics", :odg) unless defined? Mime::ODG
Mime::Type.register("application/vnd.oasis.opendocument.text-template", :ott) unless defined? Mime::OTT
Mime::Type.register("application/vnd.oasis.opendocument.spreadsheet-template", :ots) unless defined? Mime::OTS
Mime::Type.register("application/vnd.oasis.opendocument.presentation-template", :otp) unless defined? Mime::OTP
Mime::Type.register("application/vnd.oasis.opendocument.graphics-template", :otg) unless defined? Mime::OTG

# Register Template Handler
# ActionView::Template.register_template_handler(:rpdf, ActionView::TemplateHandlers::XIL)


# ActionView::Template.register_template_handler(:xpdf, Xil::TemplateHandler)
# ActionView::Template.register_template_handler(:rpdf, Xil::TemplateHandler)
# ActionView::Template.register_template_handler(:xodt, Xil::TemplateHandler)

# Specify we don't want to use the layouts
#ActionController::Base.exempt_from_layout :xpdf
#ActionController::Base.exempt_from_layout :rpdf
#ActionController::Base.exempt_from_layout :prawn
