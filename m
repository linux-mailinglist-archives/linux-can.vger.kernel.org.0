Return-Path: <linux-can+bounces-5084-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C854BB07BF
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2038C1946B2F
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D352F3630;
	Wed,  1 Oct 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hq0XoCmS"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0602F3636;
	Wed,  1 Oct 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325002; cv=fail; b=RmoY82ZYF/ASgE9JIxebg+/3g15vURnu7C/BDGbgyMRlte3WOV6Z8A1PYLauCPjBvM9hHYj7oCg7RPHw5n4vi0DC29uaqCRYonqflLC9N2RkUe4qIm17UN5AR/q++54aveA2dCenCjap/GAi0DFs2m6Sdig7fdwQzdQZ6po+1Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325002; c=relaxed/simple;
	bh=4xh6FcVqPoq/xVP5ELJCtB89xX7UbHzcDKamXLtKv1c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=osHVgzuyg7npDvo14JmmF9TuE53RJPPpAbP6PZLNoMb6Cn4hcNYdf/PkGdoHnVJKlp4kE0YFtxFVtU9rgtv9kjgpvSOJlkqKo66EfHCqDHt57//3E1g5Gz/8dJKmk9nCZh9wBHn+VynGxzhZ77+PMuE0xN0INEBhAFv6oismTVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hq0XoCmS; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV11uYYB08G6ilM1rQ82Zpd3DF1VKuCpTHgZ2kN5ZQATcrVWNOV0A1Nobxzu3aEHydUjkeB3+3BGeTOEm5YQpfGccZSx9nK1seCqP3ZJC6ZNXwiRnVX8u8hCpPpmNxqLOGzY0o72LZ+QM2huWQm0kbaQS01vvyGi86wKgmCb6ngLmyl+u0sI3kGMNm3Ct6OrDZt5auPNDWX7KOwpjmO7zpPCPlC8qYzSm5dfLOIyg3jh0vZ9P8Of43EKXDdwrT+CnCMgHM3dsTjSLLpt/P1S/GWXchQ47qxdvAFXdaQwHCZldRBhn9s2DSIjfu0kCipHQ4O1o7OF7nD4/u5PdvbzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Que+92mk+ETQ7HyOyZcdzkdMPWARiIP0e9kzNQba2Ro=;
 b=eCzwJzh+0kejPdmdEKY+rAAs9Rlulp4ao31ZyJSDjIGoVQsuDxYiDvssPVGOy0bwWvyKy5dXQZXS0o6SFYwwtO3iHBwuNivgLTz2MlWuCa4wakvy1pn1C5h84IWWNesrEnhJbsT0O7mZVaJI5Exvil7CUY6mntkgvw9OeiH/hbFoD498mSa+IgEdnuAs8SszZCPcvJZgztQIT3td0Irifl+UUdBTvTXfiGyMfBDp4kEG0zcv8Iij7q3HpxTOD+OfnlhrMi28SkrZcchZD/JAVDLdOwIHgwD/dROfhkbZEmHRXW6fzWbeZWfm/pBfeQx5aEYaZxyXhvrIslINB1MC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Que+92mk+ETQ7HyOyZcdzkdMPWARiIP0e9kzNQba2Ro=;
 b=Hq0XoCmSdrSkyz/fdCrsnPDczXMbz9tZIIeaatPlLrqhJUeBi6u+5Eu/A6NlFzfKQNHQjugM3TYr60aIFiSqROfC6WAXE1na0kMoGNe0McE0FimVSMHSZF+/ZMxm6vp+ZPvhwGtyDtBJ4uhKvzqoN49ZurSEmKIxT1NaTmySzaIERZDVtApHJyguxLTQgJ8ci6aV5rgKhk4SCxpNsuaytRu7XoolNZC5BEHrbv3K6p7fAsgWUHkcfRy1UfzfgU4VyWjNmp82pRGzVO/WOCz6Yl9YL74ZI5zwBMW71pNwZ45V4MYnXxM/8IaT3KFIg1R518SV/WszModvy/Gs73vqyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:23:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:23:18 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 Oct 2025 21:22:35 +0800
Subject: [PATCH v7 4/8] phy: phy-can-transceiver: Drop the gpio desc check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-can-v7-4-fad29efc3884@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=1755;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=4xh6FcVqPoq/xVP5ELJCtB89xX7UbHzcDKamXLtKv1c=;
 b=gzizDQsgYB0TXnb9MGYgpteIJfu6dSJIEyOH0OFSjsu2j/I/VomqDCZHNPVk0uQHXj+O87Ch1
 k5N/Fgr0WZoD6uDIbz76CN0G9cy7MEVtoaQo97mjBHui3suFvhbtwyk
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c930347-e2f6-4795-618a-08de00edaf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFBNSGJLMzA1Q05ZRFBSb0ZnZlNDbS9vbU1ITWcvL0Q5NDhHempnZTZ3dDlQ?=
 =?utf-8?B?UEJXUlJDUWZUUnZmSlJRQ01SV2pvRnM1N2Y1Uk1uU3AxZzc4eW9CVkJWVHhS?=
 =?utf-8?B?bGwxdUNMRWt6L1R5a3hjZmVXNG14Yis0MExlck5pNEVqOVNONXNNOUl6amx3?=
 =?utf-8?B?RWhFZG1EVEZwRmhHWDhyK3lyc0JSWHN0N2Z5N3gwOS8wc2RMYWQvcmM3NUhm?=
 =?utf-8?B?b3Z2NlNoTThoWHlwYXo2RW5oUEU1b3J0S3QyWHBxWmE2SDdxUVZxUW5CL1Z4?=
 =?utf-8?B?WDZaUVZFS0V5ZDl6U1EzelNON0JqdWNSL3FWaks2eW5TdlpTYjlzVGlFUk0z?=
 =?utf-8?B?eWFkZzJNRnN2cjAwMWsvTkdzNjZ4QmxXZTlzL2MyMVJBRTRGZEZKN1cxa2Na?=
 =?utf-8?B?Y1BLR0R2UmpUQUt5STJ6QzF3TERIcUNqY3RTUmEzVlVpZEVhcHUxMHVPTnRN?=
 =?utf-8?B?U3RuTUlaVHVRNWhZM09QQkpoTFRZbzFiZHQ5WDNOeHNwY0Rxc0NTS3MvVEkx?=
 =?utf-8?B?bW5uY040MmRZZUs4Nlg3MXVwUGZLY0s0b291VUJVR3VRWHpOWDd0Q2NEOVg4?=
 =?utf-8?B?bXNwUVhyNndDVXAvd3ZZNmdORnQ3WFI1NzQwTCthRmRnNkJuZnJPaDhITllm?=
 =?utf-8?B?N0xXU0ZENDdrTU5VdmkzUC9BY2VCaUFsdkNGZnVHcWd0ZEdjNFZsT2hvb2xx?=
 =?utf-8?B?YzRNbDZ6bXFQWUs0MU5HaGNST0pIbHA2cVE0WFpaek9ydDhMV0RhTVIrTDBo?=
 =?utf-8?B?MWlpdXpLVVorUHFpdnQrTDBHWEJUS21XZVpIQVBicW5VV3JqUDYzYXlmR1ha?=
 =?utf-8?B?OGIxMWxjb0tQbHNwdzdiTkVEekZMcDhpRlo5Q2hDc0pKR0czYTRtN084ZUZH?=
 =?utf-8?B?SjB0OEZKcGdVakROa3NNeTJFemJNS3VtN0FDcXZyUmpkMktjS0Vid1ZhZ0NC?=
 =?utf-8?B?TFNxeTJSL3ZFSDVTZmhraVVUZnEzRThqLzB3TStFOGtLZlk0L3VYYlRQU2J3?=
 =?utf-8?B?YlovNnhBSWNHUWFPSFJJUnZrZmp2aVg4QU1QV0dlaEZBd0VnVStmT0ZaL3h0?=
 =?utf-8?B?N093K1NVbmgySDNBRjkyQW9EVVpGQmt4Q1RXU3dTdDRvWTgwNm1saFpMZWNZ?=
 =?utf-8?B?NUVTRm42eDJFR0l2ZGd4aDI1eURucnY1S0RHRHBjenliMDY4K3luSkFmUzF2?=
 =?utf-8?B?ek5Fd1JlQjVhemZacFlpYjZ2bkdJNHVjbUhaSjRKNmhzUHZqZHVWNmhXZURx?=
 =?utf-8?B?NDhtRm42dDdxRlF1YXFDRHlFT01UclpqQjZxc3NWOFJmcDQweXQyNjlxSWlx?=
 =?utf-8?B?S0t4TzlEU2FhWlJCVUpuNkZ5dVhieUQwK2Y4U2lGclpIQ1hCMHVmSmsyK3ZU?=
 =?utf-8?B?U1FzM25rSlpTMi9IWDkxa05Ma3JCd3VvL1FkYllhY1dnYzRyamJUcE9HNGFx?=
 =?utf-8?B?WHprd3Y1WWZoYmVQM3YvaHFZS0J5MUhlSVpWUlBaSHp5QkwyV1lmTzhaNFV2?=
 =?utf-8?B?SG95RVN4QjdpeWpkL3cvb1B1YWl4Z0VDOGdpQ2pucU5kTm5PSmJiMi9HQ1Ji?=
 =?utf-8?B?S1hna3hTMTVnY3ZSNnlSaS9Ud3hNckt0U2plNm4wdlczd2g4dzN0K3NWK1li?=
 =?utf-8?B?cEJjcmxiQkdQcUhReUdya0daTDFacVUwOTUxVzhWSndxampjREcveGhGdlNN?=
 =?utf-8?B?clY3UjkvakJoWFcvWXI2dTRPdGx4bzNBdi9SN3BlT0Y1cTkvcUMwVU85TnND?=
 =?utf-8?B?dy8yK09jRXlVZ1BtNTMwN3VlbkEyblhsUWNyTURvUmxZckZMekR2YkpxblBk?=
 =?utf-8?B?NW5JcUJ6S2pBR0NZRC9Bc3hoYnEycXA4dEVnTjkzUnJiZDJXb1VlRm1wZnpS?=
 =?utf-8?B?U1BSNXhKS1laU0ZjVkZCNUF2RHJzMitVNXErMzdXNmtIRmh1NllzS2dyMk5Y?=
 =?utf-8?B?T0p2VlVoWHFqaTdjRThuWHRiYUk3dDd6VHFCTmlrOUgvTDNLTnV4QnVZQ240?=
 =?utf-8?B?V1hZQkxlTVpUZFNtazl6ZElGNitVTDJKRjZlOW10VFYrY0VVYTc0Vi9qUGRL?=
 =?utf-8?B?bStiZGRIRmltdEdITlUzT1ZGeld2U2tUWXRoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxJT09tS1dMdXNTZ0xueVA5ZlpGamF0YWhKWmZ0eUE1TEFWdERERHY4OTFI?=
 =?utf-8?B?cnkzNzJYM0U2N2M1UGVEZWVmSzgyODF4b28yWERnQllxMTlBOGhQczNpL3RK?=
 =?utf-8?B?T3o1ZWdYNCtMRGJ4V2JyQ1BEYm0xZEhLZFZSV0QyNHhhWFdQNkNvY2h2QkY1?=
 =?utf-8?B?YVZMd3NCMm5pZEFZOTlrdU40bmp3ZkR0SklJbXhFeXdGZjhiVUxQZlg1dWk0?=
 =?utf-8?B?MHZVMmJXN0ltOXpvWnY3dWtlTFRkaHBnMzFsUUJMWXY2WTYzK1lpaTc5Ymha?=
 =?utf-8?B?Z2MxaTRVZ0dwSitRL21FRWdnS0lWcnFXSXFLamV3azk0N3J1amtyTUUxRGQ5?=
 =?utf-8?B?ZVVuU1hOZi9Pa05PQWRRNmROR3EzVjhRYVpsU1d2MXNHYUdtYURzeDNsR2xi?=
 =?utf-8?B?NDdkY2VhR2hnVXRZOUwyQS9KQ1BNdEcrZ0piY0RFTFVNdDhtMFlNRy8rdTJo?=
 =?utf-8?B?NDZZSHJ0U1VmajFRUHVhTHJ5THN2eTRvQVg1RGUwR0xnc29pR2R2dlFQSXRa?=
 =?utf-8?B?aW5XazdkV3h0WElocUxPMGhGNnM4TFErQ0IwRksrVnhqMndHenpTb1VXMFFC?=
 =?utf-8?B?TENnVUZHc04yeU1jRjJrUkwwTzNoMk5wRmMxRHFNMFJzN1pNM043S3JPY1M5?=
 =?utf-8?B?U1NxV0Z5ZjJyRGdWTFJROGsyZXkydHQ0NDRQZFk2bFA4YWx2MzNpa21aSHJp?=
 =?utf-8?B?MnRUVk01SXc1L3g1QTk5K1VkWU1QNWk2RjdBSW5jc21WV0RGVHJOaEdlZHpm?=
 =?utf-8?B?QWFUMm1PMGx2VEpiVEc4NFpiY0JsL2Ntbk92cXdEanRFSlNrTjZyaUNHRWdM?=
 =?utf-8?B?MjlZSTlOSjBjY3hUVTJ4T2lhTkNqR0U3bWc1YVFrQml2ejVaVzFPbkt6WW8w?=
 =?utf-8?B?dzBDdFJla0ZuV3YvWnpLbWJ6aVJNcGdvWnJjOUNZQWNwZlZTMU1LY29rK1pz?=
 =?utf-8?B?VnRPZEFuWXd3bDQ3NG5Pb1plc2hWN2hic3lzRHNtd2EvNlZ1NnRLS0VRMGhQ?=
 =?utf-8?B?cC9ELzF5OCtkMUFvMVZRTUZISFNpRVRNcGM0Y1paNGlwUXF3TVJDUWtmN0Vk?=
 =?utf-8?B?SGp4dDJPRjU2R2YwSUlicU5rUUU2YVROdkZkeVJrRzd5YzFVNWVseFVPSUZ3?=
 =?utf-8?B?cUhhTGVJRjVLRk92QzluaGMzYnZCY0l5VmVoU3c2TkhLeEVPTSsvS3ZJcVhX?=
 =?utf-8?B?TVB4OWtUNlNxQmtFREYrYmppQitsQWl5K25PRitSZmRLcWVaazVxZTJaYWZJ?=
 =?utf-8?B?dXdlYXR0NlVJUEt0R3Y0bks4bFZhQXphMHYxeHpsNC84TnBxNGM1WVhEQ21i?=
 =?utf-8?B?b3ZQdkdncXVLa25uN0FLYTdEc0YvWWJOQnBITm9WM080b1NGYWY4RXdiNjVL?=
 =?utf-8?B?YTJtbUVYQ1ArdktmdXd6Y2tKcVZvaWxmclZBSDZlbzBhdG1PSE80VTE2Y2FX?=
 =?utf-8?B?Q0pQVGxhQlMyV3VFNk0yMTNyWi90OTJRMlBBdzNXWFFSWTloSW9pbXlzNXB5?=
 =?utf-8?B?WkpnbmMyZE5vVEtqVExldUYxdjk5eXAwVTlGWjFiL1c4UUZBRDRGU2xpd2k5?=
 =?utf-8?B?MTVoV0JTZjZQdFpZZitSR2NKeSt2TDNBc0p0RmJ3cWErby9rakdhOXc0eXUw?=
 =?utf-8?B?ZWlaYU1xaVRMcUFUamFFMzU0KzdwS3czRDZ6QWp3Qy9MNDlJMkFBYm9JdkJO?=
 =?utf-8?B?RkZIUk9PemN2TG5FQmJkczN3UW9xTHFuOGNPaExEZTM4a3Mzb1pBbWh5dWRa?=
 =?utf-8?B?U1gwUDVvZlpWNGpUZmJkOWwyaElLRytUbmgyZ2NWSEYwR1R2Vk9WeWV0a2ZP?=
 =?utf-8?B?UWwrU2VvRHdjcXUrbDQxaENIS1hRWjNkcUs0L1pVdm8wbkFMcFNUdjZLSzlr?=
 =?utf-8?B?MlhGdWV4RFIxSWlUWXJ1a1BKOHcwWGxNdTBJc25VZk1Qem5xdUMrR0k5TWFU?=
 =?utf-8?B?bG0yamJUSjd2WXpyNlQwZmxrWC9CUjVtRmtSS3NMcTF0YnVVUk5VM081YnNs?=
 =?utf-8?B?R1UwVHNrZWlXM3Uxb3l5b1F0Lzc5RGZHZFYwRTB0WjN4MGJ0WWtIMHZrRHNn?=
 =?utf-8?B?d3hRZEg4V24rMHVhRy9pT3JlTCtpSk9mSUU5SUpibHhKQ2VITGdYazh5ZzVj?=
 =?utf-8?Q?jNcQgYthOeEHeVDUvNsYRE7vH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c930347-e2f6-4795-618a-08de00edaf19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:23:17.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKz6am7KBRWsby+2ReexHn7dLWQnL1iks1zk38Df5O+qGiFbjazdA2oU+A8JFY3V1OL85b4NCCuWzpAWPfCbew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

gpiod_set_value_cansleep has an internal check on gpio_desc using
'VALIDATE_DESC(desc)', the check before invoking gpiod_set_value_cansleep
could be removed.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 09d1684895568ba8bbad7cdb47bdf984966459c3..89189be9b795a626dff7046c6a60cd4b841f4f0f 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -47,10 +47,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 			return ret;
 		}
 	}
-	if (can_transceiver_phy->standby_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
-	if (can_transceiver_phy->enable_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
+	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
+	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 
 	return 0;
 }
@@ -61,10 +59,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	struct can_transceiver_priv *priv = can_transceiver_phy->priv;
 
-	if (can_transceiver_phy->standby_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
-	if (can_transceiver_phy->enable_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
+	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
 	if (priv->mux_state)
 		mux_state_deselect(priv->mux_state);
 

-- 
2.37.1


