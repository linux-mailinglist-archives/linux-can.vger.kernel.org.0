Return-Path: <linux-can+bounces-7494-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIw0GEjD+WmxDQMAu9opvQ
	(envelope-from <linux-can+bounces-7494-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:15:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092DD4CAC11
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC373043466
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC7364E98;
	Tue,  5 May 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLiwxk/C"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B93603FB;
	Tue,  5 May 2026 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975554; cv=fail; b=XNWw3gsmd2oEuXHuFCgYX5DYiXXQyafhbByfqLU3VM7mDqrqfiD0zSy1+MH3XWG3Qerbju7+Nx94nSIZmFu1x62u6yJNhNQ8tpS3HzzybqvPBbC7FlsTqimCQ/6KilgWgh/aR8aHmPVWDhO71k92X+MiCZPOIsJmbncivEvTvCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975554; c=relaxed/simple;
	bh=bZmvByyRFjdchT+yNvmeUJX4blBz5aHRInWDdeA9sJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNC0pUfSAF11JSw8Y1rMR9n3BBEOFqH9o47ClKSNBy0wzYneMuQIrmnP/7FKxeqQNH+5ni0PXToACIpbBIVdUR5WzUqjYFEtrJxNa/FDvD7Q0RTy+0CdGFkMVpO0oeuLPvYdPDUAOF0phxq/3g0WCmOBj2PBOz2nujj199dZJBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLiwxk/C; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAi0LZjUOXoNFazCZrA1DeMH0Td0SmvycO9hI23I8jIju74GA67MFapHgTPHtp+wy5cbJ/U9CddVKOYHDG5x3sqY/jb1c/YtIItMHORvYL24p+GDh6uk38+g2xywJS1c6QlxSei9I1mLsQHRqrGxqM5EOsCGDnin8hFvGs1bFhL6ljfk8px71EUqf5yTf8cQ1uw5A0oOLYFk1Y8wOGNCoP90LyJSYbSUMt+wLpF3q9xy8YMdwatPAIATS1N5lFRcLyltNeCM8REQZkiZtNQMZeDxQJT6pmDw0OaU5wwRWTBaZikAaTMerae2sutVTLNxHrBeP3RRrlG4o8QX3c8kEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS+5THrrREwT9nxPyQ+H+C5kAxFJUFMEj14n+Jt52D0=;
 b=YNWPLlJtUzYBhBLwadNBfVYLxktjeJM/JPkrVTpI8itwSK8UIEtamtqz8Qk7PZMz/eXUxzYk7ffMvJAoZBmUsSYzenwauYyIWlvT6NN4ZCHdpFfVv91gBbiQC/oeW71e0STOT5m1MOx1iqWW8FpKU9IOR1zZwhuQp5a0659GVInqlGjZRyTuyx9QjSKza980ACWMh59tfwv1z8eWMPMtBCGiESOFm3oRLG3cxTXVZcI66SvJAfo8rpXhPv7ArjWUwSjWo4j9+iKbKAK1RvWI/EIBZce16MebamV18WaHQ4mFv0plNvEtGZWgzSnftMHpfAqXQ1iaP1B3oUVxmzKKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS+5THrrREwT9nxPyQ+H+C5kAxFJUFMEj14n+Jt52D0=;
 b=aLiwxk/C8aK+PJ3u2/xM/b0Oiwj2rnH1LCjygJn+rOivUXRWoUFN3qSmqrhVPs2yHv98EMgQgLYkj7dJU48CUkQJwcNVdOriAPqlAS/R7sZLrv47eZNFBz2yrrege5tdspf9b6RrKgu+0oPsQ0x58yX9GPfBGOeJj8Y8b4igNJxz0xB7S4NNHXZejmlUDbhT/lFuce6Sf8IGGT8gLmIUaXLbYy6sHpMSSuc2/Pen8/9LCs0ti1W/4vMDAYzMoyh4C+Hys0U8tU8kO7fE461kis2bhGggwYu/F8NELUocgpFsFJdggCZSpwnCw/M5nueK72pBVfw9bR0Y3rNJclyoww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:05:44 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:44 +0000
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
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: [PATCH v8 phy-next 05/31] drm: add <linux/pm_runtime.h> where missing
Date: Tue,  5 May 2026 13:04:57 +0300
Message-Id: <20260505100523.1922388-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 72545322-10fa-4a7a-dbd2-08deaa8ddecc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 Qf3D9paYyIABDPTDCfjR4GGCZ5P42QGW6OvYypz4g2wnzdc+TZ6x85dbR5WkjCgXqSEcaLDCG6J/vE1GdXQh1d1SsuR7O97woulvEhmuPN2GYui/fCXQIVQPowiYkXQ7Vl3F/5IfbeTp8s/xUeQNqkvi4q4RGLpsQd6ihWQXT3MT1wma/fBqQaPWNS9bT/W9NC8qjAyowe4Ai9zhA8FUfqLiXKfDKhaF4sBdVXtPWpDcOiV5VhaF2t2BK7rDyczEJehp8yLnqtGPfgqMkjLeja6j5AUJAq8V/NXVD5hmuZF8S9zLQQIkeA52lM0NU2jWxeF8zQ7B8m4Fgf65VpUqrDap0vwqLkaMIt/wwtdSdsPM2zAk0sXgvH6xVVpgrEBCA1eCPOr3wmFkiLCFJNOXM8bE7lxztrj82YI8GTebaYsOy9Puwu61diKBRGfjofFXFfa3SjMTM92v5lJiopn1w5JfkSJlLPMfqJrYgIu0JUCxzphh8wZlUUmHz3e1gaefl26rE3o3Dze3udJWZY5qiu2mLnQnXrpPeg40eo0cRZ5ay6djvXM8yJDyAQ9tnyRbiq8Ilg/tKUui22ZkjQtuaJf7jDjs3n09YMddE4VBYjYXurVN6t+oFkvyAH+FXgVVhcrEU0qtO/im2ywxEWCSjCK3Vajukkm6tKakhUQc2DJXoLzAAbH0YprGNztkzuLZ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WfkhmrcZUAMG5tkDUFQQpQzBu8yMNlpXLT9B1Cg/jVVjj8CCBMFqQEpC3grU?=
 =?us-ascii?Q?/0M6ScUElcoeEfTquMWd2Dc/HrCZ3A+Y9jK45Uyyrb9GG0dqQRwuUY/IEfyZ?=
 =?us-ascii?Q?uVEhKiMU5wptGtxDgjUlqGBde4/PllF3ETOd+bO8OWKNuWNXKq91163UZoZH?=
 =?us-ascii?Q?xb7uK1SgtXVNzHvVTzgChZ60D5qHKFwLsZQzXehQY1CA948/DVirMdbU0O0m?=
 =?us-ascii?Q?SBqwjB37/cRx6eSrL59Pk3lC385NibQdvka4yNXP8TB7a3j2Dxd54MWTEfeO?=
 =?us-ascii?Q?fbtpZmAPkoByHtcF3IbVKaUN9rdtxfI8hpk29YjLVswZQ8gCiv6pyp0r0Sph?=
 =?us-ascii?Q?IRT3QrQGoDSnL2ePo+vJbjynvf5pXaXPAcWOlV614rLIRfeLhlSdrXYzFPKB?=
 =?us-ascii?Q?rPpOZzdtNuD11wDMzQT8xoPzePDlgficl3fE/cMhdJBJnEat4wFwCe4I53GT?=
 =?us-ascii?Q?rOElqXEIkgAV+iEAfSRUs/e6YY77AvizJlWeFkXuqTXuKTN444/XCnEec+9a?=
 =?us-ascii?Q?2wjfvNwY90B5f2DHvLb4KIl4IFinL633YnN40bIUGXupVXp4pkOy7Swgzz/p?=
 =?us-ascii?Q?1uAkfvUcHxZF8P3F5XS2R88oIfOPmmMRmPmsnsxsxmGjGfGgIjKV9TcOzy0o?=
 =?us-ascii?Q?Bbrg1PE/emxDIp1+LsrkxU2Ol/iBuSEVGOHfzJEQvvukt3ntR1ZBOc+dFlS9?=
 =?us-ascii?Q?RTV56QSUh5ZfVZ0++XO5NKm9ycNuwV6Ls0XotuTVVslnARf792PcpLN/dNVU?=
 =?us-ascii?Q?3lOW1f28MMcnDoS22LBnKtD8ld+JrQYRutt0dKd8OHH/Q4NYBPSNxqWsCha0?=
 =?us-ascii?Q?tqLuZyXAWQjNVPN3OrFApVQdbDbCSbq0FVSJL1QsApB5c5ubcn9etjZ/vGqK?=
 =?us-ascii?Q?vDfvPvEr0KM9/nlZEAZQ+oqFGhPrBnDd1gWs04pDxBJy4T7GXxx90t613YSk?=
 =?us-ascii?Q?tLaoGlhA6Y9hnyLlFNAeKz/t3aDpbtnpHtQ0kLUGpvFyarJwb7W5d5mPY94Q?=
 =?us-ascii?Q?HMGbzrogMtRuVLV8LkRCc/Wma/fIVNX1xUNvfKBD+ZzocM4VfPWJGsRou3fp?=
 =?us-ascii?Q?+3ZCwG7N05/lhmwNtecILqO50GhmOcfjCkQK1W+0hq9Zt/MKVgLTrN7fbY3G?=
 =?us-ascii?Q?9Z5xxZsxiHxTFI7RlYdUknSI843j1j0tUmrvZ9ZM1gXOo+VNwJHH9nonrKNQ?=
 =?us-ascii?Q?52/1ObZMzwRtqQWLSgkGA6JzmhKk565brYO3QmwSa9/js+eAj6Hlenr7REY6?=
 =?us-ascii?Q?81qWiElvwcfTptOeMum+/GT/5ipVhk9MPLEHazA5BcgchNd+ig4XNPWX1QJY?=
 =?us-ascii?Q?Ez7luv7C+Ozf1/6V8ruurbzys+El6iBs7uVbTLk3PoF0CMQklZ8qCAW9nD1h?=
 =?us-ascii?Q?FJ9Z543B9d6PtGZDSVFGOWaQE+Zsy4jP1rxTZRRTIdW92TN7N2o1YpNo4Qjy?=
 =?us-ascii?Q?eblIyiH92t7e1VyCatBfjaVRlmwSbmidDJVwWiNnN1o6gpDzOrFw4GXpVsPd?=
 =?us-ascii?Q?69BZh9rsJLUQXIm5J27Cp3vzNTZnPZOKY9lvpSBIZh/91vnis53XXTbBYwkZ?=
 =?us-ascii?Q?njPt7+jOccAK13q/p2hWhnRBOkDxhB63PlGkClx3cFh69GvuDYeQk7aq7pEe?=
 =?us-ascii?Q?SGWB7+G9Usdaz3CM2bH+nixbg6keVYTd8ghehuQKenY3uoWTZbnn4OMJ1hu8?=
 =?us-ascii?Q?v67L+zWINlwYkCzNqnRhrWCfR/BYInSDIOneefwQ1mJuxt+V1DrQNzpMe4Ik?=
 =?us-ascii?Q?/LK39JPHvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72545322-10fa-4a7a-dbd2-08deaa8ddecc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:44.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPnQPpBfTQOZPyDlzXRHihRLS4fyHmwpqFUSpub8SPjDNz2mUcmgDClcnv79Ec5cyN5B4YYYwBtvk/i6sO1n2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
X-Rspamd-Queue-Id: 092DD4CAC11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,samsung.com,amarulasolutions.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7494-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Multiple DRM bridge drivers use runtime PM operations without
including the proper header, instead relying on transitive inclusion
by <linux/phy/phy.h>.

The PHY subsystem wants to get rid of headers it provides for no reason,
so modify these drivers to include what they need directly.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
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
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>

v1->v8: none
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
 drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
 drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8dee5f2fbde5..4ee08663e626 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/drm_atomic.h>
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 064c6915c896..d20c0f8ad04c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -32,6 +32,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-dp.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 2f7429b24fc2..9ac8796ae91e 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/sys_soc.h>
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index c3eb437ef1b0..4244434747af 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <video/mipi_display.h>
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 3825a2fb48e2..5ee22f88bd28 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <drm/drm_print.h>
 
 #include "dp_reg.h"
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 177e30445ee8..68556daa54ae 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -10,6 +10,7 @@
 #include <linux/firmware.h>
 #include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
-- 
2.34.1


