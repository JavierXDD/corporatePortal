package com.xawl.link.service;

import com.xawl.link.dao.LinkDao;
import com.xawl.link.domain.Link;
import com.xawl.news.domain.PageBean;

public class LinkService {
	LinkDao linkDao = new LinkDao();

	public PageBean<Link> findLink(int pc, int ps,String mark) {
		return linkDao.finkLink(pc,ps,mark);
	}

	public void addLink(Link link) {
		linkDao.addLink(link);
	}

	public Link findLinkByiId(String iId) {
		return linkDao.findLinkByiId(iId);
	}

	public void editLink(Link link) {
		linkDao.editLink(link);
	}

	public void deletLink(String iId) {
		linkDao.deletLink(iId);
	}
}
