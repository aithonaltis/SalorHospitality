# coding: UTF-8

# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2012-2013  Red (E) Tools LTD
# 
# See license.txt for the license applying to all files within this software.

class PartialsController < ApplicationController

  def destroy
    partial = get_model
    partial.delete
    render :nothing => true
  end

  def create
    @presentations = @current_vendor.presentations.existing.find_all_by_model params[:model]
    render :no_presentation_found and return if @presentations.empty?
    @partial = Partial.new params[:partial]
    @partial.company = @current_company
    @partial.vendor = @current_vendor
    @partial.model_id = params[:model_id]
    @partial.presentation = @presentations.first
    @partial.blurb = t('partials.default_blurb') if params[:model] == 'Presentation'
    @partial.save
    
    @page = @current_vendor.pages.existing.find_by_id params[:page_id]
    @page.partials << @partial
    @page.save
    
    @partial_html = evaluate_partial_html @partial
  end
  
  def update
    @partial = get_model
    @partial.update_attributes params[:partial]
    @partial_html = evaluate_partial_html @partial
    @presentations = @current_vendor.presentations.existing.find_all_by_model @partial.presentation.model
  end
  
  private
  
  def evaluate_partial_html(partial)
    # this goes here because binding doesn't seem to work in views
    record = partial.presentation.model.constantize.find_by_id partial.model_id
    
    begin
      eval partial.presentation.secure_expand_code
      partial_html = ERB.new( partial.presentation.secure_expand_markup).result binding
    rescue Exception => e
      partial_html = t('presentations.error_during_evaluation') + e.message
    end
    partial_html.force_encoding('UTF-8')
  end
end
