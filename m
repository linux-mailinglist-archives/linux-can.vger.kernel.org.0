Return-Path: <linux-can+bounces-7508-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GV4DLrE+Wn2DgMAu9opvQ
	(envelope-from <linux-can+bounces-7508-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:21:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B244CB01B
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C4131E3736
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378243C05E;
	Tue,  5 May 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKPL9rrg"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7036426D1D;
	Tue,  5 May 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975591; cv=fail; b=pMwfvq0cggnHWzor/YgK2xZwDY/EXl05urKhZt4pEegablVkonCvKEUuSmOF10pm/10qN/Tjp0t9+Fwham/Gi3j3WcmnNaJ9dTSpaA+xUyykME90pw51bm2XUfw+f3LqN6gkP0lLZ2Gq9jOVmZTV8wUQXOjPp2UkvhjJGAgq4Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975591; c=relaxed/simple;
	bh=iJsB9TtB16FHCo3JJ114/4lcKrgNtiUvsaCEB4w+2Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Scd1iJaYs8p+hAvVZ10nTDVaSCS2VM7iTtVyiuWjjvusIB4d4MjlruT+9eej7EsCmWObjSPHJGhrsTEF/jrLuI5FP7tEuTbM6n6n6KzThKAYk/Sa0exeKb8+mHmWNyv3BEwsm2qr55B5hGmPLJhyFcnZAiXGJQAD/6kuSZRkWB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IKPL9rrg; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiqI4KQQqL2Up1v6PwzVqifqZVX0zjLonSbONAgKowxjKsvWwYjAElQw7qUkQ1x/6RR8C+9qtLbdfoT1Oi+y1wA9sg5Zlxs2KAMonz0HFqdcsfscftBkq+iS65Eo5Jb71gyP5MVGHx9tcEwAFfOJUG9b7auERNbCqUTPfTZKLJ7HHmQGsJoPfBN8TS28SfbAiz3GW5C+oUXEF7NOfi4g7Qb+HfVdeq0Gy9nN4MUi9fqybdGHDk9xh1nUR/ZeRC3NU2pw23w0/34+YS8M77Vo7HANEJ1YoIPF9PbH/2J//DJ9pBQhQ+g7iKE50/ML87YVHF2+HHtRPclKLRClZZFRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5sRDgO8/76/s9f9by6DOCDUOB2Ib1AVjGCXp6EGedg=;
 b=HT29hBh95S+l52xf7tTnDpocPpmRAQNtGXtIVHXeGj/hOm9rAHGFPYYmePHCf65xEmw3knbgcDp6ewJPlwAsILFIOEFj58FgvAUuJRMO78fNxYVLhliNpVbhjNy97F6LzDm5qJxkujGS3q6qLGUb+LnUJXimoUcL+oupdkT5CGQLMYXG5XR1ZYNfN5hZzezkXo3rK630kxwdAAeARQcyCBKsXbQ4VhykfEGXPV8h/CyZdpehsEBO6xWu3B7eemYv+LCe1Y/dfBhIeH/3swmmeB2ZUuUeSRtFHxZlyUJbXU39LQYHPHhBtNtTnm0kCr+NvdMXjqF9W/VujoAtdUqE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5sRDgO8/76/s9f9by6DOCDUOB2Ib1AVjGCXp6EGedg=;
 b=IKPL9rrg7Da9qOLxBykiXKAqnpsStY34RG9pqVopsJ4S8EvWOB5oaRxCPlx1Ap+o/TQiUebQeqPbfPG//J/3LAbnukIww+CK7+uKrapJC4a1no8GFGz3f1J+J3G5tBWOHtCSqo4bh6l88GCQIc/fsErBYflaOzlIQnoOEV7tThn9xCCvlI5Xeib9SI/yFTEqEtpL+4cyO9irGvonV0REIlKjTEIx+AfLGGOOHh49G9dodswqkvOzGD5ZBhw+wIHk4pQTs3BULl48p/EU/bGIh78iZrlqbGkvtlb8tcGkShT7pYgTyO77Xfehzjisg6CGEgXs/uYXAzXZXoNY5qlDDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8363.eurprd04.prod.outlook.com (2603:10a6:10:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 10:06:22 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:06:20 +0000
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
	Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v8 phy-next 20/31] phy: introduce phy_get_max_link_rate() helper for consumers
Date: Tue,  5 May 2026 13:05:12 +0300
Message-Id: <20260505100523.1922388-21-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 34320779-b733-4992-3422-08deaa8df4c7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 PkXF2EQTzA1R7BkWyOAdNdkouP2SKDUJ9Eg2lSmw1pFJI3HWyJvN/zitXAgRpSUSwGnYkExo3mdvuOeeDmGjfbGuyZ7elqeiX0+Ox3A7QCSx0Zo9RIK707YeI5hS/8vlrrbr421AdAklytiP/KFxnNU2lPLsSIwt5DQznFVDLulTUplRxIU4KnsxzrG0tjrVk1mhrpCebnrhuXaUeDx5jFqfkYzUEJRW5I0Jcyb+VoSPKGhRXITioEaKNzvhQK3nBMISA2VXYXi3aWucRCJQPwe2AhlB2q+jr5mOXn9I4B9NoeBOkb2DkQp3o4a1eb8fgvizgPor+zvlQ/a5zO8V3mcxK6Zlc2srDEw0PZl/oaTIYstlid0EP1bWS4fAs9ceiU4d399V2Ibv/i5j1Nsl8JSUwP2RUXv6u8C+itXXIHeaO65dVBI0yc+6Y46FDjx4itNmb7Sjj6VlhXTEO3qGQY4I1/NyD0C6HozHkkVcYB+qoJ3DovqkrsgP4484n2gQ9mY5jLQ/MiMMJrgB1eMvg1OGRbkgt8idsat+GpfbQgAJcIHDHradtQRK5Iyx+z0R6YKRMvq3l3V3rCJ0/za7XMa7+/KZ8cl6lBG1QBtkwZNERqum4Kk2+bAy/59wBP6hvo+OtWEFIloF2HIDV/JnYYxxMWkRUpwSzp/GWyV8KYQNpk6GQDDhx20kjaLggJv5
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(7416014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?heKNdp91rcxSmoOzFldFXT16Y2C1VgElaqNvGb+cJ6+61JzGKujrTm94k8hP?=
 =?us-ascii?Q?PqWVQj0rL2Koxs6PMDiM5opCtiiI22ukeJ89KU2CNyFpU/9R/0QkxCTASdnG?=
 =?us-ascii?Q?3wDhzkdTBkljMRFlxoyVUlybN/VAe5utNPBFbhnheqY2wqvEdMHk7JronA24?=
 =?us-ascii?Q?hU07m3eJ8/9m/FvOR6jNWqjZTKQ2k/J+SRMA/+FAWY1ITzDmQ9UfoAqPy/Hp?=
 =?us-ascii?Q?cpTfjU3mEBNGoxwYWGAZ7nn54Ji5wTqygz8vmG4KZxogfOjgQDlPbFUTPfrV?=
 =?us-ascii?Q?iZJnLN/HetsZT0uujaU1JvCCYw1n3f4dBBM4cWACLhgNOXv/2bgFXsYBfen2?=
 =?us-ascii?Q?TrWJA/3a0jFi2BfSGeHC5+tW+PuBno9PRYeOH1O5Azm4BkXqFstA0D9yhVtR?=
 =?us-ascii?Q?OQhje37Y47YMxFvoJIfwjKEXDizS1EeDo26in/zOl2ZxOa4TrrhIOxiTVwa1?=
 =?us-ascii?Q?0JBIbAHRIISX1yeC0xNW11PqBz5h2zLagHw/iy7hQVopsjIsLD0UAeNWH3aT?=
 =?us-ascii?Q?HZxCVKgRU1IxVIGU+5lUn5FUlZtlow0i2v1pz7OLte1QojiPg6DPFMZsDA4O?=
 =?us-ascii?Q?pc6jaucDXazAhnhDwHfKTZcKG24LK5C5yFrSygPPj3zt1O3NiJEjYmwwDbn8?=
 =?us-ascii?Q?l5Dlef39CB+ChPsFNUIB4EXRKMioS5c3kIYL9q4BbDgdvoAWHx2eOtR9tBo2?=
 =?us-ascii?Q?6oL8+ctMwkzEbwMb9N7HBO2GTtNVSPtBAI/SdFTc8b0l2SXqHHndZoyecEmx?=
 =?us-ascii?Q?KMc643p9D85/nHfG/OYdLq2fr4NeX6qZuKTr+ufd7cFMAqasNJK9XXnaCrbu?=
 =?us-ascii?Q?HCPd8eF2tenS6n0AjLg6NYXnIqlmRlcIq0Bh/YwG5cwOIMf+Uo2h9z6bzEVj?=
 =?us-ascii?Q?hP0x7pXP/Cb4ta1jxkrl+oJd51DE9DTfqbOziBaAeLk1LI0AYk/j1dHPwMlt?=
 =?us-ascii?Q?nzpLzTj3GDVLD20Pp+iMtrj9JsmPDKSg0n21WT43wxhqSAm0qtMSsX7ssc2b?=
 =?us-ascii?Q?nsOE+epXRzFG09Y9ydvmQ7G0x37NQEyDPfIneMy4BKmmplf+wUBD7imRErY5?=
 =?us-ascii?Q?gIHjanlhO1NRJcGXokWt+TEO5ykpNaQ2SzWu+UODYA3F+DOZ9hzRJq7T0sPG?=
 =?us-ascii?Q?h44lB/q5jpNt5CXLbHr0c4vRIcao7yBml8tq3rc9AQ+QzxHGZPbq4UcbXeTT?=
 =?us-ascii?Q?I/1kc+YOUPRnKvsOQwdTlGC+mmYDl7RLEyYNELDWtuThqCcmRQMIhwkAugl/?=
 =?us-ascii?Q?O0GuR7EsJSlpijZOEnBJc8K8jH1hJMFQI/AD6nV44G6zV4mVLrdYgATZYA7p?=
 =?us-ascii?Q?B/u+dS+MJsNDRM6SGgsqzXpQqhPQPsvAS/zyrHNCk0MsUkNts/lEqv1UVc5y?=
 =?us-ascii?Q?rZ6ZxQNTGmUHWDK7Rhfz4sq6szMNdS6AvTtDZ1iC6JBSY2mPXi15gBNOZ++D?=
 =?us-ascii?Q?Gs49N4lGZReP/BHtiaiIha/HMDBrrGk9iCMR/uNJdu/Dne3JLaKqSTKGv7zR?=
 =?us-ascii?Q?xRjDR+sR+YVTcBsdPQf4lpHiJNxHcTvOXC1fH6B1CBzJdqbg5vqNqJuJiYIq?=
 =?us-ascii?Q?Bgx6g+nx9yXUl7zs/mZ4tcE5LpMeODs4IQuj8UFCUg6wY+DyYhVWAPiZk2zr?=
 =?us-ascii?Q?PTeuNXw6Qt6N1adexKB6eHHfp0E7G6OjEK1NaHv+S4/6Z+D1uDtYDQEH5K5r?=
 =?us-ascii?Q?rMhioTDZZqueK4NGn+0PJw8UBK/tpeEutBD1pRsMcKumRVmriHLDtl2a3+ZR?=
 =?us-ascii?Q?KQPBL47Vag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34320779-b733-4992-3422-08deaa8df4c7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:06:20.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lj6mTfmaJwTZD/kK1BNfcHCNpUjwzlz0/LaBzbDi5okPmGBjN9f1ruV1nezAPtokgaDRycUyE0Xv3YSEUPmuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8363
X-Rspamd-Queue-Id: D6B244CB01B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,baylibre.com,glider.be,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7508-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd
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

v7->v8: make "struct phy *" argument const
v3->v7: none
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
index d20c0f8ad04c..87847978c1fb 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1296,7 +1296,7 @@ static u32 cdns_mhdp_get_training_interval_us(struct cdns_mhdp_device *mhdp,
 
 static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 {
-	unsigned int link_rate;
+	u32 link_rate;
 
 	/* Get source capabilities based on PHY attributes */
 
@@ -1304,7 +1304,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-	link_rate = mhdp->phy->attrs.max_link_rate;
+	link_rate = phy_get_max_link_rate(mhdp->phy);
 	if (!link_rate)
 		link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_8_1);
 	else
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 45b37885d719..137ea6679732 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -530,7 +530,7 @@ static int dw_dp_link_parse(struct dw_dp *dp, struct drm_connector *connector)
 
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
index 6cd33204d2ff..8707111c4666 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -675,6 +675,15 @@ int phy_request_bus_width(struct phy *phy, int bus_width)
 }
 EXPORT_SYMBOL_GPL(phy_request_bus_width);
 
+u32 phy_get_max_link_rate(const struct phy *phy)
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
index 99d3d65da614..e65865b4acfe 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
 int phy_notify_state(struct phy *phy, union phy_notify state);
 int phy_get_bus_width(struct phy *phy);
 int phy_request_bus_width(struct phy *phy, int bus_width);
+u32 phy_get_max_link_rate(const struct phy *phy);
 #else
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
@@ -260,6 +261,11 @@ static inline int phy_request_bus_width(struct phy *phy, int bus_width)
 
 	return -ENOSYS;
 }
+
+static inline u32 phy_get_max_link_rate(const struct phy *phy)
+{
+	return 0;
+}
 #endif /* IS_ENABLED(CONFIG_GENERIC_PHY) */
 
 #endif /* __PHY_CONSUMER_H */
-- 
2.34.1


