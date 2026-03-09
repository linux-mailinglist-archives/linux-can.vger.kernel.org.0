Return-Path: <linux-can+bounces-7036-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD/4G6Uer2kgOQIAu9opvQ
	(envelope-from <linux-can+bounces-7036-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:25:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAAA23FCD5
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994BC3171B25
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C503EFD02;
	Mon,  9 Mar 2026 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IZUq8tun"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCC3C3BE1;
	Mon,  9 Mar 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083383; cv=fail; b=unpAATJ/YOFKgGJmH7pOIt0OqlRoQ3gkjTKcQAtOXL5AlraHM94CtOu+pG080ezjOZ6dPfuYJmRyNPak3hZasmnGWSQ9TWbfciVUJIMmKcoxo4b24PoA+QppImsL2L/NziFf7zHckLqKD8ukBo5i5BQnPp2zGJJSKDOqXZMCE20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083383; c=relaxed/simple;
	bh=ETyYPJYc7I2b+nDX7S3yz2NsI30KaU+qCW1DKkHuO1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOpNOFK0h6y8VppoFHNdXlAJbXJ6CKyvC7H6WK6gMupalXXzac3yBlpJ5Synwu2YnkvDo0z5F4nwQC8cbtUnnPYHHist9sq5h5KeBkApdjEEeT2Ai7V/hDZdISqXCVUGPqH9EBclDjpk3g8QCtAM9qXrCGDQGc3C9uc6tHe+cUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IZUq8tun; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdAqnWTpYKNhYsg81Vet8ny6JCochNdPqdUQ/NbhzWvYlp8xxlV67Hi6UNrlHixbwuDmd/8hwTZwr8nZubuAZP9fGM7CEXTP5BIL2523m/pGqllcDVVNEzUct6fVLzs1W5gZzfJCJo8NA6fczBj4vH9t+U1Mn3W+RLl9pQ4f7QtrMbxawwOBKW+DxgO4DKjksJMmTFc8CciDhQVLdiomfQWhJhOeeGdvULYky/Pdw9WKnxkrmfxHNgT1VNedPttEo/n4YWYKXyRPVNyRh/ouIug+jHQGuct0g+Gl8JDYpBMxIhRvyOJW/qKHOiEwVAsCxa9N17M7VXTl1hLfwJPwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+DNpG6iQUmSwu/lKQedt5hHP5w9AbKuXPmuxEyz0VU=;
 b=ADrqd49Ocw4PFMuzdDdBdw3nhGL/SctmNvzxXij9+PG6WS5wQH9G5+wMcxUowsZ2ODcN0+fQ7ig1YbBeW4yo4ThJWPWSqwPpryvX181+ahDoF40KWeFM0/BgD3Zchu2QwpRtBBoHlLdQZuKrFApfX214eUKfBckoRLxuaN4rUCRKbwf2I2SQK4T2CmZL122VDBdEMltWhhOpIutXwRheDrQ0QtHlwvmh7EhTb0xr0LSF304vnt5cj1MsbVEvL3wGeuUu2PUPiHL6YmGQNEndhudIkFbhrcbnkS6abrAPsxaZ0QHdPnzjeXpym8lq9BuyvijYCOMbpe/sK01Y+CFy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+DNpG6iQUmSwu/lKQedt5hHP5w9AbKuXPmuxEyz0VU=;
 b=IZUq8tunPa7TIOBpmIfGtbvuMFPRRK+hm7sz0aBcEBRRzk9AFHLuSaJUW6jMBHrK9fGLKokLdvMO8jQCR8W7CxHx3VyQh5sB8joqcgIf+86XuVlDPMAvpnO+XE8hP8g1Kqrl+FAAz8vcgx1z6T24mna00Ffr4BaIk1/Kqq5XaJxHQi09coSCV/StLT6MAV/koyYnapKqVtnTlg/dT4AeiK7v87vn3aWcE6W5lTAlt9zZlg3YyiuMgZuMG4ccZf9cn/vAZmHz7IGyv7U/ENi3c/EVj7tgmxN6ADNW4XSoD0r/1VicTtdOnjCbsxX1ChAO6qbl+NXwc5DQYMtvZS8TNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:22 +0000
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
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: [PATCH v3 phy-next 07/24] net: lan969x: include missing <linux/of.h>
Date: Mon,  9 Mar 2026 21:08:25 +0200
Message-ID: <20260309190842.927634-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0110.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::39) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f71f946-bc21-406e-d0c5-08de7e0f5f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	anE05ykioXrzJ814BwI9rsXMCx1S7wd6TXnJysi8R2G/bbfyYJcwqUeuikOWvNBRIvLGtG39RwilgADCo8t6f9b9LH1EkiTHQrnkbxMBmBp7ZFMaLHED+PeCC2q1bdqB8I/j1mm2h/BH0GZ3/GL1kIKeRQ/6otgBM6XwHV7M+UZ9yYsI8pufjxyOBH1XGO2ryRek3oyT7M2dXSdWhJ2fs2u9XpUmrAlconhsGhnLVH4AhPG4xp2gCH7m9DRujTL269bA8wLLIXOBxUGi7JyF6LlMScFgxV+j4b6CaxNRMdzDyjExAVsmGPIj9XhDFqRwNhInFsMpO/XN0R3RqI2/DaLiO2QdOxokOuoqNrxxv2zAc/ZofuuIGIfLtnUdN9ONLt+xasj6dfQP25BrtShT1NW0tXkf//thxa1z8w0+i/Ph5EPaO95SySGFuA/6eV9YL+aA1UzDO1f7m+1cs3UTJHXiJXhZ30yyhhlzMwXtvN5aKAzB5hmIMe95TgCojUqHX+c77m3WGOhElZzJGf8cTiFhnLe4i6zv0iCA3LfkaIJT7P1pQ+FRL5dO3IiViDy84/biEIRucv4Le/KoQQHp9fov+mvtemrU7kcDMXDXiiqwZURfDWKtEVGRr8I3WEyBH1agb4XSgy2Fjr6mX9IKCJFCn2uXpTAr7nbHMjZ9GtuB0o68V1l/5fL/Xt0AaKs06w0pvx6dX7a+29G/UOgkmRt48TtKh8SwJeByTyLGpjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8vO7/XPcgJqHPrr1S3pMcPsYOefrD41tiIzyg/MFRKHi+lzv18CplmfcIcem?=
 =?us-ascii?Q?ZSiYqVDjxecdejOigj20Fvjj1/m+MzC4qrz9IU0nYHtYDS3YVy92XJ8hVLV6?=
 =?us-ascii?Q?vIJlJaU66aumLZJMM3Mxj7Kz6jxaAcCnQRfEnfwBCPOrnktqVUIMi+2DVWE3?=
 =?us-ascii?Q?3MyxRJfxhMFbfUUrSHG72cW8JVFiVkbsA52iOub1m4E+vSafunGC3xiegAgj?=
 =?us-ascii?Q?OGohPjqpIv5c6wLFacoLPS4xF+P8OZuXJ7xjemaiQAH7myCoNn4/nHdqTUyz?=
 =?us-ascii?Q?51On2/erYZOrEZqa7F+npJiIGPWaP5PFH9XGmZc/7wy5MgNsTeRJKSoGIpVS?=
 =?us-ascii?Q?abOu/Ve3ZTQx1I8Lk45UIKdfrGP9nrcAKrFgYQfLux52G30EwCZHGZfSuWCl?=
 =?us-ascii?Q?AvhTPMZO8efwAiNmJuzbXF1Xctd7yW8j8jBApwPDeWyfpL4qAt2bCrk+Ofmc?=
 =?us-ascii?Q?V3JCJJ2/h+P+/orkeMudpIGaM4hiJSDlFYsYQLQmzfGas8C4yGHBP1OtYa1T?=
 =?us-ascii?Q?fPoI96zpMNEI59SLV9gu22SN27dkcfzqH/46gxK3rr1xi4S29WB2yyzOiXIg?=
 =?us-ascii?Q?wWttA3jrpgEmasI5xohtk564UCCZfVP2B+RAmS3JJ+HX1DzeOz1sv7G+tKTr?=
 =?us-ascii?Q?f/1vIuVdGvsnXyiYsOApPHbDAeoZNPoTFUm/LOz54tqdHNaPClxU+VRrVAdK?=
 =?us-ascii?Q?vi91h8Qd0yLUmczXqqDV7TX05RL+OOHGXcUWdRjn/lXuHCWuz1JQM8471nQK?=
 =?us-ascii?Q?E8NgUm0R4LdyYmiKtIU2SRWJhmg71dMT4QYI0mXibg5EFGRpPN7CYqv1ydEo?=
 =?us-ascii?Q?NiqkIY9AvCQuiaLGOSoNLmqa5zD/c/VxjKyRo3HWXZVQDeOcjcMdRlLheWUT?=
 =?us-ascii?Q?YEs7JUg9c6lAZEx3d1GJMY7DzHvlGKQbA84GpW/VUpevVQ7uGExQnr1XodZD?=
 =?us-ascii?Q?iw77ovCuYN/PTr8CMjJk0mK8AjSxQiiJxraKlF+ULkU3is4XGgetTbAOmRvF?=
 =?us-ascii?Q?gvgBi8VvBGuGAJ5yYoEULY5OzzNft1TSWtlfWhzVg0n1SxVBP1sUgpOilOGN?=
 =?us-ascii?Q?b9bm9+J1cNTvXILcivPMn567wuMZS3vtSzmu9XGYhFHoV9Ny/K0xoR9eolSS?=
 =?us-ascii?Q?HSfiamtrKYtq4BpCzO1Pu6bEvUdJEKBTbcIuH21FOssv+jUCGOmm1+YZLupE?=
 =?us-ascii?Q?qup2V5V1Z3iX0wxPzVb80SIjimcS5zkAso7EKy/1Dc+tyvuy3Hqy0PI3cV7n?=
 =?us-ascii?Q?ulFbcwwZPkaocRvtaxWlO2knRr/w8W4othFCoquPV+BhN9gdqEkm62XhGVUX?=
 =?us-ascii?Q?xlC3Ywmfbcaen+OqN5E6GSYsKO/9dsG4wSmf71rSRV0UpJMIVZL2gzAmEMm7?=
 =?us-ascii?Q?r0okxnt3WIV4XZIkAO1fFLtCwXQhWcyriqNmjUeh9+qHtLwFYIrbBmB+rQd0?=
 =?us-ascii?Q?Puq2aXCEnuKAKqLF6EfFAaW5RuezaiHVsw3s+ADe8EvI+Kku7QFlJQCISofv?=
 =?us-ascii?Q?VMWgpTuBXcBLhBJfAFwobU0Gxws0BrKs5BzoWtXwhMO31kFvLVZSvnGHpWQ9?=
 =?us-ascii?Q?1n8Z6S71lnDSMIBnK7yrHrmYdP8Vyn/W992t/BE+FVvY8QSMCJ/H43ul1h7z?=
 =?us-ascii?Q?2EmAzmspq3Z5k53yQuEQnsBxRMRaOguh72bHvQ/KvaRv7XCYI/wTFwj/DzQY?=
 =?us-ascii?Q?uaHDyS+H7/3yzyetUhJXheuoFycF9eaiA3hEBCtnl5aXNEtH5DmlHHfdQgz9?=
 =?us-ascii?Q?1J9wf4Is7ovEIfsRsj+m6INXT8ZedL1mSFAixcLA2CqRRKcZg2OfLKvzfScD?=
X-MS-Exchange-AntiSpam-MessageData-1: XpEs91m8xcQ4+emTNp3xEzq/1EWLOZHf9yY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f71f946-bc21-406e-d0c5-08de7e0f5f8a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:22.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gf+fcZtC+tNzwV4ZW/j27l7HYPZP6dIVPtXd02xuOP0T6K+21C9rtV0bt9i+/p4acKe7z4AjJrwgPQHOiXor+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 1AAAA23FCD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7036-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,microchip.com:email,davemloft.net:email,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

This file is calling of_property_read_u32() without including the proper
header for it. It is provided by <linux/phy/phy.h>, which wants to get
rid of it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Daniel Machon <daniel.machon@microchip.com>
---
Cc: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>

v2->v3: none
v1->v2: collect tag
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
index 4e422ca50828..249114b40c42 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries.
  */
 
+#include <linux/of.h>
 #include "lan969x.h"
 
 /* Tx clock selectors */
-- 
2.43.0


