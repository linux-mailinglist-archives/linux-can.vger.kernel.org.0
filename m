Return-Path: <linux-can+bounces-7257-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPqWDBg+xWn88gQAu9opvQ
	(envelope-from <linux-can+bounces-7257-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:09:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A293D33691F
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1650530A6903
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C2931D72E;
	Thu, 26 Mar 2026 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QavyOBxZ"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9431AA94;
	Thu, 26 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533524; cv=fail; b=KsyPIfXkadv8M/PmCQUA0kQOxohzENun2R6JSRawWnY1lXtzY6SxizKL7/r+lnCLPtunL7hG02z3lsUJYN3e2Yq/Qcb5vLE/9zeDlvSs7W+54gN0uOcMOLP3UUAXeKCYF5FPE34QiiuB9U/VyrMhIHzQhLZFlDrSdb3bmJ2wmek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533524; c=relaxed/simple;
	bh=D1Xd1s7YrEqbtvlFTkhmj8SJVSWChuDXoZfzKtuxKH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlqG4AbJSF+KySapvwz0b4SuCayIJYUn6quhk7kG9PpTS8L6ZibvSW4FITOnOCTMGDqnMrf8TqXMjIVRElck0dVo7fuEs0cYgx+54WgBIam5TXK0Jq8Vb33/nZH6bLvIyhqYp9vx5ibxIdsO3puvRKg2Wlyi3HP4b7hyLWjK2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QavyOBxZ; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULgk9NVVH9RkQlsV2O8S9OereQ0PsayWb4i6AazQi3Iiq1SDPQfm41T13RLtTbk+Hr/Jb42p57RZvB7StaAGs2Hx1HcXQCQqUnXKJxybmEHBWCwPQrEi0OTZJ7BvqN//nDB9uufDOX4Af23A6J9AM35N8Bo2n5GvZTVw0jDgpXTf3pn8YT3WDYR3av9Cn1cJHXc0M7/K+ZrqgbmvrUO8xs/tRgNg9J8ZcrmHoEl6K21bKIN051PTwyeIq0rApofjWpdllambCLXcBTm39kelY4u84Wk3zwLLegCAw3ke1LIggaMV/2amftmNlug9a233WK2mUjV6lnmxOBpdprSBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O/zHz6VHNH2clBthNEnurAD46ZT8OtXUs1Vwyt3dZ8=;
 b=c7ATDMNSz68zdLLJEE9hzsfD9VoRYxS3FiOd+Jgf4Ayua4i9HQKJFD7TVpG19AVT0bas/dRfk7tqFnimSPXPg5XdFkLQeq/H6dIAuv4yAKk/dsQYqsdBHeqiveKkCQuV/Ce/GOaRZZlcP2d8eWCW+Ut6vYl1GbBrnEhBgRlEtnmFZfhTnaQ/PWqezivvYBkxY/pcC0AAM4MSPnQ39brJWVlyOzavTN+vUUlaymxyFOqjVw0rNt9xcf90XlJw+Nm9fmhDTy5HnTnf8Iv7E64H94yUJY/NZjkJo8FR9v91r9nnA4SXIbVylhC4l1UrZDhiMEZTw+YFkMXRg8G0dtBbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O/zHz6VHNH2clBthNEnurAD46ZT8OtXUs1Vwyt3dZ8=;
 b=QavyOBxZYQ8vSaVaU54OshtBOA0XKRGHPPvFnT8wAw9Oy6HkdRXS33k8yQHmKw1dHrXV9HZWfdi4A2fkL85KvCom5eeJFNlCSQXpnAqH1sTxmpl3FVlay/R274gzi8Io2zn6juYdJqdf0L4rBXsnP2D9nsB8JAYiCAqE7CM2ONtBVng1gl8gdOKKFaKqAO5rYyaALuQ8DT345da0HpB7fOWo3Xb5ErQcfkDB0KjCAuOyTEFTGuFuTpCW+4do5QwDQrMlaAKzDN2nHhvJ1Rdk0V/weySfEhIQoBOtjnZvTaABxvdGrEZUWgGvQILY6pZS7ZfjzmGzXKMI86cM9/qMJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:34 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:34 +0000
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
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 4/8] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Thu, 26 Mar 2026 14:58:21 +0100
Message-ID: <20260326135825.3428856-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0054.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::31) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: 7953dc97-9eaa-4f97-d010-08de8b3fc565
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	exMuKbgZHTiK64guBhDJdZmYmdjhlzyI7V8xdUuayczh1LWZeZYnGgsbUtV/rda/naveP9tY7bbTQXqslWSoTAW/1UeGLQ4ZsWn/H7Pu2ZhPplenW3UWOY0QfAr9xjeqolhy7dF2o7TjnKfyCqRTMn66auqo6qhq8ywCG3IoBWoPvRq+3fD5vQ/BFKrI35fd0zSwCAz29nUxG9WfK4GoNLtHFn4A4nHFBLyEGvadBwnWlGQWkatSNkQrydWzHjwNkYxxzvyn9M+p77refTSkPZdRMjNUIW/pVblMyWJNMzbLrfVSilECGPs7Qvf9CCSGKwZnvaSo1riVq9msmQJwvxHRnbhWH/OLVnr7CWdC+rErkGFNwcCZjJyZbGJ4osjLeEodxApe3nE4lq7NpDHNM2Y2cobOeGj9feKyssW4PXwBmsmAQccy7RF5EE5gltAp2w+dWN8wPzP6X1eyu4evFGI5NrHmef+HUTbTGN7Rs3S0lG1WpXZWKvW2biSXRZMeWkyosm8M56qpqZk0D+nVyG49XhJooyy8YKwLFq3miPysszxFJlUvUDmTx1MuIVUVWLu+224lardAlHnfHy1IpGOaoQtsk+x1pvqIKg8YwbSDc23Gig4B04LZCInWNZ3u9JtDtcZMg1qdVXXm2P3oCYbKdvsirYL6OzBwaOccSPTy6sJ1qxuAu+EFRczv1LJSF2BR3cM5hX4fY43aSidOXqSxdPhLFhXixjye2M1AcSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHR2RldxNU42NUhWdnI0bGg5MXpTOXg3eXdoRFRQVEh1Sm50RFRzOCtOOXBs?=
 =?utf-8?B?dmFXZ2hTSVdnTXNVT1d0Z2N4UjIwRS85c0pUQUZGaG5nM0dJSFcyMXI5dGQ1?=
 =?utf-8?B?Z0pncXJzTkNGR0QrN1p4Z3JzaG81Y2dxNGt2WjMwYW9ETjRKaHgweFlkYVZL?=
 =?utf-8?B?T2J2bG1XZmx4bDVLdVNZVTZEdmE1aGxwRE9VejkveS82bXpzQ3oxUGFKVVZS?=
 =?utf-8?B?TG9CWEx1WTFwVnoxODUxcjVhdGErN09vb0s2R0lRcERGQ2ZaT3daY09wZzVH?=
 =?utf-8?B?Qjd2bDBnTXhCYzBTVGpnVkRka1pRT1lVWlpXY2d5WXVyRXBVR0FWUC8wRDNo?=
 =?utf-8?B?WU16YWhKc0tVZU1qeHN4M0pnTjA0S0lPSytTQmtwbER5Z3g5VXo4YjY5ajBS?=
 =?utf-8?B?TDBmNjJQYm5vR3lkUjJxdURaQTEyeVZIYTExT2ZqQ1BnU1VjZTVFTUdTNUFz?=
 =?utf-8?B?OG9URkF0bjJBVXE4SWpQZGkxNi9iVkhtRnZBNjdvRXFCazNQRzVMY0gxWDB5?=
 =?utf-8?B?ejZqYkkzK2daVFJKRzd2c3FKbVdsVlZlQjdUVENVSFZwTG9PZ0trODl6cWpK?=
 =?utf-8?B?ZlB6bTZGdkhjUExScUpjLytKc3RCK1J4Qkg1K0Rzd2VZVVFOZTV6S21ZYWVM?=
 =?utf-8?B?UUZQSnJYaDdTSmNWYUJpT3E4Z3p5emhldG9hT1ZsdUc1Q05JRXhPeHJCVUVM?=
 =?utf-8?B?VEtJc3BaTXYwZFBsTmh4djVRM2tZVFNMMk56V01mQXY5V25WaERodjF5QWRt?=
 =?utf-8?B?dHgxaWlPbnZzSmhOWFVmdVVwVWF0NXZlOEpFVzBuQVJHdktMS0RkQlRXOXQx?=
 =?utf-8?B?eGsrMVZiZW5qcVZXOXYxZXIrbXl4a1FmQXh6TkhTZXo3WW96YzlTRWFZM1Nk?=
 =?utf-8?B?dGRySys5b0UvOHFCNlJPMTh1K2wwcW1XUDc5YmhUSGJLQzZvRm5iY1RJU3l3?=
 =?utf-8?B?bkVSS2x2WS9XQTJGbHA5YzdvTmlrRnBjQml6bGVjZlZxQUdIK3dXYmNNaFI2?=
 =?utf-8?B?R2ZKYlpqQzU0dDAxZEVvaUV2N2hyVWlENU5Bc1FSNFJndWZzS1N1SWYzSkxN?=
 =?utf-8?B?OFdaREhsODRjU010WHRtV0NCTlpyMkV2Z3pidm02cjR0YzVZMEd4Rnh0Zm05?=
 =?utf-8?B?T1ZYd0c3YlFoYXBEK09qRDg2WXVkUTFNMUVUNmpzZDBYcjcrSlpSelEvU1hq?=
 =?utf-8?B?Rjhib2xQVHYvOFpEWnNCeEtkUTZuaDJTT1piM0Nubk1JSjU0ejhSbHJzdlI5?=
 =?utf-8?B?QVJHcWdrVVZOK1pzajN6bjFQYWFFRlBEZzF5c0QvWWdJenhOcVJtTnVJY0pu?=
 =?utf-8?B?MEFOTHpXcTVya3ZGSTZQb2xXWVAxeXFXc01mRXl3dEk5dFZOcm1EbWhNV1hE?=
 =?utf-8?B?QXZrM2phNTFBWnhhSVdhUER0ZUNPcnZxS0lOUzVqbVBzV0hva0tMSzBzUFJt?=
 =?utf-8?B?bTEramJxblAvZkZpek50dlhpTnBSWGVCWWNmU2pxNVE3djl3WDMreWg4RTdE?=
 =?utf-8?B?bkNuUC94NDhjUHpzM216ekhrY0ZVSElZRTBPaW9rUWdyQTFVYXFtTzZjZmV5?=
 =?utf-8?B?cFU5WXhacGkyM3h5UzYvTzVReklBczNoV0cyc25IQWVyQSsycytXb1l1MVFa?=
 =?utf-8?B?b3pISFMxQmhmRDRqT251alU3MktscnptaGh0QmZLcFZSRVo1bnp2RVJBaFNt?=
 =?utf-8?B?Y1B3QWRYNStkZ2h2NWIwdFN6L0s5a1U2OFZhM29mWUliWHFrZ0oyNmdQYkpF?=
 =?utf-8?B?TmpBSUs5ZGovZHdoQ096bytmV2c2VlA1SnF4UEYramUvZE9oRndZYmxtemJ0?=
 =?utf-8?B?bC9QOFc4YkN4VU5KODhRV0MrL3VxWkxHTldPclhsbFRMZXc3NWgwVE1VVFZ5?=
 =?utf-8?B?UnJkUlBhRmh2Z1BaeU5SN1BpbHRuRE5sY3BJa0VjeWZrSkJBWWt4Q25rN21I?=
 =?utf-8?B?cHhSODJjbTVBMlVRbEVRQ2NMd20rZXQzeWx1RWNXdVdSdHFteGZQNVI1MkNm?=
 =?utf-8?B?Z2FEU0xKNTBZQSthdElNb0R5V2MzQTZqQmh2Rit4VlFKWTYvZ1JxNnNiQlhk?=
 =?utf-8?B?STBpM2VpQ3R2QnhoUFRRUHVrZ1kyMGxIS0VCelBTYnRzR01qRzJIMmlNVmJn?=
 =?utf-8?B?anNCaVI3cE1sM2JEczRDQWFqaEhsYXBQeVY4cEwrbk95Q2p5TTlQUHN1bFV3?=
 =?utf-8?B?cmovS29kM2U3bXROc3hxSTNWK1hkWDdpaS9zMkZ5VXpmZ0pvbmZsWmRaNERC?=
 =?utf-8?B?emEvdTdaVGdYN2xjNnBNU2lFdFZlVHlDT0hST2c2SW14cHlyVXlxTlpTZUlO?=
 =?utf-8?B?cm5qY2RzcE10ck9USzVtWHR1REdsa0JFSElrT0lLQWRCTGtOVHhqL2owSUFM?=
 =?utf-8?Q?TzD3mbug+TLpRN3I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7953dc97-9eaa-4f97-d010-08de8b3fc565
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:34.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HjliHKdpmFv5h5f2urd7bYLqMrZ5/5O02p9vG3SYa8AuI80VeFPe9U/ov5rirJQLgpsQOzgy/NiXq/NZ/Pt3uCmitxQ2ZSdTN/QNo3PDy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7257-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:mid,nxp.com:email,microchip.com:email]
X-Rspamd-Queue-Id: A293D33691F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add NXP S32N79 SoC compatible string and interrupt properties.

On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
bus errors and device state changes.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f81d56f7c12a..d098a44c2b9c 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -26,6 +26,7 @@ properties:
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
           - nxp,s32g2-flexcan
+          - nxp,s32n79-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -173,11 +174,38 @@ allOf:
             - const: mb-1
       required:
         - interrupt-names
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32n79-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-127
+            - description: Bus Error and Device state change interrupt
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: berr
+      required:
+        - interrupt-names
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nxp,s32g2-flexcan
+                - nxp,s32n79-flexcan
+    then:
       properties:
         interrupts:
           maxItems: 1
         interrupt-names: false
+
   - if:
       required:
         - xceiver-supply
-- 
2.43.0


