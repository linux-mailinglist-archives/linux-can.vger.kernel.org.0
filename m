Return-Path: <linux-can+bounces-7047-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGmhFisdr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7047-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:19:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8723F9CE
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D91FC309F1E6
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F79428859;
	Mon,  9 Mar 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCuGLTIW"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE163EF0B4;
	Mon,  9 Mar 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083412; cv=fail; b=PFmoK/BCavtp8jJ3I/O3YqCo1cirWn2BfHaua4ev1G5JGr31e2AHc59z3pWwHO7XAdqOcmBZCyfaMTWCY7lXAlOSJmvGLPfRU39wsR7Gs6J6eZMkxHAugvNdpAAr8GXMQHWUvZSqSGxw+C4C9i0G+OW6YBGNfswC4t5wHUdgBNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083412; c=relaxed/simple;
	bh=ZNAYm3dPJ7mXOubOE2ZBvqWsDiphCEEnmj/9pAuqx00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xfk9dilKdNMj6DmlrkAS8oX06bYT8Pg/CXglAdvXxk/yDbPDMMxpXJCO9sg1Awc5eKIEpkMxu7fvGIE7v67JLf3pFDNuQpgPZcPnhf3NXxpuSWXpTudmBza/mj+Kn5xqmByl/dREUY6XHYpY1Q0yKVn6Gkj+YoI1AD5ImFNm2Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HCuGLTIW; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKuyWLXjOEGs/W72n+0EhybKKHIvO+pBaJf+XhW3MpM2wRs86GwE5R7/l4U97Lvf6yJBmwyaOPWdnt8mdn/9Wia/VHoKBGHMhpjEnNKLBPKFXWJV5EC+rSV5PD5P/SZzGkCUBTf09mFnJAWpW3KqY6dtDGYtq5XZlMwqTv+xaVG47Df45wPJeL0BT13iqMHiLcqqJrxPXhTxgCbzTwWnMURcomcMpJRMLOPOu30ywJr+w0+RrtRqVrzh9yEZVAvmDLqxU6oUHsz/JpTvJDaueHacqAT5ecZQcZkERKGZL4HaUWW0IVjsHxOEBXH2WptS/D9NWewEMQJkU4BMigy63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28uxp1Wh00I44y4rI/dsfnxbRu+Lq1YoXYURzVaEAmw=;
 b=PX21nzy/ALmAeMh9WPV3TeHrzlGBRmwTJCiwpeTJVbMw0eze5sCTV2BE80dDT7OBRZG5OMOmzsOYe8Ph3dIylgXUufU1RdjfQCdLAm/q5xGf/Yl/LdHpyQTUuORfEl3hOZu8tf0vtIzUlzBg56an55aQwV7c+psrSCeRH9yYtc12EIYfGKwZDv216eW7wupPaagQWg5p1CaRr/PQZTEcls9AK4k2mYW+gLadejDw18CihP0dM42sq9QtFEawFxBPceRnTpOBJXpoOag8ejfHtBnOVpSgb+xjY31T6YZpL06liTk6mWVnBks2ks4a/YZOn6H+unxxuXkQPVKueVIxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28uxp1Wh00I44y4rI/dsfnxbRu+Lq1YoXYURzVaEAmw=;
 b=HCuGLTIWq/mns3I62OiQG+A5ojxKnQ/NBDcFO7gJkwX58m/YqurEfcGZAvvELD1YDBHZe4bf5pyy8WM5z2jRvyaGA3W3t5KjsWeNiAH113eYbOwW+j+z9jPY+N8WjFy7XcPJ7p2FohvFcHW2YohcpMTcIIiIuYY6CPc8pIz0hexDjc+itCRj0ugq409Am6VYaAVhNrH5JoLhL4iIGvZcF8aOOcZvCqLyV7QT9HnDvGjobJKzu6N1uq8a9BvSe1JhqnaoGdWBicJYRIXEX21K3LMDQ03TtkE7mCl9mPirATICiviaG3Y8oA06gv8S5VOcxBIOKPqi+5PvJSB5QGeRdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB9841.eurprd04.prod.outlook.com (2603:10a6:10:4ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:10:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:10:07 +0000
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
Subject: [PATCH v3 phy-next 18/24] net: renesas: rswitch: include PHY provider header
Date: Mon,  9 Mar 2026 21:08:36 +0200
Message-ID: <20260309190842.927634-19-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB9841:EE_
X-MS-Office365-Filtering-Correlation-Id: 9668efa3-6d4b-403d-39ca-08de7e0f7a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	b2DWN92El5ANmujQ1kC/wGfpipRPLKO1lfrntVXeAqh0X6h4yGVKq7y9MRc4d/O4942TPbbFV8LXvnNoPVx7xyeu8QM1Z4RhH0ztUhqPT5bEdLGuOTVM9WSbovQ4F7GWO3ZhO6yjg8AC/OsK1AZceefCBQX3nMxt0EfA1KytSiFKRllA8C4sabia3eeNAiAlAFoAbT4WmEoQLdLIEOkA8vd4OS831/KcPjY17h6Ya9lDlfBm7aZqd/liootFSaWHZowxoJKknJZpYIk1r7ShRVUUG2qTvglwv3oUxzW8s0Q6bjvMDoeT8btHXJxwG7m0dlrryirAdKiqhi3rC7pLjcDTWEZCCdvlsmS7/5nH/L3f5z0YefOMXRql0XnopFh8B+wwAMHPvFGwqzv3bM81QO4CXMvAJ2yusUfgz423fKmwzi8p6b4iUHbMACitiuUlRzZ0vlyNVo4bkA5mI6C3l+rW2xYSV9UqoDGT4Tg8+6kJXp6qlFPe9h2h9psteZ6GBtMb3Pz+aII+GE+QR07e3vxi6KCQzLPcXA/edNJnJ0yr7j5zRttXVrzW8NAcNnJ8kkfllRIiF9TdE4df/QGfVLLMEg3bCQbaN3BOCP4cHKsQ1jgfXSkRl3xM6Otct3STXecwOEeSrdwcSXMBQZ88p32uHWAZsunnu+QRbXfoXsrS24M9gZr7mEZ2rxkl4n2uISbwR3Mfh03FoW9yr3VdJALZKVTitf+L6iMW7xmaklo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqbG12lAnL1EydrLpqgxLGA9h92hZ5iGissjJ8T3sSOdfRYUnQIFUCfug6/7?=
 =?us-ascii?Q?JbpTnvn+mbJQzHMi8N2DQOfNtuR+EVSjO2AHjz2uj0Vt2Iuyjhrk7KAgufPA?=
 =?us-ascii?Q?1R8bvq7gpe4LCRkPoyKc+jaqIKWDzkVR5JjJDo5geyai/iiyB+HBvnQCfzf/?=
 =?us-ascii?Q?5k3j7GhnJ7IzG9/omZfTNR921izKcwVkNchnAEQqu96himYQxhO9nAKpZvg+?=
 =?us-ascii?Q?8HLiwTJiWBeXQfilGNsS5hBwC30N5qVuD3M6cWaN+r1UUVN859dxvl7xHLkL?=
 =?us-ascii?Q?dn+2navFqEZQBcXvj0Xv7u8x2iJYGA/am9HF3/4xUFIhaj2XLvl9tvFj5XIb?=
 =?us-ascii?Q?A0A2mPPVsl2S4UsHfOHLeUJl9HJActqyh+XtPmOA6mqT4McawwOm2h/1xhIf?=
 =?us-ascii?Q?ooqXXeIGh73W1aTtHBX1bbWmOtLC6onS1F4Bx4FsLyuNWo6V+DJZGBn9SVRn?=
 =?us-ascii?Q?YygIKpmf31PRcM0pEtS39DpUNbIUcvYKdb1me0u4iYKaLbs59yg9AQvGwrKm?=
 =?us-ascii?Q?JgK/F7T/vRTLLHtbXfNSpvazaBRniDwL7GnCjsm/jT746hFp86ygl55Gogoc?=
 =?us-ascii?Q?3zUaGxYXw7FIS6IOHxcZ0dmPJLxamvtEnwrdvOcUZlyah+VwEEMH2YFDTyI6?=
 =?us-ascii?Q?ekM4bpnc6ucILJ2XKqQc9yJn1XpaXkXWer9xxQetkogxKKbfZzC+pEj4XFMV?=
 =?us-ascii?Q?IgTFZmrTNDM7ov8kI37JWZdPNgtJcXkVYDl0ObLQ6BqsrLN15ijvRhQNrdof?=
 =?us-ascii?Q?JkMdxv11PiKPUIGoQPvfJSpvUzJuC3jnP8inh1QBFNDBEFkoqs5EODq5Sj7j?=
 =?us-ascii?Q?tReeim003aguDQQin14zRk40iBkIcjaOPxoTLzR+LT05LI24+GxXhyrzc2Zk?=
 =?us-ascii?Q?cNaJ+K2RRTpm1ReQrWNP9i0XODsuPfFFYpbn/nNz8wtekL1mNwDxNXhGbGa6?=
 =?us-ascii?Q?TSDHF5Rs7Vqc2DCGO/tKVj9bWI71AQwM3Qrt6XQ3PTdwXfHseISY8CHTM6iL?=
 =?us-ascii?Q?nHlmHcG0xPYvxjK+yhErLkfsGfIlvsx2ypp6jg0rWvicPLZMweATagr4Evey?=
 =?us-ascii?Q?jzlftpa3E8/lqkHH4MUQK99MlQ0IzyKlo2fPAeojZpJ/REcwOrz8byURTWjW?=
 =?us-ascii?Q?2B8cVkWD3iTdBVFD5qcLvqsUyHOtuYYgSpE4LAdRASGKuEzZInuSMvo/C1G/?=
 =?us-ascii?Q?FtSDflpWIKsrnlzxVR0ZREdUzi2sTgbITNVtzBGyQeDRBqA7842L/QSTMeFh?=
 =?us-ascii?Q?P6XvgeIxmyQp4XKd7ixdAo8sVMFmTCf1Y/X0UPNoyAf/VeaDPFUYXgx2wS/K?=
 =?us-ascii?Q?B/oWD4olxnC0tOC7MP6HjXr+cre5I/puYHJeeIA6mtU02mcTuVGA2ewhlf+E?=
 =?us-ascii?Q?BKEdd6ZWwcHLXUcBmBS3n2VgHlMWVhS8YCtgxzNOKAZ8TCsOdQFexOnlTRE0?=
 =?us-ascii?Q?jY2vK9oK/axGnKBqEwg+rCiQkrnbLF0wBbUzkrYRHewPxau620z6LR2eIIK5?=
 =?us-ascii?Q?J2urh+HDVqphKcrr3DDtCozmClRe3cAwUO7OASypRkAyiyQn6sotntgj6LO8?=
 =?us-ascii?Q?Iiwx8wsWaDSyXQnLtuIGpIUkGpxAsj45VVQkPElLRNhzEBeP7GITAgWzAp0B?=
 =?us-ascii?Q?Blrf0RCaPkStCTExv9y5ePy4ctV5zQomPNAJOeYbGTLMIuA7+LD+McUgD04X?=
 =?us-ascii?Q?LAVJr0h5ITePrX5q5uh7sVGzEd/L0OtwdvEfcTwfM9dIr0UtkhAXYqFsGiVz?=
 =?us-ascii?Q?c4gW6YbDnRddLETljU3kSeu0rWyCiGvKroqVgylOnO1S3RHD6w1WmQQYdWsx?=
X-MS-Exchange-AntiSpam-MessageData-1: XiaiYvkFVFlSIAVpxeu1DJIFSNfboZMiCNk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9668efa3-6d4b-403d-39ca-08de7e0f7a12
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:10:07.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q72Lwj0Pi6OnkKOPlVD6/3TNjiL6wslOVQZI8bbKGHNFgi6MeiA+56kqtzHaBtYmlW11SgUbP0SpNjY4mu259Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9841
X-Rspamd-Queue-Id: 1AB8723F9CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7047-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas,netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,armlinux.org.uk:email,davemloft.net:email,glider.be:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid,renesas.com:email]
X-Rspamd-Action: no action

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

v2->v3: none
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


