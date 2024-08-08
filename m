Return-Path: <linux-can+bounces-1180-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7DB94C2EA
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3157281A9D
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1906190059;
	Thu,  8 Aug 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="EXYzXYIR"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2122.outbound.protection.outlook.com [40.107.22.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F1646;
	Thu,  8 Aug 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135352; cv=fail; b=qz2C+U2gSU2CQc8FLzcnx25KHeypm5o2AYY0S+JF305jkL8csBG8k+1ClhFbMBt1Fogm9wAqrFSdO0nm56IU8L1zd4TBPZvLsw8DAkfCGnn1GszQEr/Dg53VbSs976aJ47Gg2tvTfvHKoP8pU08WH/G14grUy56Ti1HqJNRmcfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135352; c=relaxed/simple;
	bh=bJXcw/+v8pixev3DGbrxDJVj7iozsH7QJ/bV7c5EGmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Krj5JSB4lP7eOlM/MeKm0S8fJqYT2+/7l5Q3CpuC+zIxHmULlKuaGhPch1zqKF77Akaxb89jn1fU4z0+vIpn4mfnKUocqLXP0qZ20p2QdlI36MelwusocBsMJxSgDfOp/s5tMI+TZFCzEA4lN9p7cwoRt6PDgDkXecsJOAc1y3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=EXYzXYIR; arc=fail smtp.client-ip=40.107.22.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csRrQ98vJzW4DMTpKMVcDjOyK/dX0WfVbdOw/PUPrNDZapY4NBGkk5JPtbTMAjy6bdDfiSdPgAmcCCcw2Hr3ApfuFmQDF+U7iQN/oowMKx6JLT6rN9tiTl2si8+6s/0JjueYbWdWETxFMviRtABCtf4Rdvk3iTcUg/f1alaDCrotiY3pq2a2T+wIpxi5SOhkw00pOrv8LdcCTAPGjjVvJVQglXfaVy48RmSc4FeVooMPEKx5oW77wBlwnYJ7+yjF2X1ZNV/gSo70wwwhl/eEbMEzS9KYMMu3oKO2Rd5ExiprteajY6+0Guo/tsA6E0w9xfewUmzE3qz2HhgswSvq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22hkwKW4f+Ugr5+IIQbXzI3JGI+hij0UgS482ya38dU=;
 b=idS04KLvDEbomAOPKBEZdzwm8Kkm+mcqXqCuI2be+qmyMg//TUYHA7/S0gG0ij0TiVSMerM0lNjoHUJmL7eGlOWJ9a2OJFEKxpxxKBJ1sjQJyRwt4kvdx3Y7u8q8NmrHlDPk2RG4a9ZIaRuOwMLiNAQzCWQqGmMEBaOMy9lkwCoXBoqzggBrqZ+yHXaGObCHei9BCFjNFCFZEyaPN7qYbkzOLn8t1UaYDwPZlbgIf7YYtYitTJBbbr2Ro3PBBY6+71IiF7G0tbesKMHrw22F9BXo4jxLFf1EWGcFkesFezII2wk0ECGZtqaMFUHONYPNTCgxuFklISbkUJ9RcQQYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22hkwKW4f+Ugr5+IIQbXzI3JGI+hij0UgS482ya38dU=;
 b=EXYzXYIRCDSu+8fmWhieTJL1IPn27Dw5/xzz5ojhj5Vz7QanC4Z4hdn2C3MQ7evMDTOdvWFjaCJ+nMHjJey07aOMc3wxEBZjF8AZ1YyBcBi3UJRzI9VxvppjMdFLegB0vPwmSzQXUzX8ygizULHG2s/eXdIhliRGoJc7RikiOuw=
Received: from DB7PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:10:36::19)
 by DU0PR03MB9198.eurprd03.prod.outlook.com (2603:10a6:10:47a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 16:42:25 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::11) by DB7PR05CA0006.outlook.office365.com
 (2603:10a6:10:36::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 16:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server id 15.20.7828.19 via Frontend Transport; Thu, 8 Aug 2024 16:42:24
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 928157C1278;
	Thu,  8 Aug 2024 18:42:24 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 7E4D32E4731; Thu,  8 Aug 2024 18:42:24 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode
Date: Thu,  8 Aug 2024 18:42:24 +0200
Message-Id: <20240808164224.213522-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|DU0PR03MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: cae2accb-9c24-46e6-7dfe-08dcb7c91523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b01iUEgyZDJqbjlHWWc1cWNKK01FWi81QlVNVTVDQTc4VTNuZExtcHdrSEQ1?=
 =?utf-8?B?amNhN2tiNjlBNjNYUDZFVGRZY2E3d21GSCs4N3ZNbmQ2d1UzZ3lGU09WTzVo?=
 =?utf-8?B?dEpqYTlnN0VxVDhUcWs0NjhMMWV4aVZrZk1ObHBjdXI3Z1hIbFhycUhzRENO?=
 =?utf-8?B?eWJyZG1YcGhia2xDNU5UanQ2UmZydU9KZHI5KzBKVjZIQnVZd3JrKzFONVZq?=
 =?utf-8?B?dTNaaG92aHlVT1MvVGFxWnJFME5tMlE0TDZSRWpGYUJhck1hWCtrZGRmaEZD?=
 =?utf-8?B?dXRSZG5YeGc0OEJTZHBPdDVhRTdWSDRkNnM0S0ExZDF1MWxrbFBOTWMxSlp0?=
 =?utf-8?B?MFY1VDBNYmF2TmQ1YXBvUUtHY1NFNnk4WGVLdkY0amhwUVg2aDJqd3QySDlW?=
 =?utf-8?B?c1MvUVRRUnBMUXFZQWdjYi9ldG5pQjEwWTZRdUFXLyt2aVBjalhuNW4yalRC?=
 =?utf-8?B?YVhhL0pIenZ0VVlOOHpsdDhEb3dpbFMzcEhoTVJOdDF6Y1UzaGp4eEhDZGJX?=
 =?utf-8?B?YXliU05tSVJxTEV5NDVuNkJQWnF0S2xYR2I2RXpQbGlLT2ZTQ2dNanAvbXFC?=
 =?utf-8?B?Y1A0cmJva2hMREQ3NjJnUHcyRVNhMDdZRmxXR2VQdlp3eEhMQkRXK0ZtczBw?=
 =?utf-8?B?d0xCK1JrR0I4OE1OeFRLV0MyWGVwOXQ0QlZwc1FMWjI2VXZDcWZ5U21LT1Rr?=
 =?utf-8?B?TVRMaS95N1hYK0tjSDc1c05sVkkvb29IcnJLZnNWQS94cXlNdXptaU10TmdT?=
 =?utf-8?B?QjNGRnVWM2cwU2djUUNGLzNBa3VnTXdFTGFoa1ZpSS9GRTNrRzVycDhJLzdh?=
 =?utf-8?B?azA5NjVtSkpKQjU3UUF6OEl3czZXNTJ5MzBid3ByT2tIckNwOCtKUVg4YnIz?=
 =?utf-8?B?LzkvQVFQcDg2Tyt1MUVLK00zeGxVYXlwTThra3Q4YTR3M1hvTGx3bFdUSE9j?=
 =?utf-8?B?Z3gzQmYrRDFrdjd6NVZWd2IxTVgvWG1zcXoyZmJyaWt0NXFHcko5MWI4bFBX?=
 =?utf-8?B?aFBmK2Z1dVAwOGRkdVRvcWxKd3l4aHB2Skl2R1ozL2NVcFV1TXg5cTZWMkhT?=
 =?utf-8?B?Y0JydmhNdkxJa2JieFdhdVoxR1c2UXFPWEg3elU2YjNKL0tWdkIxVmx1SE1H?=
 =?utf-8?B?QTRiTEQzcDNJSmVlWHZBTUdsUjdSNDlFcnBKVEJUZ0IvUy9peXRQcGRMaVh1?=
 =?utf-8?B?TGJxSmd5aFNicVB4V2ZVcEs3ejlRMldaMUFRTTF6aW90T3pFcVVZbTcrZjVx?=
 =?utf-8?B?WUFwRUxEZERFZWM2eExmL2FUN2NxSmRmaFlHeUwrdTAxT3M0L3JvSnNZb0E3?=
 =?utf-8?B?WjRxdllFdUg0VFM3bDAxdWNtOExuYXN3em4xTW5HT1M0OUEyZEZFZTNXMWNN?=
 =?utf-8?B?T3BwcFFhM1M2Zk5hZnRrd2NQeXFvdjdSdHdUNFdhZnJzaFVUcEsxbXhxc3R1?=
 =?utf-8?B?ZU51ZkowTVM4QWl0QWxsYnFTMEptWXV2cDFlNmNyWXphdEJpRUNrdTdiLytw?=
 =?utf-8?B?SWhZOElYSVRCVmtxY2lldG5jRGZsS1NGOTlZVS9rdnlvdTRLWlViVCtuL21E?=
 =?utf-8?B?UHpQRUdzeG5NUnhMaFR4RkE3bmk5WjE3L2ZTNkhRYUhuVXoyQVcxQnRMd2FZ?=
 =?utf-8?B?bEdUQlpad3pERjNjaVlvdzlaTy9WNGZJSFhQdWJGZHIyMlhrVXI1MlNDUG9v?=
 =?utf-8?B?TDFVbzVlVDdkYnJTbi9GTnoyLzlGQ0VwbVlOdkRyT2ZHajhXSW44dVpnZkdQ?=
 =?utf-8?B?MkhJWWIwYXpwMU10T0ZSL0NNZzhUejFDT0pkTEZ1VXZENTdkUUdzY0xaUm9m?=
 =?utf-8?B?bjJ2WVB5eGh2Z1QxR2xqektHbkF0b25EdE1mbzg1bTl0V3M3d3BkbHZsbjRP?=
 =?utf-8?B?cE9CSUphSDJVdlNGOFF3YUFDOW9oWEVEdXRScDBUQmZKN2hQVTM4VG1zRUNO?=
 =?utf-8?Q?xCP1RSc0sWxOUiUHWl3OmYQ4jsrqfSlV?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:42:24.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae2accb-9c24-46e6-7dfe-08dcb7c91523
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9198

This patch moves the evaluation of data[IFLA_CAN_CTRLMODE] in function
can_changelink in front of the evaluation of data[IFLA_CAN_BITTIMING].

This avoids a call to do_set_data_bittiming providing a stale
can_priv::ctrlmode with a CAN_CTRLMODE_FD flag not matching the
requested state when switching between a CAN Classic and CAN-FD bitrate.

In the same manner the evaluation of data[IFLA_CAN_CTRLMODE] in function
can_validate is also moved in front of the evaluation of
data[IFLA_CAN_BITTIMING].

This is a preparation for patches where the nominal and data bittiming
may have interdependencies on the driver side depending on the
CAN_CTRLMODE_FD flag state.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/dev/netlink.c | 102 +++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index dfdc039d92a6..01aacdcda260 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -65,15 +65,6 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
@@ -114,6 +105,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err)
+			return err;
+	}
+
 	if (is_can_fd) {
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
 			return -EOPNOTSUPP;
@@ -195,48 +195,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->bittiming_const && !priv->do_set_bittiming &&
-		    !priv->bitrate_const)
-			return -EOPNOTSUPP;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_get_bittiming(dev, &bt,
-					priv->bittiming_const,
-					priv->bitrate_const,
-					priv->bitrate_const_cnt,
-					extack);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
-					   bt.bitrate, priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memcpy(&priv->bittiming, &bt, sizeof(bt));
-
-		if (priv->do_set_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->do_set_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm;
 		u32 ctrlstatic;
@@ -284,6 +242,48 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_TDC_MASK;
 	}
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->bittiming_const && !priv->do_set_bittiming &&
+		    !priv->bitrate_const)
+			return -EOPNOTSUPP;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_get_bittiming(dev, &bt,
+					priv->bittiming_const,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt,
+					extack);
+		if (err)
+			return err;
+
+		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
+					   bt.bitrate, priv->bitrate_max);
+			return -EINVAL;
+		}
+
+		memcpy(&priv->bittiming, &bt, sizeof(bt));
+
+		if (priv->do_set_bittiming) {
+			/* Finally, set the bit-timing registers */
+			err = priv->do_set_bittiming(dev);
+			if (err)
+				return err;
+		}
+	}
+
 	if (data[IFLA_CAN_RESTART_MS]) {
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)

base-commit: ae44fa998ee280303ee5dffe99cb669e4c245706
-- 
2.34.1


