Return-Path: <linux-can+bounces-6472-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KyZCIDzgWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6472-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:09:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A79D9AF8
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B906312D12F
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254234DB57;
	Tue,  3 Feb 2026 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GPlI4hn9";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="GPlI4hn9"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023098.outbound.protection.outlook.com [52.101.72.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6D34B410;
	Tue,  3 Feb 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.98
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123726; cv=fail; b=lxnQu9ij1Nrt6N3HNY9F+Gxa/YK4RhZw+H42sobozdyyaRhAZBrTVwQ8ikS7Wx2BESFsLkYqDjwp1tKpVKOal07X5JTIyi6aTopy/svv6luhdzUf4mhuawwMgLa4fbmRaHALBkAyxAbUpp/ENEFKU38CFiUSxwpcpWQBULohZPs=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123726; c=relaxed/simple;
	bh=gYxqo/2VJerUEIavom4wmNBDs0nXuI8lm/DHf3T2axo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zp5S8qWbTfpvjb/wkjHaw/wlvX31GvYLm9MUtg23JvaR2EOFfC21LRUJplGtj8iFaZV/VUjL/Hqc8zIPGr5d5F7xITNEpFu6oGpPsM26I3OslNcBqIh4q/J+IM6YNYsshXH9ayxyoigN8vbxD/eakGPhf4VHWf3ECENZqDnM820=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GPlI4hn9; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=GPlI4hn9; arc=fail smtp.client-ip=52.101.72.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RSzbERiofuxtJLf2Wc6jHw+CxAKCbnH2OIMtQKhdEy1PwlSfckFDnB7XY0ju7ZVBfPgKgtppgcMyru8x3KC2t6PEIna939lMsE48W5yS9tA9Hw4iTUfazPN+PPuKWwMBHBkugKVlYXuj94htX7BQhr1oKmvvILGurw0eeuoxg5wgAbhwUm6iQkGsxAC6lbACTYNatFi+tI1swwbeeeABFcs5n9eNUFjOGxod7WVqIQrhZ8wbPfT5ycZ+2zqLINSR0Jjvp0iIZAthX4imsYCo8aBfQP9nSHZEoyGMdDgot5DUJ/wFCN6pl324yM+7ZrzlL0Z5090WDQrD+MV7AdPaiw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=N0dZzRoY5kKhkDmTucTDrJw9C1EX4vh0JvSJLho9i4Xj7RIIVrptvXaoHnyQgO/Qmwi59xSowA+MlVU9R1B7FxcV+WbL6AHy1HoxTZLmINSKSuSIr/yzW5Wy4f6Yz9o7CDUTwlr+os+Bgcj/5zoaLGVT4Y5Ra2avV+0mv/ZYFpVt5flKkAeOXyZCUVEzHZOaZjjO2sXUzJQRchBkOX50uWLQWeKjgT2xfOhPsRnMZNi5r2o9VZx9dTSzO45nrDqEX3XSDACNv/mgNsRS/9MGDQzQTv3olSgHbleWwpflAFqUP2wRd8/r9f8j5CZDNU1N6M3u81Y3PAQDafGKSb7xog==
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
 b=GPlI4hn9VayvporlmpF7fJrh0Q/HL13BeNeaA8gF/S+Rvgb8lhYZhwGtLwqdUlaJCSJlb0K2QF9V8A9nd2dLxT9VBhSa7K9V/+NsDgcf/kOCnxONDQKNieYASTfwe+OqxGGIPA2ASqOVWuVXccGUGMzTC9RrET+yMACPPRNrzPM=
Received: from DU6P191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::15)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:01:56 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::2b) by DU6P191CA0040.outlook.office365.com
 (2603:10a6:10:53f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 13:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:01:56 +0000
Received: from emails-9939603-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-175.eu-west-1.compute.internal [10.20.5.175])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 5EE2E80081;
	Tue,  3 Feb 2026 13:01:56 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123716; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=NsO3CcZpJy3vZn5aW7th4+gJTUBuHGfSkUbZEuNyJuk4Zxrgfr65qnXOud9a8qh/1S9G9
 NijNoWvVU1GB8K0ZimpXlPKnX+NgF5tGAW8t27vfvmXCeXIflSpH/cIz4h7YSNzQ7aU5sUR
 Xq7D3mRTfKSy1K+rczu8MexvL+BUlHs=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123716;
 b=ksDFULKO8hNppPYJX1Zsbkic/jAgZP7Zg3iF2sgiwmxrgkIKvpctnJm9VIS/J646thoZ/
 mIrWlmE/76XiKf9qV456JqJUm4TC/pGGMSExSD843n2dFfHuYSu767t+HFu9jDSm9HQx91t
 +l87LFhKN+BboaKIH1N5krz5nyoZVbk=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUKP3bpfx+Ftw2Vt5ulCxTkAHIfHAvcohfbMElwnF1fTKxTuH5GSYFKLXtsrZD9EAMxBQln1Ej51hJkSNHAZWd0VIp9GZCbFImtVlvAJA/WDEWh887+m7DxZxCA0k5K3HLlo8XzKtiXmin0ZNUTGTvtDOEDOj7mxYjeecYX8mZky6mC8S6Qp+e+bqnaKqcFLMst5jhh5ARxXk9g4OyFfPPAAAlfYcpFbkBlgrpwBLxz9nyAs+Un5YQ9/F0VeefPfAuXRjNUTeg5O1GNPmmS7kCXaWXXkGIzabquCkh3Snu3u5ZlJVLvr4q65OcNuL7dvyKieYUVlryfguRtPkjpmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=ZtAAzoUOZguDcwTtsaYd2UQzmLYLFRDtH/InBZRk2lRzRcNkngMKNLUWXNWey2Od6E67W62QwrXTDy6g0gMyfymVJ4B93Wp6Mf9PBf1GNuWMo0z61vccYfwIIaKSY92mAmmLym7ybXcz41JmFGwuiriYHIhmYnWtguuuHoRES6PRar4LQuQ4UlaJqsMnn1Wk5FrbrzJLN2NF/w8OUQ38VXWcDlEcf2PbvcrINZt5WaGdApK2hmg4mPUCZOD+G6wo+PPtQhCgZs8H6zEyaBAOrTrEiyxWtvN6w61GapXor3E0jjC0TK7w25et9qWWAZs/b8ATxH6j/KuiHmDRGoovwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=GPlI4hn9VayvporlmpF7fJrh0Q/HL13BeNeaA8gF/S+Rvgb8lhYZhwGtLwqdUlaJCSJlb0K2QF9V8A9nd2dLxT9VBhSa7K9V/+NsDgcf/kOCnxONDQKNieYASTfwe+OqxGGIPA2ASqOVWuVXccGUGMzTC9RrET+yMACPPRNrzPM=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:44 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:44 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:34 +0200
Subject: [PATCH v8 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-1-024ea405863e@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
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
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|DU6PEPF0000B61F:EE_|AS1PR04MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b868c6-9c0e-451f-3ffd-08de6324690a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cjYvUUhkbUx5MnRWTE9ObXduZE5ENnBDeEdmdHFYTy9xQXNoTUxVcmZlcTRQ?=
 =?utf-8?B?MUVmak1TUDd3SmxUekY4WkR1SDJEa0owKzkrNkVHQU9jSDViZVpYNHROa3RE?=
 =?utf-8?B?SDJiMDFqbG4rejd1RUtoekxnT2J5ZjUzVVpyRTBiaXZiaHdBYUxFanZJM2lL?=
 =?utf-8?B?a0hvR1NCK0FOOEpXS0pMU2htZ3RtZGttOGliNzZPd0RsbFdvZ1h6d2ZlbDBh?=
 =?utf-8?B?a1ZJWjVXYnRzdjFrRm5lZWFNa2pFZDRNVVBuN1VRbDJHdnN6VWJ2czYzVlhZ?=
 =?utf-8?B?a09vWFBhWlBYeW9ESHNwRmd5WE5WZExqYk5XdjM5eHlBWjl6dUV0dnpwVFEr?=
 =?utf-8?B?UThjZ1ZQd0ltTGRMZndCdkZCeW1rNGpDMGIvMWxCemZtb2JZZzdObmRYM1Ns?=
 =?utf-8?B?SUVZdlFVRGZhR1dYZkM1cEhtRDMxL21ndzgxNXpOZ2pxMndUeWpvSnVmbzZw?=
 =?utf-8?B?WHZraXVVTEFMclBHa3J5a1lFc1QxMUFVQU1BSlQ3MzFTSjZpbmROZSt3TGJU?=
 =?utf-8?B?TTNPUTdVUzlSOGRLeTZ5QWVMRjVHT0hZTWU0Rk02cXFRcElXY211dkpnZU94?=
 =?utf-8?B?Z0lOZ1M3dTMrOVV0dENhQWRCNmVxbTdxSitIS3VlMFoxeUhPenllRWtyMlFi?=
 =?utf-8?B?UzNzZGIwajBUYmZSQnJkMkxFeTBVdm1OL2xuN1lzOTduR0lFU3pnc3VBbXpN?=
 =?utf-8?B?bDRMYWJ1Z3hCdVErRUFBVENWS201YlpwVW9CY1pLdU1sSkNqUHJvWGhCbll0?=
 =?utf-8?B?ZVArN05mYkp6WXhaUnR0MEF2d0wrL3VWWCtCV1VoUndnMytsbkE3Wkt4RTVr?=
 =?utf-8?B?RUJMbVRnMHlXc0lJTHBIODNKdnJWYTRIeXkxWHpJSHl6SWY1OHZnRmpXMzVW?=
 =?utf-8?B?cnNNbm4wd1h4dkhhS2VyNHozekd0dFZ4QWkzZmFWYmFNZjZvU2g1U2twSzV6?=
 =?utf-8?B?aWZSOHBYZ21EREREdThTUXVITWhWVzVzaDZkWk1RVVY4cWVxWjRyVlBoL0FC?=
 =?utf-8?B?TW13eXA2bkRDSEltY1lvYVRCclp3OXY5SS9YbXpYQ2p0b3Z1RnJjL2hpSVNu?=
 =?utf-8?B?bWxMVU50dHlweTREYldBRzhhSWxaeHdJRTdJcHhpTVprYmpKenkzcjB0T1g4?=
 =?utf-8?B?VFNjVEorTGZTNSsvdnY2b2FrSWxDT0FoYzMxcmFvSUNGRWluTmRidHQxNjJm?=
 =?utf-8?B?cDFhRTJpV2lUc2xNYmdNZDgvcytNNUhyMjhkN1lFYlR3L2NiRjVTeDVVMWhM?=
 =?utf-8?B?djFPUDgwVThkRUprMGZqUnVhYlFjK3dQOGk4V1QyZ0ZsZEdBdEMyNU5uMzVM?=
 =?utf-8?B?Z3RMQlBBN0M5U3FmLzlBckpwa1o1cDZmTHJLaVNFMmtua1k2VVBCK3IraGtR?=
 =?utf-8?B?VzRFd3BCSGtqemhqMG5LRXYzNlluS2Q4MlM5TG5vSmxKRGtnZFR4NDZTdHlk?=
 =?utf-8?B?a0tGTlRybXlwdHhORTE5c0dHM0VhS2drMlRkQk1Lck9kOXVQdXNDYmtRRFE2?=
 =?utf-8?B?c0xCb0R5blpOeDRKYktPSVkzS3d0enk4b1BLSnNYL2U5SS9VLzRvc1lCN3lW?=
 =?utf-8?B?WTdkeGE3OTRodHFYdEtHT2I4Y0dMc2JFaUxsak9qa0t0a1B6dnYwUC8wSWs4?=
 =?utf-8?B?Q3k1QnQxTmo5ZXNGMEpLMGI3OTIvK1dwQmgrenZkcnl6KzB0bC9JT2Z5eGYv?=
 =?utf-8?B?TjRWZXgrV2RqeERlOXd4Vyt0THFSU1FnVHBmWDBUcDZUYUxmZTRmTlVSZ1Vs?=
 =?utf-8?B?VVBTckE4aHEvQWJGbFpYY250SWk2WFloWnRKWkpMazJSbG45eHJWQ1pra0lr?=
 =?utf-8?B?UENXZ2lhZit0d0g1aTRHV1hPT0tZVFc3YmVRV1hqdVFKMmFuYWJ3SkxjTDQz?=
 =?utf-8?B?RDVqcmlENjZPVVI1RDhYVitvalhSZGFMVjlkOXpFUTA5N3NMTU5adG00eXNX?=
 =?utf-8?B?aCtZZWZCMzV6TnFSa3pyYUJFNS9jbUtKN0pWNGZ5UmxDS2o4RjlOQjhmVU5a?=
 =?utf-8?B?RVpQbnpFZjM5UmpobGdyTy8zck9POG12RW9pOGVFeEZ1ZWduNWdGdWdiOW04?=
 =?utf-8?B?SnZXaDRIa29qTkpxaUNPUG1QTzBGbExZYnZUdXNHbktSRHh0b0pQZlYrMXJ5?=
 =?utf-8?B?M05sOEh2Y3h3U1M2TVprNEVjdXBGdkxiM0pydFBLWS84QTRjNTFzVWtiWUdn?=
 =?utf-8?Q?f2rKAg7lnT4dWcYUhaarNxW6GNZbowUBB5klPPgFAN4F?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4dff359c549945d192f999150bef65f1:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7579005d-ef18-4d41-baf4-08de63246195
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|14060799003|376014|35042699022|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3FHR3YrRGVzTi9rRXIwZlV2d1lJenBxUEVBeGJtZ1V2M0hLd24xTlhldG14?=
 =?utf-8?B?SG1TYmxaUUFOc05mZWE1eGNzS1JSYS9FaTRmbFd4b0RYT1l3WkVHVFdZV2Nx?=
 =?utf-8?B?SWxweG9GNVcxNHR4NHpmRnVEQWU2ZjQ0VGxtbTluY2Z2bCtWMWNnQ1V2eG51?=
 =?utf-8?B?TGoxRTRhczBla2E2SzJwbUlKcTFkTVZmUW5IZ0hDN1o4MnpHT1FSZnBDTlNW?=
 =?utf-8?B?S3ludXhhdmtPYm1YWFNaN3gwQ1NyWHZxSlNIbmx1L2NjRk9nSk8rSkRLRmRU?=
 =?utf-8?B?azNsbWJTZkRDQ2g1UU9HT1YxeHROU3Y3dU1NVzdNNjhkTWtOalVwS1RCeVM5?=
 =?utf-8?B?angxZHFKa0VCNy81MzdhQUd3ZjJGblZaRUJHRlNGQ1B4UURzM2thOFVwb1U1?=
 =?utf-8?B?Lzk3djNKMWZmbmE1eGlvQ2dBVFhhT0lBdEJvOUZNZWxKWTJHK0VQanBLbnVr?=
 =?utf-8?B?dzNkbkxHTWZqU1l3eFlQazZjNEY3Z2cyM0JTQVUvaG5nalZlNGhUQ0RvYy9q?=
 =?utf-8?B?c3RhcDF5VzB2T2YvbVhEN3p6VTJsajJKWjVxa1VmbE9udXUvVEYzV21ucnNv?=
 =?utf-8?B?WlBZcExRR1dweUs3WGREWFAvWm1zQ1daNDFsZDJZanZ2RjZWZDVuWGhSUU82?=
 =?utf-8?B?TUNJTjluQVFyd2RMbklzRHZCams0NENzWmp1SU45MGFwdGJMYVY4Y0pTZ0xj?=
 =?utf-8?B?NWFPdGYwOUF6MmM5Snl2Wll0ZzNJc2ozMzJxMEd1M2hnVVZnNmcza3VmRHBu?=
 =?utf-8?B?d250VmVXK2NES1o0TzNaU3JCR0o5dndLak14dHNXSDZZNEdWaTlIUk16QjJX?=
 =?utf-8?B?c3pXYlRtdm5DM0hQZ2JKYUxJb0xEYWlmYlZmczBWRkM5SE45WmE3QzZxaUFR?=
 =?utf-8?B?OWZaNEZRemNrTG4wRHg2ZXdwa2pCTUJrVlFiVjV2TFBScmtRN1BURXNJVlRF?=
 =?utf-8?B?SGtFUHM5dldMWjBnTmMrNUxHdE9tTG9rMWVsMi81bzUwUzljQWh3ZTZxbnVX?=
 =?utf-8?B?RVNIbUM4eG85c0Y0YWx1NGJTaXdWdHpienVrRjJGQys0SFhoeHdhQVdmS05Y?=
 =?utf-8?B?cjJwR05nb3gwNDZIbXhDbXE5RGRiTUp0TzNNUlQzdEdiTmhLUE9vUlIydSsy?=
 =?utf-8?B?bUh3a0Q4WnlsZ0lTUTViZ2VRR2tYKzRuWXBkRjVydFJES292NkVVRXQzanhj?=
 =?utf-8?B?cmIyREJPM0w4THpvU205eXNhZXhzU2xuQ3REYWQ5djZlNFRBTWV0VEhJQ3kv?=
 =?utf-8?B?NExnS2dySktjMDIycGorN29lTmVyQVhib0NtYlRoS0JSaWRVWHFWNmg3TXZl?=
 =?utf-8?B?OGczV2s2S00xYmVVcE1NYWtkNjhZYXpDa255UWNEZTJvdkt4dkxLb3kyVy95?=
 =?utf-8?B?ajdUWS9EY2RUcDg3UUxvQU5NS2NlOGZUN0JoY2lON1Aza0h3VCtTRHg0UzRj?=
 =?utf-8?B?Q0g2b0k2RExXdmhBNWx1TzV5b2h2ZEZJOXh0TmRieWpVcHI1L2RuR2JaTzRM?=
 =?utf-8?B?ZUphQzBINkwreWUzck5ycXRvUHlyZFVJdlYzUkZmVDhVL0EzYk9CK0ZQQ2lU?=
 =?utf-8?B?VmN6S3ZPb1hCQlVoYlpmSE45blBLZWd0TTVXcnNSZ29uZjNYRGN1UUpLT09n?=
 =?utf-8?B?NTJxbTZMVElGcklYdXV0ZVdPclMrT3NvNjZUZnR6NGthdWV6R2ZWMWxDK0pE?=
 =?utf-8?B?Q0x6SkNjQlVMOS9zaDA3SzB0OExBVG9FRFIwZ2NZU0I4RWQxQTlOR3lZRElH?=
 =?utf-8?B?Y0RXSUV4NDRBakNDeTRxWkxYWmRBOUsxc0lkN0c2YUVzSDJqT1pjUjZxcE1m?=
 =?utf-8?B?L3JMWnRqSjJ0ZzZsSXU0SFVydTJ4YWdkdnh4Wkt5OHVJcHd6dzVvUnBzM0Vl?=
 =?utf-8?B?dytzZkxvNXJvUFRaazg4QXpTRENRTzZqSHRjRGhCQUthT1UzRTNKamJEd3hF?=
 =?utf-8?B?blpKVnlka0wxa2xhWlp3MlhOVlN6S1NKUE1LdDZJZDkwMzJQMVdkczQvMEsy?=
 =?utf-8?B?eHZ6T2x4aFJzM2lzcGlxSW5JQmVlcFFLRy8wRHRSVUlDQll0S3FkempGODE3?=
 =?utf-8?B?YXRkVUY1U1dFUlVlS1FjQnJuTUoyNXZSVldMNzA2Wk5QZ0NTMExVU2EyOTZX?=
 =?utf-8?B?WFF4MkxJa0tZR21WZk8yU0w0WVd1Zkg3N1B2VGc3ZUNVbGtvVEFwcW52WTdH?=
 =?utf-8?B?TDBlZkZPQU1DWnFSMEh1WC9XV3FHSUFFQjFpK2FqSXBpSUdMMXJpVmVZSzB1?=
 =?utf-8?Q?rzY3Gvl0AdjjzyDyMTFRNbXVroM0JCDOO4wPea/WhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(14060799003)(376014)(35042699022)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	45bdHqnMM3H9XI9sohkrTCIUD7WOGbbzlpO6lKqopzDmW9qZndnLeSsnuBkWpbFmZedGr1V4/UoJbSYAKhjbYid84rtUBIEMMrcLzf528AFEmlmqWJJuq55Q4zLxDNLeDOEGTU+L+Xkvl+zstOXLnhj2bvHT3J3fJIu60DfWimJE8NAbft+O+MohjK8+RHI1lDiIswBY5FiCZxTAsl2OPa+DB70OOWm6+7+Q3Epw4yClpAcZp3IyyvHFWm4a1yVzM5uTUAdK7TtGAD/0qEcTbj4/ZWYBFRprF2as+YDMEUUhkyHv5f3Og8Ixf2MyVkpiEBp0LU4yWKsmJd4F3kBQJmXaBL0116gf6eBPG+BgP5sh9dh+jLRGVjZ+MpsIvOSFdgrS/sdpjcoa4V0vsEamYqPKfH5cr5NrxLBmQgevqHiLYHNeV/hS6cBSulnJ4HZQ
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:01:56.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b868c6-9c0e-451f-3ffd-08de6324690a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381
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
	TAGGED_FROM(0.00)[bounces-6472-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 74A79D9AF8
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



