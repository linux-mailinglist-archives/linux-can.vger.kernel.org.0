Return-Path: <linux-can+bounces-3064-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FAA60F7E
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32703AC584
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9EE1FDA7C;
	Fri, 14 Mar 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XA/AmnPb"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CD1F5423;
	Fri, 14 Mar 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950042; cv=fail; b=NVimdEkT5UPyCaz8/mm6oK3es/gIBiOkci2/jFP9HHR86RojWrN3jTvbdyEpWljseltqBDHttzxl+8EUlcbT9Hy9pdmgPxqvq9KKEwr3eK6l9mubak5ldgXlZIz1Chkz4iTairYajWaF9L5bOpt5zedzrSHIxVq5++55jo3MCC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950042; c=relaxed/simple;
	bh=pba4Wb1ddVp+IsvcSfE4REwJ6oyZAsHB/mVyT1N8LUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fM272o/M3D0AhuVILUjR2LK4Amqi8JZaAIDlx7+M1xEKmMSUC/Z9Xf9PHu8py6F+xQSvzmDE+TpWxYSNFkezNMg/JG1Oyc7PmXzaRCL1bQfkhdFK4iE2U63n8qP4PZuNxTuENrW84rY2J6wfD/7wuPjdh36740HtRZm2Wos3/ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XA/AmnPb; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSQ2Dprf/HXrSGRMR8IRTLJGTvnXMYtToSeGldKdshoFtZx+YJTOKuDmHoM9qfS0m8yNockf3Ih3puE8KQxOnsWrDcbxRwy4AbURq8WHovv+RbtYroAE9aWwqoACKGY4tp175VmfD8bUBaaWMezIm40kYf2PMx3uNq14yAikLtBcmq7ZgnKhX0uP5566koazfpnbDXwgaMFGHuL0yi9OafyOB7/dGB/IDUk7pfcwgIS4T21Z6w86uflZyQE+eTTEMenRu9vDRtcnjih1ls/sS5ixyExZesyRXfJe4zSAvHQuuJ1kE1HsGMLVd+HZ/ryoE0WN38foWnkOwkRiuxsUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4ws+icwu8gtUrA+iWkueVcJ6LldYqCMj5RTCBJ66/0=;
 b=DZpKGVCjgwlzMEFgkvvKjTQs6yTj1xhQtkjnz0z0UhxSHAdRxGLTsgn7T7sdV47MnvXYapfxtskLi9YWloaP0iwsTcmqaz9t1UVum+K01RTtY2+uGef4DM/qtJ9ZrBAhR783n4ns4h4LhcStGUk3WurVMSew8L16Sx6/rkjx1Qw47Jg1aXD6RXsaEwgiLW3pTdhxhdSW2cUYu1AQle8VNkMNDRvPcVfLRABfM2LecSOv8NKJJX9gcBXT6khqSLjD8VDCqFI/E7xPs6sGpISGETa+iD0R5R1U5sFMHqSRHgGvxKlyCV9c8lrQEDpGPQZd9Uqk2X4fTwcKcy+J9EUOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4ws+icwu8gtUrA+iWkueVcJ6LldYqCMj5RTCBJ66/0=;
 b=XA/AmnPbJvAlyt+nSq9OOJbqAZN8nKwmDdDB+Draji5jRFiK5w+oD6hzvlllUeWQ6ggRG2JpG4ONcq808OWSlZUMZLY4JU40UX/d/you23bLAOZvsH41ZjtXGOC/VdCnzhBmTuJvgByUMGRL2th4S9vbpK2H9x0lLMDVG6dGVzWNPxWDNTNn9Rxqkc+dGiDmOwtl1uGS9be+WH2hw/a57EtnJZPRNLEbFweQCAJPDVT//eMZ2D1LpwGo7keZphM+uNjWWJuz1SDHAqV6R6dLadqPlOfLHHv58LhZAlZsULYJciNELYPvnyaPeMoOwbtvHxI07Xw/ecM/nYMiPQYZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10166.eurprd04.prod.outlook.com (2603:10a6:800:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 11:00:36 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:00:36 +0000
From: haibo.chen@nxp.com
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: haibo.chen@nxp.com,
	ciprianmarian.costea@oss.nxp.com,
	u.kleine-koenig@baylibre.com,
	fabio.estevam@nxp.com,
	festevam@gmail.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	han.xu@nxp.com
Subject: [PATCH v3 2/2] can: flexcan: disable transceiver during system PM
Date: Fri, 14 Mar 2025 19:01:45 +0800
Message-Id: <20250314110145.899179-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314110145.899179-1-haibo.chen@nxp.com>
References: <20250314110145.899179-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI2PR04MB10166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0c70c6-314f-4364-6a95-08dd62e772cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QaJuNuMXzXmMQfigV1CHdZW7jlzwK8bCJb2X6mxhwlWh29ARUpzAC1w6JMV0?=
 =?us-ascii?Q?eEoitykvzQUvehrMEHFFXIMB3RgBVbllgUJZuHy+Fz3jQiv6S/rbr8zOJXST?=
 =?us-ascii?Q?PYsJb4huGIhqTxy/z1VEQxy1XPAYfhJGJBfzUWGPLEpN7uLM7VzuXy7vRHcr?=
 =?us-ascii?Q?xo1CR9WUuB2eXyQ7J5Zoff1mHJWaad5agMHgYBciZq28fuLdjWZsq6fNpZJQ?=
 =?us-ascii?Q?+bw0J8IQdjZPI9AjXx6ZmMTZV04WGIDR3BaFRczg+XPv568JbAv6iUusOvgh?=
 =?us-ascii?Q?CJvA+cghpOOIifHY/vQh7j7C2o4lsWjKtLNr2/1KyzpeY8yJ8EQXPGsQsUEN?=
 =?us-ascii?Q?h1OJaGAOjbA/BSDkYqtykBgyw/vhUtdPXbmCjmgnAvaHY2QqrvyZbn8jLlwj?=
 =?us-ascii?Q?vkwneYgu9wdY8bgH7f83u6GvSzNJYrW2JEgWmFX6CX4DxkmXYtCl2sOhhAD8?=
 =?us-ascii?Q?PIbHQw/9BJ98ew8ItRA76Dsk7MtApQv/r2Vslj1OqiFllsV6ZpdPuDSKY55y?=
 =?us-ascii?Q?YChjk+aycvG2hjBUfTwiVH7p53pyNRAEINSHhd58WbIdpD3At3Et8EdNNQea?=
 =?us-ascii?Q?A67CA05PKmOJc1YfdmR7VhA2kRJ/SeNnhDhM88+VFx4VpnHZtjyQ9hNeRN/p?=
 =?us-ascii?Q?7mTaFf/opFEw+mHcfjgl1XljUzlh93xBDGnP3OTbaFlJR/kcJthQPGnpGhNu?=
 =?us-ascii?Q?LTOC3sZA/+FJzM6wastowtENChp+KDKfSrQx/xajHfWg38C4UXnXywH/yGRx?=
 =?us-ascii?Q?t5lrb8+65z9mWY0scanFZTFbYsP4IyY86RivGhVTIu4Iq/XM8lLdBRqELjUu?=
 =?us-ascii?Q?we7Wje8SMSEUDlNJpNEizNyCMMOG1GKflICpNgBzIHXUEw1EOFmB6g6DtYF9?=
 =?us-ascii?Q?CruL7VzwvPJO1VDqmUZNZN1LiXAllVci7VRU9/XvH24oNdrOrkJ2O+tsW/vO?=
 =?us-ascii?Q?XZnVxKcgvkrrPnUnoDhksFQr5/8DyvF1p+2jEZSzSWGGIcEPBzgjTBSqBRmW?=
 =?us-ascii?Q?sWjp/zzez99O1WRRRz13BbZshhmGMuV22nLJ70zBWT1oCmI1MJJRK5wbHLUN?=
 =?us-ascii?Q?ZviVRW4fZaR0aG7qtFMf+1YYtSobPttXmq1sdqgV5c7VhHcEfXcrc1eG6b+g?=
 =?us-ascii?Q?fRE0UsXyzqkBw+NXhy4rbxql/2k4XKTj4mTaofvls+OTt7q+wQDUz+q17T1K?=
 =?us-ascii?Q?Px5TgYhFemrAHRQC0hGADHK/085y4uK2WxpZNPhlFdOqu0UY2rpH+9gvRUAf?=
 =?us-ascii?Q?472a7bKPV/xegTMA9YQj3nrFjp0Tq4vIZf0TxfZdrl0HOrNSH+GWjXTv0bHA?=
 =?us-ascii?Q?nA37VZedfrklyZfxjZSloe6c9qf80Kl6YCDp8D69XYbAaXy8yY9gxEcVsPNb?=
 =?us-ascii?Q?4u/whSBMoWRBBqCzS989YTQS5W8N4g7vCwoIyZPIjDY5rwQsw7OoGo5L48nO?=
 =?us-ascii?Q?RP/y6p9CDYXvI/vUqEhXA+eg9TpjYncc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQ3aD80aaKX9J02MzkbqFZpwiDyAd9A/8jsQ/X+WzMWgH+nmwwH3hJkTLm2B?=
 =?us-ascii?Q?hp3B9myO/9EB6uCeKwAPr6tOdRf8fc4/K/vBUBR5t0vlArza0FlgSmf55+gu?=
 =?us-ascii?Q?sfLzlWQkr1KhHQLh3EO4h6CP9QhWG3j85fW/3flcp9sPLkvh8aihBDTIvyuL?=
 =?us-ascii?Q?O2oVRwhkRN6ALvlnp3F61eScuymlzrYyQUsarbUz1yY+y2yQ9/CF25FdY3/x?=
 =?us-ascii?Q?mAFFhgZNetyRKN3G4EpCHTOQz0j5klO6GKZn8hM3gFAY4hxXPaGp97xc2Mdn?=
 =?us-ascii?Q?H/zEbsURoBwFrz5rMzPBn+Pe7N7pecnS/X76U4JlI4K6NEUK7V+6rkt7izAW?=
 =?us-ascii?Q?N+BsbicXoJtsZyXy61Kkqme51CMNq01mPezm6rN8hW+NvwIAgwj4NK7LeN+S?=
 =?us-ascii?Q?IkTFB8AFpO6z+i79UV1E9FOGVtc8jqLqWaIVzCbCBZzu1dXZYviN7eP/2yBZ?=
 =?us-ascii?Q?Rx4BKBQNYAGvQiMde+U71hXeozixo1o0Cbp/uSJwk+VKIrjNeFuKcCdyLDjB?=
 =?us-ascii?Q?roIlXsBk6BZNspNjPveq6AZk+yQOnTdLG0WUGwuBbOmJZAXW5PJYp9OMsOtf?=
 =?us-ascii?Q?tGWATpT6gf6QsMhCI86xS4bz5oXc2tB4+5spLeRab3pw/iPqI0eQhnt85VNB?=
 =?us-ascii?Q?eXYUkbAfVP71vQwyHQIGgw5ybvn9dGNhMLmElyT3jc21MOTQK5Es67IR1ESV?=
 =?us-ascii?Q?NnxNW9AUt8qXUbbAH9zSCS+u7yGAsHR5kyjrHnqRpIw+xTLZGtMJ9Zd/EOFs?=
 =?us-ascii?Q?1gbFo7TjI+jbtagWzDTEn4rEO/XuSnBioT7tGi3ZIQiIKpyGvJ0bMx+OL7bQ?=
 =?us-ascii?Q?Iosvo1QJTNLt6F3tvNYLfNHo6F9uHndP5gA/IZA5J6137v0/CS9Ik299GTMs?=
 =?us-ascii?Q?R0k53P2ylAmJ/OLBiepOiVN1w2a9X1a3Cj58brvNhpqCAARIqAb0jimBotqK?=
 =?us-ascii?Q?Q07bOzIYFr2w8MfqoAx5UtBl546btoecF9LK7PLk9ODEb54mZgcyv3SC41QV?=
 =?us-ascii?Q?3dS6Tufc8TU36zque+6rpMoCj7T6GK+bLGlit1cyWh+6M/vwlbIdxn7fIPZb?=
 =?us-ascii?Q?5B/C7WBYM8eXazrc7SjO4hLlzuRjw0aYV1X3M2PChmcpkvPxYEiccj+TK0YJ?=
 =?us-ascii?Q?3DssnxvJmPEJs06GvRf4JlhtCqP4dI6dv8z09kjuW/Cy5scj3FYbGEAUrf1l?=
 =?us-ascii?Q?gLtK0eyJMb+Ov5x84pqojytYY4i5UFnLB8QiABP6sqNoUbEaSoSSBNqjvDyT?=
 =?us-ascii?Q?niJf/PK1kvEgGrIpNsTz9IAFqhZhVFTFKIAo7i8GcZYAgMNn+fovNScPrHQ+?=
 =?us-ascii?Q?QsSNPgDn3yq2xGnWXNOu92qjO84DQ91YsiumF652xpQFGVG7nWF9SNcLFNwu?=
 =?us-ascii?Q?h7uV3E3aWJpkOucPqG9dNaufY2QbZttNm9sbIlJVaWm5XDwojO/m+ZkGOawk?=
 =?us-ascii?Q?pqpCiCdksT7cJaZbuTDsOnV1wBGlPza8SvKfqzEh9MjazofSIuSEf8rPm2MC?=
 =?us-ascii?Q?mNzLgsVP0ynq2aJfOlD/mn6xItdQCiPy3E+Q4J8xzuL2zrrM+AZzzef0EPLH?=
 =?us-ascii?Q?Abs5uI9f32Oki6Uc06SZzJYoVSKCDDUSfa2M9wlx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0c70c6-314f-4364-6a95-08dd62e772cb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:00:36.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+Bg/2AAGur40K+Dlj3Mo+LQw5kL2EhruhgpwBYhnYJCUn0sdr8pYZXd6Cd5KUv35Gg1oU7ScLwpmoS1nb6itw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10166

From: Haibo Chen <haibo.chen@nxp.com>

During system PM, if no wakeup requirement, disable transceiver to
save power.

Fixes: 4de349e786a3 ("can: flexcan: fix resume function")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes for V3:
 N/A

Changes for V2:
 - add return check for flexcan_transceiver_disable
 - disable transceiver if flexcan_chip_start() failed

---
 drivers/net/can/flexcan/flexcan-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index d4d342d8f490..491f9548c7ae 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2292,6 +2292,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 				return err;
 
 			flexcan_chip_interrupts_disable(dev);
+			err = flexcan_transceiver_disable(priv);
+			if (err)
+				return err;
 
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
@@ -2324,10 +2327,16 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 
-			err = flexcan_chip_start(dev);
+			err = flexcan_transceiver_enable(priv);
 			if (err)
 				return err;
 
+			err = flexcan_chip_start(dev);
+			if (err) {
+				flexcan_transceiver_disable(priv);
+				return err;
+			}
+
 			flexcan_chip_interrupts_enable(dev);
 		}
 		priv->can.state = CAN_STATE_ERROR_ACTIVE;
-- 
2.34.1


