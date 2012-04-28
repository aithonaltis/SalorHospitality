# coding: UTF-8
# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2011  Michael Franzl <michael@billgastro.com>
# 
# See license.txt for the license applying to all files within this software.

class User < ActiveRecord::Base
  has_many :settlements
  has_many :orders
  belongs_to :company
  belongs_to :role
  has_many :histories
  has_and_belongs_to_many :tables
  validates_presence_of :login, :password, :title
  scope :active, where(:active => true, :hidden => false)
  scope :existing, where('hidden=false or hidden is NULL')

  def tables_array=(ids)
    self.tables = []
    ids.each do |id|
      self.tables << Table.find_by_id(id.to_i)
    end
  end
end
