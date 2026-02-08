Return-Path: <linux-can+bounces-6503-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOEZBD+uiGlTuQQAu9opvQ
	(envelope-from <linux-can+bounces-6503-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59C109386
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D01930276BE
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14805365A02;
	Sun,  8 Feb 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="B9rxEI+4";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="B9rxEI+4"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021126.outbound.protection.outlook.com [52.101.70.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C1364EB1;
	Sun,  8 Feb 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.126
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565164; cv=fail; b=Y0CO2oRLwFV9SfI3EVOzN+hcFLQ4GpujLwhvcuqjQZ7xOd1Xjvbl4neQ97BcMsxJ9sw7HFIT7bNgZhTOTeWuarT5GhE9fz2KWFVdq68SK8DKCawIiZuXRJPxY3pS6fJ0VpTK3jqQmMn4AkyLwcWNGTMG1Dg277Iu//ZlyWT1x00=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565164; c=relaxed/simple;
	bh=F94ge6oQ5XCAW+SFTlVx96aQn8rIpCp6paJ5LwqlCGg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sag9zTYPa7N50bVHMN27CgyLRh8N80KTypI21S4/x9XqSTh586DCZP0WlLqel/Vs0MnvAtiUMgrsl2LhBYGZyBcyI2R+GN/TLPN1rewL0GDvREZJWSR48/6A0x4PAFjA+r3sKXkZ2l6EC2a4IohvAcTBw8Cp3/81hRgsQXuwzbw=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=B9rxEI+4; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=B9rxEI+4; arc=fail smtp.client-ip=52.101.70.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kKpC8vILt1CdAHhFOrVkYbOA87J8HU+wlrLCIluE1P0rYbSHlC+FkVi/Q04+Xkmc+6pFvf+V0iALKHsz2OEnJMrXsuXx6OvN/UAISRzO1UVRxxnAjk9odOFOzZFvhP7NVHKSODy8X1E3rHKsJotc3DKzdhnyjYZO9dPX0jxqCoaTY2fSb9CVh2WNdI4hC58XRFYWRspcYaZwVKdFPMFp/AuTNI66R2GuUfdKUea84ZqDn5p6CPVehVduocWl78o9LJWHUFY0b3hHN+8+rOtfm3050HOedtvobN4ENluJ6psxv2D6o3+hYsh8kV8r1JiQFKGolTZTnsjonBrxFd2Ayg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRd0mLNT0kbKVINMIOgGRUsaF96jvegTgLvB9fqbCsE=;
 b=j38KQ1zVogrA/S7yYo5glYdIsw/7hQBmINqbvSPtp/HD76BAiWjf7C4bsSpT0riig6/KdZ1QqLNSKLh2SlKjZGZT0iwn852m/6u/uYEnn09p1aTPeJFU7QcUbzJU/7NNVD4D+2YMBszGuUiYvSDN2UGiwhB0aEzQj8yb3SkZhP8lOnnMIzJYGWMM5OlG38aJCdHzBnak9Qnbo2TXU4z29jciVPGd554abSk14aK/3RsZSN3+YQsRUBGFBNHtwLpBboHVxvEgDMieVHWolflxtA39elFCUNwpWazJw4ZtnO57n0+gajJB5LEyF4N0igJzxp8bu1jEFBAZzdJfB9npdQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRd0mLNT0kbKVINMIOgGRUsaF96jvegTgLvB9fqbCsE=;
 b=B9rxEI+4w7p5lwYtHAnk6oqnIyS7Qz4Z2xeiNheeISo7kP7sYh5fxRULE/wmf6hk3KtHCuW9KkFTdD1K3JfbCrYcbveBHZ88Qk4VqCwORTSX0dj+4Yiu9wNiNqKuhAl5rxghVfaHZDNqrwCPwOoi7u35wLePSoVJZfKXQk2qT9I=
Received: from DB3PR06CA0030.eurprd06.prod.outlook.com (2603:10a6:8:1::43) by
 PAWPR04MB11706.eurprd04.prod.outlook.com (2603:10a6:102:50f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Sun, 8 Feb
 2026 15:39:20 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::83) by DB3PR06CA0030.outlook.office365.com
 (2603:10a6:8:1::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:20 +0000
Received: from emails-1780131-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-212.eu-west-1.compute.internal [10.20.6.212])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 025DD80064;
	Sun,  8 Feb 2026 15:39:20 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565159; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=NRd0mLNT0kbKVINMIOgGRUsaF96jvegTgLvB9fqbCsE=;
 b=bfWnDHFOAyzlS2ESAG2RGhtvTgGZLOpsPQ0GE/SXdK3wHnpspwfOIaaarfjzjO00ql/a0
 HSnYjOK+2VNvjUWkJZGI5iiNTz7CHVe1ISZnJ7Wo1YwhCvxq8EulAcMi9GB7nO32yqa1o8B
 tmzslsilQGto3kPyXMs9acMknD3SpcA=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565159;
 b=WEnuoP8G5FlBeVQcweYKZMFQRD6eTYT1Gg4srDxlX5hpDe9lkRwvcIimbUQlc7dIv0zqs
 TfgV23vLsc1m2QJD40xQldo6EsYp/9kVm1KCNMQuRRLtxqlZYGLwX0fR9HnE++/6aQDY1wM
 449ZgbIK5OkqV8CIPIKKlbdluy+doiM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MODQcFae0Qyc/fILZFwwJD1Jt1juFAbhQKZmQRiNVOYIYCadEF5bzQONYLXgKNvmw9h1ge2Xclrgom803f6GKumYWIGQwptvdzcRbBCBTVZVozQbasoeX+ggS3K9q/jAEqoRWGsmJvpn6eXfxywHqlSKzL6tud0cR/6tPsFAcStQmGnabf7w8wEZeXmeswJMMAjMxjJ4B1RtRSGkQ8/I0MYrg+d4k6vcbkBeYHs/b450LnB4V7HUxklYFyp1aKnWRUyf+KSaEn08fDo1ECdsgHCSd9vocftiUqtzrVBDHManbySjgz+u3bX7Ck9XxUhpNNatlprc6ovj8xHV9UINIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRd0mLNT0kbKVINMIOgGRUsaF96jvegTgLvB9fqbCsE=;
 b=smzRBFehfOkIwYTr3wusP1q8ZtNohrPSnMk3N76yDdkceZyy0kORnaDBIgd5chiOZyyeh9WPjUMcnkBzsrAcGAzs8fgw5HHegZRj83hiRgKR/D1o/edNtd0ybHo0/ycV8DDri9+d+ucri90kUvbpTwR8LVqrAIS3rh45KqtRr3l/kRNY1Rdi295gdRt/nWU9bApo+yBC1ayqVNJPnwQmpMXSwi72eslkuXTgQyYfc+YGa2tsKuehyfxGoNAip+26ODa9cuU6HzrpZ6cYJNnbRXPoq4XVSpXwonMtxoMeKXb6fcXlsOg8UdBC/tkpoixdX/BqGrlv+ZdmcgZSfkDKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRd0mLNT0kbKVINMIOgGRUsaF96jvegTgLvB9fqbCsE=;
 b=B9rxEI+4w7p5lwYtHAnk6oqnIyS7Qz4Z2xeiNheeISo7kP7sYh5fxRULE/wmf6hk3KtHCuW9KkFTdD1K3JfbCrYcbveBHZ88Qk4VqCwORTSX0dj+4Yiu9wNiNqKuhAl5rxghVfaHZDNqrwCPwOoi7u35wLePSoVJZfKXQk2qT9I=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:05 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:05 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Date: Sun, 08 Feb 2026 17:38:55 +0200
Message-Id: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+uiGkC/23PwU7DMAwG4FeZcibIdhrH5cR7IA5pkrJIbEUtq
 wbT3p10ElpX5fhb+n7bFzWlMadJvewuakxznvJwLKF92qmw98ePpHMsWRGQRSTR46+eYh704XT
 WPgSLxvXIKKqIrzH1+Xxre3sveZ+n72H8uZXPuEzrPTNq0JhiMigRGfrXafjMUY+n43MYDmrpm
 unuCfDRU/Fd6KxgJxKjq3mz8giP3hQfPJPEznJkqPnm3zMgbO5vim+jZ2D0vfhQ83blceNt8SY
 Yl0QcsZia55Wnzf+8ePHetJZcS1Lzbu03+91yP6Wu4+gh9lUvd09gHr0UD9Qk34AVNmnrr9frH
 +rW1p1qAgAA
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
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|DB1PEPF000509F4:EE_|PAWPR04MB11706:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cd5586-2303-4629-1e61-08de672839ea
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eWtuaHVpNG9wOTVab0VlNVp3b3NRcXRndnE5T0tQVmhDMzFXbzRydCtNTkc3?=
 =?utf-8?B?eHkxYUZBRkloRmsyUFc3Qjh4aDhOd1grTXZmME03M0lRNmM1UUZ0OEpLQk92?=
 =?utf-8?B?WUd2OTdhWW9FdFlzWEpyU0hOM2Z1UmxUdzEyTTJleGxpY0ZDY2hPNTN0QXB4?=
 =?utf-8?B?MW1qSlF2dHdTakxXelVLcGNNU1FBZ1IrQTFTU2xYMFhNZDJpME10YnUxNUJT?=
 =?utf-8?B?d2VNUjlLb0pDQlpYdGZlZWZJSGpGSjAxajJYcjlmZEVsWVhtcEhSQlVYbzFM?=
 =?utf-8?B?US9NV3htSHdCL3NEajZWZ2dlS2Q2bndEeEtMOFh2SStaTWdIcHZMbGNabUxr?=
 =?utf-8?B?WXViM3dvR2doYWd0UnFhRUN5dUh6eWdZT25ZQ3VacjB3akwxV3JyRUNNYXV2?=
 =?utf-8?B?b3VTakxvZHFHL0RSYVRXZFUycHFKNm51cFJKYndPU201dmNIaFlndnFLN2ds?=
 =?utf-8?B?NUFmY1o2dUFhRE56MXF5KzhYS3o1Wk52ZE93dG1NS3ovWEwrTzFocWFSUjlI?=
 =?utf-8?B?RHdXemFVcVhxdlJKYmlEK1VmNGxIWjYrQWpqM3owcE43NDR5TTRka3d0K3BM?=
 =?utf-8?B?K2JYWDUyQVV5bFVJeUdsK2dkNGNpUkdrLyt0RGpkUk0ybVdSbStLOUhPc01P?=
 =?utf-8?B?cEhIR3d6Mkdlb3d5WDJBSXV6aVZPQW5WUzk2SThUOHFMc1UrREM0cm44N2k4?=
 =?utf-8?B?NXNnaHFhZzFZUWd2VjZ5VUtJOGVmOWoyVmhLMkdHQ3NuZ284UXBpME9ERnlZ?=
 =?utf-8?B?WitGcnVLQjM5bUlJQUV2R2lIQkJpYVQzOStvTk51VnRXWHJ6MnAyekNaRWlU?=
 =?utf-8?B?U3U0N0NnKzJ1NjBGcDcxYmlxWXNjNWNuSTR6alcvaHpFaUd5dzViZWJESWJT?=
 =?utf-8?B?MnBSVU1rSW5mWnNnOFQ4SlpSTURmWHFwRW5SR284NTBteDVyZEE0TnM4R3dB?=
 =?utf-8?B?dHNVZE9NbkoxNi9JbzFKdHRsQVNlOVhPZEV4ZGVGRDBrNGZyU3hzYzk0cFMx?=
 =?utf-8?B?QWlzSHh3Z2dwdFh0QkduS2NtT3N0UFYyZXhTcjNmNnd0c21vWXRBcWxiWTE4?=
 =?utf-8?B?b0FsRWFXN2tZMjI2V2V3Y1FuclFKa3ZsT25UYndqL0tRSEkrQTUwbmxqVDU3?=
 =?utf-8?B?alJOREVOZ0U3dXQ0MS9vVUlKRGZ4dGZuamc4SVlTbDJ4TUJ0QytZUVRBdlVB?=
 =?utf-8?B?ZDJrODhRL1ZBNnE3cm5xNXhBWlZKWDdiWFRsdjNxSE9IWitVM0dpMWs0ZGRJ?=
 =?utf-8?B?a0RDQmliaVl0UDJ5NFBpYTZQdTNOUWxuVWFwcWZtYmYxRVF0TXhSNTJRZXdy?=
 =?utf-8?B?b0VqVFpVWWVHc3RwUVc1Skk1akEyQWV3bXZqN3ZSclRGOHNZci9HcWJLMklz?=
 =?utf-8?B?M0RhY2g2U2YxSXBVQmd5d3g4RnBFdXprblkwNmhqK3BsaC9ralQ4QU1MWXZG?=
 =?utf-8?B?NkE5Zng0MmtRM2VLVVBnM1pGOVRKbnY1cjhlMmp5VVFscWgyZFRwbHJtUmtu?=
 =?utf-8?B?M0hhb2ZNcWVNay82OG96RFRNd3pENk9mbmRyaDZ0ajF0WVkrUjRma1BQaC8v?=
 =?utf-8?B?UkdmTHJrbVNjOFgwVzlERm9JNzRVMU9YZEIrY3pHQXFBcmNtZUVaOUhQcjAx?=
 =?utf-8?B?N0ZQZDIrcGZDbFpuV3ZUR2h2Rm1nSWd2dTREcTVscUZ0TitmeS90UDZQeVBO?=
 =?utf-8?B?aUY4QlVaMDYwbm1tcHg1RzcyTFQwRSt2THhXam5RbVNlaUlia21MMlVtUDBZ?=
 =?utf-8?B?cUo5a2d3NHJNMUpodFgzRzRGdGcvVmxOVk56d0p6TlY0c0NZdEpuYy9uMEhU?=
 =?utf-8?B?QnE1QmdDS2lXTW1STkVJV0ZEK081aVJCOHhNZlF4c1FnQ2ZDTHgyWmhJOFJo?=
 =?utf-8?B?OHduRHRrTXp6UlpiQmhLOVg3V1lxREdKdkVBRy9yUHY2dkxzU3JRTjVrTjN4?=
 =?utf-8?B?bjE5ZTNRVFo0NHNLUmdmbG5CbDRwV3A4azc1WTRSeE9hMmoxVUZzZERtZWt2?=
 =?utf-8?B?dWpUY1pBSlZiTW5MMnQ2QVg0aE9RMTNrY1ZtL29KbkxzaDNUaHg1NE93WWw3?=
 =?utf-8?B?M3REY0pYUXgzNzQ1eW5CVXoxVkZPR0tXNExhUldKY2xNdHUremFUcUgzTGd0?=
 =?utf-8?B?N1RLRXplNk56UTErOUxOQTYwdC93RVhLMmIwWFJCbmN3REZxNC8wNHp2cE1L?=
 =?utf-8?Q?wnH/tf1D/TWNSlOyCWVyqIKp+waQmUHt2IPRhPVfkcqJ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 7cf13f8a57b24897b67962170000d6e9:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	552ae5de-580a-473f-b9c9-08de672830d1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|35042699022|82310400026|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkQwVzVId1RMU0M3b3QzMHpGTHJrK0kxWldDVGE2Zkx1MytTaGZJNXdHRGcr?=
 =?utf-8?B?REw4b0FwUkVHeDRNQnpiOHNPNjBvRWQyOG1yeDhVdm1KNE5BZzAvcTV0MHd0?=
 =?utf-8?B?SVE0cVpvSENKSEQyMjVMdHZreGRkYTdLYU0rWGlWY2tVR0RMZEdGejcyTGdx?=
 =?utf-8?B?WEJoRWFLLzA0N29abVhGZFZsYm9HbXljb3RVNkY4RWpyRkhSOUJCY3o1RVhw?=
 =?utf-8?B?QzRUVCt6SUtibUlpUTdBNkc1Z1JDSTdQR2ZvZjZyUnVkQTNBOGVCRGRDYy9M?=
 =?utf-8?B?UzV3SldqVlp4KytydURDZ2pzclhjYlFjbWlrZ3dOR0lYVTBjSWE4K3ZLNkU1?=
 =?utf-8?B?dlJGWDQ1czloVlgvZGorcUw4cm40RHF6QndpZkRkUC83alNEU3Qvc0drVjZM?=
 =?utf-8?B?OEMrTnU5SmZUTUVpOVpSdDloS1ZwK0kvb2d6bzE0aTNGaUdSMUhkYzFqQVVE?=
 =?utf-8?B?OGtYeWF3ejNqQXI0MjkxOCtmemRwV1BwVUxvOHNEa2VGQ2hLb3RQbHhydUJP?=
 =?utf-8?B?bi9VSUpvSE02Yms5OVdETzZiMXZJczQ2bVdBMWR1dWhZYisxajdYdDFsR0R3?=
 =?utf-8?B?b1ZsVFNMei8zSk9pcHk5VEh6ZnZlamhPM0xXOUxtMklrL2FkaGlZcDJpeUx0?=
 =?utf-8?B?Z09iWGpMSDh6MGNBMEdVQkVNN2YwaHh5TnZQQTZlaUcwYXpzdXhxZk9xNnhx?=
 =?utf-8?B?RlFBWi94Y1cyMjNSWjM5RW40aG9CdXNlc2lOZkVqK3JMc3N4K1BvR3d5UnYw?=
 =?utf-8?B?QmRzanliMHJXb3MyZlV1enRGN2JlZHMwUVJsUGROWFEzM3Y2d1IvUTVqdkd3?=
 =?utf-8?B?R0pCY2FkM2didjhWU2h4UXdQaHU4cmNlYjRRdUd4dXovbE9HYTBxOExhTHdh?=
 =?utf-8?B?V2xTVDJiY1VtZEVTRUdlbGdKaTJZWU1SekJRNG9MQmQ2c2hEeVIyNWFrYTly?=
 =?utf-8?B?L1BWMDlYMVg3d3U2dFArLzUzZ3A5Nm8xYmxvd2JBY2lUK2Uxd1pDZmRKbkdw?=
 =?utf-8?B?ZG0rSzhUc1BOSVFqREVhZm8vZ291QTZka3VMbU5yaFdiWm1IWkZFYzJkczg4?=
 =?utf-8?B?MWVieWlGYk1oSDhIanJCY3c3NitOWHV5cmZ2UUZ1amFlVzRDSHVtUDA2dTdG?=
 =?utf-8?B?N2NqYXpreUgzNkt6Z1p0YldXVHJzNFgycWl5MzBWY1JXVjlsd2FmUWY2RzA4?=
 =?utf-8?B?MzAvczdOMXorK1R3dmNsZ0cxOWVtRnZEODEyR0w2WnJmR2pTaHJBUjFIYzkr?=
 =?utf-8?B?ZktjZ1FFaitzQ0pBTEZjLy9ETTAwaEgvaE04SjdOdlFpZ1c0T0ZNN1hNNUs2?=
 =?utf-8?B?YTBVYy9FelJKSmVKR21rNGMxYVBIQ0poU0dva2ROMVBINzRjb2lVWWkrc2sv?=
 =?utf-8?B?OC9OSGQ1WkdHeG5FMmo1S3RWbUVLQzlZT0VqYmNPUzdMZEZlRUI1L1ROUE5p?=
 =?utf-8?B?R3FzSHhlQWkvc25SR1VIdFUyQW9TN0h2RTJKVUJ3b0N4eUdNekJkLzByNzVs?=
 =?utf-8?B?WGpEM0pEbGE2WGhXVk1GMFo3VEV4c2x6SnR3MXhUcjNYcXVkWnU2YW1Eemhl?=
 =?utf-8?B?ZzZ5NERoR1NjWUhWVDlwcHowdjBnaldnNEQvZUd6K05ZUStVUDRhZ0YxMmt4?=
 =?utf-8?B?enI3MGJxSGxhdEt2VjJ5UU0rTUhpU1U3eGRZZHF5dTBWR09PZmdkVkp0eklY?=
 =?utf-8?B?N2pHMENMUlZtenQyZzlXQnBQYmx3bnZEQUZUdmpNNUFXVnFSMnVyeEJSV1Ur?=
 =?utf-8?B?T3dJZFlkNVBpN1NjSFlOUUJkd3RjelY3ZTJRVXFYR1VBR3ZGZFRiVVFRV2V5?=
 =?utf-8?B?aStXQ2NROXBhMVVqNjBzWExPaTBmakVBbFdEOXJqckRxQ0VsSVRjMXdCVU0x?=
 =?utf-8?B?NktXUTIxYWhueGF3VFNjNnBMQ05zNTlkbTZubnNxMnNCWE1TQmpHR0NuTEpM?=
 =?utf-8?B?Wkt0b2RZWXlHMHJldDlXOTJ4RHJiSFFtdFB5b2JoZVVJSWNVZGxYTHdPUEQ4?=
 =?utf-8?B?Z29SanFKUWhMRlBtaW8yakp0MmM1dkI0d2dzV3RSNzJJUTZhR1IrVCtXUDkz?=
 =?utf-8?B?alZBemFPNGVXSDhnSHlBMUczOWxNYzgxMzF2bHY2ZkdUOUx6bTlNRTYyQ3RB?=
 =?utf-8?B?R3g5TjM4WDdTMEN4UVpONnQ0MjJvMTZuOHJnTXdua0lkcERKMlF5WWVhQnVr?=
 =?utf-8?B?bUdIcFB1RFk5Y1Y4dGJ4Z2NzcDEwTlNkZHFML0ZFZTRBem0zakVYSW1VRWVs?=
 =?utf-8?Q?yr5VVnPLJKrPpGYkaqru4t3HR0mRHERAIVN4hAnF6A=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(35042699022)(82310400026)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qn0o4QBK2kfBfnA6tCdNdnoHmdlAlKZfjfH/M1figq3SbgIgEQR/atcvAoebyVMcxRpcIAFO2Np5J4NuSakvf8VS3Y401RXf3eSITSVuV8wh9mq8QeN52jQDGrolUdkB0XfrIrWA/eUrz4SwMt3Qlljj4OI5jKxO1i2/UlCnF6bM+RIlDW84tNatOY1MeBqSiqq7G/yfwhFfDjZWq7uCiMaZwUiNZ/kea6wWu48eI4qUjOdPvruIBbG58ZSDhUheNE+rdcE9k1ws/7O1QvC9f1y9l+a4yjTDIvDslXA7AjJlan8FxSWGjw6+/3cfkHypWz8PPynxORcW/NITqW6a7ssEyEXBDhlaFl7yoTkrPnun3L2oLW8Gunn5gwUzMx03hV7w/K+ksATaqzlMisMtzL1ZZCoLLAGjkgmckXWeKoUcfIBdRrPYksy2uTxSFb6v
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:20.0760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cd5586-2303-4629-1e61-08de672839ea
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11706
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6503-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sang-engineering.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9E59C109386
X-Rspamd-Action: no action

Some Renesas SoC based boards mux SD and eMMC on a single sdio
controller, exposing user control by dip switch and software control by
gpio.

Purpose is to simplify development and provisioning by selecting boot
media at power-on, and again before starting linux.

Add binding and driver support for linking a (gpio) mux to renesas sdio
controller.

Introduce generic helper functions for getting managed and selected
mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
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
Josua Mayer (7):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      mux: add help text for MULTIPLEXER config option
      phy: can-transceiver: drop temporary helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mmc: host: renesas_sdhi_core: support selecting an optional mux

 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 drivers/i2c/busses/i2c-omap.c                      |  24 +--
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mux/Kconfig                                |   9 +-
 drivers/mux/core.c                                 | 206 +++++++++++++++++----
 drivers/phy/phy-can-transceiver.c                  |  10 -
 include/linux/mux/consumer.h                       | 108 ++++++++++-
 7 files changed, 304 insertions(+), 65 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251128-rz-sdio-mux-acc5137f1618

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



