Return-Path: <linux-can+bounces-2135-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A19D38A2
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 11:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122861F2166F
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE691990DC;
	Wed, 20 Nov 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QYbNdFjI"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B23158535;
	Wed, 20 Nov 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099657; cv=fail; b=V6qL2S0EWQ9lkC2IdpvuYJKEPcXUEWz096sxtkcmUiuu/H0BhZBFcAVu2x35qFY1/THlEJdLNecS3MyDA+A8FljmwWCbTgmolir8px1Vz5N9uu+fKbxVfRenbZyIeOF03wYtAazvZzh0PGfryUIrkwxEEjXH7I3yFfmI2r2gh24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099657; c=relaxed/simple;
	bh=O+8v0HAv+aGQ/Sv60Im+CsIuOAqu+ghGuq4h2wbDKsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWUV88aw223Y+gx/JRh2hTe02dzuABLAzo1bNcTGH5sCsJHyHSMXLk1sl8rWdCxslDZpGJpnK4jw6TAeE+McF7WgMuWFfnjn8ZOG7WI76M5ncYLaAf1tQhb+RXsmZS7vDLDnYapdD03TqDUID50yjdFG961SczPo7iqRw9CTXdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QYbNdFjI; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unRZj+57JsjaHEk9HbDac7PV4JSdZlGMleytyFZdN7TxpWASz20m4DaKQwNymMuelc7ESnOvVw/bv7yNQ20QqXNdLhN0yz7/m61iUs5Fz5ohQVTRbiyrvU8H/4g7VxFNC4TbxSNGrTYI+YaFS3BaYNx7TioIpEVxt/GlpGl42cZBS1b8/OwO3ViFXfmTK7MJJwnIscj0ypsPqOoErR0KohcDvsFLcQreH62+IxcWls/4lUghbU6YnZPmzy1UeK6/jp/+zvYez60qzqSZSN8qzPu4aJ+apJOuSaC3P4plx76zDODaj8jMsS2qoEQtNL3tcb5d/IG54YRKyHwOb7/5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5FOJMl7q3RMWOXK/zUeD4wHDDPmMRiINbMzZ57xWaY=;
 b=go1V72c4wQM+Sd8e4RPH0613ilSKTZxZTiRXEbFz4C0moV4WLyxuC+BpV1FIc/0uteCaimwL3k9uwg49A9r+JXS41JGtjDbpjDLAw8Ie7U2EgFISBXe9/VyQghzOdUJ72fkHdzAbW3fLA4+LI7/8ieaB0erkgJiSh2+F1m3Sx2/Cps9R+Fk/y5KPSA6Ly2dU0pWEUY02K9QTQI3GZ2HAGQNBFXwy3VPHR+vxq8CFBHykNicdQ486KZnhP9v0+qf9R2rR2SIpzFuhDCYVnkg5yS3Ax+PnaRHhCbtXPu9DRvBrWMee4ejS+hrhzrFwKVPyNulJ2Wp6DLom4GpjcGkeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5FOJMl7q3RMWOXK/zUeD4wHDDPmMRiINbMzZ57xWaY=;
 b=QYbNdFjIvr4Q9hcF8wHc+33DG6ggzhkG9E/lNRa1Od/+XKFuTgHzheno62yBgWqkjwAehiZQhBBLsSa0UT7kXtcRD7pJGbQknt53JdauEGKK2VYBVf7kATqRRHYFazS2hIdLcMNivJG8j0hK4e1K7BfcHZjDATieGG/BKLn6NgkWSOhp47T6GterZ0nmfKiQfI5l6vx8hZ32yfhUW8CXH36B4SZyjrzvov92ZuDLXvCG6E8GazsUnZJjCDusKFCoN6UBGS4CxhNMEwvqzgsF9wxZQj7QDI9EAK6G8t7LJbiWP7LG4jVSXJ6JokFTO4t0euf9qCC1zURe8VBWDN9CEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9953.eurprd04.prod.outlook.com (2603:10a6:800:1d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:47:29 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 10:47:29 +0000
Message-ID: <72d06daa-82ed-4dc6-8396-fb20c63f5456@oss.nxp.com>
Date: Wed, 20 Nov 2024 12:47:02 +0200
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
 <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
 <c9d8ff57-730f-40d9-887e-d11aba87c4b5@oss.nxp.com>
 <20241120-venomous-skilled-rottweiler-622b36-mkl@pengutronix.de>
 <aa73f763-44bc-4e59-ad4a-ccaedaeaf1e8@oss.nxp.com>
 <20241120-cheerful-pug-of-efficiency-bc9b22-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-cheerful-pug-of-efficiency-bc9b22-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0062.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: b9624b29-881d-41f6-bc26-08dd0950babd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVg1Y2Z0OVB2VTRQY0o1NEJqNXpNTHQweUptSTJKYXNSSGJMYjBKMjZxN3M5?=
 =?utf-8?B?bjV6YUxCL3JidmxpNFJTV05NRTU4SmduNVZDSng0RWdwdG1Pc2R2QnE5cDRk?=
 =?utf-8?B?NG5NWS9ITnhhYW9sODZQMkRwb1AwSEttZC95T0pjcGFaenJnRmJnQTY2V0Y4?=
 =?utf-8?B?ektzaUZnangrTi8yRzBlazhpeUoyWXhpOWFHMDBIU3YrUG1ET2x0cjhXWUxT?=
 =?utf-8?B?aTE4OVM2OXYzUUVhdGo4ZzdXc2NTeUVIdjJjWHlETDlPK1Y5ei93S29PTE4w?=
 =?utf-8?B?UFBUWit6cys0Wlk1a3YwbzVtUi9rTDJROHY0TFhiSVVmODFRbS91U25McFNS?=
 =?utf-8?B?bCtBMTFiaTZta3dlNW03RGZjYUlDM0tzaGNEVnY3Q0xjdGtEVUlPQUtpcHJj?=
 =?utf-8?B?OE4wUUJxa2tKTFNUbDJYTXNZMmQ2M0w0SzZvMm9mZUp3ZmpxbG15eXNCRkZu?=
 =?utf-8?B?S0ZYbW56bEJXWjBDdUtVRC9ybnJ1eGx1MVBUdHhIalVjWmhwc29aeFY4MXRa?=
 =?utf-8?B?N2JZZG10b1R1SW5ndHF5VnJwU2RCZE00bUhNcmQvWmplZWxnajRIZWhCL1dH?=
 =?utf-8?B?ZFVoUkREc3ZpZlNvdkJqbTB1TUNzNE95OTNNMEhNVVMzUmhrQzJCcU1BdXor?=
 =?utf-8?B?YnBOZUpuUldJOGowS1NiNlhHZGhpK1BqWnJIOFlHTFZ1QWRXTjRDem0rRWVu?=
 =?utf-8?B?SHlnV2ZlOFkzQXpGSkJBNzRmRU1nS1UrQTFiSnNsNnd2dVFudks4NG8wT1Zq?=
 =?utf-8?B?MkFzY3NtQnk4Zmo0TEdEdzNtb3J0UWo4UWN3UjV6bUw0SmpoUlIzYVU4Vktt?=
 =?utf-8?B?YlRmdW4zZXVJU3NWZDRSblQ5Nk5LdE5sODRpZmdzSnFSQlU1NGtzM1ZYYVhO?=
 =?utf-8?B?VWg1U1g3MURMdS82SEhobHdlMHNOUHJ5RnBKOStNQ3Rrd0hDc2l4bHZkd2hp?=
 =?utf-8?B?bU9HTXZlcmJzTWJkZTJhcFRZL0FJU3VPU0tuaHNkRGJGakFEYklkeFhCTEtr?=
 =?utf-8?B?RERzOTFwb1lldFJCaVJGbEVNL1hRdWdXL0JheFNhTlhucWhIclcvNkVUa1Vk?=
 =?utf-8?B?Y3JKMjJ6YnhpL2tuaE9KWVZmSWcyYnVmWUg0ZDQrRFprVlN2WGtMZzIvUTBD?=
 =?utf-8?B?OG5VN0xqVC9iYkgxUnlYLy9PZ2RJU3JlRkl4SzZLVk5jRkZwMDVOVmZpMUg0?=
 =?utf-8?B?TTcyaVF3ODBvR29ra2VKTXFXTlA2d3pMeTVodnJsUys2a1Z4U0hxZmZUR2dG?=
 =?utf-8?B?aHU0ZUlyYTJQcEo4S0NEQW01OUhJNm1Ha29JYzdJaFNVSWhFVVp6eExQZWRi?=
 =?utf-8?B?SHllUDl0TjB5R1B6dTd2RDdXMEZsVFZhLzhGNXNxQjJuR1RaRVU4dlppbzN3?=
 =?utf-8?B?aEV6VjF1TXNKODExUWVxQnEwdmdTYWF5d253dmJ6ZGpxUTdxR3V2MVVVZGww?=
 =?utf-8?B?bEFaazZ0QzhUSXIxd2xQcmxyVnRpQ1FQbUswcG9JU3JyYVQyQUFWTm5WR0VI?=
 =?utf-8?B?WlcrbU9RMnIzMXBCTU5tQ0FYWlBEcFMxNGtiUGtWTGRPTGNaSGFyZUpDc01J?=
 =?utf-8?B?Qi9jc1ZrbDBobWNneHZQcE4xcEVxVmpoZVQxNkcxNEpPRXFTUnRaai9DZDVw?=
 =?utf-8?B?M243UTAxWUpaNTV5ZTh2T0E1SkZvSURrSS9mdW84NTdDWlF1UXgxaEJuN09M?=
 =?utf-8?B?YnNzK3gxWENNckwySSs1VXhEQ0pFN3B3UktLZVdpTmErYm9RMlN2ZlJmM1Bz?=
 =?utf-8?Q?WRduPgkynq5mfNjQit/3kWrdVKnGy0F41RVAVyc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U01uQ1BkV1MxVW9ndUtXbnNtazlWN1p6NHJyQWtQWFdjV2tJcGk0TElabHU2?=
 =?utf-8?B?TEJuMFJGeXJ2WGNqNGsvOFd4TlBZblFmNkpoTmFJQkNUS1p3SVgyRDNObmdq?=
 =?utf-8?B?ckdXSTZNMHg4Rk5rY3NtQ1JUaWhIaUhhSElWVytKZHZUY2dsZGNvellXRDhU?=
 =?utf-8?B?YjJ1NUhMUHdKcUNDWVkwRnpFMktHWDJLR1JQL2x6dm9XNWRzTld0a2ZLN3U5?=
 =?utf-8?B?ci8rUXJFa3ZOK05pbVd5d1ZUVVhEZTJsS0Z2Nzh1czh4WTkzY0E3ODZqNnFC?=
 =?utf-8?B?d05LcHlRaU96S0pnMTlTTk05TkU2NTJTSThNOWxmb0JjSUFMSFZjSlI4cUVT?=
 =?utf-8?B?c0Fua3ZJZFlIRFN5WWd6N3c5c2RRUjNMcDRHbXR4ajNpVzd5RG11cWJiS2w3?=
 =?utf-8?B?WXNPcTltNHVIbEVXTWYzZkxiQzF1YnJpeGZrT2UwYWNucDNtYUhhZVpHMTJi?=
 =?utf-8?B?K00ybEVIRlRRbGFnRmxUSXFiZDRjR3VTRFl1cFBPTGpidEVLTEF1dUhwYzVX?=
 =?utf-8?B?aGdQOE9EOEN1eFJLOG5pM3BPWFl4WWRMclhmTnVla013Z3NCMytWOXJTNnFC?=
 =?utf-8?B?ejFUUG5VdkFLLysxdnhNZzk0UUZ6Ujdienllc0VhRlBKNk03WXJVSnhOei8w?=
 =?utf-8?B?M3VBNWwrVWIxdHhtRk9XeFpIbGg2STQ0K1NaV0Rrb0VEdkcxVkl3b1RTQzBk?=
 =?utf-8?B?bkQwOVhWUVFiUjQ2eGhRV3dwQUxWcmIrV292TVI0ZEhqY1dEMTRKMzBHdGR1?=
 =?utf-8?B?VEc0U2lNaDJMRUdJQ2Z0azltQm5pQjhqNVpQMFFIYTkzQXJ4U2hNbGZMaHdF?=
 =?utf-8?B?ejJ3YlpqOE9vNm1nVjNneFo3U3dlcUNqODB5bnpEdnJxNnk2WUxESkVKZGZ2?=
 =?utf-8?B?bnF3VUI5UUhWWExiU2srdnU3eURld1VEMXRUS2lnZHByblBYVTFwcXpqRFNh?=
 =?utf-8?B?LzBQbW9WSFRLUWpBd211S0p4V21FRC9mSUlMUklkRkEvVGpNTU9OMzlncGZ2?=
 =?utf-8?B?RjQvc2tVVm0wd1doWkRrSTJXNGRwOGtOczZsdXo5clFtZGZ2ZHcwWDFuWFhE?=
 =?utf-8?B?bEVuTit0RkI0YXNoZS9zS3dvNnlyUjhNc2dFcG5oaEhLSkp2dlJiMFk2T2Js?=
 =?utf-8?B?UncrakJSS0RuOXFLd1hHM3ZlZmh6NWFYbVZLY3lvbkpGY3pBRWpmKzhNNWNk?=
 =?utf-8?B?VG5GNlRMaGw3bWFSWFRvbkRLVXJtdzFWbnZENEh3NXZVekpnWGFGR2dDWnlU?=
 =?utf-8?B?Rng5M3pWSWZmNUhyQzgwazhKeFZjbEhxck15WFg0S0czYlBmOTZkbXV1dnFH?=
 =?utf-8?B?Wnd6WTVzd2VjL1NORVIxVmRZT000c2QvYjlNVE1Xbm1EYklVUDdpZlZ4YTJv?=
 =?utf-8?B?ZGZ4dW5ybjUwZ09kMHM2dU14bnFhNVpSUkhYRkVxZjQvbzN0Vmpab0hLTllC?=
 =?utf-8?B?ZHNFbVJsbkxBd2h3K21Rb0V2VUFVcUFHa2NlZVRqWW1OaVVQTktFUWFWV20x?=
 =?utf-8?B?NmNTbVkrR05VQUVNcWxNNVBOM1J1VmFCbzBraXQ0M3ZyRWhYZUcvZDBWd1NN?=
 =?utf-8?B?S0dqMnBvNXl2ZXg4MHAyMzNTRlNVeU02MUlnMEFpN2lLR3FjRWt0anRuWCtU?=
 =?utf-8?B?ekFWQnVIaGs1b1d0T0QzVEFJUnFQcVFIaXhaQUdwUFN4WitmQUlPNkh0VzhB?=
 =?utf-8?B?MmNtTm9KR0hKclhrWkNKSDRCNGczZGIyRWFhZjNYR0NYUkk2all1ejZmTzly?=
 =?utf-8?B?NkQ1OWpKQ3hsZzlPYXZ1enNQYXhIcU8yNGYvMnp4ZW9VU2x5NVNsUytxN2hq?=
 =?utf-8?B?aldOZjZtbm5pVVY2M0toend4TllpbGMxdFZCZW9JSGVlR2lleC93eWIrSDFQ?=
 =?utf-8?B?b2Y0Y0RyN1JhSkdqZnBMSk00L0tIemVKQUU2NElyVTNTNGpCeFpKYjhZV0xQ?=
 =?utf-8?B?dHpBRlBYT3BVNW1pT3BLcTFYZ3FDNXY1dXE1RGNmTW1Da2V2SDR4TDFhMXJl?=
 =?utf-8?B?dXVoVUZ0dVRoRUora1FvQTY4eFllM2tjVlBEQnFjdHlCMytiUE1aV2R2bldP?=
 =?utf-8?B?azVCb3I2a3ZjaWFKc013ZlJJKzZVazNiOXMydm0zU0NlK2hDQTdHVEQxQk1G?=
 =?utf-8?B?YjBQaEU5VVdHeC8ycngxeE5sdzBtdHVqdGt3V2lzYkxHaEJuTTdsekhYcE92?=
 =?utf-8?Q?me/W/iyxLFs1pCLXADoGzs4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9624b29-881d-41f6-bc26-08dd0950babd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:47:29.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFw8kIlNMf02dsnKUrH008c+aBcKg57Rim+VgfCzhWE2zFH5hJ2yzwYixrIMtGEF6I/PyCospAbkLiIwBplWrocYuR/ZQ1u86vhY0FfDWTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9953

On 11/20/2024 12:29 PM, Marc Kleine-Budde wrote:
> On 20.11.2024 12:18:03, Ciprian Marian Costea wrote:
>> On 11/20/2024 12:01 PM, Marc Kleine-Budde wrote:
>>> On 20.11.2024 11:01:25, Ciprian Marian Costea wrote:
>>>> On 11/20/2024 10:52 AM, Marc Kleine-Budde wrote:
>>>>> On 19.11.2024 10:10:53, Ciprian Costea wrote:
>>>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>>>
>>>>>> On S32G2/S32G3 SoC, there are separate interrupts
>>>>>> for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>>>>>
>>>>>> In order to handle this FlexCAN hardware particularity, reuse
>>>>>> the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
>>>>>> handling support.
>>>>>>
>>>>>> Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
>>>>>> which can be used in case there are two separate mailbox ranges
>>>>>> controlled by independent hardware interrupt lines, as it is
>>>>>> the case on S32G2/S32G3 SoC.
>>>>>
>>>>> Does the mainline driver already handle the 2nd mailbox range? Is there
>>>>> any downstream code yet?
>>>>>
>>>>> Marc
>>>>>
>>>>
>>>> Hello Marc,
>>>>
>>>> The mainline driver already handles the 2nd mailbox range (same
>>>> 'flexcan_irq') is used. The only difference is that for the 2nd mailbox
>>>> range a separate interrupt line is used.
>>>
>>> AFAICS the IP core supports up to 128 mailboxes, though the driver only
>>> supports 64 mailboxes. Which mailboxes do you mean by the "2nd mailbox
>>> range"? What about mailboxes 64..127, which IRQ will them?
>>
>> On S32G the following is the mapping between FlexCAN IRQs and mailboxes:
>> - IRQ line X -> Mailboxes 0-7
>> - IRQ line Y -> Mailboxes 8-127 (Logical OR of Message Buffer Interrupt
>> lines 127 to 8)
>>
>> By 2nd range, I was refering to Mailboxes 8-127.
> 
> Interesting, do you know why it's not symmetrical (0...63, 64...127)?
> Can you point me to the documentation.
> 
> Thanks,
> Marc
> 


Unfortunately I do not know why such hardware integration decisions have 
been made.

Documentation for S32G3 SoC can be found on the official NXP website, 
here: 
https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32g-vehicle-network-processors/s32g3-processors-for-vehicle-networking:S32G3

But please note that you need to setup an account beforehand.

Best Regards,
Ciprian


