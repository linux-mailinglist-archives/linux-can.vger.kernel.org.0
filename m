Return-Path: <linux-can+bounces-7119-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fu1HqjguWlhPAIAu9opvQ
	(envelope-from <linux-can+bounces-7119-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:15:52 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 251182B40AD
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3243031AEB6E
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A24035B2;
	Tue, 17 Mar 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W0v405Xu"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC83EB7FF;
	Tue, 17 Mar 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788769; cv=fail; b=CcHNEG3PDUkTO8Ju9D6yMODdGExMAFaNCKEO0ow1p6SQkwLT7/pkwZ+VJbYtRmVw+D8MA2WWmhKKLE0thK6pdNuDtRBR0r0ZKDXdOj4sSQomD6ALmOXhW0bL6ku4KNmvzmvM40zm9vCq5L8mYUf5fz8OqENkw63tbjYzyRelUYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788769; c=relaxed/simple;
	bh=jQkxsyaPjN4d3x91U402I9bjWAV8Vt2ZoyRiEJVImk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtQfwNea55N/ZfH14Dqv8PPHw8hjv8Jl8q6ibKM1dQlQbeg5PlnX12i3eBxYM0t5F5fH77IZmkobtofajCGmW0vuQ63SRnSLLbbLZZ6ftltBjleVaoGu8gtmHvImbTO/Ja4vqGPjfLZYbI7e0UJaBZufxFPsmRLyjKLXp9Mi+Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W0v405Xu; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh36Mrx+dGIKExvlczg3ka433K0gc6M+98vBG4ac2lI88TGuyK48n4Ke3hYC8o1a3dk6L3d34/0n5cFzvVQRzPmFI6AVNXkaHDa6UPqxJOERMawsZQE7zWeyoBHiTuDX8II+7nqpB65ocLDHEZK+W/SPni+VRErKrSrKTsT3wt8175HURCBuEZ/6jYlOm9QphrPhEbyojAqShzMs3hcleW13VU0mXg4VbJA7wrWSAtK+ub5GoQqw/E95BsxzKsZgrmWHs/32gCKQxCdJzevYBg/+NdgkECpUPxbZvxdgE3Xo7JtBnv/eFNSnBFFmXM517h7q12pAA5iaatJ00JgUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmFL3OIsphQVPzjVltHmsP8p6mnZJ7zVcKxsLSLxOos=;
 b=xZrmf4qrEEJsZ4N9PeubV5RnM8se5JpEztSa+4hxtvPddbEFjik6cyXBJGi7evtb/MN7RUWVKeCOSdobhBHGjEaejJgq3fT/OWbvnmAr6EJ+QTppE+FqwMtU5e/dhsYADWG/QeogZgvwr5qb1zAPZ6xwUuQ/36l3kEs00lqfep2AQQ9DGSAUYEJPoOeINq4RjRMzqu0VmnWAWWweLG9G7Cs5hSb2De1JoWPO8W0Lg3fg441wpK9EIzt6wdBjAmBKPD9N+ZBzbHhMMArxO3hkYp8TKwlEyjosNMIb9GjU1cV/+Apin0V9jzRPj1xq9bxR2k+bhBLSzsRj80cfl89APg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmFL3OIsphQVPzjVltHmsP8p6mnZJ7zVcKxsLSLxOos=;
 b=W0v405Xu8z9TbgPsaJZH1f+r5h7o2J2wdSoev17ExpTo2dW11dVLuLqyiemf1u3lKFUcuagaapMWzN4wlCjW7vgBdG5kB0d8edVM+Nwcyd8mVKJxrM4Y5s7z6VK//kXke9KbQTeQYjJ1qU1IvQPkD86OipAf5+dedFyep1ItAia2KljAfeDdkt22nNfdgrk7qoeLpECyGI57muCiZSEUwGZ+fpwoRZUlZVGYu532fGGGmTayRXO4j6d+vvlzXV35QF90gvZag7tJXD6jHh+e5QB5DIUQA/Ij1gfajlJXET4uXDYiOjt/lisUJES3T95hEHHZykb96wqgGTn321HLWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:47 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:47 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michael Dege <michael.dege@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v4 phy-next 18/24] net: renesas: rswitch: include PHY provider header
Date: Wed, 18 Mar 2026 01:04:54 +0200
Message-ID: <20260317230500.2056077-19-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 3751659f-7adf-4732-dc74-08de8479b993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GrBvYTI28sqeVNDc49yFjHU/FuRLf/MNRSJ4D7jsoQMO51DsEnNnC9FP1WpJ1ltTOtOQtzIM7Tea6fsAs6hpQ0SpkNXy0vFm3msjLXxXeuZetDEKU2uf+f396AdJ0jRFlN/M0FPES4TThJLpmT3H0cdSH/ZkcdSsVk3t/EqE4ViE8pz08cTfDO7M3MZdUXYPkr5dl4aCzYSDz+ab9myN/m3BtCXVWVImKBmfmkUgS4V8DUU5sPv7C0Hi0BuxK48eP3XdBhWhNcdL4vff2hh54JD/Uy0tcvBzKovRw5UKCBEpdapgIpAge/ojZZlyDI4LCDkV5LNpnqwqCZJSOytfC5ebMlIL+HrXCygKxhezXWEkb6t05Rr8Y87e6r9uvKebfahdL4ioR7xgZxMjP6FkxRTBo2+raTb3kyJ2zzXiFwDDEHKwSrThiUx27D53giIuRRRKTjQWRvj48IXE1UuRjHv4E56EUtRUXOxIOfwkpBq/m+1+jvMz7KVtHaOYRbysUurqhFLVMLZ4BpIapNDKehPNesiaO9pEjstJ4bUn4GnkIt9l14lVw8DJGcckJxj3PFitGizFdowJHVvChLAfNhLGApFN+Af4zKCs/DVJBvSBgqfS406TY8rqJihiAWtI+TaD+r3lEl6ySadJ54kP8XWkdIdJGG2iICMuMKlPlJUGL2aanlVZ7Dsi29gaVE05/Xu6OcZmX1m2zct885+k74mo8EqU+VJwBRMHF+PzRfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWkLggUgX+mSxhUXZ2yubTE8WZgOM8E/7sklMuZDOvkYnj+4xonkLjqZS2z/?=
 =?us-ascii?Q?+LF/aUfIbK7GOJl2+zCB/MI+8MI0ASp1SPObPIlReOFsghsmIx7WYwr/w3i6?=
 =?us-ascii?Q?0VpkRrcT+rPuvjb1ktpUV2/wxFh8igTifXWvs7Vm+KA9xDEMzjPDvtKC0qcC?=
 =?us-ascii?Q?VSYTaEmL5SyTCcL6BjSb23LCG/TUUjbLcuZCvfu7r15YTKRVYq7d0yqkHuex?=
 =?us-ascii?Q?Vn+Asr9WzYkIOxpcqRw1U3TGfuAeAzYaKx/7j5/d74xzIlJYzqT9QQda8WLd?=
 =?us-ascii?Q?QKwRpOd5VwxDfvAMv7Op+7/IgwTfRNOnlpX62uQ0ZywOw7+eiHI/YuJZ+ZZA?=
 =?us-ascii?Q?VoVwElHmNGA1D7BeQ1t+W9XmuAgiAtwZypcAQib3pxlfFPvtyXPuDJk23RlQ?=
 =?us-ascii?Q?wYmbHMI9Fa0rRGeEmXObF9iDGxn/w0pWkHcPmPAnCGowGjnl9D+dKSDMI/Lz?=
 =?us-ascii?Q?PuhyneTFGsyV8Ou9YyGq7uWqw2rsI+Q8rztm58C9BxijdaNK+tdQ0dNL3IBU?=
 =?us-ascii?Q?1qwO/F9mXoS2COJ0hJr0dqGFHhfRUEaBmHAHMLLVfEqFmkFQ5ou7wqcreTO8?=
 =?us-ascii?Q?87rJOVWbEuJbRJHVUtdQGTPTU7+eORJk4RrigjafOAXEZtdVvQtQBERvBjVZ?=
 =?us-ascii?Q?FseQzWUUPjaIsx0JzhLtPNw9H+jklILizBwqu483KgtA9EPuO3KtX7dI6vy9?=
 =?us-ascii?Q?Z1HjsAbBU8N8THg48DoJCEZO1upeAVrL+2FTWk9aXenCkSMRRN8CTOyk4QZn?=
 =?us-ascii?Q?XtPPTjCz4SdFPjPXfUk7Aa6lLCPdizOAmuCi+lR6BG03oTaWG90/FEMvtIhc?=
 =?us-ascii?Q?cGKUfcdkT5TWWHMSwmBfFowOT0jica8kfiO1D5zox+Uy6OKQgphWxQUECogA?=
 =?us-ascii?Q?XZxfBbs3xLdrvu2Q61NN6FDgKS/gTMiQhGeLi96CMXuZWUAcCfXQLrX2jS5F?=
 =?us-ascii?Q?nBQoc0CcjfSq/x4u0Sl/x0lHl8jUpWGQBxs35wHUhSUXTtGQn1ZJOcBHkcKM?=
 =?us-ascii?Q?gRKhfZasODNp+5I+ttj7NAm1DDsOt1Qgubm2Ox7tDFrLBl7WBkWKWB236Kt/?=
 =?us-ascii?Q?9vZ18WB/ER/57Pdpr7omDwVmABNSZUD21iwdrfUvQF5PEIIg3cB5LvFyfIkP?=
 =?us-ascii?Q?I9eIgHapsJQhhfNzhT19FXQuOE9NpWEHLkxKejBlVIhVBnfg4QqI+iycmlP8?=
 =?us-ascii?Q?XV0qoFmBUdcI4sx7Hmi+Bk+tm7wulGRUsd2Ar5oKsijZEIMD1tc7op4sUrAv?=
 =?us-ascii?Q?Lk4+jzr1n04Ys0yEEtQLi/BaxRlNWwpYC1T4PP4bRFlSphxpFpbw54O42wj9?=
 =?us-ascii?Q?DvM8C2/d4fwZc6oMamnpHN2O7yBWBipcxXJsDfty3D5hLU2n9RoebI5AAQsp?=
 =?us-ascii?Q?hnhbXPqUVzhxb2RXYWR4K/52jN8OYguy0lWCh9MD2D4lId/ow3t8C9IMv/QI?=
 =?us-ascii?Q?0WPOBmY2QjMogXWQoA8zesmDFugCJ4dAsu3G8YKdIq+6ppXoJqXM6Cq0hRGC?=
 =?us-ascii?Q?ysKYP/NUxO3Xht+KMg6luj8Q/V7BEbmPQpYdaeia4xIadPRk1yEEk67oAF/J?=
 =?us-ascii?Q?L0krGKQuy61SRDg4fk6P8u7Xpo5U2+wrH8nn2whmEyN/u3OtUMW6hZ2YSY8c?=
 =?us-ascii?Q?ruDUNIKGbGA47Fyc6bvCOwv2HVw1xEgAadKV3QrT2gtOsOkoIjZ5LhIFJO+4?=
 =?us-ascii?Q?va13eMZftm+dlef1vjO58giaHNQmAm+p+axceAyUDoe5fpVJmPSxok8kwq20?=
 =?us-ascii?Q?w1HoLUWimgImSr8HmUX2UyLJdrAmw2v9PyGvBqe1bWdo3vmIDi5uZr2YE35g?=
X-MS-Exchange-AntiSpam-MessageData-1: v16+JRytZRLYLX6a4omV0UsRJEFL6BkAfT8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3751659f-7adf-4732-dc74-08de8479b993
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:47.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXEa56/Fh1Nsr/mW8AajLTXLfy8hZJJMnHs+L2vKCsvdUcwMN8gI0vkfZopyvZDwBU5sQe7H4dVSBK+5iLySdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7119-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,glider.be:email,lunn.ch:email,davemloft.net:email,armlinux.org.uk:email,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 251182B40AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a PHY consumer driver, the Renesas rswitch dereferences internal
fields of struct phy, something which shouldn't be done, as that is
going to be made an opaque pointer.

It is quite clearly visible that the driver is tightly coupled with the
drivers/phy/renesas/r8a779f0-ether-serdes.c, which puts heavy pressure
on the Generic PHY subsystem.

This was discussed before here:
https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skbuf/

but to summarize, it is generally expected that when a Generic PHY
function is called, it takes effect immediately. When this doesn't
happen, the PHY provider driver must change its implementation rather
than the consumer be made to work around it. PHY providers which rely on
a hardcoded call sequence in the consumer are just lazy and wrong.

The most obvious example is commit 5cb630925b49 ("net: renesas: rswitch:
Add phy_power_{on,off}() calling"). Problem description:
- Ethernet PHYs may change phydev->interface. When this happens, the
  SerDes must learn of the new phydev->interface using phy_set_mode_ext().
- drivers/phy/renesas/r8a779f0-ether-serdes.c implements phy_set_mode_ext(),
  but this only caches the mode and submode into channel->phy_interface
  and applies this to hardware during phy_power_on().

The commit author decided to work around this at the consumer site, by
power cycling the PHY for the configuration to take effect.

This had a worse implication from an API perspective in subsequent
commit 053f13f67be6 ("rswitch: Fix imbalance phy_power_off() calling").
It was observed that phy_power_on() and phy_power_off() calls need to be
balanced, and so, the consumer decided to start looking at the struct
phy :: power_count (the technical reason why I'm making this change).

This is also wrong from an API perspective because
- a consumer should only care about its own vote on the PHY power state.
  If this is a multi-port submode like QSGMII, a single phy_power_off()
  call will not actually turn the PHY off (nor should it).
- the power_count is written under the &phy->mutex, but read unlocked
  here.

The rswitch and r8a779f0-ether-serdes drivers both need to be completely
rethought in terms of Generic PHY API call sequence. There is no quick
fix to apply. Just include the PHY provider API along with the consumer
one, to keep working as before when struct phy will be made an opaque
pointer to normal PHY consumers. But this is a bad offender (and it's
not even a provider) so add a FIXME.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Michael Dege <michael.dege@renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

v2->v4: none
v1->v2: collect tag
---
 drivers/net/ethernet/renesas/rswitch_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe964816322..132be5f15073 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 
+#include "../../../phy/phy-provider.h" /* FIXME */
 #include "rswitch.h"
 #include "rswitch_l2.h"
 
-- 
2.43.0


