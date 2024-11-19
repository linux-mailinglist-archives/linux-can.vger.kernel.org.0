Return-Path: <linux-can+bounces-2104-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4289D2140
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AD31F21DB1
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6872A15D5B7;
	Tue, 19 Nov 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HGLeEtYm"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF60147C71;
	Tue, 19 Nov 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003681; cv=fail; b=aFB5w3p5WhRBbI3Yivb2l9EvsaExd0abNjdHGGf2a0lAGpTTRRsZbz44fEiOrNCaMC35X99j26MLYozBwM0Y/dwrjxLzXxOQFZqo7VEfs2zDb1+K81CMdbK/D1LNv6dyo2AiwKB1bjIbGHD466fzzHzR7ImEpEqwCJuLwFk292E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003681; c=relaxed/simple;
	bh=JB3qS7dmXYy3KIs0XV+dczdxREZbRbT3qYUhiE1Rl6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=motf0c1ARXlfNMAEU/uc+n+C7JrBivg1JWu/LHTztWW9YAWn2LbPE/11bSgG0/YefC0tTiGGuNc2YLNQlNF1SREbACdgt38yrh0cM+rzKQhZ08kgYU+cnsuh64XEPpzCtSEPZOlNltAlVhTghD532ToKg04clwK/6LCNrnoS6cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HGLeEtYm; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekIYjVx06KMjtvNxRGsHwKnvpFRblte275Zf+82V8zrZaOgXX5o+PfynroW0OXFTfT66F12cgNO5/oWVWhGZ4N3o/jSfo9ai+jRm9QeO0l7pzLvdErZCEYb3HJOS6joK5Is8b8IvlxmBwlU9kkPU/QaDvdbK2ppA/QHe3IumWu3voJIgyFlJH67eFk8Xguhm+hfgYHlBHOumCUBCBVAt6PNa1X2PlX5Hppkl4rIRODaSJ49vRX18hUip4EV4uE6PXbR11HVyaRBVi2n5w5wCX83gx1cZiI5ZNRK9Cjv3sxhB6sJRf71aSqoIZRud3tfH7YOMoYpLGV/R9jOsa698JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDJ0AtthCbs+ylvvKRytXTXiX1sUEU/oRh9IOEgwlKk=;
 b=dhV48hA/Qus8jGdfLcZCfUMvvpQ6zJSNl06UOPq9Ig2UKdnau3eaXYPMEiEFGE09enRKSAmzaYtj/ifdDw15xeW+2GsmFxsP5yeNCNzwDFbqYF5FCONDtYoCcqUFp44qAtvxAPqCqBZXkcV4E4y4QXXIBLl1DhHvJm2vw8nLMhyrXwbnJ22zh6JhqyqXxFDZFGe4posng330oOf9bdQwt+Cxqq6xny8CsvbmeLiLKG+jCkALD3A3EnSZuiTiqQdlBcmK5xxwGPg/cKbWLrjCWf9gNcqIj9ipJbw26m2bx3P3wFlAYRCE/JTBEBBgA8jkBhsJ7C0GtfCMYu1dceOXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDJ0AtthCbs+ylvvKRytXTXiX1sUEU/oRh9IOEgwlKk=;
 b=HGLeEtYmVE7eZOyr+XIk4ce24J7rJAW0pJxK4yMk158273a6+ScVDJNSoiRZrHAxTuAfHySKovje19sg7D9AyqNvAKC7YBsdZMCYbmcTo6EoinFEzxAYYzs9wdvOvW5anOfPFJC0DPqdxjT87Q0iYI0vooO9U3F9RDLACxV+KNSIWH/G4A+bXM4fS5QK57a660RsB12dLjT/aDY0qwEZvLs5JQhDc3ZfH7f667uunx8JkqGCv/KP07dAEYUcatzh0M11AfAkDPeRH5zH6qDu0cVgJoxMQE7RnhWqmvKtg/K5JUxiBs/W9m0e/jW2AGdDhTKL+CfkitOpEmfa8rH3LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10615.eurprd04.prod.outlook.com (2603:10a6:800:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:07:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:07:55 +0000
Message-ID: <2d9a657c-3f40-4160-a745-02e8e7b96b5a@oss.nxp.com>
Date: Tue, 19 Nov 2024 10:07:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] add FlexCAN support for S32G2/S32G3 SoCs
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, NXP Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0034.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::12) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 500f7b23-febc-47bb-ce94-08dd087145ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STJyZ3d4WnR0Z1ovYy9yekZ1aHpSanlGVS81RFBtY29QYzRVazFIUWhGdkpl?=
 =?utf-8?B?NzNmaVQxKzRLNm5DZ2lMaHRTc1JCSnZtbVA1Q0dDL1h1Q1k5TGNkZzczalhK?=
 =?utf-8?B?bUlJR0VhU0RPdTFxNER2T0FyTGkwcmVxVjBucFNiWHNPM0oxL0NtczF2bHdH?=
 =?utf-8?B?aWFhM1lmNUtGYXRsZ0JPZ1FFazJkak5VcGRlVjc0SW5PR3BsV01wMEk1R0Q5?=
 =?utf-8?B?QXJzdUc4WC9GV1JhYXZBc3AzekFNMTZuck1QWlM3cGxJSTFVT2ZzSlR3RXpo?=
 =?utf-8?B?V3RaOFZrL2JYQlZlUVVETmlHV01kMFF3bWo0RnlJMCt1QWhkTUNuS0xBaEN0?=
 =?utf-8?B?SmM4bmlFOE1yTm1yNURFdkhGK1VhRzdZTkpzUEJ1UlVvV3NSNjk0N2RHMW43?=
 =?utf-8?B?OXhrQ2dNU2o1dCtzQ2l6ZnZRTFUwVC92ZWNwRXkvVnd0MFJtWTVSUVcwWEhn?=
 =?utf-8?B?a1l3Zll0V0hMUG1CREI2aVh0Yng0TFQzcXhDWk1DNWJmanlGNURkdy9hSDJm?=
 =?utf-8?B?cklHclNsOUh1ak1XdnJNM1NFTVlJSkRUWjErU3lERDd1SkhVaUt0NU5wM3gv?=
 =?utf-8?B?V0JQOFEwSlErYnVwb3JNanlReUdyVkpVOFVka3dqYW1WRGlCc0tQTDVPSGx3?=
 =?utf-8?B?eW9EOTVwMThVQSt2TFg2dDNtQ0tGSXVFclJ1ditLKzZsMXNVVCtOR1NPQkFX?=
 =?utf-8?B?MTJzVkV1RGx5L1hGb21FQSs4UTZYMTdtZEt6UHRObEpzVURnRTRHd2s4THRQ?=
 =?utf-8?B?cDVvV2swZ2lMenVYUjJSTmV0cnZ5dkRRSWd4VVA4Q2s0dWtrTW1GSzBvSzB0?=
 =?utf-8?B?MU51UzhrdDNyT1VxbjdjQkhIQW5QZ1M1ZUpkMkZiQXRnMjVFYkVFMHJOSlMv?=
 =?utf-8?B?ZjZMNlVmZ2ZvVXN0bWV0WTNLQ0ZpMTRlR0YxaVlCVzBUc0p3YmdaR1BrSFhJ?=
 =?utf-8?B?WHp1VVVFNFhHSnpraWdocFFxNVRGa2k0K1FMaUYzeTRITS9PZG5WYmJ2bUhn?=
 =?utf-8?B?N0lqRTFnZHlsNk5yRGRZaWdPNGc2am5NVGVrNFBYS2doNDRIQkZOeTVxcUVM?=
 =?utf-8?B?bjBBM1NKS3piVi81K3lMYVFINFpLVDNCamhwS0lLMFlpeERScEZUTk5PNlF5?=
 =?utf-8?B?d1NTUGpUSlJCZ0MvV1hLUWozVzg0SUhybUZSUG1taElsUWlRQ1lmem5MSEFx?=
 =?utf-8?B?ZWpOUTBrWFM1TlJQR2RITm1LRTJ1blB0ZTBFUXZtYVdteWFsS2FSMkZUTTJh?=
 =?utf-8?B?eUhJQW9hS0JoWXAzRVRTWHZJRWRRMGZQR09HZ0Z6N01jeFAxa21QNnMwMUdP?=
 =?utf-8?B?Vm9RSmd1MXFtQlhITm9YKzkyN2ROZEdPTnh0anBTVzZTNkxXUWMwNGFFWmxP?=
 =?utf-8?B?SnkrcWlSR0JkSU50V053UFR4YWtOYk01eTZaWWowWmxZMUwxOWg3aWpjNG5u?=
 =?utf-8?B?ci9uMldKQXRtSlZMMWROUFhSNVl4ZW5jQk5wMUJxakQ4MVZ4SnRyczU0Yy8r?=
 =?utf-8?B?U2tjOTdmTEhCRE85ZHVqbmZzbG1yM1h3bzBtOWVNWGhSOVJSb2I3NE5lb2o0?=
 =?utf-8?B?ME0vdEdDSWdjUmQxYkNlVUp6dUJyVFRwalE0bVJhR3JyRzNKQjd1cGl1NTJV?=
 =?utf-8?B?a2hHdWhuTHUya1Q3ZGVkRkt1TWl1Y1diOFJKcUhXT0NqNHlXNUkydVBEcDhR?=
 =?utf-8?B?UXQxQjc2YjdiR242TzRHd0xxOEw2Tkd1M2lsRVRNOUVqWnhNSkNuaEV5K1FV?=
 =?utf-8?B?K1hoblVPa3FOOUlkZDRmV2lDRGE0UkFaaVBPelM1cEhuUStvRHBlc3pTNEg4?=
 =?utf-8?Q?XH/qA+RgfPusC9Gl6H860lq+AApexQaD/kaI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFhWaWRJWUFGS3Y3Y2h5SDRFNzIxS08wSnhQdGlheGJYOWp6d2dmMVdPNFFx?=
 =?utf-8?B?S3NEYmdLZW5ob09MZC9Kb1MzclEwYTM1TEhoY0V3VGNtcDRiS0VYK2poL0ZJ?=
 =?utf-8?B?Z1ZYNEdEQkNkVklxM3dqV0U0aDFna1RTZ21seUcwZ0xldEZsaEoyRm5DTW0w?=
 =?utf-8?B?MUFnUWpsWG5KRkZDdGxpT0ZSZ0F6UkVzSEFHYnlOb1d6c3lnaVVUZVJHUVMz?=
 =?utf-8?B?N2Y1eDZYdFZnaktiMlNXSEJSWk03TFc1RzBkM3UveFplbkU2Q2ZpaDBjTlpY?=
 =?utf-8?B?V2o2WTlpdVhTSkhhakNiMDFkK3NjOWYxRzNjWUxMOEZ2bFBDMG51UXZ5ZC93?=
 =?utf-8?B?Y0IyYlRBZnY4Y25iQVNNbmpRS1F3T2RyNUYvYzhoZE9SQXE4bm5YNzhXek01?=
 =?utf-8?B?SytiazI1OFRmZjJNTXlHcFFtZmhaZDcwdEszQXJMODliRUhXZDBoTHRPaTdu?=
 =?utf-8?B?Mi9LdkdWR0FkSHRCT1c0SUdlQldqa0xsN0tqalpDUXRFOWhLQ1ZGUXZSMity?=
 =?utf-8?B?VmpraUZmSlJ5N21MeVBCZWVTWm1LK3Nkd3JJUW1lQyswck5wcnREb3NwNDJr?=
 =?utf-8?B?MDFQcDQvVlJLTWhwR0IySnp3RHdCdk5sWEFCR3ZjWE1ZSVZyZ3R1OFI4dnNL?=
 =?utf-8?B?cUpXTlZPSHU3Y3FQNWQraGp3d1RxY1MvemVpdm05Zmg4UUYxRUhNTzFjd3N5?=
 =?utf-8?B?UEp4S2FvMHFvRDIxa1g5eEhJMkVGTC8wVFVTYnFFeWJoenNWYUp1cmY0ZDF2?=
 =?utf-8?B?K2JiVHVIVmxMSU5PQldZdDRiVmNnaW1FU2hEVGsrUDhJckFoeExaSXFUTE1p?=
 =?utf-8?B?djhuTHptZlc0UitPYmIvT25kUEdLRERCT3FEZGN4SzVnT21MRmxDSzZ3ajJC?=
 =?utf-8?B?dGoyRjdjOTNFbUZ6ZXNTbElkRzNlRFpZNzZSNXhmUldUN2xoVGdXODJHMmFX?=
 =?utf-8?B?SW9jQ3Y2dzFibXVvTWZ4Q0dLWFM3ZU1JZkFzS0hvaHMzMDBJaHdseVZLN2RZ?=
 =?utf-8?B?MmswM0EzbXd4Yk1LUURVZDZ5anRlelpjUXVoYXpteGRyazI3RjY5WmQzTTFK?=
 =?utf-8?B?cUl6UldqVk1oeDNyeGpqQ3NKZXpaZWFZeEswVS9wcjZjamdCMTVFckcwaTY4?=
 =?utf-8?B?UjMrWDF5NEtTKzY3UW5BOU5JNGRDR0grQzdBZjJraHZ6L0Vta01ETEZ5RkFP?=
 =?utf-8?B?MmpiTVl4SnhUUWtQRm1tTTBHUisrVTBDNzdiblhQMy9oYjJFZk5aaEo1bkFS?=
 =?utf-8?B?bVM3OG1lQXRnNGdlN09odE9yR3hia2xpb3lGWldrZklkdVFBQm1lNnM4djJP?=
 =?utf-8?B?WE52RzNRZHlTSnJ6NFhTTmVrNjFDSEoyNHBSZWhSeEtSRWdyVkRXQVRYclZX?=
 =?utf-8?B?N3BOa2NMejM2dENuQ2E5MkR2cnEzTlcrbkxvVlVqejl0ZmZLcFlxOTYya2Fv?=
 =?utf-8?B?SGhJekJ4UXp2dUdmL2Y0VzNXU1F2UWQ0VnNiUUpvNVlPOStFdkNMaTQ5c0M1?=
 =?utf-8?B?MytmVjg4clorYURkMXVWRFo2MmZEYk5CSHBzbTM4OVZ1VDl4WU5rYklCQVlS?=
 =?utf-8?B?TmtvTG5CcWErTzlyQ3BaOThOa0Z5bWRESnhEeHFZSUNZQ285RU90ckgyc3NM?=
 =?utf-8?B?bXFBRnNOVHJBQXJjaXY3Ny9Wa2xlQ0JweWR5VUxJMkM0czFQU1FuNkpzK0h0?=
 =?utf-8?B?Y08yV3Qwa0R3ZTZUTVR5ZUpJbHViekZ3aVNPRWp6Z2tBTTdpS0RScDIyMXlt?=
 =?utf-8?B?RkRZWEI1TE5qa1Q2QVk4eUREa2NnTWwwdlhQMlA0ejJ5M0FNZkp4Zmg5R3NH?=
 =?utf-8?B?eWdjc0hpMzlzVVY4MGVEMVpzZy9taUZ4bjVhYy8ralpaRG1IUkhsV0dha2tG?=
 =?utf-8?B?RXRDR1ZaT1NkZWk1dUcrSVFZdFc4cmZsaFpmcVU4T0pObDJva3psbnRpakd1?=
 =?utf-8?B?dEp6emhFVU5JQUdsYUFkSjBBdDRnVUlTWTIvaFlScHBjeStTVTRXeEtDcjhN?=
 =?utf-8?B?UVRWQlZOdzlLaE50YXlWZ1FST2sreHFxL1MzWmt3S2hKZ2JXSEdGZFhCRE5X?=
 =?utf-8?B?Sk5hSVBMWFRXejJDZkh2MkI1Z3NjRFZxUzFjaUZqL1VzUXpLTlVveUtyeG9J?=
 =?utf-8?B?S3RwTlhKckR6eHhUK2ViQ1hyQ0w1MVF2Q1JxZlZyT0JabW5weFlQV24xamRr?=
 =?utf-8?Q?EEUuaGxNbJEzpjf0HBhs0J4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500f7b23-febc-47bb-ce94-08dd087145ac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:07:55.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIdRBNCOfNSRiBwk+ldYqHoJKZBnp2sk2eObhOi5sd2TrkVwurEYRKcwewwYEMqbUNUdGNgPuoNBoizg9JrBNE8PFwpO4oWBLRlcVkNCh2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615

On 11/19/2024 10:01 AM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> S32G2 and S32G3 SoCs share the FlexCAN module with i.MX SoCs, with some
> hardware integration particularities.
> 
> Main difference covered by this patchset relates to interrupt management.
> On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
> errors, MBs 0-7 and MBs 8-127 respectively.
> 
> The intent of this patchset is to be upstream'ed on the official Linux
> repo [0].
> 
> Since S32G2/S32G3 SoCs share the FlexCAN controller with I.MX platforms,
> we find value in an allignment on Linux Factory tree [1]. Hence, we are
> looking forward to integrate any feedback which you have based on your
> expertise on this proposed patchset, before finally submitting upstream
> for review.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> [1] https://bitbucket.sw.nxp.com/projects/LFAC/repos/linux-nxp/browse
> 
> Changes in V3:
> - Refactored FlexCan binding documentation changes
> - Rephrased/Clarified some commit messages
> 
> Changes in V2:
> - Fixed several issues in FlexCan binding documentation
> 
> Ciprian Marian Costea (3):
>    dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
>    can: flexcan: add NXP S32G2/S32G3 SoC support
>    can: flexcan: handle S32G2/S32G3 separate interrupt lines
> 
>   .../bindings/net/can/fsl,flexcan.yaml         | 25 +++++++++++++--
>   drivers/net/can/flexcan/flexcan-core.c        | 31 +++++++++++++++++++
>   drivers/net/can/flexcan/flexcan.h             |  3 ++
>   3 files changed, 56 insertions(+), 3 deletions(-)
> 

Hello,

Please disregard this patch series. I will send a new one with 
appropriate description.

Ciprian

