# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160824211824) do

  create_table "autorizaciones_sectores", :force => true do |t|
    t.integer  "requerimiento_id"
    t.integer  "autorizante_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "caracteristicas", :force => true do |t|
    t.string   "nombre"
    t.string   "valor"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compras", :force => true do |t|
    t.date    "fecha_probable_entrega"
    t.date    "fecha_entrega"
    t.text    "observaciones"
    t.integer "presupuesto_id"
    t.integer "requerimiento_id"
  end

  create_table "condiciones_pagos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "disabled_at"
  end

  create_table "desgloses", :force => true do |t|
    t.string   "detalle"
    t.integer  "unidades"
    t.decimal  "precio_unitario"
    t.decimal  "iva"
    t.integer  "presupuesto_id"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mas_iva"
  end

  create_table "detalles_aprobacion_compras", :force => true do |t|
    t.integer "autorizante_id"
    t.integer "presupuesto_id"
  end

  create_table "detalles_aprobacion_sector", :force => true do |t|
    t.integer  "autorizante_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detalles_cancelacion_compras", :force => true do |t|
    t.integer "cancelado_por_id"
  end

  create_table "detalles_cancelacion_de_la_compra", :force => true do |t|
    t.integer "cancelado_por_id"
    t.text    "motivo"
  end

  create_table "detalles_finalizacion", :force => true do |t|
    t.integer "responsable_id"
  end

  create_table "detalles_pendiente_aprobacion", :force => true do |t|
    t.integer "autorizante_id"
  end

  create_table "detalles_recepcion", :force => true do |t|
    t.integer "recepcionista_id"
  end

  create_table "detalles_rechazo_compras", :force => true do |t|
    t.integer "rechazado_por_id"
    t.text    "motivo"
  end

  create_table "detalles_rechazo_entrega", :force => true do |t|
    t.integer "rechazado_por_id"
    t.text    "motivo"
  end

  create_table "detalles_rechazo_sector", :force => true do |t|
    t.integer "autorizante_id"
    t.text    "motivo"
  end

  create_table "detalles_verificacion_compras", :force => true do |t|
    t.boolean "aprobado"
    t.integer "presupuesto_id"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "disabled_at"
    t.string   "url_poseidon"
  end

  create_table "estados_historicos", :force => true do |t|
    t.integer  "codigo_estado",    :default => 0, :null => false
    t.integer  "requerimiento_id"
    t.integer  "detalle_id"
    t.string   "detalle_type"
    t.datetime "created_at"
  end

  create_table "materiales", :force => true do |t|
    t.string   "nombre"
    t.string   "cantidad"
    t.text     "detalle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requerimiento_id"
  end

  create_table "monedas", :force => true do |t|
    t.string   "simbolo"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "disabled_at"
  end

  create_table "notificaciones", :force => true do |t|
    t.integer  "requerimiento_id"
    t.text     "body"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_id"
  end

  create_table "pagares", :force => true do |t|
    t.date     "fecha_pago"
    t.integer  "requerimiento_id"
    t.integer  "presupuesto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presupuestos", :force => true do |t|
    t.integer  "proveedor_id"
    t.integer  "moneda_id"
    t.integer  "condicion_pago_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requerimiento_id"
    t.string   "detalle"
    t.boolean  "aprobado",          :default => false
    t.boolean  "seleccionado",      :default => false
    t.date     "fecha_entrega"
  end

  create_table "proveedores", :force => true do |t|
    t.string   "razon_social"
    t.text     "domicilio"
    t.string   "telefono"
    t.string   "cuit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "localidad"
    t.string   "cod_postal"
    t.string   "representante"
    t.string   "jefe_ventas"
    t.text     "memo"
    t.datetime "disabled_at"
  end

  create_table "requerimientos", :force => true do |t|
    t.integer  "solicitante_id"
    t.integer  "empresa_id"
    t.integer  "sector_id"
    t.integer  "rubro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado",         :default => 0, :null => false
    t.string   "consumo"
  end

  create_table "rubros", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "disabled_at"
  end

  create_table "sectores", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.datetime "disabled_at"
  end

  create_table "sectores_usuarios", :id => false, :force => true do |t|
    t.integer "usuario_id"
    t.integer "sector_id"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "identificador"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sector_id"
    t.integer  "roles_mask"
    t.integer  "rol_id",                              :default => 0,  :null => false
  end

  create_table "verificaciones_encargado_compras", :force => true do |t|
    t.integer  "verificador_id"
    t.datetime "fecha_aprobacion"
    t.datetime "fecha_rechazo"
    t.string   "motivo_rechazo"
    t.integer  "presupuesto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
