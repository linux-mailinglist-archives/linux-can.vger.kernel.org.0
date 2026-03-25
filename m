Return-Path: <linux-can+bounces-7251-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAvxEsPaw2lwuQQAu9opvQ
	(envelope-from <linux-can+bounces-7251-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 13:53:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C0325380
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB2530FB12F
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220403D333E;
	Wed, 25 Mar 2026 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pNb+wFuI"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C918D636;
	Wed, 25 Mar 2026 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442767; cv=fail; b=MmVNAgJusV5JT4H6MLqHEPUhQOj7gBBgSqLZUEjOKfGUzUUGyH+MgdyyU2fmDfHDYj2fqB1224enaEVwnK3fqGhTc5C2e1TDRfk8JZEUPp+c1XfvNtBb5DIKg/D4eMkcUWe+4YbCx1njcmbphSINzoYscnIlSsMXS1M7YMjB1S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442767; c=relaxed/simple;
	bh=tdEs9UAo/ZTWTga044KqIEKWTduYlMJcYMMTfgkO2SQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjCx3xKBCiwN6X7lCN902DATh3NhTKh9n+hy7v9tex6dVBlz78e0S+/R/krwLbjn5HTcYRinTQsueAoseIVBk1YK3qxDDcIJuwxvKTUR9xIwgweeHnGeqcPQ59HqGUxwMvcyjI7b8lJUc/L4zjM+fDo1EkVAs+jyVhtnqhyBASo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pNb+wFuI; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGja8SxhfwTxs54KFZan6FLWhU9tqV8idkAveDXBY1WRjUI29jETP2v2m2VTPOMOY/+e6/4g+vXF0Jnql3vj+lsNG/G03gif7w4ZeEB7UgQ7oPNVSNGkaSqCOfAxxoKJVUIuiof7YE9uNDnY2TCgkkM0kbrEMZ/58/wzEmzOqbK8OQuDt3JZXY65N3iWCOF1Es5lQC6C/k6pj5OCV5p6/V7t6JU1AjxKWd25l2hUYD2mtrhvY5+tsTPDtG9zKHiqvuPDAYbpkuEplFGAkcHH9DjNWTa6Cn8Hidzg6saQmTLA53PKs9ZJENjDsF1UUX0p1guhDSe0bPZzN6LqCoJwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn/j5AEATJyu/gslTf4VOymrJf7F+280q+8v1HG84y4=;
 b=fZM8epHt1UFISM/pM0LuykImPIjpnFP7aYRluKfwZ2U9jZM1bMFrWTvmhm0EaQaoU9a5wgjyCGRJ9LSDfrG/+pXX59VPQqbKXVr6NyqfI1H7y3n0rzAelDOtA/+rJEVIgYYaLPTXkUe+t0j/KTYPuFHoA614DUIcVfeyhNX4AHYkOuDKwSGtkIW+72uiZEVh4+xozI7LeLOoAGkKpesBQkw9aY4Rr0cCdMFmYR3vZ0fHJX2PDcHvNJlLtoLdrq6GKBJwmfDszB4ivlN1fU3wl5Re0IndFwpTO2Rr2Ak1UndNopeaA6p3z/9N2xXa64JqzJu7RsA01odkrTr4fgdkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn/j5AEATJyu/gslTf4VOymrJf7F+280q+8v1HG84y4=;
 b=pNb+wFuIwnS+nSNnEfjFeApMU6FIU/VTlXkmnOeLQnZlc1iPAKc/VtFIHvQVoxqeX57lsH7C5B0LjfvRGyXgMWbrTIEy5eX3FbCwg7bS8ylyIaL7+mMxWL5p3Nm1Md1IfrT4DpNRHjE7uLpha3DLuH/H0dCbV2ZEfy2TWjKl83Io5VV91lDSxNF7eTRQkwffJVOJnVDadNKegrBv0Rt1Llj5f2NzpSkNFHtivZD55+MifkRm8o5L8jLxZs+LWLNA7DQobHQRjp7a4HQRYzWBAopB9hio2LacEFFZmvpmCZpIAoTFsAfPJKw43x3w5n4K8IT2JecKVnksTxb+nPIWMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 12:45:22 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 12:45:38 +0000
Message-ID: <215aa710-e848-4e79-a12f-e3a9c70a80a7@oss.nxp.com>
Date: Wed, 25 Mar 2026 14:45:47 +0200
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
 <20260324-visionary-vigilant-alpaca-a492d8-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260324-visionary-vigilant-alpaca-a492d8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 49145391-2319-40a1-e92a-08de8a6c6ac4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zsp6oPFSiFQCTqZkEpuvyJTyrCn64RgLzbb/p6cF3GnrMiU399PVmuP4cTfUBApTrYJTItMd6s58Gmme4T6layd37mG/0ji1uvJhmAp/Pi/+p3VbQCFzzOwp8CrtNAw1lk81WtRWd0xbp/pVvn+SB9k20J/zZN+HzdgFeTYHc2FIJU9D9mdOz9AdFlhjNtEj0l+NIYfULWEConwCxY4F1OSSVTr82D8eHwKZl3AkXW3/3x8CoI+ovmkdmozRb1cn5b73hnj7rmEKwPJl3WvfVKo/Lk/wk/GXXNZK+0DMQKYfgTogU0PVtriKKkN6SsHVS+BLUKRFK5OQvbJERo0dOYBznRsRuFH17nUMD/+219Tdy1W1qo+JBtFGpN5KyLaW7Tv/ZSB/ma7i7RuaV1O9+jsvsx1I08FKdfs3s/EHnY1WGYm0E4RcMOzyTSWhkqwuu0OW1niImkuWfyZ9HgjuTCcGKcxadWoad7elvaLyJW2YEjeEGjksTEsN2jQyvNdhLIY38BORzpCuDqXP5mMFBnfmENvPr73GK9uDrNCloGS8722OZNDn675AhXDHZ5QcrvGuJM4tFW6+A6LB158AoRLRMIvAjb+oAM+RlnFLGnYmSNDUiA69zkaAR9aMcPlnV4xcTkK2kDG68eJTECSQXwvT3nBjocuWzhrcFXxOP0sdaZKGX5vU4iWuL9mssECn+yspQh6o9fK+mqlkomoZS1SG00rSAzGsn3JcKc1y3Hg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXBDYmlJSWdPVzk2ZEFzTFY3NG5Uenhwd05CYm9TRmVGUXRvTlducTFRRi9s?=
 =?utf-8?B?YWIxWW1JMjFFeDJ5WGN6Ym44My9WNDh3WEVPVTVYeWF2VzRIb21VVnFhSWxO?=
 =?utf-8?B?RFhhempuMTdhMlZDZ0hoZTNyUkQxRk85SHFHUVNmZ2ZQZ0dkaFAwRFd3eEs5?=
 =?utf-8?B?WnduYmJUMlFkVHdGa3h4OEt1TExweEM4ZUV4NUJud2RHQ2k4RWI5TUdHZlRn?=
 =?utf-8?B?aUxMbVdpR1lOOGlqeFdSRVdFK3NIT1l1cnd6UXJ3RWtnSGxDWFUzc2FmVFhI?=
 =?utf-8?B?a1poZU8rNVNhc244dUVwdFNlQmRiRFpXQWZ3REdWVUdUZENRek40RVlObmov?=
 =?utf-8?B?NExDaDZqQmNCY3FNV1ZGczN1VlJWbTFaOEwzYjdLTi9mMmNEZTBXRmg1OCtX?=
 =?utf-8?B?MHVIWit1cU1VdmpsZ3IvWXM1ZEs0cHV6dys5YVhYVDR2ZVAwTHdVN1B1Vnd4?=
 =?utf-8?B?bkFCYmxYWkNYSHg1dXNuMEtsL3FGbGxPaGcyQmozMEpCR2w3SzBMSTMzNzNW?=
 =?utf-8?B?bVdVaGVtdDVWR0Y4a2hqNFZrRjl0c094M0xVcHdBS0k2NHJ3SFpmbE91NnZ6?=
 =?utf-8?B?NVNLOXBlaEVoWm0xajJGZDdtVkFSZFZvY0x1WElrVXpBcjhac08vZnpOSFE3?=
 =?utf-8?B?a1orcE1MTm4valZGeFRhMHo3b3I5bVJRMXNBT0RsYzR2eVB2dnpzSFJUZTgy?=
 =?utf-8?B?SWxvL29QMFBNcjZEQ3YwczdMSUpjVjM2Zk1LMy9mRjZKY0FhTjBmaUJHbnY5?=
 =?utf-8?B?VFd6cUpEcm8ybmpQVncySU5TK3U2RDFtamRBUEhSWEhiaXVpZ2QzQlI5b0JK?=
 =?utf-8?B?T2VhQm83MHU3STYzZWNRd1JNQ3pKZTl3T0k3OEwzWHdzRzFiS3VjdnVaUFVi?=
 =?utf-8?B?Ri8vZGF5RTVobEtQcDVoVVhhWmhjUVdKNlIzb213VjNpaVNTbnlYMGV3WXY5?=
 =?utf-8?B?bTNwcmNLeXhkVGNuKy9wb2todjJJNEErczgrRGlUby85ZnFSbWNCWjNONklX?=
 =?utf-8?B?VXBkSzBXMSswL2dxZmhXRThsZW9CUWNib1F1S2p6WWxvQURHemNyN2M1bElI?=
 =?utf-8?B?Qm1SbnNSM2twek5DT0UvSEttSXAyUGFTSWQ4VE5TZC9oaUJKbmN0TTBnSnNG?=
 =?utf-8?B?aFFwVTBYaFBzbmtud2Z1WVhpNS9HNmh5L1dIQ0xBbEROYVBxZ2FqSnIzbFRT?=
 =?utf-8?B?WEtDSzFjU0ZPako3d3BRd3V3cXo2dTd0L0laWDk5ek5HWElHT3pqc1E5di9V?=
 =?utf-8?B?RVFXUkdKaENmaWRlbFZhTjFuamVuMHNGY1d5TCthNWZVQWRrK0o3dXRxRjNZ?=
 =?utf-8?B?WGdFQjQ1N2xoSVVWNnh3MVF0M0ZJZ1NRRmE4TUk5VitBdlpEelhOSTFUK2dv?=
 =?utf-8?B?MzlqU011ZFo1RXlyb1dhM1Z5Q29zdmluMzI4bXdGV0o0ZWpkWndYbk5KOTZt?=
 =?utf-8?B?NzlzRDMwMG4rMHlIMzJnRGJUcjdYbmprZ0NRZzYrVStUUmpLbFF0d2Zsc3BJ?=
 =?utf-8?B?UUVwOHV2YkJVZStPR2w5aUgxc1JrS2dmcUZHU3N5ZE50cDRWbVc3d0dmWm44?=
 =?utf-8?B?QStwM3dod0RqR3htazg4L2ZVU2N2R0h2V285L1QyRmVlVnJERWJ2MzJ0dE9u?=
 =?utf-8?B?M2g4cHVkdDhiaGhmNFRHTk5kUFROSmEzNFFhNm03TVlFNXFnb1kxcmxLUWhz?=
 =?utf-8?B?Wk1ySXgxV2NFRWNjcHhVQ0cyb1VvelRzZlpGWnVlTThLVHNVQkpBd0JkcURR?=
 =?utf-8?B?R1lGL0p0TXdCV0ZmamhzL0QxOHFIWitEelk0Sjl0OFJYUWxYRm1Pazh0dzR3?=
 =?utf-8?B?VVphVVBOcmhnd1FHL1dhemxqNnFJN2tZOElzNXI3bi9JY1FqREtoRi91aEtZ?=
 =?utf-8?B?cUR5TjVESDdiNUNKcW4vVjY3ZVZLNThDQmwwMzdlTWpMZ3B3cTBOWWdYWEps?=
 =?utf-8?B?SXBwZnQrcTRRMW4wR1hNcm1jdmNsTW5FWG5BeFVvaDFzTVZ2U3k3MUpuMWhV?=
 =?utf-8?B?RzRpQktvanM1YU5qNERrRTVMM0VqSkY4cVRoYXdRaWJnZmVlczlsWi9UOUFv?=
 =?utf-8?B?NE9nelJNWGM5TkVGcmZZL2RvbVNTSFNMYjVKaEo5akwyQXVsZ3MrbEhjVDNU?=
 =?utf-8?B?REdzZmhZVW95UUxWdThRdlliTm1PZTA2azNOZTdHV0txdnZKRFl5VFFIWlRJ?=
 =?utf-8?B?clltZFBOcm13OVo4QUFIWFJCeUZZMUhPR2g3cE5IMFQvRG94QmFWSFhpUlF5?=
 =?utf-8?B?QUg5K0E5cmllWnE5ckNUQU5IbkVJUnRMUnMvMlJtK0pQMUtxZmdZeDZheHl3?=
 =?utf-8?B?TWRHUHV6bUlYSzU4UkFmWmtXZXVwUmNLNGo3d2NMYVdHUDg4VHZHcnMwUFlW?=
 =?utf-8?Q?RfsNycWCWGf1Jxy0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49145391-2319-40a1-e92a-08de8a6c6ac4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:45:38.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoOH4+Mug3o8nRb4vUdOGEfAur+2Av+b7htDdcF7CRzaNyp3qxLfkgBCVaZe282wJI2s+vsBgSV0Fc1yDpQuSPSzCQ6xhbafdS5lVw4D7aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7251-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 8F2C0325380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/2026 3:46 PM, Marc Kleine-Budde wrote:
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
> 
> Can you check if the S32N79 suffers from the
> 
> | /* No interrupt for error passive */
> | #define FLEXCAN_QUIRK_BROKEN_PERR_STATE BIT(6)
> 
> problem? Maybe everyone just added the FLEXCAN_QUIRK_BROKEN_PERR_STATE
> for the new SoC without actually testing it.
> 
> regards,
> Marc
> 

Hello Marc,

I've tested on S32N79 hardware. Without the quirk, the controller
reaches Transmit-Error-Counter=128 (error-passive at HW level) but the
driver only sees ERROR-WARNING - the passive interrupt never fires.

With the quirk enabled, ERROR-PASSIVE is correctly reported.
So FLEXCAN_QUIRK_BROKEN_PERR_STATE quirk is needed for S32N79.

Best Regards,
Ciprian

