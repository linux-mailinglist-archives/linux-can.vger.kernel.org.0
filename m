Return-Path: <linux-can+bounces-7033-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOD8NQwbr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7033-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:10:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD623F39E
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B36F3025263
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6293603C9;
	Mon,  9 Mar 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMiKeTqv"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4E34DB54;
	Mon,  9 Mar 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083377; cv=fail; b=Uz2pF+jsbeBkVP6uYUIm7OimAJiwyt8Ujx37XM2OUTztJrktCW0PKF1z403Xuo7Lps/0uTarpJynGeKBQq5T430nblEYspYmayA+OGmiTLDxVGxssZXxWJiCyhtG3LfhJ4O6n97OGqCvSJCXp2Qa1Y8+QJYJWuvaXveOsUR8O7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083377; c=relaxed/simple;
	bh=I7+a1+X8Ak77TYLvxSUT7wfjgC51/Jfk9hDuNhjnU8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tMlywl5qMmOCcTnS81Aq+1EQ3rRLcXu8blRhb9h1dRjFDLCYws2dzCzbPzIGWujhsXOgswTZuvMZdDSd7DhdH04q+D+Sho4RnGr/7jnzeCp1J1rEckE0SyczDJ0a/+h9Qe3uqmIbulgs5ZPg1ZvO0Sj1YF8JzHzFk5I+9xRt8BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TMiKeTqv; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3zAY4BMSrCd6ZQDcaRnQMXRIFBL60ObgaBeoU39+fQgVIB2tDpOWUaTsva4NpyJySXYTDjc8RO2IYk2GBhZf5C4nLjXKuyulsGYlRX+sxlpVguQw3yIcELTaTi1ibVjpZGogk5Qp8apX61YTTCeeKMDU9ZBBgMDIQ5alwwbDx+FAUouyv4E23aoWoKCX+jaIrOG7LKq5KTu+1CcH07dYWgPcawrCmJBDcKysPiIKxb+ko5xm8G8IIMgJOgEJRz6Sst3heYwtcQUgIkvX7cIrEe5yALxzm41ts2kwPXIElmaTeKKYeGlJ/4eF3feDxcnrkJ0hqq2KDVqPVQyqczeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1ETKpW6hCG8drky/YBtHxhS4gzovJHKozanDVYhu+g=;
 b=wLYismiSaKP0gW7BXlgYKAnCXpkhsPB+MqinptvPBO+HDGrOdLQDHej5aFeydFHS+6DTMr2n6E79acAhfEnBbUwTZIlyt0HLLybSzKpwJAZSsYkcdT53bIyq52RLRdJbqEOghDhvtJfxJOJgFXDtD44906EnewFmJDy4NQwNm+T5fc2LEPapu6QghqQjmNH4hF79IZOgjsNf2hjFnCGmSRFUKQButmZpXuWEogmmB5ZtR+AE20KDESmqOLmXLImrno7U0WPvFTJt+BBpN+USa15mDZkwIjWvWFCSYunqYyxgn5LI0pbQ17P2D9Pj4Z4m3XEO8MdTb9R3i8rCwhFbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ETKpW6hCG8drky/YBtHxhS4gzovJHKozanDVYhu+g=;
 b=TMiKeTqvlScXqeEsBBspYmkkQ4ahoxPGaUHyw2GbrkzZtudjQ+DlTrDVaBYD92+R62cg9hLAQM3WJrTt0GkZ3+VsU3cgGk/uZ5i7mSBWVOOb13MCXqxHu02XmXG1bvynoNAQjnSCxzW+vJRwUMftqMkzVilurym1a6vc63FdA0Q73f73yRStcEGZz6j1IHE74wERzsxSAqd7SKU+MeDJJMjXVfioeQp9E2dH+zVs2fQiClnl1rQrKAQfDpyN0Wsm8AasS49I4VhXzXcg7qEM5b+qz7dG/0TlwOPoVNafnyKOahcsc72stVKpaQEWfe7U0GiRMhnzBpqXX+TdGWZVdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:15 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:15 +0000
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
Subject: [PATCH v3 phy-next 04/24] drm: add <linux/pm_runtime.h> where missing
Date: Mon,  9 Mar 2026 21:08:22 +0200
Message-ID: <20260309190842.927634-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b68e1b-dd93-4d6f-4646-08de7e0f5b3f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 pD0yLTbFZGZedI8DEFZChbfBole3PiKPQcI7Si5DiKx3eMUkZiMpHZIGgF8ulXqtGl5XQ8APdlJ9xIFuC/F9aZDzle4I5LijeJBWQNOGLVMt5SEGp+pdVbZfhIcjwSOlW9S2yTCdJBNIJswn4d8VymyHHQXPtm5S/L9BE03X9LcbNaoP20m8iI73oPBaShTo1Aa6R3Qk2zFUJiJ8p6a05VHgeEMApiIAZVk8R6O3fjvmxUdTzIeKmsigp3Tk04w5nTdwAUWJqHFZC90gKK0aGBf+9uITqrrJPDAnqRX5JdAlTzO7hC10jgb3iuQ+PM5xWGOtYfL+DcjMeMeapyR1fSFBaR6RteZKTLzqIQtgf0aXPMLwYY03rTLHNllTXm7yqGupOJuxtnRqm8TzHQ6ZYO1NP5nYj4raCDVSvdWS0P6ehIOBiP4kNmP4FzUYAvhdnWJiWvmkdDFtCC0xxBTNyoXg8dcLXMJ+vVPnDs1YGnqC4xCYTEaIA1XDUmC5Ts6ISmoqOXvjiWxmCS091XX4qsN9GwUbIKw3y2DKMh2QhOpd7OKUjygc+l/0cn1cix9RYRhgSVIjFeJ2zIrv6jAe3Cl68/EsPMKjOcV9LWL1Xa/luXdVmfvkFJQkfLEp+DOFLJcU4BpQEZGHDkgbO3LClUnej2HDdZRy1H0xRO+8uCVOztZ4S+J2Q0y+ivn6TGQWzZ9+jv6Ws70Wf5MLtXWSceWOTOXqR7JzudWl8ay+P24=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?AevDH54PqvvwqwfmCiGkAAxq1DKC+moe4RIc3TUseuzWzhM7qZPrMa1bIZQD?=
 =?us-ascii?Q?yhcSarEejHPyQME5Ct9pTSqGHVFCiqJOJmeqgFYm/yS0Fh1F5cyiBksqJQSa?=
 =?us-ascii?Q?8tMKU4da4aNW/vN07ijIy69JmrTq1l3WAU/q8/6CJD7PCPZRcLrnu0Ew468w?=
 =?us-ascii?Q?3cMUVtDSSOaM3lSIO1X4xU5Ycdh2mVF58pjK4RD6yy1//KAyqM1XO9YbUcJy?=
 =?us-ascii?Q?hQVNR/pK0on8QZeVgAGBLNAV8k11JQ1jFXmBfBx7lQG5efwqFaRy5vFiBSBR?=
 =?us-ascii?Q?0G0OWm2tktxwqjo6bCqq0oOg/+CXX2iNNwOAZ3Z661n36QIu5PIL+ttRpgtC?=
 =?us-ascii?Q?Kd5/xAOE2Hiokw0LgaKKhq+UZ70qbCIwH7+zydXtW8J3AuUNoE52o3Ql49qL?=
 =?us-ascii?Q?dD+ZrRiLE5apR6YYUsgHB6pmWFNtl9IkVFraXDDYnHMlY0ifoY9CsLZIRt9S?=
 =?us-ascii?Q?/nvrif6kZto9XD6Jgs37cYE9i1Ys7nO8xmAZOUZFNmU3BPlvAoaBTaqfjtGy?=
 =?us-ascii?Q?4IlMpZhMlxmePdjjxkupphkWlQoNxHxvXSvtPJco0Uro8SThn6fM9tXN0GDk?=
 =?us-ascii?Q?Pm24zDJaZ5yYan4QBMdlU0LWPBgoJeJcOMNEoAwuObACUIanDnHttS5oSMlC?=
 =?us-ascii?Q?n6iYrEay15cj4UNc5yjMjn2NdUBIGeL0IwFjJseTKkk3zLsxh8OxbrBIK5SA?=
 =?us-ascii?Q?U30xtK2CvGSiTLa0I8rTyPHOsPIAiTA6tcrRGnDKDzsDFhm/EwJo0xY9UfX5?=
 =?us-ascii?Q?zxnAXotLMSd4auKKFtgRki2t+KOW7KG/QR09kDn3EH9/y/7X3TMLFAYSCYja?=
 =?us-ascii?Q?auH+5snsohthQq49OhzSDLjVAhZxGsSI1ON3wDtsrQUYsdbvpOcb8LYRKHVe?=
 =?us-ascii?Q?a/iyRlVOcdlrYhN2ocXlZCzNDQfHw3YzTdS+qqUf4y/P5cBA0nh7yViZDRi+?=
 =?us-ascii?Q?9tJXBCH6uXp1GRYCnGzhgvkHokhyPZ7Jd6EGvYNssfxtbLV0EnHk3U6VRIQI?=
 =?us-ascii?Q?Dxlqr7q+LGN+D1E2Z6BPfp1ewpejKOUzhAvSYVje9xI0yGhNn2nClLnaLYyt?=
 =?us-ascii?Q?so7ufju+5Qn8KHLswX7Dd+up+hLDJ9WqdKK88Ey9/a7FgwgTBTWeWRfgVNTs?=
 =?us-ascii?Q?dlDwVfmRIXOTJ6uJGjsnBbLPmYT8QKzt+bhll1AUkpDGFSnhmrVdX1J9YG3T?=
 =?us-ascii?Q?nge5kf82LvFuRUZJ+OyVV0Ro95hGZzSuXSa2sbLhAC/rTSBIb+ZANzs8ZxCz?=
 =?us-ascii?Q?P+OM3Dur+BmPikAwxDjsXw4M21uXFg0Xih8sSfsZFGl1032Ucak9hhWglDHt?=
 =?us-ascii?Q?9+1tPmHmXaNrJJhELhjjgTQtN5/5JlSCYuaaV28vGMrofpShq09DBtAr0P9U?=
 =?us-ascii?Q?6ceUAqBvy/cyjakyqLpfLJkUA//ibuCv0U3A3dm5ZbwgWDM5I/A/wOaMDdMu?=
 =?us-ascii?Q?kv8bqHNgFy+ZcqXZJi64QYp7GldBH+YnDIqSIcuO3PQf42ekBNbw2z2s/kFK?=
 =?us-ascii?Q?ALC37ddhY1fzL08jJjVoOlNv9v0stBR/I280NHY4xBf7g5X8MPOCKNdd64aW?=
 =?us-ascii?Q?VfpklXFcs1/DniLrvyLgzoTq3ee4JMFj6EXPp5O4Zw2AHq11zk2lyNzvqHks?=
 =?us-ascii?Q?BrWahIRGRIQVDV1UNqXd1wpUnigvBtxzB4z/kOacDNKyg6H0zRitBtaZzRAR?=
 =?us-ascii?Q?Ip2wT4YjBP1pv3vsNdoHahcQaLg3qW/k6uDPBE+VBMC7ZH8ZipOPgkOd334y?=
 =?us-ascii?Q?X8FzMCdPIJklcnIS3b81noCBwvUsPavUJIXxYby1Z1FSPsahqm12dh3+9SvI?=
X-MS-Exchange-AntiSpam-MessageData-1: JiwLuTh1QyVLfA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b68e1b-dd93-4d6f-4646-08de7e0f5b3f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:15.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W4wEUWP+cz1N/Hlu+w42uWMIkQSWHSictSEdHNRtYxmDJxK1GRvAfmpa4yrx4Gvkk328Bpy883NCDr5IQ4+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 4CDD623F39E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,samsung.com,amarulasolutions.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7033-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

v1->v3: none
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
 drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
 drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index efe534977d12..9dfe790e6c14 100644
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
index 9392c226ff5b..a8b6ae58cb0a 100644
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
index 930aaa659c97..54bc148fc29d 100644
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
2.43.0


