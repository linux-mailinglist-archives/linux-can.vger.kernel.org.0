Return-Path: <linux-can+bounces-4078-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815EBB100C9
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CA27B65FA
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D222FAF4;
	Thu, 24 Jul 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="ZIDD440C"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F722B8A1;
	Thu, 24 Jul 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339052; cv=fail; b=K0F+cQtHoYrwK+1Gbqz3ex5M0fKGJq1N+tdglasShLm5oroVKtm6nLN8Fn+t/lX/Pzm2L8CmLZoT87COsB3sude+hSD9jcB6uEHkT6bw49D49JmQ/LlLPpi3QL3DFS1/YTlTZLsg2aXAgvt4SbGbGjaF1yVkVsTAySGbOziywh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339052; c=relaxed/simple;
	bh=j6TZpeF9SZofO3tsyazSuN7paz4RkXCjaOQ3dg+DSYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeRYElTAlfsoH8RRr6Ug8vN9rvASJWyKiyiTr9z82GcNMsYggdUzZByQEbOVTl1w1K/BzfoIjwaYqQWPBHzbn2A3HU5b66NvIeh5CUVmfLbvyprYd2CAz1q8GjLAlQ4Mk3v0vF2LV8HbcbteUUpOW2+/jhOdolU15tJGOvZEImY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=ZIDD440C; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Prpz15DZlfeGEZEz8W2zMfkBQGB0AbwypIJGL6euuBMnjfmd1EO+VADOSYLWdFCDh+OH5h/bGbzd2hZn/l6zGxRwUBl5H42EMjatzUx7DM+Ue0x/8vkvfygUqWmRTV8OaYxlbGPIyxrzx4u07DELoBOvQaEgWvl4qko6bv9GR+gaRiOm+fcNZcpzbGP17gGFQq4c2HbyU3EFKcLUwZM2UhS+sYEbWPqkGdRr0nIST+Ht7gHf44tZMon305zV7XvCG2Wd7RsK+M4WDmmwJv+iS59+fSXHWRj/LcNm96RlFkch7XHbfg1ynJdJ1uKwZX8dMlllpgrU8WBHXkxnYuxSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwrHUsYrM8MXNZs+yOMxNBxyG/wHLuyHD10dLiZ6XwY=;
 b=G1ClLTdCXplXckG+EGSh0dsJmK/yzVMwA+A0Y96blOK2QNDsI4+g0ftOuPCsT4sN8+OoMUIV9zIgeA7sYPvZEiW36VMZvlgZgQQ5lKym//XP1GcEBrC6ZL7ibJDibVoZTiSd81ux0II+rNaL2d57ruZ3W4fyIDaEKNRApFGlSwDXdZqyJdNSnX9MUvfrNH4YlclsuHNH/72YoS7qVuCvO4srRjxzPVsXGS+ddF5WFjmdFgoJzr6GbW/sQos0oaS5OBqWuVmAeRy0oMG9VV/mVRWA1R6dnxwwoclVFZnmIvIJXdBjCbqYsjsi+t9gPk/xnURJL/klSs1lLs3tBdDo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwrHUsYrM8MXNZs+yOMxNBxyG/wHLuyHD10dLiZ6XwY=;
 b=ZIDD440CCeRn7qV5dC64l2cKixoT7qsU+hs0XTjm0uSKMm3d9T1jV/r+VU53HQU3Lzv/WjC4Vyt7bNJBbHSPfEJlmh9ez1TfXNurboVbRpO2h3cZZcjbMGItvDD7Uxzvba94rCewBnw4Y+sQER2Km1psvcFOBMZ7s4IU3pBewXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:20 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:20 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 08/10] can: kvaser_pciefd: Expose device firmware version via devlink info_get()
Date: Thu, 24 Jul 2025 08:36:49 +0200
Message-ID: <20250724063651.8-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724063651.8-1-extja@kvaser.com>
References: <20250724063651.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM0P193MB0562:EE_
X-MS-Office365-Filtering-Correlation-Id: 5298e1ce-bf7e-4ec6-992c-08ddca7c8a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIlXH4ypiclPswvu4f56aP/QcNiPxbbPCLj2NSOdQQSEJP16x2Yc0LfQ6rju?=
 =?us-ascii?Q?QvYG9QVHoMEYv92eadWAmmej11JE//BuvihSW3aZLPMxvHNKA+cNWTRXSfRe?=
 =?us-ascii?Q?ixkw+hSCQc1u4wxUgqKFRCf30sdFNpPumlTn2rYVkqF3Pju9nNdSPWPbX6Jx?=
 =?us-ascii?Q?szm/PPRxGnvOq/EKRxexbyLMnQcDabDCJD+aqY7yBu7VSfvSw8bJFn8Wadij?=
 =?us-ascii?Q?5eDU52JAaF6sDnjH3uADmXkJ1OvVRIBn9IPzWu7pjH9svmqnzySb/A06MgMd?=
 =?us-ascii?Q?aJ0jYzPhJYQCeV29ewqmjhN/wiO5bm0ShsCQcT+DPE49LkG8JHUGN6sm4GkM?=
 =?us-ascii?Q?M/omas16NoqunKSUqwL2xfYXgR0IwEWUrwUKlHSr6uSed7vyS3p5l7pCs3F7?=
 =?us-ascii?Q?5Dy27N1BzEjeQyFDboCBHeLQBHM0h917x2SzfyYms/JhQQEBc/ugZF8rfW+W?=
 =?us-ascii?Q?3yngheAzy/yD+YGTELQiYx7xvs/qGP7seKw6IYN0K4uognB4FwGxn0I1Nae8?=
 =?us-ascii?Q?bhkyHh0bp9E9GmDKqZw1/LWBNMA9t4fp+BRIlMvAfYpA82Kb6H/U5Uts42Cz?=
 =?us-ascii?Q?xVexApN7HaugJzaIeQeLdQ80P/GNWagjmwCCwESZHvnvZHaeylXtjcofky8w?=
 =?us-ascii?Q?+JImgdwkK7Z7eNmPukvJpKd/qMwif5xWWPZf+QYiewpT4rp/vG4tUK196gxr?=
 =?us-ascii?Q?RFimIlzcoV8jNkdkJGSirFD3opUu0aLGiV3p3XXJ0hgGjXv31oeoC+ARHOQO?=
 =?us-ascii?Q?Y5gf2YiluQmM6mR3B5pDNYeImxlFoHbwnLtH81zjxTxCFJ3MWjlnCPzTg63Z?=
 =?us-ascii?Q?6WhkTdJiQGYVUOsNL+zMS5ZXc80GDDqeqiOr4DqRdhJNyi2rDV2aFjha2j7W?=
 =?us-ascii?Q?27K9jQHuFgVVSMVuBOounZqvScBIaK16vAoCM/w/n4QsWFITMtbXuhYL/q9F?=
 =?us-ascii?Q?xJNNaAAFjJXI2Sy4Ou+Wu3ClyfA21OJz5zKE0Gab8a16XQaLuZzlphCSd5C2?=
 =?us-ascii?Q?ZclsiD3RyFYghnn0Pqc0mw/Pfwk0XqY0lBlVfebDeF4FTWaz+LV64DwQIo/v?=
 =?us-ascii?Q?doCyt7cxgz6CYOre5yzHxsvJr/k3akB6txvhXbociwyjwrgAKuy9W9ReC/KA?=
 =?us-ascii?Q?g8wN3Le8UwK6xJS4y3bs4tqDLUapAkGx+Habzt9NAkFqqu0djn0qSWwamAMc?=
 =?us-ascii?Q?gwUKg/tBpUVOZI1QSZQg8EPZUga4nT07UHLmoc9qJyInICF6/EGN0hRjeI5z?=
 =?us-ascii?Q?85Nmo/p8J/m7LKW1e4oLLAaNSPd6OJ6oWrP/OAdCdxVfNvQK4I+GW+kbcGuB?=
 =?us-ascii?Q?Z+42N0Ygri/SMjcfFhjnvKYu81aO0nMm7KGmlml9cyP4NiuEND5tBPKnjR4q?=
 =?us-ascii?Q?g0udy/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIXwAp4vE63GH5vvw7z3YMdBQnuCBGz+i8Eaen1wr+mR3GqK5aU125bcDZUG?=
 =?us-ascii?Q?fMoH46GP5q/xcCinmmKXcfLZ+EFLm+6xM3nOLdQ24qV0WUarW2keHsddjzjs?=
 =?us-ascii?Q?MmUIaDHsXD/mFSb532TtDHf4QRSUm5FzFSPe+sgoOEMWL1F7jLz1cs+AkxW4?=
 =?us-ascii?Q?5ajO82cpQS7PzT3HdPMDPug3nrP39XeG/ERFS8GuN7nPL7qM2gT8qliJ9Ocg?=
 =?us-ascii?Q?WmkrtA+eogJJk1L6B2WkpcEGbDHLNbET/vvumUMpif1HJjLS6VT0unprWDX9?=
 =?us-ascii?Q?NjyYHf4Bh4UoyXbVgJOY8OX20c4/QuRFERuOCIhZ93nn4hMjGKW+UCcdDv8I?=
 =?us-ascii?Q?USKysEQLzu+UBBBXK4Pv1bXGaTY/p3Y85513f8N7ohlURwvcLCMo09GKZXMX?=
 =?us-ascii?Q?xAOc9nZdfzQ8cN3+12Oh1fkCH7RytjDKhL6kNkYZG3PpUTZYM+SGn5EvL2m7?=
 =?us-ascii?Q?XL3Q7uLNRCpumX6eLsOuwk1vqlnL+l9b/FhLhHRGtj+fngbmvxdTGgRY/6vI?=
 =?us-ascii?Q?nvQqLqu3cZn0AxDZ+5qm4lSNV6QRPkruW1m+JYm86m1gpeas9JnghXRucZHA?=
 =?us-ascii?Q?h26g3WKnQDMWoEzCU1+QJdliRfJoYHYM370ubF8nT15VAtu0KDPoXI3OX3DW?=
 =?us-ascii?Q?I+gpdtGQRCU68lnlitGQsfFg97POXTUVSMznxWJi5KAzxxC4fuL+ajhG1kCB?=
 =?us-ascii?Q?cDPhdvYgTOq13frBCXvq2XpAHafaiXYxMTtgrRLzXIsRxIkcayKay5C0Oqau?=
 =?us-ascii?Q?i8cOVeVZKRmJpZXzoTkfc7T95toNRInvnumrXs3n2N4mq0n7ZuLjW6Tb58Gm?=
 =?us-ascii?Q?XgN5HxjnGDhHMC0rGnw0xi+spWjDbsbdbn6cynXRukz6Q9qLR8yr4zfHyODE?=
 =?us-ascii?Q?telakxQT4zkQj6FX6m6sZQMxI7xrVQ10mJSzLxT3z0/mlCVFu1LQuZDdORnW?=
 =?us-ascii?Q?j8qUM/vIFRb4nAWfO2mZRF1ONcc0t2ecP8d55VNJdjjVkIF/7kLlZDpwajIz?=
 =?us-ascii?Q?v0jA+kjeLCLo7Jmd5epLSXd0MG2TL76mkImUwsdFiQcQryGP+VfFz81VVdpP?=
 =?us-ascii?Q?IWl1W0p1skKrVyE/eQjcFikWOVnmnrbWEHdGOAkgQQrOnO1UvczqQzbOLHOp?=
 =?us-ascii?Q?1QKEiCfvumLdRzEUk5sYfNyQ5FcsTEDdcA2v9SDflb2QMzhaoJp6jACXM1IX?=
 =?us-ascii?Q?d0lb7TT1qktLdErdbq0YMKRLHHnuMVpHbEkRx5QWd7DHhr6T+74Jp0QP/E/8?=
 =?us-ascii?Q?Q1hGgNEb3yrpoFcxADTc18BK5VLKum4cVIND5nbylMxC6dyagKMLsHp2PPjE?=
 =?us-ascii?Q?sqVJiQrHPgImNcfgzGnusLhVT5MkW6U4J0WVjWuxQoYaipv6/bbfQuVDOZvf?=
 =?us-ascii?Q?qV58dBJTu+wc2sVINgpkvSK1Wj9917by8PBIxxXF5TWtBxi5SFlXlRLGHo6T?=
 =?us-ascii?Q?xaZafXmy71mx/+vYUGB8FdOr4qXbn/sgMHWshh7B/6LfxFir49FgakwIMxpV?=
 =?us-ascii?Q?9kdcNQbK/OE2d1pEO59TulK+aQ3JU8YGoSsqs1GtRfc5y9yiZpbVcpRe33z6?=
 =?us-ascii?Q?Pej3UcRowjZO++yDc8GyAl0cguW76xE5AwqKyj+rT1uiSf5podt1ke4EfWkd?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5298e1ce-bf7e-4ec6-992c-08ddca7c8a13
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:20.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiG4Nr9vF9PXJnbqJSCpmq+0bqFx2cYehI44vG1gZ4eqZ2vm7m2e9pjT38Y83lzu5BRPRyeBr1yFmbizP2PAfxC+zz8l+oJa0h3dkfjIfng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

Expose device firmware version via devlink info_get().

Example output:
  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

  $ devlink dev info
  pci/0000:07:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.75
  pci/0000:08:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 2.4.29
  pci/0000:09:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.72

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add two space indentation to terminal output. Suggested by Vincent Mailhol [1]
  - Replaced fixed-size char array with a string literal to let the compiler determine the buffer size automatically. Suggested by Vincent Mailhol [2]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5
[2] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m97df78a8b0bafa6fe888f5fc0c27d0a05877bdaf

 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index 8145d25943de..4e4550115368 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -4,7 +4,33 @@
  * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
  */
 
+#include "kvaser_pciefd.h"
+
 #include <net/devlink.h>
 
+static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
+					  struct devlink_info_req *req,
+					  struct netlink_ext_ack *extack)
+{
+	struct kvaser_pciefd *pcie = devlink_priv(devlink);
+	char buf[] = "xxx.xxx.xxxxx";
+	int ret;
+
+	if (pcie->fw_version.major) {
+		snprintf(buf, sizeof(buf), "%u.%u.%u",
+			 pcie->fw_version.major,
+			 pcie->fw_version.minor,
+			 pcie->fw_version.build);
+		ret = devlink_info_version_running_put(req,
+						       DEVLINK_INFO_VERSION_GENERIC_FW,
+						       buf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct devlink_ops kvaser_pciefd_devlink_ops = {
+	.info_get = kvaser_pciefd_devlink_info_get,
 };
-- 
2.49.0


