Return-Path: <linux-can+bounces-7493-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ObTMmjE+Wk0DgMAu9opvQ
	(envelope-from <linux-can+bounces-7493-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:20:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E04CAF8C
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 12:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A88AB30BE4F1
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018435FF73;
	Tue,  5 May 2026 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q8IUphd9"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B535CB6A;
	Tue,  5 May 2026 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975551; cv=fail; b=l+2mNnXn9oe6UZadlyXvP8ohwr1Y/nllzlFW7QkpFL/BTpiEgpuLwxN4MaX+vQ+GcLbKjdX/zW8wYRJfNIA5ydlqLc2nxWRqaEyixhpXj8zvWL8pR66YXLh+ObH61PfnVOxIzWjQ6ClSLImtRz4TH2jYkPPTYJzlXGGzOZGSSlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975551; c=relaxed/simple;
	bh=YWvSirGPhoay2Cmtoxb1+wKLj0r7nE0xFIASpmtdAWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWthlWaN4m0KRiDK/MwzFdVplzJD+DBY0SAuz1rUGI44VCYIIxyS57z7zgnsMEVa0xb1iiDP2tz8cpgt5JGHsSHBXREarfhzPwx+F7aH8dI7Amn7yntVltKtb8wGgJA/T0D4Dt1wXZ0yMDGOSElNiaCeLC5uhdohF7yeGduS9D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q8IUphd9; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb4hhTbLdkJaynpZtwp5/btQtsZxqLuu5VbHtWmd/gSHpflS9Vyu67cfsI6GWwIHEzGANW3wU3nAXF3nIlgQ68T6tmzll4s5Wie6eZbv2dJbwYQfZsg24e2xbHYCe3lh5zIH1oI9FUwTisMAjMe5eWMN5urzsyk1S/WLODMyWSItS6AezHFlSb62VgaJEUCE4bUx95Fouvz6ujRVK0uSikap1t6KOkOPM1QQbF83qFqBsmbAWa9wPnptXmKXkQSRnLUClEO4E717eUCaQSfuo+ZUI3/BjXK7tJXrYM3jerTRc2EXYJ0k+lQ1VeEXuETSr2PzP8hTaKv4Wxee6eEC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMEipDXmhMqy25fmsuOOqAPPy+PYETcjqbDLd52EhfI=;
 b=rtoPUhvmAe8fZjBqQGoB4d9RuWbhyN2i9tFSVW7CQSuVrCyb2lflqomTl2uPcdbJTqHwOJw8x/IboHRTdc6ONShsvEDJV+2rKJLhe4NW1+UUWf3cJSBVN61A38OmrwGwDxn0RL+GFDHvL4wV6keixsusYq/3FAedMV5J2H7+VLFsrgFP+sgHG3bMn7y1rh8UGSBsLDIzKNRLni3YD1V7O/aOtpbMT9ZPfRXSFmghpJ9duYSYCZ8WtWEQvI5w9KIPXpltpIDQNeaivRZ7R+mmsPuHcIIxBLKJmPDewp7wJ20u2b+7dAXzerMbwx1Zir5Os6w8xkaGEcpRl8RysjNDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMEipDXmhMqy25fmsuOOqAPPy+PYETcjqbDLd52EhfI=;
 b=Q8IUphd99ebGDcLEgUFjDZfm8TN/Wv0jFnyXAWnEbuRKZucF63bzyxAGzeMp+wBJ1+yuuLs3BX9dqgYHsKJO0lP1J56k61zpiML8jkGYodVv5N2AUtSi+P5Z41czwgZ37FMbmKrBXhP0+kFClaPL4ZXh646RQwRgyUL5wNl0oy9W6BYLjx7y3KULk3qs6998SmyZvE2sIMyiBZ6wNb5RXNeAt0det9o3dX2BYgia+JJ6PsCXdMK1FKZ3dRbTccNac/9jixjR/w0FhVg5DakWnxpIrUx9fqHyatRMpTGAcIn/ekpGF85gldCP3JtjwABE4CwE2amSPWGMSPfwDVfDIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:05:42 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:05:41 +0000
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
Subject: [PATCH v8 phy-next 04/31] usb: add missing headers transitively included by <linux/phy/phy.h>
Date: Tue,  5 May 2026 13:04:56 +0300
Message-Id: <20260505100523.1922388-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0331.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6a494e-a73d-403a-33fd-08deaa8ddc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yx7EqZaLlj8GBWRIGcy0H9eXYv4HzANWnfXnfn6e8XEezJzc9y7scNXs8E2Hdy1MMoFcoW1uK9DLq+K1l7ZiPL9Sk7x4+TflX+O/8YZnA2XPKerld7dTtCvgQQ0YQSjkM2YV6WHqNOXEKLTSZQ70KbyF4a82aQnqIY9/JJ9jYA59n4kBpUfkH/FsMIAuozRKuahB18HeHz2kDzHqepLp98O05Acvsf5V0qUHiQ6sdESjK8kdMknx9HF5HcYtmUbWxsNSQzQQ/9dA+61giC5/W53uQVfRip5Xbo0ky3J3ZE4xVtGA+NY+BsvziTRgD6chIZPa/3lYPfSUPdUNJ0o0XNs3qJje3lK9Uahfy7LOxglSDm5Q7FenQNbioci1ICaORP/cywxvrDEwF8q+uGMEUxBNje8P5qZmIBHCtoD9+c2MaOE+Ytp5zltvsjJePxsG+cipQu0tDoHJspNbJS18yaBcMhVBkqgUPwGx289Sdb1OIiWB5afhb27n4g2mOU83AZBO+hSXZoeCdlG3pFOQ0Rk3nSewYVOqBvaT6WE1oTQsshyni/5yEbr1INkMqa+yYfox/uybTUuPGe8yMOmK7HJi+62BE/cv8ok0tTpp81zqd7fSf4/n56qM6Nr1E41f3oqwgF9Pc9K4pQmW4Cl6FZhHrDx4+v86caIR0z9xyNwLObv8rYxPRwxLkZxGsR1n9lv8rYf/Hv+e71EqLbScPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPRnHdx4KK1BVedcoBji4p8n4PQRpHiWrMJaH35m/sSq0G++SFbPuVklP/v4?=
 =?us-ascii?Q?EKTf4vALPaRn3ul46MZj6O7U+rJFVkmZYDiPy2WEOx2ED8ZLO1FpouQwmqeS?=
 =?us-ascii?Q?bQuZUM7FRDrL3NBJn/ycDTycdZU34DLUQPRZ1aeP7DqVTIE2Fx7HsXOCcqXC?=
 =?us-ascii?Q?iJ2ibo8usXTdJO6MxhejNC7E1PtRkfc+IuU6Qns9xKDJbeUDbEAgxShuUq4k?=
 =?us-ascii?Q?fzKna79xhdWT8qVjQbkepRLDIrIkCVfjz+SCZ0sd/DFKwhzWdduIcPbFNWBv?=
 =?us-ascii?Q?w8G4rpHUXE74Jhuw5FHTkLUMX9h64Mh5QATe/5AFnu4QwXLOJ87HLsH/QEUu?=
 =?us-ascii?Q?NkHUfGDS0wTId4EX6a7UVHs1FAI7DCOzrULMOTTLuuLBzGM59rip/F1UwxCP?=
 =?us-ascii?Q?kT88uN+Y53MRLvTRNDdpvtF+k/Z7Dv40KWSoJeBFitJCjFMOeuVoLQTYvZdQ?=
 =?us-ascii?Q?bfCIUWknyNRQy1J96ax+/7P4Ttmwbol9sRfH5favPLzSC9TVpiYqMCU7VyJo?=
 =?us-ascii?Q?12EFmOiTS11RLKIEkKIDAYOtiMIQLBTeWhbank3BDTRphQkqioCMeuKTfSLw?=
 =?us-ascii?Q?HzMvQ4rxQxImOkbP4q9Zx+B7uNyh07vnbObxESwXbMwBvUA1fiPCs6EDc/ja?=
 =?us-ascii?Q?oZL0nXy+Xp1/RepflbCHnV+6MUnbCn1ArlZfZEpfcWkjwkVBcZQWBo8oS2e0?=
 =?us-ascii?Q?5bVvlVtn9aAwSRDIK2ttU7NWqmjyWKqzdYjoCJMciFAhvLL2mB21y3IymC76?=
 =?us-ascii?Q?MKft4vNYPqbaFROhf/atmfVVPdkeWmDajOha01FPFOe7sMrFFW0op1BQjZhm?=
 =?us-ascii?Q?a/mXZwlVLNzdEGhtLZEhuB3K+0n4XKv5K2D43gEVbYU1tZepkuJhR2rMrD2L?=
 =?us-ascii?Q?zWOaVa6k+fAw2UEIgTf9wxMLmVIYU33xDNgWiwzCClUpHqq3OhqfU4C2Exsv?=
 =?us-ascii?Q?7Psd+h32+dS8xXNhVoLyy30THLKBeFJO132sgsF5eNzYeAdY40Op68EI/CS1?=
 =?us-ascii?Q?RKuha7osh3mhKqeYTPWTIYyL1AlP03+5vuZy7ndZO8Y8gPEFpe7gCG1IZBjd?=
 =?us-ascii?Q?GoDkS7hwL7Q5kRuYWASUGvBijalKan/uN1j/dMpcubZ1PyPPYMpRHgDWYjlG?=
 =?us-ascii?Q?QczcY2FP/ddVupGwjXuiX8NNnReYFIpDgOloXKxw6u1olRsxGJRDZY5gKMRO?=
 =?us-ascii?Q?E72eFzgSKC5SDIn1I36BxFeak+AnipaTBFUoPA0DVWPXhC5h+x7Knq69vbG9?=
 =?us-ascii?Q?sZJ6qLk213OKCTa02FAxhAm1aBBV5bTfmL7xGQGO+kNJYUGxP2SIfPogwcjd?=
 =?us-ascii?Q?ns0WoW7eW9THcIfOvGszPfbGElXBWRAZ4ke2LnPXkKSbtPndzc8KQbDomH+g?=
 =?us-ascii?Q?VzTzIZQvOh2S9aAgfOCz4haO1loC4tyE9CeJk6moJ6YyaycKukNNPPRGGpSb?=
 =?us-ascii?Q?2OBKfzIVjPk1ooyYyvZqApehT1J90MtE3ziVmqSGikPt5KEqtkVWLnM6oOqZ?=
 =?us-ascii?Q?AJ+weHZPK3kE+NQgaOOWaqVfkkcUK7PnxIq8giufZrL9xIt578oBWu690q1E?=
 =?us-ascii?Q?a4enxuFpuoBJvMzhDfWbMKBN5l289w23DIQVZPVdfVVfpagnve5EG8sdlmO7?=
 =?us-ascii?Q?KRUuPQZQwjx1P7p3x2d8QV9vXS5u38iQWpKgpWPjLUEfADrH7808mn8tvWBs?=
 =?us-ascii?Q?kXL9j9XIi97WmBas8f+6IIwTjsHDYBz5BldSDqCtLzV4wxRETCgQlfI+qU7Q?=
 =?us-ascii?Q?oneO1vGBew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6a494e-a73d-403a-33fd-08deaa8ddc8f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:05:41.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT58f3hWfJPcmr13WfrM+AZ2mJjUazoFYVoWOt375lj5x7QXVACvx5HKudRJ4NZBkAOqAZcMBZPrH0N19UzEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
X-Rspamd-Queue-Id: F21E04CAF8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,synopsys.com,linuxfoundation.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7493-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,linuxfoundation.org:email,synopsys.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

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

v7->v8: none
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


