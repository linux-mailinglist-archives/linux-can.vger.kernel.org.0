Return-Path: <linux-can+bounces-4534-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC244B4A151
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD233BC95A
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251D2FF65B;
	Tue,  9 Sep 2025 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQGgdHjs"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB52FE575;
	Tue,  9 Sep 2025 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396455; cv=fail; b=iVjHH8dcmby1S7XFTU+L6TivoOhFX36BEaydCxrQ5P5ExL5bs8bG4kJ9HQNUg+td7fMe9+HrGVP+t8goewCo14eel1UazUCEOnB+0kaRfizkpDSgSfDv4foPZt2melbWFqto4pY4Dvv5iVnMzrXZp7kwR4t1c78wqZu+KSc58S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396455; c=relaxed/simple;
	bh=FY4pPZ1aDEMyqYllvZTAPBnGkv/MTxPgh/KCOmnd5ew=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UTxwyMGfdCNa1hmmvhrmPjBdy4rn1HOSTb2C1+fQ2bvkw3zq3pVqyQp8jZbXxKZAx8fU34JuELDERn2nEnxH6Ymo54k8EfniW1exOY8Pll+cYXpzPAkP/GijmlMcCb2w9y8CJWhegoQ5JhjCBFif6OM5fLZLp9D8d1DcBEM1Y50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bQGgdHjs; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSDVMojPTLHsK/f7zou9FRvIeEbKnZT06+lLKkb8Wbs6J+bnphNv8ULZha8OQWmJnQDks7Jc86q1+YwHD2ExTbTARgaqQlOJCqL/ZQON/Ku+jDU36a+GTSyg3v7Wa2InDk5ySHZnKaID5bfvKUFDrp+t6VA6+wwBtPncOFy51JwW3oVQ5FJGu+kyXc5kctVixrhLTmFV0tSQb6yAKmq8X0kP1zbMJL5XqMaIOLLHn//0XM+0HzIhC9pBQZi26M+u0g5ty+Nmq/pS7gzaWicSFvFCXui/oYD2Ei3MhgbAT+oppHolQaGrWXHWCUmAxiDJL52CmyB8cowsvw5I5NEWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoupLKXdR+Z7rmxKgymA6UFa1Dro42TjvfEoLuUf82Y=;
 b=j/pIgHZkXJurxVt+JLwSlchHQ8jO0/xungKLuwV+dcVE0FNpoyLt3LCm3g2obMWmDbq/+SQrsKo2EXjiITJxxXKqJlpIWGXB7M5xjmS47VidQbzwIBMrq1QpSfUs9kyxSMYeG4un9hV2ykFHIRH51SWbwMzQmBkpjT8UKFr65EZAgCdgVsMHbazI67f8XOrfEwNIPuLxs/as+jFBk3m2cUPzEy65OxdtZAAgMez9/Kc/QUr8echHBbtJBHYBk8UZHaNqb98RMriYJyUJRgL6DcpAKcTZgnwlgclIh1OpdVZ55Bz7WGYrFupYZTSYP2ptoCDAEb0ZOuRkpQNZ68lcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoupLKXdR+Z7rmxKgymA6UFa1Dro42TjvfEoLuUf82Y=;
 b=bQGgdHjsmUjk9Ha++x7LOCTS9HFer+ZaT1WblB+fD3wGzcVCnAZX1etHEYe3TF2IUG8+eq3EeRVCF+MoQ3h18pNHBZmUdlRgFi0uN9P0Yc41x7Kz6xUciLOVSlB8MzwzjPvD9+CSJZLCy3rFGFnOjqHFWITrbQx6JXsKpdVXl0mWE6lFj+4AD0C/Bz9EwQAtsPrDp15LMiuFMDq251OPinMgXKp83ohU7uJooa/E8QnaSrien+RsYf/xyd00BpFVCNZOfbDqEISsNVXapbFAQd8jqyv8n8gLjjMKqFRlHcNv8FbZuMSZEgBZEaoRfaF4TIqizJySUJIWeSBfGpe1Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:40:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:40:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:13 +0800
Subject: [PATCH v6 3/9] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-3-1cc30715224c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=5981;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FY4pPZ1aDEMyqYllvZTAPBnGkv/MTxPgh/KCOmnd5ew=;
 b=KcOxyTTXgXIWASa8Y1FkplRvaR02u/vspBF1aSbMnUGa+JEL1ouDTy0YhtbkWORUEpjDZxeaz
 AwJ04DLwy/iDBQYJ2zBgybkS/CWh7OjfSvbSw438M7ln8iBoFs3cbIe
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
X-MS-Office365-Filtering-Correlation-Id: bc950476-2613-42bd-9b23-08ddef636f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnpvL3hsNjBHT2F1TjdIV1YzUk8wOUtlTmp0THJnQk5tRWFEUU5yTk1sVDVy?=
 =?utf-8?B?OWhhcmZ0THFKU0F6aTh5U01OMEpNNmVvdGpKY0hXZklNYk5hYzE3Z1B6UmlT?=
 =?utf-8?B?RGJxMWNwcndRY3RmQUR3eTNKWkVxTG1COGpST1pKMlpkZ21KMkI5SnZMdmh3?=
 =?utf-8?B?QnJmcUJXNHpKZWlTc2llWlNzbnI2VzhsckxUeUNIbmNBR0FMNzh5VWR4MVh6?=
 =?utf-8?B?a2lqdVNFa1JTT3djU3FVb2dpOHVqaDUzVm02V0tGbk5TMG5MSUdpMm4rR2NZ?=
 =?utf-8?B?Q1B5a3ZjNTlDc0dVU2ZsVjFMVGdZM3NIWno4S3MvSmc1RmtxMDFUSk8vMkVo?=
 =?utf-8?B?UmUyYlQraEZvREsxdXFSTndUMEJJb1lKUUltNGRTQ3JCM0txY2krMVQzR28y?=
 =?utf-8?B?WEZBZVMzR2hrMDFCUVVabm5kbTN6U1FPa25wYTZWM0owVTJrRzZUVlpORlc3?=
 =?utf-8?B?TnJCa3NBaUJnek42QjVFZzBYQVUrQmEyTFZqcmxsVTFkdGl0WksrZ2l1dWdS?=
 =?utf-8?B?TW9xNVVOSS9Rc1UzbDhJazE1eTBRWnlpaXZWd0dTZ0Vwak8vVnlES244SHYv?=
 =?utf-8?B?ZjQ0M0JpZG96TDZ6TzZwY21ZUG1WdFhvRE9NSnFwbytBa08vQ2lLWUVNN2FK?=
 =?utf-8?B?bDJ5dU9ubmxlTm5va1pvY21aWU1kbkdGb1owYnZSL01yNTVwNktzZFFqMm1y?=
 =?utf-8?B?cTgzbVJWdVlKZmR5WFAxTFhZV0s0TzBtOFFtcmRSekRQUjNRSTBPY2F1TlV6?=
 =?utf-8?B?WnZmdm1sVGp3OHlBODYwQ1FXS2VLR0NmcTYxZDRoWWR3a0dCaXJ1K1g0cXNC?=
 =?utf-8?B?UUZBUVYzK1BLMVRKZlkwUldpTE84Q0JqZWltU08wSXdzbitqQVFuMTRERjdK?=
 =?utf-8?B?Y0grVkZKdVQ0ZVdZZGM2S2Fvek80Z0VyL3E3ZFZpdFpjZ0JlTVZ5SFFKUERm?=
 =?utf-8?B?Nm1JVjJoLzVoaXQ2UlAwdXlxa1FqZjgycC93YlRDcE5nazM1TWx3Q0hqV2Zt?=
 =?utf-8?B?bVVFVjJ2dzJFZUFpTlUwT0tYUTh3UDFEWHovRUlFZHlRcUh6UmpVS1hZUG8v?=
 =?utf-8?B?VmlnTnN5d1p6SkhGYjhONndxdXFYbzE4WTdXN1ZTQklwUCtaTFA0OXFDOGRY?=
 =?utf-8?B?T0F5eTRVZkludUduU1AzdC9jOFpxU0N0NzMvOWlkalYxRCtNdllTL21FRW95?=
 =?utf-8?B?anBLT0FjWnd6QVBvNEczWHI3Rkx5SlNwb1BVYmdwMkNzVVpmTVZXbUZucGVS?=
 =?utf-8?B?aW9laytjNDJnbGdyOFFSUFlrOGs0bzZldGcyaUZXdE5xdUVOTUk3M0U2QkFV?=
 =?utf-8?B?eFg2OWhiNzFEcFFkQncxSDJDbnlGcHRPeGRrTUhPdmN4Tm1MQ2h2eE9McS9a?=
 =?utf-8?B?TmZURXB1YjlSYjQxbTRUQ1MwRENqak9WcXpiMUpHQzZUZ1gzT2dsMzgwZzNi?=
 =?utf-8?B?YXY3Q0x2NHgzV2hWWkdUMTVIUyt3RTQrTGpzL0dtV0NzTG5QNUtoQlV6WUVF?=
 =?utf-8?B?bnZhZFlnbHNGUmtKaEkvc2Y2NjljeXYyaG8vTG5RT2JRRUpLWFRjL1ZRck9o?=
 =?utf-8?B?bUlQdzRWMVBGbE9qbXFFSTR0Lyt1bFZCVVRRdWN0T2xHL2hndnh2OUs3SWRE?=
 =?utf-8?B?Vkg0VDg0OUQ2Wk9aRDRpajVXcGhGak95YSt4WDBVZHBqd1JaM3dHTGdIWDZY?=
 =?utf-8?B?VG5wdjNFdjM1eFQyUUhySXhSZGJJeUc2MlQ0VGVvYlFGYVpzeWYzZ25qUGZj?=
 =?utf-8?B?ZDgwejVCQ3lQM3dlNnM2NVhwZlVuaGx4RTNLWTVBZTRDYTYwbXR4RXYzNlgr?=
 =?utf-8?B?NDZiVHFPSU1HTnpVUUoweWh4WGdHbDRsZm5LeHJVZWNkT2NCVFVGaDZ3M3FP?=
 =?utf-8?B?ZW9oYVBEY1ovczZJdFEzMUZHWFRmY3h5bHNSNHZFZExhNnZDS0U3YzVZb054?=
 =?utf-8?B?UHE5MFlpVDV2UlJ6MEhjbVphUS9kWUErSVpjSW0yeW5CVHRhMlRuUjkzZTB0?=
 =?utf-8?Q?CgvfbaaomyT34Yos9rcQ4Tkg9KOoSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JBdExHR1pxV08yWndBVThaZkZKVHliU1hDbzNMY3JzYzRQUXoyT0xUbzBS?=
 =?utf-8?B?eVhDbGtuRHFJbUd6YS9sb1ZOV2xaTCswZDZkc1F1L05udTRZZmVYUVRJeng1?=
 =?utf-8?B?QVBVZzJyeHJDcDdPSzlBQ0V4VFBkMXBQbjN3UlhiM2psV1QxSmJXc2FqN2RV?=
 =?utf-8?B?RHdvUHYvRGFVcFZBN1FpdEp6cmdEVXBEYmM5UkhkSUg1SGppZGpkSHdHT0ty?=
 =?utf-8?B?S09VUFAzMFZhMUdJWEwzZ1hXd1VCODRla2xWVXdrNmRqRkV4RDl3MjVOeGZZ?=
 =?utf-8?B?Vmw3eGRqeXdnSTllMlJxb3EzTDNVbUIyWWptbkViaVJjN2tseEw3dDJzVkYw?=
 =?utf-8?B?Z2lEdEd0K21PcFZaV1lmdmR5T0dTZjJOK0gxT093ZmRsU3MzclR0Uy9SODNO?=
 =?utf-8?B?N04wS1Q5SXBLVkhnWEgxL254a2ExeGpOeGcvYnhxUHA0dThWSU5DWmNWdXVy?=
 =?utf-8?B?Ty9TaUhKT0dCamRLdGhNaGZqbUZvMDJPMTVncU1UQVFMSjdKck84dzRpckJk?=
 =?utf-8?B?VGhMTUl2aHZuTUErVTcvQytCSnVuaDNHY0owa2N4dkx5NWNycjZmQmhiMjY3?=
 =?utf-8?B?V1RIQThyb3VnTE5NVXcwTHNKWmxJbUx6b0xCUFJla3pnWDdkd3l0NVpIa2hN?=
 =?utf-8?B?Nmhvamp1OTcvb091RkxOSXEremcrTEY0c2NQbjA3RHlYTWYzUzB2M0R1QXlS?=
 =?utf-8?B?TXhwL2E2ZmFqcDdVZ2JhV1I4OE9pNDZCZGN5NGNRYXo1N1UydzJ3dU9Cemlr?=
 =?utf-8?B?dXpSdWcyTEI3QVRLeEVWWFVpSUFJSGM2RkdJcmdodU02KzNWNDNsYW0wRUh0?=
 =?utf-8?B?b1NHRTR5cFVMZjgxWnBHNXpsMUZYTFlEek93RmpIY1RHZDdPMmY4Smk2YkI4?=
 =?utf-8?B?d2tZcGpaakN5QmF0UHBQYmFvN1RSU1dMUGhITllnanB2QjF5TEhJQm5vYzdW?=
 =?utf-8?B?OE52dUo3Y1hzKzkvUkdxL2R4eEN3OXFubi9pUVJxcWRHM2NWRWFmRWNuRUVj?=
 =?utf-8?B?b2tlbTM1L2gxYWNHWm1PZzRVaGhxaGlhV0dWOEVIMjR5eGxzT0JFRE1KT3lR?=
 =?utf-8?B?dXlQNENJTFQ1ZzFhWlI2YjVPRkJXK3dRUzdIeUVEbXE5ZWZCUW4xMjJsS01B?=
 =?utf-8?B?RUErN3ZHL215UjRDZFBycUV4djhRREFGajc3RkZrNUh5ZlRIeUpUVkd5N0Ur?=
 =?utf-8?B?OFBWUGw0Tm02YWhHSFRrNTQxOXNGM01xcU9sa1paQ1ZRYWFsSFhDaFY5TXgv?=
 =?utf-8?B?MnQ2UkQvTjlwS05qaHF1c0VxbVppc3E4RDBhdmFoMUpmT3FZQjFGUWxFdkhy?=
 =?utf-8?B?YkVGSHZrcndDbDl0ZW51WEtTQlljc1psRithWkxwYjhPeFVOQ2h4RkdsMzRa?=
 =?utf-8?B?L3NERDZrYyt1TnZzR3F4SWZGOHJuOERmaFBRVjFkMEFlTEs4Y2dsN1djM2VJ?=
 =?utf-8?B?N29qZ2tPSWxUOVAzTjh0RWorR1hmVUtyaEp6Qm5LS2ZQVWVQWnRSclpteVBh?=
 =?utf-8?B?T1dZNFpsZUZQWll5SU81MlQ3encrYjUvR2oyaFVzcWVibS9MVTBkUEV2cXIx?=
 =?utf-8?B?Nlo2dHhpeGJWVlF3bkpxc1V5S2pjVnNBUktmaE4yQzVuOHZCL3UwOTlRc1JP?=
 =?utf-8?B?SXhNdFJUS2dzL09ZRHptdXh1cU8xWHpqOW95b2Q1aTVROHQ3cEV4SUVnTXBx?=
 =?utf-8?B?QWxpS1NMaDFrRjlRYUdpTWdpOFcwNTkweGJwL1owQjhwU3Fxd1I1TzdjRHJP?=
 =?utf-8?B?YVBtOTNvMTN3NU9DR1IvckhOYnRmS0MyR0hyTVloNENBRGhIQ3VJNXdNUG12?=
 =?utf-8?B?ajRGSlhEWnk1ekFSRVhGYTdUa1RQb0x5eGdCRUcvMmN4bm1uYjE5L3p6eDZl?=
 =?utf-8?B?UmtIcEdIQUxmQWc0TFE4d3cwRTJzeWFheVlFY3VwTENSbjdOQzhJVDJjMlRE?=
 =?utf-8?B?dURsdzEvVVlERnMwcU1DRjJxQjZEUlAvUytZU3cySVhQUnYxUXNQTzdWNjBs?=
 =?utf-8?B?cmd0UVFJbFRCSFBZR2JwZDVORGNPTXpZcllXNnN2aStEMzd4allRZWk5cFJF?=
 =?utf-8?B?U1RiVkx1UVVkc3Z2bk95MkhnaWltU0lkM2F0ZHJaUmNKcHlCem9zTnZmRUI0?=
 =?utf-8?Q?6znq+BaY2BACFwAAJW2K1k4Fr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc950476-2613-42bd-9b23-08ddef636f4a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:40:50.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWRewPz2E/1aSdiGlWx9NBDPjirHq0z9lLU0MPJ7LMcxKeQ7FLsjPX4bfumgGboCtfYahg1oT7LvYjgG0FJsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
  channels.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with sleep
  mode supported.
- Add can_transceiver_phy_xlate for parsing phy

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6415c6af0e8414a6cc8d15958a17ee749a3f28e9..f06b1df76ada023f432dce892c3346f45397ab54 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,6 +17,7 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
@@ -29,6 +30,7 @@ struct can_transceiver_phy {
 struct can_transceiver_priv {
 	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
+	int num_ch;
 };
 
 /* Power on function */
@@ -81,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -90,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -108,6 +118,25 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev,
+					     const struct of_phandle_args *args)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	u32 idx;
+
+	if (priv->num_ch == 1)
+		return priv->can_transceiver_phy[0].generic_phy;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+	if (idx >= priv->num_ch)
+		return ERR_PTR(-EINVAL);
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -120,7 +149,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
+	int num_ch = 1;
+	int err, i;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
@@ -131,7 +161,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
+
+	priv->num_ch = num_ch;
+	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
 						 GFP_KERNEL);
 	if (!priv->can_transceiver_phy)
 		return -ENOMEM;
@@ -142,38 +176,43 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
-
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	priv->can_transceiver_phy->generic_phy = phy;
-	priv->can_transceiver_phy->priv = priv;
+	for (i = 0; i < num_ch; i++) {
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		priv->can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		priv->can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		priv->can_transceiver_phy[i].generic_phy = phy;
+		priv->can_transceiver_phy[i].priv = priv;
 
-	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
+		}
+
+		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
+				&priv->can_transceiver_phy[i]);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


