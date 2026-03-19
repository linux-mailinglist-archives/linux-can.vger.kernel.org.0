Return-Path: <linux-can+bounces-7185-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFvKHVF7vGnOzAIAu9opvQ
	(envelope-from <linux-can+bounces-7185-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:40:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAD92D36D5
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 23:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41E5F303CEE7
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7D425CCB;
	Thu, 19 Mar 2026 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fawHQl15"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B354219F8;
	Thu, 19 Mar 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959615; cv=fail; b=LnRLBmDZVDD/+EQlduCod5wq/9cMBzeIybzCFWRETEeSPftSsfKre4K5pa2xLGQlWlo55P+i9V+Be4jzIkEN00IrbaO4pRIn6DHKfYOAtq929JsHbjKY9Inh2E/Zb32YiyxucOMv+BsRkMIqadU/DYbebVI0JlLFoSVG0y28twA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959615; c=relaxed/simple;
	bh=FJ6GioYEH50+lrxeZ1qtBmM7+0DNWo+gI3cxkvc14/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3TonPv462klqM55evZoS9XZyEWFJ2+BIBloPlnuG5X2NM6/3yvbPx4Foz933OBSh/6aC9Gm6wBmH5Y1WHMBiWAv8sCT/x8kbxW4vZlkpXu8hG7rQVMffjrRVm2obm6x2UYPZUvuJOGsmshOwSfXcjX4aWggPNG9WoosnF7imOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fawHQl15; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2kEK/Z/ddegq+kBg71hzQ3XZqKVRLpP4rDErcY9FKES3P/5z6IWl6OVM8n7Nn8h6ReO5eLdHOAzA01DaoH8Kejqx2G5wySVoxqpQ4Y1KYq01TmdXHBH7BgmU6tz1oFKSfr0wVoRwqhmp8r7P8Yv+l7dj8yXr64PwAgNPv6fjBgNe/f4iiifWUQGxHPQLdOoJzz+FA1AIKZfNmKOXwGARTpFQOhBJZVLsco98wI5nCgzi2HpbsYc4RHfLJf6Gv8dKGVIt5I+e4tNPl9y5W4g7ZSkWxLz/ReyHLZWByLaBl6M5ZN4OcSYbuULV9r4iPHX1J9CChucdxHyDtMRZwP5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N0MIrXccr97jMS+1q2Vkr3OqvCQEB6Fyky+1gHSqoA=;
 b=WkMGBGMDKSJTkiwOEFSJ730rQXHFFEem4zoN/O3/LalQj3bmEpWBP51q1wx9fhL4nFKkCr9b/ikS/7gfYlYPtgVMPpGHeLHnsYdJgKgOWUiXkyMZMY/CJXa8Lg2qYaLRvjxHFZo0MlLT37ij2IhJ64019kLMqd2AnB9hdZLEyurWj5QEWVjIlGpvnLgcOAm3P+QDN4QIkZ/OX2RKRnKy88xiAosqyN4r2o4dIsnP0BGLbbeEAA9z59qAHeN0a9HMFQ7Hk67skOcBn6A+RhlT3kyeoiuG8Z6hmzENF3N0KdhI9xXAon1v3ctpUwd+Q02OXMt2GC7e0UoAXlo3wN9hEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N0MIrXccr97jMS+1q2Vkr3OqvCQEB6Fyky+1gHSqoA=;
 b=fawHQl15xz4xQCnunG6F3LE6nY1o+Nuqbi4Xjr40js8iKS0x0FAVDs/jI+kVSelGwqb/nuieoyPuFnGhoQR9cRTr+aW1TSWwtCFhsVbqPmYhTgFugaNP8Qe5w/vm19UgblrPmSBViXjr8uu1ZRUle94OJjRIuam5s8xmB6RZS2apZDph8j5iHqbMtWofSEUOQm2gK+975r74c4RXcZcPoCl9642REURMrfwsk+khOcZH7C/h0LS7QDNCE3w7MChTyVTULnmgEC+PAvA39Ob+8VRFO73bfLMjriobYwsc2Jsdc9pKYyA7xtRYTe2GedYQ2LpV/0Mym1gSZW+ILbg2IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 22:33:19 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:33:14 +0000
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
Subject: [PATCH v5 phy-next 17/27] phy: introduce phy_get_max_link_rate() helper for consumers
Date: Fri, 20 Mar 2026 00:32:31 +0200
Message-ID: <20260319223241.1351137-18-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:803:14::43) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e9f052-5f7d-498d-458e-08de86078236
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 PIR0Op3zAFjd7KJKjNGjOZYY+GQZaO6/rQeXC/EqtIL00Nco0zuSw06BB38F7BZhom166UnF5MUSXQAQ59MRALoMi794cb3VISZmUKtz9KQ6sH3OeTh8J6DABOqXr0dNdmRGrmpoO6/Hkio1VZaj1X+5pQMOzkSJUPW/6pLIS9pFN+Rm2akRkt6qQ+n590FCC3XtX1XJhU1M5R8FBBomwm6Eo7Hx4Mewcw2JYKjIzG1qn6QuOi5fBf2DoupLjosZOihxb0T2/aCQEGHgt4T0zYaDVaj3x8wzAVvYGDWNTfK/Vg1z6F0XKwMIwJdmTVnhVR6nwrGU/nukVGjPKaV2wSA9YrKqFTVNRwsaJKouLH8j6O3rG6dNRyRAjemeKj7ACiTgRhug9OPHh7u/HlnOZwdoB86T6dz6Wg+FB6J+NwLq9iZT2Qj/UeEoHWly/Pu6ppYw+ECya88sth7Xc0iAR/Tj9QuqkQKlBzEmSVp6qwFY9OVe1kXX/2+sjTXJL4VFmJzJaaV54L2H3gp0intAitc0JAyrAl0qOzuZiIllpoaF/CcntTPqtUYMmyyfpKvGegv2e+7iyHNyrht+Qui9BAQnBA0qE1P0VOri1F+pwGgIAhxKPGIUyMhnMBxyRxGFy9nrylt6S9kF4UyaaPEBusthggrXtiZLRqgbmLaAb54zMkRND2GtlqQp7GYl34fA4ggJ1/M3lUBLAd7nNNANZlh0mOny/1QI5oGSlt2/Ws8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?cEHJP8ffrNlG9zVBI1rhQM1SnxwxgBr9CDNBj+rxmoQpz/z3phhNPXEmDdub?=
 =?us-ascii?Q?bX+I63yvlCFOxM5nYqyOwRs1bGyfdISq2Kf7pvhBudJjZtF1z4NHMV6ERtgf?=
 =?us-ascii?Q?kB3hbRBUO46053XM5UadPTAeN/me7TIU7v/k+ysVdcJCosmCpyZBOtpaQo4q?=
 =?us-ascii?Q?Yodm0CG4MGnVFYZ3HsMYiKLqGMmN/CHUivI4GB3OkdoCufD+MNFqeYlfGYAL?=
 =?us-ascii?Q?AFRMrdEx9FhMQhVZ1jVzHVma3JcoL9Hiidd6ZFP8LjAUr2BuwbKv+CgIcVj+?=
 =?us-ascii?Q?omV2Ct+Uhn/1eWj+aclce6FJXZqJ1/zEhxtDpsuqPTnBCxYwRRVu99P8oFYH?=
 =?us-ascii?Q?uPQJoTrh1C6YkdQp+c94onBXk3eexI7pzYIHdYhcONzzfKky2+ancilxPOjA?=
 =?us-ascii?Q?orSQNloZ5zNX2r4vPOO86gG8Z0/vNpbw3pSK7xl9dwxsaiPOvstXcrMVU4Hm?=
 =?us-ascii?Q?wVmHeTAaLPJMFYBgKwnT60SM/oi8F6pUmp6FdHlMXDBN+yI6nPlGPOA5CJRI?=
 =?us-ascii?Q?snfZ/ju/om9arxfV7vCbqEgwcWfMFU7J4ktM+u8ZMEUCy8cQziHjMi67nipE?=
 =?us-ascii?Q?3L/wUcYv2p+g2TF1V3V86HOsmv+AFyF389n+X1rh9sHb6RggO6OXAnlaFAnz?=
 =?us-ascii?Q?yWF+Iaz5n9Unta8yinZurRRj1XKDr5IrviEf0/gUbvOgLNi0EvKETQWBs/JI?=
 =?us-ascii?Q?jp1+vZMSz6wDHrD9+u4na+LeL2+7Kq4Lqu+TujSELHPFe7dGqMgBgsA6ltLn?=
 =?us-ascii?Q?bW8g36jUOnDGToAyCgbyWeLjJYxHmj+Zs1c4Pii3c2ZDjw+eelHEiYSPVEug?=
 =?us-ascii?Q?y4tT/6uFUQY95pBnhFSqkbvTku+NTdvw1PibnCEr32tLp93RxU7bo8d+T+ax?=
 =?us-ascii?Q?xgP6bJMYA93pU/28qS+ZzWnJtPcx5RV5Eo3619eho2QD6F5XW3ybVNHLBsIL?=
 =?us-ascii?Q?CZ0YvLKZkoU4PeQ4Gpq4Ty12wIkcImv37EgWEMSQtTIQwufYUaEB+OmpCko5?=
 =?us-ascii?Q?N6OEuLSAMTFlCS10Iznw+H5NjkaibgWceamapXimDAMaOoUYMYQRfODp5scM?=
 =?us-ascii?Q?9goAiOkGc+fvVetpstuTU9YAVjnTglMSFuvfaieLcuZkD0EjiQhiAtprpfrb?=
 =?us-ascii?Q?p2XK6hrsjVte2l0Kpr2qHAWrzYdzgUuT2Iw9N2A0KlZSbDrwuhDnPIBlsgKs?=
 =?us-ascii?Q?VINMCZs2gfgyooAj3pHw1ZHtxEojSTmW+sE64Xu8J2m8r5Gz+4UYawWoGBZs?=
 =?us-ascii?Q?Qhogdpwxx2R1SQ49nUBfv4FrkobW5fF5l3Rz14rIKYpeCAXlewSIVuGU2f9M?=
 =?us-ascii?Q?njicvcN24EL2vA6Ve0l9AziEweF8AN4/nm4ZOneBMbNtV4ekXpSP+HxwM0YB?=
 =?us-ascii?Q?8i5AkJjjH3KNtwebKIjINTaPN6Boko5n7e59AdUOJ0Z2HDSrbmbL6w16xqtI?=
 =?us-ascii?Q?NgTcIDiNlsLGuYFfXoEJG9dVoNP+2lHNRv2KXzK71Hu0TwxmiwrLaIMkOcMy?=
 =?us-ascii?Q?9PiQojQBhKmopyWvPFlIVb5J9wpShKPUXmMVGyHeIPewDqFtJ5HCTPPp8lJW?=
 =?us-ascii?Q?P572nM2lSeY/N8lLWc/cVK/3prTpR29d4MEyNncxyKGM2nbhYa+XmIyfenpM?=
 =?us-ascii?Q?tfRshnxCVtV1aEuHr8VyqYNg/kM10W7NY8mHFornNDo/m0nBIWBb2uwnGqEX?=
 =?us-ascii?Q?2VFK/vdLy5KzT5uMubGX87caBMpjsq3y/QWL9Ey4BbuORdD6V4XE0+Z0Nqej?=
 =?us-ascii?Q?Gbai1MwSHfKOJkD76A5HzoEdLT7/L0MeOIswXRUh90GFR1keFgzA0iEkkgf9?=
X-MS-Exchange-AntiSpam-MessageData-1: SbPvDLIhLRvVMmLKJstj+n3Atyn2LH1nM/s=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e9f052-5f7d-498d-458e-08de86078236
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:33:14.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lz8DZ02oOa81/I4hyIFEGAfqzqpN4jooIVDtBjPxv45axIJqAhZTns1aYK1zawCR6Z0M/YsOmpLvXYi+iyF/nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,baylibre.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,rock-chips.com,pengutronix.de,bootlin.com,tuxon.dev,glider.be];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7185-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.945];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DAD92D36D5
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

v3->v5: none
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


