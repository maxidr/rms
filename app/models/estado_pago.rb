class EstadoPago < ActiveRecord::Base

  scope :enabled, where('estados_pagos.disabled_at IS NULL')

    def enabled?
      disabled_at.nil?
    end

    # Evita que el sector sea eliminado físicamente de la base.
    def destroy
      self.update_attribute(:disabled_at, Time.now)
    end

    def to_s
      "#{nombre}"
    end
end
