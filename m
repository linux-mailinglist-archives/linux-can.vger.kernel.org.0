Return-Path: <linux-can+bounces-7824-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kS0OAbiiKmp1uAMAu9opvQ
	(envelope-from <linux-can+bounces-7824-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2026 13:57:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5967B67192F
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2026 13:57:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=dI8sBQUe;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7824-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7824-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C0B9302307D
	for <lists+linux-can@lfdr.de>; Thu, 11 Jun 2026 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0BD3D903B;
	Thu, 11 Jun 2026 11:57:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00F3CB2E7;
	Thu, 11 Jun 2026 11:57:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179059; cv=fail; b=o4w2UvGwXHsS9AFs4AksJNNYNYlbybqX1rs6cFJFDFjGUp5SpelRWeb8X5rDqh7oDaHXk4Qm8jiQqiaUr8V0zOxvKHSxVdO0iIraIA2QLa/ND/KxkbHyG3mbqetXd27biw113VCEBWElxTmtj3CUJt6gPrWVpkxSWuk/zz+BX+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179059; c=relaxed/simple;
	bh=/9sEL9k0iQ3zrr7LBfyXQKqHcNAvcAni7XJgoD6RA8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XPzJVvorlLo5sRDS1a+4FzI/DC+en7GOmf4zRYbk1XK3boyivSxXH/il7wHIMl8Qwbs+QM+cpZQUcdKhOSyYALS6IiOAOGOYIccLcZI5H5BIKjV1PnCx+oeeOM9a60Ss3wFuTbdMMNT9T/X8AcyKgmGy8C3EH4YNW9U/5EwDQCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dI8sBQUe; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUT7UsUCVWq02jc1wJO+JGyXQVH67uxQED45ZVa9w1c/AWYjxUPsf7oseh0WtEDPHvw93DFohYCu712IREJMwn4r2iM4zoNrCB7imO5VCplBkFIXNZZjpaQWXFXZIZh3Nvs06XwwWeSLT67AXX/ulreJk9EXSdLR0l73BQ75NigcB7S0teQc7+mNwJGN7i4gk3ItY5i2yhItG6LuPLWT1SNQVs+7FwiDw0NbnZvYnv7YlozzCnve51dJxf9MQqEZZ0PuqHt4qwlWZW8Q3Jq3/cZdupol8oLgFxBMojn5m3h9Hddyu3san3Bw2Od3NWCsBMdSmGbWGabQck80yvJAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN8FoiLXBrUDEa6chVjhg7WM3Jrz9nCWdWW432XYCJA=;
 b=usNwEAmsvAv/qda5XO/uN6sCD21gLODSYWxtO2I/7PnEf+6jPVxIz5rP1roLB0FiTxlAAIHs3oydyf8SoGDprPsW3ZDiIbb33IwZW907Dy1iBtes3OtjNL25AaL5BM3/T1di0oV0EHMkHgCDWCS7jYpPeN9r5dwqta3I/ruLgSH3AKZ8TcC1YWGM8i4cuVLb70pVisw8UVEuQPm0elXCUb5HO1wleUrlU+togR1y1Cd852wUhWiL+Lj4QPh8yJB5wnu/ods3/zxveHIVD6bjwTTm/ixzaDsUhF6he4zSNdDwK3+CvGVJJycvqozwIq/kTl+sp/BoYxs+qvjbfYdzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN8FoiLXBrUDEa6chVjhg7WM3Jrz9nCWdWW432XYCJA=;
 b=dI8sBQUenJFGuEp8ZxgGd7CmlFPmoCpG8D23vMBunSoVu7Sc1hDgjSrN/E2Y40L07YRbEX8RVVruf1GfTEAFAMWKvAA+5Hu/FQS87DOlrJzkJOl6ZsnpGXpWmt7PQiK/zjIrw6wLYB3+xEwCMuD2EdOZijA1SfFNfeOn0fLE+t2MgZ71YnvaBAj5zWf6715at4oMqBarsZFutoIRHLRvXAcelsDYHu81JZNNbT+o4EMP8vWn7V75XWOFLMi1Bo31hz0XnKlp6ZgLKx6mWX7qh7cGJxlbYENkqTpCK/oayqXdXVrxhFHxiZpp4MRlmb22rgmDcnkhQtZ/bd/+IAqzXQ==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 11:57:33 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 11:57:33 +0000
Message-ID: <f3db6b3d-88ab-46b6-8c33-8cacbcbe0d46@oss.nxp.com>
Date: Thu, 11 Jun 2026 14:57:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>, Andra-Teodora Ilie
 <andra.ilie@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>, Haibo Chen <haibo.chen@nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-5-ciprianmarian.costea@oss.nxp.com>
 <20260610-crouching-wild-mushroom-c8bf6a@quoll>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260610-crouching-wild-mushroom-c8bf6a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA4PR04MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 752cc8dc-79b8-4f4b-9146-08dec7b09f41
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|19092799006|7416014|376014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 LBlVs6NlbNnSbGIlesK8Z1Ld42sWuL5bX7O8UHM3RfU7lNoUygyYY69DercUD7e0Z/985Tpu/LRcn+XE7VSLHOmR/CTka4ecMmoyCziw3DdZM77WbxSRXAriJu1JyJtwGazmBQnTxZyCRIEFdSaK20w/jruqxPKtR+Tb7lmtBoTn6QYR/4TUGRQ5zSY5o2m1goCmU6qHPylmLfi3KoVdlxINuP8edref3mxDktZ6SrpRpslHJZlke+NUvN8s4wsurRcw4WeiadEEktiNGw2xuFUx0cOVSnoWx5YC7Lv3PgAIA3KLnuO/1QkeGdgEqMzUmhPqjZH1wyZNf9cFi83Sst7LwJZWdQeQhQUL4tjIQ4m+Y2il4jC/a8tmUU3vjc+DrYrREUjYbjCkI5JDYR902S9X4Z9mBGyW4r+zjfzHENldj/dCgbpW2z5pBggOZ7KZZwEM2GQ2hwBlg+zfbTALkvaglemWovm+YlkpOqmle1sU0RYHB1tDXbiXnUV+yC6M6++Ibhao9+zq9SPfPgMsfKBcZkGAk3SX+yHID6S/ik0xmuJZ+D9qoKWNkAvDAlxF26eTU0HVBQM8HmzLdMCj0b7lIVTCLGm0PzV4waeVl2nQWTJBV6SkaH1WObLERxrIfV3mbBApOwE5cQFtNIaKE3IAAguiyWDKD1HP0Xycev3FYWF4OIVPUANuqAXm1x9x
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(7416014)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L0FnUDN2NDNXZ3BkRmhNWklHSTI2RVRzRTdqZkwwR2RETzRqMUxSS1plQ3ds?=
 =?utf-8?B?OFJRZERka0NYbnpZQ0VBMlR0ODJwdmdGbTJOUGRtWTQ1cEY4SkVPcURwdFdU?=
 =?utf-8?B?STRucnhaaS96TFFoOERON0k5bFA5cHJYSG1CN2FuT3d0S0V0QkNod1RLOVBV?=
 =?utf-8?B?UDN3aS9ZVUp2UmVqa2tFUzV5cVYxbkNxaG8xMkNJYmZXcC9XbDRFcitCRFZH?=
 =?utf-8?B?S0pvL2lDWVFtYk94V1VPVUJXNUJSTGgvZXRSRmIwZFdSaE1YRlU2UXZhSW9J?=
 =?utf-8?B?Zi9FS3ZJUUh1WThxTXg1bUgwVlhqR2t3UWNjWG80dXN0MlFjSEl5VzhlUDdK?=
 =?utf-8?B?UkZ0MmxTNFY3Z2FHeS96SHNBMDVGYzFkMUNCaklaTWZLV3F0c21yRkRtRVZw?=
 =?utf-8?B?aVVRZUg0ZVovenpNZ04vU1ZGd0dvY2xjYkM1SzlOL3gvcWc5ZXlDMGloZ0VH?=
 =?utf-8?B?WHc1UEtBd05USlpxaGNrbHRFNElrMmQ0Z0tucDBER1ZzT3R5QWZmNGV2ZVVx?=
 =?utf-8?B?ZlNxdHNISkw1RithZkRrUDg2OXB1WWxLWnE1REg3TWIrSGRpcmI1cTk1Ris0?=
 =?utf-8?B?R2Y1SjBjS1RCZVR3aFpmdHRZczRjTXBOR1luWkRiS0dWT0hkZEE5ZXhYUDlI?=
 =?utf-8?B?dGNwRzNZNGtLc1o1TnRpZHpMOXhnSEtOZUQ4SFFscEs4YWJLRGhJNmxEUy85?=
 =?utf-8?B?bHpTcmVLYUVBN2lsSW5zaVUxd0xTQ3FrdGp0TWJkaUt4NmpqcmtZM3F5a0dB?=
 =?utf-8?B?aXVrWWtxVkNBREx5Wmh2UkJkSkhHdmVIZVRidzM4Y3ErQTRWQXhEWG5HWmZi?=
 =?utf-8?B?bStSSzlqTHRTdkoxNGR4cmhSSE4zdU9KNkxpUHVnVVMvZ3liSzZhZzJnSkxV?=
 =?utf-8?B?YjJvWG1TTWNSZFo1WUliZC9zOXJweDhhQkZ2STY2SlZKdDdMa3hJeTlSTjVW?=
 =?utf-8?B?SVFaMjNZL2xXcGdtYTNGeFFkYzUvTUloRFMzcTJMN1JlV3lhVitVRzRLaU9Y?=
 =?utf-8?B?WmVWR3FaSEZETVV4dVFpNlo0OXp0RmpWaUVJNXlGSkIxdnM4OFpQcWVxbHlO?=
 =?utf-8?B?S2hCMUFLWDA0bjV6d24rMHdhVm43RjltYjBqMGZIeGlDK1BDNmRxangzNmZw?=
 =?utf-8?B?NEdtRGR4M3NGQ0dXcGxBcVZBRHR2R2ZaNkZzcFdDSUdRRnJoRjl5b0wzWlZi?=
 =?utf-8?B?c2JwR2ZvVHVsM2NOUWJWMUFSNjM0ZFJuRTdVNGdIWFBkL2VwVHFXQm1HdWNJ?=
 =?utf-8?B?Q0FSbzlLVWR3RHRISzB1YWN2ZzV4SUlHSmxFYjNFZTR6MUlid1g0NTRGRzZB?=
 =?utf-8?B?RlI4eThhMnpOOFFPaGhXRWRoai9TaTZ0MkNYSVA0WnZ3VjBiWVFCOGhzQW9N?=
 =?utf-8?B?OG9xRGNrRWQyQkhrcWxSblNqeDBXSGVtcmkvbG4wblVkcGkvKzlubUF0SHRu?=
 =?utf-8?B?OWkyc3h3Q3B1K0JrMlB0VzNpamNqWnVBTjN4T2tvQ3FXVXdGc1pNM1owM3hE?=
 =?utf-8?B?SE5SVjFnalpKR1B3bWh2STlWNG90RlByVHJZZTdaVzdkZk1hVm1EdUtEY0tX?=
 =?utf-8?B?bFRqZzB4YUN2UkwrS2lISkxhS3V5SmpGTFM0TEUvNWlFK1QxbGdidkJmbFM5?=
 =?utf-8?B?QURSUTJVeGtTMHVOUnJUSnRMTjlpdVJEcWsyNWQrNUttaUhkVnR4S3NNWE90?=
 =?utf-8?B?SFN0M1AxOTZUdm1PWE1WR3dJcFBYZUFuU09hclJPckhVQ1hWb0x1UHJhaC9T?=
 =?utf-8?B?N29BNkw0MkIrbngzbnROQXNhWUlxVUJBcExlT293L05YQVdMekNiSUJCNzJm?=
 =?utf-8?B?VXR6YjVaZUNjWnNDRHk3RlFjUkRFNDFoRWVCN3FXNmRmRzFuaS9WUkdoVmJZ?=
 =?utf-8?B?OXZHRXp1K2phQmRWODdNU2g4NXZIZnBQU1N4UlRRQ3ZkZFZLeHNPQS9xK3Vi?=
 =?utf-8?B?TFBYYXhBb2lDam1SNXN2N2pmNDhqNTJseWUxTzNTY2dUVHk0aGw2NWJ4VC9R?=
 =?utf-8?B?d2k5V3g4SDhwTnhuVmpvV2RoUUJlbkNGZEZUYjNnK24rZ2RpVlQ0ZlpRTVVs?=
 =?utf-8?B?VitXckVjeWJNNnZPRjl3eFhDWnBXelR6RnZ4aUVaUW5VcHM2b1hNU0svNThI?=
 =?utf-8?B?OGczUnhESE5oLytUbUhOVSt3WXVMK3BtVmhxTTdQYVIwRHJQVmVUdVBaY2VH?=
 =?utf-8?B?aFpoSXFRNGN2NlNhMllWWFJpQTdaanNBQnZ6bzZlZDJkUDZMV00vK2xRMlhJ?=
 =?utf-8?B?L3BET2hQd3U1M0F6bzFoN1BVY3dNWjBSZ3BiS2RHN2R6SFNES2dGeGxGam1D?=
 =?utf-8?B?bEtFYXdJZTUvcXNwREErQ2JHa09MR1VibC9OQm1ZL0YyUDJFY0QyR3J4dGow?=
 =?utf-8?Q?8LFNEZoEXaKA65lM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752cc8dc-79b8-4f4b-9146-08dec7b09f41
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:57:33.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D+v3ERSP29IL8raxw4wh5CefGHefyg69lY0LSZHKAiZ+sUyz5qWKfeAFk02RO2eyKKcXXNRrT50mgjGhbdlenwIPX5Q19r84GcPP7SbziQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7824-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:conor.dooley@microchip.com,m:haibo.chen@nxp.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com,microchip.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5967B67192F

On 6/10/2026 9:37 AM, Krzysztof Kozlowski wrote:
> On Tue, Jun 09, 2026 at 04:29:50PM +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add NXP S32N79 SoC compatible string and interrupt properties.
>>
>> On S32N79, FlexCAN IP is integrated with two interrupt lines:
>> one for the mailbox interrupts (0-127) and one for signaling
>> bus errors and device state changes.
>>
>> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> 
> You cannot test a binding (in a meaning what "testing" means). Building
> code is not testing.
> 
>> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
> 
> Not possible.
> 
> Best regards,
> Krzysztof
> 

Hello Krzysztof,

Yes, my bad. It makes total sense.

I presume I shouldn't send a new version just for this 'Tested-by' 
removal - right ?

Best Regards,
Ciprian

