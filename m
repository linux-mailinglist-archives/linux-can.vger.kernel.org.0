Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76192FE250
	for <lists+linux-can@lfdr.de>; Thu, 21 Jan 2021 07:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAUGJh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jan 2021 01:09:37 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbhAUGJD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jan 2021 01:09:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L64GXs056705;
        Thu, 21 Jan 2021 06:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=yUb8dA08txBpttZyvHXAdxpdWBOnjs7b8MvrY5NBn7Y=;
 b=B7PGJHeLaoR7fuikmOLuoK4/ZNJKfjoYvMCJu0V0BgVy/eeCW6dwnJnqvoyIoDp1ppVp
 hbY1RUXubRsJ18rAbtrSO9VKSjzD3Lg7Q+Vgda+UvTEuwLejjQBBffza1m2f0UP1fu86
 CFxUVookGL0wCkPIaTPfUaWuNBLMFokEI5f8iQ5D4M1wrsGwL0v+5t5n8T6TWheasMST
 /8u3qbed5VBj9yoKe9RJ1PlT0rNKf6WFKbjIDJNiEyilwxjG0IL0XZ9uUE/MIdsUIUC2
 ashjKdHVvtIgHkJsIE71MZDwfYCEeVhyoGRuwexwMzG3sWmw6t5ITwONw8+vX4bNoVwP QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3668qmwpyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 06:08:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10L64gZt012849;
        Thu, 21 Jan 2021 06:08:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3668qwewh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 06:08:11 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10L68Ahc016916;
        Thu, 21 Jan 2021 06:08:11 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jan 2021 22:08:09 -0800
Date:   Thu, 21 Jan 2021 09:08:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH can tree] can: dev: prevent potential information leak in
 can_fill_info()
Message-ID: <YAkaRdRJncsJO8Ve@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210031
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The "bec" struct isn't necessarily always initialized.  For example,
the mcp251xfd_get_berr_counter() function doesn't initialize anything
if the interface is down.

Fixes: 52c793f24054 ("can: netlink support for bus-error reporting and counters")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 3ae884cdf677..7a1ff6fcbb8f 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -263,7 +263,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct can_ctrlmode cm = {.flags = priv->ctrlmode};
-	struct can_berr_counter bec;
+	struct can_berr_counter bec = {};
 	enum can_state state = priv->state;
 
 	if (priv->do_get_state)
-- 
2.29.2

