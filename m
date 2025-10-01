Return-Path: <linux-can+bounces-5087-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20B1BB07EF
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B742C2A550A
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA62EFDA6;
	Wed,  1 Oct 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MtOl/H9N"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC82ED17B;
	Wed,  1 Oct 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325026; cv=fail; b=Noh+S2pDxPqOk698xCsRnONq+8os641IqrN2Gs5EqAJjfRU+eF75lPYNv5JvU7PTZtiyTXH5ckbosOADpKt70WS331n3WGVuAHllepLldfzgw7u5/Czyr7zhJ9VbJUxjzC/pkazr6tnuaVJxryadc/DSwAIytf9ygELRdsW01Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325026; c=relaxed/simple;
	bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r+3+oG4JS5Q6iG17OE5OE/WSTUGuzS8xQKnuZIUgoaYZZSrCSaxglp1n2DuTRhFsQKyjkNISOaGpk45uUqOyfZf0gUK2hUrQkMxx7o3Qiyo7fEI6pLX5fk1pQjacKPRYRDCFDxQ+DxIAsyEtJd5W4KlNFwVVXckZqokyBgpSxuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MtOl/H9N; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ConIqp1B5D5R05CZhRfk7m3kCvOa1Fzcf+pJmsjM84W+GRK86HYLGOaTHZeXuwAu9OwRyiArIYQwU6F2v6v/VJbzK5gMci54HoafRgmBLpZiCTEhvorXEkCad91eNblg6Q7xTkx9U1QO1D4+fXE3WCH7APhBaAXOdKHytGWkifruhEzKdFqXEoMd011pUjAsJATe7u+DHuKYnbZcg7vs6s5l6ejjcdchQSZpDZdVs8TWGhCEAO/YDlgCddYZ60vxv2KlS6JRe+s6VGtvhHzVwFv4MYgty6069qPKLEDSTECdxWGZXwkVgFoxpztI+6ry01+jZB6hj6s8vUWbv17F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=BY7d8qwRrzWUm7zbJMWDt3sXgUcYvuKFBpUDbzplhmquSqoMfIk99fUfa5hhk1bPdySk5MFl+j23fEXz1yl9gNsbrwAwrrgoq9siaL4/xt70TQyfxbbQEQg9JYkJssRlpbeBaDtyLWHAP+lgBog3RF4xAqbTElnWbKDNuIYtEbsDuzBn1ZIyu9/VOMF5JOjt98BKAG6EJyaCt4pZrAIwLZnJrlDcudhZI2fBbjut+Qz54SMGBKLfV199UF5QbKy2sThGO+MVJ3dem9AFVhnShR9W458QrW/sTdlq6y0G2zwIQsRfoakqpNYYvl7roL9k1PUDP3oRluPzrv/4ldmiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=MtOl/H9N4RkLx/1C6UlCPzHXuruz/1amaZMGS9NBi7zz7VeC4/VWd6r4TmhmJ0RD0VlvqmrUwyf3+nLLEELTY2Bhj6hVu/RV+0mc4ywkA7AQqlA4ShRdzjarZXMFT1ytDGTEoi40ETzABUbq1Y1l/VZrLU1zheLV4msmiYFK520Pt5HywnzRmdU7l81HgJvrNLNZOu+jr65eLYGet8YmVzRrZFbJej+auswsAqJwJ0jUdxExRZr4fZqA+682XmAvhBRs+uzKAQUhIFgpXCZNRyl9JKNXTld8Xq1RVbYuzoSDtQNss61NiS1hytHECTMKraCtRSYNTfRuS3rp1IGFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.14; Wed, 1 Oct
 2025 13:23:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:37 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:38 +0800
Subject: [PATCH v7 7/8] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-7-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=2835;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
 b=OptXYHmH05eC21n087OJhv/h0C3eaxJ7X9dn8L269QGLH4ANpGmWpR9GjYDbMN7OgvgRrIBXf
 NIXjR/E4kv4Bdbfmu6iqmMmAPDh+lqgjxTs/8cRie0oaijd3rXyaQ74
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6f518b-0bde-4910-db7b-08de00edba7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkZ2NmlkWWl5dkV0Slp0T1VZMDRqVVB0cEM2TmZRS0EzRnpEL0ZWSlc4ZVkz?=
 =?utf-8?B?RDMvMWdxdy83aVZSVXFlOGE5MUdXZzhkSDNPREI4c0VEQTVydmQ3d2VLUDlW?=
 =?utf-8?B?b1hPL2x3UldVNmZGUTRQN2NHQkErc24xc0NsVnlnd1M3MzVoSGU3Z2gxQStF?=
 =?utf-8?B?Wm1GbG92WUpBM1QvYURpNko2TzhVMkwrbU1RbWh1WDA2TlRJNENyeVp6NkFI?=
 =?utf-8?B?REM4MmVBckNqeCtQeG9IcmF4K21CYVk1MGRtT2I4RjZUazhLR1JzVVFrWHF6?=
 =?utf-8?B?azRUakhrZ1RRWlU5RDdWMHlnblhYRVVUN1ZvTVhGZDY5SGpka0FnajFBTW1W?=
 =?utf-8?B?YTUwWGRhNnJaU3RvK1ZYMmNTMDY4SFgvbjBKSzNvV3hERXkyR1Y4cmpDa3Yw?=
 =?utf-8?B?NVRWMWd5WWdMRVBuRENSKzBIdUhXOXg2UmpUNlJlbzBhYU4yaDlXWVg4Z29k?=
 =?utf-8?B?eDR1TkN3cVJUUTlIQkwyRERpL0RlRXhraUpHQk1OTERKdkp0ZExWRjBkVy9q?=
 =?utf-8?B?a1p5YjhaLzlnaVdPOHBQNThhV0hvUjRRT0MyeCt0Rmt4VTlTUFNiZk15K1l4?=
 =?utf-8?B?eGpJaFJUTVBPeDJJVEE2Z2YzUUhHS0d0UjhtcktVQ3QvTnJYaUM4bW9XMytG?=
 =?utf-8?B?S25OOVBhZ0JqNEM3dkZMUlBOM3FJekZYKzI1Mmppc1hIbEliSzN0eDNjaU5G?=
 =?utf-8?B?RS9iV091YXR5Y2M0NmxuOU1TajZTdUpxcmlWMWZFN0dWYSsyUHdJbEdHeWVh?=
 =?utf-8?B?aHpjTnBzRnVXMGhtUW1GRTE0SHljT1NnaDd1LzJhNXRJdGtNejkrOS9JUS9m?=
 =?utf-8?B?RkVTNytkVjB3NXBvYVE1OHdRT29mbmpycjJUNTJzd3Q5aERFZ2lLM0lXQ2ZR?=
 =?utf-8?B?allSTjl4UEE5anRQNFdLU1pvYUVZaXNRNkFXVDNLWmhMNWowZHhNblFQNjZS?=
 =?utf-8?B?T2JjUHB1Nk9rN2NrQ3lLSkVoM29IY3FDcWxXQ2FYTVlWMnhNemhsRzhVSVdR?=
 =?utf-8?B?SGxsYXlBZ1VPK004d3FxRVBBUEhrbWE5UTNFQUFBRTFaK05yNytlVi9yeDZz?=
 =?utf-8?B?LzhWVFg3cVgxMEtVVHh2SG92d1d4NmJwSk1hajQzNGZwSGl2S2dMd25nYm40?=
 =?utf-8?B?dStscU1iTmUrWDQ3UGdnMnplN2IzaU9lT0xxOGxrMVA2dllZd1RuSUJ5ZHRt?=
 =?utf-8?B?dmlyQVhnUVkwYkx3b3ZuLzI0Rk80N2d3bXovOTJJWHVQZHpKdFloSnRMcU9I?=
 =?utf-8?B?VGJwaFEzY2lNbThtYzFHa1NQNVM2K2Fnc3UyQ1FiMnN4VWx6Z2hMSnRxekVH?=
 =?utf-8?B?c0xSc3kvdWtGUVlkU1V4eXZJa3h2SjBCcEdlVVh3eFJFNUM1YzZUeERVYlEy?=
 =?utf-8?B?VVR4QUlWQ2hkYkNDZFQrZmRmMU16cFR4N0o0MkxNNEpHN09XZlJYbGFYWEk5?=
 =?utf-8?B?Nzd4QncwWVVjdUtOS1dYSmpvZTlIK1lMOXdKWmxTdHVYcEVtM3FacERTVTJa?=
 =?utf-8?B?OEpkbERRTDFEVklxQ0g0U2FyMFFjSmR6T005bTEwdjRkbEJ6UytoYkIyNWl5?=
 =?utf-8?B?Q1B2cDdkOXRRNDNWaXErT0NtVmpiZVoxM2ZSVVJBOXRsd0RsZ3FiSG5la1hL?=
 =?utf-8?B?NDZYYVBBOTIxRG5sOFFSbk9kVmJWVkM2eVlIT3RPck9KRkFMYWZiTXE1UUFy?=
 =?utf-8?B?MzNxcDJ3elVUUjNLaTRaQlpBUmwzNjI1RXZQTnJYRXZNSHQ3dklLZUd2cXJE?=
 =?utf-8?B?MHI5RmtvRkxoRUV6ZzF1dmk5cVVJYk5yV0haT0RZa29jME1mUXBWNzBCdFZR?=
 =?utf-8?B?QWcxTWZTRm9rL2N5Wm1WS1JQdzN1MGJVS29pNWVBUXQ0TVVRTDJWTXA3UFlm?=
 =?utf-8?B?S0VPcHF6MkdDRGNKamxkMkh6U0FoczBrQXN0R3VzcFJlTDNDekdGOG1JYXAy?=
 =?utf-8?B?clhwR2hNaUdqNldKeHRzbC8xUkNEVlUzMjZHMVl5bEhnY0ZtSWh0c2xaNHJi?=
 =?utf-8?B?TytidWJKVUVwRk9WTTRIci9Uc2U2cDl4TlphVGRzdGRIRXBSR0srSGJYQlA1?=
 =?utf-8?B?eHZrVVBhV3BRdTdXQzNpZkZWZXVTVy9Qdk5WZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDZlc0J5aFBXenBUWGJyUmRrTzBuaWRuTUpLQmVMTzFTdG1JaHJ6MVJBRmN1?=
 =?utf-8?B?ZWdOeFlvUEtwN3dPRGFnN3ZySU9KOWRYdFBWK0U2eEtVVFZmTEJDeUY1UlJJ?=
 =?utf-8?B?QzNzUFk5cUdoenJ2L0VzMWhhLzRYUTAvNm0wdlloY3dTKzZqYVZXNVFkUGdX?=
 =?utf-8?B?YUFpRFp1Z1JzcjM2WGZIYzUwZ21lQ1cyV1RBTEtsMUpoY3paS1hNT2JqcWpu?=
 =?utf-8?B?OHNVekEwbWk1T0d3VVdybElZUU5tVnNJZUdpUTJYeTJMSERFUGRqNE1FT2dN?=
 =?utf-8?B?RmMvN0NzeXVyUzdVdFFDUTU1WTA2Nmk5TDF3VjNleVVKbEpGRlZVbEUzZXBL?=
 =?utf-8?B?NnFTSko4WFdob2tnRG9hR2VFUVYvSkZRZnViS1Z4RjM3SVBiVUVGY1QwZ25L?=
 =?utf-8?B?OWppRFdGS3M4T2xkQ0lxNDhLWVJTbGp3UFY2bUpqbGEvK0I3MS9yN3h1T2w4?=
 =?utf-8?B?dTEyemN2QnhWRm5yb1BtWjQ2YnA2Y3pONk4rN3JyR09ZdEREZ3B1V3FSWFp0?=
 =?utf-8?B?dFNyYXl6LzNqSlRHd0FrcGFQQktvbEZSLzNRSE5IeGRSRjBGV3lmV2tvVm9s?=
 =?utf-8?B?dzdrZEowM0VwOFZvbUl4MmtSZnFSVmxUSTlJelhrdDh5M1JCbG0wUEVTaVJM?=
 =?utf-8?B?YVo5V2Z1YXVWV2JyK3N6ZXJnMHhFRmZOL2E1ellUOUdxWDRmV1VQVC9sWFhO?=
 =?utf-8?B?NHRrdlFpQzZtREV6bTBrL0xYUS9VQUZEZnNIUXdqbVllRU9HQ0E2TjZOVFgw?=
 =?utf-8?B?RHJGcXkxbnhXbkdWNTZBV002VXJ3ZmZWcDRVVm1ETmV2dWhzZzRraStDczlH?=
 =?utf-8?B?M0xIbzNxMEtVaHpZdWlaamFQUFhnS1h2RXl6ZGFMZEp3VjRCL0s4aEU3Rkd5?=
 =?utf-8?B?TjcwS0QxZmdwVDFGTU1yZlorWnlqV3E5RlJEZ3JpOXAwMTZYV2FxcjZHQ3l4?=
 =?utf-8?B?U0FZNG8xNXY3Rmt0VHN2SE8rYXJvdXZvUms0cnVZRzE2dE0zcGlvWHRONW5S?=
 =?utf-8?B?TldHc0xtVVNraVJWRzFydXI1elZ6N2FBUDRPalZPZFN1TU9nS2plTkU0M0FF?=
 =?utf-8?B?VXdkeXpJRVpHSU5ZR0s3TnlUM042WUNyaGl6cEs0REUyTkdFR2t2OUhVamd4?=
 =?utf-8?B?TzNzU0hvU214RlhNZmFMTjlPZ1Jwb0dqazRGKzNYbTNhSEsrV0g5RHpBVjM3?=
 =?utf-8?B?cnhjYXE5QWprb0Q5Qng0R3BPVGJWYXJKQlJIMFQ0Q21rYmlCd0JIeXRRMDZD?=
 =?utf-8?B?a2syb1RYeHV1MjY0Vzl3MUtycXdZSGpTT2FiZTdHSnVTYmdVSUZYeDFiZFRF?=
 =?utf-8?B?VHlJUDV1bVgxelpBWFRINjhlVFNSQVpmc3RFTEg3bFhJZWhmU3c0UGpROVRo?=
 =?utf-8?B?SzM2RDNMa21yTzdIZVlKcjUvTDdETFkvd3NxdElBM2pad3ozZGlTRmpzN2Jo?=
 =?utf-8?B?VU5Wbi8veE1WSFNDcUZ3MTY5Rmg3dDBoREpuS3RBdkh2cDlreEF5ajdmZmhj?=
 =?utf-8?B?NVNjVmJLNis3YTdyK1k1eERyblM2RzJ4aXczd2RLUVcrZHZpWWFsbkdla1RH?=
 =?utf-8?B?VkVQbnJ3ejNFcnJFMWRIaWpqMDA0QVlLY1ltRjNOR3RRbkNZeDkySHM4U2Fp?=
 =?utf-8?B?WitWOE8zYXVOakFaN3VJYjdndWhZSE1xR1VMRktMdW1ScGZZMTB1ZzIwOFBo?=
 =?utf-8?B?akNTUmtaWERUN2ZLK0Q2eGo5WXlTZitncFVlOGlDdE8wcE9Bcnl4M1lKSThX?=
 =?utf-8?B?eVRBWGV3dnZCcDRJbmlMNnpnOFBqZGVObmsyQ2FGMWdmNUwyamd1VGJrekFW?=
 =?utf-8?B?OEM3WlBlVUpwRTJyc1h3T0tkTWJiWnBvTS84cGcxUmo5Yi9zbTZMRjE2SkVs?=
 =?utf-8?B?TzVCcHZCUnUzNVpwMkZYOVJUY2FXUG11a3doSmtjNitYK1FpMXg5YzEwaGwy?=
 =?utf-8?B?MU8xOVluekNzOXhEREZkYjJheEg4Y0FsN3doWUk3dG93MmJIYXkyU1h2bmFQ?=
 =?utf-8?B?SG1hS3QvYWRmWlAvQ2RpVUNVTnJuS1VYZzZ6Y3Rhdzk2ZUwwbkI5RkV1eEVn?=
 =?utf-8?B?ZlNVeDRrUExYUTFxdUZNaXY5eUozZ3hpd2JQeVFRaUM4ajFrVkZVZ3lQNVlV?=
 =?utf-8?Q?pRGTlDUDyb0R9q0P3moOwy8Ug?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6f518b-0bde-4910-db7b-08de00edba7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:37.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHWens5eS/zESjMC5fkdSGIKG7M4VqZJaeEvlnV3iJaL0ZxMjYW83od75bMDyQiZ6pjLWwh4GTVekf3Iyb4oKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349

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


