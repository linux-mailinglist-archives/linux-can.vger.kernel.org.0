Return-Path: <linux-can+bounces-7432-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBRZHEs482mPygEAu9opvQ
	(envelope-from <linux-can+bounces-7432-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:08:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8764A16A8
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0234830196D9
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAF3FFAAA;
	Thu, 30 Apr 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zpv41Rxx"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3F3D6472;
	Thu, 30 Apr 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547231; cv=fail; b=P/Y2FbNyP8cUan1nGT0DeG7dl7uovNOJKm/4tM4OcWJzY/mrHTkuSxOhm9Fmjz56a+bDlttd7HGjeD3/Df2jfxg8rfcQ2l4m0vAYKUJKRtId0bWHoTu9mGkV002Yk5ldEJX3Mz+g3pbQOZXL5wfaMBekpDUrZnJYWuoPioi7QpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547231; c=relaxed/simple;
	bh=FLe7DGdp8WeC4bEAaBIRHBvdEa0iKy/XW2cxeSZnluU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ApRxTvTZNqlOc3bf0DHmraF+wNm2PtrG5dqqH5pK/H6f3Q6wgA01t/01Df8u9Qeok09vvgfmcLccgzTCQS1pKrIbVqkrCLNbznwpiRZkqvHAhHCSdn1nfhNlupd229moYHKvrOFJo0Ey/wOse/EM4o/VV1IRrtnooxvhJNHC1Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zpv41Rxx; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkNaod3ci9BBz/hkuwJCMveCTFvYImCWSA5Q+zxLlHhLR+d4/kn8sWYxkNxlmbrmhZjKH+GQ633I066+kkTA9xC21TQl9WSfet7q54Qh5SjZZrwf1WRAuE7Mp8KyV73x1+Bl6F8nhH4FGcCIRUpfzKB9AbC35uIPwX6q3Fgwxfqh5uSRW9OgEKBUmj2bPlS3a6ma9p2wpjtOjRANB4XolKzylPHer1Nu3u29PBzpbWRMhFtH2PcQKuePZdl5nvMwuju1lpY6rDPtoLLaxGfTSQwCi+HiKI5o+tnL0C9+tRyONAC8kmBtWrC4UvM0zpD3B9wEaXZaLZ4i67XOKuaDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhPAvN9u5uRA/0ZY9sstlg9JzfTkfHZ8gRtoUybdZGo=;
 b=GcVfu/AkOMVyrDs5Aghy6iWMO+GkP/JY21g8pNOvXEm0A4qLqVXhRbYSD4hCkbgV4fC3624b54emDczHr6j1Ucv42InDwGfGbsc0t/X3ZtLPIY24dO12DPG8VxQ0EiiOdCzG4ZJ+bgaqL77GJxshFu4z3nCsX3Js7eS8uKcFdAMKuSeGK9fj9EpvY+wdn+xOUiIEg6VEYlPJ+RnVDsCUwyQJ0Lfz7ydlGsIwrBCoihk4S/oQZ4c4E781TrQ0Yo0rshOVeRxWHkmJHM9ZijrptymaTrmP03rqaKi6+8+HZj7CkJcYen7FvBYt52KQ5PYAmOSHNUVSlFs/AmpLG98Bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhPAvN9u5uRA/0ZY9sstlg9JzfTkfHZ8gRtoUybdZGo=;
 b=Zpv41RxxlPW2MtWhL1U5KQZyRAS6ilqc88oWvfHoH0VRDxfWSLOJ8NMgXhmrVl7/lHbP+wx9LPgRVL9g4qRpPROx8xsxNcr6U9iRhYqI2IVEf/6KuiQQSMKS1TLWJT4aRj4KLLHu0jld6T9D4sXYHLxGgY4cIWSFdfMcHY1if3Ak4DH3yqC/Beby1ivM/llByGYXi2qjXnMwSCa9iUgqNjRNyoDBVSg9qfoIopTnh9i/c8G01fndOBosbp50L7AWygCgrkZKwTVgmh73rP0ji6exjokBohIkEOChQVKpX5Trj3tOMRiOGlAxQWBAyeJu1vSeS4oHcS089ExQq2rzCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:01 +0000
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
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v7 phy-next 03/27] usb: add missing headers transitively included by <linux/phy/phy.h>
Date: Thu, 30 Apr 2026 14:06:28 +0300
Message-Id: <20260430110652.558622-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6ddeb2-5fd8-4a1f-235a-08dea6a89a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rerBDG37/6kf9IoEdLLFJq5ap9uR/KzTntA08B73sHLOpEd+7wZI64jYX0fMDfsmTT5YdG0sxtwYxc3x6iBBazuOfz4xMww2c7vFIvoALT7klUm5mFmD5T+l5vAm8J0g/jfb+DKsk26hXmGt/0IKfD1TtZN7xKGkTGnGLtEdcnuxJVvgLZr3Lu1aeIvEfEBxbx+fPAZezLD9qpr4x4TmI4TWIdxU/5I8oa0rETYAim1t1eu05iNf4csVy7taopXyuyRSU67Lt3DLvEbwk/pgShxMBigI1safRhDWvgKxnU7TAo4DwPaue3eoDNA0h7PwZzC2xGhBfXrlGkj+anKJPqCRDiKuRD5gL6behbkC6tuqYB7RzQ2FXqY5RbCQ6MHIGQBfz8dsPAwXfDwujRVpLN2nax7sUNI5wUthIts0Q8qzrqGq8jH6cZ+gFKuKbuTxBDYgcofoVyYzyrHhboNCCY4OoFcwGYIdRNiULqtghOw/7ki1lcYK1xnbM8zJawPw4Y2K4BOtcUIvLe/bY35RKF0pzTD6OctfuaXmWYjzbOF+idL/2QYd4tdAKGiw5gj517muD9/lkP2u0mKg0lROb6Tuu0lNeSXPRI2CdjE84Ji7mlkC96ndOxuOdK2tWRP83DDkcqTDryEsEiKnsEyAs+2TYFTdc0gtUtAM5V72ccmxkyB31RXBJemlqpoUoN8y/E1/bGtKtk39olc+wOxiKMAtVjce7ZszetQXJAQ00Js=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NUCBRlPLd7ISFjaSMaAP6P70S3bM0UtwS4uBMyATrYsBZorD213RTZ6ODttp?=
 =?us-ascii?Q?Eo1OJTC6z9shq6DpyVj8/nNQ9LzYa6WAl3rgTYUbSiW0Thbs7gfk0AalQz3h?=
 =?us-ascii?Q?fvV5Onbplpy+jfWVUVB4BK+QhfbUmTyezxoUIdNAYozgwsTBeFjHe8FzIq/J?=
 =?us-ascii?Q?UI5YXwJy18yqWd3mvhH6rr3/nusgtQ76uyCmtNOS9bHT0AZIk4nf5B0hLyhN?=
 =?us-ascii?Q?rS/qTReH7rBSsOGjcAaw1iDTADbkSr1GUNulDnPKiD8tJYyKYVL8IBopqkxn?=
 =?us-ascii?Q?9aVjVeep0M64O/iR5e5/09yoQI7isbJrXpGbAtPgKwuOYfI2tPpXjWtUXq1e?=
 =?us-ascii?Q?GuufV6Nf1DiaR5o4/X9vrC81ZyNA/+b4zm16DYBfAEYK9BpyNWe1k4n/lEWg?=
 =?us-ascii?Q?B7lRWq33pwM44rBVhLaJnjnIWtxa9kRlsdc/Ntf+OEoZn2f6VB1VwzOjpLho?=
 =?us-ascii?Q?QLrvBHAugVClEOTD1cjUAWfhu9delVIAlVU1BR5RegTBpxuM9LVA9NJDqmFN?=
 =?us-ascii?Q?zYIKtxPmpcIHe7qFcKxrJWRZ+/ppzAHPaJMjDjNPFxR0+12cJ/lgs3XkvLHH?=
 =?us-ascii?Q?Exvv31Y48Od5LRb3Jt6p+VDnAIyCE6KUsD+bbUZ64e/P3tA9T8GZYoNllYPB?=
 =?us-ascii?Q?24mzmyIIr1fMzHGhRsVLVbfa5VSDv32qm93OEnSR87r9BH/Mspca4JTiO+S5?=
 =?us-ascii?Q?5nkCWLjC0Mv+cE5n3fPA5+kN6zt6o9ICYzk5uZmuhctsqd91VR7/ssL04yNF?=
 =?us-ascii?Q?p3V9ImnqknP8KdFoQH35MGi9IKcAM/uP9R+2kDxieaNXsICDE1m0sc5vVW1w?=
 =?us-ascii?Q?ton0vz+dy5U9kncsd9JpddN9lZ+zTZ/Vui+JCdaBaR5DJDBeAbq+iifVXTFQ?=
 =?us-ascii?Q?wSuLmTpshDWfVwLWd1bp2+zs1zTvaAzEX0Ca1Ycq/e7LUoK68R+XrUYUrwwz?=
 =?us-ascii?Q?ZsOJNQT0JoQl+gmXVe6/abUlK0YUt8LiKUC9nMuY/1mMUgwLhPkaR/HsciSm?=
 =?us-ascii?Q?W3qs9esmIRxyOSvZAhKMwdoCiMDGNFD4GLZyyOPigzTwVRiOo+ZGp9gNId6t?=
 =?us-ascii?Q?hPTLf6DVi4dYg2SGCkNzlsOEh8YYXoIYpzSj9bMQjsScl1jpE9IdaKtWY5PW?=
 =?us-ascii?Q?mpWdVomLdjIyH7szfkYTAmNmCdFz6kvLncEwKJo/X3VeMNph3EjFaxBK7B0G?=
 =?us-ascii?Q?cGPIvi8QB4ARH5kXLZPKsmpAyZ/Sm+7WRjkohTYMAqyEtporhYPORFxDVUou?=
 =?us-ascii?Q?PkZJfjRba62XOd0hEcHLVqM1cKFbFhUki7IhhBMPshyY4a0SrbHSOapU5/4D?=
 =?us-ascii?Q?LsUj55BLRlDbkJf7yYF48tLDdwBqvGgnBstKhwKV96YJBzO+PBR2qktskJpP?=
 =?us-ascii?Q?W8bVQgzQbjrTrdOn+Oxf3W6x+jdEACxlMO9i8Ndj9aJIGSTqP3q1isgSUg6X?=
 =?us-ascii?Q?90u1RH97D8qSABGJyq/6CiqMS9w/H6MQzrMOT+u1aK0+8J+5VuaT2uGLtIUk?=
 =?us-ascii?Q?J9YhFL3KuNE+2CoPTPE6iGFiAdebjDQW8gbX5r7ZRkClwRbkAT58P9cw+Iwh?=
 =?us-ascii?Q?wQmXmAZgawxte9p1Dwb9JCrc8CfKVe4865hFKhfHDUpzWfDyWvBPCV1ze2w3?=
 =?us-ascii?Q?YOZYqzefNKhLCjmS7rTdEnvX2kpGOPUFlGfF2sIradLipq4avxNwqcRwigvX?=
 =?us-ascii?Q?tWdw0Y2q0jkmUrObCSInQKExpyLccKzivBErA6J8iJ1uEMT4JLcTR/TzxfGc?=
 =?us-ascii?Q?j7EgXd4Tfk0Uy6VymJBDFrIOVITvX21BQ82zKkuQxhAEJKxwGEAb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6ddeb2-5fd8-4a1f-235a-08dea6a89a91
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:01.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5VII0J8+gB+Uyba+GeU13sLDWIxg696p0L3+rOX+FxVrUFq54ABXxbURo9LZLXe54rTWF9O+bH1GX9C7E5n+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609
X-Rspamd-Queue-Id: 7D8764A16A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,synopsys.com,linuxfoundation.org,nxp.com,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7432-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

The chipidea ci_hdrc_imx driver uses regulator consumer API like
regulator_enable() but does not include <linux/regulator/consumer.h>.

The core USB HCD driver calls invalidate_kernel_vmap_range() and
flush_kernel_vmap_range(), but does not include <linux/highmem.h>.

The DWC3 gadget driver calls:
- device_property_present()
- device_property_count_u8()
- device_property_read_u8_array()
but does not include <linux/property.h>

Similarly, dwc3-imx uses device_property_read_bool() without including
<linux/property.h>.

The dwc3-generic-plat driver uses of_device_get_match_data() but does
not include <linux/of.h>.

In all these cases, the necessary includes were still provided somehow,
directly or indirectly, through <linux/phy/phy.h>. I found the following
command to be quite helpful in figuring out the include chain:

$ make KCFLAGS="-H" drivers/usb/dwc3/dwc3-imx.o

Since <linux/phy/phy.h> wants to drop the unnecessary includes, fill in
the required headers to avoid any breakage.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com> # dwc3
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Xu Yang <xu.yang_2@nxp.com>

v6->v7:
- add drivers/usb/dwc3/dwc3-imx.c to the list of patched files
- collect tag from Greg, keeping it despite the new addition because the
  change is minor and in the same spirit as the rest
(https://lore.kernel.org/linux-phy/2026033028-squint-yield-4c23@gregkh/)
v2->v6: none
v1->v2: collect tag
---
 drivers/usb/chipidea/ci_hdrc_imx.c   | 1 +
 drivers/usb/core/hcd.c               | 1 +
 drivers/usb/dwc3/dwc3-generic-plat.c | 1 +
 drivers/usb/dwc3/dwc3-imx.c          | 1 +
 drivers/usb/dwc3/gadget.c            | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 56d2ba824a0b..0a21d7cc5f5a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_qos.h>
+#include <linux/regulator/consumer.h>
 
 #include "ci.h"
 #include "ci_hdrc_imx.h"
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 89221f1ce769..b3826ebcbe98 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index ca69ac0eb07c..2f2ae6f4704f 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
diff --git a/drivers/usb/dwc3/dwc3-imx.c b/drivers/usb/dwc3/dwc3-imx.c
index 973a486b544d..6e122674edaf 100644
--- a/drivers/usb/dwc3/dwc3-imx.c
+++ b/drivers/usb/dwc3/dwc3-imx.c
@@ -13,6 +13,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 
 #include "core.h"
 #include "glue.h"
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3d4ca68e584c..b5a6fd2899f1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-- 
2.34.1


