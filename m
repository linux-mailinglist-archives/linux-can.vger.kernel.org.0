Return-Path: <linux-can+bounces-873-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFAE91C6EF
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9031C21DCE
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB4757ED;
	Fri, 28 Jun 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="NJFyTCxF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9A7710B
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604557; cv=fail; b=Qa7M5zB9ObW83is7NGWGZQH7l9pzukAfxpB7mHZaWO9zF1wHgsO0uWHACiSbImYhDpF4Hl9JrDwx5D7g7u6nc4LgT1IRg1U+acI/wV66vM+6nK6CezCc79g0e1vUj0uibo6dAcifbhd9CyDb7ioUoUqkF57/imd4UDUqpqHYD1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604557; c=relaxed/simple;
	bh=kCwmyeRY7CLbvKb3SQ46Rmevh1y9waSZAE84/LLIObA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h3PUGY/f7QqtbiAYl4J5/tJ6bWyaPIx0LjnF682wBHZwgd65OJ+ftpTSlriDpavNQ5Af7Zqw6s7CRtF5kgQDyszBA95pj02zd7KW3qmRuh727NiKxvzsUvFMJhQaxB3pPgxVeBgbiJPWf5WtsKozvp6YCfP9trJJQQvmawPzXAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=NJFyTCxF; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msQUi/GwwH73y2OMeZvHCOG2F798TkhDH03ACNRukOXNTZuaGN+9sSeHVJKA2OpYzoWWDAbgDgGjsVl4guT6czkGvv1F0hgpXIh+Lb/uLwcXuBzT72W6ENbJ9z/xV8qebNEWi0sqp67zJhLdcW4/2V/WsQ9Kfx1nNga6fBdvsCoFUPZYO+uNOqBX29vdDvLmv9dYcjTjDpLW/GKn/FTg0+JNLo2zidU2Hhd8UJSiWbP4xn84GQ9G37qQMFLT8SYL6yGwwn+ln3ZdZ0/01ZUYLXzsv9r/+Jx4VfUH75xbe0yxK8DtNcSwKvMGBZtQVy884ZF4cWZS48m4//NuCq/hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZuYan6TrV1rsjrIfCvh0QQGo+MSQ9/33sRK+VoO57M=;
 b=RzbQLOBt7JhpDamA+5AZFiOJJ+/xm04qUFDiOe6Hp+SoDKDQCMGsETOXwTplpzCjzF3sU6bkZpH599322XS7fuw2lNJ+LF7xplL7DF42HNneSA+WxB8SmKPDDBEEhEdx5xqDkOjCuidCBrQibeS7ZAoLkY+lhRJRltiKg9LGAY6wnbpF0gibvGi4OlR1EyImuJQOKjGDsIaOB8tRVWkVjh076NKgKpliRwh5EqvWiyz1AbpTTz5og43s6470b8gfo9ZFFZ3w/bmWoypPV3YAKp8Sid4jlCodU0NCGdIzkABtLymSUrSKVotwhGSImHmgxLoxed7otGGYoJp08QOWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZuYan6TrV1rsjrIfCvh0QQGo+MSQ9/33sRK+VoO57M=;
 b=NJFyTCxFNbEYGdmc7GjO7gILdrPj199JK1I2cd9cD3aH9+bDQ+E0D7FynCOqR9uwQ1We+R3CpnYpGSjuWrMb7D7tnm5dFO70UHHK+biMZXYjCmhYI0QLVCJSLCOXj/f18XFtjVEEYCX15uxC0bBIoxPUI97rSCeF1exREeLa1Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:44 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:44 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 06/15] can: kvaser_usb: leaf: Assign correct timestamp_freq for kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz
Date: Fri, 28 Jun 2024 21:55:05 +0200
Message-ID: <20240628195514.316895-7-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: c061f1ca-090a-4676-027d-08dc97ac4c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/zrlnoYrt79AJOl7fXxSNA32yL6JlKzF63gOibhidGsTd2JJfaokYs3AlFN?=
 =?us-ascii?Q?by+VNXQd+yPJSlxlWAwAOgGiqju/jxNcnF07+oQ6JOwAuE8SGj5HPjlwfbPI?=
 =?us-ascii?Q?EQJYQ7v74A4ntEyC/nFlDS7yeQmRYZlETCUH91UmZNZ08Xyhe9HOrq6rBSWT?=
 =?us-ascii?Q?HYxu/kzejCi6Hf7V9Sda11d4t6z8EmdNH+XK5MHQLjU0UqoAUCntrSDn+oyp?=
 =?us-ascii?Q?jCehl9eaA585kKD5uWPGa4o3RD84P8NVOzNr+m5eOv9L5+7M/d0AJjrMhiKX?=
 =?us-ascii?Q?3FmNor34y/CiPFthf1XRzJRDLHJdfSSJ2XYxxZORvuXZ5ZbFVB1mKtS51HeQ?=
 =?us-ascii?Q?nXOAxYF7kGyxwEcfWTjNHbOASSNVq1pxzFE0H0+uUWEFnr5wd+LQZ0gutXrO?=
 =?us-ascii?Q?NVHpN39HKiXamRlP/fzdExKs/hAiIeesaRyK4qC/NRZyWDCXTXqusnWfeF/0?=
 =?us-ascii?Q?b9p74sOpsa3tV23qqb96fiTiPUuPAqSatlA24ZhOdlyDHV2mYe8aKFisdfA9?=
 =?us-ascii?Q?X7m7d6B2XGS1h5Ame/MqfPBhv4GxKNefehtcLQagoMj70RJPTdsG3OhBt0k8?=
 =?us-ascii?Q?+MsJh7AO2gzC5whSz+UAL4cfpcZuXoondoMVTNSsmE8bXxTShOChvdzMHZjO?=
 =?us-ascii?Q?i0/wByzD7DJV5znGWYUAVoSOnw3rvv3r25VuZ/fS/whQDsa51gPDjetlKJ1U?=
 =?us-ascii?Q?lnfzbosTYeZpwPUXiL5NPooY6X40hUPIB4WHeSjhtuHn5g75Fgth19ZEO5XI?=
 =?us-ascii?Q?xgyPO+FqL4V0cc2gywVhMORYZeHNSFm4dTOHXsaIkmPDc6ul99HBD0ifCvdM?=
 =?us-ascii?Q?YPfv6bZ3rKJTwXubf4bVHY0Tn2zcGtq6DecAzLQ1BDKPSQKywtqMNh1qijom?=
 =?us-ascii?Q?fg/mIQ8K6JTSDURyoMHy2xMYoTlNXdKQKYb5BQ4B6yDb/GsvKFTk8XER18Ww?=
 =?us-ascii?Q?kjWSI42CTokrEZfierQdWWIMZjIAPiqmsK/vgwMVYHavwyOfQy0AGqOyu2IF?=
 =?us-ascii?Q?A9M7RCqyC/braCMZBkkk3Nal2s4EfTwXEQShkA/a7XmaYAqiHYkt4oRr6PpL?=
 =?us-ascii?Q?gke+iXhIk+gluw8+365WbVti/NnQLSuB7fb88Z1DGPLN9LQy+sAdxoydRIc5?=
 =?us-ascii?Q?+Wh3Kz5Pnn41c1MJfn5qWiNvWTTfj3py5X1YNCcSslli7UMsUVhqqZRdaZYv?=
 =?us-ascii?Q?8pQe6M71el4WOsk2pCunKMrx+BPL2b+yT7rPT0uh3DtSncY2hd8qL7h/XAcf?=
 =?us-ascii?Q?ajnlG3umRP6q+r6pJffklPu9941w6nsOD4bgLYaZ2CCDs2PYobZF/oSm5Jjo?=
 =?us-ascii?Q?B7UvItYa3LjfCilDANBWEIVsMlamPIe2XHgZBtHMD5d6qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZaenalRp+civ5dAKa18cW1unBYB86Mgmp367xFKEaannbcwZD0fMHFrCjgOk?=
 =?us-ascii?Q?IJmXgKOIhVHj9r6Vb7XtVDdVg+Bo6ikrPl/GoJR467TvmvHNuEFMe+A4yqDk?=
 =?us-ascii?Q?sgF3arg1c1oF1vxbtV0kqmCIL01RaPeyu1sMSdG747JcLS5zXONuvlGPOth7?=
 =?us-ascii?Q?SGnajzlFzmEuahLvwcGgAs1TOSzPFfhp8x6Wapfi0noYXEWEhi8eOsqDC7r4?=
 =?us-ascii?Q?ScEXwsWWesD6LdVR4SoDDL9nIjAO6jRrreW1IIqxzgbQKoQqcRDFHZZrocUJ?=
 =?us-ascii?Q?3lKLCiphAmw3yuW4DTWfeA54k122B1LeoYym6JL0hvrMUTdENb4QblAKEpa2?=
 =?us-ascii?Q?iT7guUgx1CHIK0yRtJf0bic49WkRAjbzblQtMJttAkt6+c1imAVU+fKBFDCl?=
 =?us-ascii?Q?Bf8Bd4Saw+QH7WQzt2YRwaYy2DlqBTym1M79+cQtFmToAUg2jXKju7gvUF/L?=
 =?us-ascii?Q?OiVzms1ecXxpdHyuRg4fdrJqSgpvvYCaKAkNletuvX61OuNd4m0MsuACboir?=
 =?us-ascii?Q?SFENVmI8XdgUj18X+guKekTfb8FpxUj0qeSVI+jcD407pq3N7WCNxN1pTGQ4?=
 =?us-ascii?Q?86DY1TQfwP7GaL4KsGHJI66MtLmajVCkTjt9vA2UBuwYBT2sKTr14R1sMoSL?=
 =?us-ascii?Q?Djzt6g2MQ7xvyYQm8TVabQb7YZYg6zxKySBfSc70Ek13/YJ+ZbkP4oCe9CcO?=
 =?us-ascii?Q?Go8Ev5x/ZC7VUhq5VBL+mfXtQzqMQMIJGJ/hZd73J7mTg74olzt+LrELXN3O?=
 =?us-ascii?Q?SDBHpA+3aSv3QckhrMrOpNkA2oq12iDv2/nE0jCCGER0TVPT709pLUBWVNkv?=
 =?us-ascii?Q?OXjU+bLaKA2IS0vf3ZWPluAltbFBfBMZJKPQMMpA3/5P74TSHz7l+ikb9Syk?=
 =?us-ascii?Q?2+FgUBfFx2oYPRpAfcdvMdix1UpPwtxzV6ttTHWgGJa/fwEcAfVhbeyS39sa?=
 =?us-ascii?Q?WT77HW75ixN8gBIJl6p9U21m2fpWMByMprVGb87O3H84ixMWHAknFG+xjDcV?=
 =?us-ascii?Q?q811GpOwVJSl680FR5vOPKU1wtmR416jGWCYcSh9r3xdTSyebU1wskOD4vXX?=
 =?us-ascii?Q?FRYW5mNf5W4zw+DAmBQhskihCJQo/MzyVqmr50mtmfLoWyYP+cCRTpyOJszU?=
 =?us-ascii?Q?xp6khod7XUlQbD1BnOioWKBjtLnSzlZhVhDUTPQj2n1Qn0J0dB+BS2j48F3a?=
 =?us-ascii?Q?SKpQK+FpSF3pvrRXpmb4PEbHVulqULnAd1SOp903FfhqaJ6ld7a0pvEvlcev?=
 =?us-ascii?Q?ImM1yiMwW+hjOQ2wkFnEK8MywqGpIZ+3c3RwjPOVb0qFuaIETA9ZoThOSAgT?=
 =?us-ascii?Q?xz8vKVVB8aRAoFCjQSdxlsBQkWw9bRRuoMCCIgEvXXIGlSFdb5v9ajh0bRu5?=
 =?us-ascii?Q?2bBoFQLiUi9XpJjszOEsD5h0xUHDtW8ktoNdIxD4pnkXLhzvlgeI6RrSdC3t?=
 =?us-ascii?Q?Wa793y2vbcYy6xAnbIZhPZZQ4R7H0yYKcRN8ox2Tr9pxjRMHJmyViHWwyj//?=
 =?us-ascii?Q?7gVTlRJo27nFoILs6qPOSO7VLdyrfksfBVBFHQCrwM1P8MFeO+Pl5j4RtOGU?=
 =?us-ascii?Q?d/y0MX9aBgbFL1DGdavHMfyDda+eia7kNiy1480g?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c061f1ca-090a-4676-027d-08dc97ac4c0e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:44.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKxYozwWfVZPetwo1iYmyYSQcePFl1iDQf0RrWloFIT//bLGx2D4TGvahU0ZOViq8l44m+Lj6hCqQ3EaMbc8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Assign correct timestamp_freq to kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz.
Since the driver didn't utilize the value, this didn't cause any problems.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 70511e151a3b..00fe7410e36d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -483,7 +483,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_16mhz = {
 	.clock = {
 		.freq = 16 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 16,
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
@@ -491,7 +491,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_24mhz = {
 	.clock = {
 		.freq = 24 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 24,
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
@@ -499,7 +499,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_32mhz = {
 	.clock = {
 		.freq = 32 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 32,
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
-- 
2.45.2


