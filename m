Return-Path: <linux-can+bounces-7272-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OTQINbSxmkhPAUAu9opvQ
	(envelope-from <linux-can+bounces-7272-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:56:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F7E349736
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 19:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 414193078A01
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC838386C3E;
	Fri, 27 Mar 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tcbu0LuI"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F63845D2;
	Fri, 27 Mar 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637336; cv=fail; b=iXhibZc0aNteGhARHlOj6+KBfxPmrywa24fR2fAI4BUXFM52nV4qGizedztpx+fkKOBR99cemTq1pg7C9U+1642HQruIzFysBtLnaH4LvXHrfqrqf4iNcj1WMgaqTmcTeqJStAebasGRycOQPs3E58g13JN99LpZCoE7yvuKuRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637336; c=relaxed/simple;
	bh=xXxI4Dwy1ou/h7EE35vcO3UQhbkASyZ92sFB18ZxtwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTfXrHB02JPPVMWtVL+r9r9OnVihjqv5Z7h2TD1xmwZzfRg0tc9PrJVIrgU0LpTjBImjOnZcpzn3GX9hIOq79a587ALzofWau2PccqwPJGxfabeL5yBHZen86AkPfexnrK8uvdz+WwISsRSFYQXUx16V3XfGtAlYuo+yhMHo918=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tcbu0LuI; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSq6n7aKIEZHMp2FyHIq2nZMZsQdBYe7M3hPIQxt0LAYPHzTxUJf+v7r9wf8TsRW/Y0D9jkawqwyK0bQz9jWfZzhXFCU1qRDJ2uRMI1KPtWU3VwZmpmaaenWsIwmADr/vLaDsJGQLoP5nut8I4GAmqbYHDVAJRpjYCqTsdM5r9chYGzcGsfEwnANLK+Cw1H29Fl7eFKhrvg6s8TzO5evfJ8zLCUCzNmM9C2Bywcydk8Ml0kzmt9akCX2UGHsNk6bGIzmjS8H/uSI1R9I0tRpjSl+4D5L4eq8RpTdob+OA3I0efP3hJapWvPJK/LHeY44ND7JiDvNHwOp5VCotq+zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDOKsrtclLvWbsN/y6YshoLil4LdttpwB470R47L7eM=;
 b=UxrwVWjlO5GlrCLMM0GZtfXJ7f/Ej1J5TciTQZ+npT0MOE+/8OJNeAtvwaKgZxJMi66za15VFjXtLHu8a8K1rXjrGW7iqHIxL/WKAX/UZpy6QA8NOdOE1ACk55E58OfjERIpj+wUxG9hjjL8GC0lz2jLymb85DT3qYLfrVndNJHPhXIN3bkLPtcX33ibBJZbbFyg4h/HZfAPWzOymLqOxW31WG2tsiPFVNJDfnH5JTdq88R+b82lAPdA/bKunCrScdPLQo4+QZDL+UGlhpmnkGI763R4IHmsjaRxmYiI4Hs0rrdBgGHlWHvS7Od70sxvG+bNb7p/OVkslTK2IWkSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDOKsrtclLvWbsN/y6YshoLil4LdttpwB470R47L7eM=;
 b=Tcbu0LuI3rMchERXIslbSmRy2mvN6RLmlB2zekj3mwG63PJYCwGjWsevMxwEc0llds4XBnAMkZU/T59HZ6J5qlyIEi/Gg9x/jP3MkGSvLrvQHUwal+lWmq123l2nUGmFW4h/GGmP9rLdJsaf9sLEh7J2D4qf/aOBzjYPU61pm85ptBscXg4L8HKD3RxR58EG0GSafoW+/v7Ilo71MZx9NH4655YeirRQ0IaV4blu3dqdv+EqLo/OoFtDYMJuybHtSDv4hOOtJVnWfZaHD2EJliCJ7rs2GzE/EN1aoApK/m6gPJXULNsYK85UdTILk6rWRQjt+zuAcFAmX4kZlx+s2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:47 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:47 +0000
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
Subject: [PATCH v6 phy-next 07/28] net: lan969x: include missing <linux/of.h>
Date: Fri, 27 Mar 2026 20:46:45 +0200
Message-ID: <20260327184706.1600329-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: eb41be05-bfb8-474d-c9b8-08de8c317a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b6RIoAQa9LgeUbq6LLxgwBJn4T8pW/IuMLhH9ugO6t9yha6g5yHc9JdihohEnwOGokI44ca3/trV1as3TPwAJlDJciwcXTLt1YcoAKUNiNGFkguKehjc0wWVO46A0aIGfEK5o5ukYwiBWw0W25wifOcbhbI0OTSKc2CetLsDm2+jS117pMn8VTjyBFPdC21+kjmNaLWhkE25YvyVCzEGXSVO8o/kLBQ1DrWbf7owxstbuowI6HfNwz/RTIemeN7vGOn9n+3mpJpRzyuLKmyIZrYPD1Ip4LOr7s2Exrhxf4Xdz/BsNCa+NT3rjjDGB5GOA8LolS2r4z3+XaTtZZNTeFds8GzqK/8MhWccN9G3W9GB9YOGjKclTwxJgEyaEPhDuaFqnN4KnmPHtCQ/eR8KExxjTbBcjwrhxTH/MBSfm+fiWE/eF2sQ/2ezmObx2uGmMp21RxsaTY39s9lzzHwICcixnAWCIyzGBbcsl5cE26kDMR3MvJIzDMie4VCcSdtGORLiqs0Ug7pHCi42luI045j1dRmP8z6KK5xWgxylquRKXevM76YIR7aaHqw4zJn360NG45kNL6qKZNPO0FbaC0LWvaFYM9IvGEQMHaT7koJWsGHCdLxgMXYc+qedWik6MMfidXQpNegmkKaK/KtiQhknLOnFH+oGHxxE4VrTjWMdtfeZJTAZfC+6DtCLyUNe6OqASbCdsFGgOj5ftHB+TEIysobtDTofXpifUJEZ5zE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72SffRJN998wve5sGZAvlr74KOmdTPsaw92D3iY51w7+ibK5Ar08mCVpWpaJ?=
 =?us-ascii?Q?d9LzwxdrjIg3TKHPIJiqkne/mF4OgstC7tbID2rd4lsdZWu2mBvUjmULnQu5?=
 =?us-ascii?Q?BZVMThgkFycNmB0m2gg8cohsOUJSJaA/KlcyZYB+ZtyJQsB0jjzMbCUCi/if?=
 =?us-ascii?Q?2tYIk/OAs5RajdXsicubYSwBJxY1ufeZXqcLh4Dw26E46S+xeAGb19gWL4st?=
 =?us-ascii?Q?ba+abhbfHxL08vBtEjDw7kb86uOMFXBsuJzRjlTr72rhsbFSxHz70lWdYqB5?=
 =?us-ascii?Q?KottZ4rXqiw24XbZtb5Mvxk+0q3HiQwZILNvqfbD8l24ySuiCAFqqDmS+On4?=
 =?us-ascii?Q?4wCH+Op7oEdIpOWxsn7UeMkKhSNAimyKnzXaiayC2eFReZzqmtxj5Kt8NSP6?=
 =?us-ascii?Q?hMQ2b7SKwggknpjHz1LBzaOK3T3Nvr8dusrJ6nd/VGEH+Egp2iGfHEB3l9Zz?=
 =?us-ascii?Q?OsexkBlilQ1fZvpDylBRC5qqqmmFKvf0g6ERdMoRQlJka1FAq6xCb5f7bcbc?=
 =?us-ascii?Q?gdVFEDZ6rXRflg/W1Fgls351tQ434PLq45RDUzds1uiaJfzKvMM9v9hv97Mp?=
 =?us-ascii?Q?nloGU1MxS6n3KhvzKp2oZdSgjgKY0HW8VYD1hvgsM9ihLYVwy5jp157rF5+M?=
 =?us-ascii?Q?buRTPxF3OKcJaC77tPVwhNnf07oIz3vrjjJWTN5UmKR8B8njlF3SxqPMg3RQ?=
 =?us-ascii?Q?T6ozOCP0dEs8fOb2Ky0J5C6bzmB9pU2Im3cQfQ6EdlE32eD0RxFvr7jxHdES?=
 =?us-ascii?Q?1dcELY5/Yf5+o1rMZVko7rqsw2leDHxOdHKLEJNWPzuy2HFt4Emktdy4Qthg?=
 =?us-ascii?Q?3Dp/OXhXAbaptcvJE9TYAnbw18hGCxJV/ZZWbJVG1SjWoHpD9rltGAbMj0Rq?=
 =?us-ascii?Q?sP4769NvYsoW1/N4WqzxEVTTlEt7ITh0jqHO0KZgBP2JWZEAykeNUSeWGK32?=
 =?us-ascii?Q?BN0CyRHD/uCKb6gWlZSDfs6EyKjwpkprl+4yhb9RCL1QeQ4iLuJye8Bz0GMs?=
 =?us-ascii?Q?nRpbVwjpn8mU/HIeJoZC3jYIc8UaReKYgQMDE3paqB4ps/568gSPQSH1ZoA7?=
 =?us-ascii?Q?qmHfIx/KKlcZ8/q8p9goGyIl4X8w2xpieoTgdbb9KKAXSo6NotcvPTfdVoB7?=
 =?us-ascii?Q?icvPGOMHeM++Xd7e/f/J23dAS8EgOFT3pF1y3jKgI9v2PD8OT9GPnyqWs6vy?=
 =?us-ascii?Q?YmsQ0H6IXVX/zTwpBT2FNsZI+hVh76S6zUF+LRcC8gEM5NZFBzgOO6KaLLbu?=
 =?us-ascii?Q?dBpj8c+jObcCHdGulnveeAXafkmJNBX4QFLGaVy73+yzY4CI9ouPDGkQqVu8?=
 =?us-ascii?Q?+VtX3ZSjKZVpLbL/d+7ifjhFpak4ULpZ75GGQp+Oyv69yu8z4ucsXSxgB8o4?=
 =?us-ascii?Q?3MM6DO/QvS+HtJzBUud9jP3+IW0pZbUTRBjpjxXX/b1ZhmAAkRlIHW31O6pO?=
 =?us-ascii?Q?2esFfNKTwSdf9dmp1XnRPIyrloIIy4MxR+kwvBdRk3PZiKeab2PlJ9wcPull?=
 =?us-ascii?Q?JtAvxo+vvcs0wRIBjtgemg+J1UhMOTvqnVerFv0cBcQk6exarzen8vD6tep3?=
 =?us-ascii?Q?zD41g7lKvoFZ51MWMnIYpqUxYWnQ4yvmTpOXZhR8uTpGbPN0/Li8CNvPPMis?=
 =?us-ascii?Q?jj3X9A/2yjs7rFwd8+TBfE0X7TOAK7OvkOe4cTdNjv1DvnZK1Wes/7u4dZ2W?=
 =?us-ascii?Q?7GzrzoOUE+CJvKRbZAbygue2Jrn/oKNp+Lr9J7xegpqu2ywoSNdc+bIrlE/E?=
 =?us-ascii?Q?Whm/4sVGIY7KJUfEQJIBtuP3fDrZGrraulmpYsr3UKtGVX1Gzn/4e2EY3czJ?=
X-MS-Exchange-AntiSpam-MessageData-1: prTa0iDHM9ttrg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb41be05-bfb8-474d-c9b8-08de8c317a91
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:47.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcYsOYtLVsXbDvz4DtcQNY3yiSq9RyVmBD0bJYXhYUGhDfQDF423McsXzG5F6rNfyVDIu53r56aTCJuka7TevQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7272-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 80F7E349736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v2->v6: none
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


