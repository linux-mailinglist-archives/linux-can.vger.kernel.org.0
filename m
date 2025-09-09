Return-Path: <linux-can+bounces-4539-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38BB4A161
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D401B238AA
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092F52FF65B;
	Tue,  9 Sep 2025 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/aV49xQ"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C9302164;
	Tue,  9 Sep 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396484; cv=fail; b=gIVniuH7PuUi88B9YSjWbr3tO7K6nzlcOHZr6VwofM6qPJBXhbzj9et1J11WxnWXebLSMU52iy2zsGsmd8u769/0b/ktSiQamwsV2bkok96eI5FeCysFi4l4J6RTm9s19LK6uJ+fQTEfgpT5DkgaIMVJPVSz7Cw7N+7gnInVsrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396484; c=relaxed/simple;
	bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PoiunIJOxnfMPvtMYfdlrgs5Koq1CkI0U7w1bBI3pYqdInnq28RVs9kB/mOkirg8Auz+so7LXVG4+1881M1kCyEnPskt55M+PwW8qMAunqJS8hTQ3AifSgrQ38QMKxylnettVbMAHdkDY2ez92MLycVzCVxrhwZCfSSmWapKRQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m/aV49xQ; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRGoSOi6FT+I2Ge0kW6HLxusf/re96GVqGfja3jlZCRXF83tL5z4FBT4UShO4sLW5MLYLslx5+Px6M+/PEp4ybFyQDVyki34Ic7cAMXRLy2ZhMc9rmMgQy3EmO25l1WsQ8JqcLdnqvdSmO9T5kzTuPQckjxMNU3inzxxLusDdaXqWV4ufVqDdPmMenRzGjMqgdnVzg59C7TAWUP2UvD5wuUTJgIbDuLhrNrjjBOeB9tjDEYwxB/B6t/ak1bsxxPhULgo6SwnqiOoYoTRlX87DMvjf5SuHEIJ3LIWvL36odg8xXYH7Zusll88jMfaN7jCJc1K8yug4MReiFz3S98LUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=qrAXsbVGCeRZSWC+GPo1Vm0hpofPMWSDn8AMjPTgA6SNwdvTLgiPgtpOnucE7fSGyui+4szLIlGJCWBaY1/fSwWT4/T5xKeWA2aF0RKiFRQM30dkEed/JmB4GM3pbafrMb4OUPbVTWpSZfqJ1MMGSCoMLe55N0ngaCMlGaEtRrP+ms2Ng4MdKSWtdCxqOXKV+ueauFPJfz6/K8OmF+s+UmLGAknF6pZTfwSfvR+UCa910LDe/Fklu4nmWGuzCFPzQGtUMXMyfO2MCgl61e+/VZ841H1xyqNSnxwslDvperQfIA9uiieyNP8RCYwQyzPmdrN1WuCiVfa+sQpQov721A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=m/aV49xQZb+ujC+b+p7t9LoljkyWK9nSeuB8aTfhYgBKMYW49mBmu8IUZhrgFf/BfRBTzV5DCXx0FtvSD/xxRdHdqo9roj0aF/R1v7d+2jFD3uVU0SswjQ6lL2z3WTL+QguFDrJhC34fTpuACuWs8I/6krui5cZpTkU0lnDLzLj962JQalRlFLqW2oYkFrhSo/aJC+WR+ac75LBzwjtWFdcaCseB5aJjMbcO1voQh1KZKbH2SNppgeaTYCdAvn1LA7y+VOX/nbEyGexNlRGb1m7QGRWktBL+AK7+Rt1Ry7hNMrxgNJDRxKGav9h/F4k/m3hnS3e6ZCNJPagPtrpn7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:41:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:41:21 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:18 +0800
Subject: [PATCH v6 8/9] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-8-1cc30715224c@nxp.com>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
In-Reply-To: <20250909-can-v6-0-1cc30715224c@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=2835;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
 b=sUe5B/9QKjs6ss40mKgV0voy7BUW2g4Q+FtIqpii+eHSlmzsA1jNj2i/O4vxcEfPfR6h7B6bO
 SDQjWzsqVs1CU5fIWgVp23ljrtdsrTpBfTIZwoEFojvPGtp86aDIdNJ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5fd062-6b2c-4680-0a3a-08ddef638121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUJtb2xiYzFSeGZuMndzd3U0OGxaL1lNUFFOMjhhV21wNHNrWS9MaFJvckh6?=
 =?utf-8?B?eWFHOW1NSW9jMTJXWXhpNENld0Y4aDcwaXhLMXdQQk9wQ2Mwa0hNYUFiWHFp?=
 =?utf-8?B?WGVPV0xMZW15d0dhZGRHSEVnVzc3RDZ3QWZHZ0RKYzFsQ0RNdkV3QTZDb0l3?=
 =?utf-8?B?VHZwZ0dqa1hxckg2Sis0UjhBdkNOdWJ0VXB2UmNocko5NWRYTnE0ZlJkb05U?=
 =?utf-8?B?a1RkWlA2MFRUaXI5dVRSWi83Q3JWY1VPb2xlMUoxZE9NVndpVi9MR3NWQ0xZ?=
 =?utf-8?B?RzZWTUNpQVR6YVVuQWRSMS9XL0NBWE9mYXJDZC82UDZnSUM3TzZ5eEhpSWlT?=
 =?utf-8?B?MlZIbm5Ha3lPWHNRTFVQa0szSk5lNUFPRVZnNzE3cG1lTDhlKzk2VnRjd0JO?=
 =?utf-8?B?T1hXSW5wMmViQk56WW9zb0hDV1Ryd3hONk1zSGRQZjhJOUFQSWNFQ1A0bkFX?=
 =?utf-8?B?WXNjQXhjdUt3bkVUWkJEa3Z3aml4NEN4ZDdSNjhWU1VPbmNnaG1SdE45QTUw?=
 =?utf-8?B?UVp1WkR0VnBLZXNUN1p2cGVLZU9UMkgrakV4R3FZU2hUcFVFeEx2REdZRDJ6?=
 =?utf-8?B?Y216bTJsQ2ZYMEZyWnB5U1FRcXUvNURiRzRuYTEweDFrSFd1VHViQnRNL00x?=
 =?utf-8?B?aTVnaWVBMkJLYWNlL3lOSHlkQnRWNnhXVHdEUUVlZ0tjMmk5a0RhWVJpNkp2?=
 =?utf-8?B?Nk04Zkp6T3hwWVczKzV6NXpXcFBNSk5pd0ZJd2dMYmo4cW9kbFkrWEtFWk1w?=
 =?utf-8?B?NDNHS01PZEZVNmxUL0RJa2FRUTJoTXBCdG1tS20zc1FSZXgrbUFHSFFzb0FE?=
 =?utf-8?B?YnBOVktpNWVlVGJiZThSS2ViSU81Y3BVVFZRL0pjNXU3SnNRVFNwa0ZXd1No?=
 =?utf-8?B?MUtjVy9LdDVRU0xSQlN5ZjY1TE9zZ2F2QUxMTEFTeDRYMVRQSmpuM3cxQjNa?=
 =?utf-8?B?aGd6THltZ1pYOG9iNG9QN0h0V1paNUNJamg0Z0hmRnZicStheW85YVhSYmtt?=
 =?utf-8?B?QUx1RXEyZjFoRE56WDZZVHF4NG1uWDBrNTZXQ25jcXFrSFphNnl0QTFXQ2ZT?=
 =?utf-8?B?ci8yMllscEwrdFZ0cHcxNWoybXB4WWpUT2FGWTltVmNKODFDNStrMU9wTk5D?=
 =?utf-8?B?NlR6V0puM3ZsNXVBZVliYmRRS1ZIY2xEOGR1RVN1ZkhhSE1JdEVSWmUzdDU2?=
 =?utf-8?B?QmhqUnhOTVptbnhrK1NXRzZSWEhYU1dBSmtKbm5Kdy95OHcyMjhyMHdLQkYz?=
 =?utf-8?B?OE1pbVY1ZEU1U084dy9IMGNMeHc0ZTRSVnlVbHRsU0Q2OWxhRklGcDB6SEhn?=
 =?utf-8?B?aVVmZmRxNDVIMXRrelhITXhpbHFCK2QvV0tqSUs0bnFtSk9uaUVmTmdDTUUx?=
 =?utf-8?B?Wnc2Um9qNTZ4UHdIZlZSS2ZNbWtpUEhJeUhxMGk2bW51cXFuUDBqUzZpa1A5?=
 =?utf-8?B?Wk1PT0JFWlJialBLNTY0aEFHTW9DQVZDbnZkVGFnOVoreWVMS1pjR2ZoRDZa?=
 =?utf-8?B?T2RBT2JhdGV6VGJkT0lIRlMxZFhvcEhZcVJ1eWJ5cCsyVzFQSVY5a3pVSWN4?=
 =?utf-8?B?VkxvUFByY2YxeUVzVG5VdzQ5THRSS2tpVzVyVXRyQU1hbU55UDhUOUd5R3lL?=
 =?utf-8?B?c2RtbmgxN3JueEZPTXV2ZE5CWlNwVXE2ZkFickR4RzU1bGl0SFVlcjlCQ3hO?=
 =?utf-8?B?cDdVL1hBVU1qcHRMYXVhTHhVTHFocjNiYVppRlNFaHIySzFkZHpIZHFUYmpw?=
 =?utf-8?B?V001T1V5Zk5mcS9Id28vNzdaYjdqNGNDbks4SDZUV0pZQ0s5NEN3ek9UOHZN?=
 =?utf-8?B?ZFM5a1Z1UC9PNnJrT0V3QnVzcDBRZVVBZnVDYk9CdlU4QmQvVGtnQit3MVUx?=
 =?utf-8?B?ejR2UzhWblpDelVlWGIzaUh5ZXFHcXFNTk5oM05MeDk5KzRxSng1WlJ0MjlC?=
 =?utf-8?B?dm10d3J3VHdGZEhEU3RlRUI5dHY3bGs1OWsvRTRMVTRHTUlMUURiYVgyZ2tR?=
 =?utf-8?Q?wZKXzarie1sx313/GgO5h7R68mUiwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dCtJRVdVbEFJR05VNmVEcThSNkZWZmRaR3RjY1pBNWNuS05CTXh6YUVVWXF0?=
 =?utf-8?B?OXZRSlBZU2RwaUhMOGFtN0dVSzY4UnJhZUtMTWZDK0cvTlFDdmVtS0JZc3py?=
 =?utf-8?B?aXpsZ0VhdG44WWdwNVhGbEpUWGFPYXdyMWxtMS9sV0l2enZ5TWxvZEJrOUdZ?=
 =?utf-8?B?bUNIR1dRQXZIMVVBY2wydXdGSzFETlBDNkZ2Yk1hMG9NVTFHZlZINStlQVoy?=
 =?utf-8?B?bkdPVERSNENEZ2xyMTIybkdWWmxDREx0Rm91Vi9BMTV5VHpxRERuWVNxNmRF?=
 =?utf-8?B?MWtEKzVaRFExS2VxQ3BoMm01Y1dkNHpGR294S2JKdjdBMk92MWRRS3Q4WGZY?=
 =?utf-8?B?S0w0NGhRSVhEdGFxZGlqakE2TmFNdzhMRnIwZE01VkpQTlZZVTZVblJ4UlFk?=
 =?utf-8?B?Vi9YWnQwRUpBNkRCNEdRYlQrZWVJeGpIQjJ4NGVFTCtoUWZOVi9hY2pvaWJB?=
 =?utf-8?B?NXhXVnZadE9NUnRkVEhVY29mR3RTeVV5YVhsZ1h2SE9rQk1nUnkvNHoySGtM?=
 =?utf-8?B?bFF5c2xrYlBqMWZ4UCtPNlNkSTdhM3JNQmFlakZwenhKUzVYSnNIbHVPT3dy?=
 =?utf-8?B?T0hIU1E1M3VMWEJpVlh5bmlmMlJ0Y09WSk1LdlIvdUVyQkpQWTZiT1pGME1D?=
 =?utf-8?B?NFE0OTRKS2VMZDlqNVNZMitoS3ZWVDF0RDQwMzJrdnkrajJkWS9Hc0pvTFJX?=
 =?utf-8?B?V0w4SExmaGRYck91OFhESWZsMzgzZXUrcEpKbHhPTjJtRVBoY212NHlGSWJT?=
 =?utf-8?B?dDIxNE5HZk11Rm1HbisvUDc5SE05NmUxY1FDK2VXSWM1QVpBWCtwN2x6WjZS?=
 =?utf-8?B?SUxDUDVIZmYrMFQrVG1RMEhKbE00MU0zL1hqVWljcGt5ZHFMZjhINWQ4cXhk?=
 =?utf-8?B?eU1malRHZ2hta3Job2Q2ZjJIbjUweG5GVTYwcE84OXJnM1ZQZGptaFFCK3U2?=
 =?utf-8?B?V1BFT3UwZ2k2OTlDRUVwRHhVdGh5YmR6ZHV4S3MxUTZwazNFTm9jM1Bjeis5?=
 =?utf-8?B?Q2grL0V3SnhsYUdWRkh2RlRuQ2ZrYTIrcEJGV2lpSkpiZi9ORDFTV3pOaWQ5?=
 =?utf-8?B?S3daRWg5bE1RaEpHeVZCV1k4NURabitYSG9GYTdaNzVkRGs2ajB1M0djTkVz?=
 =?utf-8?B?K0FWUS84NHpFenBoOTF4eFl1YlNUNmgzTWhFeFhCdzdEUjhXMG9IckIyYVNi?=
 =?utf-8?B?ZDM5cmw4YW5obkp6dlhLZk5QdTVqRGpYK3lXd1FxZGxNSm1qcWNMN2thZ094?=
 =?utf-8?B?SXZLZm9zTHg3V3dnTGlWMHBYQWJtQWtCZHlweHNod3c3b3FrMHV2aTBGeTQr?=
 =?utf-8?B?MnpDWnpreG55aFBmVThDMnlPcGZwQnBiRVo3WXFTS1JzZWN0Z1pRNEY4S0Zk?=
 =?utf-8?B?K0JUL0M5aWdHbm5oRitTYnU1WDV1bTVqU0hYSHNqT1B4dnVYMEJMOFhkY2dE?=
 =?utf-8?B?MlNwblNITkJTcUlBTDVmaWtYazdacnZPakRFZTlWSVdMYnN0TWt0bW9IbGN0?=
 =?utf-8?B?NFZ4MzFHNnJDZ2NRbzNrMzd6TFQ4Rno4aHdQZEZ2d0pLUlhLOUgyK1JyWWJw?=
 =?utf-8?B?YlgvNHBDUXF2blh5QUZpOG5ySlE0OEZOVTVwU2xIMTl1eHc1cDhoSVBzUjNp?=
 =?utf-8?B?MDNVYzJUUi80WmRyQVFaSDBEVmZRY2EzaHBSSEdVQUVYQzNwZGRMSkpRRzMz?=
 =?utf-8?B?dG11a0lORzdhY2UyMk5IZXpIcU1sQjdYZFpURFpCZmRITS9LcE15OVY5Vlhs?=
 =?utf-8?B?RVp3U0phNTBJRVU0SmhVWTYrUHpHVDFxZWJpbjFJSlEvVSthdEliQmpKM3Bn?=
 =?utf-8?B?aTBWK0tGbUFUR1pIV1FvRGdSTmxpa2prY3d5ei9NeWxJT2NRU2xBR0dnTFZq?=
 =?utf-8?B?S3JMcUxaZ3NkY1UrVnUwKzBQVllhTnhIWGRrenp6b0pSTE1ZU0NSOUpHV2c4?=
 =?utf-8?B?aDV3R3lFdjVsUGorK0NmVmpVWGprYXlMVEFHWUtJMFJpYkw3eE1pTmtCSGFi?=
 =?utf-8?B?Vm1UaldOZnhaQVc5MlhNdWsrL3BtWTlCaExmME42cUFaa3p3dmh6REFrRHMv?=
 =?utf-8?B?Q0pvdEFIK1NkczZERHNHMXo2QWo5SldSRklXMUpIMnNDMDA2RUdRcHh4WmdK?=
 =?utf-8?Q?5OhhvHzmZNiULgRsC31dBXmKv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5fd062-6b2c-4680-0a3a-08ddef638121
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:41:20.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5GO0BpAHPmYOSWUuTIc9vrKqlD6HNbkFgkqg+Uf8Kn6mVuG3qXkR0Ccn+1IKJBnSubblXuP4I/wI42lIF40VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN transceiver,
not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf5010213cbb9f6869a8110ea28eb48a..59891627dc462d37dfd620eb68b893546cc20d6a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -56,6 +56,16 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1048";
+		#phy-cells = <1>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan_phy>;
+		standby-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>,
+				<&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
+
 	native-hdmi-connector {
 		compatible = "hdmi-connector";
 		label = "HDMI OUT";
@@ -103,28 +113,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can1-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_pcie0: regulator-pcie {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -431,14 +419,14 @@ ethphy1: ethernet-phy@1 {
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
+	phys = <&flexcan_phy 0>;
 	status = "okay";
 };
 
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan_phy 1>;
 	status = "disabled";/* can2 pin conflict with pdm */
 };
 
@@ -903,14 +891,9 @@ MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
 		>;
 	};
 
-	pinctrl_flexcan1_reg: flexcan1reggrp {
+	pinctrl_flexcan_phy: flexcanphygrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
 			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};

-- 
2.37.1


