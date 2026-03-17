Return-Path: <linux-can+bounces-7113-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKLlLc3euWnNOwIAu9opvQ
	(envelope-from <linux-can+bounces-7113-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C452B3A4C
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 00:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B679303BA14
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 23:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34D43FBEBC;
	Tue, 17 Mar 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SENM9U9w"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281243F99C6;
	Tue, 17 Mar 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788755; cv=fail; b=Pa5ZyvkhZs0/fw3HjXD5hsm+UuTNnpMCQ1Zb5uSTtXWoboWE74X2Ul2z7QG7YJG8QJk6+AD/0erQyVd/RGPOJFoQdy6nFTvwROk6RqbbAhNfKJH9TDpjqfBwwX31D/PhDuGaEewzPasxu2BL9BtHINRFk0I297nbmouDOkBRqNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788755; c=relaxed/simple;
	bh=q+PxRLOLqHtXHAjfvVDL9Y8kLYm6cHOt3gcQ1ibwEqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdayzY8rDUpQxBzRnv387UNcFqCXtExUAqIif6XA2yiHs4xJiBBTcFwyUT6LTYzgF0z56a6TRd/ZYNXyAXz2hmDxFF03Qj7YbsxMVswaAQvBH3Sv9KX9Jyb3MOQGJIN+Ox9mJZIKn5MKwiku4lECiNusAEeWlSTmn6hcuFQ8pu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SENM9U9w; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWO8l+eZpoHDuEiuCcxwrsry/MLx0wLPF7Sq4nQJ6SMEFxYQz0H+18zo3FY4mRoWTZCrpdhAbJVfFNT90+jT6plkbwCJmNux5xOlBBx3jOeYH4c7ke61oITJc0inZDNSSfo/tY1LcNWexcTzlt08wWqnb27hTnlE6niD7R7wLrv34ncCSEhYzpvO3nkyS/BpneIAYjwtxCMX37vNsDZ4DBrkurbwy2LYTOu/SOC5g/YpE0xueP9rTz1qHWkbHwLc7UrRiOXiPSQJAEzYujJ7kqAHbo79OfYm9nDvx7euPCa3D81b43oZwmQLCAQU6gQ4bowFDfYuCKuvJUDmw9802A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU2NyuJVLVhm6ddp77+YeTU53AYwE8f7Nv2x3g4J45M=;
 b=QqpPagzBRsWWrT1kXnsZrohSglpOEFgBh8Ghf5V8ey7kviccG3c1yBWvYQHafNrkqkRbhpc4BpZgOoiRFKgbqBd1HD3GvtgPbZRcXT5ut1qfmyZOj6KYLt1YpOuaOfuZob7xCGspLfy+0yZZ75p0h4/rTYPcjcgWAsg/N47xJjRr1e2xSsJaDxGlHoira6i3gakWJi3E6uegLh3k4rymqlWBpKYglNuPyjfJvJHkCscg/6CLiS/jYEuoKGTv32DXWfLPh/sAEJ7Ixh+nD3JgQMqpBhqS4G4a2tzBUa1gmtgxu3ChlF+J4GBqQOaVQGQhOqrDqerMxNH+IVpBh4bHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU2NyuJVLVhm6ddp77+YeTU53AYwE8f7Nv2x3g4J45M=;
 b=SENM9U9wm2MNfL5xihPdd3vgRXhcazT1ybg8IoHtHn1cByStfb8FFV0O3sWeX4VL+zz1KwEOKOU8f7s1pz438HBaPg28VlLDRz5y8hOQYWIN3WAg6EH1FkHwcUkgzVbEcNYhPIDVsWbrxpvhTHv1S8ugzVUbnGy8eedqdy8+pIOZXPEbSyo/sP1RWu/n9zm96PrDfjuXDhO6pVFHbcBa+fymfUR5JEkhZvsfbxKZGMqdBwhzF9Lxuj+ni3tAXkiPjA+c2TsZrUMaIqTea97a2fOzRAJgh2oyv1cIhrGxbrjF0gtYzQ2u7CZjgr/8yqaWvpTt2IfOcvkcH7Q28Fjm6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBBPR04MB7643.eurprd04.prod.outlook.com (2603:10a6:10:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 23:05:39 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 23:05:39 +0000
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
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andy Yan <andy.yan@rock-chips.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 phy-next 14/24] phy: introduce phy_get_max_link_rate() helper for consumers
Date: Wed, 18 Mar 2026 01:04:50 +0200
Message-ID: <20260317230500.2056077-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
References: <20260317230500.2056077-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBBPR04MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8ab2d2-f826-4e09-3228-08de8479b4ca
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 /6qX6FdySg80Y7C5YMU9HHskuh4WHpyCMAIRI2QC9xXtC0w/4mYP+p6aCJQPZbCYzwCq30UKYNBjhMMAScp6lZhHrW4hY7tiRGJM+gz2mqZbrC0cUZ8NQklmP/fAF4f8EHwvniEbmbi47+DhIib16H43aFVAx+4Optywyk7UDFGxW4keghjx6K4v14CAkYDQ7N+E8vKv8vHpHt/06NXW089fvo7ZRjdh8qS78cJ4uwdQIIi5By5JSkB15RuVvbV9ONHzbubpN6oYJ6TNTMbVWmSAoWO/H1OD5cbKm4NSVsa9mYdgVH4/jMtNZHUsyyGPM58dBI6Iiqed60bgrXzpuyfqeJp2gr+FhjI8fM1+E/wd3nxjgqC+bKaZ6efieXS8aGBDBm6nl1ZtELmfOSNeln1/ndbYUozEA1ald3JIoC2B7vFKhA6oyoRYfd7IdkN7Ay/XAnVRvk2B8zd2SQQ8NA1bum9MfzwHq6K0FyocPykEBFaTMwkI8Y7A5ojYoO4vkeKah+KtKyZ3rxFH15Gl3u0KnDEV9FPutPwSFU+LhggYWkiQMpB/JA5c9+Yyuh9KnUJHDfc05gc4aBGM8PGPS76rNnTaWi6d7JJ5cBjNZOxf6IoU1ncljMu/1ebcXI3MilLEAoRaVs0yBNcjoIS1yJ0QWvsDchgc4OXATVAdunLZHneYG22Qt0XYQ1t/2I2Qe1aHc2k2yN4YgnSFpjx6Xa1/JzMkBh2/HWadhKBrP5g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?1/hALWfwwv9R1aYbpq0x4i5h+apHi8UH4NIyr7n7FEudn6qIO2CNbQsNIFXo?=
 =?us-ascii?Q?G2y7bLXmfv2/xPqeNnO+XNlfIlMLIcwULCrgAs5lggBXg6vCuUMnZo331N9m?=
 =?us-ascii?Q?9Pk+nLQTEi6Bdohx4XfxDxgTWN0TB1i6PykdNI9vS1B/emNTukvd2m5egLFE?=
 =?us-ascii?Q?a0nYPwqllZlslNqWumuPNRwrzYpkyceBxi69KggbARaIBjHmkR9V/ZMR8AmU?=
 =?us-ascii?Q?r3y+KZaIx7CnfeFHRoDYAtmyB8pJNj0nge2NhI3DoG4lB7US/kTFwGld5V0Y?=
 =?us-ascii?Q?4g37Wy5zQYliUGKEwx8xL6W2orgtt2IRGBdVYgMEIncIZVz6ffjbKgrs88Zk?=
 =?us-ascii?Q?fH1gNsn6FpBTBKk5tip1j/JzCNRINgay/m4Ot/y6qXi2rA0lrtMKS/byk+EN?=
 =?us-ascii?Q?P9Ju2zUPvvq65kLRn+ZDobxLdrxk2TE5GibFww2FbcKhXE2mkS8Z3yC0zlxp?=
 =?us-ascii?Q?AvzuYN006b9SE9GHfPwshN4m7iozgr03hhQ5nkKeyE8Fl1Q4Jqb39hyiXhe8?=
 =?us-ascii?Q?KtI3xz4efAWirL0Pfk34xy3wZG7XqeMzvlrM11HMnSyWxFhNP/ysFrfc654v?=
 =?us-ascii?Q?Ik2bA9YOXk+2bTlDLi0OSG6jghqOY5brPs3KqA5ykovSL6283S/lXg+TxO39?=
 =?us-ascii?Q?x1syXQIbMuKwCCcWUD4Eof6uMRMrnk7sMPJCnf7YVAdcmtYYwAVA0HmslaWi?=
 =?us-ascii?Q?iK+BDp8spev3rWPP0e24Xc5lWHiJzJsnf7OCDFG2snqPPazuBb31Y/Lp7DJn?=
 =?us-ascii?Q?cPkOUhflkan1B312ku/wMH8I5zMNAJYAV51TcfYlegTwg8OEaIuR2350tItr?=
 =?us-ascii?Q?TQcGvsMuiflV/qr72Yx2jlSR/PHU9SxTFMXCVcLfPqHhBXWfjdTpejVK/iXC?=
 =?us-ascii?Q?8jk7AsGtHql/RQDl8++uxq+NZcdu8aKI9WOEFoFDjowMo98Reeub2XCKgXGp?=
 =?us-ascii?Q?UTJnkYO80wUvC3g8Lf3BOVkh6x1v0pBahaXBBMcyIzSr9X1ZB06fCv+QCOJm?=
 =?us-ascii?Q?j+3n0zp/H9q+cZFsG5zMW7c3IaSrkwicyXH16N0tiX2Bs0yi41OityrH50FJ?=
 =?us-ascii?Q?FG3USuWOU03wQlamHzI/AxvIZ4mzcBvVQbI0HyxA1D3haBtdgj3Iudb0hVrK?=
 =?us-ascii?Q?cdNuihOpB7ajwWuGoT0KN2E3jmh9oUa+yI/MdlwZyPmHl6XRxjBNbzZoF1YU?=
 =?us-ascii?Q?Qw0YdOgkK2C8+rLhmA0eTLXzxR9tuGuyWahDv8i09cuclwJ+aW2mEU4M3Dgc?=
 =?us-ascii?Q?KIwzMovR/mvkMVSPNgkVpDMR3uFvxPPN0hFEXwDiPjkTrRZ0eCFSvjdwn9lB?=
 =?us-ascii?Q?Ad43dVIq1jRGZrTuR20cBu01xPGOTIVQcvXKUaeSKadowy74r2kKWj/MrnJ9?=
 =?us-ascii?Q?G/a1ePYMbvAVissEF6mBJN45JfJsFroArtGs/E8ephR8pw4s0JFy5a93iv3H?=
 =?us-ascii?Q?kMqzBl2rmgazNGDx2yEp3BNlYkXD1FBo52UbZnplkqeAXCnoCw7G/lsy/IxZ?=
 =?us-ascii?Q?d3uATJwktOZUfdHK4MjNiRSLF1YowoiYoiyjqsDKUa01DTxXkFxTXeMXhLz5?=
 =?us-ascii?Q?GF247i+957XFT3CyvgBUiMxRgmWngM+UKLeZxEpuXwthmGSEaNcSQFRiQflt?=
 =?us-ascii?Q?KUtz3skla41djYngVuPnv9fbPRzJr8xeezig8Cy6ZjIhCoLHXXHBFyPNpyT/?=
 =?us-ascii?Q?YWbSUjVp2SB29p6eEM7HIGu6hokLHBAmsm6ZS1w2h6fWGssqJCBRcZNtnDIJ?=
 =?us-ascii?Q?vVZaCws3/zastWyb0A7ahU0e6ZLRKvOIMkzudFGh1Rob/rufn83lVBaD3qRy?=
X-MS-Exchange-AntiSpam-MessageData-1: YIYSVf722jBE2DwSjJ6G2c80fqSp8ANNmPw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8ab2d2-f826-4e09-3228-08de8479b4ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 23:05:39.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE0UtoWagqTIF0oSOc6ArQUKvnHSDHLuwE92r4aVBU7IF6D0aNR8fNkqfS5dnx2QrXDUaGK+PcY8ioeQ8Hpz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7643
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,baylibre.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev,glider.be];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7113-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95C452B3A4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consumer drivers shouldn't dereference struct phy, not even to get to
its attributes.

We have phy_get_bus_width() as a precedent for getting the bus_width
attribute, so let's add phy_get_max_link_rate() and use it in DRM and
CAN drivers.

In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
and NULL is given by the API as a non-error case, so the PHY API should
also tolerate NULL coming back to it. This means we can further simplify
the call sites that test for the NULL quality of the transceiver.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>

v3->v4: none
v2->v3: collect tag
v1->v2: make phy_get_bus_width() NULL-tolerant to simplify CAN callers
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
 drivers/gpu/drm/bridge/synopsys/dw-dp.c             | 2 +-
 drivers/net/can/at91_can.c                          | 3 +--
 drivers/net/can/flexcan/flexcan-core.c              | 3 +--
 drivers/net/can/m_can/m_can_platform.c              | 3 +--
 drivers/net/can/rcar/rcar_canfd.c                   | 3 +--
 drivers/phy/phy-core.c                              | 9 +++++++++
 include/linux/phy/phy.h                             | 6 ++++++
 8 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index a8b6ae58cb0a..ed7ed82ddb64 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1300,7 +1300,7 @@ static u32 cdns_mhdp_get_training_interval_us(struct cdns_mhdp_device *mhdp,
 
 static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 {
-	unsigned int link_rate;
+	u32 link_rate;
 
 	/* Get source capabilities based on PHY attributes */
 
@@ -1308,7 +1308,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-	link_rate = mhdp->phy->attrs.max_link_rate;
+	link_rate = phy_get_max_link_rate(mhdp->phy);
 	if (!link_rate)
 		link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_8_1);
 	else
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 4ab6922dd79c..79c72ee8e263 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -536,7 +536,7 @@ static int dw_dp_link_parse(struct dw_dp *dp, struct drm_connector *connector)
 
 	link->revision = link->dpcd[DP_DPCD_REV];
 	link->rate = min_t(u32, min(dp->plat_data.max_link_rate,
-				    dp->phy->attrs.max_link_rate * 100),
+				    phy_get_max_link_rate(dp->phy) * 100),
 			   drm_dp_max_link_rate(link->dpcd));
 	link->lanes = min_t(u8, phy_get_bus_width(dp->phy),
 			    drm_dp_max_lane_count(link->dpcd));
diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..7749da0a58f6 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1125,8 +1125,7 @@ static int at91_can_probe(struct platform_device *pdev)
 
 	can_rx_offload_add_timestamp(dev, &priv->offload);
 
-	if (transceiver)
-		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+	priv->can.bitrate_max = phy_get_max_link_rate(transceiver);
 
 	if (at91_is_sam9263(priv))
 		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..093e48b8da58 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2210,8 +2210,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->reg_xceiver = reg_xceiver;
 	priv->transceiver = transceiver;
 
-	if (transceiver)
-		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+	priv->can.bitrate_max = phy_get_max_link_rate(transceiver);
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 56da411878af..2a0f163a683a 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -131,8 +131,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto probe_fail;
 	}
 
-	if (transceiver)
-		mcan_class->can.bitrate_max = transceiver->attrs.max_link_rate;
+	mcan_class->can.bitrate_max = phy_get_max_link_rate(transceiver);
 
 	priv->base = addr;
 	priv->mram_base = mram_addr;
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index eaf8cac78038..9062db48d477 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1884,8 +1884,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->transceiver = transceiver;
 	priv->channel = ch;
 	priv->gpriv = gpriv;
-	if (transceiver)
-		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
+	priv->can.bitrate_max = phy_get_max_link_rate(transceiver);
 	priv->can.clock.freq = fcan_freq;
 	dev_info(dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 0d0be494cfd7..737a760d97d1 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -647,6 +647,15 @@ void phy_set_bus_width(struct phy *phy, int bus_width)
 }
 EXPORT_SYMBOL_GPL(phy_set_bus_width);
 
+u32 phy_get_max_link_rate(struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	return phy->attrs.max_link_rate;
+}
+EXPORT_SYMBOL_GPL(phy_get_max_link_rate);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index a7e2432ca1ae..34b656084caf 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
 int phy_notify_state(struct phy *phy, union phy_notify state);
 int phy_get_bus_width(struct phy *phy);
 void phy_set_bus_width(struct phy *phy, int bus_width);
+u32 phy_get_max_link_rate(struct phy *phy);
 #else
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
@@ -256,6 +257,11 @@ static inline int phy_get_bus_width(struct phy *phy)
 static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 }
+
+static inline u32 phy_get_max_link_rate(struct phy *phy)
+{
+	return 0;
+}
 #endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
 
 #endif /* __PHY_CONSUMER_H */
-- 
2.43.0


