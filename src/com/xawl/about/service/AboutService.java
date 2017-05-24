package com.xawl.about.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.xawl.about.dao.AboutDao;
import com.xawl.about.domain.About;
import com.xawl.news.domain.PageBean;

public class AboutService {
	private AboutDao aboutDao = new AboutDao();

	public PageBean<About> findAboutByCid(int pc, int ps, String cid) {
		return aboutDao.findAboutByCid(pc, ps, cid);
	}

	public void addAbout(About newbean) {
		aboutDao.addAbout(newbean);
	}

	public void aboutDelete(String aid) {
		try {
			aboutDao.aboutDelete(aid);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public About findByAbout(String aid) {
		return aboutDao.findByAbout(aid);
	}

	public void editAbout(About a) {
		aboutDao.editNew(a);
	}

	public Map<String, Object> aboutDeleteImage(String aid) {
		return aboutDao.aboutDeleteImage(aid);
	}
	public List<About> findAll(){
		try {
			return aboutDao.findAll();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
