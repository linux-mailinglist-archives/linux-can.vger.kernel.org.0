Return-Path: <linux-can+bounces-6345-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Le0J04iemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6345-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:50:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED01A3325
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06F2B308EB37
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AED3644BB;
	Wed, 28 Jan 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hQp0p/xm";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hQp0p/xm"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023090.outbound.protection.outlook.com [40.107.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2F3624B7;
	Wed, 28 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.90
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611604; cv=fail; b=DQegrv0ASby+IKa66xBi3hEssFbEBC/sCw/tG2oLgJP1xbuw/rWyFSsDrv8V67tWT/2yM5bN92+u7yJ+Mubwn2s3voOVpq94jnbfddg0IIDSPCFhwnbuF1OlnCToUt0bBh2pT4eNcruEirb3hUk5z5lJZGW4ZLzcHeRzS3axMNo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611604; c=relaxed/simple;
	bh=H+dxOlw7D+/ac+pzWaD9F9Ao/kAHfSrb2565gnhAQBo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dq78QRBAwHNbwauJS7RNdH/DbLHFCAKGTEeMDJWoIQt6rVDTtFt2GZ0A/yjULbXT4MSEaeleRTMjbpLZ+kHT6QasSmG8RtTHVF9Py5Bh0sFMsvnmfbh5JLsG5lEUomxa1ti+5kB5Cgc3VTW94VPG38MZL44KCtxO3OfBSaBvMpA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hQp0p/xm; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hQp0p/xm; arc=fail smtp.client-ip=40.107.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VIlytUkL7iX3E/dcz0kOo5FlIvwIbLmbQe2ckj2iPiISAXDwh91QL8gOIUIrmQik7aoHRwSuk3i4Yxkl2Ft3mkfs3peqzH54NIfOQIB9BJe8nER3JzOrIprvqGHwRiASGDcS/W1ApwuRcH39T4S9guJrpJt2AymGF8bdsZWA+9OCX2IY70OHqwOkQPSRTeyfj8w4lPj6llh0ix32bJutcCQLZK+4HgacSD0yeyoLmOVyoUVtTNkr92FDzpzdCI24HLBoU1ZqPhiyB2n6xxzgsVwJqgjylLkJrzqc2XNgwfsewRPHAyGH3QKJzif5Z45el48vvXvRdRJ9PJAtz719Tg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=maQukj3/wv/T2q/VTuEB7dPM4D9pPxLWOerNuQXCtW8C3YsoxAYBJzKXySLK6RgIitdE+ZjadthvjCfdDovy+AuOyM7ZgitGa0tA70crHAqMryWz60UmhO6ztVnvBEv0/WA/JyMf1Lx7mzY/JUl5cdyIU2vIe7luZx+Ro9mYbCsb1aIXS/VOIV7jz9NnL4upKZbsq5XBrfQDEBFCjtcjCkdYuq/Ap+NEv2Dh2MgMaUZ3rX3sUfNvzM978sezdvLQl6qy14xDocB0Dzs3JTBXJamF8ecHkgYVPvz30Z2tLfi9fjZHx7rxVwCKb95Qvq4/pUrsrlAcZmI1+yFPRr34dw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=hQp0p/xmZRKm/FV3ogxC9o/hw+aZDg9fQ1fZab8nvh+dhHDzdaVO9X9OKZW/epX7KIZVTebVpL1quZnSoEC+LBwbzobY69qvriLQHUK+n7VG9RpvqTb1yeMkF/Rh/FW6GeTjrSWo2lrOBfyQb3YuhYZg6FGlmnTlcuA0bE3v73Y=
Received: from DB9PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:10:1d9::15)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:46:38 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com (2603:10a6:10:1d9::4)
 by DB9PR02CA0010.outlook.office365.com (2603:10a6:10:1d9::15) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7
 via Frontend Transport; Wed, 28 Jan 2026 14:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:38 +0000
Received: from emails-8423908-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-51.eu-west-1.compute.internal [10.20.6.51])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id AB9DF80692;
	Wed, 28 Jan 2026 14:46:38 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611598; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=ALPlL6DHK1ihqz6ooKNrUVCIfSphnfVPa8Q8UPogCcFqOe2TUmfuSlf4s3PKUYOKCZFw7
 eIfy2oIUa0W5DVtHcg4MGtqh5xUUiE8jiVdaTZ7CombQGRbvmUQZ9i2CMsjOVTQz0NSXbOT
 0TMyJjBDjTbmcE0IRPtjU2B/As4w/ks=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611598;
 b=WXe7zO+/e+lOTN8rMIPV60+O4QajBa2cq7IFQO0Q8/EBAcqhhC9PZPqcUZOgqytrK1wzR
 pkAuagHGLJb+oRL0uNlfuV/DSvVRvxzcm73uAFWYWaND/DmillzUnpkrANuZjbVym4mWJ2s
 3XTwIup5Ybpl2V2e9q6rCtnvJDzajNI=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bENFzekFS+t743MUY5H5ygAA0ShrbFQJuZ71s7+PSzutR+73sDavSr82X1tcpKYa+pt2KsnE7Mb1t9t7+8yw6v+8lN416/osnJ1ypPUl/rW8GHi+o0cM2bEEm1YRsLD9Yhvo+79VHAgJBagnFYrQDEPY1ge1/5kEwkuYf822SMG+d5wJQYUoh71VSo4gI8KC/FjGpRxrflZNfG/ZR00RAsAJ0moKYPIlgMkH88jr9QYr5jpyeKKnijMIFyCRbJgxycQESa4d//MH5re8HPSD8cVXeT5hKLFWiFOgjY6+iFGN6f7ktnxCtXCAcKXE0gUfoPG+3qAZgzLmAsN2WEHrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=eCmY7CHmzyDOFHpJNJe0p8GeAaZFKhnYabC3hQK8q1W2CEv8s/38/8yBcUXlY3tCTjjfkwes5jwsE/Y2ilSiEuWpK+Vdnv7Q4NaHpVqK7OUOCRIlj6kZSXP4/+5Vl9eZE2hmttKuqairh7AfduJuIa+GRxpoPmTrr6/PfCR/9k9OPGiF0Q0BqHp7XzbESHlzI5c+/uCUNy1PhAvU3u7d3DRG2ngNhJzfmJMjiIzj3ao0ZYpyUoOFfUik5NMFKa2/3c4w1EsjSxNYDfPGb8/LiOkxKu9++8K746IWJ+creC35jQ9G+pftfioc/v5XpNk8CDs9Scw2U0eNzcn1Ml1wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rby9wyHlsPISYWVM8A3ug1fNuimNJisYbronpuurKUs=;
 b=hQp0p/xmZRKm/FV3ogxC9o/hw+aZDg9fQ1fZab8nvh+dhHDzdaVO9X9OKZW/epX7KIZVTebVpL1quZnSoEC+LBwbzobY69qvriLQHUK+n7VG9RpvqTb1yeMkF/Rh/FW6GeTjrSWo2lrOBfyQb3YuhYZg6FGlmnTlcuA0bE3v73Y=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:30 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:30 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:14 +0200
Subject: [PATCH v7 6/7] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-6-92ebb6da0df8@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7289:EE_|DB1PEPF000509F5:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 47af893f-1d13-4a5b-bac6-08de5e7c0b18
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Y3dKUDlWQ1JaMjVPQ2RyY0FyeXRlVUhsSjYyRGxETWx1TThsQlI4YTQyZFYr?=
 =?utf-8?B?aWYyRW5ZRTM4eXpjK0dnQXc1MDZEUEVheW5uaG5GUDVRYU1tNWRCYkplNW1C?=
 =?utf-8?B?TmNaekJiTmtJVkRkVVAvZEdhNUJqVkFMcHYyMGJkV1BScGlVKzY3VGhZRHRR?=
 =?utf-8?B?Qk9UNHFjNkRNTkd5N281WEQ0Tzg1d0VaUnJOSFdIZk96NklkRHVLUXMrbVVx?=
 =?utf-8?B?Z0dxcFJOaDZhcmswSGZuZWNkak1rbXdDVXE2YTh5SVRuVW1iQXlRditFSlZW?=
 =?utf-8?B?S3B5WGNMdjU5K1lHb20zbXJ2bEpLR3I5a3VFM1FzeWJkWTRmMGRCbW93MGZQ?=
 =?utf-8?B?eTNrUUd6QkhuNW9pQk9pRFpmS1FzUFN1cE9NbUhJWDFLa1lUME1hOUVreTdD?=
 =?utf-8?B?OFNWSkFxS2lDZWdBUFJTQ2tmU3hSWG01UHN0YlBRclBJcXJCMGlQNXBIbVNi?=
 =?utf-8?B?aWZ0Sm9BSkdCdUlqb2p5YWk4OURSMlJjM2lwN0hiQ3UwdmV0TElwaWNYcE84?=
 =?utf-8?B?Yjg2TG5JVWlONmIyR0pDYnFpV25sbk8xOFpwQW9EMGttdUVWWmpCWlhaSXBN?=
 =?utf-8?B?QnZnMlF5czE3L2gyZklFank1dFJBWlYzdU5aaTkwOVdJejF0VFFqbnZzTU9q?=
 =?utf-8?B?dm9tMklRZG9qdmMrNDhOWjZaZWtGd3o1Yk44T0pCRy95RFI1WTREbklKaE1q?=
 =?utf-8?B?UmU4dVliMDRBVGtSOCs5NUNQeU1FeWFJRlluazU3YWFCTTgyOVFyVVJzVjFM?=
 =?utf-8?B?SisrcFhESHRvajRvOXdyWlNiYXB0OERNalRSU1ZwTVVmUVR6bUlnU3RSc0JE?=
 =?utf-8?B?WldERnVOVUpLcXBDb3BkbU50T2trbnFCZ1U4dE1ybk14MkxQZWY2eFBSMlhS?=
 =?utf-8?B?Qi83UHFOZ1FyakxEaFhqTXVZZ3pzemozSnBaOFNwc0FaalpzS2Y2cUdzZFk0?=
 =?utf-8?B?ZFpnTkk2eEljZE5xalN5VTZxcGp0NjVJakFzaVZHWjBydTVLRGI4bzRNS3hP?=
 =?utf-8?B?TUNJNWtIMERGTHpjUnNHNC9lS3VOVDI0dEtyZTRWS09MZEhQOXJ1K1l6RnFX?=
 =?utf-8?B?YXFDSG5VcnA5NHdsUjB0OVZSTjB6MlVkZk1CYVQ0VjBJWVdCbTB1VG5LY3hn?=
 =?utf-8?B?Nks0Qm0ycC9Gb2w1QzdZcjNzRU91N0xwWEIrVy91cTNaMjB3eDlReXNaYUJ2?=
 =?utf-8?B?eWJmZGVZOE9QNVY1S1VRY2F6emdXQm81czlEK3RBUmhlSnJOYTZ6WSs5emxH?=
 =?utf-8?B?VG1vQ2lpRmZBOXpNNGloelNUMEppaFIwUXA1Z3JndGdWMTU4eFFEcFRXYmtr?=
 =?utf-8?B?RHNxbE5FdlNOaWNhVmtab1RkV0E2NTYvZGVzWm9EYXlSdmlaV3pnejFMZFdS?=
 =?utf-8?B?cStLNTU3QWk5ZVlQZnhnclE2Q1hhMVQwUE10M1RrT3RsZUZ0NjdGVk1CbkI5?=
 =?utf-8?B?T0xaRWFRazA5cWxSbmVLeWFlS0VKVVdmQ2c1c0JzQUZvaktiS3dnOTRBU3Jy?=
 =?utf-8?B?dkQ4WHhSMEpTOWoxZnYyc0ZUMU5wK1ByMnArZzhORFhNdTRKN2lCY082c21M?=
 =?utf-8?B?NUQyUmdKL3RUYWNUQlNocURuQUxoVWxuL21jNC9zL3Mvb3JWL3A1RG1oVG5y?=
 =?utf-8?B?YWlwT0ZtcXcvTm1wQXp3WVlzOWRuTC9IV3VKZlFGaVZYVHFzZzNWSlNXQkJp?=
 =?utf-8?B?MTJTME1xS0ZlVGtsclVCZHFJZHlHWHE0TFNBSGtiS3pnR1VyYW5NWUFtWk8v?=
 =?utf-8?B?cGc5MTZuS2J4SStDZkxkNnZzeXY5TC9QbHNDWk5Pc3hua25vTUhMQkxsOXJH?=
 =?utf-8?B?UTBjYUpKNnBQRHVHZW1kYmdZNW45bW53enIzYmVtckhoaUU5SDhEWFIxdDhQ?=
 =?utf-8?B?ckFsZVloVHdBQXhMUFFXWEQyUkh2c2M5T242VHN6ZUYxbXI5VXlncXVFQm10?=
 =?utf-8?B?NEVvMEpoRGwzZXRMeDBxTmVqUmtWOHJxRHlqUVptMnhSc1J3MEhhcXVnTXJk?=
 =?utf-8?B?ZlhRelNkK0lXVTBDSUNubFhLU09ZT3c5TDRJUStLTmp3Skl6K1JETHNTaEh4?=
 =?utf-8?B?SllxSUw3UDVXa3NrSytZQjlqSEdyanp5QXV3T0FvcG9VNWhUQmJRK3JXeDVQ?=
 =?utf-8?B?V01qUW1mQkRYUGo0K0xaejlHWi9VcEJLZGJFZ09wMWFuOWFVUTdCUHpmTGVw?=
 =?utf-8?Q?PGlPjCuDj09s0b/wyH6iukUIgrZpYdgnhEATw5TcRtGh?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b47bb3274a3043b4a58e7492042a5af5:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7a8e3e34-d2a8-4598-e73b-08de5e7c0628
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|82310400026|376014|7416014|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE5FekZyYllWcGl0VTlUb2hBNlIzbDIrRlpyeTFFbVQzMVh5bXdDMC9sM0xN?=
 =?utf-8?B?TXgzK3lLemVTV2dNTlNyNXFjN1hzbWhwVFVPMWZXclc0YWcraldUNG5vWENM?=
 =?utf-8?B?cWdYakVSSkFoL1RkSDVjbEliTHloRHhGQ3lxN1FrREVsRGtHM3R5MXhMeDFC?=
 =?utf-8?B?U1pIRUI5cGVIZTBqOHNIM3M1QndLdVFxbDJrNzdHOWxub05IeUdHQi80OTd3?=
 =?utf-8?B?Y0V0TXUrMmxLN1ZUYXFrbDZ1SS9TUHNPZ2VwOW92dHhRQXRIQkVDZnp4cEc2?=
 =?utf-8?B?YURJL29zSGdsYnZUTytyZnB2eFQrcC85MmlXckh6a1o5dVZsNnRuSjM0TUdH?=
 =?utf-8?B?VjBRbUk5NkRTcXRxS3doRE9yNVRDeCsrZTlXSXhGSnMyRnFuTzNEZkVlZkJ2?=
 =?utf-8?B?aHlZdllTTlV4Wkh1amRqckNLR3YzK2tOOEQ0OExNWGRXNlNtNmlyVGpsRTli?=
 =?utf-8?B?eG0xQ3JVK0dLSWlkM1BueHoxTGpnVzZpOGJ0SUpyalVPZ1Q2OThEZ0ltMitT?=
 =?utf-8?B?cS9YRUhYYUJmbE1RZnZieXI5ZURlTVR3ZytxSS9GaVRJT1cvM0NJQXpqYStD?=
 =?utf-8?B?N0hObW5tYnRUaFFXaDFKb0I0RWdHbDhxV0NlSExCYUNOM2Q2aDlRTFVrSzEy?=
 =?utf-8?B?QjFHYm5wL0RyemNIZmcwUm5Rc2lVVzdDMS9iMDdhR0RwaWNvVlNGeEd0RjRr?=
 =?utf-8?B?OXRISEwxVHNmd1A0SGVDN0taRWgyc0VxOG9SRU1HZTBjUWRpWHRHWTBtQ1pq?=
 =?utf-8?B?R2l0M1BEczBMbDJScmxVSGQyeG9CMTBURFNUTVNlRnB0b1B2L1k5ajZuZ0Mv?=
 =?utf-8?B?VTNYSmFEK2ZNa0V1Z3FOYXp0ckFLODROdUhsNTZqZkRuaWtzUkFpOHIwL3li?=
 =?utf-8?B?Qzh1UjRPclNNUUNWNkxLWkYzN0FXeGgzMWgzbVpGU21FU0hHLzZsVTFOS1VY?=
 =?utf-8?B?ZE4vQWpIbzVlSit5UVBNOEF0YVhXR3B6MVM4aWJ3U09BNDR6Uk9KVHk2dU9H?=
 =?utf-8?B?YUIrVUhkQUtJU1dvY3hjWTNBWGtDVEY1czZ3VjRwTUpucUVyZTUwM3BhSmlH?=
 =?utf-8?B?QzBpaXVOQ09ndmRtby8rWTJRd2RwdDI3NzB1QXJhTjVpSjlGQVNDcE5nVzV6?=
 =?utf-8?B?OU54OVJyU2ZWM0ZDdDlEbDJ5YWF1YlgwSjlrMTk3TlZtaWFCK01reEdjUDhG?=
 =?utf-8?B?SmJqRm0vQkMrSVlRemlvQmptT0tSeXN4V1ZsNTRwNys1THJMNXVtbWt3VmNq?=
 =?utf-8?B?MjZvd05oL0R4T1luNFBaaTUrSWFHQ25OTlN3SjRFNDZUSWEvSXoyNEprYXBh?=
 =?utf-8?B?RSs1aHV5V2ZySE80NUN5VC9DNFRxZHZzczVVS01SZEMreFBzL2NRRmdYeDBl?=
 =?utf-8?B?SDh1QkljYytXTTBjQjNCM0ErU2FaTmxNM3JLMEMySlpWVGdOSkJoa0t2TVFU?=
 =?utf-8?B?Q1d4Y1ExN2t4NUlzYzE5MVEvbWE2VGs5bWxZKzNhUEpMa0htT1VOdTRmTXFU?=
 =?utf-8?B?S2d6ck5MZHdZOGp6Q3hOTzY4Z3MwdERSd01qakZzdEkzOW1tc0RRTmZFVUtw?=
 =?utf-8?B?dWxNZmdNajBNaFRYVEY5WmhRU0wyUVl5Z0pLOFJDQ0xCNEcyQWdOR2sxTzd5?=
 =?utf-8?B?b3crb2lRUDE3QU42SlY0MW9JajhrQWtyTFBCS2pVa0ZjT1puQUdBeFBKcHY3?=
 =?utf-8?B?YU9wdEtmL1ZYM0o1M2Q4cldQU1FNQjNtelNBc1Vkd21ORlZOUGVDQjZ4SlFm?=
 =?utf-8?B?S3loS0JNKzRMbnRUc2s3anl0enlRb1ArVHpMMHpJbXl2Z015VlNFcWduYkNs?=
 =?utf-8?B?cHFPcVdmNWJCeDBCYm1SRkZrYkU1SkpyN3o1Ly9Tb1VjZG1ua3laWTRLKzBL?=
 =?utf-8?B?TDI2NDZ4REJVb1ZWY0R2WSszK0xSdGtDQlVnbWZNY2xUNCtuNmdmZ0RzajRm?=
 =?utf-8?B?UDA2MFBrR3Njb3lHaXRpODVIMHRBcm9ibkMwaytrM1dZYnVrMHBnQlJ5d3BP?=
 =?utf-8?B?ZmVMWFR2bWlvbTZtcWttSExrcmtNQjBBUTd5UFNEZGFwampYcTU2OW05bVo2?=
 =?utf-8?B?UDdpQWs5YTVTMWRHVTB4RTZsUzVCdXVyVTQ5MnVnYkl2dk9WKzJNR2N4V3FN?=
 =?utf-8?B?Yk9Bc3lXbGk3eENMRUtEL1Q1V3hoS1NpL2FmWDhtcUNZTTdoVnNwYTBtT0FL?=
 =?utf-8?B?NGFBMGZySWJyc25laDRWTFdmeE52UEtYRjVnUk5Zb093ZWFKa0VLYWc1Z2VJ?=
 =?utf-8?B?S3Z0Y1NlWWdiLzhOb1hTVFAvYlVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(82310400026)(376014)(7416014)(14060799003)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:38.7899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47af893f-1d13-4a5b-bac6-08de5e7c0b18
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6345-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ee120000:email,solidrn.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5ED01A3325
X-Rspamd-Action: no action

Add mux controller support for data or control lines that are muxed
between a host and multiple cards.

There are several devices supporting a choice of eMMC or SD on a single
board by both dip switch and gpio, e.g. Renesas RZ/G2L SMARC SoM and
SolidRun RZ/G2L SoM.

In-tree dts for the Renesas boards currently rely on preprocessor macros
and gpio hogs to describe the respective cards.

By adding mux-states property to sdhi controller description, boards can
correctly describe the mux that already exists in hardware - and drivers
can coordinate between mux selection and probing for cards.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index c754ea71f51f..64fac0d11329 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -106,6 +106,11 @@ properties:
   iommus:
     maxItems: 1
 
+  mux-states:
+    description:
+      mux controller node to route the SD/SDIO/eMMC signals from SoC to cards.
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
@@ -275,6 +280,7 @@ examples:
         max-frequency = <195000000>;
         power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
         resets = <&cpg 314>;
+        mux-states = <&mux 0>;
     };
 
     sdhi1: mmc@ee120000 {

-- 
2.43.0



