Return-Path: <linux-can+bounces-2111-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E79D22F0
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8871F21669
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2F19E83C;
	Tue, 19 Nov 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RH57sxU2"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF845945;
	Tue, 19 Nov 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010518; cv=fail; b=VWZLW6HHPLSJAjUcq8/u9OKFS+SleEdpHU4GFNISEJ6lCTuRQYiWkhVVqew2aMT1IgNfF8H47NJ10NfreKSRPhJr9rlCx/jNb4qkDDsVaE53t8GTyYGtgI1VvUXOfM8uUqQTjZupKs3gdiHoB95YwrOwQD7zphvGgNJy/4Qp/BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010518; c=relaxed/simple;
	bh=n36xsiUKjCtsrzBNS8BWkejTd8YACaI0CVYPjgcSzA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C/HO8lCmXha80N4180RthsoRq4ttJ28FHoimgeBdfPNPvFoqFd1ycJmVMGSK15ggz6/Qis050tC7xHGgbC6vr6QrdSYKIN9M11lPEGhg6riUeuZoe7QJAjgvBrVLLrco62oyXFOnAWBGJIKR5bUI9zW+p9kK8sbWl2RrvyYYpNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RH57sxU2; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA8QIijlx0/LNpcGslvEEPzJQPtiPhl+fjVqUgvQEuZ+wYPeVVXabIRP9abJmFz2vuNaEkoSpgQs6d7CPzahJ48OlPRlWPkR12yborvAkzNAFSH1UAbJc0r63ozjxUYSB3zsfLz+KSrpBgH+i2c4TtLCaYn4MtFXax3xn1oJgkbZKW9E6y0vjTBI6zPN4C7iWgO6X31pPFdIlGvTMen1F7fRwosuyQwXfWi5iu4GlIxH/XXrvGZ84oEHIbmsEljnElSYWMIVOU4KotYO++MRocsY4f7r/sqizarXIx0PnZrS4b4iRdaUE2RPMdl6czD2H45zvrZOjY4XMlBRarDk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgBqqKQzNEJmQrte9r0bzY8LA3QknRFL+OJBKIziAkc=;
 b=OOse2/aPfru+gYRgbGHpHZ6WM0G72hao43P2+4akYmqsYZwIFQ3x24FWQCKPquft1Ro+TJcVgQNChED6o3XtJzFbGjYSboCLYLjR4YWxME4IWmA+X2zdXMDv+xpQmakKw7aGRqO/KDItIVOeekPQOY61Ir1yGWqziuUclQQIZdaUQq/CeHls8UIkVxohWFeBycm3gqVlNC1GCVKBgzOKbO921b0tkTXqh/EuItT4QTdWWuPC5PGWzRuhS77x6en1HqoYbmReI2T4Kn16xm5cNWrjqPL54FydhMQBve5xPEXZiFd4ZfGp4ckLi86dO0VxsGiP44N/Jnyn+q8ZaYVn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgBqqKQzNEJmQrte9r0bzY8LA3QknRFL+OJBKIziAkc=;
 b=RH57sxU2X/IJV9jQXh3LjCXoVajQVlxVeD/W/JH9EfCzJwrJvtRO+RaE42N7WcszfUB1mBLn4loWckKJnNh3IUnyB/FcTqaWKv1hSgCJXhjajPbkZiswP6iv2UhKgp+aHWqPjDoUI7NsjBJ/FBqSepur/cKZqW9vUFDyxZvj1DvLdBzVmTXdnOAXoF7OFk4GTJO8LsV9l+bTdhoZZYvvH1IGA7OEtmLSyorvYdXOkiv0hp8cdnM3o3zTug7OtUfNtg9bpsjyn5lm8v8mIXzfGY4W/fesykCdVtBdjLSx41L+t10AnU55TSyeT+egD6aVebzNre9hn0BZS7Z2lsZ5Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 10:01:51 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 10:01:51 +0000
Message-ID: <bfa5200d-6e56-417d-ac3b-52390398dba2@oss.nxp.com>
Date: Tue, 19 Nov 2024 12:01:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <57915ed9-e57e-4ca3-bc31-6405893c937e@wanadoo.fr>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <57915ed9-e57e-4ca3-bc31-6405893c937e@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f52322c-f2d3-4ba1-86ff-08dd0881306c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmJqV3phUDZ5T05RaHA0OWs0bE5JVTBxV2pSeWM3RTBsaVpYVUc4SG8zd1Bk?=
 =?utf-8?B?MGFlR1pyczgyQlh1SC90Y1JlTmVRMXZQTUFZeVIrT0ZwMVdrbUlvajRJMmQy?=
 =?utf-8?B?T2JiTm1DU2l6eTFGeXJUU295K0xRb1JVZjFKYURleEFvODU4OTJNTDdoSzJN?=
 =?utf-8?B?REIrNGZjaW9od1RkdURVckdhL1l0Y2pON2tqVFB5WGp6U1NXVkJPUk5qcHdK?=
 =?utf-8?B?ekh4OWVvT2RMb0lTY2JPWHFZSFVOR1lxVnFLNGUrQVFDWms1YnJZUlVMbnFi?=
 =?utf-8?B?UGlOc3pKd0NWNk5GTWNyLyszbDd0K1dSOUIrU1QxbGVtUjFtT1QrMWkzbnZ0?=
 =?utf-8?B?R1U5dzkwR25MSDlHemZzUHZEL00vUERYM1ptM2VhekpBN3ltMkM5azRtTEpC?=
 =?utf-8?B?aFRxZXFZbVRmeHQ4MFlBUzV6b0l2YVcrSGFkZk9aMFJsUy9FRkg1SXVRSXRz?=
 =?utf-8?B?ZlMvZnQrUmMrUmtPbU5FZHVVMWZ0Rng5MndsS0xPd281eExUMFJFdGJiTUdP?=
 =?utf-8?B?dytUNmlXSEZ4WHRqNVlRRU5BNmZTSnhPR0FEckowQXo4ZEYvS1lGbGdPSE1r?=
 =?utf-8?B?VGZSK2ZNMmZ0UTBKRndSWS95a1YvWEhhSno4ajduYkdkMzIvTVpNbkNrdDhN?=
 =?utf-8?B?VFdiUGpxTTZqcG81b0prSklQaE9OT3V5WXoxcEtSWHh0RHpLSnBGeEtxZzAy?=
 =?utf-8?B?NHIybUdPandVV2lEeFlDU3dCaG5vWDVXY3laMG9XUGlCSExNaG01ZFZ0SnI4?=
 =?utf-8?B?TzFhYnZIaWt2ZUtVVVhYYmV5c2ozRGpIWUhENlgwd2tiZkJFdnp2SDgwaTY3?=
 =?utf-8?B?eS9UUHhIa3hDa0s4VGpmblNKcVFWVVEzQXcxaGZFeTZ2ZG1McFVlc0lBc1Ja?=
 =?utf-8?B?SWxoT0tlNGJKV1dNQ09wcXRmUnRYR3ExUktOVnFKTExpVzNLN2VOQmRUd0c5?=
 =?utf-8?B?bE1UUGZJVW5OR1FBOFRwK2lydkRqQTBOZWc4eFJieFcyY0I5bm9PdGN1b3JU?=
 =?utf-8?B?RDJEQmJWckFEWjU4NjZxVlo1NDJCUEVsM3ZvY0NoU3VNenBpUUtkWTNxeFZN?=
 =?utf-8?B?YWhUY1ZuNW0rUWtwOEtNd1pnY216Q3ZRUWlsOEQyTmxuS2s4L1VCdUpuNUtZ?=
 =?utf-8?B?eVNjU1Y4NUpuTEMrWElXRkswOURSUTRJVXk1YlpzdnBnR3NscUFja1ZZZDVH?=
 =?utf-8?B?VUFpOEhXeEVJZ2JUeEtCMjBBSFR2N2h0UzNhUmpxUkZYWmJvRVVHRlJNbmhE?=
 =?utf-8?B?N25yTUcxOU5BTGo0WmJKOXV0ZDZzTEVnT3JXV2ovYm9mWU9SeE16aGU5ZlJU?=
 =?utf-8?B?czNRV0ZTZ253OXR2UmdrblppeVcxQlRUckdGeGZiUFlsN0NWYm9HV0tZSnJB?=
 =?utf-8?B?N00vSDkwREV2dW9XVTFETzBMQ0R1blRiR3lrT3ZkSE9aQWRQWGFCdWxXYlBk?=
 =?utf-8?B?U0l3OU1XdzR6R1ZQblNJVFg2RENMRnFkUFllT3ZWLy9Eb2VYK3RvYm1OTUZu?=
 =?utf-8?B?ZjFrWTF6b1NDTzhKQmNBeXBJdUZkYW4zSkZXYVhYMS93YnM5Q2ZoTFU4emZv?=
 =?utf-8?B?U0NEZitXSE5pdzErb3g1S0FQckliNk45RWJDcC94enFjUFlZWE82WjRrL0wr?=
 =?utf-8?B?ZzYzWE9KTzBXakVjR3czTVhQZUVJbmxRSEZEWk1kMWErK2UrYXpiemNOZWFV?=
 =?utf-8?B?TDB4dVBVbS9yMlZhYnk2YkpWL3V1T3VnUlhiMmkvTHhuWHVHakNmY2Q4d1BZ?=
 =?utf-8?B?YnpMREY1SStyNitoTWp2MmJDbkJWV3ZucFJnU2QvNnNaQ3U3ZDNLLzNIcWNY?=
 =?utf-8?Q?Q++Yn4LrVfzybo8pBvG3UFNOfzLX5RstkFDz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVU3NzdlY3hOTERMRHBkREk0a2pKSkVUbFFralNxVHJtN3J5eUwvMUFVYVpr?=
 =?utf-8?B?N1B3QU1yS0pQTFlQSHFqbVBBOTAweWZTelZqQlVmMDVpOXM3bHBTd2J5OUxz?=
 =?utf-8?B?ai93c2lrR3h6eldGMEZJcStXaENuOVF3NUVja2R4aFR1OHFEbUNtdWZFbVZG?=
 =?utf-8?B?SEQ0ZE9HR1pqN0xRR1RWNlk0YzRJTWdQYy80ak9wQ1M1TFo3K3dNanJuUzc3?=
 =?utf-8?B?MmU1b1JaOTIzTUZaeHdURy9jYUtiZ1hNNUF6azFtSm9SL1BrVDNIWHdXZW41?=
 =?utf-8?B?Z2RoTVlQVC9Xd3VLbmRTeDMxWkJLS1JNRXVwQlAyb3VlMUpkNGQ4dFY4SEpB?=
 =?utf-8?B?TEtmUkFWbVIvUXp1T0p5T1lZU25lWW5jcHM4RDJxKzQyNEgwN1RUYjhHK3ZH?=
 =?utf-8?B?QUdhV0RlNzZkMTdwRnVQRFNnQ0UxcGVSeXBabklZdjlHaFg2RHVwK3RQVFNs?=
 =?utf-8?B?MWpUdTUwN2g0VnRIVSt3b2RhODljc2RWSG5FdEhLejVDeVVPMGlpMnpjNzM2?=
 =?utf-8?B?TWRhbUg0MkVHWnplaExIczdyTU1zQXA5dWFXUUF6RGl1T2Z3SzRER1EzS2hh?=
 =?utf-8?B?TWh6UFJWb3FOcmZSMmR4Qlc1eDN2bFU3c2ZUOU01dzV2S0o2V09IcTExSmFy?=
 =?utf-8?B?cXlFVXAyUkg0ZkF0aWxBaHhYK0RicmhtcDVqM0h6MzgzWlhyT0xLY2lVUXgw?=
 =?utf-8?B?aUlnVHNpS2pMaHJEbTR4dmtPeVY0akRUTFlrYlQrNHlPVmE1N0dUMFZJNFdO?=
 =?utf-8?B?a0lGZHhIK0twalhudk9CQTlwVGErK00zSU1VQmxhLzAreVhENGxBbzJjTFNj?=
 =?utf-8?B?RkphcisvVHpsZGw1ajVQaTJWMFA1WWwwN0EwTkQ2ckRKWDZTeWprcW4zOE9L?=
 =?utf-8?B?SG41Q1cxUmRVUHlvMzlxdW5oelNSTHQ0WGlmRUZiMmgzcFJuNVF4U09PZ09w?=
 =?utf-8?B?alZwL29BMm41NkgxMGd0K1RnajZQVTFhUVNRUDlJZ05rTi84eFhwSlBqbmN2?=
 =?utf-8?B?Yjg4czRRSkd0c0FqRkdLRkFRNmJpRWVLck1BTXlBR3FEWU93M0JnVVFRQ0w3?=
 =?utf-8?B?cVMwTG5DYnM1YzhUMUNlYnNFRkRDa1dkMlFqUmJ4RHZOek1vaWUxWld0SmtW?=
 =?utf-8?B?SzIxTnpnZ0dEanBXUnlxQ3JodHhvT3F2dmNTWW9WTEpEaXQzUGZ1RmFDRTB5?=
 =?utf-8?B?R2NJVWdVOHBGUzBqYWpBS0JSS3E2S3BLcW9xdDZhcURHb2Y0YUJLanlVN2JS?=
 =?utf-8?B?Q2YxdVg4VENnTWNHVHozUVQzaWtORE9DS1BRYzR0V29zOFpiZjIreWhUa3Np?=
 =?utf-8?B?Tll1WVIyUG1OQnhnU0lvTFQ5OVRGUXpyeU5KM0NtbWIzQXQzd3BNYjRzdTMw?=
 =?utf-8?B?ZWpUN2lwbEpHYlJHSWRmb3BEYlhybXFqSm1kNGN3aXU1QkJDU1J3ejdnam91?=
 =?utf-8?B?ZC9TUkd3dmdNeVZ2ZkJLQmNmU0t6WjRPSGphR2lxN0lCWHRNN0dYbHRURG5h?=
 =?utf-8?B?TkhaTmEwVmpFVldsS3B1RTZJSlJmNysreW9XUmpqNDZKbkZCYldiYVIzamgz?=
 =?utf-8?B?MDhEdGNEWXEwSDhDTWdyaW5vSE1YWnN4VFNUV0tLbE9DWXNLdHpsdjQwcERp?=
 =?utf-8?B?cTl2UXZSNjR1TWZtQ04zUTBBTkxHV05DOHNIQnNTK093SkFMQkttQjMrN1ZL?=
 =?utf-8?B?dG1ieFExVzE1WlBGRUNIYWZrS1JyZnlOVEpVbStNSUYyVExuc09zeWVDd1Rn?=
 =?utf-8?B?Z3o3RUhnUlZ2bjA4TlpxMFJ0Qmp6VUxlVjZvR0RSeVVBVW5tOE1LOXE5OTgv?=
 =?utf-8?B?WS92UjZ4dFRiblYrejNiYm9BL1U3QjZHanJHU1JvTG5RcFpCdWNqUU9kbUR0?=
 =?utf-8?B?QjFlSjFKRGVMQllmN0dZZ2dNeGhpWEdTdkR3S3NGRzcvWkRhVVRheTZlcXF5?=
 =?utf-8?B?ZVhpRVZrTnQxWTUyRHVML3hDdWlrSkZmVWloRTVNeWZTVURYem1TQnJYb0VY?=
 =?utf-8?B?R2s0Tm90QStrZjBBT08rNnNvTzE0c1ZEMmRaSHdvSzhUUWZtOFVnYjJ0SUdH?=
 =?utf-8?B?a29wNGo3ellxQ1VuTWkyTS9tc050NTFFZ3YxQ21VbWpVdUJlbDNzSTArdFN4?=
 =?utf-8?B?TXlXMEtrWHJGemI1MWVVcHBpYkNYTUdFTWRnR3E1R09Vd3dDM3RidGJZZ2RN?=
 =?utf-8?Q?usHG7rXpfgHzTGYaPTGnDlw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f52322c-f2d3-4ba1-86ff-08dd0881306c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 10:01:51.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zBMxljLybqoFYsSy5CAlE0+uwj6AiOiLw/Bed3lye1MiaQcnbA7rherTDX/GvYv3/hrsTguViR+rgh78koZJApgdt+vdhB16SDPJ2VydaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563

On 11/19/2024 11:26 AM, Vincent Mailhol wrote:
> On 19/11/2024 at 17:10, Ciprian Costea wrote:
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
> 
> Is the logic here correct?
> 
>    request_irq(priv->irq_err, flexcan_irq, IRQF_SHARED, dev->name, dev);
> 
> is called only if the device has the FLEXCAN_QUIRK_NR_IRQ_3 quirk.
> 
> So, if the device has the FLEXCAN_QUIRK_SECONDARY_MB_IRQ but not the
> FLEXCAN_QUIRK_NR_IRQ_3, you may end up trying to free an irq which was
> not initialized.
> 
> Did you confirm if it is safe to call free_irq() on an uninitialized irq?
> 
> (and I can see that currently there is no such device with
> FLEXCAN_QUIRK_SECONDARY_MB_IRQ but without FLEXCAN_QUIRK_NR_IRQ_3, but
> who knows if such device will be introduced in the future?)
> 

Hello Vincent,

Thanks for your review. Indeed this seems to be an incorrect logic since 
I do not want to create any dependency between 'FLEXCAN_QUIRK_NR_IRQ_3' 
and 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ'.

I will change the impacted section to:
	if (err) {
		if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
			goto out_free_irq_err;
		else
			goto out_free_irq;
	}

Best Regards,
Ciprian

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
>> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
>>   
>>   struct flexcan_devtype_data {
>>   	u32 quirks;		/* quirks needed for different IP cores */
>> @@ -105,6 +107,7 @@ struct flexcan_priv {
>>   	struct regulator *reg_xceiver;
>>   	struct flexcan_stop_mode stm;
>>   
>> +	int irq_secondary_mb;
>>   	int irq_boff;
>>   	int irq_err;
>>   
> 
> Yours sincerely,
> Vincent Mailhol
> 


