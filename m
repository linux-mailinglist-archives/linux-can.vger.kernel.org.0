Return-Path: <linux-can+bounces-4053-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9FB0ED5D
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FE1188EB30
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60DE279DB6;
	Wed, 23 Jul 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="PIw08VLe"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E62E3713
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259747; cv=fail; b=DNlmqNgRR0m1Ya/TsbGPihbQU6QpazieUX0Qcz21eIY7dCgD5BBV1qWb78c+sCCQ36gXLiBN4xKNxJRhHnMfuEO74wqkvCG2LnsCKTIx4AJuqxeb0H7kyI/2W7bN5ymHU3ouB39OMy1cvXQymezmv36fPXZRtoUaqUAjqwKhomA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259747; c=relaxed/simple;
	bh=G/xDGCuZmaEwDD42RkGTS8b0vQqohBzN1efcMllU8gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsOUpDMjvrQBsR9jRD4pdGYYhgKgewAX8kA75l53kl3nSokpDWkPI1rMUr/KF83Np8+MkAicIxZVHJytbTzgMkQZdXhKkpRnnND265dCtPJnZaf6IszFH6yHoAAptqzdVrs/qJM6DL+fRWqDc2WPZTV4EeP7pUpTvrsXUIaRGxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=PIw08VLe; arc=fail smtp.client-ip=40.107.22.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcxhCnU51pwsDjJ0/gj4xi4UNyjAoZS7imbx2T3P7g4vDVyCJ5FqAIJkRIxuclBlYIt45mCcbKUzhk7gZdHltyJRHklPrTyILZR1GXxuJcCAM0hIhCLyrWmYxNR76YHbEVSDmJsbSQJE58yt56pqLfH3TUcHPnyHFSHO6Dkp2j/dIUnH4Mr4nUhNJv67HzdkrSwkOADjLgyM+2DCBqj+1sryj5lNU3L8g4MlPkUzqOwsJAYXAdgQTPC00ynYKeiE14g4XAQgrJhsU6v5KuMt1SrvG7ZVFYcm7ChOlXiY6Y2CZbyVCsU4pzAumHyYx1ZeVv12xIwSVrMXm38hcZLlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmMTtJ2qJeEZsyoyjerLVDzQj6U3ANwZ0XtD5RzI+Gc=;
 b=HMRGADafNxqlw6FmT5rP4+iik7Q8I2SBGvX90/JJX5rQJYYMhxRD9oP+LMexPU4+kJ2tN3xwWbMWqc7ktA34ABrR6WBOxBmhGvND53IMC297v+jV6EmWFYnE/VV1KF2FZWu1aXXxtNg7sbDXAA/tByI/NRZspm4Oj5AZzHfnD5U1M+Om3pMg4xZf0oA4YyNZLLxAz4ZjWkGAsM5pyyfB6uf4YETuLe9fwtBMV5xtbWnSBKNkIO+n62tbd6ZnxrcT/arwGlNgougPN2coS9L4i0frOx5xc+bTJeI5yayDxr7H1LjF45UVh6gr0ZnnO4a3iG5kMr4hpoQaRNOkzgJ5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmMTtJ2qJeEZsyoyjerLVDzQj6U3ANwZ0XtD5RzI+Gc=;
 b=PIw08VLeYZNUp9poaeJDrTxdr6H2lX36XQ9lmZBtm2xuMod9wkrT5C09DEuFESnoFLpFJF+VUq8qWKQkHgheuF3ToR9NN+GzztNKD+3jmiA3nynIj5F2OdxdapJGYKUDJmvari+C3hjDzFDgoHmuBCUtFn9nQ7NY+6PLQsiI75I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:35 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:35 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 8/9] can: kvaser_usb: Expose device information via devlink info_get()
Date: Wed, 23 Jul 2025 10:35:07 +0200
Message-ID: <20250723083508.40-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f34577-a559-4431-9322-08ddc9c3e4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?di+7DKi0Vc6/j3TzuFwvYzwpL2cTg/ENkA8M4djzCG2cxXkyaOWxtCcUTCl0?=
 =?us-ascii?Q?Clgf9d7lAjF+9Y8IOIfc/RPNTSuvFHwtxBZmGi7HCnQahV5nH4suYTcPLdey?=
 =?us-ascii?Q?kTGzjrGPNRSuS+6NqUq4gFj5sQUK1tSnu3YUshBA6ep2DIawhBemuLUzKQhm?=
 =?us-ascii?Q?e6RLdIlDXQ/hMI6xCtRIlehprqzotrhLBl0njoKG9XhzUydmZKe4ZdfyjI80?=
 =?us-ascii?Q?ZzZ4OP+jM831VxoSd8SJA0jYNX8kROYN+15mdJzG85CbpQWzymVyywEX8ghu?=
 =?us-ascii?Q?Gu2Yc29wRM8NHuwoq40DXtB+eKYepiQut7+jKRDvFgxKbXMOz+DMzmBdwFKG?=
 =?us-ascii?Q?uYwaHyBaAxiK9dlho9Vu7r+iM8GXKNHFatKrNj2mbNNNouPCBVLSXB7tEmtR?=
 =?us-ascii?Q?RX2aw08/2E1P+vOavXpNyBrU/o7C6APp7FyRvL66kbasLfWGnaCezrBeKPdV?=
 =?us-ascii?Q?N97UKLhtysMv3J34wGxKMvG0IG3sKpztHJRT5L4qqW551sVzBfOQJpGu05YE?=
 =?us-ascii?Q?pPifwk+Ifk3JcB4o06FFLPfXEIzNXFBUNTYknUT310Ofw8b7IBiLYkoxbWgI?=
 =?us-ascii?Q?dneXzD1xbzWQKRbivqrtq5iNmh1cCFd0b/wrXVJsO6oEGgwhoABs82G5B6CU?=
 =?us-ascii?Q?Mcg0nrGyi/tqqmR/SeWYkRnf1kONeY5Pfo8ZRF+wAMwT+AnQphMCuOr2iDd4?=
 =?us-ascii?Q?f/9ET7imhIlYn7vVkTw4MIfCRZt7VZglcBW2cl/NrGPyNhaP7kozzW/ksy1/?=
 =?us-ascii?Q?xPPrCQdn/eSrT7HEoC2J55cF/CA64zkGz4V43vQ0VHawd7m1HFHv9YHy0u7M?=
 =?us-ascii?Q?bUxslLVtQ/De28G3TUiSp7tBNxHE1JAJqASG6Ogk2JIh4jH0BjEW25SYs/7t?=
 =?us-ascii?Q?O5vi3YQhfbUso47JKnnrud3YIWfHTsFCxD4vOULYwNw37Yp3pvPu+YkRYAAT?=
 =?us-ascii?Q?WKXYP9h85fTJW4XR0wBTrV8wWJEUksGPRMLGvtwC57jTo//y3ml5XdQSpJ4W?=
 =?us-ascii?Q?d3sRQSFG684dDKCQtdv8bbGBglG1uDpWroJqA/iXQLAV3oF/75vyHqYOOjgv?=
 =?us-ascii?Q?Ax22IuA9zJFX16EXX1YLF2YIVOdNLm+eW9vhFluO+WNssPoID+6G3asEaRgz?=
 =?us-ascii?Q?fMVEUcfhHrbDdy/PEJDRxizeQkBPaIPxqQgOjxhgfsw3VeZ3FE0wqCuUfwDb?=
 =?us-ascii?Q?m0xZ6hf93aNcwHOntzPUk0z1Mv9kWoQJx5T+jUyBmR8fOSBsV6nk082LmUHl?=
 =?us-ascii?Q?OUzI4fIYC3tEF0h6E4sOp7uFOUgEpsJxA3gfWMVcg24bcH233N+Vl4E2rYXK?=
 =?us-ascii?Q?8ojSyLfdl+LYeUG4bpcynOY/ilEt3HWsQow7Ql9MmSRzkSt31vqyKG/dXUou?=
 =?us-ascii?Q?KB5JCrRo2Oo0r1DABv8wI542GH7ZtrJIicI5z4xmXgmed/7NFFKkuq+nw+gn?=
 =?us-ascii?Q?Kc0SXNQg5dI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zQGAAZuQdhs7X2+yzq7wHjj98CW1nqPnMffZs/zOoaGsbypqfqfic2HThLL8?=
 =?us-ascii?Q?+Jx6ZdsJrM7s9B7asuaihegrHz/ALdujepqrV5xVSxsqA8bzzkscXK6TDp1+?=
 =?us-ascii?Q?Y1em9yQt8sTpSOT4+3WvKa63bcVZZLZYl6dpgFTYE3gKax4Dn2NXiEE/t0XN?=
 =?us-ascii?Q?/913Fj+Dyp4OzGBcodb698FcmZKVYm4Kf2KzvGRxmcKhgKrQA+9wXGkPvrR6?=
 =?us-ascii?Q?Mb7Ts4pVG8hNLcU5tCqezvhqRtVEmMEcxMvEokbZxozsJ4NPrIht7vDRMXZC?=
 =?us-ascii?Q?YDXhxhv7c9CLhA9ZEx2/1ETnCLsbcCgH0FM7TfL55FB5IRgSIcvbVsZY+2DR?=
 =?us-ascii?Q?k/Va59rVxdhSyyC2UcnBoO+t3woqsRU0sfu8hQRIAR1jeGxJGzJTHLhYvAk9?=
 =?us-ascii?Q?bBf8yUbERJ2bi20vr9yaY3z92tyxhaenmQhSKk0V3cRHIC98UPoQDETj913A?=
 =?us-ascii?Q?+iE9Ntcopz+il3FfBuyknMI7iAO+FmiptRtcESzhiDkBKceykVE7Zys/bp9D?=
 =?us-ascii?Q?A852Jq4yWROS1MQMXRZBf+HNxzi1KZJ5kovgbj/bLEy61rAGRv5O7UZwjUbN?=
 =?us-ascii?Q?sYmxfs8fTD96R9OPOpsq4tHXlzPK4nfZhmK4yZRrEvbe8NTWS9t8fQIoq5V3?=
 =?us-ascii?Q?PGXAxJd8WuAtzGdBR5SbHROw36S/KH2FDkdALL8c03vhNy4ItLMgZd36MOwm?=
 =?us-ascii?Q?XGWgu9qWsqUmbOk/tPIILCc7d7wFHmmvgXkI76aWeNkFuThAQH9kGB3gX9li?=
 =?us-ascii?Q?Z+4YxObtOIfzho0I/EDPuV3Eukcb9nT1XiuJQRpT+rxYYcbYv+WEUmFWYbCX?=
 =?us-ascii?Q?ONNE+ZeRQRNfvrWbqOyQLA9wK7aXSDvQrioNo+iSb9JBnIrdv7roxu4tb2+5?=
 =?us-ascii?Q?hnHeuwv+tWNRG9Aazbgmmh4NfO6qwDRn3BL/+691pnLftOYtqOajg4r6u4Gr?=
 =?us-ascii?Q?Nhc8PGfqCIg4o3zz9wVkLU4lS/B0rc524x7l0gIi0NdJMVS/5vKpVHe2fIz9?=
 =?us-ascii?Q?3r/rSRtPnkTVz4ove5ABIQEXOlwfdLAzv0cQ/F88/db6YBm3zjz+L29SbVPT?=
 =?us-ascii?Q?wo47Gx5cTjsYH3hAnUb4HYqKH9yF4BliUj8vFslHEci/ZvutYE7waG/OSzRz?=
 =?us-ascii?Q?Ura0C52vEJXTQn4NA/bBaD03eVzND+VlhsMO7HR6Wg9JyWpbVtKE5JwEIA4D?=
 =?us-ascii?Q?c0ZUqNvDdW4cebUpW1Bjt7k+84Q/xl5ADiIZiQLZ6j261enApTXHCXTGtME8?=
 =?us-ascii?Q?t/rNUmikt/s6T37s5FSgdwLl7DHpAfwNhEkGrJH+hetXNzeUqUg4ruCE53my?=
 =?us-ascii?Q?qsdk8xR26fFeQXn9cnMhelUjHJ13vCraauyshvokaNSlYXEEz0FXCXx+Arn7?=
 =?us-ascii?Q?wAfGbrl6G2RbTyv4TWPmAV5HvfCcVILhgcOAypS0P0EtFtOnzP/LVzaoVM5x?=
 =?us-ascii?Q?7riLqKSqcoeokFzFZsou+HFcQsSyWekfjdZOSt52YIYi3BT53Myi783QK29+?=
 =?us-ascii?Q?fDCfFFdSyvX2dO7Idz2WN7nohiT2X4kaeM7WjCBWdlugSDGQLSG8qgS4BvCq?=
 =?us-ascii?Q?KhP51l+sor+84ZtsnHVzUUcgDw5CeEGoL87qfhUWZJ6hpHoAdZ2yzvaYj9Fa?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f34577-a559-4431-9322-08ddc9c3e4c5
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:35.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+PHX3/Bbse8fCGYFRzhDrjb6hGoxvzewR90i+4IpbmhJelDKIBAyWAo9+gQ3zYwen8T/0qmXWF2vP1lpC+kpBnSRcAr98qL/OcOrVRekMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Expose device information via devlink info_get():
  * Serial number
  * Firmware version
  * Hardware revision
  * EAN (product number)

Example output:
$ devlink dev
usb/1-1.2:1.0

$ devlink dev info
usb/1-1.2:1.0:
  driver kvaser_usb
  serial_number 1020
  versions:
      fixed:
        board.rev 1
        board.id 7330130009653
      running:
        fw 3.22.527

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index 9a3a8966a0a1..aca36794198e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -6,5 +6,58 @@
 
 #include <net/devlink.h>
 
+#include "kvaser_usb.h"
+
+#define KVASER_USB_EAN_MSB 0x00073301
+
+static int kvaser_usb_devlink_info_get(struct devlink *devlink,
+				       struct devlink_info_req *req,
+				       struct netlink_ext_ack *extack)
+{
+	struct kvaser_usb *dev = devlink_priv(devlink);
+	char buf[16]; /* 73301XXXXXXXXXX */
+	int ret;
+
+	if (dev->serial_number) {
+		snprintf(buf, sizeof(buf), "%u", dev->serial_number);
+		ret = devlink_info_serial_number_put(req, buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 dev->fw_version.major,
+			 dev->fw_version.minor,
+			 dev->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->hw_revision) {
+		snprintf(buf, sizeof(buf), "%u", dev->hw_revision);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->ean[1] == KVASER_USB_EAN_MSB) {
+		snprintf(buf, sizeof(buf), "%x%08x", dev->ean[1], dev->ean[0]);
+		ret = devlink_info_version_fixed_put(req,
+						     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+						     buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_usb_devlink_ops = {
+	.info_get = kvaser_usb_devlink_info_get,
 };
-- 
2.49.0


