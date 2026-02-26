Return-Path: <linux-can+bounces-6641-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J9VB9lJoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6641-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:25:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9361A6793
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 809DF310EB5D
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBBE3314DD;
	Thu, 26 Feb 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OPUaX2lb";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OPUaX2lb"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023091.outbound.protection.outlook.com [40.107.162.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83133031B;
	Thu, 26 Feb 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.91
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112110; cv=fail; b=HKgPcmEbG1g5w3lCj5LY+uAxESpkvovJr1uD39SKPMjyFurJ5107iOTdhogo/mweO4M06o65AWbnDfQz5RB1UEJLN9ztpecorl/EwMgnx8ohL+/JU9NkWJPbv1u19asShUZxdUlaXPDd5wCJNzpv2zKDaGNeARwEX/e+WejCk9I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112110; c=relaxed/simple;
	bh=WNahgq41sjHUvt5Fm8xV6HvQCJS7BTOFOdiRQJkc7Y4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lFK2L6dGwvLWUllyAB743bBkRgvix1ddXqVThZ2/tQkJgUJrxjBzXH8NQFRwyqQ3O3oVPoosDpDIiykJXfHxCZk3W1btiabDaBvvVyBzbLzyngtvkgWD5gPIQqv0kautopq43E4AgZfWNgnY1YSDSmPFfgRDie+Ovz1j92/FwSw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OPUaX2lb; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OPUaX2lb; arc=fail smtp.client-ip=40.107.162.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H+QxAcW4FjenoXH9x3oFc11q0lBDcFpnL0knEVTpxE6IhyEO0ah+vd0Z3ZSe9ip4+46tQzod0OhHddMMzo+txDjQk6lz4KQmXNcgpv4J7htTcfhDW5lE2t0FKASTnilBuE3nzqrWbVd3bBn/ogH6bjZq0B7g0VqINyPptgxgWRR6Y0XH+LJZyt8c7THdrs+wnFV5XXosGTLljIV0okvWBjGIOCKe67KpJBVoAWv+KS9gctL1cVR/I2Nxqi7MdQMDiFRxFCzk//Tn65V4nP8jsuD6uDaehdkYrk/DBrAEHASt3IXujvJaA9k6qJO8UgBr37hD3qiZP+mOhnjigkgHxw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBhpOZlLMH31RJV23FcdM33Ikc1i5kv+cHH6w5o2H4c=;
 b=oZgXoCjbGFAZr9nB7AsLDTpW/m+TVhPO9EN93CP8lQndWL/qwJ4DyB+YNJhPzUgXNBqCx5Tz1btsWoEBwqpCH9LHs7+hKmbEqrU3j+wKN3oN8TlBPhkZTtNo7bxPhdz4jyfFhPQ9rdpqLPmsLJ5QUnnJ378+nF3pxQBfBAIuvzhqSdHZFnEYDVXTHxYBxkOPk0SSVG0z4WEp8bCf0IilTN7wwCl3Yy0Xy61AmId0OXQBw1qnb/gcC9bbXD2v/zg88BFr3y1pm70cnisoDs5P1JzLVMl0DC0IhR4+fFrJOS4XE9X5mzOujjJDbd+z+jjfj4nAYUOCTj50UKzL9R8qXw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBhpOZlLMH31RJV23FcdM33Ikc1i5kv+cHH6w5o2H4c=;
 b=OPUaX2lblHGwEhVJBX9L7hTv9hD7kMGaHj3xemnB5WIQ4lmiNZj1NZWcpr6g1IN/9hcb5q5VQz0EVjxH/rzgfGxRvKFu8KOsCDk9SFJl5/Bz0lrzrzQ5BgNB2QDNXLHHwPqRkWCww78Yk6TBvOACkEBB7TX4qqaWORw+KO+JOEw=
Received: from AS4P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::6)
 by VI1PR04MB9764.eurprd04.prod.outlook.com (2603:10a6:800:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:21:43 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::f8) by AS4P191CA0021.outlook.office365.com
 (2603:10a6:20b:5d9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 13:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:43 +0000
Received: from emails-5168409-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 335018073F;
	Thu, 26 Feb 2026 13:21:43 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:33 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wk/izH+hz36TgHQvcWMdw6lYFCM6yavEHGV81wbCPuZNfY/Nk2j/9DVDPJGImexW4cRmgEOMF8apOl/P+mnD0TaAAowk1siagPGt4BmpakGWBUWwwANu+Vmvb2cfVD1dqfEScME+aqQbplyF5yw1FKQoZHFo5+4941kHNQ7RCMZjQ3YA1QNxLTOR508T7rVMKZkZ4lBYZyS+0RtJC8s/PUb2SIq6YSA+NPIY5uss9wgvYBKAMTfq1m6sfSLY6odezHDTjBUnbnLr6sjshlLSLcWjUR7wNtCZjyWj9fWFwkg7eaCqfIg8AUtcrC9awFbkYjQXEwmziHIKzDzDFPOrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBhpOZlLMH31RJV23FcdM33Ikc1i5kv+cHH6w5o2H4c=;
 b=nTPhFtfOGFA+WaRBwvRbzFPUlXwG2P69d1J+6LMeJoQHn9RSvIQAL4O1dnoGN5GIDradKf/qBwC61Da8c4ri7lGio0oAE7k8wOjkitpds39PXiMhREmO0XOGks1dUwlnHLNQ+J6C5MmueM9AWN+xwBcBJ6Rr+ehMOS1HPj1yv7h1u0L+9gX/peR8unfiXQgjI91Uks2R0ejO8iSbSfN9BJNaiUlhAhCzmQ2WJZvG6OdN5CdaBhUhOL1MQSQVP1iSlldLaK/TAB3rSTZiU8839plnZ/Xk6YSS+aoIRFncNfoPZPceZQRa2KtEsBOh5Fp4xM3fyw0aCiyMpRKZj3XozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBhpOZlLMH31RJV23FcdM33Ikc1i5kv+cHH6w5o2H4c=;
 b=OPUaX2lblHGwEhVJBX9L7hTv9hD7kMGaHj3xemnB5WIQ4lmiNZj1NZWcpr6g1IN/9hcb5q5VQz0EVjxH/rzgfGxRvKFu8KOsCDk9SFJl5/Bz0lrzrzQ5BgNB2QDNXLHHwPqRkWCww78Yk6TBvOACkEBB7TX4qqaWORw+KO+JOEw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:21:29 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:28 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:11 +0200
Subject: [PATCH v11 3/9] mux: Add helper functions for getting optional and
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-3-c2a350f9bbd3@solid-run.com>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
In-Reply-To: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR04MB8747:EE_|GVXPR04MB10450:EE_|AMS0EPF000001B6:EE_|VI1PR04MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad469ac-550f-4048-b888-08de7539fc0b
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 7pqfs3Ab/C75/ijsVxJPj3wjfIBz8vH4ewpyVWRtnIeGBHr2/ojmzhZgXcy4oAkyy4s7E7Vk2OixUt0Tigb8jzycMV93eTyuJ3TFzt0pUCofmCvQirnSkgTABfNII3F+9/YevhZ8mW/59pMbn6G5MjgBCGle1xSqayakssLiyY1EtUs6EzKcpqMuOaT+IYANm4GWrHTqPjlg8Psy7X5ZFCbvN2nmH07Wxr1khdhBXxHym0B320qmgJLNulftCv87LDahmc9FtZmdyiNsFCnoPsW87ZOixXn0c/Vbs6vEwB76VEdaCJYgk7WpnkUPnL4VJ20SRlHgZ6HV1NR9MtI4PoLJu3gBKDc3J6Xh2sGw/d9y6zmFuqQNbPb18xtb6xyt0rSmP0CWsz8lapMrfFxKEt7RFq6uygBmLifS3CclytcZvur+nJD157tQZ5vACtR3yztdrx9FlKXjE7RsEAe0lIcVE+nmPnuw5rswPfVnfpV1R0c3srF3tL39o331A+yULqApyLwKPNUV7LcuhgAJ+7m6dvBUAoCNppY3pWqTjIUUUQudoajIcoDjbP2OH4q6m2LsONUMhlbbFTiRLe4KAB540RrCjucpP6TsOENipSjeh/BCl9x++eGpUc9q3bhNITtE0ENVIoHHEV8LRPAwbbbeJWealVNq6/sT5hEWFU5k/crEg3MC5mlO2p1EgO3YT2zCiT0O11LPuIwd7f1LQ2PQCNnUOse+5Az5XZ2SggnfAl+0IJvem+omatgMUw8UvXABYSx9ioazhycG/a+8vimc00AygOC8xjLGhGni5EUfDC/7uf3wYkJAaqCflrJH
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 842d7217e9da41c2ae9dfcf3b94008c8:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	10bef525-08bc-4a69-726f-08de7539f338
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|14060799003|36860700013|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	cCvnOTc+LjMeFcpOnznO4c70j+fNPlLJ0J68LM3fKUCjNRRSlNXfE6SDeibFKgSUAttRStbBo9QpJ1xSG0R4IIVjjpfZ6sl6MS6ocicRnRWA+dfB/UtabAwyLQZLmc2mKTQs/EVoQ7rXUlamOS5BQ5PAt8dpku35xgBAK0W99MraHwHs6Rl1x4Xa9mxc9imvvqVP3A8N6ccZBu6gBp559BAZPgOzxE5q+SWO/xQj103UDGFsWdQaM0GeqmTxthUn3RczR+/7WnBnjo1qdKhf8AUzc2r1MQzsZvMicwS9mypSRH5nhu8TbTiu1ZCTI/T9wdLBjRH0Dk87Hc8M+TwwPYR4MIxWloD039swIi8WMy6+suIXVXpwXMdL12J1QPfHy7J+kG8Zr5Qcnx9cTEADbF6wIDABhplJ7vtflDXwZqc0VkL/fIv4p0yMC3EGlJLuG4UYio29Z+Yj+FYa01YErUR3ZtQxGKp3oqKU1J2FeMAXytsU90YdPOdfGlqNk1RxDF4gzNx6v/MGIYDtv8FgnvWoiQ4gaZ6qfDLgsLdQZEd2GM9I6kMVSh2QF6h4WdWjU0KjrdCj3cQFOC8komxMshIEZZ28FuPI83joPWh77f2UNhuy8z5paB7JKjQmMN4E7LkBQkutlu/1FDSCaQtyRdONLCfKYTvKGNHpI1A9zAbzzlsEDXU9Pm8r837aTx9aSyHsg7/XlzA8MwXXYb9WdcrXN6JIFNeHxPj5mqCgq6b+MDz7CGMypqm0uq2lh6zRJIszITAy/cfig0pjjldyRFoSS0nC9nvu2Ru+/XrAUeWZTsprt1QLRsHbtbdBuUUYO85c72vr15YxG36fy9LPrYJ7dq8hzAKYrnAA/YebQI4=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(14060799003)(36860700013)(35042699022)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hFvRlElS61ixtKVEc/MgwEUIBYcrpZcuNFcPbZMdfHLspyHAodwcAqeulMsg/1g6cqVYseXrmvIoPK6FkAkkfBeDqfcs4mt0oLP43uKboHlLguYjlc8C1t79muOQv6QBeBJPxv5PmhUP/cCmU2Mv6Q8iRYYr5rmwWo45FqK7kHQzZVYd5hD1aw1iLAkSZ6V/xmfVd6QeqhyEanJQkHxYPjsxGHMCWqSeWNWi1WG1SbU+FG4MoXImSI82xNf4getlJ/X9UYi4/u0VaMDGQabmDAfVXrf1tFKvmyFWZd43UNPci2iyWKRCmtn20OGRsMuspbGMcdYuSRbqAnmNcIXy20VHPsO1h8KV7z+kG6uE5NiH9RLi2wRHzyr5VY8lcmE6Kul/UY4U8VYTYqcYFXMpivrmvH36wAPWw/9eKLhXqhkIkrUJGmOz8KOdpHzLOFpG
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:43.4621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad469ac-550f-4048-b888-08de7539fc0b
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6641-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9B9361A6793
X-Rspamd-Action: no action

In-tree phy-can-transceiver and phy_rcar_gen3_usb2 have already
implemented local versions of devm_mux_state_get_optional.

The omap-i2c driver gets and selects an optional mux in its probe
function without using any helper.

Add new helper functions covering both aforementioned use-cases:

- mux_control_get_optional:
  Get a mux-control if specified in dt, return NULL otherwise.
- devm_mux_state_get_optional:
  Get a mux-state if specified in dt, return NULL otherwise.
- devm_mux_state_get_selected:
  Get and select a mux-state specified in dt, return error otherwise.
- devm_mux_state_get_optional_selected:
  Get and select a mux-state if specified in dt, return error or NULL.

Existing mux_get helper function is changed to take an extra argument
indicating whether the mux is optional.
In this case no error is printed, and NULL returned in case of ENOENT.

Calling code is adapted to handle NULL return case, and to pass optional
argument as required.

To support automatic deselect for _selected helper, a new structure is
created storing an exit pointer similar to clock core which is called on
release.

To facilitate code sharing between optional/mandatory/selected helpers,
a new internal helper function is added to handle quiet (optional) and
verbose (mandatory) errors, as well as storing the correct callback for
devm release: __devm_mux_state_get

Due to this structure devm_mux_state_get_*_selected can no longer print
a useful error message when select fails. Instead callers should print
errors where needed.

Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
property presence check") noted that "mux_get() always prints an error
message in case of an error, including when the property is not present,
confusing the user."

The first error message covers the case that a mux name is not matched
in dt. The second error message is based on of_parse_phandle_with_args
return value.

In optional case no error is printed and NULL is returned.
This ensures that the new helper functions will not confuse the user
either.

With the addition of optional helper functions it became clear that
drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
Add stubs for all symbols exported by mux core.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/core.c           | 194 +++++++++++++++++++++++++++++++++++++------
 include/linux/mux/consumer.h | 108 +++++++++++++++++++++++-
 2 files changed, 271 insertions(+), 31 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index f09ee8782e3d..23538de2c91b 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -46,6 +46,16 @@ static const struct class mux_class = {
 	.name = "mux",
 };
 
+/**
+ * struct devm_mux_state_state -	Tracks managed resources for mux-state objects.
+ * @mstate:				Pointer to a mux state.
+ * @exit:				An optional callback to execute before free.
+ */
+struct devm_mux_state_state {
+	struct mux_state *mstate;
+	int (*exit)(struct mux_state *mstate);
+};
+
 static DEFINE_IDA(mux_ida);
 
 static int __init mux_init(void)
@@ -516,17 +526,19 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 	return dev ? to_mux_chip(dev) : NULL;
 }
 
-/*
+/**
  * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
- * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ * Return: Pointer to the mux-control on success, an ERR_PTR with a negative
+ * errno on error, or NULL if optional is true and mux doesn't exist.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   unsigned int *state, bool optional)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -542,7 +554,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 		else
 			index = of_property_match_string(np, "mux-control-names",
 							 mux_name);
-		if (index < 0) {
+		if (index < 0 && optional) {
+			return NULL;
+		} else if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
 			return ERR_PTR(index);
@@ -558,8 +572,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 						 "mux-controls", "#mux-control-cells",
 						 index, &args);
 	if (ret) {
+		if (optional && ret == -ENOENT)
+			return NULL;
+
 		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
-			np, state ? "state" : "control", mux_name ?: "", index);
+			np, state ? "state" : "control",
+			mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -617,10 +635,29 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	struct mux_control *mux = mux_get(dev, mux_name, NULL, false);
+
+	if (!mux)
+		return ERR_PTR(-ENOENT);
+
+	return mux;
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
+/**
+ * mux_control_get_optional() - Get the optional mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control on success, an ERR_PTR with a negative
+ * errno on error, or NULL if mux doesn't exist.
+ */
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_optional);
+
 /**
  * mux_control_put() - Put away the mux-control for good.
  * @mux: The mux-control to put away.
@@ -670,14 +707,16 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
-/*
+/**
  * mux_state_get() - Get the mux-state for a device.
  * @dev: The device that needs a mux-state.
  * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
- * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative
+ * errno on error, or NULL if optional is true and mux doesn't exist.
  */
-static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
 {
 	struct mux_state *mstate;
 
@@ -685,12 +724,15 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	mstate->mux = mux_get(dev, mux_name, &mstate->state, optional);
 	if (IS_ERR(mstate->mux)) {
 		int err = PTR_ERR(mstate->mux);
 
 		kfree(mstate);
 		return ERR_PTR(err);
+	} else if (!mstate->mux) {
+		kfree(mstate);
+		return optional ? NULL : ERR_PTR(-ENOENT);
 	}
 
 	return mstate;
@@ -710,9 +752,66 @@ static void mux_state_put(struct mux_state *mstate)
 
 static void devm_mux_state_release(struct device *dev, void *res)
 {
-	struct mux_state *mstate = *(struct mux_state **)res;
+	struct devm_mux_state_state *devm_state = res;
+
+	if (devm_state->exit)
+		devm_state->exit(devm_state->mstate);
+
+	mux_state_put(devm_state->mstate);
+}
+
+/**
+ * __devm_mux_state_get() - Get the optional mux-state for a device,
+ *			    with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
+ * @init: Optional function pointer for mux-state object initialisation.
+ * @exit: Optional function pointer for mux-state object cleanup on release.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative
+ * errno on error, or NULL if optional is true and mux doesn't exist.
+ */
+static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
+					      bool optional,
+					      int (*init)(struct mux_state *mstate),
+					      int (*exit)(struct mux_state *mstate))
+{
+	struct devm_mux_state_state *devm_state;
+	struct mux_state *mstate;
+	int ret;
+
+	mstate = mux_state_get(dev, mux_name, optional);
+	if (IS_ERR(mstate))
+		return ERR_CAST(mstate);
+	else if (optional && !mstate)
+		return NULL;
+	else if (!mstate)
+		return ERR_PTR(-ENOENT);
+
+	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
+	if (!devm_state) {
+		ret = -ENOMEM;
+		goto err_devres_alloc;
+	}
+
+	if (init) {
+		ret = init(mstate);
+		if (ret)
+			goto err_mux_state_init;
+	}
+
+	devm_state->mstate = mstate;
+	devm_state->exit = exit;
+	devres_add(dev, devm_state);
 
+	return mstate;
+
+err_mux_state_init:
+	devres_free(devm_state);
+err_devres_alloc:
 	mux_state_put(mstate);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -722,28 +821,69 @@ static void devm_mux_state_release(struct device *dev, void *res)
  * @mux_name: The name identifying the mux-control.
  *
  * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
  */
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name)
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
 {
-	struct mux_state **ptr, *mstate;
-
-	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	return __devm_mux_state_get(dev, mux_name, false, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get);
 
-	mstate = mux_state_get(dev, mux_name);
-	if (IS_ERR(mstate)) {
-		devres_free(ptr);
-		return mstate;
-	}
+/**
+ * devm_mux_state_get_optional() - Get the optional mux-state for a device,
+ *				   with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative
+ * errno on error, or NULL if mux doesn't exist.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional);
 
-	*ptr = mstate;
-	devres_add(dev, ptr);
+/**
+ * devm_mux_state_get_selected() - Get the mux-state for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_selected);
 
-	return mstate;
+/**
+ * devm_mux_state_get_optional_selected() - Get the optional mux-state for
+ *					    a device, with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative
+ * errno on error, or NULL if mux doesn't exist.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+						       const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, mux_state_select, mux_state_deselect);
 }
-EXPORT_SYMBOL_GPL(devm_mux_state_get);
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional_selected);
 
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..a961861a503b 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,8 @@ struct device;
 struct mux_control;
 struct mux_state;
 
+#if IS_ENABLED(CONFIG_MULTIPLEXER)
+
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
@@ -54,11 +56,109 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name);
+struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev, const char *mux_name);
+
+#else
+
+static inline unsigned int mux_control_states(struct mux_control *mux)
+{
+	return 0;
+}
+static inline int __must_check mux_control_select_delay(struct mux_control *mux,
+							unsigned int state, unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
+						      unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
+							    unsigned int state,
+							    unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+							  unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_try_select(struct mux_control *mux,
+						      unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mux_control_deselect(struct mux_control *mux)
+{
+	return -EOPNOTSUPP;
+}
+static inline int mux_state_deselect(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_control *mux_control_get_optional(struct device *dev,
+							   const char *mux_name)
+{
+	return NULL;
+}
+static inline void mux_control_put(struct mux_control *mux) {}
+
+static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
+							    const char *mux_name)
+{
+	return NULL;
+}
+static inline struct mux_state *devm_mux_state_get_selected(struct device *dev,
+							    const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+								     const char *mux_name)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MULTIPLEXER */
 
 #endif /* _LINUX_MUX_CONSUMER_H */

-- 
2.43.0


