Return-Path: <linux-can+bounces-7626-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBZBHuNxBWoTXAIAu9opvQ
	(envelope-from <linux-can+bounces-7626-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 08:55:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626C53E93C
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 08:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5516301B6DF
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F53AD522;
	Thu, 14 May 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UwUJBJhT"
X-Original-To: linux-can@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11251E515;
	Thu, 14 May 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741727; cv=fail; b=sqRD3vsxncGcEVTDHp2124WG4dTF5K8Wk96Up4F9YEuelPEH1nNhuaMeGvtxMTRQsZ0a9WXo6iCPB0akxM2Sca9AE9CMnBn0e6VW48khjtuQKKbfXcVupnbQ1/6QiouUk4iMf/DpJw4Jyym8q2/sQczRGHQ79VqFLY4d6epYkbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741727; c=relaxed/simple;
	bh=w1F3pn/HvdIznv5x4Zy6X1m4SfvWlywxUb14Q07p0EQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4+WfwGvtvcvt7tcfc0FQCSLbpGB1ztX5AqvQRzZ5Xs/J6aQHwMXaAVnsZoP23Arb35iZaBrX1wnhqnWsW7yeJ6GbVxECXw25MUme8uU2G/1PdTlVxGDAd1gwbv2LY3x2acMessEo73neG5SPfHJcKSIhMYkTLEXeZofGuI5VtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UwUJBJhT; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drNWye6LrsHJz8rEO/WlQ5z+/bJUDfGkDhyLmkM4ozh8gsx5DBin3+bSTA2qyOB1+WPn/qMW1jQjC0uEMwQ+q982KnTWtEFuiJLLal2+NggydrqECXHN6yFB4GBR2Al0trh5KH1JVmLUo+N+IqtrdXF432so7Np9QLdq4uPnMx4uyz/35P/0PErOdCAKo5YJz3pistq4piBSYTcMW9AY/DqCTEmi3lTFTZKl6LRdDfTtHBOCbWYiAlgv7V3CpE0KO7hFUGRaDrqrWfLATt/zLjLfhZouqplhNtMZNDDYtm5h8ihtldOzdOLYFFD7eiifdx+zVU3trPKxT1lFJl3qmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgPMso378RYQlv/pJes+4+b3rzxtn137BfYwMdLQztM=;
 b=g2jvh4a9j/Lp2mFVdtiSlnQ1DsKjYAMtDvbmueHQWteLKgRKrUDgyP+KqBkeT8nFyWfuVuHiolMd0pgyphOjHCafv0CB6BbIL1zgvCjFY88Pm54uy7VDfnoTNttmBHRSYVwfYMR9r7ospjKKLUZAu9JlD531+YfFapysYUThAu2Ay3t6vLYgxDjb1I8KnFAhGsbKw5ztCKQcC+LIA2hsx6upwVtgh8JIOO0/EOzKrwox+gKvl6cziS5PdGv1BkWr2W4EDd7us0rSz6AgPV1OQDcCVDqq4PwRnUFey7e4xHH2vu27GI9P+PCVr8pq0rOShpeKgzodHWueHvbmxbZ/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgPMso378RYQlv/pJes+4+b3rzxtn137BfYwMdLQztM=;
 b=UwUJBJhT8sqzRSYCrDwcR4SfSZM3iwDZu9mX4InXEpsJTKtCqM8cRBuG/MRJcn1obs6xZ3JQ/hUWMdXak9jJD2nyYZGaS9hzgt8Uz/XYmzhDkxryiS+hElwxA/T/36Pvu7VU5bIyLWFYUcxlg00gBse0oymXnSNZVEWas/O8L2E=
Received: from PH7P220CA0035.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::30)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 06:55:22 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::bc) by PH7P220CA0035.outlook.office365.com
 (2603:10b6:510:32b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 06:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Thu, 14 May 2026 06:55:19 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 01:55:16 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 01:55:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 14 May 2026 01:55:16 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64E6tBdu1565973;
	Thu, 14 May 2026 01:55:12 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <u-kumar1@ti.com>, <vigneshr@ti.com>, <gehariprasath@ti.com>,
	<rcsekar@samsung.com>, <mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>, <a-dutta@ti.com>
Subject: [PATCH] can: m_can: Implement workaround for errata i2278 and i2279
Date: Thu, 14 May 2026 12:25:11 +0530
Message-ID: <20260514065511.3573223-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0435a51d-b09f-40d2-8024-08deb185c358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|82310400026|376014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Zom4gR0bBvp+xlt5mDQ8ke5Gq+YZeuoUqw1106NOlMdqSTJvwq8IwuEGkWfSeTWl5c9/YlzzziiKGT23IqV0ulVhfEWpE8TVsSkj2CGReU51EWS5Losy2jED6P5ELKil+8S0LELgim1gP4m2RqzLgzxtUl9RXXTF2kpx94i6EtKU/oNAwlhEluzeDwDqlUniQq4GL7IpDuhC+l/ngh/1SCSJjzfODSWz3Wa+g+tppIVmw3ub53AtKuiDAl9qIhkwIMEDaf4fIrWhvAsrZLGARc9aBoB7/dArFF4IrJRE7qaeoa7NJdwjjyXP7E52EzIheMnER7Nh4F3EqGuFHAW85WN13+TPdz5E9Lkq/cYjAmegLFT9BYQDhSUth6MdDJkRnEuuaouCC3DCJ/AZvTyU/wQxIPg5VYBgAqWsY8Qo0crgBF+P6TqiH/ynRnRQNkXhbsZcFt2q6rjd2mzj+6mKRRm4hO0nl+7Ge3b/9cncHTl+oifGFe55pN57JBAJQY6S+yjiTsk36HKIOaoX6ZUx+8yD6W4CyRGpbt+mRgFWpB/LdBHWM1t3gpjqnJc5/qwSjdclJ4WQ87+t+/ZC5w5FG3+qyebWIuJIRZeh627f9k1IgMG2yYAu8fzri17EbbPeUcVkmEqWBMpaQW84kY3YvU5rxJAXUUuj5lgroMS56WpEHMdQUmiRxO72+VjIIwgV+TpnVIYxJkFijVOYvgOK9ASRoxbzmkhAAYKiNdJ54udlFC/vT4ul5asRd/n0T5Q1THP6ucs0BD2d1sZVsCyvNjCLOptMcR+8I+VbGhlkNRw=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(82310400026)(376014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mxcoOdZ2wbiLDwtkH0gRh0p02MDMDCteBcywPu1P4LWRX1Hj0smah5evwDzHb5SOqwdk482gq088sZd+j9QPA4XVdSpuQ6Okqk6Ko1wTEzZy+OZim6VQFwKzw8Uyn3yhL54pkwGeWf7/1PtuckypAL0b7MSPPdGJ/3r0hFfsT81bl+R7k/1Jj3wjv1GKIZmQ6Xm5JyfAfvqmkQwRxaq8g6P2f0GzH6YNxXb9Emr23X5hVZ4s+KkMCNt5bm5VnmTt423yRZjaqVWON9kR0D6sMnlKjwu//3DSlwW5hiP8X7ohSYIcEqdp4+5Ku5wn6PC8P2gW64XAQjCxn8l17aIEfGtdBxF6zSF8T+B1sXKej9wutGREzo7Glzm9z/Zq3J1hYyJl35+Bz7E64pr1BXE9Cq5nNAyJzaqWMBPywCT2UjLMXW25br7M85UxLIB0CLaN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:55:19.8030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0435a51d-b09f-40d2-8024-08deb185c358
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Rspamd-Queue-Id: 0626C53E93C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,samsung.com,pengutronix.de,wanadoo.fr,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7626-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a-dutta@ti.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Message transmit order is not guaranteed when dedicated TX buffers
configured with the same Message ID are submitted simultaneously via
TXBAR write. This is described in J7 errata i2278 and i2279.

As a workaround, introduce m_can_tx_peripheral_submit() to submit
buffers one at a time using ffs() to find the next pending buffer.
The TX complete interrupt(IR_TC) triggers submission of the next
buffer, ensuring strict FIFO ordering.

Link: https://www.ti.com/lit/pdf/sprz530
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---

 drivers/net/can/m_can/m_can.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c2b1da87a9ee..1eb6397b79b9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1225,6 +1225,17 @@ static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 			      HRTIMER_MODE_REL);
 }
 
+static void m_can_tx_peripheral_submit(struct m_can_classdev *cdev)
+{
+	int ffs_idx;
+
+	ffs_idx = ffs(cdev->tx_peripheral_submit);
+	if (ffs_idx > 0) {
+		m_can_write(cdev, M_CAN_TXBAR, ffs_idx - 1);
+		cdev->tx_peripheral_submit &= cdev->tx_peripheral_submit - 1;
+	}
+}
+
 /* This interrupt handler is called either from the interrupt thread or a
  * hrtimer. This has implications like cancelling a timer won't be possible
  * blocking.
@@ -1290,6 +1301,11 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 			m_can_finish_tx(cdev, 1, frame_len);
 		}
 	} else  {
+		if (cdev->is_peripheral && (ir & IR_TC)) {
+			if (cdev->tx_peripheral_submit > 0)
+				m_can_tx_peripheral_submit(cdev);
+		}
+
 		if (ir & (IR_TEFN | IR_TEFW)) {
 			/* New TX FIFO Element arrived */
 			ret = m_can_echo_tx_event(dev);
@@ -1956,8 +1972,7 @@ static void m_can_tx_submit(struct m_can_classdev *cdev)
 	if (!cdev->is_peripheral)
 		return;
 
-	m_can_write(cdev, M_CAN_TXBAR, cdev->tx_peripheral_submit);
-	cdev->tx_peripheral_submit = 0;
+	m_can_tx_peripheral_submit(cdev);
 }
 
 static void m_can_tx_work_queue(struct work_struct *ws)
-- 
2.34.1


