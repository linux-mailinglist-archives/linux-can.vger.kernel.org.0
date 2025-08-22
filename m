Return-Path: <linux-can+bounces-4297-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF9B31020
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084A7A26BE1
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63982E7657;
	Fri, 22 Aug 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="TK99uUBn"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020083.outbound.protection.outlook.com [52.101.69.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B8222587;
	Fri, 22 Aug 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847240; cv=fail; b=C9woG1MHph3v3tE5H8MDVHA3nQ+nZrbx9M8N1AfwM4muqW44w0sdlgBc4+XsrqMgq0njY7i+f70etclNuiLbRwBnEOakLGN8F0MIGpCmsZjE9QBUNtJVDn/+OouMnAbgoBWeOjTd2vb4ehYFD9ZCG5F+pDywNd6aG2eMjXf3UE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847240; c=relaxed/simple;
	bh=hybGg7ny/AttpQR21pMOougqZZWDO3FHScKrafL+50U=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNHaceBp8eFXmU3Z0Dvgax4fN+WVa0Vv3k+M/Y9tKpjVMJretdrz7cl1RFUtEE9IQ303t/4bcU9O6dtRpY9PwV7zY9Lcz6c87gE9jVa1Odw0//sRa6ZoqRTPnnwePsLrnHiFrKmo/sI4N8uu2A+NRi3nqGReIiFDnyw4nOBJpBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=TK99uUBn; arc=fail smtp.client-ip=52.101.69.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ95fYHouZBjmO9OjM0/4uSQRDnP3SSa1+Msx6KPn/4SmiFph6j7NPJI5xMLjbXU/fqJ5l4f/muJGEmJqogeOiEVVpwpc893fUbVVhs45rZPhYuDiEsAoyGG5JkFrFnpgyFsWm8gVqlZ0ltmqwMoc3xat9N6d7QV5H3IMdQ5bm1tJFYJUnXG9jcO/sSVrSWJHUJWjSUhALg2ywR0irS/Zs1fUkLVW6SmU9DM2eHOi5uCohrTXsHTF7F7meb5TnSW3q1TrZJnHscO5qRgTTRCpnjfxbeWrJitrcIRcAyDPJv/kgf5lyjZoqK2tjWXud4Mb13V+H+hNDOMUIqk3Ad45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Net4eQGFTm6sEQqm8d+uAyU+zNclpFmp5VtOodm8dAE=;
 b=GGRfywa36dizAdGFhBqnclu88Hi6jwCTmolbJbJ6uzOu/R+gqRF4X9znNNzoikrIGRgy03LgEECRcJ96MDchcfGK+ysDP+fCr3m4Ys/Puytt8SAiUucuwP4Z0KyU9c/q1egfMAmEq787A7kH9BpCkpZg+kUZYLMEE3gsPvr/X7fKXojbCMq08h0ucTr3UezWx3cpRvgaGWZGSijAWtbctfBc4kYA/FB30XUUbuO/JxLiroy3K9HBrcrUlrZdwXMfjiWYQbJ4MaPV/cmPJK+tZi/b428SkA/5nddkvhk9qAqSUmMMKZWA7R5sLcxxEZETgOAf596D2wEGd04wuZLSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Net4eQGFTm6sEQqm8d+uAyU+zNclpFmp5VtOodm8dAE=;
 b=TK99uUBnJtPGvLrx7UKLmSnlzmp3PaYqoMPYrzGxiqCFlf/lJF62P7iViGkoWFTcFCCq8xQNYfk52Y2Zf2n9LlowroCL9/GywqYjt2sRi1PvqEZZjoYZONFgOQot1fNz0+5Pn9/JKZAqfSNgqJdkO7ox6wsk0vZjU3xEayi8JpWEja8WkCvot6rA9dhxrMnE04Tbgp90CvtOXvr0VEcEgflbLVdxi5UtTfIqxYlKAgmLn8y6LvtFMwNJ0tMsFfpthJWJWYUlfmdTyMcwuzYjD1vTXqU15hHQ9YTlqKHTQSyjfpMnepy6sLL3FRY4YRtV7wutcIabxyGroQ615p577w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 07:20:34 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:20:33 +0000
Message-ID: <060439dd-3df8-4d0b-8957-83b75dc13537@gocontroll.com>
Date: Fri, 22 Aug 2025 09:20:32 +0200
User-Agent: Mozilla Thunderbird
To: peng.fan@nxp.com
Cc: a-govindraju@ti.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 festevam@gmail.com, frank.li@nxp.com, haibo.chen@nxp.com,
 imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, mailhol.vincent@wanadoo.fr,
 mkl@pengutronix.de, robh@kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org, vkoul@kernel.org
References: <20250822-can-v1-2-c075f702adea@nxp.com>
Subject: Re: [PATCH 2/6] phy: phy-can-transceiver: Add support for NXP TJA1051
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20250822-can-v1-2-c075f702adea@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::19) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|DBBPR04MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b2a912-2e80-41e4-a1ad-08dde14c61bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aThRSlpPNkkvWitOWHZxcUVqNGZOM1pxSFVDalNzam9hVnAwT3M3REVQWVlD?=
 =?utf-8?B?T1FGNUJBVFF2b1prMFlpMFVSQ3JiaHhCVFVpU1BLNWV1S1NrVmR1bGxDbGxs?=
 =?utf-8?B?TDZySHJrS1BpTE03TmxGRkRJcVJLTHlKSEo5YVdLdGtDMXdKdnlMMVJFV2dz?=
 =?utf-8?B?eS8vQnMxVW5ZMHd3MTVaQzlIYUhFRFExUCtjM1R2YW85cnFNTm9waXRHdmRB?=
 =?utf-8?B?VkdrSDhFcVM3ZjRTaW5UVEFWVmp1ak1saExBaURqZXdFcEVaZzh0RE1GTmdv?=
 =?utf-8?B?US84cUJXUkhZbWlSVzRCNzZVVGNOa2lBZWZBVkR4cVdvVWQ2aVVYYnVJbWZU?=
 =?utf-8?B?RU1uMVFENVZIb1ZvUVAxN0FSRU1RS0pRMjUyK1VFUnV6VVFpM3NxTW9PRkVV?=
 =?utf-8?B?a0FtYVhGd1c3ejdTVXNSTkUyMEhKaEg2L2FCQWhibUFQRWtSdyt3QTh3bUlK?=
 =?utf-8?B?MFlEcEdZN2Zyenl2K3ZsUkF6RFdmZnpiYWgyaEhpaXJ1d0pTclRQc0ZUMWRE?=
 =?utf-8?B?aXp0czI5aFJvUjVCdktPRXVhUW5PWml2TWR6YVIzb0l4dThMcmdtR3ZSaElB?=
 =?utf-8?B?M01tTHg2eTg3czVRdGJtRE1YbHRmZEZGcW5TZzlhSTlrMDJubVpQSk9oeVUx?=
 =?utf-8?B?NHRMMk5xRm1ZQjhyU2Q0VmRzU29Qck5LbmdRR212WTYwMkpZb0wweS9PakYv?=
 =?utf-8?B?azF2dmRrK3A2dU5KK1dVUCtsM1JVYUFJNXdrTEtyd09lbkdjY0ZMWGtVSDNm?=
 =?utf-8?B?U2djMEVSYkdORlNXTGcrR084eVZ3VEluZU5FNDFHSEdnYURYK01wOGdmVkYv?=
 =?utf-8?B?VFlaZkNEWWN3b1dUWndGQXdNR0duWDF4dGlmd2JkaitUNHQ0RmJtME1hb3Bo?=
 =?utf-8?B?ZHIrVWQ4cEFWOC9BdjEyMGR2aTlKYWF2TXAzWW1lMGY4T0lvR2I1TUFsbkxp?=
 =?utf-8?B?NkVpRlMrSkNETkNzbi9lekpUZ3hOUkRmNVk5RUtteDNhU0lzajVLWnhQSUZk?=
 =?utf-8?B?UW9SRnRRclUvRVBzdk5vWDZGT0VYcXB4L1VHdis3TlA1UWR3WDV2cmUreXJD?=
 =?utf-8?B?NDBzZURmTWZSWElyY2QraWhaL29acU5mUUJpM2ppR1FmayszNUVQa1Z0NnFu?=
 =?utf-8?B?bDI0Zy9rYnBrY1B3Yjk1NGY3MGc4YUVpdDFrRXpsejQ3N0xYejlDaVhKQlVr?=
 =?utf-8?B?Zm5LUTM1cWY0ZjVIekxNVUNWU0FOSzB1UW13aDk2Q3dVZ1laMUpFcmlxUlE0?=
 =?utf-8?B?UmJMK2dPb2xya1lOdEROTmlzMXU4c2VXTUJkdTJ6cDZkWVZlQ0loWWM0NE9U?=
 =?utf-8?B?RmJudVVpb2I0YVJ3ZE5zQjgvZnRBWCtwRHpWVU5LdFBMYzY0U09kNkc2YkZW?=
 =?utf-8?B?RitZN29vdE5razBJZkExN3dxQkFWcllKUGY1RjI2SVpITHQ2Ynl0em1VbVdV?=
 =?utf-8?B?TW9NWjhYelZ3TTFudmROUlZia2pGWFRGM2l5NHM1RE94cEg4b1dZeC8rWXJI?=
 =?utf-8?B?RnphRTE0b3FuUEIwcXRNbXZONWNNUlZoMmZWUzN6Z01jOGZFVmorVjFSbmJN?=
 =?utf-8?B?Y2JWZmlNV1pHTGI5dWhlUkwya3NuZVNzdmFubGlEZlFCMWxnOS9KVml1Q0Zn?=
 =?utf-8?B?MzFMeTZCTHFiUUI1M2ZCRVFLS1FWMFdTcVU1MzBUVERiVW9tT0wrN01QVlNx?=
 =?utf-8?B?N0p6a2dWemRxYk9SNW5ybWgwRE15NEhCTFdOYXlXNTcxdkIvT2VxTUcyNzJj?=
 =?utf-8?B?UU53UExDN0pTVjVmMWE1M3JWL2E3MjR4YWl6UGhHbmRSOTJDOXdEVFB0aFZ4?=
 =?utf-8?B?RHpzMC8zd0h1UjFKWDZhVzJoY2ZnUC9FdHRjTWVqbFlxMUxEbXpuQnpZMGdZ?=
 =?utf-8?B?TmZmRVpOZ0JOczBIQlFrUzhydEZseDBkR3d4U0FZM0ZaY2pnOWY4d1JCcys0?=
 =?utf-8?Q?suovBwlKl30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFpick94WWNRaVBwN0NaUmwxOGRUU0pEQ29RdkE3R09ZUzlHYkF3Y2VKdk5X?=
 =?utf-8?B?bG40UnN6TC9jTng3ZzZwYkgzTjJGM2dzcURoZDhhb2tja0pYL0hwVlBoaXNN?=
 =?utf-8?B?MUVzVFA5dmlJWERkZWZPTnJERDJZaVBPekphandjaXB3SDVXcEg4STBFSERV?=
 =?utf-8?B?bW1CcERIbVpvazFidDZzWkg0MGh6NTMvdUZ6N0o5ZjdCN1pPWTNmWE5qS3VZ?=
 =?utf-8?B?czJWTVF1RlpHak5Jek1INW5lSzJWcVdFZXhOMkhLVWpLajVDR3lqQnNKem92?=
 =?utf-8?B?S2FQZ0NsekcxYWdaVHdkMkk5L0dIVDRyazhicVZHM3RNWkhMdDhKd0RKYUFR?=
 =?utf-8?B?T2xMMkZ0MU80eDlQRXRIcXlqcVVJQS9MRGlZdUJvYTBPcElDOFJjbEdpN2dk?=
 =?utf-8?B?d042KzB3N0x6aTM5L1pvY2dGanZUMkV4VUZCUWV3QnhuK0NtYW9ORVdLd0VK?=
 =?utf-8?B?K2xGZ2huT1lLd25wajBVRkwwZFpiUFhPQy9TOU9TVnkxUTRrVjB4TDBSeHNF?=
 =?utf-8?B?aXZycytuMmV6aTJtWnZCdmhQLy94dks1QzI2K1JvTlVIOWRFWTlYYTkxQVp6?=
 =?utf-8?B?ZDRPc0lxTWFjdldCcWZiUTk0Rkt4UGg2R1RGWWIxRk5ZZWdBTXoxZ1dvVnBB?=
 =?utf-8?B?aXRrNFREYmVtQVluQ21CTWNBOEpUZzJEOHlaUEZ0dzZhTk5UY3JOOGdUVkU0?=
 =?utf-8?B?T0ZQR24vUitlWnlmQWV6UjJWOXBBL01HbzFUY2Myc0xMbUlISDY0OEVDdnRo?=
 =?utf-8?B?RUZOV0VIVXpnbVRNaEMxamQ1cUJiWXJmMmliUEV1Z2cxQmErdFlRcjlqZDRU?=
 =?utf-8?B?STBNbjRCbWhSSFhZdHU0NVh6blhKVlRlWWJ0Ui8xQWV1QjFMSGVka0tDRmpL?=
 =?utf-8?B?QURFY3FJL0JPUTVoTUtVbmF6SFBxM2dnZmtPRkY4ZW8yMVI5V3VvZTJEeDVk?=
 =?utf-8?B?ZFJUckI0UjVwMzFFWnMwUHRVcTNBNlFJUS9GOGw3MHJGdkJrTnp1RjkyWkJX?=
 =?utf-8?B?WTV6TGloZ0hRVy96c3p4VnZQVEJnaU9Cd1FXV0lUU0pCd0tLeUFyNndVTUN3?=
 =?utf-8?B?NHFiaU13Y0NJUGpGazYxTm9UbWw2YUR3K0xLNEtQeDZldzJQZWFvRkczWWg5?=
 =?utf-8?B?S3dnUzZkVHc1eGY5MGdsVEJjSW1PRm1kMFhDK2VwSVMrQURTY1hVdStUYTZh?=
 =?utf-8?B?ZGM4TUZGM0E5Y3BUKzN6Ukk4YjloNGthbjA0bm5XTlM1SzRCdC8rMld2ZHlH?=
 =?utf-8?B?ckljMklPVC9nOGs1OUxXNkZvczk4M0NEZ3FXcm9rY3VLekVDTkRadHVUak5a?=
 =?utf-8?B?TUptL21EdXB1dk9CZmVyeE1IMXBtaVB3K0FnYnkydFZTNDkzS2gvYlQ5TjBS?=
 =?utf-8?B?THRNNlQ1U1dpZzhhNmV6Rk1KSFFBZjBiOC9GWGdtMXplQzM0ZGVEeTFXV3Rq?=
 =?utf-8?B?Tkp2SWJCbnNmWUNIK2pRU1ZiQTdCOTdmMTFGT3g0dkdmQk1jOEs2a2h0ZkdO?=
 =?utf-8?B?cUtvTDZkaFdscVpnZ2Y1OVAxQ0Eza2RUZkhYa1pCTTJHUW0yOXJ0Y1JEcm1v?=
 =?utf-8?B?dmorSW9BR3hFQmVuandQc29zMkh1K2RQVXFDdmpEQWs5N3I0VjZmTTllWGxn?=
 =?utf-8?B?b1ZzZzBWZytwZHNJVFVERGZZV3lPWUNvVUxGWHRBSGc4NVRhMkRiQ1ZrSGRY?=
 =?utf-8?B?ZjRQUDdrOWJlVk1tTGJONUR6Z0tPc0VYN2w1bW4xQzBZc2gwamlBbkdHK3NS?=
 =?utf-8?B?Ykw1WkF4aEk5NmZETGZldGRzdlR1Q1M0N2tXL2t4aFFoVlVEMDJBWHNyVFhk?=
 =?utf-8?B?Z01LRDdHZFlWejlXWlU5NERvcUdpMUlYN1lHYXYxaElpTHFVUUxieFd3MW1R?=
 =?utf-8?B?VFNMWEROaUlaTkp0aWg5Q0xudVlLT3FuUU5YOFBjUll1azNXdTcvQVlsbDFw?=
 =?utf-8?B?RFdFQUtoUU9KZDV4Nmw3T2lXenlBdGN2ZG5RMTlWZ0dIZU9Lb1pDeGZLWk9F?=
 =?utf-8?B?T1pWbWFTOXEvV3JpMjlEdHd0Q0crbWtoOG1hbWFmR09UWGJWc3RoeitpSHM5?=
 =?utf-8?B?eDJ1b2prUUppYWNtUnBOZSt1SEtsRTY3UURNaDZjQXlkUHYxdElKYjJ2M1Nj?=
 =?utf-8?B?aitMa2svK0kxbEVseVhuV01iM3ZYeDBVLzdyMlY4ZjRsMjZyRmJxdW9lQXVU?=
 =?utf-8?B?cGh5aFlGNEJHUUNiV1kvZE0zMXVINXBqbldPcWxOY2VhQzJKaHBMN3hvRW5E?=
 =?utf-8?B?T3oxTGFja2NBZHd0NEtwMFVHWVFnPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b2a912-2e80-41e4-a1ad-08dde14c61bf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:20:33.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n3yU9CYoKFBol7/8tFjr0jHs+qJn5ijqbu26yRPAc79ECkzsR6hWMn6V0KqKC34E1zcO10zpGr+zP+r9eJ6rVVg3g7TINzeml1+3Ik1QWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977

Hi Peng,

> The TJA1051 is a high-speed CAN transceiver which is a pin-compatible
> alternative for TI TCAN1043 with Sleep mode supported.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index f59caff4b3d4c267feca4220bf1547b6fad08f95..b49371a1272cd8a25b5e2271586b756103c64f0a 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -85,6 +85,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
>  		.compatible = "ti,tcan1043",
>  		.data = &tcan1043_drvdata
>  	},
> +	{
> +		.compatible = "nxp,tja1051",
> +		.data = &tcan1043_drvdata
> +	},
>  	{
>  		.compatible = "nxp,tjr1443",
>  		.data = &tcan1043_drvdata
> 
> -- 
> 2.37.1

Isn't this unnecessary as it has the ti,tcan1043 fallback compatible in 
the bindings? I'm still learning a lot so I might be wrong.

Kind regards,
Maud

