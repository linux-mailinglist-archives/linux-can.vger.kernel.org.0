Return-Path: <linux-can+bounces-4043-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D9B0ED51
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791AB16C24B
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9616279DDB;
	Wed, 23 Jul 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="bnGsDnxm"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A527AC44
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259602; cv=fail; b=fw2WfVVxkmzI/0nh7ng0ZEXzNvhj9oGWY7TAqffio06hsrF/n7cyaxEO5Ohph7GaK96E+keiQxCFsye8oBXcyNDDs4bE0hyPi4CD1VGUvpVhrjfIkI0KAJV2yY/gyxwnGPLKJbfDey1N+ETUah6j8ZyvSUfRnTrifWjmrnYoDl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259602; c=relaxed/simple;
	bh=7cf0K3F37v8Qm4WaDpxYMVQkr/3jVXSbI7pXpGHjErU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIQ+BDR6F4ZPzOMCoJEspvMAozpHOy9i1bsBHDVWXF7AqCPNg2N4S8V9z36OL8n4E5mqbXuTVPeoq8e2M4Atzy/aVA804KZEZ6iTUF6wxIRJG61ISs2bsKKq22fTQb5SyFUvcWn5iaiMLseitmvyGCk3e4wS6z8HeE0pWJtqi6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=bnGsDnxm; arc=fail smtp.client-ip=40.107.20.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEF+Bv1hOHqXTPgpM8qHYXeWC/IRxIK2RkCNHG2i0UNUNj2Ky9hZhzUjH3K30ugACwjW56jGigYyTsyFfe4a4SIOUP3zRTpQ+6jD6xd1kEmSHqG3YS1ZqOn9vI4Srph2Ljaul/XWvpykhFwkELsr0AjqHADceOXpTSxpmaDmjVxrgVUgd7sxGk6504eCIcGnjmmL5j36c5RndHFQDwa/4LbOFa4TREQfILmszpvh2Jhg5iu5LcPkGm/qe81kXZMFhIShs7dmksBZnNn+44dQvhG252D/luDjHbvNx9zOiHPL31C3oz0CGBAP9uEZbeaw3K8Dpw8ZOl+V/sMMgVUgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDPQDUcUKux2OIsDCR6O8PiY3W2GalmTpIws+PbiGeE=;
 b=o1aT584RyAxmhqkFSwNdFHR687KVLVWw9hINVe1T752gMz1jYbCpbO7d75hzDKYKgm0hpaAd2s0BCGkmaerz5Nn3LzJ4/LXkPGiWjz7pXxPaISnMdvgI64Y61EDwbXyDMdYfeH2Q/cBI0JrsQJKd+Yjx1Na625WQdy+16J20wVww+FA1fK81TobbLVcP8VCp8ga5XzVMbvCx8DVSTkscUMjEIiM9N6jgrqgCNDSKrlop5FzCYvYwcnUlPKUcLe3uA6/GW5I14Vba+tzDDRzPMjGFT+oXsjkjGSP5PLXVIZ69hCzKry90eVTIK+cNc+yC+PaI+L1xyPeFPAZLcp5e5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDPQDUcUKux2OIsDCR6O8PiY3W2GalmTpIws+PbiGeE=;
 b=bnGsDnxmVLzue14b1OpMqAbz3gRElmndMHYEHpizwNVqmFB2sIeaB5kVjjKlRTHix67qmWS8ZuSA78eyFJhC572TJeW7xGjSlOrjXsjZgPdDyCcpX7cKTuVQxWgxWZuoduhD0Fe3S8cgdHC7ILztauucc6UMLjqHYizh/rwJghU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:10 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:10 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 8/9] can: kvaser_pciefd: Expose device firmware version via devlink info_get()
Date: Wed, 23 Jul 2025 10:32:35 +0200
Message-ID: <20250723083236.9-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: b20884c3-e470-4aab-d96a-08ddc9c38e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NGAs2GoT95PjQFmNgyUucXilTycBt6Nn895f7dkg5nldUP1l+F0CZGutDtLr?=
 =?us-ascii?Q?+ZhvwyFd1V+TcRM37ecF/rdzb3u98PoaOFbDIkHDTwRFsSVdXaDjV3LDPjyN?=
 =?us-ascii?Q?8QroBcDAfQmldDUyBHcr1mMVZ9n+myj8yvnpVodGV159uMAuaJkIofPmqhDx?=
 =?us-ascii?Q?bR/n01hs1S1gkniXs+JZCW+Mma5thnliDM4H4gnaZX+tRcjt8cp70Y2NFzQ8?=
 =?us-ascii?Q?gqcl4lPhKyPKkKnOZ/6QymgMw3H/tYL3+45XPldDuLbIMKfIym8oSecAJr7W?=
 =?us-ascii?Q?0El6W7Dy2lwdpxb+m48lAOJVl+ruGseFidp8f+kCWG/6YlgPnTw3ND8HLZqU?=
 =?us-ascii?Q?qInudvWtn4HaNr/3ZpGUW1Ph44uYYJpkHchG6H9ojaUQ7j3Brq+frIkHEzzj?=
 =?us-ascii?Q?7Sn4/ODWYnwVPMxnRBGCPksFc2qBvQjsXWuC1pEy3UptjucXJtit889/g85g?=
 =?us-ascii?Q?vsT8XFHg/RMw8WQwpGyB3rxPX3R4oYjAKzXuPHdBmdsU/MwFOIgjgtCYWs0N?=
 =?us-ascii?Q?rd/VoVXjGWp1uqYIcub1YOJom7YH4PkrG0MWN/iWu6h4OZwTYytw2z5oFTJz?=
 =?us-ascii?Q?ff5rxM7EwP56KtiZIhlOtf4ge4LTwXjx35YuwjOh+g1bEzXI8T2VfLxXh1pT?=
 =?us-ascii?Q?iB4J9cX2JvoXRZTOcquq+BM28hstbZvQuz2I/3ld0RIvx0kMyW62jBe1jrkx?=
 =?us-ascii?Q?BKW4VyfCkJOBD83Hb4RKuEiAI5zgL1f6YAaiQWDLYxhR3smjABKTobl3IP3E?=
 =?us-ascii?Q?dNhA8pdIzYK1MOGm/95ywVahS2/Z+gbtwqho4RnH4nfzC9r1UI/MdVeDBE19?=
 =?us-ascii?Q?rNv/m5x7wczZ9Ygg3GeEK3nJ8DMO3dbyoSGwcvSHABAzOsek99EWCs/OBeRx?=
 =?us-ascii?Q?DWWbO3rzW/4scFHeDhuiwhW0ohiqRlBEgtmlMT9bgJjSaZSJTZn1/F+XKnUT?=
 =?us-ascii?Q?RGFXdMlogCyZznHy8wtTb8dV6lhxZ6VWb3bwNNThh5KSoOfw5kI5Lu/KwHze?=
 =?us-ascii?Q?GlEQyBVbU/kTowLeciXpL1Xng6NX9ADSSK/2YpaweFkbRgmHwGK1Qaix+l8b?=
 =?us-ascii?Q?XwX4vsgDa0VHTjkqrxShWFwcKESuO5acC+DkNa9J529WITF1ESsdOjzgacaS?=
 =?us-ascii?Q?rt6LzBilxLW4WxyZVGrzAY1S2/UxOBw/Ah1m1hXrfw02IQCrCZjmhGk2BMRR?=
 =?us-ascii?Q?eSW84w9e08ypBvMCpNXvOvSnBftYIqhhc2hl02hG8VvCXTe7FI6Yl1zQD1PQ?=
 =?us-ascii?Q?JrP+8J3rKkrc8xFDOK21/uL9mKYNe6kIaSu5BqYvuh8o2UjUECv5PiHWIHcp?=
 =?us-ascii?Q?+EF7VDZU/mEnZ2VTOiBUAi/m8vlHNKxlC2vNkQK0XsxpussBuRvDdeDoRA3V?=
 =?us-ascii?Q?QyvPgbTEB142/RelXNAu/VAK0kCbzjTpYomNWik8yaZ2QkJ2Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CVKZ6+ezAI1uaT1v605bVLWxFMtgZDEz0yIePK+EyH5PH1ZFC5RQaLF7cnm?=
 =?us-ascii?Q?I2IHyGtfJLAe2uPp41EICR9pwxYP1pEpI+bm0BHLOSFT1T7TKi7Y2N7yPonE?=
 =?us-ascii?Q?YWMBhM1XiOTzSfBVeoKsDkgcmIfHYMdsiskJ7MTXUCC2nHe+aoUkBO+G1BVA?=
 =?us-ascii?Q?3fvGH3lQqMGExz7IklrGYQ/8ebvo5bXBP2W6H51rHMYHuWUWza6rBm8yxHuJ?=
 =?us-ascii?Q?wpsdljj75YRB1vDsivnj40vwJRpdta6rbXdXhtGGPrnU4UxAznI8p5PUnLkR?=
 =?us-ascii?Q?7dXh0oqo8uNBMRl9VlBTTi5k909Qc+9G8Uk8QQw5T4r0q7lEcVBqWN5HMeMJ?=
 =?us-ascii?Q?eEv7DkMMNRoGYLIU1qIXyFldfuwaDdtQDcAh4YW48XBwaQ28nEVoQay6HuWr?=
 =?us-ascii?Q?t+uSvv566+pj5RO3N/Hhf/igruQdJcoM3fMLo+nuLryZ5wGzfvzZ8c2SgN5Y?=
 =?us-ascii?Q?xDtDNuFBcWfAaAm/xNQFch3csblUB6keWNkU3W7mfeVjuWDevoUCOyvZfqTv?=
 =?us-ascii?Q?ImZRU5yD/XfqEHZl0Nro0oIeda/xl15wnqLciM5vEHbWXms75IY3/0g6R/qD?=
 =?us-ascii?Q?BIAQg4m2sDo5KAJMJSjNZln9bnh3REAA1VivOiff+5xyuQXjydxZRBx6dXp4?=
 =?us-ascii?Q?/tO9C8O+u20NlMq8Hr3SiRm6IhQsprYIPYKXZJ2Gb4Xv2IAXbZed+yFUom0m?=
 =?us-ascii?Q?24bKlyQ7rrp5D+iFPdNAs/rw2mww6uuMSCd8m4eLk+O4mCtxYQ5mQDbu/qT6?=
 =?us-ascii?Q?imhaQ1RtbEKgDvsG/mz9uHuMr2po8+TUDblNUYI851gBtJNWZwDUaNmGuFgn?=
 =?us-ascii?Q?YZ2XLMb1yTkZb6BV/aakhAe9IVDdaB64lb6PKILxjdUuQMKJgJtOrdVOWXmO?=
 =?us-ascii?Q?TqnUsoZkElh3LHaCmgKyklrlA0uSvPxDDdlgWmm0Glu89eNwkR8gj/Ppe1P0?=
 =?us-ascii?Q?ha9Q/H5d3MQK5gnfGA7YOlqfL5FQzpBlqXgMEF8wMnzbj+8ESOXibgafimqC?=
 =?us-ascii?Q?Y+cRqp2DEj9iG+cKtxp1qETXTS12vjTb82JnSSFjqNRUSkXbTcifsxa1CHCn?=
 =?us-ascii?Q?XL7uQtBY5ko4559Bm1sslLOzJlc/T2FfHHZHgRjQaaygeUXZXil6jOC/6Tpt?=
 =?us-ascii?Q?kdHcxGbQUDGhydrQjexpOkoW8R0dGmxQEDCM2X5V2mlVh0HIrAqvot5uFz7E?=
 =?us-ascii?Q?P7s+ki23WcfsGQe3rqCR0UriWjjlCYjiBb0bmgBeGy5FOMUb47ZKyY0e6n4g?=
 =?us-ascii?Q?20n9C60ahD8+dfwTCkAnf2crJBHNYAil0cGtvy9O6J0jogRalwcgeJ9g2ZDL?=
 =?us-ascii?Q?BJqrp8lz+ZSAAn0dApvURor5kZ3EGdkfZRQewf/XNUUjQyVXdUC2GL18Cg+l?=
 =?us-ascii?Q?RY/GkXnRHt4qNR0V+cOZjWKa6/pxDtsg1b/7CLuRXDU1kA1oAqgoIi5+a00e?=
 =?us-ascii?Q?gg68UeKztzeao6HTQbvVcM3MkodTBlBBNAp+2dZIvY7+ASzReOPxEBCMlZDX?=
 =?us-ascii?Q?xlOkJx6otFxmn0VLOx0krJdd9BKFrykjcqsak8kfVHl0YJPX1fbIxQVlaROm?=
 =?us-ascii?Q?vG55yBfQgyRXYJ2zFVYrnzFceXsy1yhfdLJTGRHBmO4fvcMGaPSpCG+MnDfl?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20884c3-e470-4aab-d96a-08ddc9c38e85
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:10.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRTKn0ts2Da4/TklHjS7YE+ECqu6IAPqAPRt+qk3hTnNQM7m1S4hAcyZL+NFnQB9zHlpd0uGhgAWRREZWHoyBnLtq0IGADeaDO1yTWpa4z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

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
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index 8145d25943de..b6d3745089d4 100644
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
+	char buf[14]; /* xxx.xxx.xxxxx */
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


