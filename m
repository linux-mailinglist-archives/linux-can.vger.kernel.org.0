Return-Path: <linux-can+bounces-8357-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +o7VFASoVGqyowMAu9opvQ
	(envelope-from <linux-can+bounces-8357-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:55:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B505F748FDA
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=HeilkWda;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8357-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8357-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD9D930344D8
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DCF3D301E;
	Mon, 13 Jul 2026 08:53:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBC3BAD8B;
	Mon, 13 Jul 2026 08:53:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932800; cv=fail; b=GfZFRBXMn32fVvrYwbmEyDtKECiZ9D4KvUXFBpjrkiDd3UegZ5ZdfwajfLBsjRPJJ4zowPcDk0oz0/JYJZvWvnN0S5FAFZaqySFjENZtbWUP94Pp3qKg4q9AXnwSCvdEwvP7GybrOTrRuhvJMMfUX2S3HNJcS7ptVWlW5VW8YAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932800; c=relaxed/simple;
	bh=jEKc1mHUxTPgmopcleEEXBhGsLlzVY9kPz//6GeEJ28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrqohyT/S+uD3aa9IFcqvkvPzTul8kvEOOfBbWh+d6uA7jxIs9WbnPP7IvmhzVcE6PCtyodwE1oBmwTCCawZMr7MY70ppvx8ARvQonhzZ2ugk3qOUacridpMOTryEi4+nwIfq5n/Zuex9SOZnMnPI+7V03EqHqrkbwctB7lJEsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HeilkWda; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrxbhcaXHNt2X9iQX7isWyZo/2pKm163cTWU5SsFCLcd3Nq+6Swz3N6/WpBudnGZaJ2vWp4w6+UPP7376lz8/lZOSsqMwJjO5muNgLK2cNtOHrzo9146xrXH1YS95l+laDk7O5YyJh4RJwrQc26BMTuNoGNZH8wbVbAOvZAbBIf72I+1DhvWr3hiJs03oNTbNeRoRqzvyI8JPGioigR97aiCcfbGT9dGwrI9qXlJQBGodsfOs/CmD/Lb2PiLGjPjRYWx5z1BcCngESd3g1qmheZoGDbS3+ov0Tfx79T9/+RbwcXd7GdKWooUMr03S0ZS+L/HROFrWbKrn9qO9OOKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIwMQuNSe7a3jJkFFm2nuBoWfl5Wt9Oyitq8ajx+img=;
 b=qQX4r5cuWShNSYEf50upo159br+CPKrncYhyVnqsnPeg90wERSvjBvSg1xKkLhGhhmnxNtcfTqCXKxf31W+r0FWXuq2SDddwrJtWeT89Ug/3RQtUh8DLFCZXrwmK8+CYw3tpXWCIRx7s8MeB4jhoaLvIN5+NA5TBHxVj1DswZJ/Z+tBY96ZB6Aiwy6cgLz15dZfLEX7coN8Y30UwkqWI8KiC1sc3ehd49AHzFV8cH0+s0SASHLgl04i5VpVD/mAwT7ksew6MJ+rKm+DGFG7YJ1VuUJ4nexi5gsIRneKCItn2malo/8HqVCaoJ+9khVSaUsRJ94aU3kz8MLrA2FPk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIwMQuNSe7a3jJkFFm2nuBoWfl5Wt9Oyitq8ajx+img=;
 b=HeilkWdaS01aU7tjxSp/rgffaAkA2N4LlRIoBe1gGBU6w6zD1NQPQaxYFzqOR/sfcJ6JfeR9TAHK2JczozClimqk2BOhYzjsJwFg3x1N52T2heJD52LUOzi9HjNdQnx8p5vW8pi2txEAGq6IuEgUGr6vtvHLx8YiGsH8bzyd3Y2GEmtDxcYzd/39XWlMVxvOJ3qbudXA7I6rISYwMThuYsem0WUZQbcCFGszyuDHaiMoohWfHqwXHtNjcRrSlRKjEBFH3SVRDVKeEY6e6sy0++LsUQ+TmfWS9a83orwB1yQxF2poUQ/ZlcPGRlikiXqrGziM06fTPjTZnW+FyqtbMA==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:12 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:12 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Mon, 13 Jul 2026 10:53:02 +0200
Message-ID: <20260713085306.2643794-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::12) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: bb672a0f-017e-4df7-69b2-08dee0bc2b74
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 NCz8OdpEHbhnUdBqkPEhmRh53wO3riAcjCfm4ElEHat0eWkVFL9ezO4iRZz1ZD5mCfEPHGWy4B4ntuzZvTqYwQKhgAZVEfranoBXu2XVKik/FeHhhfBGjJZ+MYRQcYEOv5LQcZ5qVq8Mej65FSqleCC9Try4949UVJhxkb1DWEfddSSc8nQeQ0uZn6BnI+CQ00OPhh6QMtHA8CVIig6A5JiEG1AkwDhIpWuB2i7qazTuSaFJj9MHFYBs0Wujl0qF61/+F/L28NsyTMt/lvHLquvRi6BBbLwYXTpE04TYnM87QVWDHrk2YUSFlEbRqgbguIu77YIlSaljdbruT47wuCm1JcZItuNO9fWIaqLMyK1vbLbIYnA3ski8pCaCwoLowDiukIycNXv9LMyLM0IuytBBXNHAfjvvQ4o8PXZNSw0r3Rf9obkNl6jTcJMw0McQjrdd6Q8iAYoXXpyX/6FI6Sarby+eBaJdc84EJcWOrChwC4CVk32v8lif23lpDTS0d7rfTsB3vpiVbimA7a/7hWl9Gs7Nb9PSj+mmEKCQbT6+ImZzuVOhNbKCZVX73FufVSgCNjf4a6ZW9fUQWab5nYmBjeYMrupBCHMoL1P9dVsf8tWFJSosXVYgVmjADMOCcdubt5LmjIkg5hmUAssnGtZ8YjKwfX+dfGiQ9IlAWWM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Tk5hbTRsaHBhdmVKZ1RmMUw1alFOMlYwK0gvRzY2MVdSSVFiS3hiNTkvYlJV?=
 =?utf-8?B?RUlVbmNaUTdiSXpIQnE2ZmY4bFFkSXo5T2Q5TEtsdi9DVitTRW82cm5OTmRH?=
 =?utf-8?B?L0RremJMUnFMLzY3ZXlkMjlDZ2NTcGRQT3dRRDJEOHRIYVNFbHpxYWttd0xB?=
 =?utf-8?B?T2hVdlBvcDRCRzBlYXlkc0YwZis3VGgzZTlPWENhVWwzbTNZMi81VWc4eTkx?=
 =?utf-8?B?YmN5a2pSMGNVN1d4c2xPalhHVEdsbmV6MlFlNmJPMXJsUWhoSEU1T3lWOXZI?=
 =?utf-8?B?Zm9ieE5ITUh1OTJwbDd4UnNoU0o3eW1oVDk1blZyOXNxejUrcUdQWjdieUtu?=
 =?utf-8?B?aStRdDdsR2RrSGtuVUpucytsd0JIc2RCTDllZGZBaXppaGFoTEdYZlZZNWlN?=
 =?utf-8?B?OE5XY1FPbWVQTnA4SFRCeHZaTHMvNHJQUTVFNzZBbDJocllZUUxkNXJTdjc2?=
 =?utf-8?B?NmxMOUUzYmx5Q1ExUmVvU0VNeTM5ejRNbEk5TzBacm9zSmwyUVdiWUQ2TWZy?=
 =?utf-8?B?U0hSYXptb0lMVFF2US92WnVQb1pjL1dXc1JURXg5LzZwVnlLRkF2c24xYjhQ?=
 =?utf-8?B?UDZFUDUyeitaMk1nUXZJb0pIZy9KVzhlOUdEbUxjV214WHZKMDVqYjBDR1Fm?=
 =?utf-8?B?VXd2SWRQcVdhaE92ZFhzMy9uRDJtN0NDT0Q2aFkxOWFQNThaRDF5bDB4aFN5?=
 =?utf-8?B?VHBsU1RDaEkvQ250a3R0YjRJcFpqTmROKzEySk1nTTdTRlN5d2o4UWZDbkpZ?=
 =?utf-8?B?MTFmMHdnell0SVdQVW16STdOTytoOUxxY1JGZ04wenhoM2lDMHd3TWxjd1Vm?=
 =?utf-8?B?OHFyOUhETWVmVDRzVW93RWRMRmNLdkhLZG5URGY2N25ST2lCSldOSE9VSktm?=
 =?utf-8?B?Rkw0Tm1jMUp5RWJIcUcvWElDM1RaN3hFdE94d2xIYWwrK0J2ZWgyL3FrUm9E?=
 =?utf-8?B?dmxwdWtiY011eFJSaWpuK01BeWVNb01YRlNUYmI4U2VRWWFWQ0pxNVc0ZjlS?=
 =?utf-8?B?dWZOWi9BVGZkTmhIK1FRQWJBQjdsa1VtNmxyZkdESmFsS1ZBeldyQkVWWUFG?=
 =?utf-8?B?Rm9GSmhJSkdLVVZ5aCtSeVJkeHZtc3ZIc0s1L2QrdjF4czZIa2o0VkJneThR?=
 =?utf-8?B?K0pUdGZlVVUzdHZ0cytjN0YzbHJYWEFEOHpER2NuOUxsWmVYN2pCNXhCN09M?=
 =?utf-8?B?VmZqQ3h6ZFQ5TnV5eW1WWFp1UGcrdWNVQXIzYlVFbGhhT3ZtMmg1cHpIdWxa?=
 =?utf-8?B?OTJWODJhQlFHRnRFbzZicHp2ekxhNTFVaEtiL3JBczRmVUlUbWl5Rm1GWDEy?=
 =?utf-8?B?a2xPVEpsV2lScmk1QWtRM204b3djaXRzTnlrU2pFMlRHN3NFRmF6ZHdBM1Jk?=
 =?utf-8?B?L29aMVgxRnNVREFLQzhjczYrR3RzR29LRzYxYmlVQTdNM2lvRDQ4UXhCL1do?=
 =?utf-8?B?RzV5OHR3NFRkbG5KVmlUVmRBL05rdUdnN1grNlRvS1lDNktNVStwWFZnMVpS?=
 =?utf-8?B?YVVkKzVLUkZyai8yLzJ0cTBSTzEvVzBCK0FHcWNNSVBXRW51VXMrc0JNeGYw?=
 =?utf-8?B?Zm5YNkcwWmN3dVFrL29FM1NFTHNvR1hjVVBRbmMya3Vldlc3M0FiMlJraTJt?=
 =?utf-8?B?clQ2UE9uMVZNK28rOE0rbDNIcWl1bHZzZ2hYR1JFczRLdnpEeFpJTWxEaWlH?=
 =?utf-8?B?ekV5OEExcm11Ni9MTUxMUm80bmsvK2kwRnlQRzRwNzBRWS9jSnZsR09IRjRy?=
 =?utf-8?B?MXVuSDNtT2laVXhHUGpuSUluR1RtK05aV2d3dGRlUEpkTGU5aUxpWG9jeWtN?=
 =?utf-8?B?Q0ZSSEoycjZleHgzK29LemhiNlZWblJhRENUQ2MwUVBhc29EUElEbnNiU1Rv?=
 =?utf-8?B?enBjaitBLzFFVlhIbldMWENIWFZ4MjVYcksvUllpSDdmNEZVZytjQk9Jbzcw?=
 =?utf-8?B?Q1hyWHNpTmlNTm9LTU9GdjhSNzBNUzNnK2QrWHdrVWNvZmpOOWQ1cjdQejkr?=
 =?utf-8?B?OERxSHhCeDRGMzNYeDE0QXR3WjVLSVN4NU5ER1VRMlhhcjV4RG1HUjJCSzJp?=
 =?utf-8?B?RndSQkQ2aHk5ZW5KbWYwNE5YeE02M1Q5Q0trb3lVT1Btand5T0RvWUVvRG5F?=
 =?utf-8?B?RG5UL1VISFlHQitTencyZElsNFZoY2JIcGhab09vNmJGWDFObHd2STV2L21X?=
 =?utf-8?B?QjBKV3dwbzl5a3d6dEE4WkNFb0ZOS1lMNlFmbUkwdnZISThmelJjNWg3VDlL?=
 =?utf-8?B?V0p4aEs5d0dkSUp6dEU4L0k2Z3NBZm8zbDFONWx5aEExTks3T2tDQ21kMGNN?=
 =?utf-8?B?YkNYbmFMS0xLZTVCaDJkcVZXei96RUt0K2dJcDFZYlpCQ3ViQmM3L29YZEo1?=
 =?utf-8?Q?bWtIUYnd75oGOSbE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb672a0f-017e-4df7-69b2-08dee0bc2b74
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:12.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaGm3goO0rgHeZAPt4UAMT/RAclkPChKz63lIPt8EweQwPloBCrZOcSTvvRmEhIwbTajWE0XKZUt1b4NVN9FPb2DmXyCu9D1BlldQ0Q44U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8357-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B505F748FDA

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f73ff442d530..7dde2e623def 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	u32 quirks = priv->devtype_data.quirks;
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		disable_irq(priv->irq_boff);
+		disable_irq(priv->irq_err);
+	}
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		disable_irq(priv->irq_secondary_mb);
+
 	priv->write(priv->reg_ctrl_default, &regs->ctrl);
 	reg_imask = priv->rx_mask | priv->tx_mask;
 	priv->write(upper_32_bits(reg_imask), &regs->imask2);
 	priv->write(lower_32_bits(reg_imask), &regs->imask1);
 	enable_irq(dev->irq);
+	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		enable_irq(priv->irq_secondary_mb);
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+		enable_irq(priv->irq_boff);
+		enable_irq(priv->irq_err);
+	}
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
-- 
2.43.0


