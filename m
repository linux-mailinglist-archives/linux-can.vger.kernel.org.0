Return-Path: <linux-can+bounces-7339-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOVmGgFm02nmhwcAu9opvQ
	(envelope-from <linux-can+bounces-7339-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Apr 2026 09:51:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A333A214D
	for <lists+linux-can@lfdr.de>; Mon, 06 Apr 2026 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A3FF30065F5
	for <lists+linux-can@lfdr.de>; Mon,  6 Apr 2026 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC41318BA4;
	Mon,  6 Apr 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jT8FJUiB"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938151A262D;
	Mon,  6 Apr 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775461885; cv=fail; b=rLsegYNHJnRcKNLQYWA6eC0X+YDkYRvwrXfv/S9ok5MgJfI9eJegydgQloxtIPZNbhuM5jISSSeTM4mKPAZSgaGUyOz8lfyNqFN+CAz4yS95VFL9JSUQzGtp5fpTf7yrBbSdfgyoAx7Q2beHJKYqUWlf5Djvb0O6c6kv3Fw8yJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775461885; c=relaxed/simple;
	bh=nxjfKt79L4PMHg8cRu41qgIv1Kv3iVthHpEteDnD7sc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG9N/q9QwkgirM6ft34YUP+rBRqZkYokhEDZXFc6b4BN6FLDn16QmSt70NoxjjkRQyJXakZ/0oX57nGd7IY4ozlqerr48wQG4xZ6twJjvKBVvA2ens1giFsMvc2SiKpD/pLEU4UWcno7GTt/iHTG9FbMT+0Op2dfN1So/56zMRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jT8FJUiB; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE/dioKZZ6dii+tG272HxND0/+VxNBkEDK37/y7w2sA7ac+PKZ2RRohSCbXm4S/3biKcol8s6ugtO6f19xPFAkib7SUaWffSfJSvPIFqFHTxXnFB4Og6vOMNeKFG7YSc/nK58Dq4T3XB07U+xcwzAA3mhdrZScQ0AT4IzcA0YKD7VMdsVIKSlwVbhYJTtVWSs5uQudAmzb4RDlgsp29bPRHVkfNIx6ZUYR5qXSKfkeRwnVYjj6PEz2yDai/W7ro4iG57/Ezjdjz9c74uTIIyGhQ7phOj9sCfqcibH7nu0gn0yxE8TQLzVxi8u/anTwEFOjZWUyrqclji+FYkLC86lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QF3WvKyJzuR2UeQ2pteKdiOOyznY6z90PyrVch19Dc=;
 b=FjjNDWqexoLnpLe4HmYtsA5aRcPN93M4drzBam7XhQwbh2CpHZqkAjjQ66yOq3oBfzGSBU4ZIh2x80KUW/L/4tNom1jYO8061+m6C93AhLkvYSO4E3csYpSsWY54JPZlkXHBQoHMhNsrmUPBISWVIh6G14B0gzspU6ydlbDW0LMWLXVaLa77Me61+joOMZCstmWMLtzZbE//JGx/8ygp6eOZ8Nd0/nLhUnTI2ktVoZ8J7BJLxkzJZtZzujqyUt5pNMeNee2xUXiUgiLWHuenS1vJlM4Pyhkz0DK0XjAbEDBYztPEwPbCTJsb3Q/42Mw87F/NQGqcT0olGIcp2b17MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QF3WvKyJzuR2UeQ2pteKdiOOyznY6z90PyrVch19Dc=;
 b=jT8FJUiBja29m8IBa2jOxE8l+Sqd1lgebEffCHnRL6kiLbBvq7PkJK16re+Un1aavF/LBLz7P8deYqI29zg0co/yr+GqDxemsD9Hmoz1YiEHC2D9idspkvjQDoibgE5VAPDiU/QQSa5qCBPcxTmqZWZbqxCfcNosIRsTw+A8wdAAa6Y3H4zPVHw7g8Mx8/IRg6dS52GtvWbg0Dsym1BIZr1IxXye6N54taDYsyoV7HJR8/Q6+SPXJJzj1gmYf3PUU//aSd+IPdJTglbqKM1aEosR2hRjqGLRO1pIGyzWZdHDkRNyzcsDVQmQvwnO7USmmx2jRthU4blI0wkVZzZwaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 07:51:19 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 07:51:19 +0000
Message-ID: <0ee87f3d-64a8-48de-a213-e3ea604a85a9@oss.nxp.com>
Date: Mon, 6 Apr 2026 10:50:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 39910a20-0daf-41b0-0342-08de93b149f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a+xt4kXeQ6uatTWi7MFzpalQipY5GwH360Hd5gOhL35PENASyZBPguPaw72yZ/92g4Z6eSKgEE9+/P3H5aIWNteKMkoeIKQQ9lp7FomvcE3wzCDwZJ+VuP2ZwMXQdBJvY+FvA2OuMXZZzADRMoHrRbdhUUl7bTYMEYbMwItoqXLYbMh2C97t904TtfLgTKd2xlfcOcPhoRl2WQPax3JN4RgvT16eMSW+yUWcgElSFpr0CGX/xwibFUfWst3Ks0Y884BNKEy8wpee9+PYXl+4sgPNKcCIu10Tp6cJKS7HfrbnJn6cuQtN6S/g6YbQdGa+4LF3zLg5I1ruHo0hOgVYXWN5sUpQHdsgJh8527G97R6AqwihV5UXPuoZAeDJJ2jjCD2w/VcMXki9sNVU9EB9fI9/tp45orSbs5/1zlaTSqWJwAhcIz1SwDnD85/osZjXCYgd1YwGsVgSJPqCzvrK2Q2lE8l/47udX37Av2HqqZ7UbE9dWku28PDVmljqvTFBIG5KemmqTbKXez27Vmjxk38hRGbqRy2XwhudjiEh6N2mCZsH0d1KwnbqKwqGdP6HQKXdieQTGx1hjZXAR9UA6/2d73wvjSTkh/iEeu14EQr1I4S9V8iSp4cJd3Hfhpqjvmo00ZNPtZ84KDHTwiAJzgYK9ZCkjPj00d5cwWRZ7SKyVzypPLVeonUvKHCc4RuB8M1nwM1Zm5Dk1HXp6DRaECmaPDOfg8S009Ha1eMyFRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWdqWHJYbXFURnBZUkxWU1hxY2VYVm1Cc1AvU20xaHpUREhkaVpxcE5peitt?=
 =?utf-8?B?TS9DYklwZHhlVnMvdklXSnU4TUlHK3Q5bnlIMDdpTlM1Q0kvQ1VtOTNDWWZG?=
 =?utf-8?B?ZXI5aTJEZFRQRU5yWlpIVmd1cjVEU2IwSE9PNlFSQmJvMlNIcGtuQjFsSTIx?=
 =?utf-8?B?LzNySkJkaDdCemFnSGlENVhoT2lWZGxnbE1aRjBVUTdHclV3bzVrNTJMS0VD?=
 =?utf-8?B?Lzd0ZG5OSmFsZ2pGOXMyTjd1dVNmRXN5VjdKTC9HaEdDcnNFdWlIZzJQNmFt?=
 =?utf-8?B?bzZqMmFHMFQxYktYUklXZndhTjVpd0pOc0hXS254TWRsaFZac2RZTHpnRS92?=
 =?utf-8?B?cTA2QjBYWGkxVFZ2Wit1dHQ3aElnc1EzOEtOT0o4dFo2dkxqdFVQdkZwTHlT?=
 =?utf-8?B?QUpRejZKQVNMT1hTSkl5dnUrWDh3MHQ4MXdtcXRDSFllV1RvVVE5OUMveUp6?=
 =?utf-8?B?aXE5UFg5Yk10WXZpcVdwNWZFU3FMNEJnb1NmVitqQjdvOTFzOW9mNTUzemdm?=
 =?utf-8?B?L1dlTXpOd2w5b0plYzJ5djNDYm1DaGxzUDQ3Qm0yUXRCREZ3Y1ZPQmhsa1o5?=
 =?utf-8?B?R05ITnhtSnIxUitNTFkvc1Y3cUpYQlU5dmNHL0R3Q0p4djdtLzZ0WEtpSHdS?=
 =?utf-8?B?SVFHZFNxMVdwK09LTXk0ejVnc3BiNVF0NUtqa2Y0bXlaVmVlVHlSd0t4TERs?=
 =?utf-8?B?b2V1ZE8rdThiZk8wb2J1eUFaMjRLWVVQWCt4QzhFcnZoVDFPQ2hQVmlQMjNw?=
 =?utf-8?B?OHp2MW9XUXQvRWdBaUcrVTgrNEFpbitScUI2c1FobTRUT2dTWVRoQmxsM053?=
 =?utf-8?B?MFdMQWhCdkF1NVJzUWZtWkEwY3BWRDM5T0dUQ1ptcFMxTlp2MzNycVJON0JF?=
 =?utf-8?B?VXVwbC9sMDRaR1RXU1pCZE12YktpSW9IWTErL3R2SThVeE9IUTJrVFl3K3Fv?=
 =?utf-8?B?Q1RtTWkraG8vYUJ4RUlmem5Sak92YmNickFCUVAzRUluVFdxb2hHNk5OYTcx?=
 =?utf-8?B?NFVMeVplRjRJM1JZRHVMNHlqcm1GcWV5Y2JBcjRZZkhUMVp1WXpia2U2ekpN?=
 =?utf-8?B?anp0cG42SUh0Z08yTWlZWDJDa1BiYkt3SmdLT1k0akZyaHpYdUdxRmRsQlVS?=
 =?utf-8?B?SmVWeUVyb20yYmhtS25IQXMyV0F6SEpGbXV3S04waENmMmRBZjU1MjgxQ0ov?=
 =?utf-8?B?eklyb0Eybk9aQmRERXNGUC9nTURrTWhiaCsrQWg5M2ZFUXh0Y3hHTmFCc3ZS?=
 =?utf-8?B?c2hLcm1ya0F0dC9JdFcwdzBFSlJYMjdIM1l2S3ZVZDZLTGxDYXZvSDBqeDBs?=
 =?utf-8?B?ZUlxOUV3UHlZcXJnWEd5K3RSSFV0elkzanlRMitCcHBTeWdVUUVteEMxVjAr?=
 =?utf-8?B?Q0QrQ1FIZWNYS2VUU0lQd2FQL2ZlVThRdTlIVGQzSGhWT1JFM05pWTdlUm9j?=
 =?utf-8?B?OXIvN1RpZUowRWxOUXBhVjB5RThHeXhpOFRYVmxBdFA3SGQxL2pRejkxa1Ez?=
 =?utf-8?B?OFRPbGVRUHBodlRZZVo2ZW0zTDEzWWZKVFVHTzl4R1luR2JQbTJObHRtODZx?=
 =?utf-8?B?Q3RJRVFkcDVpbFNXdzA4RTMxR050WnQ0WjRPT3F6TUhvTjZIWVFXQThJVm5S?=
 =?utf-8?B?a3lRanhOUU41T014cmE5WlZ2Tm9xdGlpSW5xNlplSFlFRjlyQVZZMm14eWxF?=
 =?utf-8?B?MjEvS2tYUVRLZTNSNmhIY2pvNmVFZHhXSml2WmRPcmNTNTU0aFNZdlNoc1BL?=
 =?utf-8?B?Yk5iak8ycSsrRzZrUWJpSHp2NCtvUVhiTnlMaVlFY2VZNjBmQVkybHhYVkpD?=
 =?utf-8?B?eU5sT0dZclorRmpNb2Jud0J4bWNtUHQwekt6OEpCdzduMTduZWdkK0QvZFhQ?=
 =?utf-8?B?cDhWSTFDVzFTVVdydkdCbFRxRTA5c3JGWVo3cU43VHRjVTZSYldOeWg2eTln?=
 =?utf-8?B?S3doRGNvVUs5T01BTVlGUE9LMWJRNS9EdDkvT0RsTnNmOFFXT0VoLzFpbnVi?=
 =?utf-8?B?cGpOU0FWMEM0bkJ1YVEycVJiK3NXcVR5TEZnOFZzMlQ4cGZiWHdxeUZZOHVT?=
 =?utf-8?B?SXgxVmVHRW0xaCt2SEZyUVpXMGd5L0doSlJKaWU1dHRDYTBLdmJvR3gxYTNx?=
 =?utf-8?B?L2RYOTRpUUVkM2dqelc5aHhBWUxNSUYzb2xuZ0dRcDhoamlRMForNjlhc010?=
 =?utf-8?B?R01BNVN2LzR3TkdqWnRNanQzbXNEMnEyQUoxWFR3R1QrOW9LaGpYT0hrakVN?=
 =?utf-8?B?a2c1d2JKOVk3YVF4QmpWQXZYRE93Z2JPdWZ3ZTkwcFZDVXl0K0RFUENoRm11?=
 =?utf-8?B?ZC9FdnVSa0ovelBQT2FvUW5rU05mbEhjUExadHErUjV2T2Z0NXFvZ2tnUTVj?=
 =?utf-8?Q?svKkTASa/5eDCymM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39910a20-0daf-41b0-0342-08de93b149f7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 07:51:19.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHOj8JYlYqoz28UM6SHdiUtXX07UIEv7aHadCt/mLAe+A6JiDgUCDS7himhjjgGhs246hV6qhFHVMRZLccUCXCpOCPMI4bbET1E4XIp80yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7339-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04A333A214D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/2026 3:58 PM, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 

Hello Marc,

I was wondering if you had a chance to look at v4 of this series.
I've integrated all your suggestions from v3. Please let me know if you
see any further issues.

Best Regards,
Ciprian

> This patch series adds FlexCAN support for the NXP S32N79 SoC.
> 
> The S32N79 is an automotive-grade processor from NXP with multiple
> FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
> other SoCs in the interrupt routing - it uses two separate interrupt
> lines:
>    - one interrupt for mailboxes 0-127
>    - one interrupt for bus error detection and device state changes
> 
> The CAN controllers are connected through an irqsteer interrupt
> controller in the RCU (Resource Control Unit) domain.
> 
> This series:
>    1. Splits flexcan_irq() into dedicated handlers for multi-IRQ platforms
>    2. Adds dt-bindings documentation for S32N79 FlexCAN
>    3. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
>       configuration
>    4. Adds S32N79 device data and compatible string to the driver
>    5. Adds FlexCAN device tree nodes for S32N79 SoC
>    6. Enables FlexCAN devices on the S32N79-RDB board
> 
> Tested on S32N79-RDB board with CAN and CAN FD communication.
> 
> v4 -> v3
> - flexcan_chip_interrupts_enable(): disable/enable all IRQ lines
>    (not just dev->irq) during IMASK register writes
> - Split rx/tx masks per mailbox IRQ line (struct flexcan_mb_irq) so
>    each handler on S32G2 only processes its own MB range
> - Added received Acked-by tag on DT bindings patch
> 
> v3 -> v2
> - Split flexcan_irq() into dedicated handlers (flexcan_irq_mb,
>    flexcan_irq_boff, flexcan_irq_berr) to fix duplicate event
>    processing when multiple IRQ lines run concurrently (new patch).
> - Added flexcan_irq_esr() handler composing state + berr for S32N79
> - Ordered quirks used by s32n devtype data by value.
> 
> v2 -> v1
> - Renamed FLEXCAN_QUIRK_NR_IRQ_2 to FLEXCAN_QUIRK_IRQ_BERR to better
> describe the actual hardware feature
> - Appended new quirk at the end
> - Switched from platform_get_irq to platform_get_irq_byname usage
> - Updated interrupt description in dt-bindings
> 
> Ciprian Marian Costea (8):
>    can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
>    can: flexcan: disable all IRQ lines in
>      flexcan_chip_interrupts_enable()
>    can: flexcan: split rx/tx masks per mailbox IRQ line
>    dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
>    can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
>    can: flexcan: add NXP S32N79 SoC support
>    arm64: dts: s32n79: add FlexCAN nodes
>    arm64: dts: s32n79: enable FlexCAN devices
> 
>   .../bindings/net/can/fsl,flexcan.yaml         |  30 ++-
>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  12 +
>   arch/arm64/boot/dts/freescale/s32n79.dtsi     |  50 ++++
>   drivers/net/can/flexcan/flexcan-core.c        | 249 +++++++++++++++---
>   drivers/net/can/flexcan/flexcan.h             |  12 +-
>   5 files changed, 316 insertions(+), 37 deletions(-)
> 


