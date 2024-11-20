Return-Path: <linux-can+bounces-2144-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942289D3C9C
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627D71F22818
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571141A302E;
	Wed, 20 Nov 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sZ2ec084"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6915AD9C;
	Wed, 20 Nov 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109921; cv=fail; b=sjsHrJm9TUAsk/yUfCO4sPAmU2zGG/RlbCd8LFcoSQVZ+q/lzLGzq4kqkYKwm1m+OaELVfTRxYuns6GC8t/IFervZmUQDLdzInFGglpK/vqlcMzh5n/R9JpOjA8yZ2OCHF4qPcZWp4cJWiQYdRJySWQF9Z11RBQPC9LCvRmM5+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109921; c=relaxed/simple;
	bh=74PcBklJgoCnXUJ63cd0jNarYam6clg4vZH75tW8zbk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dls4v0UnieeZJVoQDYPb4aT0q57u45EteSm3Ds/cI+dLjIe7enOlIZU4oasxPcy4s+QW3Rye6L1cauVR3i+f/Qo2SyC+n7X3Acb4t6d1FMRvkqGcLJD+HBdcSy90i3q0j4Dy2A0lSYBXunkYolH5JLZ1bkKBEesVBRSv7I1O6NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sZ2ec084; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxOwH6HrNf37UXzyq0yIH1ppggK4k18OSaEQ5UjHvZiy9jDMGc1tR16OAFzC14XmypbbCAE0uLfyAwxbI7YEmr1Y27ZpFWtDYwBfwUC3OTCnywsBUdeo1KM5WB4qcxKxhMyNIbK4pbflmodm4HraS+PLKb0NhfeK8qyk55QuNUFyvNM6YxozLQ2ogt6oVZRByyQSNYQnHKHuWAq5tCps5Kxq8KNvViMsT8NDSknv6PPqi0zVhR2Qe0xfvsyBNX7MgpFOEGUdjVGMyYJkPmWiXWyJOaTMRPaPooDkM8zZ8vG8PCCets+7rjcE3J1+CYL2+1d4iu5YBozIADD0W8xc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDa7gII7deudzmas0UIWJYV83/ceCTyIGQk+yN/O3I4=;
 b=eKG9uzKTkmF+yusM0drearxtCvFeDL4i8bhs5Aq/I2maWpM0F5Mg9pkw4ScRaqT2FF0Udzzd3RlVRUSVfKj0NuU7IY7UqUyMEk7F3egHyWQysvoJLTIIc81Puh3dpe4zIOU3YW94sRLgMLuUeAu1ZtQwPCd1U2Jm99yXBt6gbqVDnt0oUIVEvDuUg7j2H9zUpKuLFbbMMiN7v5jULUlcomqVyhDtWc0NKkyhfv/656evXJnddcA1dZtop7xmK6OgmrjoZ5N3Y7d+MsCzIihFixw5jzJ6yqPEUvYKGrEhbhCKDcOEE0k2k8vrUljESF0XrjRh2UNV3aUMVROot0ShHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDa7gII7deudzmas0UIWJYV83/ceCTyIGQk+yN/O3I4=;
 b=sZ2ec084egEoTHA/a7Luf19oMOSK4rkz2H91nSwBk93clPGIhDSwujv7QNYqHyFvVU8+4rtVkKlRWmjq521NX7iv3O9RhHlpte2KPJEOsVixGgbJrMf/Orc4pecXqC+lRFBo3aWxI3yYtoavSdx7MxTUn+YMkirsvM5dCvCkBFW+fnlw2RvZ4kA73Xa08czp37ZZBSpqYV25WLRXM98s69RUr9ZqHUmJirdsoFO75GM1/ZbmnUPu3exgkElH+8gpXDVXxFjWiorOsEEJDiAAIr/Hil31UHnO2Cw+38ozsnN/GKkcfBu5XMPjdeWMFbUxeC9zOIHeHY/sY80bRTO1Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:38:34 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 13:38:33 +0000
Message-ID: <2508b28c-0de6-4858-9ddc-5babcbb322ca@oss.nxp.com>
Date: Wed, 20 Nov 2024 15:38:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 NXP Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <20241120-mindful-belligerent-mussel-501d72-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-mindful-belligerent-mussel-501d72-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c471a07-edf8-4bd8-f8c8-08dd0968a0dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVorUFRNa3E1Qkx1MytNYWUwSTFRZlFMTUtJNXl2Z2w1NUlNQndoK0l3cElk?=
 =?utf-8?B?SlBBOEZ4d3RaWGJMMVE4Vm1CV2FwUG5aTVpFckJOQVR6WmpjTjcydXIwdE1l?=
 =?utf-8?B?ZS9ta2lVU2tWbVR4c3U1WHloa09GUko2OGdxbTRCMjFIakZtajlOTkUwZFpZ?=
 =?utf-8?B?Y1FPdy9oV2VnOGU2L2lsQ0VuRVV1VXhyMnRrSlRVQUNzMTI5b2NCSFg3L2FB?=
 =?utf-8?B?SCt4dCt2Z2RmWHVDOEk1WUp5cDhqeDdQa09aUUlQdzBwQlVtb25GL0E1SVk5?=
 =?utf-8?B?WE1hZzZtaGhLQjF0U1RWcG5yandVbzl5RFJjMnlreWVHZmNRZ3g3UUNocUp2?=
 =?utf-8?B?WEpUbUx6eStRNUEvazMrM3JhTVY0UzlpK1RKZmNVS2dMa0FHZS9JZ1pneFNk?=
 =?utf-8?B?bnAwRlZaTjJBZmhvamE3MWtFdWdFYXV2eSs0ZGw3RVFEVG0xVFpaOEl0LzFv?=
 =?utf-8?B?M1MyWlZoa2VGeUcwYzRva2ZiekR3dDdEU3ZUM01pVy9sUzRCR3RBTitEUk8y?=
 =?utf-8?B?NzR0ZGo4TVBHWWVaYjFSZTVhS3lpZ2hCQVZMVlIyV21nMUxFT3FwdVhnblRV?=
 =?utf-8?B?Zkk0VWdxK0tSN2FsdVd2dVZOZnRjQTdUWm1kcDA1RWsrbjNKV3I2S251ODRZ?=
 =?utf-8?B?eXVubisrNmk5TVd1SFNqK0Q5bkt2RHNGWVh3T0ZHMjBpRzV2cTd0QVVKM2lx?=
 =?utf-8?B?TE1zdHJ4Q3lpcGVmUzNRTWdReHBTY3JIMldtSVQ5YWs3MGhGVytpTjVDNTZI?=
 =?utf-8?B?UHFmeFZMRjg1SU4xZFNDSTlacGZ2a3hVQVEwYVF4YUk0K2pkVitrOU9NdjRq?=
 =?utf-8?B?QllDL2xEdXJwMWVNZlRud3NFUUd2dWk5QlZvN0IvclpwZnNteDA3TEkzcFcr?=
 =?utf-8?B?NmQ3L0R5a2xmbVFodGRORldsdTJzSFJrTVJJR2FnbFN2eDFIMHU2MVNIZmRK?=
 =?utf-8?B?MW9IVWk4NG50SnBCbDJiNGdsOEpabHUwbzlVUWxUQkI2V01zMU1DaFRCL04v?=
 =?utf-8?B?ckdrVXVrU2p5UjE3NktKQ2k1bm81NjJzOVhQRTgwWGJXMUdRbzVLUXh4anpw?=
 =?utf-8?B?NnVHa1Mwd1FYUlN2TjBKS3ZjT3hveHhMV0R6VUJSalVzU2Z6NEd4L1F0OXdl?=
 =?utf-8?B?b1d4OENjYUFocXpzOUc3dW5FdjVDaURPVjF1M2hDSDJWLzdwOFZsR1d1Rldq?=
 =?utf-8?B?WkE1S0lpUHArZ1I4L0JjcHNSeEIrS3N0V2JsN0VpaVYrNHd2NWZLaDZObi94?=
 =?utf-8?B?Z0hzeU16Vi9SbTV1OFVUb3d5bndGOUJQdlhlQ3VpTnZjZ0VoNzJ5WTlFRldp?=
 =?utf-8?B?SVpydE5CZ283YzFHVFZhWkwvT0JzU0ZMMHFjT1VOQnQ5R2JsSjgzZUNwenBu?=
 =?utf-8?B?MGV2bEdxWlBEOFI4NUQzaGk0ZjErVGExeU5kNDllZWlSeE9jcUR2K0ljYkxx?=
 =?utf-8?B?MTF1blNOUUFqTzNEaHh1OEEwUGw5Kyt1V2FsejdyR1Yra2FmNXFlYnZTSFJS?=
 =?utf-8?B?QkFja0tTbFJpUzZYcmRJZ05YMnQwRnZlWThFcUFGS2lCMTZHcGZZMFRidDFG?=
 =?utf-8?B?czRkRy9nMXJmMEF1Z2JLN0IxTjRkWVpuNFNka2ttbThHSStEYVdyY08vZlYw?=
 =?utf-8?B?Vk5XTmF0cEdxQUFZeStPdW9HYWxFVG9sSE1VNWU1eGJrK0d5OVovMUpRNE01?=
 =?utf-8?B?TEc1Snk4M0pjTEdwaVVlaHd0UHhSK3R6RVBOVDY3Q2doZkhjTEFKVFZEbEpv?=
 =?utf-8?Q?wgmZIkQEoAkAtia/ipqOHqqorhxaCy4K7PrvXZV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UExUT0pGRG53K2tvNUp0NlZzOVRRUXdYelVueVE2Q3VKNk5XczJKZXRUUnBy?=
 =?utf-8?B?S0VTZGlSNUhoV3pqTkJZa0NJU0lqMnM2anpaSDZlV1RnRzQvUXlKVHFsK0FC?=
 =?utf-8?B?SGdXL2trdFJrU0Q0ZEMwOGFMZ1hYUnZhRHZjeDExNklwNTQvUUhTZ0dyTWhK?=
 =?utf-8?B?dkdPcytuUkQzeUZCc01tRnFnZEN5YnBWYjkxR2doL0F4aXk1MWpLbzFYUXds?=
 =?utf-8?B?elVRYVVwNmtOdmdWWDFJZEM0Q1l2Znh4bFBGY3BVODFKWXM4YStMY0gyWk1l?=
 =?utf-8?B?YTFzNmc1ZTg4QWh3V2NEb1ZISzFkNlNPRDVVQXdWVEtGcjB0aEFJeURmVTBU?=
 =?utf-8?B?TE9OVkRNUHpFbTdRazhyaTltSGZ4QVZ0L0FiQml0NXpwVHRLZXIzYWQ2K3VB?=
 =?utf-8?B?OGxBKzh2Z3FCME03TWREWWhqM1lMVm05bEpram1ZRU01Wm9FTDBEVGl0WDRa?=
 =?utf-8?B?VktNYTRUUUt3eEhYc0R1dDNHcVhxbnlOZ09DWG8rMDBiNCt3Ry82Y2RDcnFw?=
 =?utf-8?B?a2xYcDQ3bU5pYzN3blBCMVlQVk5QSWEyZ3dlNndUemxORDRYUEsrNEZPZ0pj?=
 =?utf-8?B?em0zQm9XYWRpUy8wMnNIVEdodm9jM1BDak9Ydm1KNExKcGxKeEJlRERNMEc3?=
 =?utf-8?B?WXdvOHh5dVQ0SXRkUWRLQzFZS1F6bW43cSszcmNQcjJsQXdYN29FRXJESUhO?=
 =?utf-8?B?RkNsYXhTKzZjUEplY3ZhTEtrZ0NyNEFDcmlvQ294dm9PNmtpV3MvUWNHODVR?=
 =?utf-8?B?VDVrQVNueVMwTy9ZUDBNNFljUVpZU2g5UEN3RmdMTnRTcW10cnRpY0QvcHZv?=
 =?utf-8?B?RTNmTmpwM1hUODBpN1NVNDB2OEU0dW0vbEJzdnh2VVo5cENqb2srckxFYXRM?=
 =?utf-8?B?SXdBWUFDNE8vK0N1R01yL3poaEZLblhobml6ak1aM2VVZDNCRWpGcTErYzlS?=
 =?utf-8?B?VEZyMTFvVGRuWGRSL0xhUXZsaHNFY1VwQllFcURZeTVwYXdOQ2NCNWNuaXEw?=
 =?utf-8?B?VmJtSWRFUUZlbHdkNEFJNEJDTWxZeG0yK2l2cllGTnFPeTAweEhwVFRhaXBH?=
 =?utf-8?B?S3NBelpMMkdreFgzNTF1MndJRDk2Y3VEQnpONnFEOUxQNUdGT254Y09jUis5?=
 =?utf-8?B?ekQ3SWxHaTBpMUF0bldPcDFMSEdKWDh3T1k3dUlDUXFRVnF5OFZiajJGVE55?=
 =?utf-8?B?T2N3bFhFRlZBNE93QWhwcE9FZEJ5VzJPUW0xS0k4SE1BZks4aFkyY1hwVkNV?=
 =?utf-8?B?NnJta0hRTnJQS2pqNHowczlDS2pvWm9ZQXFkRWxsL0RoT3l0ODFTT2JDWUs5?=
 =?utf-8?B?U05jOGhaYTRsaCtyWTRqeWp2aVhSWXpPdW5wdVNkRlpLQTRyY2syKy9LRGIw?=
 =?utf-8?B?SXdzMS9DYkRXWHE4NGVLdWFrSVdYcndUS0w0U2NXbS9ncGlkTktnZ0ZVaENn?=
 =?utf-8?B?QWphaC9id0psRW5mR3dvSkhzU2lNWkNta0JMNEhUWk1kc2NyOEgzNXN6NXpi?=
 =?utf-8?B?VTFoWVpLS0dERWo0TEFZWDVWQXNVVklrZy9xNUd5UzZmeURRblM3OGxLZkh3?=
 =?utf-8?B?RmlkY2JyTGF1QkxyYjdwL0J4OHNTVFUxU3ZGM0VXNSsxRnh0V21Bc1kxZVhH?=
 =?utf-8?B?NkhHbVRLcG9say9IL2RHbTFxcVJvZ1dldmFTM1F4RE5jVnBGT3BOSzYvOVln?=
 =?utf-8?B?TXdBR29hSlFVUVRsVGlCSUlWWjdzNnFZNDlmVVA2M3hiZjZHM3ZkcjdMbWd1?=
 =?utf-8?B?cXFNT3ZKMWkrQ1VCZmVNUXNYQXFKbnE2QWhVY2t2ekpLMTVwZVprMWhXNDd5?=
 =?utf-8?B?RFFFdWdFczE2VlJpeDlvWXVsRVZKRDg1by92Nk9FMGtudTZsakdkZnk1OGVr?=
 =?utf-8?B?VUFEQkQrSGI1SDN2WUtGcElrNnFtMm5xdUxSRjFzZktWcVdISGFQUjhoR3My?=
 =?utf-8?B?QXhvUCtOa0x0WDBqRUhCYlNXNW9LTmFyektIVnl4RXdHRllzNUFvbVhCYmFh?=
 =?utf-8?B?ZHRybWl1TWU4ai9TYndobmNjV3U5MEVvalZzdm1RRGdFamdQbVhvMnFSNzFG?=
 =?utf-8?B?M1pPOGxKcGhwTmQ1ZUhQNGtNSUFVMjM3dVdHSDM1MGpNRXFwNzd0aTV0THhX?=
 =?utf-8?B?Rm5LUGIzZ3RmVXJ5aytjZDBUUUJYMnI3VGZTTEhUaXIzamhsY3RqWVhDdTli?=
 =?utf-8?Q?vJ6TGibCk/a87hjuy6UG6Ks=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c471a07-edf8-4bd8-f8c8-08dd0968a0dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:38:33.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78J7wjPwAZ16SRTd62AnaENyE21XNGE0RjhRZlGkFk8NXc7EgklrK0+2ShdpF95W9dVKgp07EH/fJQahh4edfWSRB4lnN8cWZFibz2GFm98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

On 11/20/2024 2:20 PM, Marc Kleine-Budde wrote:
> On 19.11.2024 10:10:53, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> On S32G2/S32G3 SoC, there are separate interrupts
>> for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>
>> In order to handle this FlexCAN hardware particularity, reuse
>> the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
>> handling support.
>>
>> Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
>> which can be used in case there are two separate mailbox ranges
>> controlled by independent hardware interrupt lines, as it is
>> the case on S32G2/S32G3 SoC.
> 
> Please move the quirk and quirk handling to the 2nd patch. The 3rd patch
> should only add the nxp,s32g2-flexcan compatible and the struct
> flexcan_devtype_data nxp_s32g2_devtype_data.
> 

I will refactor accordingly in V2.

>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++++++--
>>   drivers/net/can/flexcan/flexcan.h      |  3 +++
>>   2 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index f0dee04800d3..dc56d4a7d30b 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>> @@ -390,9 +390,10 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
>>   	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>>   		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>>   		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
>> -		FLEXCAN_QUIRK_SUPPORT_ECC |
>> +		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
>>   		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
>> -		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
>> +		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
>>   };
>>   
>>   static const struct can_bittiming_const flexcan_bittiming_const = {
>> @@ -1771,12 +1772,21 @@ static int flexcan_open(struct net_device *dev)
>>   			goto out_free_irq_boff;
>>   	}
>>   
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>> +		err = request_irq(priv->irq_secondary_mb,
>> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>> +		if (err)
>> +			goto out_free_irq_err;
>> +	}
>> +
>>   	flexcan_chip_interrupts_enable(dev);
>>   
>>   	netif_start_queue(dev);
>>   
>>   	return 0;
>>   
>> + out_free_irq_err:
>> +	free_irq(priv->irq_err, dev);
>>    out_free_irq_boff:
>>   	free_irq(priv->irq_boff, dev);
>>    out_free_irq:
>> @@ -1808,6 +1818,9 @@ static int flexcan_close(struct net_device *dev)
>>   		free_irq(priv->irq_boff, dev);
>>   	}
>>   
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>> +		free_irq(priv->irq_secondary_mb, dev);
>> +
>>   	free_irq(dev->irq, dev);
>>   	can_rx_offload_disable(&priv->offload);
>>   	flexcan_chip_stop_disable_on_error(dev);
>> @@ -2197,6 +2210,14 @@ static int flexcan_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>> +		priv->irq_secondary_mb = platform_get_irq(pdev, 3);
>> +		if (priv->irq_secondary_mb < 0) {
>> +			err = priv->irq_secondary_mb;
>> +			goto failed_platform_get_irq;
>> +		}
>> +	}
>> +
>>   	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>>   		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
>>   			CAN_CTRLMODE_FD_NON_ISO;
>> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
>> index 4933d8c7439e..d4b1a954c538 100644
>> --- a/drivers/net/can/flexcan/flexcan.h
>> +++ b/drivers/net/can/flexcan/flexcan.h
>> @@ -70,6 +70,8 @@
>>   #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
>>   /* Setup stop mode with ATF SCMI protocol to support wakeup */
>>   #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
>> +/* Setup secondary mailbox interrupt */
> 
> Describe why this quirk is needed. If you have a proper description in
> the commit message, you can copy it here.
> 

I will add more motivation in the associated comment in V2.

>> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>>   
>>   struct flexcan_devtype_data {
>>   	u32 quirks;		/* quirks needed for different IP cores */
>> @@ -105,6 +107,7 @@ struct flexcan_priv {
>>   	struct regulator *reg_xceiver;
>>   	struct flexcan_stop_mode stm;
>>   
>> +	int irq_secondary_mb;
> 
> Please place it after the irq_err, this way it's in order with the
> spread sheet.
> 

Will refactor.


Best Regards,
Ciprian

>>   	int irq_boff;
>>   	int irq_err;
>>   
> 
> regards,
> Marc
> 


