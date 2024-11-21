Return-Path: <linux-can+bounces-2166-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F32EB9D4FB5
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A151F22F02
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A751581F3;
	Thu, 21 Nov 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="sIFnHqrY"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2100.outbound.protection.outlook.com [40.107.20.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DB16CD29;
	Thu, 21 Nov 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203007; cv=fail; b=aQTke/xDQD7+nyNidPmVtGRveiJL3BwJoBbqJDOl6KxwW5eszvjhi/viOFAcsjoj2aRb5osNb/Kga++zzju4439slArvqc5dbp8YvDSJjmq7rcdz7hZCWDRCYY0twq1/XI7SOG8ulyDgAwigLRdKCe7x74flEMHVy3ztI39OdlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203007; c=relaxed/simple;
	bh=KOcHmEcN+UBU+BuM5o/iRR0wqsTll16H+wyp34y6MqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6FTbeTgXd6RTmiHmZONB1zqCFce4mNadXEtix+0vWTF/GQJZyKDtnTVTc7ijsI6Kv+bxCjiaKK1BRzLur9tO3PV79UH4fNeQ6ujDjrBL982nzIUerVAouW5YpGV2A61niI+hIsxWcHrELfc6/ZQo8sY3e//rWziYY9OpZIi2yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=sIFnHqrY; arc=fail smtp.client-ip=40.107.20.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQU4Y5wfh5eBsAvGV8B5QbwYkcKEg8JsW0YRMaPqjq4THh2q4B2/q2nD9gkAEdFCdU9kqXi9oL+kw/oGjO/Eo+zfEFl6rI8a1eM3b42c5JIOFE7z15DbAd4wDL91qQY5/p3hHp8E0L4Mp9UpIsiuATBHSYBkYDAQD5vRFBPe58hpSgwhMolM77+wKqX/A/WarXoKCn8JMGxsULE14UzJuI6nEJjoFDxVW6pa16Kq6G4GRhKA+WLZ/y3+uLG0mAqdEcenwkTX98uLmF6zdtXfb7lUL/ghqgXwHa13QpSeFY+S4zvdI7Q2raDDwoPjUZ6PY7fjjp5y5ZDyiSx7JmqXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7C4IREdW/a/Bk69JcQQi7JunJbeUGcu1R47qPX145I=;
 b=hl3ouVHEX//z0IUHOkb4BdOTi6tiYcCXNhrTAAFsEmLER/z258ZyqV+LN01DHrff9gI577QsxwSViWG2h/pVuGYm0icBFRIYeSqU5WsRygFHKObXb+wlqhrLnWdDdtE4VWXPVOFPLze59XpZ/wNtX5H0H4Ceeake1kLlYxp7TeOWHUbSBLfPXFsg9KazEwMmATX/GWvO+598tjmlVYel740/fFkmQ/a6oBWwI3NvcB0hGpRWaFhPUw7PEkNBqDZkMZ6u0/qZW4O8TWV5HnPnWIKINA7sfLgT4oNOyfTLLYUEGBp0Zht3ey/5XnrhLDRBVAKgmZPaWiVh2CRVK6fYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7C4IREdW/a/Bk69JcQQi7JunJbeUGcu1R47qPX145I=;
 b=sIFnHqrYk2kIKpt2df4OcCPj5kmC1HBO4ZK4LF912qVskkBxsdww/Dn6DnBVhhwqau0RnvgProKc35uIEnzKz4uXYDOz5aOx5OmCKzF+afJfmo2N14Rcf12knMTNYF3PcxQEINixwGixBWW/GhYNkp8t62v971CcpT8O/t2j1QY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ab::17)
 by PA1P193MB2523.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 15:30:01 +0000
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486]) by PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 15:30:01 +0000
Message-ID: <8d67c890-6e9c-46e5-a22e-84d354a93026@kunbus.com>
Date: Thu, 21 Nov 2024 16:30:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nicolai Buchwitz <nb@tipi-net.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 n.buchwitz@kunbus.com, p.rosenberger@kunbus.com, stable@vger.kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121150209.125772-1-nb@tipi-net.de>
 <20241121-augmented-aquamarine-cuckoo-017f53-mkl@pengutronix.de>
 <c47b3d06-8763-4f69-b845-c7b58c9e2fd2@kunbus.com>
 <20241121-inquisitive-granite-hamster-b12a6f-mkl@pengutronix.de>
Content-Language: en-US
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20241121-inquisitive-granite-hamster-b12a6f-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:ab::17)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P193MB0846:EE_|PA1P193MB2523:EE_
X-MS-Office365-Filtering-Correlation-Id: 669fc974-4cca-456c-0884-08dd0a415d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|52116014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1o3S2h4T2UyU2pLbnkvZFBrMWd3NnlEUytQMjIyZW0yMDgycmhDeTB0d2hV?=
 =?utf-8?B?Rk5zUEdicTRDZ0V3UFNoMTNocTREUDRvajhNdlEvNmlXOTVRVjk3WGJOQ3FO?=
 =?utf-8?B?KytJdkZBM2ZCSjR4MWVEL2h0ZU4rbTBCN2s1SHVrdHRhNVk1M3JsQUM3Z1k3?=
 =?utf-8?B?ZFFZU0hmZFNhdWlwQTVYTjdKdERjanBpWFNFVDdveVd0WFF0cGV2YUhRK1lN?=
 =?utf-8?B?T1d6SFdTSTU4RWFCNkVJZ01vdDFKbmFsTSsvQi9DMUxxL1lNR1J0T0IzamVG?=
 =?utf-8?B?NitqY0tYckNubGp6b2RqUllEVEVUekhKZFdTazFyN3FyN3RZcStJQm1Jelp1?=
 =?utf-8?B?NXBQQVhsR2tsY1BoQjdSYWVmK3FtUitjYVRzdTdpTE5SV1NSMTQwN2FsdDMx?=
 =?utf-8?B?UlRORUdVczlYamhDUERtcis4dUVpNUxBbHcvSFM3OUswa1RzdTNpZ1NmN25M?=
 =?utf-8?B?bVV6UDRUb2gyd3FnUnd3OTlxdUxhY0ErNGV0Nng4T0hYbEdLWEp5RFNXTFI0?=
 =?utf-8?B?N1cvQXJzRkliZkozQzZvWmovV0VIVFVjbmxrUHBFdlVZWldKeUZyMHF3WUpX?=
 =?utf-8?B?a2l2eTlldmtGQklnQnBIdUN1QmlJL0NnRFZiTlp5QzRuTHQ1OTF3aHhtUHp3?=
 =?utf-8?B?NitJemxHMm16djRVRFlEVEFIRTh0dk1EMmlreWhoc3J1a201VnlyclVka1g4?=
 =?utf-8?B?QXNVVmU3V1Y4elJTQnpHMk5NNGNTUEJLTm1LTUoyclFQT2RkNyt3WS9nYmJD?=
 =?utf-8?B?WTRySzJybnp0MGdwR1I2M3ZCV3A2SDdQTlZsNExGSXV4YWV0MG5ENHExZk5P?=
 =?utf-8?B?aEk5TDZOVUxqTzd1UUN0Yi80QzB5a0RxNGdGeDViWUNJZDczNzFiZk5tWDlZ?=
 =?utf-8?B?YkpMV2FEWUV0UFdtY2JvY3lkZ1hDbyszVHh1MjRKYWpWdXBhWmhkcURJaEtj?=
 =?utf-8?B?RWJGaWJPNHltWDQ5aitMOWJYVVcrS2Vjamh6S0d4dFh1a2VkaEhYK2t2SXk4?=
 =?utf-8?B?THMwNnhUZWE0Qm11aVlzTmNuRWJacG9zUmdCaysvZmJLU1ArUkFCRGZaaVBD?=
 =?utf-8?B?ekppRjNlaW5jWmRJQkFScUt2V0QwSjVjeXErbHdsM2wvZWhERHlnT1lTU3Vp?=
 =?utf-8?B?aVdRMDJ4emlnaGZpOHdWN2dsTldWdzQzSVZHdzJwUkE3eTUxaEVDWCtiRHNl?=
 =?utf-8?B?RHgzNXZqa0ZXV1YzVmxmZ0tuM0JlZ2hhbzI4dUFLV3B5ZkhlbDRxY0ZlTDRU?=
 =?utf-8?B?T09VL2ZabXVRdmFJa040SHhIKy9LTHN1cEhmRGdOT2l5czJZNTZiLzM3NU52?=
 =?utf-8?B?bnNUaXV1WDlRV2ZvNFlvT280NlJ5MVE0ZDBoeE5vZis4bThKcFJwb2VISGxH?=
 =?utf-8?B?UnpJR1pncTYwZkxKK0w1TkFoRDI3UGdiMnF5VzdNVmhJR3Niek1BSjVWUnpG?=
 =?utf-8?B?ekErT0dsYzdoR2tsMjVNQTFuNG1BZE1ZcXoyOXM5cXpCdXJqR1dmOXlsSjVF?=
 =?utf-8?B?Y3RQZk9EV24zUnh2aG1LZjJEQkVtQzdIZlpJZEhXbnFHeGN6S1k5S21tN0RV?=
 =?utf-8?B?SDZHejBXeW5ocEpmNjV3WEEzQ1RseW9yaTlaaUx6RmV3WThNZzh0dy82bE5E?=
 =?utf-8?B?RXFwNlZhR2czZWZQUHFaNFFHNGt0T2U4SElHWTNyWUk4VDMrTGU3Z2FUeDdw?=
 =?utf-8?Q?eDK9q5hLqKfkDYRmvwEM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0846.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(52116014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am1Dc1pmOWVZa2FseEZic09xdTkybEdyTERiMW1NbXVhWWJKSTVibFBuN2Yw?=
 =?utf-8?B?QWFKQys5QUphMHNmaWVEZTc5Q0R5WDVIUkF1d005M0xQNnl0S1ZzVEtWdGcv?=
 =?utf-8?B?N1ozTTl3UFl3UDM2RUxURmdkb3RtV1c1dGRTWHBYM0pZVUZwM3lPaDZtS293?=
 =?utf-8?B?TG9GcTN3ckVmOHRaa0lDZEhPYTc2Y3JFamZBTjloRTlkZFRnVnJrM29sMW1o?=
 =?utf-8?B?ekFDc0RNbG1Na2x1MjEyZGlKSWk3OWJTUDVnajVoOXNLbElacS9jTzFWUXBT?=
 =?utf-8?B?dXpSZnJlaWQ1MzJXUGhGQXo1ZHJ4ZStVT2huRmhGam9Fa3REWjZNVzlZTlNH?=
 =?utf-8?B?VlZwbnRTQi9KNGt0UERuMFRYb1JXdmRaRzVUKzNEcUFXVVMrMkttR0lVSjFW?=
 =?utf-8?B?Q3RadXNxaDFWQVV6b3hTUXNDZlJabTQyRDFKSlJjcW56b0xZSEZyeTVkbFkv?=
 =?utf-8?B?WGRORlBjeGdqQStpV2NjUHM4eVAvWUE4N05HTEcrTlZ3MlFIUVAyRUt4LzM5?=
 =?utf-8?B?Rk9pd3hLRlNIWWJDZW12Uk1vM2dyckVScVdaQkVYdjZGdkRpSjJaOWhhenBy?=
 =?utf-8?B?UTluWnJ0dWJqeDJKTFc2ZStZZDJ1ZjA0VWN6UjBCYWVrRHBaK1UwTVBTOExF?=
 =?utf-8?B?cEpWTkpWbC9GekZWUGJ1RC9hV0pCbDUzK0VLYkdOR3BpLzVLVy9JeXdaMjVW?=
 =?utf-8?B?djlwdFBNUkZ2eXpuejBMcTk5bzBsZmt3RWZMK2FDS0o3ZDUwS3FQbkpTaElF?=
 =?utf-8?B?OU5IeFR3VDUybFljeU1UdzUzWFFxaEl0bW9DTVFRN05NWjN4Vk1RNG9aaUtM?=
 =?utf-8?B?K2l3aU9qOS9yMEJDdkdXRGJmNkNCTkpHQnVQWmxSY0VNdVRpSTNFMXhCRDFv?=
 =?utf-8?B?c2p5aXI3dVlqaWJPWnlqakFKMFJUbGVTRitQL1FBMWYzRzJhMzZ0c0pzdFZU?=
 =?utf-8?B?Nmg3WUNweXVlSnZFVXRsbktpcE9BZVVPRVkwdVB1SWtxK1Z4WGxTOVRyeEdY?=
 =?utf-8?B?NnUvUzltMGZ4ZHdTQ0tYQ1dUU0NiSS9hcWJrVDRkbkZLUkpEV3pEc0M5elcx?=
 =?utf-8?B?WmxXb3JRbnpJN0IzQ0VGcHRuTkc0bko3ejBxajlOZW5ucEtMQ2lLdVlGaG96?=
 =?utf-8?B?cWVsL0hjOFdDQ3JNNFVNL2RjTEdNWU1xQWMvck5TcFozaVRnaFJOcEc0ay8y?=
 =?utf-8?B?eVNCdXpWckRpeDVlZFhlQzJkdEpVU1o4RmQ1eUUyMFBCd0dEUThwY2E5M2xr?=
 =?utf-8?B?eDNQTGRKSzlyL29EaGlJYVFyNDZvS0w3M2FLN3BWLzRISGZIV3B2eTRhZ2Er?=
 =?utf-8?B?OVpuV0xhRFd5Y2VteDhYdWRNTktVQzIxK216c3RVaEZuY2J1dys3SHM2QTAz?=
 =?utf-8?B?NG41VGVtRVRzYjRmeDNhaElhUDVjMjR3RU40elROcmlHMU5tSE11RUptRmRL?=
 =?utf-8?B?MldCSUR1eXpOY0JLb1NORGZHSmYxSGVXTEFiWlpSdk9FdmNESGVKUnR6N0pr?=
 =?utf-8?B?Z0c4OTZMVXBBRytONytZM2Q0WmptTjJ4YWJsMDhxQzg5eXBucUx3bVdXTXZG?=
 =?utf-8?B?SUphRTFJbHNQR2Z5SnRDN0RNMG1GTlc2SUFieWNxdVladW40V3VFSWY4b0FU?=
 =?utf-8?B?TEVCc2VJS0NHeElrQVhjU0k2Nkh0NDdialJEM3owUGRVeFp4ZWEyTkVhQU5q?=
 =?utf-8?B?RWovRkJQQ2pnbWVRd0E1d1RncjNreUdkcEtlYUJTQ2wyNlUzWmszdkthR2NH?=
 =?utf-8?B?RHlBU3lHZ1puK2R0N3VKcG8zcStmRVM2LzUzTW5HS2lnN1NOL200RUl0MFJ3?=
 =?utf-8?B?TzV5bEFWVW1HOGZ0U3Awa1FaS2puMS9SYTJQaVhnQnJFSDFnT01MaFdDQnhQ?=
 =?utf-8?B?RmtVVGZ3azAwemN6cmZiOGZ5V2xQMTB5TmppNm4xMHdPdWtVWDE2czR5NW1h?=
 =?utf-8?B?SVZla0JTVkl6ekdndU1OWlh1eXRBUmUxZU1hOTYzZ1hxcmEwY0htOGJrR3Iz?=
 =?utf-8?B?U3BodDc4eFhvT1h1RHVLS0R2UHRoaVRMSjlQelpCYTJsM2ZKeDhNV2VtUkxD?=
 =?utf-8?B?ZTdqMGdheXdRNWFGUzlWbkFNZ3NlVzljcnRwMHlNTnIvMXFPOWMyUDFkSWlT?=
 =?utf-8?B?NEVmTVlodmgvWW80dDFCZHJkVjRVZnpDYWlMUXhXRENDdGlNKzN0VXJpVUZk?=
 =?utf-8?B?QTBqbUZlNmo5SzlDdkdDZ2ltNHBJdUd1eXE2cExMQVhuVCtlM1g0eWkwa24z?=
 =?utf-8?B?SW82K2NaNjhhbmZTV1E1WWp6SnB3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669fc974-4cca-456c-0884-08dd0a415d8f
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:30:01.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jHlJ+IiocmbHiksUGm9/YOA1So2Rmx7vkztMAxTe2S5enQMzsYkcB7jjC7+I4ASrRABD++onWzzQ4mjhWDJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P193MB2523



On 21.11.24 16:25, Marc Kleine-Budde wrote:
> On 21.11.2024 16:17:53, Lino Sanfilippo wrote:
>>> On 21.11.2024 16:02:09, Nicolai Buchwitz wrote:
>>>> The current implementation of can_set_termination() sets the GPIO in a
>>>> context which cannot sleep. This is an issue if the GPIO controller can
>>>> sleep (e.g. since the concerning GPIO expander is connected via SPI or
>>>> I2C). Thus, if the termination resistor is set (eg. with ip link),
>>>> a warning splat will be issued in the kernel log.
>>>>
>>>> Fix this by setting the termination resistor with
>>>> gpiod_set_value_cansleep() which instead of gpiod_set_value() allows it to
>>>> sleep.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>>>
>>> I've send the same patch a few hours ago:
>>>
>>> https://lore.kernel.org/all/20241121-dev-fix-can_set_termination-v1-1-41fa6e29216d@pengutronix.de/
>>>
>> Shouldnt this also go to stable?
> 
> Until today no-one complained about the problem, but I'll add stable on
> Cc while applying the patch.
> 
> regards,
> Marc
> 

Great, thanks!

BR,
Lino

