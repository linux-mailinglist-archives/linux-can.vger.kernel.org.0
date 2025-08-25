Return-Path: <linux-can+bounces-4348-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFBB339A1
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D4917EA02
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267802C178D;
	Mon, 25 Aug 2025 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OpUE3E8O"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781F2BE03B;
	Mon, 25 Aug 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111049; cv=fail; b=m5o4k4sqJ0bFGORQv6Xs5f+tNZhKv0ODmxVDg4NdVnqyybHOPL+HFIta7wxiR6gMYXsQvjF2DWuvYGcla8Ccch7wJCMnP2mZz08jKSSNnoq2vk2/OMRnQl2UvUHesV+t72Epphy4OzQeMSBIwaL7/AtoQRPg7dramvl4TeXmfKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111049; c=relaxed/simple;
	bh=k5Hs+Amecj6+QGD6PsQ/3cP5ltSqAIzRxVwJy7xq3no=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lQYML+PIjSAqeKPUgOb3qaXl24GVDLH5VkS4YBPP/BHxqxzu8/NYJYCDJWhBO0y32C99bHTo0Ojo+2Kl0ma6l73s0dq9oD9heGYACJPAzu1xIrPqdZUgw2pvAvstHNsVmUV6aMVYgocsWBpAKJaJcMoivtX7oeFt+ToGv/QLtq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OpUE3E8O; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh97Kb3O9HTmFxWndthHQdCgM33CPwdPrQAcc7ITOXQzMbcPtqosmyOVCnm4b0gcmS4fKUaWe7h2vn+pUHE+xvyLIRR+OsGZORGu/so0MZbEhZv2nicM4nV4qAf/RyaXZZQXuwKGIGhYY1RPzxLK7qRTH5tU5zXV/WLLmh045ZuLvPnKi9VnJNoiT5QIr9HRJ6zxy1RDjuy/NNqTmkn7EYK0vQvyi6QV4Zd9OcCdR8jb6DjIbL2SMl3VZ5lJJzUDOOdJsVJJbc7ieXhEmePYRclCCoSy+jqLvxHpGcY5rq8BZUOWik6HxJyBnX2B0k4I9ah5B9cF4ihQead4QhqG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5cN7gkvweniinjHN5anjHUpjznyl5Q+q3xrkvpQDW8=;
 b=gYT92eT94f4Rd9y+s50CeYMNxk/AqT7atKNGCw01oNq/rr5/h5cLxVT01hFjmJb84TvGep/fIivGdlhdaaJPkKMhIkjD03OhyJdRmq/DnhUO9QQ8p1oEOglGs7Wjb5+xm9H1HsXYs75+sTbawn/l/pqHbv/z5fQ2axaG5Qcsuq1E5wwstJDHo17XwAUHDJN1RyDjMGFf6WAiAucjZ5NHZgf5O/uB5qN9sEx4UUrRInedxvNWRROswmONltqaHtBJXYE5re1AkTg2uD3Jfu9ZfCs1ZFra/WfUi8FNBb8fLmrmFpw6bgjpikBNwchRIM56y/VRjJHYRzdOSHkKGm/ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5cN7gkvweniinjHN5anjHUpjznyl5Q+q3xrkvpQDW8=;
 b=OpUE3E8OsfwyFkefbH03eUeZjbwxd/SBQaZbLSO7faS0Hg9zgLyNzHjNwzF8eQSfDgkRDTFqMbSH8TEvww2GbnaA3vffVZ3FCmRVVJzvS8wqMUjGQoc5sepv3DiLwVrGf1pIAG0+kkzN2z845LYibnBbeY+BVyzFLw++tt169mNRMus3bUHNp98OZDw+nvWtXPyJ+PgJMnE6TPE9r3t2qUw/sFzf62j9rvsm38oEcYYVBHUFx+IKeQ6FIzFRWGdNV9fy43mzggoj3BJGmz8qoa6SwRIHOaHVpBXxqN3jdoR8iyRZjED1IPp4CNncY91KDfMbdyACV9C44BLWDtmeCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 08:37:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:37:24 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 16:36:45 +0800
Subject: [PATCH v2 4/5] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-can-v2-4-c461e9fcbc14@nxp.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
In-Reply-To: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756111013; l=2793;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=k5Hs+Amecj6+QGD6PsQ/3cP5ltSqAIzRxVwJy7xq3no=;
 b=ui1hOdlC+T7MTv5vb8Ocuw8N5MuLbrWNYOgAht3tqaG6oTCmgf7sMi7FQWn3xfwLeBuhtDBl/
 Mtt8DGJouBQBrBfheVRU82vzhB9LbthptDwPlixc/DQ0U7T4zC2r0jo
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: b65c8ce1-66aa-43b8-e7f0-08dde3b29d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFgyTUszSmIrREttTzZmY0cvMzV2bUdLM1VHUlB2aVdZSG9uSHBCL1U5Rnor?=
 =?utf-8?B?MHREeXRDV1I4dFNxS1V2bDRTK0VWWGZZQTRxWGkxRzBKdmRheGpBU3RheWNS?=
 =?utf-8?B?MHBlUE1Wa3RHWm13akJiL0ZYdkpka2l5UG1YTHFndlJBWEdsTzZwWFA3eEJv?=
 =?utf-8?B?U0kzTzlaUnpJK0VTeld1N05ydmdpNzQ2K2dObkhHaHdNUnJ4RlQvdFBIL29G?=
 =?utf-8?B?ZWswQjFKendOSmFtd1IwNm1QS1JPYnVIN1I0M1c1MlFlakRNRitpVlZoWHZK?=
 =?utf-8?B?a01HcDA1NUxSYWlZM2lGMlJxcHBKajFJazY4YWsrQTVTaXZ5MEdxei9qSGxQ?=
 =?utf-8?B?cXZablVOd2NYb1pRZ1dmTGFBQ3UxV1ViRDFzaCtLYk5vRDBtdXIxVC9ITXR1?=
 =?utf-8?B?bEx0SysxRit6eDA4bnJkN2hSM3gwS2RsRisxQTVTdkFRS2h0YnRibC9jbmtM?=
 =?utf-8?B?NldINk8xcGNuRmk3b0JhUXdPL1JHa2Y3OVF4OHZtTEJFTU9YbENZc2NuSnZt?=
 =?utf-8?B?NlpHTEtYM2RIOFZKdXE3N25hUVR4dGhtZ2ZQY3ZIRm16bUtvQmx1dllYU2xO?=
 =?utf-8?B?eWl4NGRwSGZCQkl0MlNKUkN2SXFSaldVSVZEU0ljNktHanF3WWgwNnlrbDBo?=
 =?utf-8?B?NmtOMkh1MEJNbkM3MHdGbVZFYmRRcG5RZEptYVhZTHlmelpab3U0UGQ5Umt1?=
 =?utf-8?B?L0JSKzNaeEtlQ1JjT01kL0daWVl2Um4yK0JjM2F6MVRRamFERUUyY3Y1NHVL?=
 =?utf-8?B?R1B0UkxvUHdySHZ6YTR0cXQ4R0R3d2RtRjlkNVRTbEoxRzVyckVDN1U5MEt0?=
 =?utf-8?B?MGl5SEE5VjV1L0pCRGEwei90VnIycTJUd2VpS3lJZlRGV2pNKzBpVG5lK1Ju?=
 =?utf-8?B?aVlkU0VlbjVKWmxESkhrTEFybEZEZjBYWmp5SWI0Q2lkdlcwUkozaEV1NTJk?=
 =?utf-8?B?VzdyWVJza3JCcG8zT1hGMXF4cjBkUy91Ky92K0V5OTg4YWxSTEdIL1hZcjRz?=
 =?utf-8?B?WW50U2tuamdRWDFKWlVzSURuQjZQQnpDaXh3SDZnNXIyeU9LWE9FakErUFNE?=
 =?utf-8?B?ZFlGTGFXNEwwZWIwaDExQ3B5ZG5mOW92T0h3ejVabTlpd3kwVnZoOW5FWUl6?=
 =?utf-8?B?a3Y0SFBjOS9RdytvWTV0Qk8zbWNBcjlmUEdOVnIvMWZJZTdpeGo3UGNTZDh6?=
 =?utf-8?B?Zml4d2R4UEtHcnJtd0dXc3B3UTBuZkRPZkx1Mm1PUXVydWI0V2ZtUU1hc00r?=
 =?utf-8?B?cllCZ1psejc5akZkWWVoeDNEblZvZFRNQ0JhelBoK2thbnI5VWZKNksxckt3?=
 =?utf-8?B?a0plZmxid2RoVElFVTF1ZkdoekN6ckF6alNkTmMvM0FrT1FrREVqTmRpbTZj?=
 =?utf-8?B?VW90ZkEzWGF4M0VZSldGc0NmT3dJZDNIa3k2NU1CN0tUblZmZ1I4QWVleFBz?=
 =?utf-8?B?aVE4QjBqZFlBMU4yV1pWNzI5bFJuNk1Ycmw5aXh3dmtweE5iYndOb1JKOXJv?=
 =?utf-8?B?YkRsMjB3UXBscG91b0Y1YVpVLzk3N09zQUVGZ3VabngxL3ZsQ1Y1WDZSSFd0?=
 =?utf-8?B?aE1PdUU3Sk1rb21zZHpsdGhyWWJ3UU1sZGhEVmJwZDg4eHdRVkJXOTF5cGNP?=
 =?utf-8?B?QmlBQ1hqWllYU3Y3ZWRMUm1MNjhWRWpJWHNYQjRyQ0hZQ3djUk5sSnBMZkw4?=
 =?utf-8?B?U3FWWFdBeUJxRWl5bVV1bElFVEhjNnlYVWdzd0JLQzZSY2Y5aE1aRHo5YlZm?=
 =?utf-8?B?QlVrVkpscGdGZUhiOTFEdWhYMFZKaGRsR0VkeG9haTZEclg1WVNVeXkwU0xG?=
 =?utf-8?B?bXE0MUU0b0dFREo3ZzVjKzBxcG9xMnFXSGsvNEhHOXQ3bDhuRmpIZnVjZUNn?=
 =?utf-8?B?RXdQMEJTcWNOeTVjRXZoTjNTZjhPanVwR3NpSmRXNUc0ZWQrWlZjc3RsWi9B?=
 =?utf-8?B?NGlrY01DVkdCNGFSd1dtTEltR1daNzFxdG1nNEZlTzU3WWlWdGdlMWh1RUhp?=
 =?utf-8?Q?Hsa3G0f+6EKMIEhNiDCU3tVw9FcWkA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHN3L09KMHRRTFZBQUxzeDA4RmJRUVBOcW9qYXVCYjJKWHdxMWJrTXFrZzIy?=
 =?utf-8?B?MVNESFFaMjVTeCs2aE9wMUljMDQrbmtDVU0yZThWL3VLQTVrNHJZUldyU09x?=
 =?utf-8?B?QkR1NWhYRlBsR01DZk9kYy82ell5NGNPSFJQYkRFaVhoRzA0UmxYTkltSUNQ?=
 =?utf-8?B?MVRDV3pqR21iMVdGQXpxTTZWME1HN05TUGo4MisyVmtVT0NqaXVuQStpWG0z?=
 =?utf-8?B?N1ZlZnh2QUkzYk8yOWNKNC9ZdjhHZE1QVk5lS0xOdDFLQ05MeGthWUJQa2N1?=
 =?utf-8?B?dTg4bFRnT2RSVTZLcGt1RjBSdVorcGhkSURka3F3RGlUbEh2SVNzZ1VsRDg0?=
 =?utf-8?B?U3lTM0VLNUowZGpHQzE1eHpNd1pRS0RLTXNGbFV0MjhVbHluODFOYU9Kenk2?=
 =?utf-8?B?TVRMQlhVR0Fmb3QvTHl0Qk8wTHdSMTl3SmxVL2NzcVVGbXFSRnNEYjAxdURY?=
 =?utf-8?B?eHRZNnRBVzRCMVY3MXBxODkwTyszR2tPMTdkdTI1S2M5L09CMVRrNWc4bTRq?=
 =?utf-8?B?UHUwNkFGajZDYmljNFdiZWlCUDZEbVMwVHY3V1YvQTBnaVBSaGFHbDA4VG9E?=
 =?utf-8?B?YlNRSEg4REdGd2VDWjZHSzFUa2g1bm5iZHY0QldOYnBRMmdUTEVGb0wrOWgw?=
 =?utf-8?B?YXI2UERkOEtjWktCY2JEcS9BTStxcHI3V1BDUHhvemw0eFQ2WWIxUlgyU0Jx?=
 =?utf-8?B?YVh4a2ZyYkNtUjljUWNUOXJaWHNhMHV5alhtTk9qYVdTTFpHUEM1RFVreXpQ?=
 =?utf-8?B?SThUMElMcTB2ZU9WdGUxK3NIR3BwZEZKcHpPMm5GR2JSVE9RbHFVOWpIV3A3?=
 =?utf-8?B?RkJrdG1Rc0plQkc1MENQeUVwM1JNL0JnREZBZHJFRis3Q09WdUZNQ2w1UCtz?=
 =?utf-8?B?SWlHWW5rVWNQZFdOMFFNeFNCejdadUppeitwQ0NFcW9KNGhvTlBvS2JyZnVT?=
 =?utf-8?B?VjFvRXRpUGx1TDU5bEprL3hVTmpvTlJkVkNTcGJNZ1l2RzVhR1BNYmFTNEdp?=
 =?utf-8?B?NmhnOEJOc1dJQnNRWEZYdm5pK2dUN0R3Vld5L21wNnY2Wll1aXBGc1ZaWUE3?=
 =?utf-8?B?M21OR3ZXZXFyNlFxZ2FjQUlmeW50enRxSFFtaDNWUHBWbFFaRGdzeURHRnZB?=
 =?utf-8?B?ZFdmSXVCVGFnR3VCWkFYU3k1VHcvaklhQzlWVXpGL1h2UHMyODMrNGZyaDda?=
 =?utf-8?B?eGtBU3c2QkpYMGFiMC94T25Bam8wcEpNMEJJeTRwSFZaNEhoRHRJYVF2L1Ba?=
 =?utf-8?B?YSsyby9ycHBOK2FpSFY5eGl4SXNSWnl5N2l3b3JkaTZsTit0dTZsNlUvbWhP?=
 =?utf-8?B?OGNpRXg2YXB0NEpYZGQ3Y2tiYnFqN2J4Z0Q2SlBEZkhhYzRMT3R6U2JUYTlK?=
 =?utf-8?B?VnhZR0NyeExoZVgwVENOdzhUQWJ1MDQ1Z3NKSXJMeGt0RTVtNTd4Rm1rQkVi?=
 =?utf-8?B?SWlFR2hHaFlpT3VtbUhWMjZFMldra2YzazlnZTEzaWltMXYyd3I2REVBdU1M?=
 =?utf-8?B?Q3Rmei9URFhOSkRGdXBvOFAvZGd1K2dCTUpIM1JJVFpCVWxxcHlsWnlBc01Z?=
 =?utf-8?B?d1ZEU05MMVB6Y2t1QU9XQ3dKUlRkZDQ4VnYzdm9nVG5SNFNoNmpvQkhiTCtt?=
 =?utf-8?B?NXNuNG8rZUFZODlwRTRlbmxDTzBlZGVmQjJPeENJdkZJb0ZNbXNLeEFCcWdG?=
 =?utf-8?B?ZThFZlUxZ2FITTV2RjFlWVBQQ01idUlGK3lkVWpITXhFVHJBMzNpcjN3ZWQw?=
 =?utf-8?B?cGVuMkhCcW5RZzlYcjVmbkVQdDdHTWdkSFB5U25NRzI5TERoUEdDZ0huVUJp?=
 =?utf-8?B?VHVTSTVYd1ROYnQ0eVZiUzlsWUtKay8raXFqdGNhbktuT2Z0cUtwc3hHUXFu?=
 =?utf-8?B?RmJyUFBIV1liclFIeUJIVWtvYkhOWU54Q01YL3VXLzBralZhanRqbkViUHV3?=
 =?utf-8?B?OUg2bk10bFdVTktlZVRTUzhBQ1NIeUhFR1hEdGZlNzJ1SEQxVlZUQkhIQmRV?=
 =?utf-8?B?NHVSdmJLKzQzV1hVd0JCVXFtb2J1c0kzUXJsNjlwQitxUE8zRlF3MGdVWkNn?=
 =?utf-8?B?RysvSTJOWlg5TFFpdkNLLzl0ZVMxLzRQS2hzbGpENnBKMmFSSFU3TEhnTE8r?=
 =?utf-8?Q?eNvjccE0WOSJ2fpuZvo8riLEE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65c8ce1-66aa-43b8-e7f0-08dde3b29d45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:37:24.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcAIjN7NQ8yzKVNO8iJW/06talNt9sAtnsw9RNOtM8Yrg+TDNYr5yQPM2RJfB4VxwV9eudsdANX4vvb84SQ5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index c0cc5611048e6a739f13c14bbd2e7b26f2715696..d238d419d87cc7c99d472720c96aade90275cb0f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -56,6 +56,16 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1048";
+		#phy-cells = <1>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan_phy>;
+		standby-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>,
+				<&gpio4 27 GPIO_ACTIVE_LOW>;
+	};
+
 	native-hdmi-connector {
 		compatible = "hdmi-connector";
 		label = "HDMI OUT";
@@ -103,28 +113,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can1_stby: regulator-can1-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can1-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan1_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_can2_stby: regulator-can2-stby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_flexcan2_reg>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	reg_pcie0: regulator-pcie {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -431,14 +419,14 @@ ethphy1: ethernet-phy@1 {
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_can1_stby>;
+	phys = <&flexcan_phy 0>;
 	status = "okay";
 };
 
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_stby>;
+	phys = <&flexcan_phy 1>;
 	status = "disabled";/* can2 pin conflict with pdm */
 };
 
@@ -903,14 +891,9 @@ MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
 		>;
 	};
 
-	pinctrl_flexcan1_reg: flexcan1reggrp {
+	pinctrl_flexcan_phy: flexcanphygrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
-		>;
-	};
-
-	pinctrl_flexcan2_reg: flexcan2reggrp {
-		fsl,pins = <
 			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};

-- 
2.37.1


