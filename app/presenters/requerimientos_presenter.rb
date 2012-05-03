# encoding: utf-8
class RequerimientosPresenter

  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::NumberHelper

  def initialize(requerimientos)
    @reqs = requerimientos
  end

  def to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet :name => 'Requerimientos'
    titles = ["N°", "Fecha", "Solicitante", "Empresa", "Sector", "Rubro", "Estado", 
      "Proveedor del presupuesto", "Moneda", "Monto total final", "Condición de pago", "Destalles del presupuesto"]
    add_titles(sheet, titles)
    load_content(sheet, @reqs) do |rqm|
      row = [
        rqm.id, 
        l(rqm.created_at, :format => :short), 
        rqm.solicitante.try(:to_s),
        rqm.empresa.try(:to_s),
        rqm.sector.try(:to_s),
        rqm.rubro.try(:to_s),
        rqm.estado.try(:to_s) ]
      if presupuesto = rqm.presupuestos.aprobado
        row.concat [
          presupuesto.proveedor.razon_social,
          presupuesto.moneda.simbolo, 
          number_with_precision(presupuesto.monto_total),
          presupuesto.condicion_pago.nombre,
          presupuesto.detalle
        ]
      end
      row
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

  def add_titles(sheet, titles)
    title_format = Spreadsheet::Format.new :weight => :bold, :align => :center
    sheet.row(0).default_format = title_format
    sheet.row(0).concat titles
    sheet
  end
end
