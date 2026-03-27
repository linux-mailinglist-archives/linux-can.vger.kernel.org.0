Return-Path: <linux-can+bounces-7287-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG0qGdPVxmmtPAUAu9opvQ
	(envelope-from <linux-can+bounces-7287-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:09:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D880349DD1
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E6613195B25
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA241324E;
	Fri, 27 Mar 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbdu+dV0"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536E3FE653;
	Fri, 27 Mar 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637367; cv=fail; b=uFAtlHY1q5TQjKkm7Y/KHElFwZhIgwc4p3f5dr/7GKpW28rigNnjlr2tjMskgtN2+bLMXDEbZ6m85eqsod2V4DeQwQIEd5J/hbJkaFapcsdVkneCYR99ZkL1wU52jaFx+nJpqXF4P4wpIv53jy8ac97Yr8hRotXYez4gOMS5RZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637367; c=relaxed/simple;
	bh=scRp4s94rZf/U2E3JGXLpk494PeVGaVWMIjoOEBKMcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDTBekoFofQmzVkTftyMm33lssKxW+SMlBnFM3KPwgh/ijpIPfcrzbdfzij1RQA+g4SvYJiMXtLzxZO6xyIkcRFEy0FCzEskLW8Vgga8UJ3zBnxl+7hWICiPuCRnLWtgNxtdADEcNT3JLX7lr7ubYkI0soe1z2vzRolSf1W95q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dbdu+dV0; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHwP/j04C2csl/xdanySMqD+x6uMOhTMqZXJumu7xi8Z4maMt4jm0silox4QOjWW7+Un8A+jrYGlMY0eYHzP08guIRXCbJM6Pvvl7bYWYnB5p4QbL47/41poZwsj00nIv3V1ZUYQySZIQVhcYN+RDiiuC3LpOiaUnB8IBcQrB7Lp00TZMYGd2frFShXZkd5lH5bWs2v5loY2VFWlf8y5a0dhM58FAW9EbrvrkhuDRGvDpRenTrkTlB6zQ+ixGp1XTw/Vq5Yb50fBakH/DGkHfSOND7EVx+cATxp1x7ISALl5uO9LAz+dZItpOMxwChBtQGU33m8I5YRjtP+80DniBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wUxyQfIICyHiocl/8Hfk2mOOKh2ERGlTdSua5EuTn4=;
 b=Td1RkI2C1ThyrC4kaBC3r8+uW9HjHKo/ZydCFbIwET4IVlVwSz9qCWnT4egzFIEoJZEI8iVmR05QRLOgFPUa5l7jQeuP1fNcxr01WnWm3tK/KyA/WW+DWP9FfF0c3LknlVIbXb9cnQKvrEq8CzktVmD0h0Qr6u6mEPckdK1vHYMDh3MmumDA16wJjqHJyjqY0FWwdciOlur4VcqsbFjzr6YsLFPandbgvPR94rhjCucs/bgAMcuMA2qCfHufDMgusEyDnIY+euFAWiThtPPqkndNLMD3Xj/pVsFFIAvU0/MbahjOwqD4aR/X5wkZbRQDcRC0iTlLkmgCwomYDow+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wUxyQfIICyHiocl/8Hfk2mOOKh2ERGlTdSua5EuTn4=;
 b=dbdu+dV0RInLeoV8TGGiZY0yXhp9elX7toB3yMbIxqU9CHOr+4TSZig6iwP2p7pPdknr+5bt5h+KfK6FdSY5rV5NetacUEjzEd2BVdo4mWXd81LgHCjv2mpsZjyeP2XVoeaal4HPTpuhflvZ+9sKTRz+lruBD+W69BAS8xVy+/JzsTfCxeSCZ8Ry0uuqNnypm3B6YrBzNP9xGMgCbIHHrws3rl5I2+/jt2jpI/hDW0CS5mtb5tWqA4oXrn0IJgqfOqMyK0Bph0MwiEub/ZoP2LUoJw6TiVV8t0lrXTfn9HfPTEvEj4Rckz+pt0tMWPlXPmK7JBVnefWKe9lmkHp9Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by GV1PR04MB9515.eurprd04.prod.outlook.com (2603:10a6:150:24::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 18:49:21 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:49:21 +0000
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
Subject: [PATCH v6 phy-next 22/28] net: renesas: rswitch: include PHY provider header
Date: Fri, 27 Mar 2026 20:47:00 +0200
Message-ID: <20260327184706.1600329-23-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0170.eurprd09.prod.outlook.com
 (2603:10a6:800:120::24) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|GV1PR04MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e5ccda-53bb-4731-4e11-08de8c318ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|19092799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e7Ty6hMrlEQ+COimMeGataPNybFbtpq9ERfoJLJyAh5iFov4SjxAK5WU13ujGZJILgozVxHhAVu2iJ3EC0msHOpQbl44quaabjwWa6k/W9XkKo3ik5GNCYXzuBbN99Nrur5r9x/lQmf7INpM0wg/CCsibSIjdlcB6zsNpLczoX0X2kj+LqVyvOrO6X3iGfAavR5S0eoQ2Sd9OzdnNqkFVuFFdFXIxajbQW2HTx19nK1k4Tmed4TBSVqTe/w2IGojKro0CGzWXNrP8cbgtEfeI+PbuNkdJFaSdMbBxooec1s7ABHaciUFtki8kz7DKbi5a8pohRjRO2bCo4fh9nTf7bSrx+se+7N4LWu0DwNkKJj2djVAv+y6yT6XhnOeNVfFiAkt5c5H7qV/APLWoFKwbfwLWvMkI+oeFcYqYpHA7MFKJUkk0TuO4w71c4ifo7cmWY7sNac6WWv+r6dfI2IZr0WUw134P4kwxt5hufvXjVwqBxio6VOmr3+EEVvIKwM/B42k+KeIPNPQ/8n4ixByDpu3kTWPbBLm+tlk6+epecFPzIEXY7NNqR4S8TRz2Rx9IcmZEpw8feK+J1VDKHzRHqCmd6tvPjghKidpuiCq+JzsrMHGn+6B9MyisheD03+f/7irLPeAJq7G3mt5Xkks1g4JKSrTiR94fZn0yObfWFNU/2jHP3YYLgDR6hMdQJcCdqEhaMSm5rzwNPGzQdtcw6vZVWSt5V9UC+pRfksGOViurg4nK50sdGSqgluljgFh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bgWTs7VczB5MVhbTyChPoQjwRniVUwUsfp6zWXnp8aLgpSFGuyjqvfUsb2F?=
 =?us-ascii?Q?NswHdls7bsmn56LeMedpkjol45Wv82o9z56vxQzMpWUEmDPgaUDJvLbA7Eh4?=
 =?us-ascii?Q?jEo6tMGG3Kya25YLMxLWWOBGhPG5b2UWaht5ZQ9Na6Lxiif0IKsdpOKYtLoK?=
 =?us-ascii?Q?q3NrLf9tSACl0rZO3ih4vUJRMB+kDgTS83NPhGnOu4SYsE8OMrRvKdHGiRje?=
 =?us-ascii?Q?7yutF9YxZQq+R8/yY1SkGJ/t4bVTcAbVesEHeSbg200Rgjbml5g7A00smETR?=
 =?us-ascii?Q?H9wdfbschpPi+axL/zqj+isp/u+DHQ0tlwp/UkAApt47bYGt+C5s00bqTc4/?=
 =?us-ascii?Q?L2L95EQtbuOeR8iVECI3Wh9SUD45jVQzMl8ZgClzq8GfO2A7/ekMmMson14Z?=
 =?us-ascii?Q?BoqeMSSd9P7Uospe1T9oHQVN0IXJvI2sPO/FrZ4Oe81zoDIGOm0iusQ0dWnD?=
 =?us-ascii?Q?vpQS6RWaDpTWgxJR0Mvgq/eK9EFR3xvq2amfIYTDanMbI1oerYsQ+mC97x6m?=
 =?us-ascii?Q?XItdlrnB2s/uHJCQw2yQPC5dwruUJnYvJ4oyUuOlIflIBdsztFVwEMlw7kWF?=
 =?us-ascii?Q?EveBYQaw838Cc52qHdbrNu0EPwjhDDDDIy9kzfUvf+6LoV8a7jBzQkGioZ12?=
 =?us-ascii?Q?s/Xg3HswfspLULrNiGetuMjCgCHnLaJgrprhZpbixe1Y++N9fHwk79YCizrQ?=
 =?us-ascii?Q?mrOfmIe94dq7L1RCMfLKsmHXrKVfpvWIYF/3rNmgg3wcec5nIVVWBc5Ser9M?=
 =?us-ascii?Q?SfVTnZc6cOE5HQzbxJG5sekH51+kGGq+n3L99OTv2Y1kuH9mcCsjQrxk7XZK?=
 =?us-ascii?Q?s06qP6wh3rB7DFFPkJIB0QwIKk5XxvR3IJlqMZZszHKd7lRiWP1TN8Oa7spl?=
 =?us-ascii?Q?kKh13MNYNu/XRbzreFzEeh/C2lLfzfm/nwJwMo5OS/wQ8sKqWZv9C+NeeYa1?=
 =?us-ascii?Q?/snLmRpVCJHLncpE6kcV8vcXlxAYJz8sFOOnoVxzTDad2OzTK+IjDCjwn3K5?=
 =?us-ascii?Q?JFMMkspaSRHN7q38fHIQP/RvtF6RkQFy3hL82nzUsYaZXula1zhNP03Rslfl?=
 =?us-ascii?Q?YMrI7EOulV94euBblOPmsVHVcGt4RepA3EM7wPQoYHsCw7jCqD8y6NGoQm4E?=
 =?us-ascii?Q?WKGhdHIAG1hms2hd1WswrzNC0LWtRs15oBFBtCDk0drZPZbbcUJ6ZVJ/RllC?=
 =?us-ascii?Q?Sa4mECVrY8Z01w8FDkjt4o2FTUUpKhsGUVSxd1bOM6URzq+oOzWezkehGtIN?=
 =?us-ascii?Q?qD+VyIWnhimF4NbvYRY5KbOxA/8ladtZDb/GNGU6+mPy1hhCk8HdgT8zsBZH?=
 =?us-ascii?Q?pgAELKNVEPQCMqlGvIHDyyX4bvElSXBNo2NWsbJGhVEKdkdy1BiaNTH+Z95C?=
 =?us-ascii?Q?8lomqqKZiajkFsy6p3XKQMjaYsZC4rFZOjJ69WIJ6dHPafW6tPI8vas3RKHk?=
 =?us-ascii?Q?AbcrzOpxzX7RVTLNZDKXrSxy9pmwZr+LdxrkdOG2DEfzE0xIVF1r3U61ckRV?=
 =?us-ascii?Q?8tDiaGaJvv8xIBMM+DLnjO+NrNBKj8qyzUuixLfYIG0hYfyWiisKechYCkFr?=
 =?us-ascii?Q?EnAntzhWv63kYA+63fcLM55e+MATZrGSXfA5Y6JDrmFn2YVrxeDI7GkoWiNO?=
 =?us-ascii?Q?p9R+7l+GYRFRElOiwECM+i+chZuAzo1NPCEldt/HNZ0ilZlEc5YMujX/hRPI?=
 =?us-ascii?Q?5DAnsu9YljUE3eWCXCXzt4MxYIyTKWV3HKJUO+rEFoZb6ZbdXa0ZCcei/nls?=
 =?us-ascii?Q?YvUGb/Dap59la4U8JRH/x3ktiS5z0tlLN/QXwSCSzn9nOJTPmotW9Zzn+tTI?=
X-MS-Exchange-AntiSpam-MessageData-1: OxI+/GSjxdcUfunfnQVBR4eDpHclazs9OEA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e5ccda-53bb-4731-4e11-08de8c318ed5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:49:21.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIRfQvVY93umJZ4sO9AYmZaDwQH15hE6LT33lMYE5JD5rUYkTuyL6ESF3Cs2FzPcH2Lod0TWWuoDf4dVjk1Y0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9515
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7287-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,glider.be:email,armlinux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,lunn.ch:email,davemloft.net:email]
X-Rspamd-Queue-Id: 0D880349DD1
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

v2->v6: none
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


