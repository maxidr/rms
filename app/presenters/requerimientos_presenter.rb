# encoding: utf-8
class RequerimientosPresenter

  include ActionView::Helpers::TranslationHelper

  def initialize(requerimientos)
    @reqs = requerimientos
  end

  def to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => 'Requerimientos'
    add_title(sheet)
    load_content(sheet, @reqs) do |rqm|
      [
        rqm.id, 
        l(rqm.created_at, :format => :short), 
        rqm.solicitante.try(:to_s),
        rqm.empresa.try(:to_s),
        rqm.sector.try(:to_s),
        rqm.rubro.try(:to_s),
        rqm.estado.try(:to_s) 
      ]
    end
    stringify(book)
  end

  private 

  def stringify(book)
    blob = StringIO.new ""
    book.write blob
    blob.string
  end

  def load_content(sheet, list, &block)
    idx = 1
    list.each do |element|
      sheet.insert_row(idx, block.call(element))
      idx += 1
    end
  end

  def add_title(sheet)
    title_format = Spreadsheet::Format.new :weight => :bold, :align => :center
    sheet.row(0).default_format = title_format
    sheet.row(0).concat %w( N° Fecha Solicitante Empresa Sector Rubro Estado )
    sheet
  end
end
