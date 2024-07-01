Return-Path: <linux-can+bounces-920-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43291E494
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E354C1F22530
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2045616D32E;
	Mon,  1 Jul 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="IT2HnXsT"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606A16D4C6
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849008; cv=fail; b=a4sBJj32WT/MlPHFcURmyDENYzB7LRr38Zrek8xL5LhLf0R0GYitI/CNkJqFzeHgCImjSKQ7aSz4T9SQHxJCZucT6J7dmkETiCegau6wyfljz5fEaYWIMu35VSIXjMeYaaYA1j29MmMlbPMWCxmPQ96KbNNez33eqHkVR32ZcNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849008; c=relaxed/simple;
	bh=fYeN4tLApxyEw2lHWniQUflYOOfVtz06OYvyEE+9VwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFt3Q2Pz92HD9Q/cOZqM8LoP5eJxpkGTxQ2mljjccxeRUQF0RGOgt35PTdLcD/enjVeIVi+J53rus9zhse0TP4ngm0jdvwjJnruQ642J6RNi9METwKWN0opvelicssY/DKePKcR8HNFZQuD5u4qdZvoJRpJuqQnrK8lLMTOJJPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=IT2HnXsT; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbCJVOKuWFe+DwZ8sJtzmrjJMVpv84sp0SNDrRmATWAPQusQL3/NUEGvqiCLReES7mUvIt4rFHBnzw5BPakGPjCIh2wkLIdxFeS9hWlpcJGYZIl7W21MZoHa+VRHH2kdeFcgpM+toe7xg5ax5dChnyZhpeXQbcNNCjXpA+Prc2ABJa0/GeL695wmrldpI77s1MfBTeU4fKEMD+cIBbNWnxH+sLPrvWtIOi+M6y07TTsgepcLni0Kwu/cLtRT2ul0knoAZAZJZLwGqsgLAYJYxPTVKty7pwdqjqueMIENtGv2pLrC25ezTZorffj2njwHCcO+TwTEZ7Xv6Vj/ez8K5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byb9bVLsTG7Y0X6d+BL3pSQ3r6FmDpQbsxTOVAeJMcA=;
 b=lnwR3vPQWcEt135Fc400EVpXb7XmOHnrvq+N4IIR7lXFlisnncJWth7TSUpJPsyKvu2KzRRJKHAmrDWjRoc6EgG4CexEm4LXVwTpnjRwhrFP+AThxBFgEBwA+s+IdiYeYJ4HdqvNusf9+5gBlJ+9c+CXnjHt57R4TrhAxMEtsL2JT//jMjjTIckTDjQXOc1tscasgQcquFQAnbb/4mH5+Sip474VT/7LooHX0BJcAxrJhNEZQBniEpShKtthKixyRmMD7AZPAlDDzReRpR7OEnA7DA3IM6OyJWxHJaN6I8akCL2JnTaFv8aLs4nRXIZ6mIJWBDd9CP3R6d2Jijk+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byb9bVLsTG7Y0X6d+BL3pSQ3r6FmDpQbsxTOVAeJMcA=;
 b=IT2HnXsTrL39w55I8mDsmxc+SBUHY+mJAkqYWpkKHMbhSJrJXl7Fgd9toZc0m7phQ5pKGYVknHmLjY9dZmYlnFb7qeeg+xsyu4n3lCVEyEA4t/iBEvEWJpKnivoE+8yjRV7ru0jgWK5Fa9LmDYrV9msgqXT/yhxYu341rdRdnEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:49:58 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:49:58 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 01/15] can: kvaser_usb: Add helper functions to convert device timestamp into ktime
Date: Mon,  1 Jul 2024 17:49:22 +0200
Message-ID: <20240701154936.92633-2-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: eca4c069-2061-4949-b1cb-08dc99e575fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALhNViY1glta3rj1l+dr2V6GvHJAKOWxn3laLpBE1ctWSHEBzVqFlm9coTvO?=
 =?us-ascii?Q?fEwPMUZuL4+TISa5N2CGLDVrI1I3r4RpAQuD1roaOMX3aCxFzUOH0slXYPN/?=
 =?us-ascii?Q?N3e0wivpI0sLsy9TYX42BNQZttniu1chfWpjOYzUaJgAQLlFzSNHl+krqPbR?=
 =?us-ascii?Q?u6gKXNqaS4c1yf/SKgid7njKVJ4vYNpb/eMWB0myhSSV4JnZ+ai9b7+q1mYv?=
 =?us-ascii?Q?CLgoH49BQEGLMVNSIWHdURjrTCFBgImPFJFXYI0rPyMQu0sj5sPHYXAtbcWq?=
 =?us-ascii?Q?sHQRFZPLJgw/BhzLm2gq1LUTqrnBB4iqdSDqEmqcJPVL8P9j6CQMWwv7qWbT?=
 =?us-ascii?Q?yTFA7GYtHRZr3OkGqxl4dOJvn/va1O2Aj/Ng7RFlJWkBelce9d6qflig6rFa?=
 =?us-ascii?Q?PyMAr5GxGDbqgHQJdb3uWumeKiSAi7xNZlK1GIwW1WMV4y4vlj8ebR8FrEZP?=
 =?us-ascii?Q?rLM9sWD5gHB56hXcDprkqO0voFmrWPYa1TxGS88roliHHP+ZM8mqgdQ2Sz3J?=
 =?us-ascii?Q?s+bY50naKv1xJ2Io/N6MYAcngmhIsBt3shkTSvYMoniPCAq2LTDPVJVemM/G?=
 =?us-ascii?Q?+SGEnF1BeVvG2/uoyptzwNmsBv2bz05v5VqcGORL50qAO1tnRKZzlLY+bNUp?=
 =?us-ascii?Q?wquAPESKh/Fy4KHLwjElQPJbp9eVfFe9WLjfO8NfrDeXGiJQVRtnVjNqTY/W?=
 =?us-ascii?Q?IaMoozKJzTwIiLnU+qpfIGEcyb+wC8oNvuO8BJStwty35bdThXwVpMo7fxhO?=
 =?us-ascii?Q?O2Cp7SFWSRu9/ShbaXJaVIoY5O0XPdlcyl5+KVNbGlQDAxIWd4KHOD9q0Gwu?=
 =?us-ascii?Q?Qo/L+n8D0QoqHDoRE2OcI+rfY9HA6BguNAlbHwQWqYuUOSccQVUKNexN8IS+?=
 =?us-ascii?Q?vRLOKRn65+yNwJS1rzNPWKfkpxJfINpTJAbmAtIm8/9GMa+EnuF0/wwOUQ7F?=
 =?us-ascii?Q?gatvMjQM6J8r+1/CnXj2UkO5r0sMUxJ38q343HenEkS5Tf/kA10u5OdO9/F/?=
 =?us-ascii?Q?6gzGOg2l/joQCjcN+A1ekWtaVi9eCxi+nr8ehEBcWE6p0bwjW2Jsaz+Vl5na?=
 =?us-ascii?Q?X0POCxlBFp1OoyPhcFez660dMcQhBu2XvXbWz1OwzsRvLEBq/Sq15VRJQTza?=
 =?us-ascii?Q?NtKA8pB936q9+LwzBH3FGct/6rVUBUa0wIVoijtrHshxxBlAKiN4aKwnLkjZ?=
 =?us-ascii?Q?CEKIGdacomGNiUs/eif74EJnfSs3vysSPJ0pdeeQkg3B22aYu6ldaPHweZFU?=
 =?us-ascii?Q?2lxL3kF76z6y0gbfurDI0ryV03pteLQsPE5K07LYIe4NMvK8T3LrfiAuQwX+?=
 =?us-ascii?Q?8xQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xuhIBywoSOR4sv9E/uhTxfWvKbNbU2QMQfvCOsA9KzfBSxHJp76YUlM9hwT6?=
 =?us-ascii?Q?fMkVqA2lAVXJCbukYfwGxpyCwxnuBWWgM0KBHoEclEzgvAL2Xxl3mQpga1I8?=
 =?us-ascii?Q?pewCcZBB3OF1CBH7EEGOrRF7qbJBMoAix8CwunZAMRqcIy6uKORtVwgu7Zup?=
 =?us-ascii?Q?/efJ1ym5mGMlxZZPuJdETbQL3+Hc5OjIbd3YTzJzx+eQanZHGFrNhLAvg7PT?=
 =?us-ascii?Q?XF0vSVNVgjv9FeZBXUJFSF60L1zUDF+Uxwhd0ubHeDY6j+UBPmPDKsucOj+t?=
 =?us-ascii?Q?YNQocpTiaMLirWHnlSLiPKfCYEZDTJqRxtJSZ6s22oDNFNT51r9U6fiNeBXm?=
 =?us-ascii?Q?xinAybmsHTdG5k3Os308sJFM8GDQD4NoO+TgY5wAODMSHDwEcrtHXTkET5eE?=
 =?us-ascii?Q?+EZIQF7pQ3bKIUjJXKtshMKdJ1EjcWLzv3Jrd4bRIYVIQLGH8JNtUnWh2wRX?=
 =?us-ascii?Q?fZrInj/i58duSenFLj6pRzuVmexN05q0XwEX8TgEFN05SV7JM4h2f9RbSvBc?=
 =?us-ascii?Q?tlJxoDiubNAxzN2TaokEariPiQKzMHBjsYrhfgsl7pwJqDr4NxEjO9M/RO4R?=
 =?us-ascii?Q?Gh/gFhLayh5ASmQYl0yj7FjJ07DVnPY82P6xE4CuMrZ7Kw9W/JunRg91M/ho?=
 =?us-ascii?Q?tHDS4IL1McWiRunY8ZYv0AZCASzHTP7HANr5CqwVNszb7MPxERAgc4906/w7?=
 =?us-ascii?Q?t8E1WtnqmczQCHrLLPYN6MMptuv4J4tHfoHUAOFSX/zuqAnQ4gvXQBm4CCUp?=
 =?us-ascii?Q?4/5oV08wPLalEHqPyjaFaDfixg/dFAYEoFdEslLMJPgbrReJOf8O+/NlImqt?=
 =?us-ascii?Q?d1ieUt0mDEGjRwjF7Nb1ZvjistLNSKCJG8htwnYjN8TOsoyeA2F6tRixxqvV?=
 =?us-ascii?Q?VnJB0NxFx3b7PQcYajENmmlTVCMficMGg0sUyoNExB/rt/kZlutKdUTZJLx2?=
 =?us-ascii?Q?yYbT3gfgXaN27Cm2hsRLoZptuZRIytAhYU8WbqNs6BlB9W/nQiPJnHsvVzqw?=
 =?us-ascii?Q?9RiVnMDDwufcf5TRfwERVvIZV/sgKoAQ8Mm+ApxWSNIyIPjLzs1d7ORIWxSZ?=
 =?us-ascii?Q?iafK+jZq6W84lrD9XG8PJmsfRBGmUI7pgcgP2X2Rpmmsm1tZmPFLWCn5cLBg?=
 =?us-ascii?Q?T+M6TKXeA3X9PHv3gTFxw6rsG7BIt71je43DkY9V3flNA7ZuNw8lCoAU+VJj?=
 =?us-ascii?Q?agc10b44yPR9CyyuM4lNMiJWBRg1rVKboIYnAp8kxe2mJKqGI3xtu533lnV+?=
 =?us-ascii?Q?nkioEmqyhVcKZPharQK0M7dwmknoaPGptdRyEJ+kXcoJ17aJBVyMs9lo/35l?=
 =?us-ascii?Q?yarc0B8T6dyCcScCLwbs0tp39NtHTozIdYuEWCucalnipRFwWXACCjOTtWHu?=
 =?us-ascii?Q?fXDW5zJfZh628MCud40T3nuBuRZSwyp5/pYyvIB83BF9S0++2z4/hy2RITX/?=
 =?us-ascii?Q?UXLGVIgOzlEnc3IwU0cRf9TC+G3IJ4GHQi0JFiVfrciYN1r/XXe8+YwHWbvt?=
 =?us-ascii?Q?a9QY0lBrUMeAXwWrl6ccL1vqyX9xgty4P/+7iF3M9/X3v7Fca6tCzcvdOJCW?=
 =?us-ascii?Q?L5xsYslUoJNWODpVDVFITEWOeW65+3FiUJoij7s/?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca4c069-2061-4949-b1cb-08dc99e575fc
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:49:58.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZICBza0N5VKGIEct9exTkntNZ2THnjJ3qZQ+OotndHw2RSkTEgNQmwtak3zIjXSDJrOZnu05Q2llr39BHk+OJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Add helper function kvaser_usb_ticks_to_ktime() that converts from
device ticks to ktime.
And kvaser_usb_timestamp{48,64}_to_ktime() that converts from device
48-bit or 64-bit timestamp, to ktime.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2. Replaces
    can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
  - Add two more helper functions, kvaser_usb_timestamp{48,64}_to_ktime()
    for converting timestamps, suggested by Vincent MAILHOL [2][3]
[2] https://lore.kernel.org/linux-can/CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com/
[3] https://lore.kernel.org/linux-can/CAMZ6Rq+Xd7+th=dKV+vrqzRtS+GY-xq2UziH1CURcQ3HxEXMqQ@mail.gmail.com/

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   | 24 +++++++++++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 10 ++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index ff10b3790d84..4256a0caae20 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -22,6 +22,8 @@
  */
 
 #include <linux/completion.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/usb.h>
@@ -216,4 +218,26 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev);
 
 extern const struct can_bittiming_const kvaser_usb_flexc_bittiming_const;
 
+static inline ktime_t kvaser_usb_ticks_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						u64 ticks)
+{
+	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
+}
+
+static inline ktime_t kvaser_usb_timestamp48_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						      const __le16 *timestamp)
+{
+	u64 ticks = le16_to_cpu(timestamp[0]) |
+		    (u64)(le16_to_cpu(timestamp[1])) << 16 |
+		    (u64)(le16_to_cpu(timestamp[2])) << 32;
+
+	return kvaser_usb_ticks_to_ktime(cfg, ticks);
+}
+
+static inline ktime_t kvaser_usb_timestamp64_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
+						      __le64 timestamp)
+{
+	return kvaser_usb_ticks_to_ktime(cfg, le64_to_cpu(timestamp));
+}
+
 #endif /* KVASER_USB_H */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index c7ba768dfe17..ad1c6101a0cd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -526,19 +526,17 @@ static ktime_t
 kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
 				   const struct kvaser_cmd *cmd)
 {
-	u64 ticks;
+	ktime_t hwtstamp = 0;
 
 	if (cmd->header.cmd_no == CMD_EXTENDED) {
 		struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
 
-		ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
+		hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
 	} else {
-		ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
-		ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
-		ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->rx_can.timestamp);
 	}
 
-	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
+	return hwtstamp;
 }
 
 static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
-- 
2.45.2


