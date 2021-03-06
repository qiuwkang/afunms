/**
 * <p>Description:mapping table NMS_POSITION</p>
 * <p>Company: dhcc.com</p>
 * @author afunms
 * @project afunms
 * @date 2006-08-07
 */

package com.afunms.config.model;

import com.afunms.common.base.BaseVo;

public class TrapOIDConfig extends BaseVo {
	private String id;
	private String enterpriseoid;
	private int orders;
	private String oid;
	private String desc;
	private String value1;
	private String transvalue1;
	private String value2;
	private String transvalue2;
	private int transflag;
	private int compareflag;
	private String traptype;

	public int getCompareflag() {
		return compareflag;
	}

	public String getDesc() {
		return desc;
	}

	public String getEnterpriseoid() {
		return enterpriseoid;
	}

	public String getId() {
		return id;
	}

	public String getOid() {
		return oid;
	}

	public int getOrders() {
		return orders;
	}

	public int getTransflag() {
		return transflag;
	}

	public String getTransvalue1() {
		return transvalue1;
	}

	public String getTransvalue2() {
		return transvalue2;
	}

	public String getTraptype() {
		return traptype;
	}

	public String getValue1() {
		return value1;
	}

	public String getValue2() {
		return value2;
	}

	public void setCompareflag(int compareflag) {
		this.compareflag = compareflag;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public void setEnterpriseoid(String enterpriseoid) {
		this.enterpriseoid = enterpriseoid;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public void setOrders(int orders) {
		this.orders = orders;
	}

	public void setTransflag(int transflag) {
		this.transflag = transflag;
	}

	public void setTransvalue1(String transvalue1) {
		this.transvalue1 = transvalue1;
	}

	public void setTransvalue2(String transvalue2) {
		this.transvalue2 = transvalue2;
	}

	public void setTraptype(String traptype) {
		this.traptype = traptype;
	}

	public void setValue1(String value1) {
		this.value1 = value1;
	}

	public void setValue2(String value2) {
		this.value2 = value2;
	}
}
