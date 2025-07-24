Return-Path: <linux-can+bounces-4088-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD4B101D5
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD94AC2A38
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0926C38C;
	Thu, 24 Jul 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="VwZp1APV"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0B26C39E;
	Thu, 24 Jul 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342247; cv=fail; b=jrnmy9rhXzZ0D7eet5k/0Tx++8HqQ+fi0Xn4SDwVcxDNG2l99Jc27MUEikpQx7ghcfbEJ591rJwNR7mMkNQ7kLxO3s1iS8DBzm4jIQVAZzv217MIQrZPWjUgnip+XmqJ9SjrA0H38OeHuLPc1ti9GK7+eIFkn8mX0Lcn6ks0pt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342247; c=relaxed/simple;
	bh=j+Vxtbgi472piXybDdXTUTeQArRYQ8xCgVwo4wEqjT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ek1ozzlrHWkqbmnUz09T3m36ejdLFfACC90ep8Bcj1PTM6gp1DGzHqj3gYKsAeudThChPza+W7/gYLxPi5qD5E2O7NtMLpCGmO72WM15qCIbHOVYs/ECC7E/LnqcJ6VpxXd/DtTlysDCsncwgkQg7d7FfrnNfT21bvmhz8tAkKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=VwZp1APV; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS6Ef7QEvg5oWWyA3RM0cioQL0fWRZeD6cPs1c/hjzW3Gf1JfC+z7+N2z6q8NDLkP7joTYS8uPjo2JP4xTwAPc24M7SFMfgo97bUf2yUq7Q01X69wQrgtAl0NgIy0AZ92vDvAKy0mAOUI+Br62SfoJz6vwAz7iuefvgveNsDveTLzslM6z1viMMEe1CUXTy/snxygx1rPov0yzgPQ+8gYvX45fnzv/I4zyOURwMuRq7Bw50iWoRoZWUp7ZO/jcrKrO3PVfcOm3HsnKeoLlIx9OxOvFwUNsJR8p/6ersilMSw65ukwTMcZ6KSlkShNG9ZsILy5bwvy2t73+FrIX4BMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ye7k3DumBVASnBdjGTYTvPikzjnr8GF6aL+aYOPFy80=;
 b=TR6Gq/T39XYn5DzvUOdENVR9JUKWPqgW0pSdHR/boS55XTXP7ADfxu7QphHMUw0sVsxOmYx6DgkKvIhBdJtZKGGfeIj91hJHnhw/NMKaeL4E84p3HHqo25N+bF46sZR+N+QVYaGBqGhA2DvyXf87lrvpUyPxM7+1VC7EAqMSFTBWGnOW09cclYFNJ5n7ezZcrJ1fBJGO/Wm219XaekKbHamHxauv3kbn1OIdwwTwyWxFNK5yYsNY4viZ8Ad9Vp/gb/rMrMh1limOKIp2+Io+/w5N953Q5VvLQay6EiAJimFX6jQujE8x51h/QqHGtI4/gZmS89lX9aQzTmrrCbo3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye7k3DumBVASnBdjGTYTvPikzjnr8GF6aL+aYOPFy80=;
 b=VwZp1APVlvHUUGkhtVmKfzDvoGkmX0P/YNt7t6zzXzluAKK9o8q0kbRyeKR6ON8tyfsCNOxM3R6BCUW+I5GmtV7/cK+Eer5kBfL2YPjKo52hSxlOqWqNwEdjm48EfdClL5fs/PyCoUixD3jysMF7sVHn2BQXLy1GNIOhXc/AgX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AMBP193MB2850.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:6ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:39 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:39 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 08/10] can: kvaser_pciefd: Expose device firmware version via devlink info_get()
Date: Thu, 24 Jul 2025 09:30:19 +0200
Message-ID: <20250724073021.8-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AMBP193MB2850:EE_
X-MS-Office365-Filtering-Correlation-Id: da412207-b278-4aa1-4e2c-08ddca83fd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3VpRKkkuawtYfl0rYmY9kPdWp+dook+wKp/uMzE+5ypwLScGbqNyJVYzBvh?=
 =?us-ascii?Q?bI4CplHj3xK2a2KA/1fmHCtrs5/jGZZH0cccVQ7Xz0cGlsMx5O68ktAL7aOA?=
 =?us-ascii?Q?Bt7LXpu7Z3bkx/5jUVlNRzZ++Rpcre+3mIea8UK8cuQbZOo+dJOrY1KwSdT5?=
 =?us-ascii?Q?hdo5hTATBUldYOcVLVxNYwYcq2m1EK0wKkefzRwL/PClmYGv3+QZTpc97hwH?=
 =?us-ascii?Q?Ovwuljmpk1ncdv9K6wdolUn6upOvorANVrxrQ6xwmny2SgcBWndK+6D8+JAC?=
 =?us-ascii?Q?buPTG2hdpDUFRxaV+InXI1RD6BU9H+RuBb6qh2O3WwwBHwZRD+jhE31/aIp7?=
 =?us-ascii?Q?otD9MeOC5xY0mI23piwynMdgI/Gim68kP6myXrp53EDpUt3W8dFav3SrHRJ6?=
 =?us-ascii?Q?c4TrVeKyL9brpemCCE4sJtUedz1os7v3bfF+x4wk3je0MEKszS5JN6kSPQz9?=
 =?us-ascii?Q?s/M0P2PSrg34Pmv1OVNhc1z1dA4biuvs9jjn8rtEgws8GQGHOTv+cS6b9ieF?=
 =?us-ascii?Q?O3C00cZVvNFv0hd+X3CLZOTjP+AUIPWq8U7SWyj1jOBVGYwxL9Uk2/BCoodz?=
 =?us-ascii?Q?C7JQ9pDosPvkyFoBVmtxFgR3n78q6fjnVDyvBDs6siKd8WdUucw/JArT8VjG?=
 =?us-ascii?Q?j4JC8rt6An9c/w3N0NVPqNLlW6yJ509kpC/CVijDwqsae6JSUJjJanMReHGW?=
 =?us-ascii?Q?OBPzMZJZsVzbwqM18Iy7ci2TN8DTT+Y0pymaWOko5qtZc7J6zGjshAxA1LU9?=
 =?us-ascii?Q?F93W7zMM7A/ccna8E2qPbnK/gis4j+bliyk72NkwMvxIHVhiAAcL9AShm/lF?=
 =?us-ascii?Q?mnHHpau8w8njhTJR3vtqYOGoAVEm9Rc5E86BIP8FOZm6YmGI05jDz++jhcwq?=
 =?us-ascii?Q?kG9kTbpFhH5/5w7XdXhp8DnLOBUAVtM9NoaifSkW6Ab4TVWxYU+bsdRnlzXp?=
 =?us-ascii?Q?v60kYtgYxpXuPTnkbjjXKBpTCYgXmnzWmNRiRlDQKbsTo8AiETpNvUrtyPjF?=
 =?us-ascii?Q?Nxh8KUNDTBk1VeySdQU850ciSde9/zGFJPbnlhZ1RufE7IFyVlloDgdGZ46a?=
 =?us-ascii?Q?hGXKfSsDjt7K2O7jwfxIno5hZsm1OQy5ketbHoCDvAtxC6EcDPkIXJ8ufyIc?=
 =?us-ascii?Q?Hg45Aw9JB9bgwmLnny9xS9m4gKQ4BYTpoBi7IU3QO0midW/XPM7r7U2KPUVT?=
 =?us-ascii?Q?6r3SHnyNwPNccXqwZMsAwkuusfwj3utVz+f9Z1hOAkLpt5bRS38KZp/OUx5T?=
 =?us-ascii?Q?KfybBGWWxKS4GDRr5lhCiK1AIDHmyYYXKWNssb5Q60c11A19X97bm+w+6QF3?=
 =?us-ascii?Q?EHkGLeQyzIEyNIUJf/uN2R2UFhp8pyOKbPKpsIUp8LkqyeajmWqR1wRE548K?=
 =?us-ascii?Q?55UmQT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmNyyrkfIJxm0VkiTM9QDN3b2iQ1ryGNPm0BDEsyV4zd/0RcVMYRK67NZnB+?=
 =?us-ascii?Q?WTT8YcVQhfvYIj9/xQFf38IXdk30z5CXvmbnLw4Gjna/gSGWKvYxWNFCZJAz?=
 =?us-ascii?Q?o4B6E/ZIpKWman4hq9sDvGxro5qknrpA/R9D0ZbuqQReJtTutUzp3CpTJRLS?=
 =?us-ascii?Q?JPHl3H5GKD/IH/MIfA3qlvp8bGtcGyeCObRohDJHnPG80l07QOCxg4QPYevk?=
 =?us-ascii?Q?vELVwECTeOw6XjG5OMgIo5/rMBHTBplPBYdR6WsY7KkXBnUv2RAR4HuMBNxp?=
 =?us-ascii?Q?c+/sfTdVwVCVPCZh72tE3lXnVvh9tijAU4R4HHjDjAVegns94+RL/RfxDL5b?=
 =?us-ascii?Q?uddlkd66K1xfY32fDgn0L/t+LSh5sFeTOReSSsQP18z1wS9ol3LUYY/WgPmY?=
 =?us-ascii?Q?oNVWrZ6BUsg7CPUCCc8Dn9KgsAntjMkRFoBVEp8K3G6GqSoJxxYafbiH6u4E?=
 =?us-ascii?Q?lXRYeED21Zu2HHzbVJZ0xo2y+6qSAJx0EIePA+2XWFoiFsAV84/HrD0PwSWL?=
 =?us-ascii?Q?p12O0nqDd3Ks07DJOBi2EVP1bLvLdVtfRe7R/4qaDHUGy0J23isc3k6acZQs?=
 =?us-ascii?Q?tVqpEVLGCrY6QtKRMMT3CPQh7BlJX7SBsi2hm8cTRJH4b539VF/Yf8YF1OUk?=
 =?us-ascii?Q?s7GBuuY/Fu5KOrXnSuEdow6qBVEBTcuf9gbRM6K3KllgmgQ9tUBUMkyFTo0R?=
 =?us-ascii?Q?ZAUmo3sKooXBFCLz6MczXZFRE9l1MNFu41CwK0EXn0bvQ/LHJKMTEUzwhF25?=
 =?us-ascii?Q?+RVMr4VRasD1zglJp1T/fxzV9Vbyk7GDSxnoY4V616mIwS5CScZJ7si07BnI?=
 =?us-ascii?Q?hSFTzPPPGQil6lLDLNq7ZSYZ15feU6LHruidbp8Po5xssArGSLDuzLqlKcNZ?=
 =?us-ascii?Q?CHC6J5l3hSsC7mCmY4+j9rTZeUjzrvvjWc8Pp/3XMQZT0gjZMUjyRl0mjBma?=
 =?us-ascii?Q?QwfjZSXC2loAsaGNZM73kte1Uk+Fyr5JWYWrr2RBneRD/iGHo3lRpBBPkV3i?=
 =?us-ascii?Q?TvrJfB/03wpakXI55eQmXjsQV4Nms4V9X80OE+IkFfKszxVvXKgInQ8yDuV7?=
 =?us-ascii?Q?hFkQN0rXKQgy9SejwTav0V/ICF3YSUYVHKyHVcdYJcSkPCu8gLSLW3vC1VET?=
 =?us-ascii?Q?FqXKYo/EqUojn2s0Q3XgmjCBqDmx12E5bWcN8DMEnmYCSYIoUrQnnkhhzpHf?=
 =?us-ascii?Q?DIIi1njPc8cL6Xemv8/nL3cyM5iQlbrElDj8eGvW4LNhiaCHSxaXoEjSdVmd?=
 =?us-ascii?Q?FueeMOZ3LFzGq4ZyRI1XncDjd7rgQCdN4PDt3kdUU/xLujLoW2qO6CSY+vDO?=
 =?us-ascii?Q?R+X1rmLkNJtWv6leER44mSrQghJTd1GIBgcIwtNsze10PP3+Lq84LNi1rqGE?=
 =?us-ascii?Q?GUJtcI6bQv1gI45Nz2TbpWuyDdZgT7HIzmIin5gah7wpvCgn5cWCLTYjeBQp?=
 =?us-ascii?Q?6fbyi3XPxkMeDkyvd/hy50R9MQytz4cpNe/hH7e5JxkNUuqPJszjRxqAhgOM?=
 =?us-ascii?Q?xwhUD1lL09T7i6PR0FyhY2m5IDoony3sfWyyvfZiEbgEVjmJCALnUNpATG2Z?=
 =?us-ascii?Q?vz2+KlzRPBtGHTBqQqnM6JW4phvmWvTQIvGCgHw7+yNFlKrEsfTLFbppEuG1?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da412207-b278-4aa1-4e2c-08ddca83fd02
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:39.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZJgbSPwH65cnwL3phtEPzNSFgvA7JMArhlUtCDhI84qvPKSQn9GpUoynytlXu9L4cStwDeJDiW1nLTqco8+LS4py0pGhhGpVo7Yqw/hjY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP193MB2850

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
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]
  - Replaced fixed-size char array with a string literal to let the compiler
    determine the buffer size automatically. Suggested by Vincent Mailhol [2]

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


