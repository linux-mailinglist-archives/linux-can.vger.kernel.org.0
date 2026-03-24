Return-Path: <linux-can+bounces-7243-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCIYBlmCwmlneQQAu9opvQ
	(envelope-from <linux-can+bounces-7243-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 13:23:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F4308271
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 13:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56558301D697
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869793EE1E8;
	Tue, 24 Mar 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V4SgKzfg"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288BE1E515;
	Tue, 24 Mar 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354699; cv=fail; b=gcP0voL96a5EW4eXssQUvEBDWLICnCOin2qIlZKToTkyiC2sLk9HRiLQACBPJeCZUJyOHy3WPjCjLAyT/6oujNdtdTp8gOOOAtxvlI/3TZrl7qVxWjrVTWMLIt4LljGHk43seVmSmcIpf4CxT9gV6fNUnt+sqjxh1pQutQfW72U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354699; c=relaxed/simple;
	bh=prwZJMsAYjNHMLNrcpumWOA2pTJq2mA6YoZnJFMyLw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hO6WevGQXTyIKhA3NVJOreyO4nZX02bgAL0l9oTCokcvQdaXf0XqQiMtgTQeVQuNMgLbe9C0NaLkGtBqH9AB1wvbrkxB2X+5f7dBf2z57GfN9aiRvvLRxcAtpj624sOnMl+9ZfD06hGqKTSngDxNPtxxZgIcVCYzwPOERYHO0Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V4SgKzfg; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnd0jqa3PvQ8CHLrOa2A2/BDfMY/UiAFc9S2lptULwZdSe2NgV5ztvVOFWsiUAXchtUYux2RgbTSEonuiYU/uWcbGk7b/XSRs8Zck2uwK869s7UcXs887p88h1u1ZvfTP1NOeitrJiIn3eJULHlQgSgvC01oLUvN0fntk9jy+ydJ+Ic9zAt97hsnFNDjJR9nRXsWjOLDn/MXDP0Qmh7Oh1U4TxK9Gxb986P1vRUoW3/F/EWYuJ0NvhLyE7pnptrUZLX2Aktk1maKD2IU0CyWrykYl+hfXxCSjqttTjeyfvN94kSCJvh4OCKmrb8D1wBbF1CZc3nwU1EHcCmzyshYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3C2VYqbYgbhS9nb90cw7zZ01+vDQBxBUyDhprwVJr8=;
 b=vr7HU/A1XPkSY9V5smiLk+wYXQbUBDLGnWKc+/5G5dGQ5xN09QvWmRIU+FQd4mr+kNOQdfOvL+IGmqQvObvvCkSS+egMA9SjQeeUpRlHz18UQKxLnc6XPwHggYARrjU6Kmq+omzBemKCg1xT1CQQhTPJ4DYbRTe+3EdAL7QfgD6GxMHIZTl4Z53weoqM+Gis3OhjDDUepCSgkJdW2vt5TYfD0DFwdgJ+UpJgNIKKWw2TSAZaxmfmk11MMKyB3NVP0RQvBOMSi3ZNAvazuyPtC6b4yYndfZO9uLgASiQsLPhlNeUkbDO6h5hdeWen0r/JEv0tq2ygM/dXdH2gZXe4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3C2VYqbYgbhS9nb90cw7zZ01+vDQBxBUyDhprwVJr8=;
 b=V4SgKzfgWCI7LXL9leESlf6TyNdes/piv6Qi7txQxziQdyWVtUZwEtVfjmSHI6qhJqHbgWToqrE0cNj8yskjRiHBp6dxUdpxcQONBUab0BFvYfcgpEsIBGUSQxq3pTNDjqv/nGI6XtdpodRuco5HhDn7wF4E1DaU1iAW19wejD2T+geHVsuyUPFDKUfRJjKvsbrfncJOwuoJugBMQxJLgg+geLJY2YX7HRHglooYTwxgqCZ76Ob/TwGiuxcOPpuXwHc5uaNutHHUASBp/mbG3tA/WVN+s1+NwBECJItk1zzADSpib4H0ulkMaJX+8EzqqZTG872VvKFJ/4RWGmKUGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:18:00 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 12:18:00 +0000
Message-ID: <f9a92f7a-55bb-4e53-bbcb-41e2064bb355@oss.nxp.com>
Date: Tue, 24 Mar 2026 14:18:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
 <20260324-nice-boa-of-elegance-10c519-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260324-nice-boa-of-elegance-10c519-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU0PR04MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ec0ca6-d9d6-4dc0-8a9f-08de899f6419
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	U0lnDpMg6VWdShUWW6V4ekWMukk0lTMSgQYvErGaFXAns9ptgU6AT91CMvZYB84wep6wggxRne3eTNSNBDXx1KEHw2snXdrElHcwjxnhcMbWG2KCB0GkQd3QYzOMQsu4/1BCWaIXU4CGiy/nf9NWdO8mM28Y0Fji5OYV5Wb/0whnNUb8svm7kUsWEnvigsp7hvCDU78KxhtdSn+uJfnJLiyi8hEncaPYRrFFsFVMAkeuHsmVPl/CgKnYuh+mB4n9fkCpCFiFIQuFUwBKOnkjDZGOUBnw7jI1KWks69LH5Qu+KxKZKR2sbqjCob1b40tgeojJzqe9vNTs6CtrVO/Oj+NMTXQW3FPojpU7jxVxi6dCrejkodhjjeltEKpbLUmutTu1n6ksfHaR/jVU3TCaG7v9gJW9CUArYnT/fi1k5n0zfyT/29N4EvbRM2rrkVXNV2PMTkCQVuDyFVIACMClmkdUW75iK48x4VpQiXniSpRRXZ00+K3wW3PRJYGPfpMISFfQqTCh4eDxBSX5QzIhjHNgEXcA5WvSh1LqZsHUrpt1NqTfjNNVn+THr9aaMVfb+aCBVmKDGzGtYkLUydf0OGcQjxJDXpc5I+BtAfXDkXRbgHDwqpp0g5mFRjSGt6vLpJtycAKSOLxhrc0krt37NdIDPYrK1erFOoaeOQSCVuvGbuYVNEobmZUj2hCc+cC5D2KU0xWOLFA9qNi11l6Cj2UBfn8/5kLSXUXqTzXLkGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnN4L1ZiMUlLR2dsemZuUFFaN0h6UGRySWdWaFNscENoTjBTRHRGdUYxTTNU?=
 =?utf-8?B?cUFpME1PSXpvZU9lRDZ4bmp2eEpWelpLMjk4MGFRM1JrRVh6WHAzK1A3WkUz?=
 =?utf-8?B?SkQvOVlURjdDL0UxSnFaVmZkWUMwWEljbUFyUk9DbVhLa3NZZWp1bkVyT0R5?=
 =?utf-8?B?dXFCZm5hZ1FZOFB1M1hGWUROMGRraDVsL0ovZEZHT2VKVUE5VEJjRDZadjlm?=
 =?utf-8?B?NTRFWk1OK0d4eklWT2ppYU1uWW5YVUl5NU1ENE1LY3g1QllEWXNob0ZBaC9M?=
 =?utf-8?B?MUxzTjZ0bUo3TGlKeHVRakhybzJMUDJuc1o5YlpXcFNNenU3TEQremxXMDNs?=
 =?utf-8?B?Smo1US8zbnpudCtZNDVNeUNrTFBESThtckIvVXNxVWI4NHQwOTY5NkF6czgz?=
 =?utf-8?B?UkdYRmQxUGpOWFF5RUIyWEEvUTUwYnpQZEFzTGd5c2h2NlBSS2M0d2Q4c2lV?=
 =?utf-8?B?em9Pd3AyWUJNbjIyOHNiSWlVY2l0cWxTbENabjJOWVBiWWx0cjgzbGJSRFA0?=
 =?utf-8?B?VWNqeUJTT0doQWliRnM3VkRBdjJ4cWZBM1lTTmMyREYyblRzYVJ5UmNjV1Zo?=
 =?utf-8?B?ZjhXOXNRcDNMSkZQb2s4VHlIMk9rNFdKWUZQUWJRcWRMMFNnUTNYVVNEcmJP?=
 =?utf-8?B?Mi9BMXV4MzdkZjFiQU5GVXZ6UWM3SlZSVmZqN2xmaCtEcXhXdEEyVkVTRVJ2?=
 =?utf-8?B?TEVRZ01OQnZPRS84WFJJUDhSUVFZNG42MGU2OHc4d2tmVWxGbnBCcFVML2hN?=
 =?utf-8?B?VCtoa0NwanlPcjBUdDdicDQ5QldWM3BVV0toZlhNUnBCWVlTQTJjK0Nzdm1E?=
 =?utf-8?B?OVlua2hVUEhUMlBVVzU3cUE5WXNXNkhFM2M4RDczL2hzWkxyQWxMZ0cwcWww?=
 =?utf-8?B?NjExczN6RDYwYVRWTFJVdEE3eG1vajJhMXhwNVV2aER4SUlPVURoMXlmb0dz?=
 =?utf-8?B?ZENYODZNMk9DUXZrZHlzT1ByOVdaTlIzMTg3ZDBDR014UXMwTHJIalM2bVlT?=
 =?utf-8?B?LzliSFhmUXBZMHlxWGNxcUJQSDBzclcyUmpYbnpOeE5ZNDNOdjY1V24vMThp?=
 =?utf-8?B?YlZnS2VmSTlBZ2IvRXp1Ty9QaHV1a2lHVHVvWlhtN1VTWjhreFdraTlJdDFP?=
 =?utf-8?B?U2pVL05GUFY1Z2hnNEJNOXFFV3RXK25LQVQ2R1JoWWFrV1I2R0dGR2xVOUcv?=
 =?utf-8?B?ZURkakRVYUtlU29QdFVzWGxJR28vN1ZSdU44eHhkREJxelNxcmwvL2lDaFZN?=
 =?utf-8?B?VE5FUU5EaGZqWUNJVDkreVk1enA1bFpuWnQxR1lGbFlwK0N3THVrMkh4OVpw?=
 =?utf-8?B?ZVlESVRZNWxFRFRnS2MyTHdyYVc4MTVEaE1BWHdpVUIxNmZRbnBzTjdaS1Za?=
 =?utf-8?B?bmFOUklrU2JvUlF1MTVCenJPNytETXhISy8zRUVqM25ZdFVVYkluRCtCMGg3?=
 =?utf-8?B?WEE3aXdKQ0I0eHd5VEZBdDI5WEJ5Z1Nab0p4SndWeFVQdDBPOXA3VksxUTRv?=
 =?utf-8?B?Y2YwdFdJWU9KcmRwSHJObFAxRkJua2F1WVhIenRmUlJJUDcyaXB1Zy9Mdldx?=
 =?utf-8?B?NVRneHhKckg1Q3ZtUXRYc0t3M2p6eXlvdGhtY0JUZFNBUnovRlkxVm1vRFkz?=
 =?utf-8?B?aFUvTHNhNXNpOU0rY0VtaHF0a1hvOGNYd2pLUC8rMWxzN05FeEsrbUo3ZXJ1?=
 =?utf-8?B?VkhqUkZDYUhOT05lS2puTGZyRVpuRHA5eG1hQXRrb3lWM24yRDc5MTV3UW83?=
 =?utf-8?B?Y2FoQ0pzUVVmRStJbEhWRlJOQkZOVWdPdDZ1Z3p2UXNORkFxOUlTVVZlMFZn?=
 =?utf-8?B?Q3IreTdhY2MvMzJ6SkR4WDFmTXZKZmhJTVdub0JnY1JaRjdPTjlIWW9MakxL?=
 =?utf-8?B?eE5Zc01DYXZyUWRLMVNQRE43VmhwcWZUQzNHMDAzeEpyWmVseENWY29KODkx?=
 =?utf-8?B?emMrOHE5OVF0RGlvc1d1VXdSeThwWlRVbDFXUmh2Ni9PRFAzTm01cElVT3o4?=
 =?utf-8?B?WnE4ZDFYOW1UclQ1UUhuRkdzdHdkOG9EWkx3SS9HMFEvRVZqL1BMRnJscVRG?=
 =?utf-8?B?QjA1VzgzcThENU1hdFJ5VW5PdXhGbHBOamhpUVRjcHdrKzEwd0NnSXNYNm1K?=
 =?utf-8?B?QkFoVjVWVVdFbmViV09jait4ZzkyZ0FNcjFXUmwrTDZ4OUNuRlBjSTA5Y1B4?=
 =?utf-8?B?YlZyYjJVTEJibHM0bGhha0tWU3ZrR0NmbDExMVBrRkFsQ2wvL0diS0UvMmhO?=
 =?utf-8?B?NzEveHdvV0ljSmNIYncxaG9CY3BQRFJkczl3NVh4aW5MRDk5dWgyK3VJRXJw?=
 =?utf-8?B?LzQyUXBsaFdtZ1BzTzRtU1RnVnVKZWNHcmtSekVzeVJzTi9wa01PVUlpdW1T?=
 =?utf-8?Q?hWLoYaZDRm4Eke0M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ec0ca6-d9d6-4dc0-8a9f-08de899f6419
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:18:00.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8v9zlZFnn/Hp+t0MCW3Fgb/v7FTNQpB6kF44PLa3RL8Dw5Bb+Zbk4Kl8xUBzt2xb0eJOqdKLefYsYZTZEzgEpWx7gdmP7qnqUu1bk6pdEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7243-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 6C1F4308271
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/2026 1:58 PM, Marc Kleine-Budde wrote:
> On 23.03.2026 14:58:21, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> This patch series adds FlexCAN support for the NXP S32N79 SoC.
>>
>> The S32N79 is an automotive-grade processor from NXP with multiple
>> FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
>> other SoCs in the interrupt routing - it uses two separate interrupt
>> lines:
>>    - one interrupt for mailboxes 0-127
>>    - one interrupt for bus error detection and device state changes
>>
>> The CAN controllers are connected through an irqsteer interrupt
>> controller in the RCU (Resource Control Unit) domain.
>>
>> This series:
>>    1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
>>    2. Adds dt-bindings documentation for S32N79 FlexCAN
>>    3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
>>       configuration
>>    4. Adds S32N79 device data and compatible string to the driver
>>    5. Adds FlexCAN device tree nodes for S32N79 SoC
>>    6. Enables FlexCAN devices on the S32N79-RDB board
> 
> Can you please add support for multiple IRQs to
> flexcan_chip_interrupts_enable().
> 
> regards,
> Marc
> 

Hello Marc,

Yes. Thanks for pointing this out. I will update 
flexcan_chip_interrupts_enable() in V4.

Regards,
Ciprian


