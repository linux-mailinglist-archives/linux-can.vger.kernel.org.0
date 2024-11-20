Return-Path: <linux-can+bounces-2134-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC1A9D3868
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D171F23D8E
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A10819ABA3;
	Wed, 20 Nov 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eFdCgoxL"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07B15DBBA;
	Wed, 20 Nov 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098844; cv=fail; b=qJwS4vtCL2t6X3R0nu8mfpdi2x149+clnDRPDWISKeRd/uc8afIZGTD1niRK7FHSum9L08/pgLWqIQUcRaW1fUaK84HEeC3ZkUz+dO2LwSe++/aoGQ+9B9c1ha93D0kBBZMhSFyTGJxngw7zKByZxv9mhasUb+hqy/drz8Uf1r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098844; c=relaxed/simple;
	bh=Ql3M3AVFWzxbRaYHYNpb0EAyogZf0BF8WVdYU9gQg/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QcRpkPetxAxiCvvzwu9FkVvYRTDk9oDDoPg25Irj3n6PXcTCga1TeoWRP5FHqOnf4Kqk+55Dq18tnRVMbqrkN1lOxNDcH/dyOvYKYxPO0qzL8zxCC24Ff4BNncLQLg1wjcgQr9F8run7EJgB3jgCikfGGIOe9CjWTsA/U+6NU2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eFdCgoxL; arc=fail smtp.client-ip=40.107.247.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ampxUIE9VrrMt0kymqj/32yko3bbSneNAeapP6TMyyHeapT32uEBtJp4KaCJIIjL71DJJUcJscQsV0I9llis7SJsmhkVFZWtgfI+ZRB/rmfdNmDmmpg/ihOceyiGYIm1FVfWL7KNZyGDYeslBkl0XYGeTQoAFdjJ184/D8EXy4q9Ti8TCLbFUuhKroY2Uli1SfE2Htpr3o+CnTtEUZcWVmcm/8+b69+XKIEMZwjFpYT7NLYpJQAhpIA4jnXrnRd+91Ky1QZcIdQSobMtni+F4PLJ5fTn+JU32YVvX019Sj7a/lzTnMn0SZmzKtGB4qTebajWO8gRw5mTQcLLzLO8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poT3lKannfSvxP4smZWHKcftUSvBuTMJltOxKtBDUUM=;
 b=c1Y6IBAj1jpiVOZXEGpv8CP3orezTP0gHgK8qvsheOwRz8w7pCcpBoKkMxf4Z9N0M5e8wDeErEgcpK0ns5gzoNf5DHLSp/zalF0qvrfRY3DByPKxj2YNWKbQTVU0D21/B0CVcWaDzYo4weKB8cCtpZKBwJHRUDbTN4wiG+LP6yjeLq1P5keJsk8aYbgnFKnVUHMB1T2Hg4BBg+hQR1fMLZ83EGAoGEW8dlm/8q8eFykl3yAHaHI8mllooNlIH0GmA5qMFg8AbynvvODYdjS1FXQvAkOrfgvp9hVFgSrefmPBRH+z92Nyq6A5+X0eG6wOWARKnVl4va7AgTzBH+8H/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poT3lKannfSvxP4smZWHKcftUSvBuTMJltOxKtBDUUM=;
 b=eFdCgoxLpjw+RGM4LZ585wWCBDVIHewyyZSxvqJyOv0aGfZNsc7JxtMKdjV60oFxd9oIUVGrHILVTAgK4EphG1xL+JBBzbVPcvWIpYNKcSviHm0CJaHvWFhn3AHxe+ZNtfIZBd2mFIgTFfozFqwbLKNDSJhmECQy3yyjkP97t1X0QiOuqOm29yZSBIMB6YL6MR603ILIAeIG/SAvKiQKLsbI+bNdDf2fCN71OLeRs4hs97jcpZkxAysCMkH43eQLU0dkYOmQaVKvynSkL4XkDdKJZsG/iiRNRyZbC7B2z5zeNmwAoHwdL0ZZyFxmOo+O5eeiBF6EgK5nlpCyWuwgqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:33:56 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 10:33:56 +0000
Message-ID: <cc38915f-bd91-413c-93fc-4f1a5f3b1541@oss.nxp.com>
Date: Wed, 20 Nov 2024 12:33:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
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
 <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
 <o4uiphg4lcmdmvibiheyvqa4zmp3kijn7u3qo5c5mofemqaii7@fdn3h2hspks7>
 <5527f0e2-1986-4eb5-b16a-86276db0cbb5@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <5527f0e2-1986-4eb5-b16a-86276db0cbb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0159.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::28) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 906ca8d8-e6dd-463c-0d27-08dd094ed648
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlNRR1hWeHQvOEI5V21DUDQwQk42M2VnLzJZVzRURFFHUXpZMm1ZVnVWMnZz?=
 =?utf-8?B?eEtPMVUxRElKZmFyZE0vdGRCY1dHWVI2K0lySFJZaWdsR2MrRlJMVG9aWHFJ?=
 =?utf-8?B?MGxEQTFVZXJVRTNrb1BYbGJ0TWlPbm1SalpuRE51a1Bya1J3Q3VKd2wxaTAv?=
 =?utf-8?B?bklMN2tjemVaQUsvbENhbmp1WWozQ29RSkx6dnozUjBnSVVlNENtUWR4SzRV?=
 =?utf-8?B?S0FoRFJTeDNRZ1lBcFN0SjkzRkdDanhIdDdCYlY3MExIOUFsWGNyQmRIVFJo?=
 =?utf-8?B?ejAwWkt0QnEwdGhNaEIxQUtPTEl2NXdEUXhRL0x6QXJIdHdCdDFkQS82ajAx?=
 =?utf-8?B?MVpUeXV3WXpIc1RXR2hBMTB4b0s1ZEgxc0tmQkVBTmhOV29rSDd5Vm5yZkI0?=
 =?utf-8?B?OGY0dkhMNU9vZU9zbTZjaFNrc08rMGpOTUMxR3VYVCt6NXRFblJXVnBUbTJR?=
 =?utf-8?B?QnFUdGNHTzdySlJxVVZEbWM0QmgzeVNtakRVK21BVittZVdyR2srVlZzanJU?=
 =?utf-8?B?OWxNb2hEd0J4QVN1SVlPSllyYUZVVnpTbG43UityT2tKWm5FLzIvbTRMVDVr?=
 =?utf-8?B?OHQvMjRsUndHSThORUlZZGpIU1lhUmp1eHRFTTBibTVWZGN5QzV2YkNoUVVi?=
 =?utf-8?B?c0E1MG9lZ3crWjRqWnVGSnNzVDJSUkdDTmNRbmNJSVZEVmRhTGl4MEowTUZu?=
 =?utf-8?B?RTgreGhXaGxaTU9UNG44UTVTWkJFaXlFUmdWVXpSMlY0MmRndmJJTGl4eWpZ?=
 =?utf-8?B?dWVRaVgwYlhTVWFBOWlFdDFHNmw4L2p1UklKZDlEWDh3SWxTdHpobkVrMHB0?=
 =?utf-8?B?V2g5Z3FoZUN1T21aaEZ6dENCTFpERjNrVkhQT29XK2lDNk9jM1JaYmgwU3BH?=
 =?utf-8?B?dUZFYlVBenl2dXJaVmZTcEloNGhpNXlYdE5qckRZK0ZxbDdkYU1HSXZpZm8x?=
 =?utf-8?B?Uk1YRGNWTGVaVGNsVmM3ajdkc09leVpER0dxQW5VL2ViSG9sRTM1bWxTQXMx?=
 =?utf-8?B?TWlVTmRqNlE5aFlCclMrYWg0MS8zNTQ3WEZZRlc5TEkzd1JQSDhCbHBsL25X?=
 =?utf-8?B?RUFzQkFYc3cyQzNCSWhmSkVGSEdPTEltRzdmZTh4Skt5NkIyU3pSNkgrL3Bs?=
 =?utf-8?B?cUR3WXVmQUdCb3dZcThwRGJEQno0eE1sM1lIc2ZxZUNnVjNCeVZvNDFuWENv?=
 =?utf-8?B?U0NOeFBNYks1MHlHdkNkdVpKbXlVVFkwZDNQZWd0aVNHdzJaNjVFOXoxZE9a?=
 =?utf-8?B?SmhZUmlMMnZUZlBESUxDNjEzSkZYUnFKc3hDanAvcStmYWs1ZFBIeVB6Ui9i?=
 =?utf-8?B?cjMrSzJVYWROODVhb2o4OXBjcUxvd1RGUGQ0aXM5ZGNYL0I0Z1N2Mkh3c2dy?=
 =?utf-8?B?dXdEYk4wNHRiVEdGeFJKV054c2RveXIyekhTSVhTcDBJVSs4aFBhTDdpdVJF?=
 =?utf-8?B?NHdQc0JUV1FCNVF1RURqSk53R01xT090N05CL1RpS2hBcmsrVEVDM1hna2lW?=
 =?utf-8?B?N0sxZ3FHOHJPd0lLS0tNZE5YeTR5MzF1N2FZT0JIM1FGODFGekp6OWt1N3kv?=
 =?utf-8?B?eDkzNEJJbE8wdWdsNWxRYTdFVGpJQndtQmErbDhqeTgxVUI5UWZoRldtTTdY?=
 =?utf-8?B?N0M5U2FBcFl6MDZJcmZyRmlSWDdERkk2dEhlQ3dabGdld0VEd0tGUWwvMGJu?=
 =?utf-8?B?eEUvRSsvRWlGR1BvYm5wL0lQYmFMSVJGdHRGaDl5V2dzZHJaeW42T3lEYW5Y?=
 =?utf-8?Q?SrAkZUssP9W/JsnLKbJauwD+za0ikvjUqLoOdXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhZVGhmcCtrTFc4WkVneVJqOHVaUHVuZ0trN25SNmRVVXJFRTRTSTJZUGpa?=
 =?utf-8?B?RlRHSkpTaVlSZkZkQUZiR2pld0RhQW5DWWt4RU1NdlB4eFBqS2tINHlxQWdp?=
 =?utf-8?B?d1pHaGlNOWJwOUgvMjYyL3IyUzE3V1RRY0hQMy9RSXIrOU42NkJ5bHhtV3BL?=
 =?utf-8?B?dHZ6TkYycHg3WStNb1JtRElUb3RwZ2JEdCtDM0p6NGhTZFYyd1JpcWlsei81?=
 =?utf-8?B?TTQvZG9Oa3Vob3A4enpCQ1p4OVlZeXhPeXJLUWRTOUVuaGhKMUlIbjQ5RVpl?=
 =?utf-8?B?eGFtb3czUXZlUGEreDFaWnYrM3F5bFhNRTFaOEJ1QVJZVjVSeG1mRWZNZUh0?=
 =?utf-8?B?Y3pKUVIzSm5Od2lIdGpMZTVGbHdVRWV4TFluWU9MZ1c0KzluSGhtMFZpS0VN?=
 =?utf-8?B?MnFVajBBUFo4Q3dpY081Nmw4bmV3U0RDZ2ZIL3hZbS9XUGtBZmdKMDRGc1A0?=
 =?utf-8?B?RGtRRkJkckZwbjY2bXMxRXJnazF4Y3pTMGhHZCtud3Z1cWE3djlvdTRyZWor?=
 =?utf-8?B?Vm1oVnAyWkRJQUl4elpyK3hLNzErWUVhelFtUHpsYzRKUDhlWnRpSU8zb0M3?=
 =?utf-8?B?clNCUlYyR1AvOGp1dlpYbzlWeWR0MTQ3ellWdnlGaEZzMTByRmF0SEh1SEx0?=
 =?utf-8?B?NGw4VFp2NkRrZGNsVG1xbG9Qa3A5UktWZ3VicmkxMmJIa3NqMWJTdFh1YVly?=
 =?utf-8?B?VTZXcnJHaEx3Q1pvRlBaUXk0SDN2eFQyL0JwdmdUUjV0TDlrNjNnOUxBRUpG?=
 =?utf-8?B?NndUclBnY1pEdSt2NkZTVkxhYlNQRkI1b3IzVVc3cFJnQU9aaUJ5clpLZ2tY?=
 =?utf-8?B?UlJ2Ulp6SkVkQlZxbGJtdkNWdDRxZS9Palp5Sm1vOGx3TmpvVFU4NVp2bkpL?=
 =?utf-8?B?bzZsVm1EaXJjRGphVmd0R1lqN0xuVXRObkpieFUvcWRGcmhSSlBMZlRCSlYr?=
 =?utf-8?B?TWZZaHNMVVdJRG1OUWZHaE1pUEZnSmZsR3pvK1I1QlRCcWZGdFBoeHloQVZt?=
 =?utf-8?B?WVYxMkd2OHV0aGJZSXFvR2ZSUTdEZVZXWTFtK3B2RDUyR0c1N1AyTUR4Ulpi?=
 =?utf-8?B?Uldaajg5azBZd1V2R3ozMDcwOFBYdUNYTUp4eUFWMXdhTDNIdE8vWGNLWVEy?=
 =?utf-8?B?V1k0RXE5Q2FBVWNhbVVyV1BjTkFZRjZqdTBOd3VvQW1IVSthYTBFTVdNcm9D?=
 =?utf-8?B?cmI5N2hidG45WmNTL2U2Ky9iM3JLdlp2N2Q4Z1Z4MjRFS0tNa2M2bWxEdk00?=
 =?utf-8?B?c0xsTGRDZnFnK2xTVk5zTnBXUUVxZ0ZoMXQ1SGZucGljTFc2a2RkbEsreDM1?=
 =?utf-8?B?T2pQazJHK2M0a2NMMVZXL2VxT3JPc3g5ZmZTd2xmVGJybkdhcm9JV0tkdlN0?=
 =?utf-8?B?eFM3RUxUNGcvRWxGd3pjTDlENXhPQWVMV1h5eG0vdHQ0T0RocUFwY2thOVl1?=
 =?utf-8?B?NDBRcXJRQlQrTVZmazRsZ0FXSVFjRVlLUHhHc0REMkJ4QnRLOVFUNmFEbmNJ?=
 =?utf-8?B?S0o3aUFyNlRFenl6cWdYUmhET25DQzJ6M2RsR3hDNFZyN1FCbUZ0UEQrZDBY?=
 =?utf-8?B?bUpmbWtJeTRXbmVCMlBHVjVqblZQZW9PRDlDd2xDbkFKRFBSSFpNVVlkQm5R?=
 =?utf-8?B?Qkw4OU1wYjdPSjFDWjdZOThzeEJsTkpDMEZ2S2paaGVTN0xvcmxhVnV1QVRw?=
 =?utf-8?B?aDRhcE9zSVNsRWRsRm9LWUFGV0Z1Tmk1ejlXakpaOHNMdmV6dlFjMTJYNWI0?=
 =?utf-8?B?UDNhalVoWmY2WW9MUlJsRzBQendueVV6VEp4MXMwdE4wRTZFOW1UUlUyYXlR?=
 =?utf-8?B?enVvUU4wbFVya1N5SmVERUdZTFNhNXh2NFpaZEd3bGY1d0RqbzkrV29VWGJH?=
 =?utf-8?B?d2hpL0VlNzU2TFZmeVBrNzV0eE00T3BwVUk5N3dEamRTTUM2WENkajdNOGl1?=
 =?utf-8?B?RTlVUnRUTHNNVmJjdDZiRHVhRWNMQjFjVk9uUGhETkFpbm0wZ0YwNzdiV3hI?=
 =?utf-8?B?cVpuNUlObUt5MVlhYU1Gb2xmdGpMZzI5ci9oaDhlMWFURk5kdVlydFExR1lU?=
 =?utf-8?B?dzFHZlU2UWlnK0d1K1h4V2wyaVhJVHhFM2hwZmJ4L0s0Q1VjRXNxa0gvTGg5?=
 =?utf-8?B?NzFOb3QzVG5paEdBZTNLbnEzY3poZ3hhVVgwTmQyZ2xjTG85S0pyOHNBaWYw?=
 =?utf-8?Q?VIu2kfFPqnBxXHc7klP/e7Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ca8d8-e6dd-463c-0d27-08dd094ed648
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:33:56.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7crOnqoWWciD9slaQ9ymrvU3HimMuQZ7Xzqk37PUGfcXvm378fpwuHrualR9lZTtNmA5oLHElorr4YzDfuUZxD5++9pFETp7bEZK/Fp0Flw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8570

On 11/20/2024 11:12 AM, Krzysztof Kozlowski wrote:
> On 20/11/2024 09:45, Krzysztof Kozlowski wrote:
>> On Tue, Nov 19, 2024 at 10:10:51AM +0200, Ciprian Costea wrote:
>>>     reg:
>>>       maxItems: 1
>>> @@ -136,6 +138,23 @@ required:
>>>     - reg
>>>     - interrupts
>>>   
>>> +allOf:
>>> +  - $ref: can-controller.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: nxp,s32g2-flexcan
>>> +    then:
>>> +      properties:
>>> +        interrupts:
>>> +          minItems: 4
>>> +          maxItems: 4
>>
>> Top level says max is 1. You need to keep there widest constraints.
> And list items here instead...
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Just to confirm before making any changes:
Are you referring to directly change 'maxItems' to value 4 ? Instead of 
using this 'if' condition under 'allOf' ?

Best Regards,
Ciprian

