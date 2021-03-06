class Admin::ReturnAuthorizationsController < Admin::ResourceController
  belongs_to :order

  update.after :associate_inventory_units
  create.after :associate_inventory_units

  def fire
    @return_authorization.send("#{params[:e]}!")
    flash.notice = t('return_authorization_updated')
    redirect_to :back
  end

  protected
    def associate_inventory_units
      params[:return_quantity].each { |variant_id, qty| @return_authorization.add_variant(variant_id.to_i, qty.to_i) }
    end
end
