Return-Path: <linux-can+bounces-7040-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IAgGygcr2lIOAIAu9opvQ
	(envelope-from <linux-can+bounces-7040-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:14:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C97423F753
	for <lists+linux-can@lfdr.de>; Mon, 09 Mar 2026 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7143071C3B
	for <lists+linux-can@lfdr.de>; Mon,  9 Mar 2026 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678A40FD92;
	Mon,  9 Mar 2026 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrQGSFy2"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514A4014BF;
	Mon,  9 Mar 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083388; cv=fail; b=NpKRVBXoMlcbysZPzhuhGVAXx8P4USC5jg6VdR84UNifTw6QSxiNcD2/sVkr/gy5qsyJZqptIwsjoaRQNuR+b8yqUUaZbsgX6bZ7EnOyPZNyduL+793ZU1RYrYBz/nHgK/hVH/Si6+hxxQvW/xSDCRdc3x4QMAEJ9/HVKz2x2mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083388; c=relaxed/simple;
	bh=elus96FR/znWc/gnDj0GVPwlwb9pWAbWcUaEyHIs/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpmyhkrZ3UWks8s4a4xkKCK2HUmsur/Y0ONVGSg855fk9bvtjNEoyKZZ0hAtp3vi6f6xuiaPFxPv6OUT42ND+N+2NGiqXIMPL/XZlNy7Il3SSxann/Aj/f8YniSg6ZWKTTrzPxpKoEoPOH9qq7qLYLKyztRLjhXKo6RenIKgTTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nrQGSFy2; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt9AQ3oPwJIzY/stO31GaQrT2jGlsDjSUfI2+luaNubtrFX6f79MhiV7mouI/anvvobqA2OqiQakt7+o6kHY0pCQA6iQig6649bF/II8qGZ7iy7gl+3egBv8TAXa6M0nMK3v6SnibJ6RKSYxJeZrVgtrybtVBa0djL+I1iSzvQ5cuQLl0B2I/WYnp+wu0az4HzTxLbUPxYJ5Dcz5oLtuJ8zfPss1aBcaomS9rhY7rYLR+KZKyKpKClL1nu3S8aJIKIoV1rgnsiQriPeJ/SPfG0DAcr0bcfX4vDn1O5p9WvjL8/oREPbMwl5GsMARouZgHo1bRPuTSosSvDcGTMtDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ur5P6XXC+lI2cmjawhXkkW4us30A+owlrT5uJMnAB/E=;
 b=JiM1JRhB3ubnUHceyuyurPJ6Xcp2aPeobrWg1aUc5SIjx3T18lqDVPRW9tJfniH4bm60SNbCKKvHLw7Xu/JL5lnkPYnx89dTfFpJNWKYDocbHALBEo+R6hiCGpA/g/bxyBI7xpfFElQ4bjs4+H23iB/1uXNKMU91y+a9c2t14ycvwBmx9qmZhTTHsnDcqkNOGgo06P8FW0zdQanxzx6hlKXqiokZzwjFGkYqJs3HYmPhOao6SWJfO3iBM0/mpuo/zm6yCD3HIdpMeCS/evDFU8Tu9ehIBnjolMZ/PTW7x9jngaXHH+d8zgKWsL8V/bAnmdc2qaDVSudRIbFfN7NJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur5P6XXC+lI2cmjawhXkkW4us30A+owlrT5uJMnAB/E=;
 b=nrQGSFy2zRf5XNTFAFcKBf0bUj0zAhwo+5N2g9H7NB1UoNOtjViJ9repE14R/T/baNrmC9js8i9DcQVzU3NDyaNjFYN2r65ehcyuNDwe373+0z+d/msINjPeZpyMbdT6Trf4qZ/WjgZHPS/CSuXrJadkDOhbqz5H7I3YGz8YAU6yZFD3SP1k2gos/fCmyeR0h2w07X9wLC2dSDbWfG73MsJGJ+4fdG/P3XUzd2yya0VunhIfbgp/Q4paxP46P6zmfCrvCen5k0wzte7PvSGVqr1wCvvYXfkN9AYlGp3sW49OSgfn/ounNbsp27Ad69eeUAjAIHbx1gypgDrE4JHtiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:09:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 19:09:31 +0000
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 phy-next 11/24] drm/msm/dp: remove debugging prints with internal struct phy state
Date: Mon,  9 Mar 2026 21:08:29 +0200
Message-ID: <20260309190842.927634-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309190842.927634-1-vladimir.oltean@nxp.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3372f8-c14f-4131-41a5-08de7e0f647d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	zjLFwxdKpvUv2kCV+B4Ta874JN3TqoSW0YymbP7aZpPKyaBtpCndvwpOS+5l2j6T5aCnIkEgowGeEc9QY/2aDP0ltshY4o/3BafoGpRp8qhSATKQPnhpZBI+F/g6q9LreLAPzNoR0PhCT4Dmp0dtVdgw9Byqij6WNzZ3zFHwH2HR4+kZN5Mp1Le90e9PQGhUtSGoQLO67QSmB1ZD3cuMpUc4VpniN+22Ux/+dHpQZCMWz9lHgSUMl38ulqWExa3g/fUOw4kxsDn7qAy0XQjMq+pHU85F91eCEKtl63xiuySfhyjl038eNlOL7POrSxGp8yr0c3n32KyGjq6SobV3I1pH9zn/PAsLOuMrWAJ3G09tigZJF6foNKaRwhboxjjtaqJ/pHFNvyqxOQtRdSt/k7MNQ+osRJeZONOkNzPia8QLYhS6ynfk6KNgLbSC6VzFY24tW5rYPSnwQWOqXMLFT2f4ZSG5igBOYsRe9K9ZrxN0xZIayl24HlrPL8NrVhmNCZfPSWYmD3uyiB4HU1qyuBgQ0yaoX4fN1IlMDR+bd4REAPHwxyNzJc3I84vJ4a3GCKTCJZsmTUVfbgBjbyjnmGRDLDOR/g1Xc108JisW/n+lC6DVlUS+IBo2g71gB8T70AuwjAIdAHyVHaZ7pMlC3xJ9pCGXS+tY0ftu5DiOYDjZmM0xqwR+Bfcr71VXBT1TPyqHjeFQEXKtOPQb/aINnZPsuzRPuWuOEvXpFXcnj1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fkpA5UTPbZKIEBQIZQ7Ra4pv3sXRj+XFYMHOyC/jgXF7YTfn4ZuWVyvPph2D?=
 =?us-ascii?Q?GqxQ422/pv83bVN0mUINE/3AkgS/MiShr11ROx7s/iafhadqycZVWsmwBZVh?=
 =?us-ascii?Q?rNC+BeUOMkAWdqGp00KtyJDZDjZgAi7At0Dcklj0QpLwhT+rkyDvqCdf9gyj?=
 =?us-ascii?Q?YnIaua8Csch+EKOwPmIO4ruOqooixAiZ2e/AIdXopL0tiw0i7JbQXqflgrp+?=
 =?us-ascii?Q?3Gl9RbbZbch8fyvPpbI7VfEPHT1IHtmErZEOReawHdmVT3rMlcK3ZgaOs9Vv?=
 =?us-ascii?Q?VGqCcrnWK7HA9gFdhTUyOPRIDKJJRPUX/FVgjVpINrFkb9eB/4z7AS+z9aFU?=
 =?us-ascii?Q?LuMGt2NnPPbWpHBK0qUKjPCtdC7UWeuLRyT/4iZ5rAJyeeUCOJZcKa4ofZzx?=
 =?us-ascii?Q?9bG9VjNPIU2VfatZKRkzB0Xk/v+MSbCU7W6wmW9ui8595+YQli99R1eaRF+S?=
 =?us-ascii?Q?0SzsB0cy+sLTGBya9RowEPGpOtDF+Tnf6tbBgbKjkVWuMtoXar+ENciPoXac?=
 =?us-ascii?Q?fjw38/iNykO6Z6h+TN9WdWgVXyLRZZuRFfK2UStsccFdmupUUWSrq59euJ/j?=
 =?us-ascii?Q?hS6ItMLGKqkFIHpZPicz45svE3UY/CvsgZO6s8gKfv1u0olqCCgtHOHX2Q2V?=
 =?us-ascii?Q?50e0oBpZ/LjAUmjptB9cv45DQa5ab6vHboC2AQxGXUdFmGHNe+NvgpIhkO17?=
 =?us-ascii?Q?GIbQAUr/fzFXv62Xi5N7X1SvYeNrEKu4McQ0T4VSSIpiBNCrqkZ+VEkvMUC8?=
 =?us-ascii?Q?y5WeayJiKK4RsRkYbi6Tjnyj988Oze793Nr524bWFr1AgsjrTdD7Pn1hqNEa?=
 =?us-ascii?Q?7zfZcGPcMjVnCnMczX9Ps8j0vz4fuo1f39FFdxiaVFiQwpJlCX78hQSlMB7H?=
 =?us-ascii?Q?cIOpSVj6nqfh5ieEbsEHG+2STE8gzG5PA0AIPuNashnFSyZ+5rePCjP1JbW1?=
 =?us-ascii?Q?TNv73zBTZcuGFA6t5yUkb0OPWC2sRwPi3Q+P6MHqtNKbA1vUllgAvJSOloIr?=
 =?us-ascii?Q?LwtnU4bvkqul23abrRTWkn+trckKHwIaQcrtScIoi49oD3C2wv37p46wJZ/O?=
 =?us-ascii?Q?S5hm60IoYhw+gWr6iCsmh2kGOQ6neexElooAhjKrNVglXdksLvUSJZG/HpxT?=
 =?us-ascii?Q?JXL5pI/2MScvoPL/KN/jhztMv7yrkSuj6qr11sIgkXxB6H81Ohb9Ko0p0YFm?=
 =?us-ascii?Q?sP/OI/jpQ0FI8+74rE7mxY+pmEk1dDW57jhKe9Agwv77EQSnQBjf8/c9OtLe?=
 =?us-ascii?Q?AxgCTHkMLF7nnbn4QLlysAx2BLRe29T+WXlGFB8mMXIGrHhNJSwyQ9rot1n1?=
 =?us-ascii?Q?U7hBlT1XkVa7Mhrjb+KljDlLGGnYYgHp8vnVXZYbyNG+1uWob6qgxCN/fz1C?=
 =?us-ascii?Q?lK60RXQ6vSI8p7GMWhy9ScdTQoMOQlgKC8PeZ7je6zuahqalPgtk9W/TPRVe?=
 =?us-ascii?Q?g8f/64aCQZX0CsU9rOIVyfeFTbmbjL1fBBJJG02lohQgKt91J4HjOdbuNCJW?=
 =?us-ascii?Q?xM1P6KNM32wEkbFLlkV1lO7Oza1eouVZNHKlurh7bH3vFYSQo9WMA3c/NlbA?=
 =?us-ascii?Q?Exm2GLLZAEV+Rf2hyA+x2WuApcqpuABaqE/yQ6YQWYKYbQPtiYAOMYlzMJ+/?=
 =?us-ascii?Q?jfTsBXEz3LFTssro/ObJmupFSlcqhnR4Ea9kxFnris2kyZ5qKcaSabLEeOkt?=
 =?us-ascii?Q?P4rEwbHIRvkyVaR2LPUfxh4UIu+irF+Pd+WOFs9jBjO2hqqDUhwkltoHvx4c?=
 =?us-ascii?Q?vEpYVg7xCMm09WKScqt0YhC7TW3e/RzzWvbJ1nARFR5+Fqrsnk/rr3oZCvnG?=
X-MS-Exchange-AntiSpam-MessageData-1: ozJ7YurQHJ2xVFDnzEievCuLCpxf+IZ/uy4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3372f8-c14f-4131-41a5-08de7e0f647d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:09:31.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFlP+K1vbwulkKtylNzvdFFNFdKYg8HksIZLI3po2uiGLmAe4MbZk0boHnaWk8uHnYx1A76Byp71A2o5rLxvvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Rspamd-Queue-Id: 2C97423F753
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,oss.qualcomm.com,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7040-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[poorly.run:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,ffwll.ch:email,somainline.org:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,qualcomm.com:email]
X-Rspamd-Action: no action

These do not provide much value, and will become hard to maintain once
the Generic PHY framework starts hiding the contents of struct phy from
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v1->v3: collect tag
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ef298c7d3e5e..cba8a71a2561 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1928,9 +1928,6 @@ void msm_dp_ctrl_phy_init(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -1943,8 +1940,6 @@ void msm_dp_ctrl_phy_exit(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_phy_reset(ctrl);
 	phy_exit(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
@@ -1996,8 +1991,6 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl)
 	phy_exit(phy);
 	phy_init(phy);
 
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 	return 0;
 }
 
@@ -2588,9 +2581,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
-
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2606,13 +2596,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	DRM_DEBUG_DP("Before, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
-
 	phy_power_off(phy);
-
-	DRM_DEBUG_DP("After, phy=%p init_count=%d power_on=%d\n",
-		phy, phy->init_count, phy->power_count);
 }
 
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
@@ -2638,8 +2622,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
 	phy_power_off(phy);
-	drm_dbg_dp(ctrl->drm_dev, "phy=%p init=%d power_on=%d\n",
-			phy, phy->init_count, phy->power_count);
 }
 
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
-- 
2.43.0


