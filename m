Return-Path: <linux-can+bounces-4347-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DAB3399F
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01533B118D
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079782C0F8E;
	Mon, 25 Aug 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KBpEFubu"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70682C1599;
	Mon, 25 Aug 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111042; cv=fail; b=QO4iwRVRN1KTUfMioX53Cm2QQFwySxopOaHLWiyINkSxj0U4y3pzB86e0J62/jrMQmj8YTfoTZq6rhWNt/RB54LN3AfEV4ZFZWX10qatjRopqGEvgA2FRh9zenBY+bOWgcZHd2gAI8PFskbNl8doTL5fK2S44aMDCkj2dcjBOt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111042; c=relaxed/simple;
	bh=XPqTu04zFGccIED4ZckPZZpsHPgGBH9CaOZ/cTuZG3A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uhru/EQv/uTmtSW2tlFP9k2DT7jQb45aRK0jIuZ+TnKfogHoJv8fDJPvOEE3m/y5EtAzGOoKD6oyWhHRY3VK/DrwV/gSGa+vQW0lyNsPFk+IYfhDEV1bGkIKDmKcu3gSv7SIOJQkD5tw7Q4fLy+MfgUAmlfki8zb5NTF8oVn4d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KBpEFubu; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiaCA+j8fG7peFWChvHf3+OG71SNr3RufOA8ZfAEfgGLtExAODZwGJ+uv6LZvNjWuEeMYHb2boBfW+eOx+jxTrfEYbzhFFa4/Xpj0/69YOvZ5XvCkp+2R3P1xYSO0rz4yY4F1Al/SRFvt0sQEKBSKhHlYWMeboUFHncgfHxuKdhADboDE3h69tM8jFMoe9cuFRcCAcnYKK8QU7OBRohxiOCz8N7wfOQmYPuGO96PIj7e+W2YBdG4z7a8gIRcfB1kdNDhxs6alzsADPuK+RYXDm8X4MKCp0LMuov3vylOseWq08A+Q1mcME2Wfsy8dHxD3xB5TKdmNIonO+n8R9L82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpWylB88VwkJesavYBJWZySnMrfftJ37fL6ptcUYm4A=;
 b=H6UKM0SAMaq+gpzktelLvIc+cTS4z894TAv6E17FDVF6+kdWknBoU7On5FY/1WoOk/toXLfIDd5OBWwYLILd0g2vMoHPEyTgV6kQHDexTBEEQPNqOzSrEJA8S2p42SuOeSFEj79erOV2jGWx4UHTwOz6IdIn4ft0mOu4ZUmyxwuYakuaLbygyIE3NTf/mMekXXSufRBiLvibnU++KsJCYIL+LfbaD8+JIUegUA08wI2UpDpq/PXkpO1z3rogbtUlJa3RxlZ/wIDxkg2M0jLOjsOdckwQLrG2BamwcCrvFSU5nKO2dSrUtYtwGCyu7Ft3nXyCFSM4vCZzAn/hk6fBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpWylB88VwkJesavYBJWZySnMrfftJ37fL6ptcUYm4A=;
 b=KBpEFubuGG1QOibP1LMNN59CV8Wo5stEQCKXXhY7k3vTnY0oUr556HyZRhoRc4oJFFs+RieUcyP8nIA58LrC1ozJEdgun6W+jZFQJ3P2hssV7/30BqUNfUQANUZzSP5gn8nNBcW7MAQhfNoQIVC3U2r2bvbCBfcnV0pQEeJbTNbxw8B5g+jl6vQt+xXc4tuKffeh0yNtKI4ymdElvdW6FHpE6wnhYvIhm10f7KHVrgvEqZju1XnT7SlmAp4TxlAmkCHWQdQ4lST6woHcBmI0SqVncM0LvqPpSXU5nCJbChBXzj4xuyJXkUDaokq6cOO/b+GkQ9//yWj6FWablhlofA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 08:37:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:37:18 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 16:36:44 +0800
Subject: [PATCH v2 3/5] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-can-v2-3-c461e9fcbc14@nxp.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
In-Reply-To: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756111013; l=1438;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=XPqTu04zFGccIED4ZckPZZpsHPgGBH9CaOZ/cTuZG3A=;
 b=KG8ZTC5J7/i8O3b2LuXOEN5YL9jMu4y3qRUqsj2fJGiADiDHVocbPdBLy/5WUXbAIQueq7LvB
 +Tpi3XWX29kBT6EO61wiSxKsZT3Ijtf2/++OF3oTbO3fItyF1xTb6dU
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: ee565d8e-87be-4adc-81f6-08dde3b299bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGlwcERsYmJHcW14MHdEYitYcFUrMzFQU1luVm9KTGxybFE5ZzFLQWV6Z0g1?=
 =?utf-8?B?MnV1MFBiTUFRT043aU15SEhNdXRXVFo5ZElYNlpzYjBXYXJlOEZma0NmY09j?=
 =?utf-8?B?OEsrNjZqM0sxSnpnU0pwM3FqUjR1TTkxa2RyOWp6WGZZNG94TVdHa3hqTjBD?=
 =?utf-8?B?akFKL1hlWklGZGxONmt0R2JJcnNGNW1xTkZCL0Q5bTI2emVOby9UUDUrRnRS?=
 =?utf-8?B?YkFUT1RQSDN2NU8zdGYzYjFncWpCUmF1K0N2djJ4Ylh3d2dvVzdPNHVOdWFR?=
 =?utf-8?B?M0pFbEVMQnpsbjIxQlVtZ092dXhUVDlRTlVDdWhKRGl6cEJOaHRheHo1bzIx?=
 =?utf-8?B?WlFSTGhGOVd1b2VGVWkxK1FjOVkxSEtXTjQyNmNXdXkva3p0TnpVRjM0QlF1?=
 =?utf-8?B?UHZMVjNLSDhYRklnbVRFRldYU0dKc2Y0di8yTUlDY1FSQVUreXJHaWV6REJp?=
 =?utf-8?B?bGhqVVNxMmFGdXRhRmRjZmt1VDdJME9jdFpTL1VzWnZ2R0YyM3AyYk5HOFBv?=
 =?utf-8?B?bHJOZDFZZXV3UnRjeG0zVHNGdDlzVXNyNndYK0tnN1NsZ2w0UFJqMTlieGJq?=
 =?utf-8?B?bEpaVnBqeXVlVjN6UWlmYS8vUjdRalo3RUFkS1pEdWpsVnVZKzd6LzVQZlR3?=
 =?utf-8?B?ZXdrQ1VmMnNyVG9RTk1vcEZMK05QdXd2ZmV3ZnRJRHhpaG54aVRPcndCQVhu?=
 =?utf-8?B?Y2NycW92QlVkNUhTNUJaWUwwcTQxLzZ4TnZ0N0t4eUFUUkhhNXJURHdGeTBx?=
 =?utf-8?B?OUtCT0d6VmFoME9DWEkzd1RXTXZQeThacC8xT2REMWN1WE83TjdrRFhJaHBv?=
 =?utf-8?B?M3k4ZTdsSlQvV3p6U0ZwSGhzYmNzTWVmNHo3QkpwaU04aHY3dU03NThINUcv?=
 =?utf-8?B?U1prZldvQ2VibC8yQnozV0dBMjU0eWtCUGpnQXlIS200b0NQMDRKQWNTVExJ?=
 =?utf-8?B?N0tqaUhVUjhBa0VOMmlMNnNJcmQ1RkFncEpoQVJkZVVNOVljaHpCenF4RlVy?=
 =?utf-8?B?ZUpZTC9FYnFCWE85NHlPUHpudVgzM0RIVGNSYWk4UEw1bGFsNzExOHVOV1RO?=
 =?utf-8?B?cExkd2E4TzM4amtSeEI4RGlrVmtVbVNRanlqakNEUnZmVkpPbEJRR1ZmNHJq?=
 =?utf-8?B?L2FiL0hPejlTRXNHczF0b0hDRzlna28yZUZaNVp5SG9JQkpOVnBBRnpTK0ow?=
 =?utf-8?B?SEFMajZBZ1dmU3VWTlNSczV3QXBXYmp4YUlHSWlkTXhiVXowcHk3RkNXZzE2?=
 =?utf-8?B?QmRvYm5wNkRjZlFLZFphY25tcmpjSjdqdVlqVHp0SGFya1ljWHNkVEt5cW9L?=
 =?utf-8?B?V0lwWnFUaHh1ei9OTFJuOGJVbEovTVBqUjdHUW53M0lXRFlDWEU1ZnE3aXlk?=
 =?utf-8?B?T3p1YUVOS29pVTlJWEp5NUhFNFQyT1FPcnJVbUY3blVtT25RclVuNnhHL3h2?=
 =?utf-8?B?cGVzUmgyOWNaNm9PWXZRL0xMdTVFOHVXS0lYaHlFS1BEYnoxWktERHppOFBK?=
 =?utf-8?B?djBzZmpmQUJYQnFjUjRDZGJBbjBheDA5ZUg2NDV0d2VIcGw3Q0NFZG5Jelcr?=
 =?utf-8?B?L1FEVisweTV1UFk3TGZaOVlOWHBQU09JbnlnbWUwVkVod21qRTFYVFNxNlRK?=
 =?utf-8?B?c3JpOGVDUlRWbm9ybURtankvUURPWlU2K09ZOTVsdDBReVltM2dsTnZ0Lzla?=
 =?utf-8?B?ZDZYS0FJaFd1TEtoRklsWDZiVGMwYXZPMXorTFUrMGkyeHVHNkpvcTR4aDRl?=
 =?utf-8?B?VXprdHcyck1HUHNTMGZJY2ozd3Zaa3hXdXBnY21ST2ZHTHFQYUpWNGZwcHJm?=
 =?utf-8?B?MGxxd1pzOG92RndmMzRRSjZBTFRubFpwNjYya281VU44MUpDdjc0YVhyMlBh?=
 =?utf-8?B?dmhzOGRFUkNlQldtMGVaODk2TGtsaGJKMXQ2d3lnczBmWXJncWI4TW5yM2ow?=
 =?utf-8?B?bllTZmRHVmc2dXQvR3V2a0hjaWoyNWlFUTZjZmpSNFBySDA5WFJsSVoxOXVP?=
 =?utf-8?Q?zoJcxkW64Ajtdq1sQQPIts8d/7wiNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHhweDRFUmREWlFvMjhKNWw2YnVDakJsZXpJazZwN2MzRWRka0RwakQ3WTFX?=
 =?utf-8?B?WkVrMzJPcUFoTm5oSzFSb2VqZTN1Q1dVcWhjTTljbTFxKzRLZEpkMTdPRC8y?=
 =?utf-8?B?YllhMTFCd3JtdUIvK0JxYjNjZUx1eVVMMTV1M2UyN1lmUlYxVWtkSVdBQzAx?=
 =?utf-8?B?RzZKTGRxeldrOUNWWHJiWERYK1pwcE1DZ0ZIejl3ZHdWOEo0Mys3dzk5K3dr?=
 =?utf-8?B?ZitIUWVsOVJTMEdhay9tQ3BPQ1VDWit2LzhueXNqWXdjUFF6Z1lPWklTNUN4?=
 =?utf-8?B?SEdtTXI1aEFFLzVsYU9uZ0h3dC9adytDd0pnbUV0YzlDMkhEdmc5djVoMWhI?=
 =?utf-8?B?UDl2MnFOY0ZYZ0x4OU1GQjBiNFBhQjNUU1ZSR25USXd6NDE3UktKZ3h0RXht?=
 =?utf-8?B?anF0L3dodGc5MWl5SU03VFlpM0FWUzRPN3RJUDhQd0txRzVPSklWb296QTFK?=
 =?utf-8?B?T2dGM2ZETW5weFNBU256OXM1cVU3ZGx3Z0x4SUxObktvT1M0QXo4MFFvVG1m?=
 =?utf-8?B?allhck4zM3VDTEs1S2V0clJFQ1dGODkwdFlQTkwzWU9IWm91L0NvSmdPTEc5?=
 =?utf-8?B?STZKTWV2dXhhRmVZY3FBQ1BsdUZOaDdUbytXcGEvNG55VFpENXYyTEhPUGp6?=
 =?utf-8?B?UEg1cTJQdWF6SEl1TkJiOVlUZHYxZnNKK2lFM3lTQjhNcFhWZE1kR1k0c0Vt?=
 =?utf-8?B?ZHRMNEt0K1BuWjk0U2IwcldiQ1NZWFhFaXVGUGdpbVp1VGpGaXdBZVBNTU1t?=
 =?utf-8?B?Rzl1dzZaMDVTVmpCRDFQMDEzUXlrZ2hVcldhZ2pXR1kzSjlIVWRyQitXWUdy?=
 =?utf-8?B?TGtHSmM3b3JaNHErK2tBYVkxUzJTa1ZGNDl4NXB2RWlrbFlRK1pMTjQ4S0xi?=
 =?utf-8?B?V0p6ZHlJZk5aTXRDWHViaThIdGlEeE1HVUhQbEI1QjZxY0RpcWtROXk5Y1RR?=
 =?utf-8?B?REdzWWE4M2FFdFBvWFZFT0d1eHZmWVdDS2FsZDIrVUpvMnY0M2JnSC9FTjdx?=
 =?utf-8?B?VkpIdEhEOHY0Z2lJZDVrek1JdkhWejdHY0tZZUh5ZDgyQzFvOXVKRHp5WERV?=
 =?utf-8?B?STF1ODdScS9hRVB1eFdGRm9mNVpzUjJYYWtvdXhFeUVRbkJYRzZpNFE1V3Nv?=
 =?utf-8?B?S24wQ2ROZmMrclF4VE1OM0QzZzh3UjlTdkpLQkk2K3BKRUVvZUZQQTgzVVdr?=
 =?utf-8?B?Q09ETVk5UFBWbGU2WFY1Z2dPSTRqZjR4bjZBcVdNM3ZKL1owSm1iREpBOGdp?=
 =?utf-8?B?S1p0Q3I4UUhNM3grczg4TGZDYWZLNy82YlBLL1JHWU55aktmb2U0bld0U1p0?=
 =?utf-8?B?MzZFR0g4MmIyc0pjMHJhY2hWUEV0dmIramliTzNwbldlZTZvZEVDMUN4Y2pp?=
 =?utf-8?B?YkErVEpJWjhuSGRRaDBQc2xTdnZ4U1k0Z21mUnNGMmNsZWtiYjhHUEhpby8r?=
 =?utf-8?B?ellxTzA2YzVlWW13djJzS3puYjhUekJFK1ZZVDRMOXJWNWs3VjV5bTQyTmxH?=
 =?utf-8?B?NlQzVENUSVp6UUVFd2hGZ0ZWanowSytHMXFydDJyUElTWVZUWFMvcEcrdnFk?=
 =?utf-8?B?MTdDV2JaRnd6VWNySnBFYjRrbUpzM0JjYkJ6K2NETlhoYWtrdFd6NHdxNDFx?=
 =?utf-8?B?OFFQQ1A2ckVzcjk4c3RvMlc4a1FzWTFCakZCd3F5T1k3VUk5d1lDT25jcFJD?=
 =?utf-8?B?cmdoWlUreWxQY1I0M0lxa2lXcXVPNUFzNlBJV1B2RnJRcVpENHZINGc5dm0r?=
 =?utf-8?B?OXZuUm9BancyTjBqUk1JMmF6SFRGV2Z0aVdDaFdLbVRWWCt4TDlxU0FzY0Uw?=
 =?utf-8?B?ZHNQc01kb0x6ajdlZnc3bzJSRmg5VHZENmpndFJvandrTk9xSTY0OUN4NFJq?=
 =?utf-8?B?b1U3T0RCajZrdERnNEN4aVp5Ynl0LzUyb1dTcHlvampMUldVMGRXTUVYM0tL?=
 =?utf-8?B?cXZ6YmswYSs5eUcvK0RZZWVNMFNVS2x6MWFUYVJ6RVpWYlg4Qm5sMzF3enNm?=
 =?utf-8?B?U3RqQ3VxZFFoakNuRW1QQW5qaGZnRXprcTljc1ozZjlib0N5eXlwZEQyNFZ3?=
 =?utf-8?B?OEF3S2dHaERHRktBTDBPdFdTNjFXUmttb2tsVGUvaGVvNkpKKzZ5VzlQbVJH?=
 =?utf-8?Q?5o4R2wKgis7dIl2BgEYpIJp3m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee565d8e-87be-4adc-81f6-08dde3b299bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:37:18.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fdJZo9qUQXuRgPiP1Mga91KSidHmos6gha6W5lfjq/17644X2+c8Rt9l7yUGYg+FrlQKD9d3W4UbO0oGqnnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 46f6e0fbf2b09106e6e726ff8b61522d1359cfa4..f6197ba356d49b97bf7287c3f0f86ef84f89bac9 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -89,12 +89,11 @@ reg_audio_switch1: regulator-audio-switch1 {
 		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
 	};
 
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "can2-stby";
-		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	flexcan2_phy: can-phy {
+		compatible = "nxp,tja1051", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <1000000>;
+		standby-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
 	};
 
 	reg_m2_pwr: regulator-m2-pwr {
@@ -300,7 +299,7 @@ &enetc_port1 {
 &flexcan2 {
 	pinctrl-0 = <&pinctrl_flexcan2>;
 	pinctrl-names = "default";
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan2_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


