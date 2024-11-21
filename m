Return-Path: <linux-can+bounces-2164-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8C9D4F8F
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F361F22430
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1C1CB9E1;
	Thu, 21 Nov 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="DNkmvGFv"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2139.outbound.protection.outlook.com [40.107.249.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCEB19DF7A;
	Thu, 21 Nov 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202280; cv=fail; b=crnyh5fYpNQBSEg3wvv0INt+emCaYioTffnS01CTWY2FtVUfAyY4K4w6cbw9jGWbzXD7tClQ8unSgClojEdq784tAIG0TSoWgYN5sRnTr8LEIHqgE51h+VxT3rY592/gFZu2ueO+2oiEcgDcqnX16g74++QXsWkI17N51Z38HaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202280; c=relaxed/simple;
	bh=T3yEUQjNEXp8NL33OqG4W0nYLSQtSEHhlhIMz1ISdxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=taa2sPtso6zWgGJVIWJXHOPLu/6j1OAqLXEQfECo8BhdPHQLR9RdmstkLOhR5WZC+xCXQkEP4xlZm9JCQSn8mes6xVvXaZd/tPVTP+ehP+T+EDAgzBOzJGr7n3zwF+v/FlHV5JGvJgp+2/WCxkR/24UzaMdh34mfcMFsHawV/r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=DNkmvGFv; arc=fail smtp.client-ip=40.107.249.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiYMrDiaYP8sbZQpNIYzysaxvPIp/XU4h6nh+Nc8AjeIeTy2rNvHFxji7+C/3ZlqVgU3y8rwYwtpfC74WkngS7T4JmPx09g/f9e3vVy6kyEu8pE0fG4dUUfxt67FGkKaCIPIabCGw2bYxqpVA7zt3rKNob10VxXmKEmmK1DdsQpGfTeyku84Y1mBfAyV0s/cZhy+yD4syrz8Ig0YwNugMcnUwaug1uemGOIE2X3VzCAA8kh5tW2hYYJf3hPlIaaU3JRsDHb58BIrgCv7+tcQh/2HYWyx1xUcvBgVBzuXlytPqW1wzVR8UUz279r8mQ5ndDpzcxt2JOISlomTZxOnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvRpnHb0uYSx/tDqeSGlkd0nLXoUdJFqSIni8A/0nq0=;
 b=hWhu82rGCXbTU5xKs1nafP4pcfYcrHg4OTHypKRrXvRpXMoPKwNadLrvsmGZs+JY5iXdEXMhd/zdBXKy1TOoFryuW7JmhaYBhET4SDBm8j+TzWLHWZ+E2yR7vu+BZ0j/HS6u+Pqk63TfgV6hmnIKX1oBrVSyneQirU+8wiC8aKVDLR+DciUl9Mn1OF9FKH/i8eTfdPtzvPGACnHrK4nBL5hwQdC9hfkWY3ICG0KrT2Yx/20ciI02BAYvSXJwe5Bgio4IgG28AiU0UYSuyotTLbUIWHbffNmIueXTjRDVwEkWsLWO5fxIG4I3TZe/rqbCioFFCwyNb6K9/T2MkeRuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvRpnHb0uYSx/tDqeSGlkd0nLXoUdJFqSIni8A/0nq0=;
 b=DNkmvGFvkCJ65F6uOxFEX5WiyX2Nk8hgHnRH2zVu3NtH6HZZdUBTARh0XzGCq8k7g4nEwVYbE3LEZvTxQGc7lJOzgmdJlMCpsYnBDWr1UNE8ibDVV7pyZtybXgk0r8tjk96WwXHcVaLZ1I48Qh0AUJU/4L+sHsvL8qWKPfneVdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ab::17)
 by DB8P193MB0645.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 15:17:55 +0000
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486]) by PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 15:17:55 +0000
Message-ID: <c47b3d06-8763-4f69-b845-c7b58c9e2fd2@kunbus.com>
Date: Thu, 21 Nov 2024 16:17:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
To: Marc Kleine-Budde <mkl@pengutronix.de>, Nicolai Buchwitz <nb@tipi-net.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 n.buchwitz@kunbus.com, p.rosenberger@kunbus.com, stable@vger.kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121150209.125772-1-nb@tipi-net.de>
 <20241121-augmented-aquamarine-cuckoo-017f53-mkl@pengutronix.de>
Content-Language: en-US
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20241121-augmented-aquamarine-cuckoo-017f53-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:ab::17)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P193MB0846:EE_|DB8P193MB0645:EE_
X-MS-Office365-Filtering-Correlation-Id: cce01cfb-4760-47ed-a5b0-08dd0a3fac9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3VGbUFnUUpqbUxUUVRCNXNMSm1adTlZcjlyN2JSMlJVaFZaOFJOdzBXcVFq?=
 =?utf-8?B?RXlSeGNsMkw3WHFhdW9EaHJ4K2RtOGxyZFRSdm4xbkNkbk9LQU1KcHdFcytV?=
 =?utf-8?B?S2JPazNac0NnNk8yVnNNZUVEWE1Jc0s3RWZaSkRVdDByOFBGWUJUUHRkWnV4?=
 =?utf-8?B?bENyREJoQ1BCdGVxZENZUnZ3SmJUazJ3M2lld0NRY01ySXRwVCs1dUtzL2lS?=
 =?utf-8?B?WnNYSXh1TlFLb3NNeUFSeHI0Z2QyRjdzYkZrUENZdnRnUWVKeVFIRE12ZWJl?=
 =?utf-8?B?RXhUM3lpUmNJb29nS1IwTkNFYnVlam1ZemhzR2FVeGpRT0pMdUpvRjYrNFEy?=
 =?utf-8?B?K1prTUJRRkxkdk1BOG8rZFBER3NyRnF6SG9CUkZ3eVpQQkY0em9pb2taMlpx?=
 =?utf-8?B?RHJXVTlIeGVxUkp0dy9HTDBwQXRSeUtxV3NRdnRNZktMM2RBdzEwdzZlY1Fs?=
 =?utf-8?B?THRzNzZPNmxzS1c5KzE0cDV6ekVFNGhWY281aTU3SGJoczQvL3c5eG05Rm9m?=
 =?utf-8?B?NnhzSXNFSVNTQmNjcW15N244WTJobGRGR1orWFpGVnJUODRKUE12Y1VQSFNR?=
 =?utf-8?B?d04xaFdaakh1cVVjTWZodzA2VEwrVlUzVnlrRUxYNGtjWEsvWHluWlE5YXBq?=
 =?utf-8?B?U1BZQkg4bis5YVU5dEQ3SjJjN3l3RDlaNE1WOW4rUGgrcUpRU3Vwd0tzVFho?=
 =?utf-8?B?Vmt3UTRGMVBNazhKZUlzaDJXM2RsWDlDam1rWEswZ3c3bS9wWUdldDdrZVNC?=
 =?utf-8?B?OERjV3BpUE55WFVaY2l1bWhneXhBaVJYeSt1OUZlWTRJU080a2JLY3dWWGFW?=
 =?utf-8?B?bEUzTXJzZzlDY2xYenFKeGsyTVVlM2JyTFJpM1lsaUx5Q2EvTkoxS2ZteDJ0?=
 =?utf-8?B?Q0JUTTRqMVBPd1F2bDU4QXlhL0xwOU9JT3J2dzdHekNoKy9rRG5tYWU3eXUv?=
 =?utf-8?B?OG5OaTE2R210eCtFRzNjN09zOUFUellhSk44aDVMUHdJZHZsdHFqck9YRHFO?=
 =?utf-8?B?Zm1BV3N5d3EwNmRKY3M0ZjlPeG40VlNKRmY5ZW9ZSWdRMzBRSGhUUno5and5?=
 =?utf-8?B?SGJTd3dhQTl1ZlRjeWFIUGhZQldmRTVZN3k1WlJhTEUrWXpnQzN2aUd6WDZJ?=
 =?utf-8?B?U2FhaVZDN1VpSFJDR05BVDRZZk5kaWtnTE1XeWhGaVRIZmw0enY2Q050TDBZ?=
 =?utf-8?B?Y0M1WGRCcU41dVZza2tQeE9Yam1WUEJJY0x0L1FYZWpQU0tKcU9CZkpGTVBK?=
 =?utf-8?B?dGkrbnBHcVlSdi9aZEViM0JnSmZRNjNCb0RXUklhVVJKR09YL3dEQkFrTWI4?=
 =?utf-8?B?Vm1HWk10REZPUHkyTkpoMzBuaU1vYUlpaUk4TXJZZzB4WFJZLzg3MUx3WEFC?=
 =?utf-8?B?eUpXSWZkY0dwdzJJWGNGVWJjd0hRbStFdWJreStsangxcEswSnVDTlU0WlRo?=
 =?utf-8?B?T2sxR2FXYW5neDBhSENrc00xaHIrVjJOcW5zRlppYTVhN01OZU02VSs4NFNF?=
 =?utf-8?B?RWtuNmR1WEFoVDF1WllrNUVldnJMcFhuUllpVmh3bXgwZVFycVNQcDJjcFlU?=
 =?utf-8?B?U082MnFPTW5vdDVGZmlUdXptWWJ0bWQvZ295MmhIcmNoVUlpYzlHRllCL3ls?=
 =?utf-8?B?NkkzYUZnR2Q1NktoKzFwUE5sd2xwNTRuSmxHYkg4NGtEWlN5UUwrNHkza055?=
 =?utf-8?Q?csCkblgf7IUPFE361SiL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0846.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdYb09SZkNVdTJRQ2ZaRUVvbVBRMmtoaFoxL0pueFdYMWMwc29YMG1mMkNV?=
 =?utf-8?B?cmpNUzQ0WGNNeW5iMitSU25DYjBMUXNQRVJ4dGdDN09Ib0Q2KzRzanhFVG5K?=
 =?utf-8?B?VnQ5ZmNWN3RqSjdQc2FYekZ4N2x3RUYxNkRqM1dhZEt5dVJVakp6d3NXSjky?=
 =?utf-8?B?WDk5cjZEYmZXL1FKTmJJTUFtenh2b011N1gzT1BYaVZtRWpTTVBqdU5xeXlX?=
 =?utf-8?B?UzhHWndXa29RVWVnbHFmdlVqRDBZUlloWkJaa1BqK2VRdWJXOFNLRnZ1SmxN?=
 =?utf-8?B?cU8ySnovVlBBREdhOGdMN1Ivd2c5Ri90YnY3SWt0TDBoMjZ5VmZQVzdZU1FE?=
 =?utf-8?B?bU1XazloaHBPMGtIRlQ4L2c3Wk1PcGVuaUVtTjJseis0KzRJRENSdFJQZVc0?=
 =?utf-8?B?UytkWS90V3RGK3Eva3NQVTFMSTg3eWF4bG40TS94UlN4VVR3UzhRNVFzTXZH?=
 =?utf-8?B?RzlVK2lEc1J5amo2eHBjMkpOenN0UURPQXZMKzRQdTJnKzRCRlBMNXY3ZFJJ?=
 =?utf-8?B?VlhpS0ZvcUQrU3V1REViT0Z6NHJDbFRCanQrUEVUM0Zudm5GM0s1bWlxWFgx?=
 =?utf-8?B?V2lhMU5SNHA4dmZuZHZMNXNMYzE1anE3WHJkenRZTDVHY3VzR3luanRLbk40?=
 =?utf-8?B?MHRPUTZudld0RkhVbWRWbWI5REtBVHEwWDZhM3ZWQ2YwNHJVc0dVOGdrazRP?=
 =?utf-8?B?cncxT2ZwaVd5a0tpbWtrbnhjeUc0WE81aWZrdmlqbXlXK1lkdHRrUjlpSGh0?=
 =?utf-8?B?YXVmSHRqd1NHV1VHZG9iSFB4UGxVWVRaQTFzNVN5TEg2ZDhnRjAzTWRTcE91?=
 =?utf-8?B?QXliMFFIWEpzRGExQ1FGd1VES0NFTVNVWk1DWmRERlhLZmdES05xb0l6VVU2?=
 =?utf-8?B?UmJLUGFrdkp4Z0xVdllyeHdyaGNmTnc4cUxJSk1JS0ppeTd4M1BSUEVlRmMx?=
 =?utf-8?B?b3YreXE1Mms4bmxJZmgwdGZoVTFXM2N4dmRTZFRqTXBCbmNsa1hWZXcwWnhU?=
 =?utf-8?B?WCs3SkpSZVVxc2kzQ1pkZTQrZ0F1Vkc3TndPL3FIQVVyV0sxdHhnLzRwYkNp?=
 =?utf-8?B?SWR4SkR3aEFrTmZiQzhEdml6YXZodDdoazlwQVhhOGdLRjQwdTYwbERiQWVP?=
 =?utf-8?B?RUY5UkZUWUtsUnVHQU54Tm5UOHhibXFDK01wdFRYSXhXOTc1UGtvS0ZTS081?=
 =?utf-8?B?Q1lxTGc1dFpxYmdGUFVra3VtRWdrTytBNUFVK0J0RFZjTG9GdUFJSng5cFE4?=
 =?utf-8?B?a0tGME9CUEV2M1p2TTVRK0pnWGk5ZG03VEYrSEg5ZnFBVVpkSDhodjVCWisx?=
 =?utf-8?B?cEJ0STUwVUdjbEVtRnVVUmJLeTQ0RUhkM1hvL0ZoZjVhT2hHMjVFcStoNEtn?=
 =?utf-8?B?dC83NVEzVGxBbGFxTUxFZldNMFJRMEhCWm5zL3UxcU14VStKYW1zSzFrZmNr?=
 =?utf-8?B?TS9tTW5zcTN5LzFyN2V3aG5pZkw5cm1HSGNqSlY4aG1OTThJWEFFWVJJTmdj?=
 =?utf-8?B?TTZPc0QyWFRCbTF3NDZ5SlF5S2tKSmw2QkxyRUZ5RWlaSVFkMlVQaldHOTJT?=
 =?utf-8?B?ZlZkbHVDL3RyYU1RT21sTmlLTTBoZ0lwdncrZEtCRWNGZW01K0picE1RREww?=
 =?utf-8?B?dXZEUGViUGtpYm45MFoxVnJBM2RMTkJRMUo1SXIrcmtRVkRicHkrd3JhUkRT?=
 =?utf-8?B?TEpFTWlwTkhVaGVrd3J2a1pWY01VWUNVQ0szaVYyTloyQWdFc3JjUU9nUjFV?=
 =?utf-8?B?RVZLWStDOXdEWkFoems0c3BTeUsxb1FtTExncmpVbnJNS0Zrb0pEM2QzNDRp?=
 =?utf-8?B?OElsbmVXQTd2MzlpdUYrT05CZXFUQUVvZHAyQmtJanVFbmd5UFB4SWFlZk5m?=
 =?utf-8?B?MUt5N2t5U2Rrdzd1K2NTZnFROTV3cW1Ydk50WCtjN0JWazFmS3h5cm9reWVj?=
 =?utf-8?B?M29YR01RWGw0eUhkbDgzVHpGNUNqcWgvM3JSb1ZKNmpEc2tnVGs4cU1oTUVC?=
 =?utf-8?B?dnhKNVJHaUp0cVZ6dXRnUmdnVmdZQlp4NFk1WFBEcElrN2FGZGtCSGZuSFpS?=
 =?utf-8?B?dTJsZ3J5Yms0QmgrUEFtNkpLMXo3ci9WZmRpaGJiZ0JTSGVpbmE0K042eDVu?=
 =?utf-8?B?L1YrTnIzSld3TkR1NXd1dDBVRVMra3lPQlgzbm9laTZ1R0Z5d2l5Q0VVQlVD?=
 =?utf-8?B?NEd1QTB4SmEvRTlxeDc5WUxpL3R1Mkdqa0tvc1A3VzNGb3ZreHd3Wk1Rek5I?=
 =?utf-8?B?anZvMmcrVGMyL01JcGNJRmRYSlp3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce01cfb-4760-47ed-a5b0-08dd0a3fac9f
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:17:55.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38bLnuIVBP9qRfJJPn7H2jaRbviHOxIkUdbOxLFB2ajUAI6uWM+M2dByBMuq/2vbQULBVVwGN9Fqfw/p3HT2xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0645

Hi,

On 21.11.24 16:12, Marc Kleine-Budde wrote:
> Hello Nicolai,
> 
> thanks for your contribution!
> 
> On 21.11.2024 16:02:09, Nicolai Buchwitz wrote:
>> The current implementation of can_set_termination() sets the GPIO in a
>> context which cannot sleep. This is an issue if the GPIO controller can
>> sleep (e.g. since the concerning GPIO expander is connected via SPI or
>> I2C). Thus, if the termination resistor is set (eg. with ip link),
>> a warning splat will be issued in the kernel log.
>>
>> Fix this by setting the termination resistor with
>> gpiod_set_value_cansleep() which instead of gpiod_set_value() allows it to
>> sleep.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> I've send the same patch a few hours ago:
> 
> https://lore.kernel.org/all/20241121-dev-fix-can_set_termination-v1-1-41fa6e29216d@pengutronix.de/
> 
> Marc
> 

Shouldnt this also go to stable?

Regards,
Lino

