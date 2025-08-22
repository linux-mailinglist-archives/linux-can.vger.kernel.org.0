Return-Path: <linux-can+bounces-4291-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7403B30D4E
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4924616B36D
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514628C878;
	Fri, 22 Aug 2025 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aeYkmRUS"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03328B40A;
	Fri, 22 Aug 2025 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835561; cv=fail; b=JtiWyyuzT+KTQ5YHyeBCYduENU1E1udipmnJnAI5DFHRvPe6bBNsWIcMvqQp1WSFV3YfNCJMyZ7wE/UnWEqA79E60DUAWRc1djWjmHos2GjQJ3aYTnZjg0k8ibBod0n02Plj6PiuBR3giOLBCs16z9fca8bPE23mN8bgpHJbg8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835561; c=relaxed/simple;
	bh=gmEUhim6CwapR64Pmu/MdfVP4Ba3/qxbYn9K8/H7vbY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n/kou92eh4WBJiiiQ83PRtj+1XJG/SnGbcbIJGAT9wLfI+WWUHpvD15afLG0nkiBMCrQPFjZU/OmI8ClL/8im5kb6DKX3EQzxV+Cr9vGhELa7num9wISGPSQ1+p3aNo/idQHpvlsRcb0tv0mDMdCyeOCVaJGbNWfk508W1Lzt9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aeYkmRUS; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zip1H/f+z4VT1u0hoD9DH4DzNbdM9U8D1cILAjVO01GOuMZrQORMRD8haCgTXEGfEDWtzU7bU9GG4F8LImmxmmFShBcpp32L9XpYJHX2NgDHo+FO+KLAwGBo+SQw+jTQchTD8tWqEfm817KJxvO/NBG/yBrhOCokzKlMo+yTQmV7gC0p4bhqecHi0BcOxADz48ciqfUa3U3lqIVtqYnEWiPtoa5UCklZ2B2lTAOGjvRHDycdsELGwsJ8rZbcFXOZCe+h7Taqq3ff/+zwEZOEEzuTkZYY4Xop6KVEAerSW34J+sHqpStIs9dDsUnOoBrw0WS2c9SMosmKic7P+8yz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg1CFDAtoIzX4DqTgAOHsEDVXMc1AMIuAJ5+9K4fDU0=;
 b=j9QbkunrRnAHKUVN06rP4ZOurGt6W+AiqlUHFR4ncfqWYg0b6CPcPp3v6j8Lh7te++i645pFbosZd5OUskPcrAczm87wZOUIrT+Lx9jHKi5SYb2RZjqXqPVz2o8+CMnRgEmlRAkROnw0WSN4/qZ+L1ResCAEYt+7idTg1Xjk1XayiV2tLeoJglF3LD6DK4qZ5VL13Nv7s1As+AEKqTzFC9Dd3X7+TyHqWrhwuVKfkga1dX6lyo5czdkuPUywTcksE3KqOGG0oBnJxHnkf1+C2SqooI7edm0AL2tRhylFbdibqc3/a7HJgWeh47CmPO4m79fRct9pheQ0JfjfHCujVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg1CFDAtoIzX4DqTgAOHsEDVXMc1AMIuAJ5+9K4fDU0=;
 b=aeYkmRUSyRSnVzllAI7GWDB5acbSmOwk0s+RDk1uqSzkfjyrzQzbZOYWWacGxAGCcAuadJHbsF+hs0Fbpqj7jcVDZu9QVVvPbTY7Jch9ZPgmqvkTfm0Ni5LbbrJCXWzFGjcLjuHnz7gGUWJxZGFGuQ9Z2b58IfG9CwYz6W7JWzmLMZF2O/BuXqre+5xguvOsncDAA/EQ/JXK9xppRV0j3CJNu+eehojJ6G3lOFVYAuFsaTbAU7cFxoYedYcvegW/DMl9U2lt1XcTfAxxryLfAjIiZ2yMby1biK8c62bTT/X9uldG3HYSSCjrTRp5Uji6QFHv+/3aIaDiJ3k2SOPoJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:05:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:05:55 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 22 Aug 2025 12:05:28 +0800
Subject: [PATCH 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA1051/1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can-v1-1-c075f702adea@nxp.com>
References: <20250822-can-v1-0-c075f702adea@nxp.com>
In-Reply-To: <20250822-can-v1-0-c075f702adea@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=1906;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gmEUhim6CwapR64Pmu/MdfVP4Ba3/qxbYn9K8/H7vbY=;
 b=PTwUq0Zrx2xd8l/DNT5m9d8NDAOPsmRdTWofvWrYMRshfldk2yoNi1js6BJ9UtabSD3g7Mofb
 KhrXjSzq4vHBPd3dd2wi9eJGy6pZYNaBo/kxNvGhpjxEnojnRJ0ASFQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: aebbc979-eae3-43e8-f47e-08dde1313171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0lDWnEzVHVtZU5xcEI1OExCWFBkZ3k1Ym5wZ1hKajBJUFVzRUE2NlhMbDBZ?=
 =?utf-8?B?Q1lzY1FUN1YvUWhmY1R6REtEK1Z5ZjdEekNzam52NFE4eGVVdDFVQ0tPeTYy?=
 =?utf-8?B?MDdua3VnYmNZWjVOU0o1TU5sbDdmbi8yU05XczBFM1pjVVhoVjZVZ0h2d2ti?=
 =?utf-8?B?bTRFZnJZd2JCcWlDM3VkM1lTVEVUMWF5RnlEREl4cDIyQittakNoY1pWR1cv?=
 =?utf-8?B?SnFQcnR5RU1XaHZ3Z2dNTnVyU3UxS0lsb2lRUXZ4WExXVHpLRS9ucXhoZzQ2?=
 =?utf-8?B?NWNGTXpxT3BFMU5lTUx5WEJlbWJKUENFSnJvM3gvNmtuMkJ6NjI5S0dXMXRR?=
 =?utf-8?B?Y09DVUl1ZmhBTVE0L3ZyOHZ5a0tuZm5wNlFOTW5IUmh1dWUxWml4S29paHM4?=
 =?utf-8?B?UWFETm8rMjVOWEN1cU0vNjhuRVoreU82dnVDOE5RYnB4NGRCcHlDVW1CdlVo?=
 =?utf-8?B?L0M3Z09IVFBQVEhvVUhjSEtVd1BJelM2c2Z5eDVVbWdaNGcyVUk4OHgzelhz?=
 =?utf-8?B?NmZBVENsK3Bib2Q2Nk9obWhVYVdTN0VSR0wxVndBN0RTRlkzcGloVTI2cFRy?=
 =?utf-8?B?M3MxUmEzSEd3S1R4V2RodmNpN0RTVFQ1NkVHR09mNEtkSzI2R1lnUkFaUFB3?=
 =?utf-8?B?SDNBbkorZFM3aklNd1cySVhFWkNjUkk3NTdvK2RKaEFCZ2Q0b1MvWXVXVlJN?=
 =?utf-8?B?Uk4zSUtaN2lxTWJvY1p5QmZESG1kNTNQRkptUWIxYzQ4cWF0V3pMLy9aZGZs?=
 =?utf-8?B?cUd1ZzI0WmlCZ2ZtcWNIZ0ovSDh2ajc3K2ZLNTNyUFlSZHdLVDVxS1doQm4w?=
 =?utf-8?B?MjF4UmVodWR3eGVWeXdIcWZyWXFzNEM5Tzh4ZkdmS2Y1L1pkZ3JyZldWSWFO?=
 =?utf-8?B?ZnRIeVBkZ1d1Q2tuM1p6NnFUT3ZPWEN3NHozL3phaHNOUE1wVnZlSHcrcTNN?=
 =?utf-8?B?TXBGY0ZXYUIrSURCanNxYVZjYndRb2xFN0Nlb2pFRmREUFFzZ1p2SGx3QTdt?=
 =?utf-8?B?aDdaODJsdE5KMWlsQ0dkZE45eCtrenUzUnhPQVh6T3BZNWVRS3h6V2dLcitI?=
 =?utf-8?B?Q1pjcWxyY1kzV2t2ek45NHkxNjZsVW1ha0RXMjczMTAzNjI2MHhRM3VTSjN5?=
 =?utf-8?B?Z3hzZHpHZFoxVFB6RzhHd2FGZDF4N3phTXVJZ2VPVTZacXVEQ3ZSVUZ0a3Q1?=
 =?utf-8?B?S01qRWtabzcwTml1aEV5V2dvV0MxMlJOdW9xelRnejE1R1lDRERNOEdjcVhj?=
 =?utf-8?B?MS9pck9uSDRpU2dzRjNxMHlKTWN3VUdnbmxjMFJxR29lZ29GSS8yZXk4UUQr?=
 =?utf-8?B?WVlYV01MVmQvalhLMGVrWE9Db3ZOT3pPZEJYcjZoc1JuZmhYbUd5cFQ5blNC?=
 =?utf-8?B?bEdDVTBJWWRPazBabXcyRS9WWnA3ZEg5YVdrcTNXeU9UcUZuNGo3NEJkSjVi?=
 =?utf-8?B?QWxrT0RjSzdxMHNyNnBIb0d3OGszMnBLbWcrYkhVZDZCT3dUM2tlT1ZiUFNJ?=
 =?utf-8?B?aUxjMlVFL2ZSS3hPM0xmN2V1OHZ1WFpaOGJTRkViRTgrTFFkUERjckJkd1oy?=
 =?utf-8?B?WEh6R1NSdVVBOHFQZGkva2xpYTRYUDRaR25NNENoaWtTaDVJc1pEWTBCYTNl?=
 =?utf-8?B?Rk4vUVVWdzB0bTQyM2xFVWJ5Z3hZYXFoR05qa1pIOExScVB6MDRPcXMyaTZB?=
 =?utf-8?B?MDVvZy9NbHhmWDJKanAyem12NHg5azhVTDgySHN2ZHZ3dE1kMDZsV09FbWRM?=
 =?utf-8?B?SWtKVUZoQk0wTzdhT3JuTzFnRjAzWThqNUk1ZEcydW10SGJjWXJVVjRhZWl3?=
 =?utf-8?B?UllQTjR5dHdscS91UzFYRVlrNk9wak5SUVVKUS9JS0hra084cVgzeVNIRXdk?=
 =?utf-8?B?SnBPZFRPSHVIT1F3b1J3ZWdZakthVDA3WDBUdUhrdXNRaGc1VlBNR0tVSWlQ?=
 =?utf-8?B?bnV3dndEQzZ2T0M2bzMvMU9mYUgxYnJiUEdhcGMxUnU1c0FCelFIQ0kzV1Yw?=
 =?utf-8?Q?b01QLh3r9os5ncs3kD5i3dPgs0+Zlg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lHTURqbll3T3c5L0dhZW8vY1RzTVo4SzlKbisxekpvV2lHcHozM2JxTERu?=
 =?utf-8?B?TDdIVUJIOUh5cEkrWlR5Y0tmajJGcnJqME5JWDNTRDdEbGJRcGtwemQ5ZUlz?=
 =?utf-8?B?bTlBZ2R4dVo5NnhPdFNaZkZ3cmhkMnpOUjlkNHg2VEFZT1l0OThyWVY1eHZw?=
 =?utf-8?B?MTEza2svSUNCRW5YTVhIejRGU1Y5NVRTTytUTGtsVnVOR0ZPTERFaktyY2hU?=
 =?utf-8?B?cTlDTGt4MEdDd0FLNzNVZGYxcFg1Y1VYa1ZiajViVWt2NDNEWjFrNktPcy9Y?=
 =?utf-8?B?bHpDNVh3N2tlVEwwZXBDcnBIUEVGbmRncUpDUThDS2N4djgraVlZWmx5Skd2?=
 =?utf-8?B?YUNoU01DUGlsc1lpUGdSWU5CU3BLRUZNUEtEaThINW5hRjhIekJjVmJnbHlO?=
 =?utf-8?B?RldlbVJlbFo2QjgzTkkwMDZnaEVudERlcVNTL09lWDNIVks0U09mWGpOZVNS?=
 =?utf-8?B?ZUgrbnhwT01WeCtDQVIwdk54SHZDa0lyUnIrNkcxVElwYWdMMHhrVFh5WDFv?=
 =?utf-8?B?aHRzeTI5MGwzNkVMbytWVUU4cmc3UnZzT0x4MzhrRmpQVjJYTE1HVUtKOFVk?=
 =?utf-8?B?eU5saFRBZmYvNjQyaVFxeVNrSHFuaERsVWoveE1mWGFFdmFCY1JlcitscUJp?=
 =?utf-8?B?RWZpMXlSWi9RRXl3ZVoxK0g3N2lDOUY1R1dqUGptOXRqeTRZdWxhVmp3OWZq?=
 =?utf-8?B?NjBoL2c4b2M0VXBBT1VVWWZENExLSFJxanhMbXN3dDlEL1QvcS9TWDcvamRt?=
 =?utf-8?B?S2xIcFIwRkxyVGdTeVFHell0dkVLdGh1cTRRTW5lR2ZtUndGSmdWY2Q0Vm5B?=
 =?utf-8?B?RlBRcHFnNWdncnlBZFQrOEtMZGNUR1I2RGkxaWZDRUtxUHZCZXFBWG5sdm5H?=
 =?utf-8?B?Y3lrRFNzWlhtbDNmU3YxR1pwdDJSZ2x2VVF3ZlBITllPMTdvS3ZIV1ZHdThW?=
 =?utf-8?B?YW5wSWRLZE9EVUF1b1Y5WUNMWFV4TGI5UkwvdkJuTXBSQWdrd2pESURQdVZH?=
 =?utf-8?B?M2RJZW5hbXNINEh0VXRDL205MXVrZVNiYjJ3THVmMHNJNG04ZzIrbzdKbzY1?=
 =?utf-8?B?ck1FSXFiZEdEcDJKYzBkSVd6ZTc5SlB4RWtvMWxFTVhudkxGNVNyRnBrczg0?=
 =?utf-8?B?aHpaWVZ2c1Z1OUxlQUtwMjVmcGhHY3h6a0FtNS9DTjZxeEpaQmR2bnVOMHg3?=
 =?utf-8?B?ZWdQMXRuMFRVT0VGUUJZQnR4ZTBqbGluVkthNlB6MGhsVHdSZklxTXBESHlY?=
 =?utf-8?B?RjJaYWJhdWhRaXJMYkw5Q3BJU0lSbGFDaFpQOHRRSElTbDdnSGZFcThtKzBN?=
 =?utf-8?B?QzZ3UXF2RlYvbkNqYW5wWXF1U1pPelhjelJxMmFZdlN1dkpOT2pVUWo4c28v?=
 =?utf-8?B?YTdScEUzYTlpNm5la3RteURqeFRPMlRkdmE0YXRrUG5PNlRPMUdXOVcvTlcx?=
 =?utf-8?B?akwrVUtIZWhKK1lnays2L21uZ1Evekt3TVNSSUtaZjltUnBoT2p1bmw2bm90?=
 =?utf-8?B?V1VyKzFtTWRtcFhkckJpZCtDazRYekdTRk4zZHhoK3FWNDFrR2N5ak1ITElB?=
 =?utf-8?B?VHJpUGlYZHRVdEl3eGx0T0p0R2tHeWpwRjEzaGxpMnh4VlZWb2hWWjZBU2VY?=
 =?utf-8?B?T2wrTXh2WmVJMktSOTRHczQyMWF0alU3Zjd2OHMzTVh6dGVsVmRPRGI1ejJo?=
 =?utf-8?B?cEdQZTBsaldzaTNWY2plK1VNUVhWWkNydXRFRHowTldVVDNlLzlwU1NvOE1E?=
 =?utf-8?B?Z09pMzRHSGhHWUVGRUJiNERjK1BXTkplRnAzYmszMlJCbVpKMmhFWmdscVQv?=
 =?utf-8?B?MlBlYVovWkZRWktoeWhvUkQ5UzdFbUVqMENJbWJDY3pTWVNJRzUrbFNOU2l2?=
 =?utf-8?B?OVROa2s3VEhCZ1l5a3AwZ2ZuaGZzaDZZZHRXVG1XMDB6YXpzOHRWTGtiSUdD?=
 =?utf-8?B?UmRZVDR2NFp0Wlc1MU8yM2huSFFUeFduUXZaUFRGVUlZOWZxWjd4dC9FMkhG?=
 =?utf-8?B?aEtYSmVaZ2FGVzc0dUFydVZ3elJUeklFNk5MN3RRQkN0TzVrYlVJVW9yR01Q?=
 =?utf-8?B?bjVFRjhDdWxOeUpJTDB4QUF2SityQ2RQMzNuVkZLS25TdDVCME4yTDc2UkIz?=
 =?utf-8?Q?n8S7GQNUVA5TutezD42ZDPQbl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebbc979-eae3-43e8-f47e-08dde1313171
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:05:55.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alkx2fHnIq7FEdp1+bwip0YoGZWXTF+Xr1tY1R3h0BCX8SndyJr7CKN+KGgbXlul37FbTkOPKuGThAB5O3p7Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

The TJA1051 is a high-speed CAN transceiver which is a pin-compatible
alternative for TI TCAN1043 with Sleep mode supported, and has a compatible
programming model, therefore use ti,tcan1043 as fallback compatible.

The TJA1048 is a dual high-speed CAN transceiver with Sleep mode supported.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 4a8c3829d85d3c4a4963750d03567c1c345beb91..de4ab204ec86f91e84eba8f1a6343ed137e5cd71 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -19,18 +19,21 @@ properties:
           - enum:
               - microchip,ata6561
           - const: ti,tcan1042
+      - items:
+          - enum:
+              - nxp,tja1051
+          - const: ti,tcan1043
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - nxp,tja1048
           - nxp,tjr1443
 
-  '#phy-cells':
-    const: 0
+  '#phy-cells': true
 
   standby-gpios:
     description:
       gpio node to toggle standby signal on transceiver
-    maxItems: 1
 
   enable-gpios:
     description:
@@ -53,6 +56,26 @@ required:
   - compatible
   - '#phy-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,tja1048
+
+    then:
+      properties:
+        '#phy-cells':
+          const: 1
+        standby-gpios:
+          maxItems: 2
+    else:
+      properties:
+        '#phy-cells':
+          const: 0
+        standby-gpios:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:

-- 
2.37.1


