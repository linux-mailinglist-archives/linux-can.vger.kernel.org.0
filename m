Return-Path: <linux-can+bounces-3063-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B1A60F7B
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3909E16F380
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733312AF1D;
	Fri, 14 Mar 2025 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VwF40FeC"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B916F271;
	Fri, 14 Mar 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950039; cv=fail; b=QZhVIXwoh6uhlVkbvfRQxLcIMMM0oWM1f09Go0kYzMsUgJobQHLF8kKoxUbefuOYl5MtJPLIF6TEm5NU8PaonM38KN0HS6O5PWe6gz7QgZYxvUPMld4rbp4N/q+5lvyv7SvvhWkR/SfFeSsgYb8NNUkzWrG/bXzLU5P38wMdKhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950039; c=relaxed/simple;
	bh=cBQ2PpKrKwLdCgzNHZzHOZYi2o4Jfn7/jDkFQTrw58c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EZrOgdD8zhsXyZhq01MbYcom4K1cPSmK7ZEr3OEGQ8tmiK9ERqJnXEqgHdHqu1l9fOLdBukqBTeTSy9gDoctpE+ZyXjA9aS591CMPpULrbUh9QN38e8e0ewOAixQkKWDQV7BFbonx3oC/t49hZmB76V6V1YrZqkmcvtqhyyh9pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VwF40FeC; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXyWW5DZiUZkbi6lu2ACiNJdgk+K97Cp/fMroHd1O9ZBwPKCOtZIqLg4Tk4f8/p80/Gk1z2r1SvyRXhxwye/7mZYhXE3KW1uRCLU4JJ6ZKP1eeuJsADlYEfLjys7YwmwbrVhatg7+uQqCVNKa6lMS1TmHlbIRSmrJkEupdYR70ov6OouBM6jLWfUxtaKIyvqdRWYNGq9RWvPChFfBjrF2UQZbNIxECOV207w8C6PgwWn/oTe7CCH0Ku8mKII17TXhZSoDDQZvdzZdX9HsK/riMvZyr5zoyzN8yuoQIc2lRl+0RzrUMlyMuA9Ww8jFGIOBPOnegwpiIqNqvmfYPuFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qyUfj1PkwM4YQesijSPV5olPWQwiWjo3wbQNSHzNZ0=;
 b=WGcRIeX7S/488W1VryzX4hL2uiOtbus2pbWERcRY9Znt4c+4ONwRXr+bpObgHWwRQbaekZo7qzjXe+TktjEGitGtgCItdUr5HJwuH6GiTn6iyYInWS2u56yQpahP2xj8ZDFZwhCWvWvgPD+jhLEAabbMrR5S8BJw8uc3C5klSv2pWVy/SK3KyxFaO0fF0U82DdUrJYTgpQAusZa6QhXdtUnMcGlJZ58iIjfpULXKp9GhNTMQxGgkuFmHvUnBNWhjNOU4YhtqGYuLlOv7VYNpD3K0SBlVm99fjoLb7cdPy87GJD4TjFrBuEEtTgLBv2NZ3kHmSGhYXz9MgcUnmA4+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qyUfj1PkwM4YQesijSPV5olPWQwiWjo3wbQNSHzNZ0=;
 b=VwF40FeCBhGhcPzdeFhcdgQQQZ2NeIZofMbXZhmEg1nzVv+GlXGoPckcSLlYCtrUNgm+6cMSvCG12jmJVEARuMiQdrf8YRvIuLlcrmWvE01PAuXzXyhYG9EB+9fDAUIWk28IrYO6HiDX9NZD0PhshcdCPLdk5nGeU9o8I1u++nIJq90sYtLLsIEJsAijGtfYKyv+BUUk3l+fiZSs5nQDSdT4yKo6EJZe7K6EHFB9qZlFk2cG1Or4jaeB54wdYBfQBLmvJhPryO2eI+CYAegJoNwrWSqSjtzGtblet/rHXhdhFPIn87jKKB63lIITCw2PcuC+eLpMZV6wV31UUJQfqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10166.eurprd04.prod.outlook.com (2603:10a6:800:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 11:00:32 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 11:00:32 +0000
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
Subject: [PATCH v3 1/2] can: flexcan: only change CAN state when link up in system PM
Date: Fri, 14 Mar 2025 19:01:44 +0800
Message-Id: <20250314110145.899179-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: b4b353ea-eb60-4cbf-a11b-08dd62e77052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kB5tayo7KmZqv5zQJ7u8h+tbW0gy/nSb0j6vYZKt2T+Qd2n7+CWqVHqpL5Tw?=
 =?us-ascii?Q?CU5+OmGJL1xBysaF+UjEf5ESUF7Mr965/LM3wSokE+pieiaXY13QNOcJMgAu?=
 =?us-ascii?Q?gQQ8zQw5KKcCDRmnYVbfk/Nx2N/hRYGw+lueEdwMnLWsVXhHJ2RxcP6HPCpL?=
 =?us-ascii?Q?cDfko09HzVlAQnvEgZq8lFzAElJYG6AFrlVuErELWmZFS9vwT8zCf7dC2PAD?=
 =?us-ascii?Q?0+q8jmYr5sN6Y7Ba/Lltfcd6e61dtz61SqSKRkDdNvHliuirjqJ313gLjnGN?=
 =?us-ascii?Q?9Z7f1Rdj50vdxts47y3cTcyUsL1YQ6PmMCmhFEB3/x523tYTGjqbhc8WnaEf?=
 =?us-ascii?Q?bDvC8VZXjkw/3zmzwKnyDAde7dD0YM/qfzLqC9ee5UAQCdPqIHBETDk0OnV1?=
 =?us-ascii?Q?mZuU1Ty+PILczrsGR0b0vWXpIyR9QXIGiXYMjIcoV2xbUtEio2TJF+ShwfTJ?=
 =?us-ascii?Q?IgsFXMLz/suC/TFOV2wJYBpphIzHPCn2w1qwE5n80yLKEKel6b6JAgCpfK3G?=
 =?us-ascii?Q?P90yDzITC5lZVRdGS+FyegYJAm9+XLhzeYB1M5KpVnXhrON26kf/Z4IuFxhn?=
 =?us-ascii?Q?uHR8AwSIqBdLe8x4sDSJvfuh+tWdtYH3TcOGAJOH0gNdlrDZn46cHt/m/1PK?=
 =?us-ascii?Q?GcMM2GoXlJ3JMP+T8LlaMDOfBXMLvqIfMh9S+tpFE+8xLAp6ZAmB8wz+z+zO?=
 =?us-ascii?Q?nw9vrCy4JiKVO1grkM3lJ1qqkSiLgc/GVgoJ9aSTSeUnEA3KJACdEDAdyNVK?=
 =?us-ascii?Q?mdLMS6j0TWKURh/pZEJeaY1bxhTQjWWiOFDxuVQhoZrRwK4YfELXZB7xjD7r?=
 =?us-ascii?Q?ZGbiHmTGHtXNgculp0aI/W1JPAjFbN8vWv7QhV9ebZiHgh4joP5pRcNqw4fq?=
 =?us-ascii?Q?bJQ8cSlJVQe+5ovZZ+RL1DwneocHroNTrslwrThjGVGDwCHb+5qlECkmeXkK?=
 =?us-ascii?Q?Axov9GzoOoTu3w7XOTd0eT67thDpWiGUDKu/ofxk5TMdeI9+A8bx0WdzlzTW?=
 =?us-ascii?Q?42YYgMSRf3pjVZlVqinG5CaihneaSHkqCL/CiuGBkGK2Brk0Mh/rt0FGLTqn?=
 =?us-ascii?Q?4evrgifSjjqNYuTDRDmLBo0Oc4E1cFkFtuysbYGSng7f8mCX5vG5Abtomgr6?=
 =?us-ascii?Q?dWbEyxwWabD9I7wcWqCPACeS2tCVsUERQPOhCy7MVH0H081QFpYvzhpHYCr7?=
 =?us-ascii?Q?xZ6S+7xRh5XsGCJv0PzZTaljRUe78Dzyq1Y9/Hd7s9/WpDeSwmWfESBfghD5?=
 =?us-ascii?Q?ID1ViZ8c+YzP97UrxCLQi8nXOi2lO9DN2wfbLHxsuNU+2ue1PvtNiMf3Z+ZL?=
 =?us-ascii?Q?KB3gGhQP7uBd3xL13SJUJ7IPdVhyrRcxUKIkBjPnGUzcwn/YDY1Gi5rgJpyN?=
 =?us-ascii?Q?DX3L8CeCY02/Iride4XO9ehPfBlQFvkhW+35wVol95nmvN76UKZ/+LIHDrs4?=
 =?us-ascii?Q?AwNF2ITckp4C/SM+rGjyK1aRn9VHN5Tk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZr/xuNWbWChRESspIiM5ib6PN0Poh8y6iHKs6Uqxs19MoX+CuWG3cFnI0Wv?=
 =?us-ascii?Q?RIFwNn7Y1bM5z0ZlTTCMbjh0BTtuyZr4J9/cMonXotBGC3jxAbsd6zZwoxxi?=
 =?us-ascii?Q?tLFH9qjREZEFkp7zUt3jipupklWhITl2mxob5iHwgvZ+qeVbvOxI+5B3bh2I?=
 =?us-ascii?Q?ANwsGCcFG2wSkwshLTkNJW/wXdFQjhyf+TPPz8u34hzk9lV4E/u3x1PgiQs1?=
 =?us-ascii?Q?ofpBw/QuDp0Eih31+cmnyADYXSufGK3J9y8QExY7Os1G9PsPvtIF97Tlodpu?=
 =?us-ascii?Q?aL/LRsL+Z9Vbp5jyjHDqCr2SQpViJSkSDhvE97VLIrGk7cgzprZy0qVuSgoc?=
 =?us-ascii?Q?vsCfYmq3hfzQvjgf10lXAFVngtSwkWjKipgaJvLMUtzwlbI8i/rKnCo+NUqV?=
 =?us-ascii?Q?nUBZnagxjKEw2UvSZLdXFIyb12a4SZijIWpB2eIoavdwfoa6rlrD2HXif2Dk?=
 =?us-ascii?Q?5ZtuPzq7PW9vMPo7S27jW2t3Yoq9w6UD/qiBcPAz5GwbEO7qKjV8FHbab4vv?=
 =?us-ascii?Q?gVNSA+8X6EFvrSpo6Owb/4TIdgZOhLbEOVSJ4hNSrDC6OpYDmetXASC81bOw?=
 =?us-ascii?Q?CKmvzrnGiWhOoovWBFeGXVbPYvdFh1MguRnkKDZPuNDvxUwI10i8+Yt7OR5b?=
 =?us-ascii?Q?eRgRIMeE5hd1tJjxFWvip9M5VhUJSjj1m/j64+TN1uEZT5lSxVmlYAjKxd+G?=
 =?us-ascii?Q?QTBzkOdTiZmaeoxsCShkEorYHexGn7yXtpONNcqZWrEdnPZ2C0JEH7d67vjR?=
 =?us-ascii?Q?cGgd1n2a2EhNKjOx1aUy5VZl88LD2350w/ZcvBDGPbBOqXZr+aEekeHezUVw?=
 =?us-ascii?Q?ik7dxTI96MfIpQzJGVGjbD/lnIbinnYi46RE2p81Fl40Ki7krfWe2Ixnccvq?=
 =?us-ascii?Q?1boCo++AKtAOxTo9DNDD8xJ32T6nZiAvtGkL7Z+x9p7Z26D/frpJR9GGr5q0?=
 =?us-ascii?Q?H0unb9MwB6cxVPFvJgKYrJnYTLeoM5/vEFSeQ2Vo/CkmojEmMwPXU0bEp4uj?=
 =?us-ascii?Q?Nz8abu2EDRC6RjZSBsI1yJBLA0dGtWwSty4EN7LVNGOMurWa4mU+H1Zl6M6s?=
 =?us-ascii?Q?dOe78yMQU1WR4/DzAhT3Rooqg6z0O1Ez3u5WfiIsnaiqMPEAnEor4DVtMuU1?=
 =?us-ascii?Q?ylSvo7ZbOBTxyh03dEVJJU6fizTRl1OfwUGHDgv7YJqvojtyFHQS9hmyccaj?=
 =?us-ascii?Q?AZzCqAMh3nSZp5Lw9rp8wewsZqgxoPUPHmpEMq9PGIPXmHj8n5JgC6kJBwgf?=
 =?us-ascii?Q?pGTILN8Uf68hpPJdxpNhIjl8d9L8CxVO1KL8MX51ujWr0rrWh4hVFt7Ks/94?=
 =?us-ascii?Q?D7m3bGSFQ/4a+fNps+Eyh7H96icIYihW2bvfFjaDjwbLxwMXIdUlZVFo5U0E?=
 =?us-ascii?Q?KLza69ri4QM0FLsvqmBLOjHTric9kTDAnZtAti5VlyT3xfbBSNWzgcdi49Ia?=
 =?us-ascii?Q?Rlsfn0ELyxUewQTBrJuomZO3oH225cZuArjlArsJ4V/eoc8w58krwTeC9QN0?=
 =?us-ascii?Q?4BfnZ9Eh7b+/ha8ZQ/1MiKcAr4Zglp0qQT39de4OW9/p1JblG2aPIi6lajGl?=
 =?us-ascii?Q?wRYU0za++WYaX7Sp22jvyz2mcHUbhMBbJNu0uzk8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b353ea-eb60-4cbf-a11b-08dd62e77052
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:00:32.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTjOCzsEwDkTrRTpwzosw3cmv4QcndputxTKKF2F1tYdsXMxu/4DBPUMQPvYqgUkzEPFh44vG39QuQ5LUP2fJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10166

From: Haibo Chen <haibo.chen@nxp.com>

After a suspend/resume cycle on a down interface, it will come up as
ERROR-ACTIVE.

$ ip -details -s -s a s dev flexcan0
3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group default qlen 10
    link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 1000

$ sudo systemctl suspend

$ ip -details -s -s a s dev flexcan0
3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group default qlen 10
    link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 1000

And only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process
has no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.

Fixes: 4de349e786a3 ("can: flexcan: fix resume function")
Cc: stable@vger.kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes for v3:
 - only handle priv->can.state when netif_running(dev) return true in PM.
---
 drivers/net/can/flexcan/flexcan-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index b347a1c93536..d4d342d8f490 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2299,8 +2299,8 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
 }
@@ -2311,7 +2311,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2331,6 +2330,7 @@ static int __maybe_unused flexcan_resume(struct device *device)
 
 			flexcan_chip_interrupts_enable(dev);
 		}
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return 0;
-- 
2.34.1


