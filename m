Return-Path: <linux-can+bounces-4532-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20416B4A148
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CC91B23852
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02412FC030;
	Tue,  9 Sep 2025 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KBAOz/5m"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1BE2FABFE;
	Tue,  9 Sep 2025 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396443; cv=fail; b=VWi/NNxfg4sDQDpRZpgKKINjfXxAPIjwTxfih9nJcjEIMsXRPBSn6KwvknzJcpAaqd1n+UZkjKwjr2fv8XLdPXZ5r8Q+DsbmW6bYmXLhAPXkcK++KGe7rBGSsKVKDyPyvzC4E1b2+oiQ54J4veqvRKYuvyvWp8wWr3afttIf/Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396443; c=relaxed/simple;
	bh=nLMvvWO0Qqi9eWpSjEX74inzRUFG7ffs9Jq3WsDhjEw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Gv0rY87TbY+Y8wEzjKSm77bqNEfwQPmWUW43aThIAXnWq4G3T3qUBleET25AbvyuzebjBBqBAECm6OSrPqMyWdPJzk/DvkDzGpspQoyN4HJE0BcnrUvJIdfcgvlqj82V+b3bzqilHe5qm90/iYgdmTrpZlEd3gHdhSX8RLp7xAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KBAOz/5m; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLKV5ELcUZuO8IQvPgcWrn+MH8Fb6ykIh6/nUzLXb+oIuvm3xlvoZR1E9JWdVLHDlc3sF7p1NcPRlIUK7amJg9buCKyiZLvUHHb1vIjon5hjP7dY0i6XnidS+4GKeSsCNQu+YiEzPDkI6Q43M51xNIW0HsxALEfvSOjUiAIzPoJqw8vXe98ebAtgjSgBA9dIukgOcExM4th0+RUhKN9fI/yiZQF/40BKsQ+l6umjcSVxtlOtY1ipDgFluQmqvhJoM77o49l21fzkP+iLceN7A31sAiHbj+aCDBcORrb5em3OZirr9wHOOtF+dPrrIGHfuSDXjsV38GnIGf2+btIN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jbia6+/L1FKNbo5JpoetA35/628dUxtrQkMvg1sMV0=;
 b=kJj5bXkX0trJpgoMUjcp1BMWZDVdYQoO1YbhuvS146rehspDTduU2Z7dAS8aklNlrr3dD5FKNzog+l04QZjKdi+3M6z/r4Ff+Q9LxSxJQCWRAq0ol+kcA9LvXOIY0Pju/bQ+Qx+F1za0BiCBTXzTpyciPTkwH4Iit8v9m7JtSV2wN6r9nbpIgBrIvkBIqJ7RmCAbkcJ+aDOWDWT9NzvMawe2wKCnmgyiFGuHZvhybblCITconfA0f99X25uXfm8Y6DJS+MUcnZpo1LhHxzMxjUDQtKFe3i1K7qAx2Ei0EVMfJTAgWIW/1vz4IVGEBIKbQ02plGiD1HHDHLLkcPoGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jbia6+/L1FKNbo5JpoetA35/628dUxtrQkMvg1sMV0=;
 b=KBAOz/5m6BoajMNB5CL5gZKO7p+WxaNZSa/4qVKD/Ksv4dXH6nX5WKUNVIYcXoF3TIv4i9sJodS8K+I36cx7cApYCdz6dAvysObgmGvL4KzNUEg2Z6OH1jivMWYXniamZxAvJ/+S8/S3BWWFAWWllouDCj0mLiUIGNCctE5VcoZqYk1g6rSLSyBCcSpNpc6vEBHhu4+KR+6JxK2oPxECjBh9DomkDpByHCx8XH6j2QvS8M2NV/6NtpsiQRT4by59CncN+/Ph7WH65+c07gKn4zagAo90kt+Toh2VvMQ0kb6eks4hk0gMgWMfw05dDYssgWQct4Ce2CkEly5pMx6BmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:40:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:40:38 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:11 +0800
Subject: [PATCH v6 1/9] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-1-1cc30715224c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=2906;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nLMvvWO0Qqi9eWpSjEX74inzRUFG7ffs9Jq3WsDhjEw=;
 b=wihqyjsPLMG5yYUS0vYuIr2BNAiEWa2FI+aUUHeu4KgmsgXrDBgGMY4ibzyjHw5t91PZeGI81
 N+jaAkilmkjD3nLIrRpQyn+tGiHSVDgMyJo3sSeKL7zEqJh1xpt0uqf
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
X-MS-Office365-Filtering-Correlation-Id: 532e2591-cea9-47ff-42e8-08ddef636837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aklWT0NPWXBCbG9zb1ZkZVZmSjFOd3dackF6Z2FZTGR3TXVJZWlDTlVzWXJt?=
 =?utf-8?B?KzVvM2NNK1I3NzF5c1lIczgzNGdHZGdmaWlOdXFnN3dFM216RTNSWFR5cHRp?=
 =?utf-8?B?bTMrcUIrRnBiTWFlSnBTcGtROHlnUXRYdzl3bnFpTWhMcEFPM1NzTlZpT0I0?=
 =?utf-8?B?RTVpMTdJK1JzeGdLdFJqV0FKZ0tFZnNBcHpvYTk1TEJXYkdnVGJjM3dYMTFL?=
 =?utf-8?B?ZEt4YmVmQXBJZHBORnBQdE9Bb2Njanl1VmtIVmluVWdtU2Q3dnJXT3JJdlRV?=
 =?utf-8?B?QlQyYUUyNGNMQkJaczlZajVKRW5KNngzWEkvTzNCNGVwNlNFUTJCcnU1NTNu?=
 =?utf-8?B?VllhdEw5anV1RmtPRUw4NkdlMHFmZUU1bDBLaXR3UFo2dXpvazI2Uk9GR3V3?=
 =?utf-8?B?REM5cmt0MFdPS2RBME1WUjZLYzVnc25sbXVDNVhOTlZmcHVIZCt1dFV5Z0Q3?=
 =?utf-8?B?dXV6T3FLUkVsRlZ5SnNmNjVjOHovWUpUM1N3Sm5RNGd1a1ZuS3VTOURwaS9Y?=
 =?utf-8?B?S2JSZ3VML2tlamp1NEQ3M2N6NnNxdEY3QmdmZDhRdHRXZWVFS3dPaEt5WUor?=
 =?utf-8?B?dnpJT2JlM25MUkhLNzdYUlhqdFY3cThSYWJ0c00vSVQvbUFydVV3d0Q2ei94?=
 =?utf-8?B?OHhwK3ZnNmF6K1FlNzFGamFmUERTZDdGVncrTHc0RzZ6YTU0ZVc5M2Q4Z3gz?=
 =?utf-8?B?eEdPN2sxZ1llNmMwRlc5WXkwSU01c1ZnQ1VKZVpEQVlDMnI1SmdKWlF0R1Aw?=
 =?utf-8?B?bWtvaDMrWk44Qzh3ajFidkZMb3IzZnY2YzArQ1JiaGl0a0o3Zk1RcGRqamhX?=
 =?utf-8?B?RE1FaW95d2FwT3VYV3JRcktnbDJFOVFOQzV5aHN0Y2hxbm1wT0JMSlRkbDZE?=
 =?utf-8?B?TDFmdGU5RUIxaUlUekVQRnk5VHZkVWJOemJ6Vmc4VDVxMUN3V0tSZXZGQi9k?=
 =?utf-8?B?ZHNZZVQvTTZiUkFDRE9TUTFyVkp2QkVqNmszbmMreWxzV0RjMHlTNXJJeUpU?=
 =?utf-8?B?R1BnaFNnZVRMbTVIMHpBbXdsdE1TNk5hcVJ5VElEN1JkbkZEVUpQeHU1cHlY?=
 =?utf-8?B?bjRIZWY3L053OEtUbCtIeGxyUTg1TVZ5MmJLN1RVZFJRSkZGNUhYZ1VCUThj?=
 =?utf-8?B?WWdFdTRBd1BJM3Erc2dSVnhOeWhmR3kzc2s2cmF2d0dIVmVoRHBuVEtPRzlt?=
 =?utf-8?B?SlUwV2pzd1BjdDBYblZhemJtQnpHVG41aURSNDYvVEdyMTRSVmN1TXFaTDJJ?=
 =?utf-8?B?Z3B2a2RvSGM3M1dHc0dGVHJ4NlZSOGRXM25yeHhsYi85d1NDRHNTVGJML3NT?=
 =?utf-8?B?eStseXN0Y0FKUjVNT3Jab0xsckR0R0N4bXlTSnN0QVl2bzRweGhkZkJxSUsy?=
 =?utf-8?B?YnRha280RTA4NFFYL0RMbFFycDVmbXorN29oK2NUbkRlZ0EyUjVkcjdmOXVn?=
 =?utf-8?B?Z1lWNmlGdHdJUGM0ZFNNNmR1Nk84aFJRM2tZTTI0eWsxMTNxNlI0S09ZNng1?=
 =?utf-8?B?UXlMVkpFVzV3VWtRUVhSMUdvVTgyQ1VCcTNBeVh3VUNnZ3BqWTFiTzJkUDVY?=
 =?utf-8?B?Z3AxY3JVb0tIWWNTYjlaei9sY3hhVytYc0NCcTJjckdENzd1SlU4Vm5NdnZr?=
 =?utf-8?B?MFpNRzh3QkY1QmU1NEREM3BReGNEUklyd1ExUjBHM256cUtHdzcvUjZJdTN2?=
 =?utf-8?B?NUhabGZzVUViTlNWT29Pamd0Z2p2M1U3WmFxdzRnUkxrTzBGZnM1TW44c0d5?=
 =?utf-8?B?T1pvUC9wUEkwN3JYM2U1V0FxVVNPSnVhVXI3SlQ1d2VoS1pmSzhWelVzQThJ?=
 =?utf-8?B?eU9OaHZCdkprUTZkSGlPN1hGYStZU1NaVVNKaEh1NlVoYWhDYzRMQ2I0RFRs?=
 =?utf-8?B?eGhtdkd4WitiSzhvUS9ZbW1LcHpmbW9vUS9xd1ZzbTJEWWhCbHUrRktIeDRa?=
 =?utf-8?B?ZndMM08yamlBVFdUQ245djAvSURKZDE1WXBlekUwM0oxT05DWkJXR0J2TENq?=
 =?utf-8?Q?cM/IrJ0DhSmRlul9OlCbkzprN3nEu8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEVsWVNtdjdScVIvTnhQR1drbnMrTGpJOFdnWTE3QlRTbndzU0NkWURuUXVF?=
 =?utf-8?B?RDBmbm1yZ0JQRlFYZ2pkQTRXcGZSem5mWmVtd3VMaElIWjAwRWozNEFmNmpE?=
 =?utf-8?B?bUFscTNudnErbEJqcVpod1J3MmF6UzhadGVYenA5Wi9Ha1dzR0VNV1U2Q0Ez?=
 =?utf-8?B?TXVXREw4L1BWZ1JFUElRdjVaRjhucFpWZFZBUHZrRW9iWStmdEFacDd5Wngw?=
 =?utf-8?B?TDdKSGs5RVRSZ3NaZXgvNHZXL3J0MEdEK0R2bDFzVkxtcGJ1UHpDK0JtRHhO?=
 =?utf-8?B?NFBiTE5MT3ovalpWSVJPSGYxOUsyNlBqTVpzOW9XQXhkbWRrREQ4T1JnS3VY?=
 =?utf-8?B?UEk0bFYxcmErYXVVYzBSYm9sR1RxWWl6MS9ZTDEyOVBXZ0E5S0NmcFRMS3Vw?=
 =?utf-8?B?dzN0M2xMZEkxUVJCTHRhWlJWS2hyaVdWYnpZUzlNQmR2Z01aKzNJN2hXTFNk?=
 =?utf-8?B?SU13Z0ZyTjJBTjBCMTU1dUREQU1ZRlVWZU9ZL2dPYUwvdDJqZVlRUkFoSkRQ?=
 =?utf-8?B?MkdaMGFzZytPZ3ViNEhmUitRQzBQRlFLZllDT1pIYThrUUJTM1RQSGZlWFRC?=
 =?utf-8?B?dkY1RFZnOUQyVjYwRE9ncHBEZzZwMlpRZ2hsc3g2eXJTVnQwdDBBa1cvSm81?=
 =?utf-8?B?MUNieVJTcDR2b3FIODkyRnhMcVBSMDlCUC8wSGdHd3ZEYjh2VjdXYWF6eXEy?=
 =?utf-8?B?RTFxak5PTHYyUHVZenA1YlN0MzNnanpxYktOZmdOSytPR2w2dHhJMVU3S25O?=
 =?utf-8?B?TGtEdWZzUU5aenVUS2xBYWF1STFjTzV2R0R1cEM1WHlZZzdPYnVidjljUUpS?=
 =?utf-8?B?NTN5a2pITVArb1JsUXdMei8vTG81a2F1TWRZNXB4amppTWN4anFNT2JUNkk5?=
 =?utf-8?B?YmFpVzBNUXRZQU5BUitmNjNicHlrcWVPcHViSGEwclVzWFl0dHN4MnpvUm9o?=
 =?utf-8?B?U0xoL0thdllJZjNKVFRROWZuN05EZi9GQnpRRVBCYmZRYUplQnhHaTNoS05O?=
 =?utf-8?B?WTgzTXlYYjhaNmpMZlhaelFWK3BUcThFVThVTXpjMEVRdVBabTNiS1hhQ1JX?=
 =?utf-8?B?ZmkzaUl2TjNHTEZ3WitjdEFVVkVBUDBkNUxpb3BPRWJqWFlnNmFGTkI5YXh4?=
 =?utf-8?B?emxPRHd6cVZzYkZxY2NxeTJtSkNvUUNSYWZCVG1jNTBSN3NnaXd3TnQvYjMx?=
 =?utf-8?B?TTFTMXQ3ZjN5NUthQ3hMcDNwVlMwM1hpd3RQS2ovMXFhbjZsNFQvSjU3cEF2?=
 =?utf-8?B?bXZuNjNZZGdtZ21BUzBQQzI2WnBEWWR1RmhKcXZZTkloZ0thdUtJZWR1SjB2?=
 =?utf-8?B?a1pKam5wUXFSYTlPaXd5WWRkMWw1M3JFY3lxa1YvU0l0YUIvTHFEeWZmbTJD?=
 =?utf-8?B?MFdKMXB5bHVQUUd1bUxkTW04YndSQzFyandhaEZ2Qy9sc3dxd2pXNFU3RTM0?=
 =?utf-8?B?VmM5SFJQeFJPcHVTMmsyUlNkL0hQMURzVEI5Y1I2MytHREN6c1FMbjk0eVM0?=
 =?utf-8?B?OTZpUGNKSEFRWGtNTC8zQWdQVGtSRXdQWXVtT1B5VWEzRlhGUE90bFVzVm9V?=
 =?utf-8?B?OFd6eTJ6VXJCRnV2Z0J4RXgxNVl1WVhMOFFkTlJtbkhUai9TVVFQQmtpS2xl?=
 =?utf-8?B?MWlQbzREdlFFR2pRd0VzWi9qaEw4bjFyMnF5OTJXdWF3eEtXUmMvZ2lNRFVL?=
 =?utf-8?B?bEx4K09vNzAzb2x3OTZPNVhDa3J0WGxtREE3dXRibTJmNlFEOTdTbTAxV2tK?=
 =?utf-8?B?UEliTWlRUzNVaitRUHMyLy90SW0xVWgrTTZGUjBCTk9xaGxlTjJxRXZSVzFu?=
 =?utf-8?B?NFNMTHBPOVdwcUx3U3kwNmdkTXRLT0RuQkZzNUJidXZudVZuSm5CcVVJTWFG?=
 =?utf-8?B?aWk3Q252UWNuMVpHa2EySldEbjVZdHEzdjUycTJOL1dPMGNzamtBcm1wN2Z6?=
 =?utf-8?B?M1cvSW0vYUZpbitZbzNTY05yVTYwZ2lzZmhDbHlLazd6NTBiZDZKNERwT1Vi?=
 =?utf-8?B?eDNPeFl5NlVIeWRqUDFCeVFPZEpmODJRelA4U2ZXVE4va0M0M0tkaWsvOHNO?=
 =?utf-8?B?WDBCMlYwOG14SWY5dUJPb3p4N2NRWUtjWkl4cWtlUHBwSEFjYmE5bUF0cjZ2?=
 =?utf-8?Q?Mv6c/MSAlfS2sYDgf024Oo/cu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532e2591-cea9-47ff-42e8-08ddef636837
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:40:38.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM0JfUqs1SKZz/bnH1k+Ki+4Xb8m7D3T2NFJs6ULIkvvbgt9/ISvwF1h6zCnd/0fH6E+bML2Nrat3B0jOj6rtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported
and no EN pin.

The TJA1051 is a high-speed CAN transceiver with slient mode supported,
but only TJA1051T/E has EN pin. To make it simple, make enable-gpios as
optional for TJA1051.

The TJA1057 is a high-speed CAN transceiver with slient mode supported
and no EN pin.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 69 +++++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 138923ffedfeeb6a0b391cae863723ec70bf2c88..c686d06f5f5619552bf041c951e36b71cb68c2a0 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -23,16 +23,26 @@ properties:
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - nxp,tja1048
+          - nxp,tja1051
+          - nxp,tja1057
           - nxp,tjr1443
 
   '#phy-cells':
-    const: 0
+    enum: [0, 1]
 
-  standby-gpios:
+  silent-gpios:
     description:
-      gpio node to toggle standby signal on transceiver
+      gpio node to toggle silent signal on transceiver
     maxItems: 1
 
+  standby-gpios:
+    description:
+      gpio node to toggle standby signal on transceiver. For two Items, item 1
+      is for stbn1, item 2 is for stbn2.
+    minItems: 1
+    maxItems: 2
+
   enable-gpios:
     description:
       gpio node to toggle enable signal on transceiver
@@ -54,6 +64,59 @@ required:
   - compatible
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - nxp,tjr1443
+            - ti,tcan1042
+            - ti,tcan1043
+    then:
+      properties:
+        '#phy-cells':
+          const: 0
+        silent-gpios: false
+        standby-gpios:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1048
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+        enable-gpios: false
+        silent-gpios: false
+        standby-gpios:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1051
+    then:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1057
+    then:
+      properties:
+        '#phy-cells':
+          const: 0
+        enable-gpios: false
+        standby-gpios: false
+
 additionalProperties: false
 
 examples:

-- 
2.37.1


