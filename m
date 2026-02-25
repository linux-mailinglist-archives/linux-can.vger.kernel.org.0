Return-Path: <linux-can+bounces-6620-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AXDUDT7fnmmHXgQAu9opvQ
	(envelope-from <linux-can+bounces-6620-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:38:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADF196A0B
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A85304CCD8
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D81395250;
	Wed, 25 Feb 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OvzbUD7o";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OvzbUD7o"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023120.outbound.protection.outlook.com [40.107.159.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCB39449E;
	Wed, 25 Feb 2026 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.120
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019291; cv=fail; b=MP3h1foK5jY+ByEJAoRyUprq+3EGRRdTknZ3q42Z6GNGgix/5ez9q1oqUVvtlIn2bFvnU9liSk2NGhkywooyf9pcc0p/GzJ38b/aSVFkOgiaz31oFdHOcQ6ItZNDManW6DBlJeQLG3klV9DH7246fbWPdPaHXPykzJhkZ2hQHls=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019291; c=relaxed/simple;
	bh=NH/F6cA1bl3x+p9UkCvzOJtSfdhUOzL7JrneRbTD0xc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=fixeZt18MjFK0PimNrWRRU1tDZ3jEisALjn8n7YQiBrgb8LG/sjYhREvHgYiWGlpuNyqpyHNbaTfEuUg0vfa0eoGXjDA84HVTWUUVStIUL+ugDjnbh7T9TuFKCa+eMJPPQF/3Z7QPONthwIEQJVXlpbUiaTRLUofCfPmvwXebbQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OvzbUD7o; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OvzbUD7o; arc=fail smtp.client-ip=40.107.159.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Y+o70TpVZ1bg3EpSAXYPd5xa3Y+42/W1+nsxb7WVFvt2Dofhbs9l/9zooqNUQ8q3iaOc97DS5Edlnb1R3pb7L5EsKB+0MndfGCrWpAZZenAdN7PHbZn0Y8qor7T7CFEJhRME/4pOR5gqglP98YPEmemIH6YQT2ot060RwopLg4PtkBlELGdQ1D4/BmYwTjA1MtMg/kW57ITZVj+5pz6nId6uieVVq5mUPG9cZ3itqXQ4qEyPhY11UrejAm4YbCQ1/FKTgvhZ8a08BMlj+odPbxsMjy47jvMUpzcUyGWAitr/J4x61rGbuMK/wJI5f7stl1LtpHDR1+v0rGxFPMOuEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1Ao3U72Vxf9hqC1E0QwmRN492plGmYPPOCFOrrcAJw=;
 b=wGRhWg02xeWhbiDVrKJlHYRRDMYTTKOxyrdg4EcLCTEpGKcmfZmwch6RaO9hz7QRevEhm4j5vUZyYJAIoY92jnqnMVNwpI/suiCUDlAaHJrcEfT9XIyjOdpwGq96WBn86GNCgiXOtG06aTaLqKWq3eUz6DkXGgWVFRZeKHu04rsiDIOiSx+mGUJVEFH1y7MeHzZBcy4lVHSdLGvSmcXQovKXQ7V8/n3P3QdwRJtPI3xaNLU1Tr2Alord2Kzvf2DihZnAIkosQsfHd3Cv989cFDGo7Jf5WAeZKjH3JUCODRCszDQvl0pC0J2kkgDpMfSxYxJo18/qXWfd59YqYSFpCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1Ao3U72Vxf9hqC1E0QwmRN492plGmYPPOCFOrrcAJw=;
 b=OvzbUD7oyzXUOOQhmgPlfOrbnJfgSPyLoP5eo/9jjGuNPyTQ60Hu37BclsYNO/WgOUirjZ1LgVHUrzbVEH3EcW3fegEGfXfqCwboGVYVlgzbbEt+yqp+CiQBRWpe0HqbxOARSRd33XGq744mx23Hcg5jY/+JqoLsggT20R0u5V8=
Received: from AS4P191CA0054.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::12)
 by GV1PR04MB10379.eurprd04.prod.outlook.com (2603:10a6:150:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 11:34:40 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::23) by AS4P191CA0054.outlook.office365.com
 (2603:10a6:20b:657::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 11:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:40 +0000
Received: from emails-8729467-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id C121D8005D;
	Wed, 25 Feb 2026 11:34:39 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:33 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysAO0C6Pu6go5mTos0974CfK/aXRVX9gAlwHLOFrbPx0sUYHUx2Cd84e3gqGyZr1Zsbk6M9CIBGKbPUhfAPf+q6IUbEvmu4VSjtpxjpZtybpyiqzVNa4vby479YwyZuZmgFCY272yYZRSGMA1H8MFV1LeidVbDg/fwdvx+l6PXRBoJeeWP19VFtDh46g47lAkZyku/Mldz15CKc5nnZLpwSWj90IA92lJ9Xc2xhdcOwZZvem46x8jIVQzA815L/cSMhTbj8c9hpMLsoKpS8CykR0F7pYtfGqNU54XXpSVTSX0AqHu1pKyEhYOX7gBzCCmI5v/4NPFShyCUr8qTsRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1Ao3U72Vxf9hqC1E0QwmRN492plGmYPPOCFOrrcAJw=;
 b=U6Tl5D8df50NsMKdwN6w2JvAugnx0SXLjSOsoiM6UH3+EKiyySINHY7wMo4IPkG6KoyieDAv5/EhmXq8MzXEM2eRDXNHK850Q+3fAEaLbePC/68hZ+fQseJsmWaKnPlUP57lGMKBhiwHU3oUc21XTCpUa+211Y7CX71TbWm0JtAqUX75camRNU2xTulYtRaFRqIGHtuQKPCiAC7BLXIYQ/1pnSs8FEk+eB+xLDVrOX44gi+5BDe0V9zBvnSclKheADO2/ueIFER/b5s6KAOxgce4ihV9fgHB6ruBBn1txmnEIsRK/9Lam4ROrPtyGAMB53d2y6NpS3TZpZOxVtEbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1Ao3U72Vxf9hqC1E0QwmRN492plGmYPPOCFOrrcAJw=;
 b=OvzbUD7oyzXUOOQhmgPlfOrbnJfgSPyLoP5eo/9jjGuNPyTQ60Hu37BclsYNO/WgOUirjZ1LgVHUrzbVEH3EcW3fegEGfXfqCwboGVYVlgzbbEt+yqp+CiQBRWpe0HqbxOARSRd33XGq744mx23Hcg5jY/+JqoLsggT20R0u5V8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:28 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:28 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v10 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Date: Wed, 25 Feb 2026 13:34:14 +0200
Message-Id: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbenmkC/23QTU7DMBAF4KtUXmM0M47tCSvugVj4L9QSbaqER
 oUqd8ephJoGL2ek772xr2JMQ06jeNldxZCmPOb+WAaEp50Ie3f8SDLHshAEpBGJ5fAjx5h7eTh
 fpAtBo7IdGmRRxGlIXb7c4t7ey7zP41c/fN/SJ1y29ZwJJUhMMSnkiAa617H/zFEO5+Nz6A9iy
 Zro7gnw0VPxPnjN6JljtDWvVh7h0avigzPE0WsTDdR88+cNIGzub4pvozNg0HXsQs3rlceN18W
 roGxitmRY1bxZedq83yyenVOtJtsS17xd+02/Xe6n5L2JDmJX9Xz3BOrRc/FATXINaDYq1Xy79
 pv+dul3yidUoRz37//nef4F++EnWqsCAAA=
X-Change-ID: 20251128-rz-sdio-mux-acc5137f1618
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
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7267:EE_|AMS1EPF0000004B:EE_|GV1PR04MB10379:EE_
X-MS-Office365-Filtering-Correlation-Id: 56aa58d5-d4c3-44e6-85ea-08de7461dd02
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 GDLSOuASsWsoufP6nUhaP+MY6TNDlB/DUkdx+JLc7Bl8jTRbmd/e8Zdr5fh9uPDImXgVfB0Xx84w0dmX/h3bnALxXXiO8wEfM1mkylWbgP6wF68P5wCDw1q2fnuhs6gjDWGcWoClPBAeOMDtI9M39j5Pe/75PiWBVIEfpRxJvbAWny8b/3sgoegmlLY+i3BQFzZaY/KqfV43FYR/iVXZuCRjocRjm40mCxjHWscwW75Nd1Jj3Ywmo8pnxaPVXpSHx5EzobEdzlb+dp1P2TCvj/bBw29S4JFCqGMxWltgXiQn2LXgaMFEiugqtmZ/a9zHmL4HdJZ2M8flrPL/yKMXedkqfsNvTYiI8sOYnHblRe+UCC4RO4xO9z/9bNkk4bZEuw9PjHP9AlGlq4rQKoYLD0RUIHAx7y8VwV+2ykxEvSCd/JllWp+1EIAWHbHzGptgrh46g9HxSN435BWcJBh2Bq+iZ6QfCY3Mk5u9uqY9IQ0QYvdww2z7EqLxLbh29fm370WJBH2ph240b+KtDHHNUyxzGd684tBXKYhZrH2p/SJcBupz0M4MgColNJfj9YG1U3hDAlzu7dKiLPuZZBuQS+wwlZS5u5XvG8XaHGPORldmtNhx3Ca7KR/Z5slhsAR2mWWCOGf+VHbPLKMUZTG9LMAI/bBchcWRqi/lbUt9GgEtvP8e9QQYojt1NaihjedNWaHdfhVQa3InCjDmoReyOZj/yjOTsGDKB7TFKrmqpRwkrpDssFFugwDTn6i777iHGVuNVhn58n8ZwafkpuKXFipmaDILpSq+Bm9rnc4Q12fpBcB+UDn1g4yqz/W86SPI
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3be6daa101714469b90f6e7424606240:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1c1fceeb-014e-410e-1ed8-08de7461d60f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|14060799003|35042699022|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	wB4yAFiEPFIkrPF4DbcRiUjZ9gskRLLORXNcn8Ppr74Cjh1OLKM/xC5I439QPzTbVcrIZX/aCgI346SvN9gJiBLAfNe8IJnoquHNiy4E/Ohcw2Bjak9ONz/jhj8dtt+tx+1iUc0ZrIvG0FkUYjv7MPTOsNDvBKR4MLvxWIFAqU4rL3SZyWCa/PBzuAuBB43AddajF1X2jlF8A+sgXlAoBUDvd2sEPZ/liXKQyPbIAi1sP8y7U9r+UPigacnh6yqqShD0S4+J81p3JoJd9iYOXfbKcFDWI3iJixe8ZR7Cdo8xBb5RyCY/Ut18HMsa2t3Ak+bPPh0gELUsVk4Cbzy9LoAblEe8G8HgujVNr/+p3gLdqG+9P583fjETXOebsWslifEMuxCIV6qgZ+EOAcQlAXcafIJfX3XCL7Ykj+4BCKkEVhX4zoO64o07ygTDuS3q28sMCxnsmaS0eSKx7K4UE8xXvERdhbvyNuo+Wfsi/pTOtxiQLs8V9g3650umPpLAO1Bqf7a6JMSrmcvY1F44B5u3Y6X9pzVf7oGUSQ1U0p52AVPi4YlMnUpw7l67Z6ThfDAjxmT4T2qE2rRHNst+funE2wT8Gj8LJ57GmqmyK9ykfGu+NMTRm0c/0J3R63C1DDLjTDIGt4BADww7apikHpJnR2ZPfCJG+2QccXXkSoOe+4oDAilcBbSBFzrrAhmcBpO59Am/Cym2P5ax0/yueau+LumAt3GKL/X3PEzdKu9wX6p1WQGY60TDukeKMcRJLJyQ/s/v0QKQ3tZrZHvNAQx9fcoecACHPyhc7a8j5UKRTByJw26MdP9D0sDyOVeefc5xMB1YqXWTCOokciTIFeKtuMBsboU4pQKzSGEhKW4=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(14060799003)(35042699022)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qTVHmVZ8GO8hXTeMCv2ld4Sz4l9LQKn0OC6yTC6vW5WKYzB/1Kn7beVFr7S6i56uE5yGTisJCzEUWSwvPnGtdTsSl8Te13mTiJeE9la5dqDiZxkA37pcKjVF3Fy2f62t4g0e9XmMPpX8xJe473zPryWZV3jxrIKdMyXaz9aa9ZRU05icgK/T2l9OgpUICRcuY/v4iPlin+Q3itMKzoNA/beYiE1ookLJxMmyxd9y8Kn1cnoMHf/2aYWdvQ4pomM3dAUtFyBbo4DaoLE6laZwO9MWBrv/vMkZfzRP3DVq6YBGU/MgWo3tnn1GkSAevHYUQdk0WmkT7Wt+sXo9lEZ96xv2P0DmcWA84/TG8a6oXsrZ+LTo8rBi4ZUH8rQlKGq9+u4duXyz3Of6nueez+nXUe3xK0WDsZGSTwjtMvW7wK6yjm5hrC2K4K6jo76PHJlR
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:40.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aa58d5-d4c3-44e6-85ea-08de7461dd02
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10379
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6620-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,intel.com:email,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,sang-engineering.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BFADF196A0B
X-Rspamd-Action: no action

This series has evolved over time from adding generic mux support for
renesas sdhi driver, to partial rewrite of the mux framework.

Several drivers have started implementing driver-local managed and
unmanaged helper functions for getting and selecting a mux-state object.

mmc maintainers have requested that new code shall intreoduce and use
generic helper functions that can be shared by all drivers, avoiding
code duplication.

This series is structured in 5 parts, each of which is self-sufficient
depending only on the previous patches. This shall allow the first N
patches to be applied even if the last ones need further discussion.

1. Rename driver-local helper functions to avoid name collision with
   global version to be introduced later.

2. Implement generic device-managed helper functions in mux core.

3. Convert driver local code from similar patterns to use the newly
   added global helpers.

4. Change mux-core Kconfig so that it can be enabled through menuconfig,
   without an explicit "select" dependency from other drivers.

5. add dt bindings and driver support for mux in renesas sdhi driver.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v10:
- added renesas-sdhi Kconfig dependency for MULTIPLEXER, avoiding build
  errors in case setting SDHI=y and MULTIPLEXER=m is attempted.
  Trailers were dropped on this patch to encourage fresh review.
- renamed phy-can-transceiver driver-local helper function to be
  consistent with other driver-local functions, and dropped all trailers
  for this particular patch.
- reconsidered the Kconfig changes due to inputs from mux core author
- handle newly-added mux usage in rcar-gen3-usb2 introduced with
  v7.0-rc1
- streamline patch sequence
- rebase on v7.0-rc1
- Link to v9: https://lore.kernel.org/r/20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com

Changes in v9:
- compile-tested on x86 with MULTIPLEXER=m/y/unset.
- fixed Kconfig changes so that CONFIG_MULTIPLEXER can be selected.
  through menuconfig / .config as intended.
- updated trailers
- document null return value for mux_control_get_optional.
- fix build error for CONFIG_MULTIPLEXER=m, found with x86_64
  allmodconfig: replaced ifdef ... with if IS_ENABLED(...).
  (Reported-by: Mark Brown <broonie@kernel.org>)
- Link to v8: https://lore.kernel.org/r/20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com

Changes in v8:
- Add defensive null checks for all non-optional calls to internal
  mux_get function.
- Document NULL return value on applicable functions.
- Avoid IS_ERR_OR_NULL and ERR_PTR(0) to disarm smatch errors.
- Link to v7: https://lore.kernel.org/r/20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com

Changes in v7:
- picked up reviewed-tags
- fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
  and enable it by default when COMPILE_TEST is set.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- fix another kernel build robot warning: undocumented C struct member
- Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com

Changes in v6:
- replaced /* with /** for devm_mux_state_state function description.
- collected review tags.
- fixed checkpatch warnings (space-before-tab, void-return).
  (Reported-by: Geert Uytterhoeven)
- fixed use-after-free in mux core mux_get function.
  (Reported-by: Geert Uytterhoeven)
- fix mux helper error path uninitialised return code variable.
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com

Changes in v5:
- implemented automatic mux deselect for devm_*_selected.
  (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
- because of semantic changes I dropped reviewed and acks from omap-i2c
  patch (Andreas Kemnade / Wolfram Sang).
- fix invalid return value in void function for mux helper stubs
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com

Changes in v4:
- added MULTIPLEXER Kconfig help text.
- removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
  not required for all devices using this driver.
- added stubs for all symbols exported by mux core.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- refactored mux core logic to silence ENOENT errors only on optional
  code paths, keeping error printing unchanged otherwise.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- picked up various reviewed- and acked-by tags
- Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com

Changes in v3:
- updated omap-i2c and phy-can-transceiver to use new helpers.
- created generic helper functions for getting managed optional mux-state.
  (Reported-by: Rob Herring <robh@kernel.org>)
- picked up binding ack by Rob Herring.
- replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
  commit descriptions.
  (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
- Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com

Changes in v2:
- dropped mux-controller node from dt binding example
  (Reported-by: Conor Dooley <conor@kernel.org>
   Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com

---
Josua Mayer (9):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      phy: renesas: rcar-gen3-usb2: rename local mux helper to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      phy: can-transceiver: drop temporary helper getting optional mux-state
      phy: renesas: rcar-gen3-usb2: drop helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mux: add prompt and help text to CONFIG_MULTIPLEXER making it visible
      mmc: host: renesas_sdhi_core: support selecting an optional mux

 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 drivers/i2c/busses/i2c-omap.c                      |  24 +--
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mux/Kconfig                                |   9 +-
 drivers/mux/core.c                                 | 206 +++++++++++++++++----
 drivers/phy/phy-can-transceiver.c                  |  10 -
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  30 +--
 include/linux/mux/consumer.h                       | 108 ++++++++++-
 9 files changed, 307 insertions(+), 93 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251128-rz-sdio-mux-acc5137f1618

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


