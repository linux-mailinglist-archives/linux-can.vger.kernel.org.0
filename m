Return-Path: <linux-can+bounces-2714-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BEBA25B82
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038AF188818D
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624F2063EC;
	Mon,  3 Feb 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WEUUXc0v"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522C205AB4;
	Mon,  3 Feb 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590830; cv=fail; b=oOzdCm3jGjBLhJTGiw734raA82iePVGkUBAQvyU7CUGMqCiYZwkc39N1APMg+r0FwzW5KYcwna6NwdosxCS+K6eFlMNmaTA9Wn6B5y27q3uiM4ggIIJQr5kCrzi/FK/INd6/C/LjJwxcvZjSJUecHc8llPRAhioPvH6D88XsBxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590830; c=relaxed/simple;
	bh=RmqBdZOZjZ828rE3khQLb2Vd+eHHwYH3lKw1S49jQyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pOwt3MO5T/TEQOEGeUXeVsVGZRKmVMwvuqYv/uhT2rBAhONB+ttwz4/0VdQ7A6WFb8+atfgtwyPHFLfqASMU37GVnzE31pgDPTlISjr8SiLnkqyYpKKlq4hhvzDLRy+9qUmY+u9Vz6o2UIM07v7hYuVgukHhMk4dZpBC8yAGzuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WEUUXc0v; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYFZCB8Oi2fcOEuYkVfK3CzRhl2/7U/EglpRTKPyEne7Fw3Dl+UjQLbdhV5MmVy7vFS6zKGymBvlDcB2qDbXGALYGtdlWphWTAV3jmFzrob3Uz9Dg9SG00KrOBjN/j+m3MqGVkXQNTFVQZrzZky5OltpsOKsjfeG+1rQgqaSdnB0OHG70myAkinsrtyOud4xgR8Fr2yonM1jkoil+cTbCQgUi/lJguQIOebQtYzGXm/oy9B//lwgWtn6b8q0MD2yyFpes4Rk9uD5khH39mwTzS14j96w8H4VTdQ4AzZcM3+1gxMB14wrqZ6jcceoUIXuZY7+IKjo3y8Cpym5fKKNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2yBP8o4E4p/Uhx6wa0uNvSO6DKJw9Z8J8pGAHY2iac=;
 b=Z54e1EltbJpQ7d2xd9arQP2rPb65Y/ZB+4ZaIrus4qoxGkDbgvt/KYxoRw8QqFkPOf5ErhQM69VnXPwUNAcYPv2Qn6QeILkuDbnlOV8s4t0L/eqdSasRUf2LhBreeDnTGAQ1O/pjxdSQ3Q8uT5bw1kOgOOUcSvmZZbdV06vRVYM05rTbj0Dr98dlfbF3fpZpeTn3WSz0DAQAUvw2vh4IL+ytvsut94TjKkGHqVe7U51+Dik6lkPwVEQaXhBDuxsmYvb05mOE1mRGh8YIMMSG0KPk1wnxBfi+HljTEpea2r5aT23EpFtrkOAEOKootKWUQxyoColaW7ES71iLkFYVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2yBP8o4E4p/Uhx6wa0uNvSO6DKJw9Z8J8pGAHY2iac=;
 b=WEUUXc0vJBqhope4Izv1mAEb+pLf/X3qzC6b+6/0/QmSUVmeRtBlaUfswDYFAjsbV3MVGsbDUFMLrc6VNpP3Z4pHKPfBanEmXZe40OaFMBsUAgg9Sj1JXhs9hTX0FKVBN83fNlT+pXE3yWzg1zY+BptMcs4Tfrok1nLT6oYf460L/2dqhyS/a3NmjLMxxuRODqU7gVprczAqrm+9dEH/SDYAjj70bWtTQXwW9GjVl8TjFKRBWq0ohusT7kIOVu0Xz1glcHCSOPY4rGDS2Umf2JeoFcmrb82ZWA3+bdf3ENKAg/E1IVTT8Szzm70N3itH063nG+GDKEJI+dRBOU8XoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 13:53:41 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 13:53:41 +0000
Message-ID: <0d639e78-d5f5-4c58-bb11-fdd9d3ee1ff3@oss.nxp.com>
Date: Mon, 3 Feb 2025 15:53:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
 <20241204074916.880466-4-ciprianmarian.costea@oss.nxp.com>
 <20241204-chipmunk-of-unmatched-research-e89301-mkl@pengutronix.de>
 <1147e8d9-b6e1-4290-9cfa-888d93f185e9@oss.nxp.com>
 <20241204-fantastic-rare-civet-8d24ec-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241204-fantastic-rare-civet-8d24ec-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9ce2f7-6876-4493-8fe4-08dd445a2ae9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVU2czVsMXMxa1ZISEh2aExGcXVlMWRFWGdrVHNpLzNaQUR1ejM5QTV1aTN6?=
 =?utf-8?B?ZXNMa0ViUGthcUpldVJWMlFEdWFjZGFpcmgrclhkVVRYSWQySStIVFBkTEdh?=
 =?utf-8?B?VEl3VFpka3Nxb2g3TXRLZkhKaW9JZlFRV0dFcHIxQ2VrandrU0VZTHlBUHQ3?=
 =?utf-8?B?Um5UQkplWlJybHpmWXA2NkhINWV5bDVpdmdHVVFzdlNtQzd1anFpUjRKREJ0?=
 =?utf-8?B?ZENiWm5zOTZvS3hiZEh3K1VGWFRoY0x4Z2ZzNjNTK0g4TVBBckVoSDMyUGwx?=
 =?utf-8?B?UDV2S2U3WXhqdkpxNUVmYVAvUFhRUFNteDhhbjAwOFBxOE1zMGRpMmQ3QUtL?=
 =?utf-8?B?NDgxYllUTHlRQzBWUGZPU3lFUU5nTVRUbTRxZno5bVlZUHpkRS80Kzh2aDhs?=
 =?utf-8?B?QW1KbHVkOEdSYnpCQ1A3SmN1c1Z2VmwzODc0RWt3Y2VjS2pEbXZrNitGSTdD?=
 =?utf-8?B?UnlaNHgrZDE2VlhuSHIxQTdsejZVMUh4bkluWmZWNkFsT29ndkZhelQrRmRr?=
 =?utf-8?B?bXp4VmEyaC9RNDcxUFVkdEdyVEFGTTRNaDVubmF0UGgxYXhlcWJJVXFqNjlE?=
 =?utf-8?B?VWMzUUxjQlBHMTcrYVllTGZtcmZDQWxqQnQrU3V1b3YzanBkY2VxZDZ0WkRQ?=
 =?utf-8?B?YlNvdlVWb3JQRFV5VW03bWt1RlgrQkJqalFpelpoZzBDaHZJN3lZc09GREhp?=
 =?utf-8?B?WnVGNWNDUTdvRkI0VHZzdUZSTW5pOThaYk9WQk1VbmxXMkFHdGI0cmx0YnQz?=
 =?utf-8?B?Q3ltbU5OMXlsSVlYYVZyRU9lTXhJVUk3Y2ZTMkFiWnErNnR2ZElGNzNFcnlF?=
 =?utf-8?B?ZS9YQXc1Z2pvRThMbEt6L1l5WUh0ME5tNDM4eHBxem5COFlIMlYvTjhRc0p3?=
 =?utf-8?B?KzdQRURwSFc3QzlMTkw5Q1dqRmo1cUJxb0xpMkdBdUhvTG1pbkl0S29vWXJL?=
 =?utf-8?B?Y1paNkxkNFdML2lMYlU4bjBWVjV2V3JLUnFqSUZaS3Q3VlovU2pyOTFnd0pZ?=
 =?utf-8?B?WUxXT0hVRTJ1OWQrNEc2dzdCS2FvRE5QNmRXQTlGSFprRUJwanB1c09Ld3lT?=
 =?utf-8?B?dHQzNk5CNlViYkd2NVNPNnNoNElTUktjRHVOUzBxdnB4aHJLOGhXMVdlZGMx?=
 =?utf-8?B?d3dDSDc4WDVXejB4a0V4NXBFY0hlb2V4UkoycytOY3pvd0ErZHl1YzRMUkx4?=
 =?utf-8?B?NVcrY0NnMngrQTkzeVdhRmIvNEFzemRCVGthOWZnSHl0SWUxSzEwci9zZjJa?=
 =?utf-8?B?YnY0TllDenIwc0s1TWRSY1dHUWhON0lyYlpFcllKTlI5NUUwdjFDSUlBTXA5?=
 =?utf-8?B?eXN6UGl2eTRvTDMzUE03YitpZzRnR3hPV1JIT2VoVVYzVFVzUlFEakxXV3Bl?=
 =?utf-8?B?cFZaVjgwQXF2K0hSNmZLR1NDV2VWZ2pZeEI2UkR5RzdDajdYSDJ3alFmWHN2?=
 =?utf-8?B?RXJGTDN3SEcreGFpMDZjNFMyU1N1UjV4U2lQTVFmcUd4ZW1wcHh3ZTBhemkv?=
 =?utf-8?B?ZTdCbEZpL0tPNFNlL1VQMHI2bUwvMUx1dFlSd3lBdUQ0disxZWZPWVFOZzBK?=
 =?utf-8?B?RklEVDJqOXUyNnArdjZ2aUxnTU42T2ovbFkxeFlnVGt6WXJ2ZmcyUWZNaW0v?=
 =?utf-8?B?WlVwYTJYNnAzcDBuclJNTEkwL2drSkphMVNDTEZtVHF1RUcyT1VtOTlOVzlp?=
 =?utf-8?B?OFd4ay9uWi9tZnFvTGVFd0lxcEZ3MXlEeTdET0l4SGdHZG1OTFlkNktibHNo?=
 =?utf-8?B?MHJDU2N5NWRuNGZNZlJSS3lKZllBT0xqZGJCcnZidEc4cEphcUE0ZCtYVFZq?=
 =?utf-8?B?Y1k1YjJnbDVNR283Q1V2NmEyY280ZTJxOGhDVTZUREVIcXFwekJQSElaN0Ro?=
 =?utf-8?Q?U87OXaGkw9lVO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGZzTXluYTVzYUVrNkNWY29XeS9HS3l6cEZFdUtLWnJLTFVjMWY1UXUwL2xn?=
 =?utf-8?B?Um9yOWVlTXpENmxIMnlyWllrL2dUTCt5K0kwdW83aUxaTk43MFNGSVNrSjl5?=
 =?utf-8?B?SmJVRmZpOTJvSVFjazZIb3RZS2VqR2dqUHNXRUU2WnZGdlIzQVArb1lzeVR0?=
 =?utf-8?B?NERmeGF0WjBKc3JyVi9rcHVEWWJjNENXK3VzR1E4b2NOR2UwOVl5NEFnQ3FT?=
 =?utf-8?B?eldhWElEeWo1eWxXZUU4MkdqN3BId3NKZ3hDTGVCV1Njc0F4VysxNjJLVGVW?=
 =?utf-8?B?T1U0VW9McExnQWE1VmhUcGdaWHUwb3VQZnVOUXNreDZxT2VPeTJ4a1dLM3VJ?=
 =?utf-8?B?SEE1U0FFaEoyVVE3VFAzbXQxYVFGZkpyUU43MG1tMTUyZWNzRlJCS0hCano0?=
 =?utf-8?B?T2pNZDlkYWwxQzF0MGVZMzY5eUp4MHV0SVVQZ1pGSVIyL1V2d1dUK294SElz?=
 =?utf-8?B?eWpRTTBFOVlPMnZrSk5wdWhyN2czelhNQ0U1WEI1blVsK0JQblVwNHVrcWx4?=
 =?utf-8?B?amlucGpETHpNaHAzdmJvR3E3WkEyMEF3UENUdDJqRHAyanBSWFltTjk1d29W?=
 =?utf-8?B?ak5MbXFKUUFBdDVzMWtlV2dPUnc5b1N0VG5GMmU4L3hCc2MrMVBPTU1yN0JL?=
 =?utf-8?B?RDE3TkIzNWswMEN4QXhNOXFBbFZ6eFZTbENPU3lIVGVCcnhkUUN1aU9XOWgr?=
 =?utf-8?B?MVlhOGh3b1QzUXRCY0VBNk9IWXAwUEw1U21PUGNkQTJyR2g2Rkl3Zk1CdkNu?=
 =?utf-8?B?VUl4dGVPMjRyWFQvRjdkNnd4UHY5K0RWNzRSODA1NFpwQ2x0S2N5bnlydGZ0?=
 =?utf-8?B?UlFGeGNPOHFJbUhhY1FRQzRJejIwTFdnY2xSb2kyM2FlUWdGaU12SHliQzhE?=
 =?utf-8?B?K250VHhyS1J2UUlpMVp4WjY5aitnUWZRRmNDbzIvSHpHY1Q5NE1NUlhkM0dB?=
 =?utf-8?B?NGxOanR6MmVPdjd3R1Flc3l2TUttelZVTXdWRXJvcXpqOFNqdVpSRWExTFNa?=
 =?utf-8?B?Zk5HWWhjNFRVZ2VJWlAwWGZ5SFg1TmlZTVB1N0RmbzdnVmlreW5mT2M1N0lT?=
 =?utf-8?B?cXRaME1iS1ZmNzVNYVRMMG1xd3FqM2d5Y3hlSGVDTmlld1VZRUtoRTFJSFJN?=
 =?utf-8?B?Q0lSZy9KZjNXNlhYaVFpRFV0Wk1TR2JUdGNsUHc1ckhKS0d4dW0wQjhWQ3VW?=
 =?utf-8?B?RHAzcGxPVmZLeUI4TmVyTzRRcCtvNnF6eVFtWU9hbitGVnFtbjVFUW9CdWt2?=
 =?utf-8?B?eU9vTVRDaFh2Nk96bWxwR3NFRGxMRXQrTlU0YjVYNERNY3dIUlBQYnN4aTQ4?=
 =?utf-8?B?d2tZQ0U2MnpKVEo0NG1LTytPVURCWU0xMFMvR005TStrcWcwbjZZa0JVWEJU?=
 =?utf-8?B?VHZieUpKa0djVUZ4QjllS3dtQitsZktEUS9MTnNXSGpEWWRQUUg4ekw4OFRs?=
 =?utf-8?B?MGJiS3dhU0c3ZkpXUWIvcDBqWUFNZUhEZDJEYVpsVnNmQkN1ZjFJRTRzRk9Z?=
 =?utf-8?B?bmpndGN6TyszSXA0L2YyQ1h0ZURKS0xXWHRObXJNZ3NhUlBmVm56QjM3YWJ4?=
 =?utf-8?B?QUtkekNrRXZNU3VqZ0xKNzYvcXpPYlgwOU1pcWp1Szd4bzVhMmY5ZEFkQzd4?=
 =?utf-8?B?a1A2YVBnOEVzR3A1VmNOTXo0TjFoNXZ0dGtCdi9SdkJFRW5SWTUwUFVETlEw?=
 =?utf-8?B?YmNxbThwVlFvZmQwT0Npc2t4ZXMrU0dISUoxam9KOXQvNGZsbFlQOFlrMm94?=
 =?utf-8?B?Y1V5MUc2N3Q3bHZHRmNpUzdUUC9tQUN4eGpuTEI4WFZkb2Qyc2V0cnA4dzBh?=
 =?utf-8?B?VG5GbUJOVHZWWE5KRzhPSVRIUllkazE2SGlvTnEvbFdYVTZ6eFRkM1lzYkls?=
 =?utf-8?B?ZjhkUmRyQUtkMEVGUXJsMG9UTFhpemh4VUJ0NmpDQ05YblBCQjY3SWlDcXFt?=
 =?utf-8?B?UXROazR6NFR5bE5PczBDTHhubi9RUEt6UnJrYW51QXRQS0hjVjY1WG5iNDdP?=
 =?utf-8?B?L1lqa2JIK1FhVUhpMUpqUVliUlkrcjNFL04xRllldXh2Q1pFQldwYllaeGZJ?=
 =?utf-8?B?OTdnUFJzYUtueXZ2QUNjNEVtWDJubkx5L0ZBMVVpQWZRUVY1bml3c3h6VG9i?=
 =?utf-8?B?YmQzdVZMK1hrc0c5Zk9rOEpxYzMrbmo4RWplaiswZzhFbjJ5VTVLdDh0dy80?=
 =?utf-8?Q?DuA2k8U3VQH0TZLSKyA9IPc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9ce2f7-6876-4493-8fe4-08dd445a2ae9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 13:53:41.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIeZxAdCEzyHoe42v3dEAhqfUbrNIwsSjBVQdvue6gPsAiXmMWSZVBpF0bYYscuCKZ98miBV/v2f9lgDDX3zEynIwev2ap4xDDVMp/fbWRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

On 12/4/2024 1:48 PM, Marc Kleine-Budde wrote:
> On 04.12.2024 13:38:51, Ciprian Marian Costea wrote:
>>> Unrelated to this patch, but I want to extend the "FLEXCAN hardware
>>> feature flags" table in "flexcan.h". Can you provide the needed
>>> information?
>>>
>>
>> I would say the following S32G related information could be added:
>>
>>>> /* FLEXCAN hardware feature flags
>>>>    *
>>>>    * Below is some version info we got:
>>>>    *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode     MB
>>>>    *                                Filter? connected?  Passive detection  ption in MB Supported?
>>>>    * MCF5441X FlexCAN2  ?               no       yes        no       no        no           no     16
>>>>    *    MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
>>>>    *    MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no     64
>>>>    *    MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no     64
>>>>    *    MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no     64
>>>>    *    MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no     64
>>>>    *    MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes     64
>>>>    *    MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes       yes          yes     64
>>>>    *    VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no     64
>>>>    *  LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no     64
>>>>    *  LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes       yes          yes     64
>>        *  S32G2/S32G3 FlexCAN3 03.00.39.00  no       yes        no      yes       yes          yes    128
>>>>    *
>>>>    * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>>>>    */
>>
>> Would you like me to send another version of this patchset with above
>> information included ?
> 
> No. Once we have Krzysztof's ACK for the DT binding changes, I'll take
> this series.
> 
> I think we'll make that a separate patch and maybe add more information.
> 
> regards,
> Marc
> 

Hello Krzysztof,

I've addressed your feedback from the previous version of this patchset.

Is the current version ok from your point of view with respect to DT 
bindings changes?

Regards,
Ciprian

