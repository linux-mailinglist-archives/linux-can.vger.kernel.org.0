Return-Path: <linux-can+bounces-6508-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOA0O/WuiGlTuQQAu9opvQ
	(envelope-from <linux-can+bounces-6508-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:42:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFFA109480
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 265E030602C1
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472C366577;
	Sun,  8 Feb 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AXEe7BZm";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AXEe7BZm"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023097.outbound.protection.outlook.com [52.101.72.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F980364E89;
	Sun,  8 Feb 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.97
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565175; cv=fail; b=hCervil94mUZi2/zmrIfVeQqs7VV1DAPrsACiQLWvfrTR0AuPmuNeiT9tpxv8yK6/0lUG3KVVIVEnIA5roXVv66teAntYSZpwxtP6oWkovghqemb2TZoSmIVmtl2HOnB5uYiAvDTTnp9JWqxnyTw5I1Z/dBSuZaLslLrR0UZILs=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565175; c=relaxed/simple;
	bh=+7AXzRDdO/6DznkCVEj7nvWGb+MksP8sfm3UBQHqum8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jyaKUu601SI19nefFEyXp9rhwMPCgtqECXRMpUfX1Gnwt0YSpaTEMeqenrlZ9hv0csmWeY+CiFf9N3Qij41I05f6cPfBguRuMA2AQ/O15050evOi8PMaNFAJ6tfmZKxEBOeGS0aGiMz6DdGWU5gHed9tNpcxIMmT5OmEtsLGl84=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=AXEe7BZm; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=AXEe7BZm; arc=fail smtp.client-ip=52.101.72.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S3B9Wz9Otus6O3hP1ZWPR40R7js3w53zxA/sVa6TNkLyOPlTlD4sczeTdsYSmnqfMoabS5YRfmkYslWJzLcgnbnByNbsUIGuLrpoB1ZwGgJgDT6i9Wml2M48ZbxHp3d0Bjf3NxgqP7xzIwsD4vjt4paw6QsyVC42u/gkMoDfcDVSMaXDWUCBRMEip7pjMa7WkbXgEkKp0p4NHQiGlmgf+Awx8Z+jrYRy4sjckmp46XSD4+4Z6zQkNPNfr/Y+HDek7asc62Yp1z72iuJ9JEHjf4CvV/b3Wpf9zppXcdsJURA8cJasf0CV94AzYrjjqoM0ny7KLBdQYmiBN7PUq9WCXQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=dqq7vx/0SDBduVKGUIIZhu9LjTgKh2+HLoCmDbBRSjj0Cal5O3LB1sIJBnUYD/CM8MK1QGwv5hWBk5ssCO/gV821O3KClNBvEgWXOPgpb6aucgw0fHGRuZtQ7SRBBLgOfbYV00KDYA1h7wRXNFNsD/xA3lnKd+FzUF/Vs3I+ybHP3BqfwMRCuNxB/2D2d6T+Tgk8tJZUrhY6LJe2XvxNebIN4qpdMdWv4KlpaN0mripJfB1sQjEDiVxrmgbhzi+Tlav/f0sF0VMHzCZKwjkcj9YBAvN4s2924Lqab4K7YmXKxuJ6q86Vf4Zdj42LlwCrTk4o608SO/qkUBFk03ad+g==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=AXEe7BZmOm6VSlKOfjTIQ5RWuVj0oIUS/YBdnIk15RbPYf5LAiqUIj2nUi5OTrkDqxogX8oBxaPAxfI/BlU77mkkyE6gj5Mseuvwgj7LIvz5Nx+FKvL8dUCrUFH8V1TO46fWBWCuzco1X7nCwipQ1jR4j5HYM3lbrQq646HsQes=
Received: from DUZPR01CA0208.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::6) by AM0PR04MB6897.eurprd04.prod.outlook.com
 (2603:10a6:208:184::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:28 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::e) by DUZPR01CA0208.outlook.office365.com
 (2603:10a6:10:4b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:28 +0000
Received: from emails-1780131-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-212.eu-west-1.compute.internal [10.20.6.212])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2ECBD80061;
	Sun,  8 Feb 2026 15:39:28 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565168; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=HCvJQu51XlIpUDNcsUM7WRGbspJwDLEGy4ne2kafs3Anm8wzreTWdt4I5h9VwS542c9Jn
 SwUkHdfk4fVjhYORpoRLvx4uYGe05wfqaSY6LhBe1Rzmm6U9GCYv0lTXbiwFQ771LSj4Nnk
 bi+IuUdP2/ainQ/dr0sQbgxQVFEgKjg=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565168;
 b=ddqb9w3kY7YTlTYCj0A3jgeNAwJb/bNkKkyiCupp6T98Aj4d4kCbYn4JAOR30REezU4Ya
 1O6MWcF0bAyyD5UfZGqd2hjnKYD1ji8zKpfeS4opvxewiUjPWkUhGH5sqt8wIttNAP5sUGh
 FZ+atvQn/5sYjxFsAgCKkMn82JP/hbU=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt4uS9ZwsMkixNBthyl0B0npYT+rY8doYkpaXsl4k2DI2HSG2VIek1rr9DlW8A0spjXtkVcM8zuR5+Lc7BSEqSJnafLnNlRvwFT5gmoOiRDeqa5vKklOoGpA+H6jEF9asnH6BIOAYOJtpcGLm/4eXhBk1iCPVSvmiJEk7di6ufJscQpMXRKctiDZzGLlLNwryBT7miP2W82f5KSpqfFj6DjtSJbktobOQSWw2yKX0iHFa1/BAkDtnsJcLiUuROy1NAWFQaXYJXSc0RPNX3F8u5Uy/4IFXyCO48DIFc4WbafA8ietb6aWLxu8xhUF0RYyTagVrvqBvSO5Kpp/rF68/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=EsJRQLFMxQ4Wjltotjb79dE60FImZGPUNLAUCy4HiOMM1eeYVWC1Zw/0DfWLZtVIXfX962YID1s6RvLYc6pVR7uHau8u0jOwwtckS/lJZtSd0plSAj57reOwLe0fHaz0SE1BpXnEylvLEu/XWD/WZmXgxPFAdtZmU2p2WwmHcN/ycb0OwQm0d09BWpr69SeGv/9h0Gi5FoKQ/2wptCBjI1hIcLjp1gzkv3i4WlClHjvMqPFFk7ck4wUYjM6jjJk5JvgkKpuoxBVPqlwKF6V93x1QO1O4jn4BQjCf/EBqWFJWBDLPO5f6s0VDxTNGGs88OpCzcExN3jfT+v0vwiQ/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=AXEe7BZmOm6VSlKOfjTIQ5RWuVj0oIUS/YBdnIk15RbPYf5LAiqUIj2nUi5OTrkDqxogX8oBxaPAxfI/BlU77mkkyE6gj5Mseuvwgj7LIvz5Nx+FKvL8dUCrUFH8V1TO46fWBWCuzco1X7nCwipQ1jR4j5HYM3lbrQq646HsQes=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:18 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:39:01 +0200
Subject: [PATCH v9 6/7] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-6-9a3be13c1280@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
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
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|DB3PEPF0000885E:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db56ce4-21e7-4ea7-e8e7-08de67283ed6
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Y29nNjRRcnFaM01WREQ0Wk9YbEdkNkZuYytacjhPRVJDMUNZMEE3em9pMlRW?=
 =?utf-8?B?elU4Sm9US2pnK2JPOVNBVndlSGNxUVZYVTBlZGVZYTJYeWEvUUdxL2ZRZnp0?=
 =?utf-8?B?K0NWRjJBZ3NJblduMmtZRU01ZTFxWFRwYzRhYkhzSWszbnlWeVhqNFEwdWk5?=
 =?utf-8?B?R3ZoREt0aTV2NFExUzdWWjNoVTVJL3p3eDFMV3lDWkIwci81RHpRMFp1azl1?=
 =?utf-8?B?RjFzUDgzcklzaXF4NVJqMjRGaDA1OUNOZ1ZlQnBENnhBN3N3eXRBVUNBQ0RF?=
 =?utf-8?B?aTUzQXVGUmxxV3R2VjFqWnY2NnUzTi9pbzFmMm9MRnBld09VVmxYZ1pwVDhN?=
 =?utf-8?B?ZlVORm9YeEFtaVFFMWJKMWhOeTU3ZXdDYW1QT09kMXRPWmtxaWxraDRLYmI3?=
 =?utf-8?B?QmZSRVRFVTdjRGFDdWMrSzdTRWtnV2FNZkErNFMvSU42L3U2K2JSelFydm9C?=
 =?utf-8?B?VzlUZ2c1RjY2N3BOZXMxVXQ0MGh3Mm9KQ1FvNDd5OUhMU1hzeWpZQjlrY3ha?=
 =?utf-8?B?RWVGeVRmcGJ4VDBKT1JQV3dGQ2JtN1MrZldjaVd6ZzJ5eG5UWVpTbENTS0k3?=
 =?utf-8?B?VTdOQ3E3dEpISGVGMlhFaUpKZEJFTk5hbmNFMXpkdSsxSno0MTRTc0Q2RE52?=
 =?utf-8?B?MEViQXBtZlhDNzRtM0Z1ckZmYjhlci9CYm02K0FsWUZXc2RwMW56MHlyUnJR?=
 =?utf-8?B?Ty9ORCtybVg4NUwvV0EwRlBnV25Ybm1tU2dCUVlEZ2tOWFZXS1B5WFZZcHA5?=
 =?utf-8?B?Yy9zc1NzMFd6ck5BMUg5dVlIb0dOWjd4U0E2UW9VN2hoQ1hKY2FYNzNndUhn?=
 =?utf-8?B?aFRsb3QvZm02MjZ1M1dUVUpqVkhlYkt0cDVSWm81Y1AyS00yUElDNXZlTWZD?=
 =?utf-8?B?blRacXNaZnNONytKZWJoeGNhU1BraHVEUEVib3RQM3h0ejdOd0VwZ1pRNDJR?=
 =?utf-8?B?eGVnUmZwUU1CclMxVEE2eWdhYjQwc3VBUitCZlZPVkhZazJQWllpTlBCTFhG?=
 =?utf-8?B?d2IrSWVldmNQTVovZ09sVTBqOHpYdnk2cmtIWnNMcXNuSmpXL3I3RFVZNCtq?=
 =?utf-8?B?bzZPSFIyS3MzSm5QSnhQdG93SkNMZUJmcjUybkJoZHVweFJpRjVzNUN1M3BC?=
 =?utf-8?B?MnoxUkJGN0h0L0VOVGNiTWRqekZpOUY1V2RxSXBrV2lmWFhLQ3BHcWxEVTI1?=
 =?utf-8?B?aHBReEljYWhRNG9GbzdSb1pqSlo3d2hCcU1CM2dIMitaTkRhdnowMHNUUjFu?=
 =?utf-8?B?VXpZOGdFQXl3RW5JUjM1Vy9Cekg5WlFFdHE3bnNIKy9vVG1UWVJoZVo5WTFL?=
 =?utf-8?B?WGNwVU9jQTlBK3NNcitBTGxBR3A2T2tWaW4vc0lMWWlNZFNvb1N6Q3FpVTlG?=
 =?utf-8?B?SXZ3WFk4ZTRrWFRoZHhiUmp3NUx1NCtjMHNzaCtNUjh2Rm5oVEhPdHZCRHl6?=
 =?utf-8?B?UzRDWW1vcm5aMUxueTZUUGFwMFBSVTNSSTJndUNzcnVuc0hXQUxUTk53bStV?=
 =?utf-8?B?OUVYWlA4NEVLVmZuVXpndnA4YmdZd0pCc0pHUmlaM3JHRVZDa3hzbkpwWWw1?=
 =?utf-8?B?K1pmSWdVbEg3MEdiTnp6aGJQOHhBSWRLMTlTTzlmVjlPcnRhYmtHdVVzVm4w?=
 =?utf-8?B?WnhucmZ0MFBBRFJMVkdIakZQTW0ybnhmdVB5R3Q1aTAyM2J1cmh5d3FLOWNo?=
 =?utf-8?B?UmhIOVNVYzlmV0pFOHRVM2NSVHdQZEdxd3dCc2lwMFdjdnNzNWtrTkhUUWt3?=
 =?utf-8?B?cDUyYzFFMFl5MUlGUlZMdGpxek9TeU5EbFFnOVdJOWZVVDN0TkR2dHY0cmRn?=
 =?utf-8?B?QisxT1hTcHNtRzVGSHYzNWtERER3RWxkT0VnSFNYVUJjclJKbDc1NUJnUnBD?=
 =?utf-8?B?Z2lqRmtIOHZTQmkzRkxvOWR1RktwOW9RaXhRTkRkQnlOMVVXbkcrT2VQczIv?=
 =?utf-8?B?d1BOb2w5bkY0QVR3V0VrdHBYalYxZzdRc3lGSnR1czdJWmZFWXNQdlFaNmps?=
 =?utf-8?B?d09KZG1oSTZJQ0R0SEpVbFpja1o1eGN5ZXBOeTBmcEZadHpmRUIvSjhRbG9N?=
 =?utf-8?B?RkU0RU5rS1Eyc0VxWjBJeWViTlo2UjUxblpBRWdnKzNTYXlxWjRzNFZzeWgv?=
 =?utf-8?B?cFlVc0JkVVJ5QlptaFFqcXlBa1FYTk5ra1UxTFpzbkREUitCYWhseWxaNW1z?=
 =?utf-8?Q?TQguGEhzUZe9xBVjZ3k4D2np74XfnhZE7h5hiT75USJm?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ee412ed5647e48258a0c990a27cb4c36:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e39c7225-6175-4b57-a917-08de672838d7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|7416014|376014|36860700013|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEdvOWdTcTBtZWoyby9EMDZ1Tll2ZHF4NktIdzM0WThFd0l3NlJrRi92RWtJ?=
 =?utf-8?B?SHJJZG1BazhKWEhndzg1SUNjUHlubUhUTGVGdlhHYncwV0RadWdlNnlyYUJl?=
 =?utf-8?B?VVBtYWlmRVlRbExNMlZmNGRpckU0b2J5MmZaK1l1YU9nellKcW1sM2ZMQWEr?=
 =?utf-8?B?dW83R3ZVaWJUQzZwUlVhZDBlRlRPSmNKQzJ5NWFoeUVmQ3pEQXNQN3o5TUs0?=
 =?utf-8?B?OEt4TjNjc1lPWHp4YkhKOFlrM1J6Z255RlEraU9GZXRSalNVV1JCbWhaS2ZF?=
 =?utf-8?B?WlVacytzMjVzRDZNb3VQK3haNUw3OCt2Z3MxWDE2RysxWFMrbkpWWVFSU2dw?=
 =?utf-8?B?dkRJWCtUeUMzQ2pXZktZSERMUDd0OHBWQjZOVXdCd0xSOU0rT2lOaFVWamtl?=
 =?utf-8?B?eDJNRi9MWThlYlBzT0YvNGI0alF0L21Wd3lNcVhhdGRDQU5vSnBacmRPeWJR?=
 =?utf-8?B?MUNKTmx2c00wMnYvV1B2Smt4T0FqQ0ZneDluanhpaEw4U2N3eUVNTzAwU2Ro?=
 =?utf-8?B?MHVBb0VOR3cyamdXUUIvM2lxTHZvUGN5cklIWGUreU1VR1hQS2pHb2xjUUFP?=
 =?utf-8?B?V2FEejVaRjQvSUtQOGxweC9BSjBRcUlUeHBKWkpnT2E4aDZwRlVHVW1OZHNS?=
 =?utf-8?B?cnBxMG5hZzNFRnFxYnNodG0rbGRvam5Yekc5U3F0ZzljT3o4Z2hmUkh3L3Ns?=
 =?utf-8?B?R1EyV0MzbDB6aStERDZubFdWV0JLcmpEQldKcjNyY1VXQlk2Rm1rWVhEZjBW?=
 =?utf-8?B?b0NNOHJhNWoxaGk0eXU0MFNzMUdRMUdGM0N4MVB0REU4SjNKTTdUZnB3TE5O?=
 =?utf-8?B?K3NJYStRSXlEUGladVFLZjg0T0M4NW5JUmxJVVdqR3BPMmJGeUIrZDZUREZR?=
 =?utf-8?B?VlRGc2gydTVKU01mL2tWUlgxQStUSzk4SVcvT2MvYnlRdkNKUTJ1Z0tRbUZV?=
 =?utf-8?B?cnpVK1UxOFZJVERYVC9keURGUnZrUTVmY0gzN1l3a1M1T0JIK3JNNVluMTY3?=
 =?utf-8?B?OVg2Y1hFUk5sOEh1RnQzTnlyNFhlTjBMTFNIMFF4VENXNmNwdEJSMGErK0d5?=
 =?utf-8?B?d2QwdklZRnBod2I0bjRlZTNyUzM0OEpFeGJNeHJoSjNnV2xuQVpuMGtjQTlS?=
 =?utf-8?B?MGgyYkhqaDBVU3VOTU9lNStkUFJRL01WODlZcDRTdW80OXU1UzdoemNxaVBG?=
 =?utf-8?B?a1ZGN1FmZjJiTnZ1UEp3azBKbDh2dVBSVi9uRXZSRUIzaGR3N3A5YmxVNXZJ?=
 =?utf-8?B?Mjk3SGh2Tk14MGJXRmxCaklJWUJqS0NuOEZQMTMxbE03UytySzFJak1GN2g0?=
 =?utf-8?B?NXVZbXpoamJIVldTZnpCSEVsWGRvWHJEQXdhejZIZDdscEROWWlOMUxwUmFh?=
 =?utf-8?B?R0ZJdkdlVWtBclFiQ25yMVlJakFiODJyMStUMENKMlhnRW5zOFhzUURMSkRQ?=
 =?utf-8?B?QTFJbFRpMXl1ejR2anBkakFqbXFoRW1PZ0FJbDhrQVZvdmVsYzNVU1Z4L2pQ?=
 =?utf-8?B?UURYcVFiS05SQnhVWXl6K1drcFBOMFRSZlova3RoNUNEcERxTmt3eEZ3aW96?=
 =?utf-8?B?dUpXV3p3dlMvYm1uUXdRL01wWkNXU1c0VVZZTXpXU1lySTlRbzUzZlFCL2Fp?=
 =?utf-8?B?VEtOZjMyTHRRKyt4R3RxdDBTUUtMVVBDdmNDczRObkErTndZZWFDa0ZUNkRn?=
 =?utf-8?B?Z1NZRkRpQTVaakxyVldocUNSMy9tTXJMMkdaQ3ZuZHoreXpOWXpKY05yaHIx?=
 =?utf-8?B?ZWNEM2h0ZzE2T0tiVWEwS2wxRFRxVVlTMElQZG13SEJPWm9kZjI3TVBGMHl1?=
 =?utf-8?B?MjRxU25ZYXZ6UG1XLzRNTHhxSC81ZzJMZkVkRkJ2cUlKUVUrdUErMndISmVk?=
 =?utf-8?B?VU1Wd0VZa3d6NkIxb1pId210UHFOTGNyV3pHQkFNVzVTcWNBRjZpc0kvVkg3?=
 =?utf-8?B?MmhiSDNDOFVBT0lveTNUNjhLVGJPb1oxQWpXZVhZMGhwZWdtSW4yWEZPbTZP?=
 =?utf-8?B?ZWR5eHNRbEZvTW16VzRQdWxQY2JQdlpJZmN1N1Z3aXU2NFR2RGlFSHZNZDhQ?=
 =?utf-8?B?UlR6K3VGY1o2K2hJaHc2cDg2cDArR3cyaGRNOHRRRkZKS2xTQllyTHVwcytX?=
 =?utf-8?B?VTdWemlZeUNEbFRVVEUrSGNyZlNDZDA0Yk9YMVA0NmpKeEcwYXdHRlV2S1Nv?=
 =?utf-8?B?QWNUbXBEMXN1SlRocFVhVVlueDdxMU5rSVpZZjJVVkFkWFlYSyt4WW9oQzJO?=
 =?utf-8?B?WHdZTlB0RHZrbithWW9BaTNwNWFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(7416014)(376014)(36860700013)(14060799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yOrRcldWFfwovJRm2ckJpN/UHMzq+xldCfvyD1Hg8qrvA7d7Mfu09SJX03PpSSHxXEnU85y9wv29u4G31iBnq5PF8cRvBDeX/DwuKXncdgAmYxOP/e830kZuxpxGVXgjgDK94TzqnGT7kA4Q1BXwFgR0iA7sFASocnU2koi7xqn0VN5Ef4DSnLweYaq+mC1ca1L7ynfULAp8Bov8RD628VExWrNzbWYLsK/EkawgLx32fSvLBkIopnSzq24KjnwPofxiV4LJ6RwSAOcQHEA5zJnruq/pcd6ZabHepgllRwFUkQ8CbwhpoCxjO/rDowiv5qT5FXRrSeTKf5uZebEvLj0LOfLa54o+nnFHoBCvAbj5eDE0FLjD28PiXCGGbRitqNraBSNy0+YIzr8whjTmIvxFDSlegDqTxx23TeTWx97ioKj066Pjl7D83SusOV4f
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:28.3386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db56ce4-21e7-4ea7-e8e7-08de67283ed6
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6508-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sang-engineering.com:email,solidrn.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4DFFA109480
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
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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



