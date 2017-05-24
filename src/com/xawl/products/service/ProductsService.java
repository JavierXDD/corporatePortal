package com.xawl.products.service;

import java.sql.SQLException;
import java.util.Map;

import com.xawl.products.dao.ProductsDao;
import com.xawl.products.domain.PageBean;
import com.xawl.products.domain.Products;

public class ProductsService {
	private ProductsDao productsDao = new ProductsDao();
	//查询某产品分类下所有产品
	public PageBean<Products> findByCidProducts(int pc, int ps, String cid) {
		try {
			return productsDao.findByCidProducts(pc, ps, cid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	//添加新产品
	public void addProducts(Products productsBean) {
		productsDao.addProducts(productsBean);
	}
	//删除产品
	public void productsDelete(String pid) {
		productsDao.productsDelete(pid);
	}
	//编辑回显信息
	public Products findByProduct(String pid){
	try {
		return	productsDao.findByProduct(pid);
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
	}
	
	public void editProduct(Products p){
		try {
			productsDao.editProduct(p);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	public Map<String, Object> productsDeleteImage(String pid) {
		return productsDao.productsDeleteImage(pid);
	}
}
