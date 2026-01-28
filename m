Return-Path: <linux-can+bounces-6339-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIQeLtghemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6339-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:48:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05AA31F6
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C383053CA8
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66522BD5AF;
	Wed, 28 Jan 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gdycyMQU";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gdycyMQU"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021139.outbound.protection.outlook.com [52.101.70.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769A2853F3;
	Wed, 28 Jan 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.139
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611595; cv=fail; b=d+cNGwd7h5sVgDUiyJEC+yc1cQ+aCsczT21nzn3IPzdm0QuV7CF6YhIXjyuLjRCwQMGDU2H47hk67RjtKTCfuV/Lws1t9YW43E5P2GMdzB4MOjivvy6lJbzOcdphsTHDzC2jA+MMCIpahJb6LHFBnJuKSYGWrz5V+JDF6caaqjE=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611595; c=relaxed/simple;
	bh=gYxqo/2VJerUEIavom4wmNBDs0nXuI8lm/DHf3T2axo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fTwzPM/Sbs3OhJWxSfyb4tzeo56g5+9KMza2o2VuqPAMqToJ7/YHwEn18lCqC8YdJVBlg8vshfOtJ9tGTFU9BK0FpY4NgeL8wge+080SQib751Qpp/QIuX6DzZyiokqWKwWN/xTyYlKkAyb28c4VOXE+PMgn+i816IXkZZSPKnM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=gdycyMQU; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=gdycyMQU; arc=fail smtp.client-ip=52.101.70.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EUQeVRy//TIgKOqiN1NO/r4d16eq18Ps6BSRMs3rYcStnmQ5bhOdl1xuX3c228B3BPN9yba6CloHuBbBewpumZZsIe3b+NOcij7uO1ZqI1Tcvf/a8lqiXzR25mQhgQwzDh65QCb7ZIVD3VMn+t5Q4drOjOWYx9nQrHrlEILD5yLJqgXoTUNYpr21Hq7Z0TJJRJIq1dHFVdBey1RNkLcwWcy2ttpmx519g/CgHm/7T0IgQF1Czv7xvwpAfqqCrUiuXpIT7Sz9HwEXoNrLPExfjROv3RV1skQYRYvg1i8H5bzhXhVkiXi/5h3cYz5xOfgc3OtpwZxgNrmpfhnjMonYpA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=qrHHnBNt47VANv5k9h/4wMAimshiH2zXdonkTtkQgZPxfNxeTBodE/3x0UmwpKziR33f+xNr2/SH4DcVaoyHvXoN/TRhC13EDK26jIw6WwY2L7UaEeM2XCxyF5DjPJJwNOXsRg3P6U17EYBb9r1sLWh222CEiLuugDk49MhW0ZSSJCa6ny5oyogl0tRjSFEbMBBQh3LoNbZT1kQqwE9GjJfk3WC8xW179aySfhvRegl2GGpmufO3gHBUXkPhnlmMzKa+TVyQb8OYtry86VEHkiG53uY0Wmk2vyFAIHV+Yfpc7zCvttdiZzp/Fqoba3xKH8/piatJ6Tf0iQn9RmIVow==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=gdycyMQUnDSJWGCHzNowxIcGKd/kbUA+xzsVvVGBIeXEWPGwdO87d3ZgWhuOvpXK5hfe8AV/M771rHvVD/1ub6+8h6QahvWlASlE/wzlJwIJfC6tXO09vIHjXCgmI8y++JfdfM5WXbjD0sDnOZwgX4gfvAZpekHuQdEKgFGPgn0=
Received: from DU2PR04CA0282.eurprd04.prod.outlook.com (2603:10a6:10:28c::17)
 by AM8PR04MB7217.eurprd04.prod.outlook.com (2603:10a6:20b:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 14:46:29 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::93) by DU2PR04CA0282.outlook.office365.com
 (2603:10a6:10:28c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:29 +0000
Received: from emails-2666495-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-155.eu-west-1.compute.internal [10.20.5.155])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 7596B806F1;
	Wed, 28 Jan 2026 14:46:29 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611589; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=cHRYHsFGIfYAMMt4078lNFXihMYbX6mpP+z577dEXJ55YSqzBrOQvgor1t++VJYDZhGvX
 mwcTQllFcgufwnP6I8R4VpMo8/d/zPkO2CcKV/UCu5DrEAmSCZUnrAKca92OcguxyAueG0V
 vwbSECNHIF+5aTWEkT4/1ktjHbqK5Hg=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611589;
 b=NDHz5Cu1vowGFOXV/5qNxE583hrbe1Je0IIdp1IwTCKsvVgYhWERZa8wl/zL2J3JHsxi0
 phGvGPQsERuBTbxPiHALFCxxZpaogjHuqilIzcCOr5VAj2ZPWJypoZZ0EVfmGZKaGL7f/Yv
 AaHzy/l0niAd6qUo6Ha/YI5Wk1HkFF4=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+ZGqQgpqcio8wOGlyUSlW6DPG7yMHLSy14AoHSX3fihZ+9s+Vn4XzOqcsHPZSR0540BQPCPTh4Ya3bC7zYexwxkwOk0dCP9+bDMnGC8mFlJi0k6MSDnP9Sjxfqyos91hrBRvY+Grg7GOlrWf3o3P0vDtfSU8mHpeUN5UVsrGcPQJesiAujk+zB0bfUYYHs19szrwVSGPZO3KQOtxsvCvBAx7Afd8j/9Wr/pUmJWVgukdZ4/6DfjHWuTCNScv36/RUlEeY2dthrKF4vy7KADnvuUGFk+Y3fNi07J9iiEZaCOR191I46gDITiUlQb514JPZhZnCAq74KEjTLul2xrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=Ch6l6Pcnx8ChXkcqYBbaPmStTW6p+9elCjUVrC24GTbZ3sopFWHiIzEFauVXspnVnFiP4oUPRohUDp731CBUzLtGhgxr+3h9p9PcHjiQNv5Dmdjg4bu5pfdSx8uVFsCCD6jI2l/AYhMeANaDZBaXhB274tR4vPKiEodTzQsbaFtLCqQTo2/ayNEycN1HrdjiW1Pb40TRbBZZ910WJb2uI94OFMV5re9JnCoTiMY8A8Z1iIvNabOQ3Q8ewo9OV1DCIcuLBs3ieaGULsGyWCE/yo1xv6lvvrCHsatWLs9UOvSg7Il4tuD44RRvUh2MEM8LRYU4zwPs13HMu0sj/DuLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=gdycyMQUnDSJWGCHzNowxIcGKd/kbUA+xzsVvVGBIeXEWPGwdO87d3ZgWhuOvpXK5hfe8AV/M771rHvVD/1ub6+8h6QahvWlASlE/wzlJwIJfC6tXO09vIHjXCgmI8y++JfdfM5WXbjD0sDnOZwgX4gfvAZpekHuQdEKgFGPgn0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:20 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:09 +0200
Subject: [PATCH v7 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-1-92ebb6da0df8@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7289:EE_|DB1PEPF000509FA:EE_|AM8PR04MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3d379b-6bfd-42bf-d2c7-08de5e7c05a4
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QngxckNJSDRQZjZkU1ZiU2VIbEJSSUNyOHRPb0JEbGtmWFJCQWxNNS9jb0tH?=
 =?utf-8?B?RmZFN1RqNlVwZHB6bDFDcC92THlaeFhjQVZQd3NpblJzZVBWS2xORHZZaGN1?=
 =?utf-8?B?QXBpcXdhelVKRWpQc3VFMFJ0NkpzNkV5NC9QVzl0cUdWL2pzSGRmUEw5aUlL?=
 =?utf-8?B?MCszWGwzd2RtYWhIZzVCTDdEOGFYTFI3TmR5N29MYjVhY05ZcCtlVGJrY2s4?=
 =?utf-8?B?em5FYWdZL3ZyMHVUWWU2MTJrQUJwVitpQjJPMU0yWU1VZEt4MngrTndTWkhF?=
 =?utf-8?B?UlV6dGpudmFicHRFWUY3Ty9vQWkzbG5KaE41WTRONTFOc3dMdzFkZXlCVGNj?=
 =?utf-8?B?WEIwQzgzNFVocG1OYld0d09ydGlrU05VOWhneUVRcmhkbWJxaENXMUV6ZXdz?=
 =?utf-8?B?eDBwWGE1N1ltcnBQSVd0bGRFWURLeU1SUnpCZ1RVSVh4eWYvYUVTNTNrQkk4?=
 =?utf-8?B?ak5pQlFzUUh3ZHRqbUw2VDljcXoxeEVSYys0Ykxuc055RW1vRHJYSDZYRW9X?=
 =?utf-8?B?QVZrRDMwVHdpcTJ2TGdydGNXbXBKWXRWM2FtQjlua2VZbFJCRTNySnRBdWEr?=
 =?utf-8?B?Unhnb0pGa0lGVmdVVWkxY3QrekNwV0dHdTZFRnpqYUYzalZ5dmtNWElrOVJo?=
 =?utf-8?B?VlFQaGNqSXpqbXlKNEZsd3F0cXU1OVRkb2JoY0Nnb25KNDJPNE5uZmc1TjA0?=
 =?utf-8?B?Sjd3Y1pvZTRGblJ4U0hsell6Q1V1Zm16T3g5Z1VhTktnWktTVzhUQnNjaWto?=
 =?utf-8?B?cVhTOG02b1lmd0ltcjFlMnA5UG9sRWwwRHhha2JEVWpJZ002R1BNME5KSTlr?=
 =?utf-8?B?RWNaZjF0YVQvemdaMlhhZ1poN1JudVp5YlE5ZXJSc21kNG5kQk9SK2NQc0Vv?=
 =?utf-8?B?SmJ5aG9OWVVzUEVxK3JjeEVLbjgzcm8rekdwV3JTMXVIUXJ4bHgzbWc1bjlu?=
 =?utf-8?B?QTAwU1orTXdHTlJPZWVNRjJZcldVd0xRcVFkQzlCaGVNRnBTemJGMlYyMko1?=
 =?utf-8?B?YW41T0FKVk0rY0xhZ0xJVlV6d0ZUYXRHZFNVbkN1dlJ5TU9oY09LWVFxMTM3?=
 =?utf-8?B?V3E0bGtZTUpDV0FJYkVERXg5S0pJM1BnZVhSbGJHTk94ektQajQvc0xHenNk?=
 =?utf-8?B?cmozU3ZBemFJeTZSSFVRKytsMmcvL3pLN0dCQWp4ZFNGQzZWKy9FTW1rRTgz?=
 =?utf-8?B?U0dsbkx3bjd0Tm5xOWVOeTNvR0V4Vnk0R1paUXUzZitYZ3FlRnpIUTk3YXZ4?=
 =?utf-8?B?Y2JEeitPcnZqbFRUSGZOYm0rd0tNOGlJYlM1VVNCbmpJVFVweVdZRkFFZmhY?=
 =?utf-8?B?M0Fsekp5YU9qU1VEcGYxRlhQUW0yMW83STh4RmRaL1JYS0V4WmNZRjFBZWEw?=
 =?utf-8?B?ck5FNG8raGRwRDBESTRzTUhXT1ZLSCs3STg4d1owM3l2czhoRXVHZmdrallE?=
 =?utf-8?B?Y1dwR2MyYThmSFBJMW1NN2l2d0xBbEVveVBIMVRqTVZqT1NRYzBqUGdGMGYw?=
 =?utf-8?B?ckZRNlRjWCtTY21hSUlTU1B5OHpVYTBpV254VzRXUTBiOE9kMWlqRHhwZngx?=
 =?utf-8?B?bGVvRndXdWQ4MG13L1lMNCtMUTZvU21HT0JBdDIxdnc0OXJTSEk1U1E2WmpP?=
 =?utf-8?B?anBpWHU1ckIxcVhndmtYTS8wc1ZvNHgvN1BGZW14SENPWkNhV3FacTRRTmo2?=
 =?utf-8?B?YmthN3R1eTZxbkwyVVNYeW5qZVNmY2JSQ3ZoeWlocHl1RjRyOWNjTC9VN3B0?=
 =?utf-8?B?U1MwTVMvQTdyYlptVUlndjhQV2psc0ZRakJ3U3dLTEZ0MFd4MjBGS3VpcDJq?=
 =?utf-8?B?bm8xUHAvenE2bXNybWZjNFhIRDJFRHhKU3d0dGdHZTJsRFBEeG8xVnVmNEhp?=
 =?utf-8?B?bEthdDBrWGQ3V0I0RC9aRmRmNHFVYzVtY2VEZzFuT0k2UWZhZ3M1bkVJTmR3?=
 =?utf-8?B?RGk5RFpPaEk0QVlLRmJ6d256a3p6bHNsSG94THhpY0dMSlNsVW9BSTVxczFu?=
 =?utf-8?B?cUp5L1FHVkl4VHB4enZNWnVJRzZuTmpIMHNEWExGT2wzTUd4WFB2cVp2MUZ1?=
 =?utf-8?B?bHJnOWZmeUpObnN3em00VFhnVFlHd0o5WEw4cW9BWWhtd1ovT2ZmbDA2RHEv?=
 =?utf-8?B?YjhtMFdxLzdPMFduZHBrZkpydzNISCtFREFnbDI0WEhqY3dyOS9nSUp3eEg4?=
 =?utf-8?Q?rOUaS+rPHfFky1uy6isEuPqXRabz+QXDASTR0KM4ke3V?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f6316cf79779416197bd4fdaccc15250:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3e6b6f6c-a7c5-412d-3521-08de5e7bff41
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHRzd2YzUTNEUmdGVURxMEIwQlNHZkM5aTdLUS9NMXplOVMxOWVxcUJEb3Y1?=
 =?utf-8?B?RHdyOS8rc2xmYlppck5zcythaE9oSWZwSkgyeklvclUrUmg3bkllK25Ra3I2?=
 =?utf-8?B?Z0xTUFhOR0NZVGlscTVLUVBiRGoxR3pscG9YdnpDVDlDcE5wVlhiSFVEOG8x?=
 =?utf-8?B?Z3JtVHB0NUNpS1ZmWkpxWTJ3TjBMM1VjZmJoZVg1dWl4VW5hU2hHa1lKNHFT?=
 =?utf-8?B?bUw4SWZxcG1GbmcycXBXOTJBeVc1dU9ueEh5ZnZBM3JKS3NJTkdacjRhcEc3?=
 =?utf-8?B?VmdEQzRLZ0xkQ3F3SVRaS3dWem1SY3ZHMEhKYUIxSW9CYzlGWVQ0Vmw3RXV1?=
 =?utf-8?B?d0xnRCsyUGQzOGM0dnRMSnZGUkR4SzkyRE1FKzZQaEliQjlBR2Zyb0p2WkNk?=
 =?utf-8?B?VG5wQU1hSk1NRUxvRXM3N2hDOFFjYnBKVjlGaXh1QlhpRVovbVhFb013aXB3?=
 =?utf-8?B?RGx0UGhhdWxYZmJ0RzlPcWsvelRzTGlNcHFZK2dWK3BPUjhEMmI3cVZQYjZh?=
 =?utf-8?B?YzR4d2FWUWpZbVhPcTZVblA5aExCbm9oNUFxL1JvYzFMNEFkb3dYRDJMSkNM?=
 =?utf-8?B?VkVaazBnUUlUbnBZcmtKT2twYWF4RFhKaDY1bUl5NFd2SFk4aEhYMWZIUzgw?=
 =?utf-8?B?eEhlR3MzYzhsM2xkSDRQamttblU1MWtCZkNZTndvZ2JjY1d2Q3haZm11VGJ3?=
 =?utf-8?B?T25iS0xkODF3KzVTT0trcVJLS2gwUmpoWUJwbXQ1OEV5Yko2dWMwZGhFUGh1?=
 =?utf-8?B?ZThrN2ZRT2llRjVOMkpRUW1YN050QWc1RDZVS3l3cXVLUXBkREw4ek5QYVFh?=
 =?utf-8?B?c3dzZHdFdHhxUUlPai9oWURCM2p5QVB6ZTNFNzJHTlNjbU81RjQ3K1RHNEM5?=
 =?utf-8?B?L3FodFFJbEY4eGgyajJiS0tLTVZscFpFNUM1VFNsbzduWkZtVC9oNUhEckpv?=
 =?utf-8?B?TnphSkpwY0V0Vzl6MHBYYk1RTitRUlFLbFljbDVEdWJZUHo3RTBzc3ozSWpD?=
 =?utf-8?B?ZU11QTNaY1kyQTVJTDRkOWdYaTFVN2JNdHRHUEdSK2FPVXIzbThSNktlcFhl?=
 =?utf-8?B?aWp4a04zWUpGa0NjUS9EekVNNWNjbWhIMS80WlVwYm5pYkV6ZVA3bFp3T0Yr?=
 =?utf-8?B?TzRFVVI5dkpXOHl5UG1MVFduQ2JIUldoNkxVOWlURkhiL3oyTitNajU4OWVY?=
 =?utf-8?B?cGJvTkxTU0M3SUxYUUpzSjZYRFlYMzk3Mm9GcVh3aXcrQ3lyZ2dYTjBqRVZV?=
 =?utf-8?B?UiswbC8vR3dlbjBjYmUwK3RqcjFuamhrKytRVDRGc2N2U21SRytwSk54UHpT?=
 =?utf-8?B?czBZUXlOYjhXcVRLaHZ1YmRybGtnTWcyU3Q3UUozRDY0VHZXMXI4cE80c2VB?=
 =?utf-8?B?KzM3cmRCS2FYOWtmUFRuZ3RxOS9BWFR3RG5JZWhOcGdTNGhKSkJLK0Vaa1BM?=
 =?utf-8?B?cmM1YlE3bTFGbkdZQWc0NzdtM0sxTkdXTHc2Ynh3c25WbXZxOWFSZGpDNjBB?=
 =?utf-8?B?WnoyVGZVbW1mVHcwbDl4VGV3bmE0cXBESWZ1SzI1bGZ4ekYyV3Q1TXYvdFd5?=
 =?utf-8?B?V2dQd2lsSGVHRlFZSURGdmY1R21RUVZGZktvYnJrU3ZMaThBSWtYOHk1dysy?=
 =?utf-8?B?L3k4NEtvcGdvbitoWjhnWG5UclNJcWJkY0VncXlOeXVjcVZTcHZTdmg3TUNw?=
 =?utf-8?B?ZlVqcVRLbFB6R1JFRzFORzJHZzlYZFFpU3J4alUzbDNVV1BJMjc3YzZLbCtU?=
 =?utf-8?B?WXRTRlJuYU9yZloyRkFHRDdERUJYY2hCa0NNTHcza0Y5KzY3S1lLbWcycEVN?=
 =?utf-8?B?WWlWYUxKbHRJSFF3djlEbzhCUGhKeFhscFZVSkdZdWZEakhkejRGS2Rsbm5W?=
 =?utf-8?B?MEFxNlRnelJlaHZrcUt1UUh1Zk03TzJ1aVhjWC9CdkM0S0pkbVUyb0cySHVV?=
 =?utf-8?B?TFRhTlpMR29FWVBLVHVMNVpkU25NaXhxb0xYdytaQTZ4Nk5RRHh3WVpLRzdV?=
 =?utf-8?B?Si9sMlQrZ1BiZ29UK01jeG12ODY3S0V3Uk9KYXhSeTlmNzFzcmdzRURGSG5X?=
 =?utf-8?B?eDZDdjk0SEUvKzZhbXFGWFRaNjh4VmdmMU51MjBwdTh3UGJJR0dmNzJNWmN0?=
 =?utf-8?B?ZlBVelpzcUluZkI0ckF0bDRBbWlHTEFFRktMTFpkdlBHSGlscThSRkQrZTYv?=
 =?utf-8?B?RStRMC9aVW5nMU91NzlMYmxic1ZPUzVtaHJFdWdhdk1MWFpWMDBMdXRsdEtC?=
 =?utf-8?Q?pAhZG+jgBiqocHDlJrpfv0L97u/4+bAkWMAyeINElc=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:29.6406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d379b-6bfd-42bf-d2c7-08de5e7c05a4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6339-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2A05AA31F6
X-Rspamd-Action: no action

Rename the temporary devm_mux_state_get_optional function to avoid
conflict with upcoming implementation in multiplexer subsystem.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 330356706ad7..81591d247128 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,7 +128,7 @@ MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
 /* Temporary wrapper until the multiplexer subsystem supports optional muxes */
 static inline struct mux_state *
-devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+temp_devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 {
 	if (!of_property_present(dev->of_node, "mux-states"))
 		return NULL;
@@ -183,7 +183,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = devm_mux_state_get_optional(dev, NULL);
+	mux_state = temp_devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0



