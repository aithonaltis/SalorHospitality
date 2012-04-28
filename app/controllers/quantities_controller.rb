# coding: UTF-8
# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2011  Michael Franzl <michael@billgastro.com>
# 
# See license.txt for the license applying to all files within this software.

class QuantitiesController < ApplicationController

  def sort
    if params['quantity']
      params['quantity'].each do |id|
        q = Quantity.find_by_id id
        q.position = params['quantity'].index(q.id.to_s) + 1
        q.save
      end
    end
    render :nothing => true
  end

end
