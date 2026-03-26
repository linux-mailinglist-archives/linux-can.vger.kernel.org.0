Return-Path: <linux-can+bounces-7255-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFK2HbM9xWn/8AQAu9opvQ
	(envelope-from <linux-can+bounces-7255-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:07:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893C33687C
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF97F3087E85
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15A3101B2;
	Thu, 26 Mar 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BNl49hm9"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4730DD1E;
	Thu, 26 Mar 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533519; cv=fail; b=bsaoOdf1lGhC6avOsYwA/K4I0RyOgJ5tSKQwNxiGhRsxfdDLTCyVoghx53daJUSlIq0YrmTncBrbSo9DSNRwEGRKaKK1od+xm7SRLSJTAL+GqDTHG04njfU0Cq1dRimfmewP8aOtRyVHXsDBzrjElFTaXAcROeJ7WuKaz/AuR+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533519; c=relaxed/simple;
	bh=8EOsHs7J6ANm39x00dNUt4uy33ChTfGHoogRmHAEvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJ3oFSqOV/N7fPQ58LfbqzU9BZ7KIG8S7/GN3E7ZGu4SByNwo6hBex3GAoa/AzT0dGCKS0agcGt1U8m70JP5a36GyHSyGn6bCDCirFsI2NehR7J2Va0hDAIU0ZdCmcJfMZnqt2hHa8wO8sD9SXOv73qpPyMH526/HYO7pb113Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BNl49hm9; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7uUFuAj0Ndyrwe6aJJHLATbIQwRggIB0XJKeZX8ta2sSvntFbCTJ8lXmD8bH3E+BnwmfhiR1D3UA6q31cnghXXN7Rz9U1ZWK+HYk2hmL2FAw9MJJZPZZLEOsI5bpA4DYvqPLqFDMTIiHVmiMVDe2K6XC9O5HVsmfZZ86w3HBAIaTgP5egKfKRFk4HEKrOkUmq0q9sRuXVUNBnVh3TQc5/LnQxXgInw2b+hvUt3E0E1kciNd1NLyp0NtLUuHBd175hfhSyniNJzw/5iKd5SLUGFQXTig4jE9rgJg0CE3vRrMWs1dgefidxyiy2Xy9lEzLg6IdGH9tndT3tuiucuztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY/iIRo27uKIqzkg/Rz5IhDiJmPYK8ia9+8E4UiWGlk=;
 b=OnbH8m3vr7OsQ/hfsB/zxoeHb40UqJaLqE6DcXHly+UV3H3wZ46iYGM1WtkfgPSxVDFL9dCCMRmzXHp2wCC5/8jyQ8vvrhJ2S+o0tYiA2yZQt2YuULnRFRYZaPpfHtr/VgVQDY6BxDeZNFgAdkBfS1PUkihR9S2s5jmDdp+eF+L37oMCR1mYuF/7OPgOzOUnaSrXBjhr87ZGpgjBm0ZGYvoG1iPjv/zW/YuH6vhAwy/zuf9361yjr+QsON2vEWMS2An3fcZR4ZL8ZZ7aAxAvyFIpxrvhavDneQgtOd64tzkuM3BIxxraYZPGiRtKPAnWxB/WlVn9YfMIEHKiUBug2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY/iIRo27uKIqzkg/Rz5IhDiJmPYK8ia9+8E4UiWGlk=;
 b=BNl49hm9TuUevmUAllPx/u534yB2yAUzitdw+3Kq66gUlG0KcVs5MbSD+TM4kqnZoUf3hxOSa8A1zXmyzU7LkCcNiWfqoMA/oLYyOjb8+O1M+521WBktei+DaYsA/1xQhGNPCLATITtUh+2jI19Hytgy/55rgMZg+qPaOsZriAyizI+nnHq+kq0JeoowBKOlRaQg/JeVk2WNyRoyMee9PvSuvtNjyWKdmE8P4U5U//AvfpHxMzO11ZdIMMlDfMh37OsxknNtKXlwqGrxN31/e1uYI7zAeQw9Hc2CGOSebsRZU1Hd4ipvrKi+Ghw3vFSsk68FesWVLdr/oisXZxyzUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:31 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:31 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 2/8] can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()
Date: Thu, 26 Mar 2026 14:58:19 +0100
Message-ID: <20260326135825.3428856-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 7f737a01-3778-4ec1-4df1-08de8b3fc39f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+xTrIPtGfdwJoj1Hc4ohs234x3pZF+2s+7W8ulTGLJlq9QC+Q4bGbd3fMq3he90kP+g8IqR0/69vY6ZdN7G+6rjSTqKFV7QLZh992cMy4B6xWVGBKR1kjuPQkthC8/A7i79a5jjANw8PNCmfoYEMiQd19lHYqcRbOJs/5nir+m2LxewLn72O9YBPk4wyLmZtaN/lFMtsIqVAzOKctqlIyiUHvEKt0hSt8BHZRKjaex/tFmj1HBHM0uR5I3pXyI2/BYBX5Auwo18F0trEvHg894x9YRVCiSEWi6Yo2kB4JnkhfQDB7EFDfERSR9ECSNmkJUbkstn9NvSYvcDYvzjzUpxV7M73+/pxU2Lr3iPUEIvUvAudbe2VvgNxOIaK8ZyeX7ykb4lNB9KalFDHIGfwujwckz82Qhuz8U1QYIuArnUp4ak1h6NuNqNGpjDcScYLtyRWGVaovMk/tzu2+bvjDL2sm9qA8S0kfwpegHTB0U0RQfsMEBTOLl0UxgJC68d3VH5agUpVqVknZsUtCBsVcjuydVc0oMa8aPW4Lt5g5QVPNi8d8fDSsaaK2iJVmt+wfsuVBEu+marO8dTuirAdbwB0Ghp5eChJ03AMbwftbr2IQ92QUChX6Y4UACj83cHTkv/7jzvKl4Le1/MosOrM4bqQ1em2taGdV1EvcZ8fli0qRF/6wfysePRa9r1C667Gh3NfchWXEYvNrkSwP2M4HlGogDN++AQ1ANuQvu66o2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUhwdUV1ajJTcHRJUkExT1BLa1oxelBDdTE1TXNPMkl1WEc1UkVKOGZ1Ympt?=
 =?utf-8?B?ejJuK2Jhd3FZaHF1UW1SYWFMY0hJTWFoOUJuWEpCeTR3VUxtZzFac1YxSHRY?=
 =?utf-8?B?ZDEreE5YYWtJVXQwZ0lGZEtLcDhJZjlsYldKY1FkSHp3ZjNLd0hKL3UyTmt5?=
 =?utf-8?B?ZDZZSHNzWmxTK2dLVkhpK2pzT1RoMVVoZTlyL280cnQvV1BBUUpCcDg0UDJu?=
 =?utf-8?B?Y1dqalMyTjV4NnBiUlM3SFhwd25HUUhvTVdHVUhjUmR1ZVZ2Yng0YVJxbjla?=
 =?utf-8?B?RjlHTTVyQjZtY0F2TU9RMnBMRnV1YlQ0VzlibTBpMzZEUnI0ZGF1Ti82OFp0?=
 =?utf-8?B?Vy9ZcHkzL3hnT1dQcFhuRDVwSWZtVlRWZ2MzUnk3TGhUZDFOWnNlQjMzTjBx?=
 =?utf-8?B?cXk3YTUvcFZGUzlPRGpndkhRWXVBbWhkaG5DVlRXb3NsV09ZbzZZc2twdU1z?=
 =?utf-8?B?a3J0VjM0VE13VTE1UmhpQ3NISjQ3d2JDZTdFQ0h6WGo2SmhaK3dFeUg5cGkr?=
 =?utf-8?B?a2dOYjZTUFROb3BFYXMwS1F2T2dMTHFyaXZDV2FCd2Q1R2dDUllhZVFuaVkz?=
 =?utf-8?B?YXIySGthOWY1Ym1sRitoOFdoVm9wUU9RVktUTFJqUXVTSFVlaGcxbnJDazlm?=
 =?utf-8?B?R2M5bFA5MCszOVNLU2s5K3QxSGIwcndMa21teTVVOUhWTkEva2F6Wm42eFRV?=
 =?utf-8?B?ZmkvT0dIanNEWnBGMzVSY2lxN0ViZnhJVW1NNnZ6VkN2bkVvREVGWVlQSmxJ?=
 =?utf-8?B?UkYwRGVxMUZGZ09yODJ3TEtZZzN4Y2RsTW9hZWpPQk1xTkd0dStkODgrNXVY?=
 =?utf-8?B?SDVNakJpeWk1VVFIbzJGWjF1a3hPUlJqMjhSRm5NOW5ZVXVJU0I4YklVdW5D?=
 =?utf-8?B?M1J6S2QzWGw0SnRPbjFLTzhCeDhGTWYydFhveTdIM1FwZk92bVlSL2NFK0U2?=
 =?utf-8?B?NGExOU1YQjVROG1aNUhZTWxib0R2UzdmT3l5c2ZpT1pKS3YxVkczMTB6ZFRq?=
 =?utf-8?B?K2NTOW1Md0VlemllQ0VwTGVyYTZ3Lzh1ZExoNnR5b1k4VVFTTkk0WWJRV3lx?=
 =?utf-8?B?aldTUmRKMHlYQVpidEJmT0xubm5qdkJ6b3o2SVpSdmFVWWV5ZC84S2Zla0ZG?=
 =?utf-8?B?clBSVEh1dDFSQ1IrUU4wUHNxOVozQUgxS2JFVkFaQ0xVaXFOdnU3dGdtcy9C?=
 =?utf-8?B?YXBxY2p2RmgvbHl0aFc2Rkt4SS9ZTnVZT0Y3dlVnNGdvUGtFZjJNRTVXZ0tD?=
 =?utf-8?B?RUZwLzd6S25SKzJaa2JTajJyc0ptWWxlWGI5NjJnU1hVRElUdEpXcjAvQkNH?=
 =?utf-8?B?ODcrZHFENk9BWE9sUG5GV1BOcEpjUFBrbXVOME0vcG8wT0dqRldDTEw4c2hu?=
 =?utf-8?B?c3Z2ODI1VTY4cnd0NlFWMkwxcWhBSEdaZmUybXh0OXcyTld4ZnN5MkNTYWxD?=
 =?utf-8?B?V0V6YngvL3ZrOS9iVmxKVjVjTXZtekQyOG5Qc2U1dG5hVFc3aTBZbXdUL01C?=
 =?utf-8?B?VHA3NTQwcDNrUGVBWGNTakJmWVNYOWt6QU0rU0ZZMTU2bzN5VUpoUTdqdDhH?=
 =?utf-8?B?Y3FwUjJPeUJ6M2FTbmpFL0xqS056Um42ckoxdm8rNkl3YXpmLzRlNC9BY1dY?=
 =?utf-8?B?VythYkpCVHJ5U2huRWlrRUpyb3hudzQxUG9mU2ZSc0pMbm5DcEQyejRXYUdi?=
 =?utf-8?B?Znd3OVg2NzQ5NTFIbnRBYlNYbWRCc1d5bXhXWWNndlFOTk55WDFCUEI4ZUR1?=
 =?utf-8?B?QWpzcDRwZXRaaE5PZVFjdHk1STlpajhtTldkUzZGejA5VGFxMVQvNk1Ud01y?=
 =?utf-8?B?UVN6dVNKTUdUd3NEaXBKMUs1N3RXTkdRSTBHZUdzTE0yZXdXSkNyS2ZrbStS?=
 =?utf-8?B?eXFOMFFPYUI5UmZjMGE1ZzBraU5pWWRLdngzUElSQWxpN3d1M3NBTURiUmcy?=
 =?utf-8?B?SmlnYnBUL0k4ek5yUDFGSG1Pc2ZPUU9JMzhnMWpSTWlXYS85ZThuVUphNGlH?=
 =?utf-8?B?NnZjNndsYzRuc2VNaytxUGxtNmVJRWdnQTZIdnBTYWRocmNsYzAvZXIxdVlM?=
 =?utf-8?B?aGJvWmpHOU56UWs2OXhlamdkREptOEhtQUFuTHVvOGhYTTQ2cTQvUXNqdVR1?=
 =?utf-8?B?ck50bGRITUpBdTFSOW45M2EzWG1seUs3b3FKMkVRWWtCQytHVE5OdEhka0xG?=
 =?utf-8?B?WWRIS3BUam9PdmdFaFp3NzhDNXYxbXVpejlKNGwxWVpnd0hWSzVxcXhNSHc5?=
 =?utf-8?B?Z0U5VUR2VVJ4OVorcU9SS2Zhb1lhYmpnazA3d1JncWNoWFRkQzlCbnlhc0hi?=
 =?utf-8?B?ZFI1Um1mc1g2b1R3UTJ2UWpLTk00OGtjNlMyS2dZQWZuN0cwU2d5VGZyMHRE?=
 =?utf-8?Q?s1KOtSFly3bCPWdk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f737a01-3778-4ec1-4df1-08de8b3fc39f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:31.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFFV8A9/XZBFhjOjljiDFF0y5oFooMleGfqCxIwCt+11UopMTnlFC8hfYNRBobXomIFR57xP3XJlEzyPLcG1OPY2mGKGzNxv38LsVxAb2NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-7255-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.nxp.com:mid]
X-Rspamd-Queue-Id: 3893C33687C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
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


