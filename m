Return-Path: <linux-can+bounces-865-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05EA91C6D1
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C4E1F24DE3
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E517347F;
	Fri, 28 Jun 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="TufKH1sj"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB978C7D
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603963; cv=fail; b=ltCEjAu7yPkbgAeSj2DorBJAGfLa7LP3g/RHecfDx/8lIxWzVMh1BhCfsQ6DIpI07RVGSgS4uTvpHiUUgIRocDPQiZVBpMk5rE+MRood5gzsK3oWE2cGyFequY1vSylb4xHXXS0qGE3R+j4TDPDk3UWM/PRCvt/KEjfLpNvSO6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603963; c=relaxed/simple;
	bh=YmKLjfLDDQf85WTfhiwux7CN6Z4DMCii34vVfSWNvE0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EIXgJe6NL9VXKYddSYZ87rKOg9e6iLZl1jKKzmSOERn7XXIPiH9KWdRR0nbwlEprM4YJt+tmNXMFRwHpESr639uCAkAAdZVwqx5/u4fXfbRK+Y39vnOaBreEyha8VUVh8K5LWkoTbkA0xUTR4AomW9snxPuMF7ut1VG0osYGcyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=TufKH1sj; arc=fail smtp.client-ip=40.107.20.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8PAS1Gh3ZDSFDwTzoeiqQIk008/teR8AMGEkAYKVHxUbqftJEf5BBdv4i713gEkb5Fc3wk46uLdtLcKV2Wk3s0+QGPjroR5/O4XZxobC9cpmSEabaZ8nlJ55tZYrrmkHcMMP0YpO+5tUjncBvIo++s1Rnx9imnL4EKVSNmcDFjRhUtBB27QLMmqlHBeF0tuF5wp5vEJTmFw9T4HZ9vFMW0cIB9crgb/cB0HXEpCx53iGr0h7IvGle2CO3UZSGRqMmygvYa+mAJt8NC7xw1OC7hnh3kCUPU9Ul0qUZowLGIstx8MqpnRAr1hDrQTnuvOhTg+Jfq1G+M66tZMwKQwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeZ2qNQ3BxpCybAQAYuPoAexBNCg43li4qAPM8kf/JU=;
 b=VuPYIL02HntaWostIXH5/dOqlxhh65I8KsE05jGoRl4WJwPIA3hnliuGRCZ4vt77cbgM4S7QIyrAwo3WBhsHEgV0zyQYv6u2oKIxTvbASYrpw1SiQfCawK3OvORH5+CLTo63BNvmUMIevTtPnZe0aiUN5jnTWlNXpKmmb9xnqZjeuY9M9jdsQhGxTazyS5K3MLF9BHOv5Q36+3EqNktv0ZuffdtgE8z1/DG5Csm99FX/1fF5w4/o51pUnXaV7TjrOyWN5jYZNyhPVv4qAtcwWBkzl1B/hZFUXFmpfz6jr7qoRdh55+IiRaRJ/HFbp7gBw0KpRg1Z9Y9wUn+CTe2Amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeZ2qNQ3BxpCybAQAYuPoAexBNCg43li4qAPM8kf/JU=;
 b=TufKH1sj95la4vuoX0/Yy/NBk2rLDj3qvESh3EWfNkW3g2Q+OdbMk5WnzcYaC7AoV2RabJEaYHT/IgPZ6wQ5RATo88TSBm9e7JnJXk1IWkyartbBGhy/q82SMZjADSBq4IlbRrnIt0q2LQ7K2CmIEcKZnuVJikcgA/FpcedFB6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DBAP193MB0892.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 19:45:57 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:45:57 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct
Date: Fri, 28 Jun 2024 21:45:29 +0200
Message-ID: <20240628194529.312968-1-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DBAP193MB0892:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a73860-bf7e-49c7-f34a-08dc97aaedb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fb8eAS1RiOZh4tSN5FMEVlpHejeW2lyv6H9SYKJFQNnOYtKFtU/9cJaPVDl5?=
 =?us-ascii?Q?bebDT+5R4KH1vq81VrT7Ub4kmI5w3R1YtTrDK/iLpd3dpY70Iz+Q3pGKbLIT?=
 =?us-ascii?Q?KaH9uDrJv0VrQDeSNm/MpULbdker93hipkgfH9xvebfgSVqJl1Kw22UAV5rb?=
 =?us-ascii?Q?sL3FmeV8LUbBc+xJFn2Fty9s8jrTWlk2bBr6hIZnrni8F50K5CketSprXMvo?=
 =?us-ascii?Q?ooP0/2z0nEur7b1gjKZ8X7dIjKUyFzFEG32jRyV2PvLtOFwaANi8zCI4y/n5?=
 =?us-ascii?Q?c7gJZO335nogi6BbwC92FCs+vDslrMpa8d022CmFF0DMbwPB4IGcPe3JzcON?=
 =?us-ascii?Q?/Bk8VXbD7XWTGyEZASM87SifmufeXIQwbaf6+WJ2+Gcw12n0O3i7+5V0e/s6?=
 =?us-ascii?Q?omvaBdWbzN4Op1cKu+SIfeIJxmW+0yRvDSZ0sFA/FQ2WT8eMmqQrUsfAaBdl?=
 =?us-ascii?Q?reXjU65UrTQYjXG3toEp0tdGfs1iKW9uAXLiPioRW+KmgxuTvOHGvva1/QUc?=
 =?us-ascii?Q?UqiJ8Wz0QYGlSKY3DHB7KoB4qqlkj223s0nxcv9j7HWHwokJn+pcL33BSeTQ?=
 =?us-ascii?Q?z0C34Nh0ukjaLC/JDOvRsRjSTLKNvKZ7jBICJ9g72aAgYkPwG5OHIDx9FEFS?=
 =?us-ascii?Q?lWJy8r1D4QUVc6AhiKXJOX0a0MfYi646VJzqanSY6AXvEg7RGchsHDi578qB?=
 =?us-ascii?Q?nj037TIw6Ya5L4uBuVcAShgVLqTXMxgc6Y2qZDmXu6YNKBaL5mc2wHSZE473?=
 =?us-ascii?Q?UVMaEEsuWE/CbhCGlj4aZvbMPth8ZxqcGxyRpsrvaDrpusgTLogUOb9zQhny?=
 =?us-ascii?Q?7NV/ntp/NMdEFfK0wYBs8OGpGaAvGWAIcNtxPbLshOfO5ugTWPEEN6h07A6Z?=
 =?us-ascii?Q?0de07M9ugi+Q/Cil31u3Q660hBLNNDbcvNPagYgvzuNG2s1Sm8idrYalVpwU?=
 =?us-ascii?Q?xFYGvE8I0iXbcpxv4561+dtqKngUgDHHWrt0zNW5pHtLP6SeIQLBPKWLGUOW?=
 =?us-ascii?Q?ghuncz3FKem2ZVPtsvyyUaT7SwwV4GHEtwmrEz611vxneEW1V6H17AyT65mI?=
 =?us-ascii?Q?WuX+CvKAuHEheuWAzC3V5u5MRktSMMfVGgPHQHDggFAvh2Ezif/DMDk7Ov83?=
 =?us-ascii?Q?Ef/ryJCobA9RBtxOClTxxLQort5WSg1mM4waJX7kuW/m52sWz9bE4Rn9MwuZ?=
 =?us-ascii?Q?WdRUS8lr8D8cWYg0Q6ds81KiK1PowS4nJvgLoZWXFNjVz0U/WfohWJ3ka/oD?=
 =?us-ascii?Q?8cv3OaqAS7j9ZSzhH5ryYI00+XAo3a8w/f9eAQQPjSn9thFKX/cu9oU4s6JM?=
 =?us-ascii?Q?p59UeGOKRWgUT/28IF0ISc15dsrEB2S52iHpUe9xs3/b6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6bSr4kJGrhfzlR+60tWNkgyqasvt78vDMcYzlwRIxEztutonfgbPoaSh2uoi?=
 =?us-ascii?Q?WGMwzenbtL3f3jKPcnBCbAB1lKygM6MBtg0yTXRUCFkOXMgPoICIS9vg2V9I?=
 =?us-ascii?Q?FoLzohiUKHpjjVb509JU1hC/gEbdI2ihXJFfOY8q7FoXsl3SrJgDe98m+uNR?=
 =?us-ascii?Q?+3sB6FCVmZ0a/kXJYos8OSbVf/MhltzbOWP0a8FbQDWeUg6tgazyjwi+BrSN?=
 =?us-ascii?Q?nF3tiZ32Z/LQdmqToI7YFI07A69/I5dImhymR42ACNDEqGVm5L1Kv9rwBoVW?=
 =?us-ascii?Q?J0upBk48f+Kb93roJ8mMjP5810oCRfTs6QUUXGt6Hlb3TVFKc9+aD4R49iI3?=
 =?us-ascii?Q?KtnJcmAttLqY9BS5k3syfihCFZjZc4Hywi778FnLA0FzpCAR7KNc/clJlxtu?=
 =?us-ascii?Q?mEJZD3i3xTlLVJt1xdh6igQugcCWIf8OYdNEPthuOln9YgXcHD3Wvch5JYFd?=
 =?us-ascii?Q?HR4Zidh2nlBT5DesZFrbzPT2F1pLqf4sUxn2vfi9gGUctjrYEDH+FFzzvxhF?=
 =?us-ascii?Q?itPkEGc6rB7Id00kJ3HsWCvGtFZEG0VybIhNAfWVTjFQZc5WN+RA91gbQO+N?=
 =?us-ascii?Q?5KhLd3lEJ3h1O483KFgbyT2KYpbhm7Y+7hfiwYXpk6gsBMahJ1tfj/768OcL?=
 =?us-ascii?Q?oO7SpXgDPd1uQvw3HchW+9dH5D3loQqFqlZ5uWLZnN05D2iBgH5KcrW5jgas?=
 =?us-ascii?Q?EJ2j8bGMQ/N6wZQoF/Gss4eR3l2MKhWaNVY4fqmdIuxcz/ZYhOHPFnNuGJGX?=
 =?us-ascii?Q?Bbxne82YratpqVC8Bgx4Io2tJM18+FCPvtDzG60M/eNEXSS7WeHtXVJRvLPi?=
 =?us-ascii?Q?GQXjULYxx23n1L403hNod9szVIRV/wWFhv/6nq+yISNwGfd6zCjMhcv/OMUU?=
 =?us-ascii?Q?iayqkS+sM2NqzuIt/BoIPzDCx31ZIxJ8X1MdDyVtxfC+EwZNaN6ZbiSsti+y?=
 =?us-ascii?Q?Z3uR0CCkMAz80XMJZcTaUE6kCWZmBhPK/VWYsKsrwAXYwbPwxecNzoU9ocbf?=
 =?us-ascii?Q?KNi08pcsVi3CmDahY6vhV3Ca6oMXcam2Y3V1T74DkSIWl81i2PTI0XIIAkbu?=
 =?us-ascii?Q?IvYjyNQMcvD5ugqVUMIKkMr8514It2ZhZ5Qx+WV/zujKML/5W4TclXbA+qpF?=
 =?us-ascii?Q?nNYFdNYes+cwX/CGQDWz1sSyDAphhtbvHUSBmQ2Wed/8w2+1hUDH9KuiJ66i?=
 =?us-ascii?Q?vcPjvhLNMlxYa+MfkrXSPjpED22JfiEFGdeeTL9UeI/8MZzs/WFgyA3deZid?=
 =?us-ascii?Q?QmUXzr6TXe+CHpx5O9a1gl1te2I9PGyLVRM45L/noHH1hkvtn4BVN39oJ/8i?=
 =?us-ascii?Q?zEp1eGLKDGsG4fBZ445BFgXi7TjaBDDVZdi+fBs0+OLe4cbv28wQ6ANpLbKq?=
 =?us-ascii?Q?4tVQzTcqayQjCtcgGNRKT1uCrlaLrNVV2Usj4EibXlLHgmNwOFXvGmZqSLis?=
 =?us-ascii?Q?lFx9Vp41eZcBviRy2DEsFixHJSHLFAMwfsDgNXtzMWG7BLMLln/TAYoLKdWE?=
 =?us-ascii?Q?VQ+mLr8M5+OO9raBHYYmoog4CCRG43bw/VLnweVhIPjb9DMKlhIYigSL1zD+?=
 =?us-ascii?Q?StRH4grdrk2ALHTTngPqfKdNZ3iss56a6R3k7KZY?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a73860-bf7e-49c7-f34a-08dc97aaedb6
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:45:56.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qSmb0Lh2RJnKaJvLuoMXVFz/wAZRqC/QtX80/YGdEgJEd9SKK4gULNbhdlz+0SUus7kZNdWJ3ToRSCwl/3c0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0892

Explicitly set the 'family' driver_info struct member for leafimx.
Previously, the correct operation relied on KVASER_LEAF being the first
defined value in enum kvaser_usb_leaf_family.

Fixes: e6c80e601053 ("can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7292c81fc0cd..024169461cad 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -125,6 +125,7 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_liste
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
 	.quirks = 0,
+	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
-- 
2.45.2


