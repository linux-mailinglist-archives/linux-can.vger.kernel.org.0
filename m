Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527C7157004
	for <lists+linux-can@lfdr.de>; Mon, 10 Feb 2020 08:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgBJHmp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Feb 2020 02:42:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgBJHmp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2020 02:42:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A7cZDT058742;
        Mon, 10 Feb 2020 07:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=4mB8GFYxTJX3p1B/OkDsYRR5CzX4gIXBGlOFxDSF53o=;
 b=W8sSvvoVqXS/gj5dNzgnN5cppP9NRq02YXo9CdEj5kPs1Bela+pro3Wh3dQsA5H2sOAf
 0FbSxMdWkP0UlDhO6lrA4wLAlkqE7YjkPBouVqvmDKZeevTVYAA7VHnbtBICjB8Me6ym
 8eszW1B6T0iSeKMB78MveALu9VPPfSbLBX1aGuFiOjd+5v5m848JDY0uJRQ40lVBDfwV
 7RPy91LCPVDq5PtkyxvM/GJ7eIz1T27mnkYum9F2jbL3g0MN2QY42NXszSm0KM2PEuyF
 CijRxa7uk8vJqLjsmN/uiPSIPbBf/YI320JtbSYuwZIIGor8kJoU9eSelzY0Q95Q8Hg0 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k87t6xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 07:42:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A7g5Ef076945;
        Mon, 10 Feb 2020 07:42:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y26hsf0vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 07:42:37 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01A7gYFA030147;
        Mon, 10 Feb 2020 07:42:34 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Feb 2020 23:42:34 -0800
Date:   Mon, 10 Feb 2020 10:42:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org
Subject: [mkl-can-next:v5.4/mcp25xxfd 5/99]
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:1305 mcp25xxfd_irq() warn:
 ignoring unreachable code.
Message-ID: <20200210074227.GR24804@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=977 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100064
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git v5.4/mcp25xxfd
head:   cdcc21e4acc1a753bc4fb151b938ba292ecf686b
commit: 6499ad52b2ad766769d55b8d59df0d36db848e95 [5/99] can: mcp25xxfd: initial commit

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:1305 mcp25xxfd_irq() warn: ignoring unreachable code.

Old smatch warnings:
drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:1667 mcp25xxfd_probe() warn: passing zero to 'PTR_ERR'
drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:1675 mcp25xxfd_probe() warn: passing zero to 'PTR_ERR'

# https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=6499ad52b2ad766769d55b8d59df0d36db848e95
git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
git remote update mkl-can-next
git checkout 6499ad52b2ad766769d55b8d59df0d36db848e95
vim +1305 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c

6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1280  
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1281  		if (IS_ENABLED(CONFIG_CAN_MCP25XXFD_DEBUG) &&
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1282  		    intf_pending & ~(MCP25XXFD_CAN_INT_MODIF |
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1283  				     MCP25XXFD_CAN_INT_TEFIF |
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1284  				     MCP25XXFD_CAN_INT_RXIF |
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1285  				     MCP25XXFD_CAN_INT_SERRIF |
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1286  				     MCP25XXFD_CAN_INT_IVMIF)) {
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1287  			netdev_err(priv->ndev, "%s: intf_pending=0x%04x\n",
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1288  				   __func__, intf_pending);
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1289  			mcp25xxfd_dump(priv);
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1290  		}
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1291  
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1292  		/* ACK interrupts that need to be ACKed in the
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1293  		 * MCP25XXFD_CAN_INT register.
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1294  		 */
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1295  		intf_pending_clearable = intf_pending &
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1296  			MCP25XXFD_CAN_INT_INTERRUPT_CLEARABLE;
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1297  		if (intf_pending_clearable) {
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1298  			err = regmap_update_bits(priv->map, MCP25XXFD_CAN_INT,
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1299  						 intf_pending_clearable, 0x0);
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1300  			if (err)
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1301  				goto out_fail;
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1302  		}
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1303  	} while (1);
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1304  
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14 @1305  	return handled;

I guess the while (1) loop has no breaks.

6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1306  
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1307   out_fail:
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1308  	mcp25xxfd_dump(priv);
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1309  	mcp25xxfd_chip_interrupts_disable(priv);
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1310  
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1311  	return handled;
6499ad52b2ad76 Marc Kleine-Budde 2019-10-14  1312  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
