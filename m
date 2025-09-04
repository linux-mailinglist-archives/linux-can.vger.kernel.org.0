Return-Path: <linux-can+bounces-4471-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0454B435FB
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF331BC8B46
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FCA2D2482;
	Thu,  4 Sep 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Osea4vEu"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241622C21D5;
	Thu,  4 Sep 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975072; cv=fail; b=IlkeD4nK+2NB9A4AiRkBg0995UHps6dhX4Ri+od8x/U+FX5j1D7gMB0ww3JcHd7oy1AsSoCIOFHTV3Fl4LHdbzGthaguIT/iabs9gdR63x/YkX2m4pEemyHmXe6cJpUnKmV+vjwOCsolo5R693CsbrfazceUOVDbU0Pv1dbdxdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975072; c=relaxed/simple;
	bh=gCIkVJ5687w4JC/iXH2zdfPKdy1y9n7kFucnRZ0EZx0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mXoKVRi1QHRNPkqJbWWD5zN7TaCi1IoBHyEtM72j+2oNVn6B3zMjgTcPsVlQVWbYF21Xrh+iQr+lPAAac+21q66GwRKe8hcM+l4d+YOYPOEtCxULw6Rh2JJrTxx7AA1Cro6ZzIazDDDI+BGnSG5JZHPQZuveaeJUZ96m7DwSk7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Osea4vEu; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/mFmJCdM58kP3XMx5fOLLyqhuytzY2FZ0rNFEK94tHiYP5yrgr2Shytf+Oe/LkoPfwZNwQB+pVZtkXqoA0wu8OLuomC8SU5wnJf1O7PjGcgQpQR/OGquzOO6Jl1g1iIMEN/VVvR8n4kE7L/ZJisZbKTiHv93M/G8Fm8XEOMYpMUQUHsE86sD6a8Nf9nsfrnHaaf82Z6583yaFQoOQgZrWMtPvDbb4m8PCyfTizds/F9sJcV09NGnflCCbhhAlwN+BsAmK3CK+KRo22/lX88Nhwbi1bR4zVPgHZY3at4krq+pdecVhC4n8zUww4lMJBkPuP0kqVz4z1E33g6eQVI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4LrV5039zmXiZB4R2+yiz3v81A0BrqjClljoXVA8DA=;
 b=VK1yQ6XpqdUIFhUuvIR9TbuykANP/DpaGbJ/WXkgBS9QzmOC3kddYiQ6A0qGNGN7/dYytdqXsN7aozDYnXJ7x3kVJ2rAgMlwiTXmCpVWyk2RxgYNjLv9af3+Mt739FMrQQJtrbeSqBkTYZt7GDdHuIM8EwPDvvoJL9rWbiNpeLxbLV4E0LUA/Ruc+dcZevfiHBHhJCDPe/4OviextW8Vz8iJm7VzKpfMU/ONMKjS/hQmUajjBtwGWpes0WAs/e54DkHQE4VTC7Dz0DTYuUy5sywNYV/SfpJ2vhyNzRzQRsysqUiRcvryiJK5Dylzcv1qloVCcMrOAjq+91CJK192Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4LrV5039zmXiZB4R2+yiz3v81A0BrqjClljoXVA8DA=;
 b=Osea4vEumcTBv941Orfsc9KjCxj0vTQuDlkCdFU34Q7rz6HFWWcB/+C0B9Jsl2sxdBcwg4pBM0mE2Uu7n4QdvJv1AFQoqWeOvqkkQFv2cpNl1LGne0CW9Pn/W+jUUnJRZGj7HWWU3FtSE7vmenqTsglyWdtkN4Kg90FiqR+XxDeBpM2qc3VHxxjvc/mkYEolA9nwXmKfSMlRIZJhuuArqM+vtF8WnCsBljoyRji4JnG5wVcHqHws+QiTzrzts7MXUA83WVxx08yaTQDafUA3WTMwPwxJZbGW4dOtmg4bja6fr/MntAC8UIo5U7aKdnBqykA/PK+7sAE2h6wa3pOX1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:47 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:50 +0800
Subject: [PATCH v5 7/9] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-7-23d8129b5e5d@nxp.com>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
In-Reply-To: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=1466;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gCIkVJ5687w4JC/iXH2zdfPKdy1y9n7kFucnRZ0EZx0=;
 b=BG18LmANFjr3/XoQTB5rm4EBDRWiwHiFL1FxtRJsEwTEkPBgQtqDYNw15zIQTN5ltOc8EBQRc
 ZWBO3l/0e/4DG3726MKumdY9Ig2BfK5mmOLcjzpJnMIa2hPLJPWFDqs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abe24ac-baf9-4139-5888-08ddeb8e535d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUhoWVo2bVJKdEZFZWYzcEFsWjRhaEFKQmNyMHppU2cwSXBzTkg0ZHFGaGtm?=
 =?utf-8?B?WTQwYUk1Sk5GOTBkSVJHbHBtUy9pWG9kVWVyNFNRR0VIWWVCeEhDSllHWFRt?=
 =?utf-8?B?TStwQk9wMVJoTXA4L0xucnRMRDVaL1RGMWdWYmZUM1ZwRitldW9CZW8wZXFD?=
 =?utf-8?B?NWdSZHFyWTJFc2EzdGlGd2ozQzhWQ08xQ3NxbThUWjRlT2taT2liOWUwK1pH?=
 =?utf-8?B?TDMwaWl1d1RPVmdlYUUzV3h0Y3ZuVGw3NUpGNnN4NnpxNENmZ3FnVGRYSTcr?=
 =?utf-8?B?RXBrVFloNUxlLzVML3VBeCtxNjZCc3Z3cFFQRTJBVTJ3aHk2YjJPRHhucWZq?=
 =?utf-8?B?S210OG9NZi8wNVVrSkFJK3MvTDRyT2M5a05YY1hIVXpqMXFWeTBNZjJvRjRU?=
 =?utf-8?B?VHhZamxOY0ZZUTFxVERwM3pPV2VKTHlGS29wcUUrYVhYVisreldRMXJyMHhw?=
 =?utf-8?B?dzcrb01aYkh6Z2xzRWlWM3h1ei9ObS8wZ3dKaEZEalQ4U05TYkVhZ21aTEZo?=
 =?utf-8?B?cDNDRWtSQm9aUVRjaFc4Qy93d2VXM1RUVVcvTVkzcGx6V05PeUl6S0Q0b3NG?=
 =?utf-8?B?Z3I1TnF3RXp1QWNYUENQOHFsMW9nQ0dOQ0hLZ3ZlVGRFR01Eam5NN1VockNN?=
 =?utf-8?B?b3g1djVlbW5TZFRCdkpVN0YyUHJldFo2ZDdjdkMzQzh1d3R2ZUsyUlJoeGNu?=
 =?utf-8?B?VnJCVS9VeWZsV1hzNWszRW5hNGxIY1FUUXhwbUJoOElKanQzeE10RUgra3Ur?=
 =?utf-8?B?K1JBcUtHZTFLUXg5N01aYnNLdDc3bGpYR1QyOXBwdmRtWlRKcWZoYm1Mb0FX?=
 =?utf-8?B?S1pWd3hwT0ZVaW9CY1dxWlFmamRxK1laY3pJQ2crWThSSmY5a08vbE5mNDgr?=
 =?utf-8?B?R01yaFMrNk1EeWRneWc4VHhWS0w5TmdaRDg1aVRFUXZyUTZabmNqRmtKbTZK?=
 =?utf-8?B?Skd6UFpHa1BQYktmRlp2SXV4WXIybGlzcjVTZUQyclVWcDhjZGN3RWxjMmlT?=
 =?utf-8?B?QVJ4bENXY0JwVWcwancwcEpsdXRHMkFxUDdEcFIwMVlNQ3pKQ2NMdmswSzYv?=
 =?utf-8?B?WlVCTUtLZ2Y4amRMaHU3N2czWkRLeDNFMytXcm0xR29Vb1JzTmVOTk1ZaFM1?=
 =?utf-8?B?TUFkNG0wTDlITTFjS011dW4xRU1sQ3FaY29GbE5sbGd1TjY2RVBjQXorMHpl?=
 =?utf-8?B?Q2pEYUxsdjl1aFNpZTZmeGVTQnAxOGRlRExWeVY0UnNaTFpMa0pleERHRDBH?=
 =?utf-8?B?cFk4VXF0Qk9CZ2dXenNRUzBHVE1WVHFvN1AyQTRuUzhvbURLS0dlSFRvRVBM?=
 =?utf-8?B?Z21iM1VPclUvRHhWQWdSalVIUm5hcEtvb3MyYmprcVM1ZnNNOGtXOTNyZWo1?=
 =?utf-8?B?aDQ5VDlyakpBUDdMVy9xaDIySnlOUVdna21nZGtvcFRvUFN0LzRyQ25XS3p6?=
 =?utf-8?B?UEFvQndmUUxueXJtZ29tc1N1K2ZvV09PcnZpRVhtTThyWVQwOElNaGtUSWVJ?=
 =?utf-8?B?alJySzFtalA4aEV2QmFVWHhmOWNJd1k4cnVCWEZMMkZiaURoWGxtMmtnRkZk?=
 =?utf-8?B?SnZ0MkpESmxlV3dtb1ZkZnVEQzJQSUNlT2EvNzdxM1g3VmIrUTFiSXdyQ1VK?=
 =?utf-8?B?THNZZUFpYWp1VUJvWFU1YWRDT0t2U29WN1NkOG1SSDl0elpQZSt2bm1rTWd5?=
 =?utf-8?B?a0krcDFxd2wyYXpNOEJUd2ErSzREdGdqcy9LczlQL1ZWUUR5elNtQnpvSXFL?=
 =?utf-8?B?MDJXRVNLQlV6UXlwODAySkhicjZMMGxYQkJvLzZTcVZJU1pQbUZINi9zZDJZ?=
 =?utf-8?B?bDBnM1IxbXhxelp3RnlNNXluQThGcVlCMGF6aG5VTThNVFBqTmVSMitDNlNx?=
 =?utf-8?B?b05malNsanZwSUl3d3VuMkNuMU1TYVUzTjhZMGswYktyek9zd21wM3RVSHlY?=
 =?utf-8?B?Yzc2ejIwU2FwR1RyK3V4QTBQSTVrazhMNkFnUkhoTFNydmlnWWxUd2RtQmRW?=
 =?utf-8?Q?qMAtPIbiBsekRvG+BKazYmQcCDiBUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2lQZ1RkZkZ2aGI0eVpOc2F2YmpOc2tQcmpRSDNQcW9UVmhpbkFZbFV0MDZP?=
 =?utf-8?B?dUpDS1FTU0dzY3hMeDBMNWp5TUo5QW55Z3F5bFh0THpGemtmQ1hNdUNWdmRR?=
 =?utf-8?B?MnZWVWpocjB4VHFLdFZVRkhXTC9kNVdHa2hGcmNsa1NJMndlYnh1NTNYVmh1?=
 =?utf-8?B?cjY3dDlmeWVmWTlrRmVJOG1BTHQyUzdVblltYlV1ZU1ISHA5SFFsY3puSGVI?=
 =?utf-8?B?ZXFvMHlQcUsrREZOQUozYW1PMDhHUG5PMmlVbWxzRHdwY2FscGJUakY0M0hG?=
 =?utf-8?B?cCtXM25yWmEzS251REdlVnhsWDFRR2gxeUlUb09xUVFvZ0Q5bFd5TE1zWTBn?=
 =?utf-8?B?blRrRFRiTkhhbkU2UTl5T3h3K0FPNklMK2l4SjZxZjNWLzdOaHZaY2dPRFpF?=
 =?utf-8?B?VXFQNWRaNFU2WTUrR2JxM0NQVHJrWVlWQUVGSEJRT0RXYk9kV3lTRkFGN0pw?=
 =?utf-8?B?Yno2VEdqSDdGMFowWjFBakpaaHVQSUdQRUFNczB4M0ptR0FJUUJ6dkU3eHB5?=
 =?utf-8?B?TWdmaHQ5U3FPaXp1WkwzMnhMcWNyY2Q3R01IcmM5V0x0d0FPUEovZnNvSzZs?=
 =?utf-8?B?MFh3aVh4UEJOVzNRZmVtbytnczJaeUwwYmhtczNweHM3T0Y2dUdzdkkrb1Zz?=
 =?utf-8?B?dmtVRzhkRnJYL2tselJ3dTRJVXgrZnVKa2J1M2JleTNwN1JWUDhzQ1dSNE1S?=
 =?utf-8?B?RnpObzJOcXlVa29nOXFXOEF6emhPM01EUXlyTVFWOXhvWmtCRjRnUlBnYVQ1?=
 =?utf-8?B?SEg0NzUvR3A3TS9ndjNoK0hXdW91L1o5bzFvYmFzVDhhc0NnMDlNMzBJYWF6?=
 =?utf-8?B?a0ROYmR2ei80SjlzY2VxY3VHQUZGM0UrcGQrYUZ3Mk9RZVJpRjlyTHQ0Nnky?=
 =?utf-8?B?NHNML29nZmlULzJ2TExpRGxGNzBROHZPSms3Zk1zb2liK0NncjZ5NFh5NnpF?=
 =?utf-8?B?dE5VM2NHbjdXTnBpRjFveXU0QmlEbEQ0d0dvS296dGZySytONlU0L2tJRHJ1?=
 =?utf-8?B?b0dFU0VWYVlhNUY4dytJbjB1SzFqSGs4SFQ3bHMwTTFNRnM0Yk8ycTVrbThj?=
 =?utf-8?B?M3MxYys1VjkveVJJRm9Qanc2eUIrV3dDU1RBTnB5b0NseWhLck1CNTU5Mkpy?=
 =?utf-8?B?MjBjTFpwOTBTdXlyOFNobmlUQjh0cHhWYmlqMWJTYTFJQ01QUXdrSEJWSlJz?=
 =?utf-8?B?K21uTlh4MUVCWFd4OXBwSnZYcTB2UmxGVDJDbUtWMzFZdzFLRVpiaWZjd2Jh?=
 =?utf-8?B?Qlh2N0lNcWswcFBjTEx1YW1ORktiTHpkYmR6ZlhPNE5kc3pqQ1R6ZzFjTWR6?=
 =?utf-8?B?RVZUZWN6OHlhS1VadlFFZDN4SWFDVGhyWjBUdUJEU1dMdHBSdDE1S3BVWHRa?=
 =?utf-8?B?R1VndzFoT05uMjI1T05kWThkRk9QTk9nL01NbHUrdy8xbldpM3hFTWJYWDZt?=
 =?utf-8?B?Q25DZk5HU2tIM2RVeEFEMGQ2a2tWcEZJUEZqejZWcjJMZHM4YkF2VnJhV1Jj?=
 =?utf-8?B?QnhwVUExaGVWeW9BQmJueVBRbnhZTFFhOFVzTkYydVl4bFFpVmU2OGlISmxP?=
 =?utf-8?B?d0VUTkFnQXVkSEpQSDVpZ2MvRUNpQURVYm1SQ1h1eEFFM2hiMFBycXNBRDZF?=
 =?utf-8?B?Z2Q5eVFvKzVXWVV5ZWQrOUprRGJJM0U4OXJiR3NqbmJJeDNpOGNsOUxTSTlN?=
 =?utf-8?B?ZXdrUUplV1p1UGo5dGxDWUFJT1Y5c2FteFVSWWZDQ1B6cTVIc25jSnFtMXF2?=
 =?utf-8?B?U3ByV3FUMFJSYW1PTEZLczJUS0pEZjkvUkl5NWhvQjdPRmZwbWRDR05PWjBR?=
 =?utf-8?B?aXlqSWhHSkh2YlZPR2JLQ0xJTWpuNENXY21tY0xmVW4zQ0lkVmdHakxjSHFh?=
 =?utf-8?B?aXRWbWtpdEI2Q0pmeVBldk9XckVVcWtEbG1YNW0wS3hTY3dwditUanlMVkxh?=
 =?utf-8?B?RWhwczJ2WnVlcjhXaEg3Skdld0licGxCNU0vT0JSOExmOG95M3BMeDhYL0xy?=
 =?utf-8?B?WSt4aUt1dmNzeEliRVhWNis4enB2UmJEL0pUbWtBVnB4MmF6WE9GVjlodjgy?=
 =?utf-8?B?V1c2WFBhTllIL0h1K0cxeGtSTHNZQTNQdzZnMHAyYmVLYm9iZll0VTNPanBU?=
 =?utf-8?Q?4btkOW8ez3iWigruLgrpAR66q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abe24ac-baf9-4139-5888-08ddeb8e535d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:47.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJVH9r995Ng0jMJwyKc8mGnMpOb5HhIbVRtr4SUA26PWse0qVinFegp/CTBzpB1VL5MQ0oyJpBsXpKjEraddew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4ab03afdae949c8316f31467d1377..a15f021498869918945405cc7f34ea7e27ae6aea 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -106,12 +106,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		silent-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -317,7 +316,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


