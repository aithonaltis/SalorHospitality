# coding: UTF-8
# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2011  Michael Franzl <michael@billgastro.com>
# 
# See license.txt for the license applying to all files within this software.

class Table < ActiveRecord::Base
  has_many :orders
  has_and_belongs_to_many :users
  belongs_to :user, :class_name => 'User', :foreign_key => 'active_user_id'
  validates_presence_of :name
  scope :existing, where('hidden=false or hidden is NULL')
end
