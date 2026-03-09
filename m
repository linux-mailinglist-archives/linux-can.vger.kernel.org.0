Return-Path: <linux-can+bounces-7044-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGfLAxQcr2lzOAIAu9opvQ
	(envelope-from <linux-can+bounces-7044-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:14:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68623F6F5
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7282304466A
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68D1425CCD;
	Mon,  9 Mar 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ARJkC/2m"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44664219F3;
	Mon,  9 Mar 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083397; cv=fail; b=eofeihSoH6Kdb7sOfO4lZQQVQkN3Ft8lF/pSZFg1RHHr3k5kMCt/9OixykHfkpcG48dA8x3yeWtCJ3WfLY+BBSwOB+HP081gWvMfEmXYU4YHJ+gKhy1fUROXIcAGzE3TlZFyxZZHfAG5XbF/SRHRoTLSxxzNOkAzgSLd7zol8c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083397; c=relaxed/simple;
	bh=0xfNwKkpBBh75uzkyY6gD2Xq9/jHRT8JUZ0VKzevCIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZPOES1Zmz3xJamhqC9Z4KAiHcEu/gRdcRBMGgozfxGsk8lws+dNYKLGgSxUvFwvehF51ji5j2U1W9EVNYZxXcFEQmwGq3PZPGES1+Vl8BRev2J7g21isah9oJws5kyhiV0FP6/fYWMuXg8zZBWwkNROLq//UkxVSYGAdqw8f58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ARJkC/2m; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiodQ9B9TBg4Oez/2i8lpj9rJU5GgFlAd28T2iTyxIyT3BP8pHZHNDwKdiCMIxUsbsSwFFOM/ILTjlS06yKSrgJI+iW5yLOfVcm24G81+bhgc8GunmZ07blsnLlxPWSVOD0YU04jCfmDg4y7a8BzP1DXpUbeIWcVk1Ox4f1avxB59e9OqwwLkSGSyE2hFPl3KSs1Cx0f9nNd2x6Q3AoVxupO5wyIyJ0+CXWY5Pu1cFZGw6s4mHbhSytrJLoVgMf2zUG6AzqhY2kSPMD5XWar0ydJHP8ywzIsJ6X7gOOG8/J+u0qBsiJfsq9w7WX625+PoNxhQxujIgUM5S4R3htT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSm+ln8wI6ff9j7MMnnO5aDhiJEvtd+UMkkszWSFAwE=;
 b=XbQdZOHXjOzmuj7flFNiE7fcjJFchc7edtl7klLxtR8sQNoZhTtwp/EO+/Ct5o9cmxCb6hV4FVEDOtjNAkaIrTY/5+HDazDXTM1GbLujHRhrEosRo44kt2Iq69Jr9W+1+UZW2Fnh7Pdo80zFRjGMSj/QK2oVAKRAQrrrRXYEn4kN2mf3UsxGf8kY5nkXL4HGPwqAAa2JCdvkia6G6FqHXF34e0C1t1Anq8QV7tcdCLvGPuTFz7tKIPm/GTXnONd7um5GJzO7ia5wJ1ukNFsOKVhra+ndjheN/vzV5lBWhmjJ7XiULXXvrEVL/rjmvZLQCJjzv9fHm6wpecUe8RF6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSm+ln8wI6ff9j7MMnnO5aDhiJEvtd+UMkkszWSFAwE=;
 b=ARJkC/2mpTAfU/4LQRnPoGR57QqsBffCvfvNMYZHWi0omhe4opurdKZLxFELkMZcQvQXGODTSwdWTinwuEZzFy+YlIJFdcwcZizbHWuUehAvkyZSsr9efoPD+AJVSrraWZ53KidN8Mz5wlGvGtwV1CIqophYIDfx83UZMkWTWUza8mJ+eBDW8g0o/eMK67pHKmNzOqym820EanyHThYZWo3fQDxsd4/zcKdwwNosFcCWmF1fxAbUAet+55W8FYwuj8MaCpV0yBzEPI0NGGwgg6KqfPPPkj3ZiIW3xLJbBZMMuD/N1m7mJIYI7/HwrMNuvXBGW/dmVUH3kEkVEcK+6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:37 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:37 +0000
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
Subject: [PATCH v3 phy-next 14/24] phy: introduce phy_get_max_link_rate() helper for consumers
Date: Mon,  9 Mar 2026 21:08:32 +0200
Message-ID: <20260309190842.927634-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::40) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 793a5f7b-41aa-4404-3190-08de7e0f683e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 mSSeV3XGo95PbzuiiQiLUwMD4pSFIq113B7HPj4TU4FJWZ6owGV+GHcLmsjIXDK08RogP2aoAzqVerzqAt5dp52NhW6/FKAURyQka6alt0bZ8dPbTthLKl/BsPfnnOOoHLGcF9lNjeZ6w1d2p5Q25bWSm1gs8KFmYGKCHfHq4OZt8qzOR61E5bVac1CjbNAVjcKYGahFmLaWoQBFe23ivJ4WOWxMi771MmkwzzwAjy1B2yMb/zpG9+dJLV8FeoSkOkbH8qjM/VamA1+t8marLuitmioCtd49oxkvQScfRHGpl8hYpHyjEnK3l1RdE96kQY1d2U0hq+uBQFpOTiGE2PwNVKDJioiGK5DWaf65MuCqW27gWY3eOVu/WFGfxf9e0ptkqqHAQKKstZxrsfZqi0SSOk3/LQZyvBp7JileW5ibTfH85Jjk+Jo7GK7oiFj6hCaevzSIc8zVyyFSLTQaTgajGh1qPZXdgP+J/1WI79WH4+32Hq/04uwr5pR0K9sSehZH07tsrZIBadD8hvbwict7w2v0oag+D4IH9cbPderFutkykLXPikofxoY3IKwAXIC7RntIf307YCtdACLAV0sigmZmQ867uIYz/nKEk/8yNfVpJjTySCiNoFNE+cSwUfcg6QJ6sS8rzofgS7IhCi4uu3SKush1mKS0ETPe8qInyMd5sEmrH8+3fiE5npVx+jBjxZhzsmTHWyCSnAXdDSExY/fEblZ3CtS+J4LQRCE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Wfpl9OytQoz53i6/DYP1nCKkaWq5xJCEFgKPtLt6f3HORlCubovEJ+Q2CuK4?=
 =?us-ascii?Q?fQi0kRizAGDD0uTs8xj0HegW3cGNoHxqFZOuC56oMRu7Vt2fSz4t6HDy64iB?=
 =?us-ascii?Q?OlswfHAdTlmdrOI9HZa0e1WqMPPB9xBXI/69m4MkSBqyBOz1qMGCBfNm8IvO?=
 =?us-ascii?Q?ojNCKUf+HS7CwFzASOUHLPKwwKX53U2Crk/++EjXAvI1AFjmRTLI9sQK8s+/?=
 =?us-ascii?Q?cTNFeFRromvxF9VAylMc6IFoFHt99AmqtqWdJ9g1l0+EA+wfCCkv9R+vpOKC?=
 =?us-ascii?Q?zCl6ThFvgc/zKSnhXkHXgP5EaxF33IpkROSMUNxvt37/PxNDP7Y7Vp5DN+yt?=
 =?us-ascii?Q?w51JiicHfs/m7NYTiNKdW6KLGaNS7LkXOWgXhYI6c6PRZs9dvxvryywRSdgk?=
 =?us-ascii?Q?aU6sRwTYmWsj7aocoq6R62MjNjz1+O8spQ5NfTmeTum2QaBKwP5Ie/vDlWBH?=
 =?us-ascii?Q?jjuUWqRXxrNpTCJz+kGCAY+9MJq9oD7t5AjZ/qnDmnLmfKI4XdJkis1pZrKe?=
 =?us-ascii?Q?XXkvD0piVAn6Ho7GPljJ65EBWYA5WB02CykJLV3TNRGpl1X74NvBXSkxQuwm?=
 =?us-ascii?Q?wNpbEciKQlPb6uIaJDjPZ0FbbfTwLr62wIVeTOUF/csTDKi58LPBrIJjAPg1?=
 =?us-ascii?Q?txxbF61WjU67UCybpQGUlSSNHi9B+dm2ULq8F9u7EM5x59D0FD9PRTvM77yh?=
 =?us-ascii?Q?/kWucPDhpc7V73MhprXhe1rRg7kxc3PvpUDS6Ms8KVngqKTmmrsVnULTi5pF?=
 =?us-ascii?Q?NNSSaicJ1PrPxCBQqX7AkjPhWnpjkO1n9YrWf8aYGUHq1p/NOHkbJqbS8SZS?=
 =?us-ascii?Q?y4xpKe8Uj07jMchAeMzLjl83XA6jxa5FxOnL1ZhWHFsYMdd4J4r3v1hdeEY/?=
 =?us-ascii?Q?WNMlHZugA94LYpFglrcwXAy34EfKy8poN4iTs4qUcZOLBRoKCsGnNy5BvRR0?=
 =?us-ascii?Q?6vZSk7cWHBorN8tVPXCy3zc9ewKbAum3Mko8GitqAUjFd+rFE7oKNZ/lSu5j?=
 =?us-ascii?Q?/bF+yec60NWoKbaAO9+wahkb5P2SSrinc+mZlxv2N5qzsP26sD8ybHHgma9x?=
 =?us-ascii?Q?1AHkEtkB3bAHbfPmWyFjNolDaNrsXi/ODo+DGBWB+cWfECeoLW/GzmQifc2p?=
 =?us-ascii?Q?Pbz0mBjQ2AL96bUCToxA9IB/mXdgxCtkuTK6WhAAvG+fNRmYE7E7apReIl5v?=
 =?us-ascii?Q?Q+xkxQ6blQP1zUiZ4OHwx2kxeUZaLPyY2iTfqCIVHFmJ3vZTXUQXIr3p+A5T?=
 =?us-ascii?Q?pPgbRg7bTpAVzl0LuFIpaoY2QKk7U6DxlRxJ/PLbrbld3Pn1KlvHay5C3Wcl?=
 =?us-ascii?Q?BatD2OdZ6ZT041FPM/g0COpIXFbINGKj8ZRm+sRUZkcjMwIjvefjy6cNQW2y?=
 =?us-ascii?Q?fAyX44MGU9+cYYbWTaDmhbifHlT8/tHK++vEe+Qize4/dPI8xrwdC3aRVjW3?=
 =?us-ascii?Q?vmulX+xItoZ7tI0VQVUcxhXwQPv+5KF5wmd8c7mYd9pHUc08WKEzfcjC0K9h?=
 =?us-ascii?Q?DJIoUo8AFvb5Nb+670htE9OTlaJZaHhsQeFcMTFQtu9VL2V+qcaSfDvVNz03?=
 =?us-ascii?Q?AxXMP6kuMQyCdeBhnSfbK+wkkI/s0n015VZdZ3dv9PY2JMCmjt/OXrARz+AX?=
 =?us-ascii?Q?pZdqHoT0cIJYQCU+fUc/fo+RUVTmKZLxTLA59kjpH1PFZOwOO79cX0NKy/Nd?=
 =?us-ascii?Q?RCrAS1gPjJRVZMuu0snh6jFn7pGv75xr0XbQnn8C+2z3EP9nUSZ/wiipZ8Bn?=
 =?us-ascii?Q?RDfABGgHouhqf3Z8yrR5xUuQYJfu439wJdbOcniBepp/hPFrqyrYNb1e11M+?=
X-MS-Exchange-AntiSpam-MessageData-1: XYyzx30y5/FYtyLRaw+PKcCZPVy/xRZcro0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793a5f7b-41aa-4404-3190-08de7e0f683e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:37.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlnNBifvp2umvNF9qSWLlb+1ZXIp4B9jHeG0uYAWb6jHKCfF1H9JYd7V54UUb6i6D8+PAKHsECchRVPm2r2G6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: AE68623F6F5
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-7044-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


