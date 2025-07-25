Return-Path: <linux-can+bounces-4137-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6BB11EB4
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC04F16B060
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91C62ECD17;
	Fri, 25 Jul 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="EHnxipPz"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABED2EBDF0;
	Fri, 25 Jul 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446910; cv=fail; b=hZEIk2Ks3mLLRp3vKL3kyehYrrSFGQNU5TLRqt1qmm1E4DTJsGcPSkjkGcdhzYNEo7OvEkr9W491qZsFM6QYRwiWtPmgeFf95HtKvB8fk5I+3I1Dlt4XhHdcMaEFmDfNp8+tVc5uT6iv9d2jvAayPlCfOXCrCbPU5E4VYZVmki0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446910; c=relaxed/simple;
	bh=pw7Y1+181vl1ZhkGGEcytt0Z0OKjFMM99obeHQog5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSrec2duYEjy95aEwOOWzeTZWZIGaeUFUH6KyCKfRU481wl0KMfBIop73GHD+knVC3EymuJpIsxZPaaqTo9knPWiNq7WevGDx5KOWgtN69y4GqEmHe5CQR/JSFgwozSeVcmWlSw08FNPKn21Qm2AKnkTCSihEWwRdcu28h0kfMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=EHnxipPz; arc=fail smtp.client-ip=40.107.20.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGv++C8CAnk9XUJWGG9+TgCEjtU0hr+dX4vCgrxEHVUx/YvJ9zIyA+wdFcQOxPgSYnVcF9+nHs53VX1+hozr0xvOkrlbt5UjEvWkwzpaDZD4fAqW3w4JrU92WC0za/s8sVoQEFvAPNuulldPWuetrc6MooZnWkdsEWf4Bk/YaYTzOnm7xd0C5piGum6ycDIYoHwtwqpIqs3cBF3oJXdg+1BCz+FxVwOxHTEPOEPTrStEjv553ZsfQDenBR2FQgYQ737Gxud3OaTh5Ku/28WGn23mYfl1a2f58mULR5snnSOg2KJCRTljDq6sWKxIl02Xr/tOyxpSvZnli3LKRPdIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P9dpnGjgiN4AhzJbDXfIKv2O1oUyEoqWLTpdY1AAZ4=;
 b=X291F4yJp2mIopHcyUbBawn8yYhH7TtDDPhwLrY/Z57T/k4+q/9zzADm8YrCWoXu+/OcFaxnA4hCwHxYkIFkLD5ov4+QyT+tCtsN+m5kscH1pc51g74Gh7sPQu+M6hDMUVNDUGrxbYbFhh5LpL8VBJUKIIsWr1u19VtV/pnpdbMPrvrr76/eMyuOy0RAtvDbzaUmtePv+sryrDv2uYI80j2UinE97B+toACFm/oUegwSJJsZbqcLxWBN0CZKztjrybL3zEQpGQ2gG+KjVDvINlBSsB00wvHRB4kdfPMXiXx2X6g+mz1p/mkywxpqqTdxpDMQ+veTXIdpRa+X1+yJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P9dpnGjgiN4AhzJbDXfIKv2O1oUyEoqWLTpdY1AAZ4=;
 b=EHnxipPz5hxmxyRYUWswkPlSGfsqvvf6CBZb/U+LY2+Xbo4yOMceKu4OhAPAXM1jqtFh5lXcVimfBriYy7EEL8RlxUYmzC2ESp3qr77o9rSqWVFziUe5hNAgxvcd6HihE2jOIZSVL3RmhtqachyUDlzqiTAeDijEbTSIhjxUL2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:03 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:03 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 04/11] can: kvaser_usb: Add intermediate variables
Date: Fri, 25 Jul 2025 14:34:45 +0200
Message-ID: <20250725123452.41-5-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfc3aa9-c1a5-4722-3504-08ddcb77adad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?71OGTXuAiAUFbW7oQRikv6926YQv0fQDKNI/mADzFaY6Uq/fm5mTKE74fiZA?=
 =?us-ascii?Q?4fW9dtWAAS8S7OWJNCuqAKUTEa4dVyEJY/JXRP/5H6m3lfRzHJMKH155/JjZ?=
 =?us-ascii?Q?/eNknVi9uldtDx4YwnN0adsgaFA6bXxEvanZtPTyGVOlL2HpiUx9zLGXk9Cc?=
 =?us-ascii?Q?oaAOpRttdPhNp/oNfGX38lTAdp5bYIWqgzq02LrqG102psIm6FAhq5xD6Y4z?=
 =?us-ascii?Q?mxt6cxMAscxwb5wZSWm8Rw0Lp7KAfgOcJei2oSpwpo/XrT7Oz+XemGLgOqrS?=
 =?us-ascii?Q?sfYPmdfy1FLDtMPtuQH2mhXG7OIXGHyrSd4sVtv8HL9crtgVRo/SlFbDRAx8?=
 =?us-ascii?Q?qrVyLeFJ42kQU/jZA4wzALCPRhc7dfRAyaqXu4AmLc/Dk6OD+7tyIm4RMy6p?=
 =?us-ascii?Q?yNjOI15X7DuaWwtzfkCmu1i9XWnYukzZHXylQ+O4TF4Ia+XzLQhk3e3XU6rS?=
 =?us-ascii?Q?e9NLtU3vTeCJMFtVxnKkRsbCbdxHUplh+fDdK5h/s2fGdgPjJWj01uxs+Dkn?=
 =?us-ascii?Q?/7zjpapgx5tBQN1aqLlHM2R1gMKsjgDb6kjzOJIGxlhtLiM/RHYRx9Yn5ghn?=
 =?us-ascii?Q?AW9wIP6DOjpr6leddAvLO6w8UM66H1hCUMsnCyOAPYtTm9kCoj8li2/MiMTC?=
 =?us-ascii?Q?QL7DNUaYpypJIiSW0hi4Zq396cdg1RSYDlYhFDX8zWQIvViKGGqMYYjss6xo?=
 =?us-ascii?Q?c2CyNbHH2/7u8D7iFxFj1GpVDFgl+OceUaPuicS/U4HtVlehVBEvzdw020GW?=
 =?us-ascii?Q?JLskUUhvyOo8stz2U+WcALMejzBOtEuCNYa7GkLQLSmRFOLuS2WAacCpB1TY?=
 =?us-ascii?Q?uvBAkZbu3qWwr8eG1PKdEl5gsnm0ZYw/+Hr5gwGTcCshH7JY0yJlOkv/tcHU?=
 =?us-ascii?Q?75JcH67e0jJXVhf829Iw46FCAquVn0bGz02igxEiw+dJvPQVegXNfHRlBlHh?=
 =?us-ascii?Q?IZaGkNGX5kGDr3/sZfoLnDUi3rpqTZq4lHB0OAdGW7ZOaTTYjYP6BrNVsARW?=
 =?us-ascii?Q?yXNudraw3BrGrvGz0RRh4tZCeaezJPtblWbryOhEcjkPVcA/Kr8zVFgboRqJ?=
 =?us-ascii?Q?vmDQjClEqlp2AErSIFOxn3mnSA4t0S7vKL5DM6Ea9FP0L92alnGMOHLv619T?=
 =?us-ascii?Q?UcBskLVrQruGOexoSFNTivujDj6weZcCs7YeRFf7RpLO+IG7QHMXQrf/2iDF?=
 =?us-ascii?Q?StZQ1k7uzoF7zfg8Bhv12l62N9RkhfDJyWlTG3LJOYWnugkPBSjNDdibG9LG?=
 =?us-ascii?Q?unZFuBGVYs/VJ2aldLp2UUZ4+eAqOnFFjaAcfc05juDZ+W3cM4uKiZihaZlU?=
 =?us-ascii?Q?wNvqerPwCWrSmpPAMHbYC3lxZbMrVGIiG+L8HmiKeL23p2JXWffpiLjef6i5?=
 =?us-ascii?Q?wSzWeiTQPNysrYiPxfRDVnTr/z7PO3EZkQsEUtH5qIZ0OiPe/8chXHM5Tjut?=
 =?us-ascii?Q?Gala5dymFto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UIIOfEAb6OQBa0Pzn0WOJdUvtzx77ZRn3es1KIOqDyPqa9v9xI5PYaNnmmdZ?=
 =?us-ascii?Q?UYzqttqBL5b2rKQsehc9z6Y9e+qoi8ru1zOSpojCY+FPBgbhy59S6OxOWH29?=
 =?us-ascii?Q?i5g/rc4lo+e5SkG9M+pj8n1h2fCWAX2nDGOxIlRhV2OYlgnfVpW4wXnlt7ud?=
 =?us-ascii?Q?fTv/MMXI129yJR7Xqymz0USh4tE4YhGqS4EkfoXWMWDWpEe2VMeyUddXko9S?=
 =?us-ascii?Q?mFiX+rLvX4Ur/YFRZBzc1CNltinkBxeLAjnRi7MBOQmDBr8tljDIBRkmDsex?=
 =?us-ascii?Q?SUTaSL6/aiXbkfc12nxUcXFL3ez5PtF1gD5oeqjsGTxx8rveR2Yqa/tBKozO?=
 =?us-ascii?Q?EuUeXDJQzYbCH3PSMG8pOtU47n3QVQf4dpnKlod2md6T3Kw0PWASRYSg5AmZ?=
 =?us-ascii?Q?W/rYaq6GU2Wb0OgaHV8/EZczL/eITNiagwRPtBvjETQZmwUhktpxoPBxRHbr?=
 =?us-ascii?Q?p1VItrFqSZyo7x6TZdKtO4r8+FHJcBsOvIJoJe9wp7Y0TplMvWvgYmRSDCT4?=
 =?us-ascii?Q?cdSSBA/t+QXhY88R/jXwwFz0MKIgBe6JFeL6+jSVDflIZD0h61b5acprJ9KM?=
 =?us-ascii?Q?+Ul3ibmOdRPVp2d7S6wgcDYmyn8K2t6v6ZQOgHo3eKpKojOH2HWJahhh58O0?=
 =?us-ascii?Q?qxduJvflBSa6k5Iwg8xfNlGTAiG1p44hYLXedi3btgYzZNb4hfd30T9xQ76J?=
 =?us-ascii?Q?izpmgsrMieSl0B+9w/cm73RR2MCsvQ7AvB5+xGXWhuYJFX6qvCXRKUrOBsji?=
 =?us-ascii?Q?1lnSzGF5I9W4qp/1A/FJfhZ5g2BEVNtILfZSJuCXZuTlbcT3E8rd8NO+aTn6?=
 =?us-ascii?Q?MVYLegqmOU4SmV0t//IMy9Uihn/rw/e06TEePqppLuTZadzUZ0iHkqgp24Vl?=
 =?us-ascii?Q?XfM8YIZeRmekCldlP48SrU+RM7IxHx60MLpwlIy3i9mFJufN+Qq2gmbdfH5o?=
 =?us-ascii?Q?lxgG3vMmIC9V3c7bq22hmQbpmzwlZCEW6VyTlccbPncP7Gyw+xbgLUqpOn4K?=
 =?us-ascii?Q?kD3q5BPXZ37YEYhrzK6CkwMpi/OKuPzGOmGslwcldYjdWg2HfJp/S++928ZY?=
 =?us-ascii?Q?ErxTwLH2HM8IJ18Pw6idbJoxdwZKUKeoRtDOk7yZv4jVZkLeaCmp7RCBesZ7?=
 =?us-ascii?Q?64QohvtCfBA17zBAek1yD0n4WKoYgPbuDsmgQwwGwlLgjC1dAaAn72xkJTVi?=
 =?us-ascii?Q?XdiGJD5mkTUZEqcZA8QY+NngAQikxXJRc4YxoYZuXlNGb5ZclPxfVvEpD11A?=
 =?us-ascii?Q?OH0+nHtCPBvRR1ViWwZyY8ivLVJXOMRs72Ox0+D8ZjgFLVU5sBDrlDKsrCzk?=
 =?us-ascii?Q?qhwQQ09HZVDqpgLrpvU/L8KHrDzMZNMaS0UKNeUGMNvaxy+T0qajP7mmBp/u?=
 =?us-ascii?Q?vNxYWcI0FxG0UuBED/wcP573vSwKCbkRyJHZLuNS3lt0Ii8E+OWey7988PRS?=
 =?us-ascii?Q?NPrKCbiv4+kTd1RGUHNtsHPbsBjteHhKC42IUZfqH545J46pIqGbD17ORJH+?=
 =?us-ascii?Q?lJbjToQlU6G5dq7bE/WspiKONjTr2kDAAFhkQKMnFRjiu7RM95DjZdd+zt6b?=
 =?us-ascii?Q?8l5MUAHhBwFEFsP2FGP1TpnHUIk5D2bZ356cIfuzJCPvyPaPbhk3Zww0n7xU?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc3aa9-c1a5-4722-3504-08ddcb77adad
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:03.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eA0+lCyOgPToeHeapvLrObTV85GfRCaXlMFiuJHPEcAwhXImN578jXKDZz8oEAcUBzr3otG9TEXDNsF3GGN/PVbwQWw2iLvGRJMxZfwIXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Add intermediate variables, for readability and to simplify future patches.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Add tag Reviewed-by Vincent Mailhol

 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7be8604bf760..46e6cda0bf8d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -364,10 +364,13 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err == -ENODEV) {
 		for (i = 0; i < dev->nchannels; i++) {
-			if (!dev->nets[i])
+			struct kvaser_usb_net_priv *priv;
+
+			priv = dev->nets[i];
+			if (!priv)
 				continue;
 
-			netif_device_detach(dev->nets[i]->netdev);
+			netif_device_detach(priv->netdev);
 		}
 	} else if (err) {
 		dev_err(&dev->intf->dev,
@@ -795,24 +798,27 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 {
 	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int i;
+	struct kvaser_usb_net_priv *priv;
 
 	for (i = 0; i < dev->nchannels; i++) {
-		if (!dev->nets[i])
+		priv = dev->nets[i];
+		if (!priv)
 			continue;
 
-		unregister_candev(dev->nets[i]->netdev);
+		unregister_candev(priv->netdev);
 	}
 
 	kvaser_usb_unlink_all_urbs(dev);
 
 	for (i = 0; i < dev->nchannels; i++) {
-		if (!dev->nets[i])
+		priv = dev->nets[i];
+		if (!priv)
 			continue;
 
 		if (ops->dev_remove_channel)
-			ops->dev_remove_channel(dev->nets[i]);
+			ops->dev_remove_channel(priv);
 
-		free_candev(dev->nets[i]->netdev);
+		free_candev(priv->netdev);
 	}
 }
 
-- 
2.49.0


