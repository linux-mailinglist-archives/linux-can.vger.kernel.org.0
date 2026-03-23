Return-Path: <linux-can+bounces-7224-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIqhBlVKwWlbSAQAu9opvQ
	(envelope-from <linux-can+bounces-7224-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:12:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2212F3F8C
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DFE31497BB
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C034D3B389B;
	Mon, 23 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U6B/Q0+M"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910F1A6815;
	Mon, 23 Mar 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274323; cv=fail; b=qC70Zy/jMt2eARmK03QJ6a12mtbQ8ow7oQVyOmDgbfeNPtGcZmQdpRGdtA/SJhtO+hDbQd4EwkmydQanu7dsYvq6IH0NIpHV0N2qC/hCfRwNyN1uo4HOKrgmM5N/2s4wqnghct5k9zJX6kmF42aoAwrL5of5eAA2kBT2/e5qDKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274323; c=relaxed/simple;
	bh=l06LRpNDfwcUc37ePQQxThusnRZOKpRfcjHxYPjciUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+i8rTStdlLgLJPcHMcOPtOjfuE+7m6HcOHv80l58LANZ9Vag19KROXdkfm5KWhUeSrdjHgsVON1D7sRcPSzoGxg0A1xYNpVRypmbXqlu3eo0GZ8texDlBG7mi4wjSbRM1pnl6l/cDUp53Hb1J+Ivy/m4hgAIMPmsisB4J7JkEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U6B/Q0+M; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B418SkfC6wv9dchAl9Fn1WIdeQHFIqx+fAeOdg0+IC2+tcUO4bI9XmmdgCe5i44tQoIs0Lsb9zBd4NmTuNLe7wofzPyI/gWxqF6MQax3S1JQcFsF/Tz1IUEGE4zOTGB+1WzLi9rh1FIQ0kkM+MC9YImJZK6inmUckzRCy3fSItbXctFkdDLVdzgiazaDrrlnjsTAk2RY7ex0TTyDTQHwZ+xQ1r5hUEEEoGbrjbcxkACAjOC8hQJpwMtx2fD9piv71mfa1N71eqCh2mwGFMnUhqFvw63QFSLcHQA0E+8dm4HZI0tJXEwaswC1DdQMD7Kh+x3PB4/9a8qTJpbJO9ME3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxWLzPP+st7cpt1jNrG1ud3AUG56aWUmdRn1tG/gqLU=;
 b=xKZaVuGcZvaDmDw4uX5VNcctDPvWOxJL+UhzLCCrLbbQuSc4HiVd6qZBGIYKp3CW/v9yzA7k+FI54L8ZJ7sfFikw1+ySY3LfyglqCiGhN0sJH18nZvz04hqdugFbbZ3cNqG5qHV7REj/GsBpQpQGQKysKBI/6FyhdHrJLdHIFNiHFjckMqC1loSAEHHWDLXbjO18Wbf2MjbZVwMo75R/3Hbr341emijGA/8SHs9ObMms+/JkMgx9G7uZDQpEcy3Rpr2TMtCeB06rhX7d3TyHkAZQcX8nvqgV9goAUGJ/ybKz91tIEnzYIhxe3twq2GsAcORoyqV0RXBByFwu0rAUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxWLzPP+st7cpt1jNrG1ud3AUG56aWUmdRn1tG/gqLU=;
 b=U6B/Q0+MKvsS+p6HSO7GtqSFNOml43duV/FpXTT8uyZE8QPpe3ej5cZIaRDHQaGS2bIJ8vh4jpnOKn36z1PkLGStuUPI4tBnHeEOJeqRbIFhTBuTZy6dZShjy7zxlY8zhcwCDNTQnLdASKLxPYWD7O1bnF+Ynf9sqFZrHcVK1j4xjfbAPJ1pwHSB63TtT2C5cFOGgLkFkO9LTcI4q4HAAq808YXm8hN3Iujlt7uvu7NrNDRyD3SrcZfaqj+O3TYUOccbGTsNi6dbpE+jnz0JPaY1k2hQ0+LrQnCMU2i+fOQAspDKlx2I0CWzg9Kq5M44YznDUSm/k/DPvAGg5oYqaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8354.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 13:58:27 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 13:58:26 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v3 3/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Mon, 23 Mar 2026 14:58:24 +0100
Message-ID: <20260323135827.2129371-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
References: <20260323135827.2129371-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0056.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::27) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 691974d0-00d7-4257-58be-08de88e44135
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7TqWvyLhM9D2OLokF9iBxa16gnPxq7/pqJzQ56fSywMeUMpWaUku1q8QPdJbEBta8hMHHYXFiKC0H8oKAEIdHMHVvBx+6RsIwhNMgsACIqDJSKJRdegOYbij/RaPldj32O5InDpMlcoXW+LL1Abl2oys/COKGpBPJ17q/Ql5BDPVHd39dFa2aQSxBmazBpuQUYvNWg9d+lr7Bf4EIJV0wLZ3ElMqxcmQuNEs6Mb5BVp/ss6UJnrVisfarBxcWMi17lOTPaHaZBHXAeuEAkRddYPOQkhfijUtZmHVp4fA+8t05PyiYsXd93pKnum2ZRL8Dp/6X+z0UGkowcV96unoGeyc8iysjEnZkwltbWYh5SoaOr5AZBuJLb4DNAMLHXcxlswMUwj4mWju3COA6FADTJW+KeqlD9lWV/0dysclxS1Z7YvWD2U5/YzTsDw/+uBImJcbe/JgKM3rMiSuCnZDYp1WGtdjLpgcnmWTpAbbYWBGKL8U+vEwY82ycsbkiKJqqXRIsuDcBU7R50Sjqm8t8vGn1dWo0wISHLdMH306Sop2XVKblQh0u9u2ioJGmIgdfqN4OTSHw8PBgXRKmDHFCi+NzPzvRnWBR7XnSz4qYQzZ+hyeWtUQGSdJFtz7QotK+NpSs9okRtHftuLJ5zLC7mk/eZ8UOncT5gig+5/m68f0T0UIwPhFnkqiFmf+oFHhDTi5bJg2JhN4DNjwMeBSNSBQyd/oGRUZjRmXxDL8kUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yyt0dXA1SU1QRURFZmp6ZTRSTTd1RFQ1d2tOOG9WTEN5WGZtQlRvZDVrOXZS?=
 =?utf-8?B?SzNrMzRGaE1JelpEVFlOczd5alBFWGV2T2JXSjdvRjhmZWxFMk1taWNsRE9S?=
 =?utf-8?B?UEphenI0aWtSQjljOGp1RzZ2WWg3aWFacVFvZVN3ZHBVUXFnV1I0anUzQzNp?=
 =?utf-8?B?c3ZoTVNkbStNbVh6Tkd5WWFDZFJ5bjhhc201L09oSDdrWnR6aCtWcmV0L0Ry?=
 =?utf-8?B?OUk3NGN2blhWMUdSU0VVdG1hZnRmSFlMWGxrRDJvdjNnZ2NJdTRydE1NT0Rq?=
 =?utf-8?B?UityTjdPOTB6NUZZRkthcDgva1grdDU4RC95SkJ5cGhpanJLb25qd2lwa0Fq?=
 =?utf-8?B?MmsrMVIwbjl2WFhpekdvajlYV1kwdksvNnFFN2FCSmwydUdyakMzOXAyU3NF?=
 =?utf-8?B?Y0VmKy9IQiszV0tGRnI5dExBd0lxY2pKVUFwR3lVMmUrYmxFcHhkWWZ5aXdy?=
 =?utf-8?B?OFVZSU9xNDlLVVJUd0xocVZpcmh2WFQ5RFh6RlpISjVWeWtWRkZkN0doMUlL?=
 =?utf-8?B?WWhjd2wrTTU3Z0ZOVW5aK2lkQi9IVmQ0UGJKMHdJNEtESFQ3aDBEVGhub1dN?=
 =?utf-8?B?dGRYRnRiV3VreVRRMG5ta1BJRGJvYnVScVFWV2J4UUZVcDhaVEJPeThnQ1Vx?=
 =?utf-8?B?YkFldlZtTXNBVUNUNFFLU0NRaTNERCt6MmtENmswb2xWRVp0ajh0N2crRFJP?=
 =?utf-8?B?Z2NFU1o3anUwdHEzVGhCcDBidVpRZWtnT3BKWjFGeVhRR0N6TnZGS0VXQmdu?=
 =?utf-8?B?RTB6ZTRVQlUvQlhtV1ZYcWRRWkllOEpWUm1pN1ZaWlBzbE5LVjNxS2FRazJR?=
 =?utf-8?B?OTJCb3lQTXFFeFJKeUE5Mm9qVTF4cDlIb2JqYjVBbm5Hb05icGVzRzVMNDlK?=
 =?utf-8?B?TjRKMHFlanhuZEM0Zmd1WHM2U056c0RjNHR3Q3I3QTJRbEJlR1NTYm0veURW?=
 =?utf-8?B?Ym9LUy91djlQd3FENTZhRDU3Wk50RVp3ODVsWW15UVlrSTZiOG9TZ1k4QlpV?=
 =?utf-8?B?ZHpJWVdqcW11QkFMcGlXSG45VEdJWWNmTDc5Qmh2L3I4ZU80UHJyd3dxVUh5?=
 =?utf-8?B?R1lxcjV5RUtPK0YxMlQyTVNzMXNJbWxrNG9FdTkySVBEWDRVZ0lOVWR2Z0VL?=
 =?utf-8?B?cGFYVE5aUmJPUXRjYUpCb3lxaEUydGJaMkE4Y1NnUW9YY081eUFuNDdTQnFq?=
 =?utf-8?B?eHhmaHhBTEVjUWt4QStnUmhYSUkxODZhRHRQWEJxVURyZEdmZnQrMTVnUFk2?=
 =?utf-8?B?U21uQ0lwT2dtNlVobndidWVGOTdPdldrbTRCNnZNMll1cFdORzFhV3ZvaEVV?=
 =?utf-8?B?TzA0NkVSNlZUSjBmT0t1V1BRUlUwN1ZBdnU3TlY5a1daUXYrcWoxT3ZJL2hE?=
 =?utf-8?B?QXVNcEo2LzhwVitERTN4T0tRdHBSVmhERFZXQlJMVC82U09QSlRLSDJkVjJV?=
 =?utf-8?B?TmVsS0ZRaTRYTzhOVjhTVXhISTVDeVdWK0c5a3VUTmR0Y1F0RVplZVVMdDlZ?=
 =?utf-8?B?UHRzdkwzV2I3ZlY4L2REanZ4YTZGSWNOQkt6L3RHL0pRbjExVWcwY2RCUi9U?=
 =?utf-8?B?UFNDUHB3b29NMWh1UGxsUjRFQkZaa0FEVllNNW8wRXN4d202VDh5aVNjOXJK?=
 =?utf-8?B?dW9HVC9oNmZwYXNkODRlbHdzRUk5eVBmelZHZkNwajBNVTIzWE9rSDR4R0kr?=
 =?utf-8?B?Vm9sZnI0eDF6SmQwaGgvOTJ0bmR5V1V6Snh3dU1mY2FjUFE5ejc2MjdXK3pD?=
 =?utf-8?B?MWZWcGxZaExieWRjTW50UHlGT09zVDNDSlFPYkdrZGwrZmF0NU5Oc1hDNTB1?=
 =?utf-8?B?bFZ6cnhSa0FWaHJ4S242MnNCTzI5NVV5U0tiT1dBamF3RXlwZUpGTUFJT2hS?=
 =?utf-8?B?eXB1dk93QStJRWxabEZzTEJOSXpEVUlna2l0eTZPWjFwK3QySSt6T2c3Q2NY?=
 =?utf-8?B?SXVJUTU3dUNPQlU4MzhYaUpxS2dPNGd4dG12NkU4SzJjL29vQlVqT0JwUVQ3?=
 =?utf-8?B?dStNWjNTMDQ5bjRFa0RRemJvVGc5Y3grbmYyc0dxdUorSFlxb2pYQ0o2bzNR?=
 =?utf-8?B?R0pYTmg1amR3NXU4R3BKSURMcU93Y09iRXo2anRPTzF4L1lKYzZBcDgzQklV?=
 =?utf-8?B?ZmltbVllZ1Y5VWxyRjJHK3g0dzFFQTlKZDVuS21jc0l3RjFIMU1UMDB2cGdC?=
 =?utf-8?B?cXovclZ0V1Q4cG95d2RHNGpsbkhpSHhDQTJMeHQyOGxPQTVUYkVabWppV3I4?=
 =?utf-8?B?eStGUHh6aDRpa0ppeXdsWklDOG1iRUxDWHNDQktJMGtCSjFGYXNqYlFCd05v?=
 =?utf-8?B?M0s1MHpCQUFzN3l3QlpFMnpMUkUzTnMxWUQ3UzFXaXVPK0xoVzFMREpkNDZ3?=
 =?utf-8?Q?j1mPvnncnmxJCxto=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691974d0-00d7-4257-58be-08de88e44135
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:58:26.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmOYZAkfXSzxRxDaZqBeFFvKnUD9brqruhmWD7o3a2bzbFSI6eO0tAHKpUkRVuKnuVlwQB/kTPW6wP25BGOSnFwwS1OYEWZMJGhT3rB4jNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8354
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7224-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 6F2212F3F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes.

This adds the flexcan_irq_esr() handler which composes
flexcan_do_state() and flexcan_do_berr() to handle platforms where
these events share a single IRQ line.

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 44 +++++++++++++++++++++++---
 drivers/net/can/flexcan/flexcan.h      |  2 ++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index da712972d5de..51f60bbf25fa 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1283,6 +1283,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
 	return handled;
 }
 
+/* Combined bus error and state change IRQ handler */
+static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
 static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1850,7 +1866,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1871,6 +1888,13 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		err = request_irq(priv->irq_err,
+				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
 				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
@@ -1885,7 +1909,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1917,10 +1942,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2307,12 +2334,21 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		priv->irq_err = platform_get_irq_byname(pdev, "berr");
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
 			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
+
 		priv->irq_err = platform_get_irq(pdev, 2);
 		if (priv->irq_err < 0) {
 			err = priv->irq_err;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 16692a2502eb..bbb1a8dd4777 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.43.0


