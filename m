Return-Path: <linux-can+bounces-2108-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31079D2157
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABEBB21CF6
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94011B0F2C;
	Tue, 19 Nov 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="djEO/WED"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588F19F416;
	Tue, 19 Nov 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003870; cv=fail; b=YdASwRI54mumPV1aI1SKiJn3lVe6wvMouvS25DvQJGUeUqgF47RGLUjWyn8kLtBZD4F2E0ODT2gjtrZG68eMy2LG8V7qiYiefWoGJNrcj9d7OaY/P0yxHB8CLBRK12e+E7dzSnelqDePzpBOl5DPf/F0s4pjRxIX5O2+awHaewo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003870; c=relaxed/simple;
	bh=G0WXPIXmMq0Zlpzu9iMfPQeI0xxXc0kD7I0Hsy8XA30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/BF4WkoB9WkwhzHHEt94/OukG30AAMWd/Ivab07gmakHgfiEoehhOxPcb6cpbf6Km9CoIdrrU4kCDfPD5FylsY9Fx1hFDIpxJW6GSYSDZ1+sJCvlnqWiK1g6evXET5x1SX/Xym8zR265z3GidHCpTqdbYwEJ76VcDke7e0rdIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=djEO/WED; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erPxxAu5A/5CQq2wJpp2OlE5rTgujdX/BckliJSEHS+h3YWo0osU8ASQ5BxTZ+NcEi8Iup6NMUIZOKl4rjGhEtaFk6+ScGWicdOEktK9/Q4bu1jLkDa3eU4q5OwDU45zgnX5DWW0MicQmr3uq/VMQl7Zn8PXPzTfJEm5xELvog5AOz1bXcpgMX4xtbE42SUTpL1PLxOucPBIrgH2iX/J+Ck+VokGHIDnhqs7f2dkmylgRAqfloCubeegHmPPjiLIDF7t/TNJizW1xaoSkHcwnEKSqz6FtcAZZRfFEsWA4KS/bC0Rd+xMVnaKC+NJvHLRS8m56tIUc7BaGBNjgsocfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+MvJjMJ3N0pA8nHxioLNChTuV+Hmdtz2LxJKzYJbxY=;
 b=LZQU4HQvUYFa+ArSxX8oSEzccrJKmfNo+23N7fRjaTBdF0LUQT4EDWGqE28Y6OidmGrmjEw77Xjr79BVsIgqELrOmbRnBHWYpvy25UzuPywhVlwOywi+fFLJJW6b5FVUosnwfYgswrYyrE/ZGX42Yntu0dkrZTC0J4zjynwGGiLZwYQSBW9UiiCpos8PJJVC4Duccvb/E7B5TPJy+Bl081SNStjSy8S9A64TFrd0TAnFcuQt9r/uxqzG/WxSG+5UjEvW+fwHqP8Bgp0+gMnkRPKVD5/wypzu84f6YfG/9H3WOZzDjTAqw5T/IrrRZpB2QvON+u3nuIM4nnFo7hBwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+MvJjMJ3N0pA8nHxioLNChTuV+Hmdtz2LxJKzYJbxY=;
 b=djEO/WEDxg/M+oRBHEBMMuPvZYEqG5NWgDjGhpNDYen5IvNcqvExPcuMCo5T1a6P8wnPldgABIdzmToO2gUtjdtqs1h5Aa4u1Z6GF1H3VsMvx9+dqe95HBKWH/vaw29D24EWi+VT3c4HqykqQPpuDSsXDjLtOYrIOMHGsZFm9ePTCSvTLsgkVi1GyfQfx0vsPHBnd2WD3FYm1vp/a7hhROZ0Yd7YLeZ5uMnCXyKRjuZowecS3KcDjlE2zUjncMdfTYTJGCiFsHvSM00LHEK/rY/PthI88VfhABhT+DEeNan7VfOcJU3upUyRvIIhjqrffaoo0PPZwo8680b2pXLhxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:11:03 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:11:03 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt lines
Date: Tue, 19 Nov 2024 10:10:53 +0200
Message-ID: <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34)
 To DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: bc93aa2f-5cb8-4877-cfef-08dd0871b617
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0Z3bGNLZFBlT1hIQXovSnd3KzB6SE9CbXhQa0pqcE5DRk5JV2t0a05tTUJ2?=
 =?utf-8?B?YTYvQTlpVEJ5akNuMkpBcEpiM0Q1eDNmSG9kRHEvTTV5R1hRdVB0Ykd1Nmxw?=
 =?utf-8?B?alBLMjRJaFNhNmllVkZuUUxmdnM0WGgxd1h4LzR4WjRSZy9ubElCNStGVDh5?=
 =?utf-8?B?WWtFYVJyMnpwL25FdlhrYllYb1VoQjRhTGdHdzNjZHJybWtpelRoN0VUSUlT?=
 =?utf-8?B?cEpJV0tVa2tRQ0NxV3BFczBIaWc3NVgwRHFONmJUQXdqcytISmhqcWZSeTM3?=
 =?utf-8?B?MWxwUmRxazdraElVeGd3UTFVdkhsS04yS0R0MEwzbWFsdktOUW5yU1RjZy9p?=
 =?utf-8?B?NzRoQjNwTVVPZmxxaEovc21SUWFWeS9iWHFxbit0NlhkWVdSVG4waUdSN0pB?=
 =?utf-8?B?Mlg3a2tUL2N2UlYxeWZ2cGxseS9tQ1pIWCt5TXFxMTJPeStiNCtVUGZORkRJ?=
 =?utf-8?B?MkxLcnZVdlRCRlQ4OTdlYjdoUzlzdDhhQ0JPWkFwMUptc3dKUTJac05Kbkk1?=
 =?utf-8?B?QjNOSGh1dmw4amsvQmVTRjNaT2pXNFUzRUppcUNhckhQdEM3Y2ErQkpBd2VJ?=
 =?utf-8?B?aFdOUG1QUHZCd1plcUxJVWtnazNjOEd3S01rakxFMVJONG15Y2RoT2pqRWRm?=
 =?utf-8?B?ZExsS2Nyd0VVZlA1SXUyVUVTRmI0M3ZiMitrYU9nM0pGRUFnYTRhaFVjTzht?=
 =?utf-8?B?QnF4TW5LZVpBZzZCT1dVR0ppazc1WHQ4U0ZQNE05Q08vYUdzZ0JIZkU1eDR3?=
 =?utf-8?B?UXRQWW1YdElwZDlxSzRvSnZ4VFhuYzZVM25XcldnUkl5djNHWWZ2bU55YUVl?=
 =?utf-8?B?UDQxN3ZFWXBydXloZktsVHlHa1JMaHc5TkZNUk9leFZaU0IyaVM4SXcxUUNp?=
 =?utf-8?B?anltaEEyTDlOdjFtWlFlcExBcnA2ekRaRmFCZmhyTkM4Qy9GSDRnc2pua1JZ?=
 =?utf-8?B?S0E2ZHZkRHF0b2Z2SFFvYTNPMkc2ZlJZMlZJb21WSHlKVnBINHR2c2VKc1pr?=
 =?utf-8?B?Wm5TQ1Y1SE5NZzh2TkpiUmRaUnRnRHlGSTZtQjNZN2NtYWtRanZvQVltY2dN?=
 =?utf-8?B?YXBBOXE4MkJhSjMvWVFmY3lCUUc0NGtsMkRhcXkxbGlnK25HcG10ZkYwVkxI?=
 =?utf-8?B?MUowY29OMEVKYythYUE2REVkNDdWeG5PWExmcG85VGFjeGErLzhyWW1DQWJR?=
 =?utf-8?B?cTBuTGdTbnRUNGxQQ0pPdy9oOGhRZTRSUS9HaXlQSlV5QXZqRDVWMGQrajk1?=
 =?utf-8?B?Rmd3bHY3M0Y3V0QwdldpakcxWStqeDZSd1h2MTBqQUl3Q0ZXR1NVbVFKdmFk?=
 =?utf-8?B?SGVqWk9MQ0FkVFRabzB4Q1pTdGxHdTB6QVNETVNXN2hFTDQ2V1lHOTgyWkR3?=
 =?utf-8?B?dzZaRy9vSCt5VHpZT0hGWlRsUUlJdnBQdUNoZWNhRzZ3Z0dGUDhXNEtPWjVG?=
 =?utf-8?B?SElUVkl5anRzLzZ5cTF6azQwRUtyTFBEVDlsM0l3d3o0ZnNrNHpsdDByWGFR?=
 =?utf-8?B?QllaRm5hN1E0dE5uWC9LWTl6NjY2UXozWlhjM3NKeE40d243SzhuS2RiZWtw?=
 =?utf-8?B?bE52c3h5NDlmZ1hUY0Q4bDEvN2dJcXF0em5NQmRIcU9qVmtYTVBIWlRGSDZV?=
 =?utf-8?B?Sm96YVJaekZUa2dVVUZQMWhoZTVXTWZhL3krMlRRRHVnenN0SmppTmhrcTRr?=
 =?utf-8?B?ZnZabGFwVUtyNHBzaitndU9ROU5COWVHMUxmbUx0M2ZGWGw2OGxETEpJQnhl?=
 =?utf-8?B?cFMzOTloZ2RCZFRiYnhFVVljWVJ6YW41MWowcVgwaWpjQUFUMHlSemhlczZy?=
 =?utf-8?Q?etgRKlWdU4BzfE1Fo0MzU0tawqVJqrqOx2zAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUJRdnRWVU4wb3gxc3Rlb2RKMjQ3eGJtaXZscUU1UXVLWGdldm5pOUNZRUtH?=
 =?utf-8?B?cW5NbHRxbVBZT3g0cjhLY1haYjJSNHJqRzJpOXgvVlBYYkViVmxzY1RQS0hM?=
 =?utf-8?B?eTV0UGJnZ2hNbHhiOXlzc1Rmd2FRRUx5TzVTZFB2SGF2bkM1dzVnNWFxdUlN?=
 =?utf-8?B?NHExMnhab0w3WW1Ga1ZQcTBuU3FUdW40NkJROHFYaHFiQm9raWMxNHV5Uk1N?=
 =?utf-8?B?RjAyVEpiYmtSREdwQ05GMjRrcHF2dEpVYW5qQVluUnFqRVNxTERWR1ZuWmF0?=
 =?utf-8?B?eE5EQndva3oyYkRpMWp6YlBMR1EwT2lWWVcrQjBKQnFheFUwTXZ0TWp0SFlo?=
 =?utf-8?B?ZjBtRUY2R3RlZDlpVUpjbFppWWJjWldhZWRNV29HSm1QUC91RTVqeWUvYkFN?=
 =?utf-8?B?bUVRTXZXNjZuNEYxK2ZyUUN0NWk0WktLM3hDbjlWVHRZYmtFOGI4cGs1YVF3?=
 =?utf-8?B?UmdMRXlnSEJZclBRRG15ZG9VeVVEUHEvbzNCQ3RGZG9OMWVxS1owSEtqK1ZQ?=
 =?utf-8?B?aW04bk5jcGpXaVBHMXRMdzFJVnNFWFozQmplWmpzbUF5TjFQcjMzWWpqUU5q?=
 =?utf-8?B?eDFxM3pyK3J3VmdUZmI0ZUo1TzMzZi9uTWZsZiswTXREbFhubjdoK0gwVXdM?=
 =?utf-8?B?Zkk1Z2lPckZ3dXpBL2FLQW1Lc2NXVjZlQ2Eza21QcjVBbU44RXVZVmJab29p?=
 =?utf-8?B?VnlzdkhPQnZUbk1Ja1NQSzNkalhrcVZJazJYV2M3ZVUzeDlFd2Urb29KK1N0?=
 =?utf-8?B?bU8zNVhkdXlBcTBJWlg5MkpxK2F3TWE3MFRDMVhnS1R6MnZxWWVFYS9iRE8x?=
 =?utf-8?B?aUlmclRFalgveVlzNjNhMGVLZFE5RENwMHZBR0QwT2g5MHloQkZ0NzJLS1gz?=
 =?utf-8?B?b3lyQ2FtL0h1WHhMV250MU5ZK0d1bVdNVXNPeU5hVEx6WmlyUzY4eHBTRTYz?=
 =?utf-8?B?dGFReHhqaUd2Vmh5SXRuaUxmeHVTYXYydlZkTER6NFdTYjlkZ3N2OFpsY1F0?=
 =?utf-8?B?a09tM3dyRnF2OHhIMmVsVlpEeCtaRlFzaXNMczVFN2JSTDNYRkd3Wkh5TGta?=
 =?utf-8?B?UHlCWVllT1kvYXczM3llRGUvNk12cUdlNk1qWWtVOTFNTVVEUk1qQldGQlJY?=
 =?utf-8?B?bEk1TkpZcHlTRnFVWWdQS1AvREhEdStVN0MrVkJWR2VBSkg0aXB5U09MU25w?=
 =?utf-8?B?R25LbmYwZkEyRHRkK0p3S1YyczQ4dEM4bnlKMmVCL25Ka0NyQWlwVTFYTyto?=
 =?utf-8?B?a3ZGRkRhNzVQUGVoeE8rSFlWV0lwSEJCQ25jcm44QVJDSVl5TU9sR2NLS3c3?=
 =?utf-8?B?UUFRWlJMZkYrWVJjb3RoYXhscDFIN0cyVWdpZzVtVkNhNTFsVytnTVF4VEd2?=
 =?utf-8?B?eE8wT2QyeDhZeWRSVi9Ha1lXcHhlMnhBWGlqK3B6Rzc1Ri9MSjM1OHJNelBm?=
 =?utf-8?B?bGtWTE9ibGlSc1hzWHMyeHM3QnJJaXAvRllTZ3VHY1lPVElROEJzdHA3dERC?=
 =?utf-8?B?N1pQdEJQMnJ5ekE1OXJ4SjFlTWYraDhBMTl4N0lFUGlrVW1uN0N4T0w1T3lC?=
 =?utf-8?B?UlNMRDE5ZVI5ZElldkxQbks4bkpramhCMWxXMnVjUlloOHNid25ZUURkd3U5?=
 =?utf-8?B?UmY4K1JCb1M4dytlN1N0eXU3OFhqUm95Vm9yYjM5UXg2ZXNzbEF0Zm9BMmZH?=
 =?utf-8?B?MW5ZQ1U2eWhsMTJpcEM5TytDdkhEUzVQbGcvUU1kUnBodHpmT0JQU21HYndo?=
 =?utf-8?B?eWxSazhDNWd3bDdYZnQ2R1FselVjRWJBUlY4SmVCNXdGMzVXOUp6dDFhc2R0?=
 =?utf-8?B?b3FjTmhkenhKcDMvWndyL09oTHJLYnZpRlIrNGY3K0tmaFJrNmRtQzNyb0lS?=
 =?utf-8?B?R3BkcThHV3hCR3JoVGI3VDdSZk5Dd1puVFEyc0NzcDk4dUZKWjhTMEpWYytH?=
 =?utf-8?B?bEZCV1ErakdSOVhBbjJ4RVZQUCt1V3l0RzI2ZFU2SFprMTZhUXdraVg3MElj?=
 =?utf-8?B?TTlSTEZGYjFnSHhlcSt2enZXTnhMYVNUNGt1ZE9XdmIrejNSNVF4VDl6cUp1?=
 =?utf-8?B?ODZIZE9QbktlZ1BocUo2MFJuNkV0Z0tFUUVQNDJMUVR1YVVrNHkyMEZFakZY?=
 =?utf-8?B?RGQ5eTJ3MURkNDZQTVJXUVZaZVFoaFFTZlJJdjExQ0JSRk8wMW11ME14TkZ3?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc93aa2f-5cb8-4877-cfef-08dd0871b617
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:11:03.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3X6bGugneoxgBVbFvkW2TPf3yTkSebfD4BFRZctynlcyrDmhdHx8/S+/F6wKGuWPqFEn/9Ns3wO+9bVp83MOJOyNkKG1beAeIr0+5WC+ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2/S32G3 SoC, there are separate interrupts
for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

In order to handle this FlexCAN hardware particularity, reuse
the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
handling support.

Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
which can be used in case there are two separate mailbox ranges
controlled by independent hardware interrupt lines, as it is
the case on S32G2/S32G3 SoC.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++++++--
 drivers/net/can/flexcan/flexcan.h      |  3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f0dee04800d3..dc56d4a7d30b 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -390,9 +390,10 @@ static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
-		FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
@@ -1771,12 +1772,21 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		err = request_irq(priv->irq_secondary_mb,
+				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_err;
+	}
+
 	flexcan_chip_interrupts_enable(dev);
 
 	netif_start_queue(dev);
 
 	return 0;
 
+ out_free_irq_err:
+	free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	free_irq(priv->irq_boff, dev);
  out_free_irq:
@@ -1808,6 +1818,9 @@ static int flexcan_close(struct net_device *dev)
 		free_irq(priv->irq_boff, dev);
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		free_irq(priv->irq_secondary_mb, dev);
+
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop_disable_on_error(dev);
@@ -2197,6 +2210,14 @@ static int flexcan_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
+		priv->irq_secondary_mb = platform_get_irq(pdev, 3);
+		if (priv->irq_secondary_mb < 0) {
+			err = priv->irq_secondary_mb;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_FD_NON_ISO;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 4933d8c7439e..d4b1a954c538 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -70,6 +70,8 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 /* Setup stop mode with ATF SCMI protocol to support wakeup */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
+/* Setup secondary mailbox interrupt */
+#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -105,6 +107,7 @@ struct flexcan_priv {
 	struct regulator *reg_xceiver;
 	struct flexcan_stop_mode stm;
 
+	int irq_secondary_mb;
 	int irq_boff;
 	int irq_err;
 
-- 
2.45.2


