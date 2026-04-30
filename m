Return-Path: <linux-can+bounces-7433-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pt4GLE482mFygEAu9opvQ
	(envelope-from <linux-can+bounces-7433-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:10:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A14A17DF
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6150306B436
	for <lists+linux-can@lfdr.de>; Thu, 30 Apr 2026 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812740242C;
	Thu, 30 Apr 2026 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NV+ZLUUC"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84440149B;
	Thu, 30 Apr 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547233; cv=fail; b=KNneyGviQaAVevBxiraeOEKuoM945dwccZBWviY5Jkp67UHLBNz32KaJBI/OiNXj+MAduwhHFXJrcLIhHW4eFjOX3eO3ZAJ8yiOgIXNlo4rI6b3JRbd67+4beRamGOepZ8QQ8Rt392qNOJedhnJHC7oMTVYe5mRqkpnvB4EICAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547233; c=relaxed/simple;
	bh=k0C1j+DQJzxFH7SaopKyGEGu5kcfzfnVBOtfSGnWRHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvtVuI8c6ft43+f9tMR3tLVZ8wfwyDtZxeeAT20IAT/ovIisaCgk1vXu1llSe4AGN6IOc4FzIx82U/cs6wmK7CUOyI/aDbPabGDI8Nfqz/Dwq+x3alcfPze+BmTw6Gf96cHBrnzJiE+tbTDQslhyHG+DLAq/JL84ANmwDK1IQ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NV+ZLUUC; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJekoIrAcrLF6ET6OcFOMyRw8VPfat/pGOMiXgMaOIIP/VPWHY3Be1Cf6jBD5WydWaPogTv1HQMtY0j+TRpgkBHjifFAOk89gcqhn33UtZG4qXRoJU9GyfSztBKU8fBS/1oKSJlexapZfAQSzNYoCZjRUctNiecNt4VqxFrnRQQ0BBDPVKQJ3r4NR6pcdmmyx6g/aVRDbfDz4fL/WaV9QetRVYsoL5BtknC1VfjexNAEreNlI8LVsE/79wIfdCf1hNoLaS8gb0jti9YDXQtKutwH9l9rcgcFUhR8Ddf2NeMPM1h8uuVY0babotRYTt7O4Gpi+kI9kD/q9IQAc/Gcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNLEJGWxX6e+dGbNOhEPAlvL7+uQ57E1dxRG4xUtslc=;
 b=ELLmhl5OfPvR7VUjvyrmRLdHu+xAKZPncnTaOcp3o3+21FX8Ngeue4bAEVS0otxJgsT65QC3iOyyf6ejJnM6Df/UGV5QEJ5v0iI0wZEJU3cEMdkEZhjqK8w6Wolo2JLgBZsrIaMBjwrPLdvvIdDjAyiCmCj+t991jA+mumQdlh+uvUcOtfMhOKWYoCd6j2kB5eBLMo3qW8kIwA7NGvN6UbjpCMZd2n2e0pw1iIw/7R9vg/hTcyGw6Go5IWm7CEwRl4lJyzNRe/XZ1c5aSfQ4gQqX6aAHd5Cta98dCYXVRWNQVTrjT4YSQ4n8WlND37/ukMvuBAvYXy6xzANQ0UkXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNLEJGWxX6e+dGbNOhEPAlvL7+uQ57E1dxRG4xUtslc=;
 b=NV+ZLUUCtMs6+1j1Ph1zr/fmePgdq5/LWaSpxPCUVYMBg3vvDnHaThuVHgyVjUwrbadJr7LO64fqMYz9kiHqbT7Rl/uPEbYZI74eOEiIWDiPp3PziQn+xVCL1T8Sxez62xyFEljsu/Gv9Fmd+s/gYkGdrQrWE2RfucYE4Okkwrd0sHpyggkV/5oMde57UVVFgPkCqvBKyytSYfjZ5N4GMglkoQ3iXweb5Rkw1i0EIOI1AKSP4soEdS1URdwwr3SS6xrdz+NxLP/uLuUg+p0zkq5LpcSR2TNYotVEsVBpBQyoZT5LWLYbQ/ktPINcCMrSDe2TvFteSJ8LMs4Gqud5Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10609.eurprd04.prod.outlook.com (2603:10a6:150:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:07:03 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:07:03 +0000
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
Subject: [PATCH v7 phy-next 04/27] drm: add <linux/pm_runtime.h> where missing
Date: Thu, 30 Apr 2026 14:06:29 +0300
Message-Id: <20260430110652.558622-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430110652.558622-1-vladimir.oltean@nxp.com>
References: <20260430110652.558622-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0013.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 04631762-bb47-404c-f8eb-08dea6a89ba1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 1f+K5cwFxnxjwojTMCO+VKEFG7mXm4bLfgYrD6IdnIfiC2I6w7lGcvgyc2Hxp0l0Ftbk6Y0m7eXUM9Te1540eVu+4B3YL1kYDE/kjciqTNoKin5EVRwF7H2LLvCoZtAJQLlfkkkfMXrbuI+0HDHjSkqkeU75g28vq0CcYzq667YisfcDroZTNEvf/oUEbzt4mVpmizpRmDTe8CrxnzL/HCpQwdzLzxFjlOE7wWvnGGcsHG3PGA+KxWI1b3o0z8m0EqsKjg3h5jd0ghxPEM+C6OZdxfIMyG+4J1MCGe7AusC8QjlOSRu6nMpmvUPNKXo8sht6TdWEb9hUk3Xa5bGGzp2t8cugPJSosWoYHD/v84sf2kmq8wGHJlUe9GP2QVGc56T2X8T0M0mJvKjaFJy7KSWm3lvWIQS8PNxPIrenLTwUqxuD0K5R71EyZGSIN3WX5Yb3Bx4XdVO1ULmuwU6LmUzDckPg4/72TVZyXwvY7Xx52kvUFSlmkM+KuqjlrBcQbVTyGuP7rG6sn95Y3qHSjX9ZCzKhe6zctW2hUa2GhdZY90jIv764Sq8HY1CZwNYUwHBcHBJjwDoMs/KdswmXwxe6yl3zSdIagK9yV1/5ISyuZ4ftr+jF3VDRLn4L6b+RNrXdPn5lbQ41Fz2EKlv/N+aHoISyCm3cWHls3UwnbY0Cqp2c+xNe7909XEnQBrAZxoZG86GzktpZlcFk5cUVUF2Yfe7ohStnTkTXb3FngUE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?FBa5qrzGQ6lN7jNp8j9aFyc77MVbr4fLMXvIZYDYYLFauJKBs/zfKJjtN97v?=
 =?us-ascii?Q?BL7fj+Cae9GYrjuYz70ZQMU1xELMqFXIZFjQ75I/7jMVJs+byhrKLXTw+LUZ?=
 =?us-ascii?Q?CR/9yPqlHa/KU/6ahgmUaMJUs+1fUjlRtN4zmTbZX+QhsM0+gZAsC9ghXiMv?=
 =?us-ascii?Q?9Hul+fDxpBFvmXjSh+tA6FjByfQaZYb34h1ObedAV+sLdlrcdhkB3ZTlYPEv?=
 =?us-ascii?Q?cxMcFB0j1ott6BbUsmFyyR5NKOZM9sQZzHzP6PnPoZGYr1XZy5phURqc2+Xm?=
 =?us-ascii?Q?LxGJp4ZMJ9DKAiS4qvZm5KnAfBpYbUwf34fI2e5EpPTfOFtq4/hJCoF+x9zb?=
 =?us-ascii?Q?BnIvR2hrOnMH7w0Un1aSrF3z39uzcjdUjSg3xIuC4GkIbOvR1W8oSs6miHQN?=
 =?us-ascii?Q?Yn1D/U0P6HTbs5vfylZeDWewGopz6G2N4O5hJxV/RcH/dL9HYWwtYxQAJpwk?=
 =?us-ascii?Q?a7prlqEbZqJafuXfEV8VNjc6NLSsRKSas4DObwa594baGDORJyARJ2eUfTKx?=
 =?us-ascii?Q?vnqhoqv79wYIND3ARRAd2VbCLqBdG0FenlKCCa/2DUHaMVSBIXhAeZYO25yD?=
 =?us-ascii?Q?YZ/UWVBtp337/Llq5LrycD1xUO4uvknfwlEIfTmewvp8sRhsb+Wbk/+JK8UR?=
 =?us-ascii?Q?7GkmFrBTfAf5EzysPu/uuILMYS4NR2iRPWt61K7wF9oiIqk0XiA6rIvqHDG8?=
 =?us-ascii?Q?vOuT/O3xyaFm4Y8I5pqDAwUOe4IDK5WzPUQguTQaVHW6V6JCWfnq5L+ILWGI?=
 =?us-ascii?Q?VNxiTPu2K9WN14YbN3cEKIyHMERyIi0zHZfa2uMHrVvL8KPtCJ2PISps30Kk?=
 =?us-ascii?Q?vWo4jS1yfbow0Skm93KEOiZbr8l8mplwC3mh4nKEwEB3d0iASEdOj5mTcthy?=
 =?us-ascii?Q?DhjndBvgykoz1HotLb0YnhBiUAW4O6VIzSurLpoumD62YI3VSUciN2i/qlSk?=
 =?us-ascii?Q?Pe7RFs0zMOZqgATYC+0I/PtlGn67E+QSwGjvVL6Xu0wgSPPpwnyBhRC9I44u?=
 =?us-ascii?Q?J5ZSR+7UiTRD38yRdYhafkU9kgKVT73CxeGTLIVr1Dqbc++LagqKv0Mzr7Uq?=
 =?us-ascii?Q?vu5ymxNOndtSdzZPa8q9j2M1SRZZ+AmNGfb6FA/89Hk8wZUgmR1PdYWvzuFf?=
 =?us-ascii?Q?TMIRkwo54NtxZzaLj+akxkh8Yqc9roEjR6vaYurcytr8ySaVLodj5+xjvAmc?=
 =?us-ascii?Q?RUJNBsO+/5r5VjvrRv6+gdaz7mpGrc2+SEBWoX8SXrom0I/yfi2mM/dTJRnr?=
 =?us-ascii?Q?cZRs1iZwUsKXSY9xMWmyAICObTc2OBxjoWo08wxwj8uND2sqb0h+JA1Vu04B?=
 =?us-ascii?Q?d4IUK6iWjQhdhYB2GorQK7Q+OhApTmt0qO5A+S483M1zdCx0NZ1sJcB6CBaz?=
 =?us-ascii?Q?W9vS7ZiMnHqInO75oAuxkm8v/wtPm0jAVBEAPSOD6zpf9sBXTMv4dPhG3xhV?=
 =?us-ascii?Q?hNNyWG1gYjCfejiL7VmqlKG66iUmNimUw/mOHIl8oFwm6bdNQjTIIupwFFkm?=
 =?us-ascii?Q?IbFdxrbsDhN9gnBszeAB5Jttn8rlpz7C8tKup8oRMHgYameYf/fBXhb6m3Pa?=
 =?us-ascii?Q?sJhjOpR2sPeQLt9ZR1iFnQ8Kmp32cHzT8LvXAWEbqhyQZYwmBSq6gfWHmi/r?=
 =?us-ascii?Q?v+E7olxM9gn0qbVnFAbACj8BSg6Aa/vSchVbzWUoFAjbO74HWhfpTdTVXjhV?=
 =?us-ascii?Q?FSYSIPhHuqgPSQHIkApvI9NTLBUU+JVlZZ7pNBJpgc4yPYy9kqbPeyftGxi4?=
 =?us-ascii?Q?zfDqmQpgmqyL5oLGcsiVnXilxfUxugy5Qrtcw8XUUe2IxKZTV0ia?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04631762-bb47-404c-f8eb-08dea6a89ba1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:07:03.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGauJTpOEBOH7t4KgzwEPTsBrT/jBSnhoS8XYx8KLTk0tBU00S+bzxs657Sn/WPI3J1+Q/P32kxKlFIMDYbSnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10609
X-Rspamd-Queue-Id: 117A14A17DF
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
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,microchip.com,intel.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,samsung.com,amarulasolutions.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7433-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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

v1->v7: none
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


