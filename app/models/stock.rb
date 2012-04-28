# coding: UTF-8
# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2011  Michael Franzl <michael@billgastro.com>
# 
# See license.txt for the license applying to all files within this software.

class Stock < ActiveRecord::Base
  belongs_to :group

  validates_presence_of :name, :balance, :unit

  def custom_name
    @custom_name = unit + ' ' + name
  end
end
