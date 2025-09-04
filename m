Return-Path: <linux-can+bounces-4470-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B92B435F8
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A8D1796B3
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD972D29D6;
	Thu,  4 Sep 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVgDRcOV"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA02D2482;
	Thu,  4 Sep 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975066; cv=fail; b=KP1MEytyJuCarJLcWZWpNqfpbMwuLwK2e+mxm2TujEFIUOMzRcF5rNnDAtEuHF5w7/eFk4xx8AJWea/dI1GoplSnMXuU6ARB3iBMffx6AaI0uYJCdygHzky7zVfsKSID5EL6dNEN6Y9EgBAGpPNiyPOAyGyD4MlMEDILhfmWrfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975066; c=relaxed/simple;
	bh=T33SultXVFxCIQ2XVw1HyPhSHteA+im/oNtUmLRuVt0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bIKP16rK8Z1mouxdiyyLE3O65V2GMcsBqwyy86MRlNwVxIlRrNaB3pGs+nDhgZxjZtUNth3pak3xa+Syj4Nb2Sx064slGLif4bb7kSIYeYhLcfLMneFprKX0IumMJfRSAAvhnZXsPhg/Oy/lPzsH9R8JqVOLiun1kYzrak9RoAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVgDRcOV; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AikvlHixqW5UlUpVgMJ8NHnwyl36L87t+pHePer7p9mShchwCwqQxMro8GU+bl6W57GObIg9i4kCibJjcH2Qm8c7M3XO46abrTn0a4f1n/5BTzKn0v0+saymLdphGtiQRrzArWCY0JO51Yx32mHXFXt1jKFfI6SanUpnJUcQUuwUJ1SMayDz70bCnI4UzAn9aBhpaHfHnq9jYkfJU4Au5zXjB4Mgcbf2nxE+AXRPTd9zE0BjoIy48lC46E/KNxNsQXakvvkRblrVl+kybV5F7t+mttz92t/ftdNOKmjqbrPMyh6CwiVVZh2N+yh62YdVM+N/RQ65hhCfEleFxPE+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1XV+YNeqIrBPI20VtkmuIEAtlt1lvW9BpE9QzlYSig=;
 b=fgccvKcX5L+YCQkwz5lRonTV/N4RfX+COGkYnfqILXdIntbNe7vcC2VSdWTNXwu3MVM7+s7c5a/dkk78lDtJexhqTQJxq1Rv7mvTcD/rwApn82moVYgw0X72pqjWjzXXmVIWV1M+MNXT6h2+5/KQUbJ5vMHxwbpQzfq/pPgTY6r2nY+8knAqA8Q+3QQBpnO/zNO0ddnhWcGr23BOPkkZKP1thRNqfT7Wuoh3i8dl+1jGcpoB+UQUDiQ/QyRCK5KUS2CZIIMKtJfi7Aatn1QjGNbPdFJiBI/7OBZ0B7RdasI3Pz/mMWBpJXI5vKd/HZsWGsuM1eD+09LFxZ6q144EKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1XV+YNeqIrBPI20VtkmuIEAtlt1lvW9BpE9QzlYSig=;
 b=ZVgDRcOVWq64gcVUkdVe4D5FkHRyF0D2fH/s+vBl4QgokdWrUldN3PyY+SYGmwUFnyhgyzygx/Zo4SDYrGw40fwSk1oOWrBjVKTLP6buk8RtCdv++ReHRQ2pUYuVJ0VDKS5Uxgs7dzW/oxrfJibnj/KL9azYV4DY5+MU5XPMigRpPPoR7oGti/Fxf4epkozBiT9vK9PHVBCM9W1G2GrhJExLOj4MWmFmBS0vF+QLw+9b7Q9q+0Ie19rNqbW2rr4U0vVe3zCXAe4qu1YAIUykafHNksGZkdIg4YEV79t60aUx2HLmJeWE9Cz8/OtQwiyts1MoGDB24hrV1VXy0nflFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:41 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:49 +0800
Subject: [PATCH v5 6/9] phy: phy-can-transceiver: Add support for
 TJA105{1,7}
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-6-23d8129b5e5d@nxp.com>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
In-Reply-To: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=3605;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=T33SultXVFxCIQ2XVw1HyPhSHteA+im/oNtUmLRuVt0=;
 b=RIAAYBdc/NbcT0SuX9Vq0hsOn/PeCXcmIRdF1pSz2zneZME3gfwr48nLf3E2n0PoY4cOIqXjl
 R7QLx0YgGqoCV9yv3BnUebIbLGBIKpuir9MxRewXCFrZ/OWYlR7nfu5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4ef318-da14-432d-280c-08ddeb8e4fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTZmMjdrRnZsUk1LYkNXQml1ajdzQ0dSdTZOalhrWkNDckI4NFcrUWhNYmpv?=
 =?utf-8?B?eFlWeWM3NG1rYVMwKzVEelQyUFhNMFZRb1o5VVljU0t0WWhBYlFPc0ZTeTlS?=
 =?utf-8?B?dDFUNkFkcFZPQm1rdEhaMFhsU0VrQjkzdHZVTVY0TXVPSXowVnNOK3dxeU1V?=
 =?utf-8?B?UXNJdkEyQ0VSWkdwS0l5eHpEOUdUTjhZaldLaGp5cmVzTk5wdXlEN3ZaditN?=
 =?utf-8?B?cUVJZSsyRXFCUFBJSUZKMWxVYXRuM0IwaHhROXQvbUN4Mzc1d08zc04wOGxo?=
 =?utf-8?B?TlJPdVFxK1VHeWJ3alBxN2h3THNqVGFTQ2J0OXhwTjFiKzFTbDBSbHF5dUtO?=
 =?utf-8?B?b0U2S0dXWjAxQUpmY2FFSzdEV0dyck02YktPSmhISC9iQnVwem9GdFZGeVBV?=
 =?utf-8?B?NjZudy9kUXZJQmp2eEhZS0F1YURhbGlmVjl1UE9ybGJrSHJBL2V3OWhiQklt?=
 =?utf-8?B?TTFBQXVjS081S2ZMWG4yY2RaMWNoUDFBYTBQZ1h2aTF6UC9rSjZ4LzR4STF0?=
 =?utf-8?B?aG9wU0M4U0hSLzB2WWJjWWZwa2gzWm14S0ZBN3lVbmpNR2Frc29lR0duWlNB?=
 =?utf-8?B?TlFoMzlaY3FPeTcrS0hMTjdRdkxUQ3lqbytUZWdOY002MGYrN0lEcmZLcDFy?=
 =?utf-8?B?L1pOei9hbk9kVjhkSzgwZHpJRnIxQ0VTcEIwVGVaenhJT1hOaWJ5ZWorb3VY?=
 =?utf-8?B?K0tVVXlvR3B4Y0FRb0pEMHJEMUE4emdxNTFIcS9nTW5aQzJIRlN5V3E3QXZW?=
 =?utf-8?B?eE1aZFJ0aXg2ZnNjOGpYdCtUV2RxZ3BSbTAvOWJJTHFuODl0a1dVcG9UNzNu?=
 =?utf-8?B?ektVcVlUMVloOFQrRTJOUEtWZkJqb0YwOGNQWEFJc2JBaXRTYU9FaXNld25o?=
 =?utf-8?B?TkdCODR3a0trN3BmSjUzTXBnM2NlYzhWNlduY3E2MXRaNmFOdTV4cWlYanBo?=
 =?utf-8?B?ZkJuQUtKQ0N3dHcwT1lCM2xpSFYrUG1BazJtSG56NVE4NjBtbmt6TVAveG5y?=
 =?utf-8?B?aVhaRXJuS1UrNDJqRjhmRFdvSkR0NjZ0L2JoNjB2bWFsY25JU05QK2loYXFV?=
 =?utf-8?B?TFhYRXdCNjBsMVNuL29DQ3pnSzdNYmpwcktjRlVHQVp1NHIyb3ZxaHFDeGE1?=
 =?utf-8?B?dW9ndWh0MGRjKzhOR3VYVnhTZ2wrZ2tqanE5TThwN3lYQXBZcWlWQ2dQend0?=
 =?utf-8?B?SjBMT2kvckkzZk9iVHlpSm1GOFBHVEFQaWRDalVQTHNob0s3VDY5VHhWbkln?=
 =?utf-8?B?Z3FDUE5UL1dwT2YvMW91QzlGTGtqc2dGSWZieS9JWDV0THkyVXRZSlQ1cTVY?=
 =?utf-8?B?Z2Jsai9pTGRWLzRZSzB2QVpmUERYYUdlQlIwYkRoZnlnMURHMW03VjV6TDJz?=
 =?utf-8?B?NFBwSWdTUVJiR0NPSWpINzhCeVRpY3d4R21yNm9MMTJ3dEhEVk1hZWErbmxF?=
 =?utf-8?B?OVAxNnBtUnJaUEVGNmNwcVhTa3RMd25HcTlqTmk3UnRYM2hJdC9FVXBuU3Qx?=
 =?utf-8?B?NUpXSWR0K05zcy9OZWlQMnFSV2twYzQ5WW04L2xYckNRSlV3ekh5UmMyc0ZP?=
 =?utf-8?B?RWkremRBUTRMQmNQQUQyVU0xVlg2UnUyRkNzV2N2T25kWUpzQ2tnQUcyV0ZH?=
 =?utf-8?B?dzh5blBFUnlxV0ZFTGdDSDA4a2RjTHcvWnI2LzNFT1NjVThVSnBHKzBocU9z?=
 =?utf-8?B?SnRicXcrbU1uZEQwSVQzZkpXSnZXQUlibVhCdU9HdEMxclNUL3FZTm5OcW9G?=
 =?utf-8?B?WWt6SU1aNytLeFNGM3IvMGxmMGZ0eElSQmxlbXdIWVBVME5zVCs5RExVYTJX?=
 =?utf-8?B?Nzk0UlFCc1ZlQnBlZlgvbUpZU1NaZTBTY0swNmNkMTJjM3RYSDd3b21SVk5X?=
 =?utf-8?B?TW1mU016NURmWjV4Y0JWZTdCaGRmbkFLMXJRV1Y2Rm9WQlJadnZKZkFOM2FN?=
 =?utf-8?B?RFF0TXR4OUdIR295M2tuVUtsbm0rZzZEaXRyczZraHo0ZzlIakxrcVc3c243?=
 =?utf-8?Q?y3C/AccX503T0auOllKAOCzVKy/d94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGlKdzE0RTF4cHl6NDM3TitQMnA0b2E1VW8zZndBT2FGMVlWTTgzVnpzMkFh?=
 =?utf-8?B?K0s0MWdSbkxkZ3BrenBZV2RTMVhGQVVSZmk4Vzd0Ym9SNzBBYUxieTdmVFVX?=
 =?utf-8?B?dHdzZDJyZ3ZTQ1JpRVpYNGZNUEk0OXlkN21zbk1ySW5sdS9kanBCc3NBY3hS?=
 =?utf-8?B?UTJzS09oWVdNcjQ5YTVxTENhNzVDVURvY2dVeEJiRUZ2SXV1M2ltMDZYaTNa?=
 =?utf-8?B?Nk13cnlOUXByNHVmOXlBemNPQUszeW0zbEhGd2VEeEM5aXlLRGNSQjgrTHk0?=
 =?utf-8?B?d2pMNUJBZWlPOG9CTDhqUTA5RjZxd05zaWNpaTVLNUpJa1pXeVhabW1kZ1hh?=
 =?utf-8?B?Z1kwakxqRUlVOEkrR2VVdHM2V2c1MkpSN3g2alRxMjNZL2xWS2dqazhkeWFt?=
 =?utf-8?B?OWp5bVV6WW5wZlpuN1E4bkZHbHhOS0dmQkpGWlFSV0g3VXNNSGtlWjNqcDFw?=
 =?utf-8?B?TzZPbENsdzFJUmxhWHJydWh6U0hvT2lRZkZqd2d5aVVsU05oa2Q0bVRTb2ln?=
 =?utf-8?B?bFRuL3RIN1FvN1BjMzBPTXFobzh4OG5GRFFwMWt6dkwxVmFsV2tnMWZHVkJr?=
 =?utf-8?B?QzBxRW1odjlhVkpDSHYzTkxtdWxBaGtLd2d3VzhhUWxlZjZOWllPa0NPbXFz?=
 =?utf-8?B?eDB6MzhUb0hLcHdCcmw0VHFmTWdObGZpeGFBVWFuL2RNendhMXZwVC9Mbmx1?=
 =?utf-8?B?ZlU3UkVFU3c4citQS3dqK0tsZDd1Z0JUQnZOTkdrbk90aWI3WEgzci9qVlZa?=
 =?utf-8?B?djlDSEFzbElKVS9kV0RNOVNRQnlqbkZua1JBVnYvMXM3R1BPY3l1UWpDOHJB?=
 =?utf-8?B?RkEvWDZKZEJQT1RQOU55d21LYnFONE9uRDhXakNZM2RleFpVMnBNZ3NDbHpp?=
 =?utf-8?B?QUQwbU1zTHNmY0cwdDNDVU5CYVJrYitJbTZqbkJ1RmpjSFJlYzNRcVh4Vldi?=
 =?utf-8?B?MFlUME9nQ1hRdk9TNCtIa2ZlZHM1VEJjWTdJNE5DNTlweTRmYUJEUTRDdmFR?=
 =?utf-8?B?azhmMWxoaFhqR3RsSGtTOW84UXcvQkdITHVGQXZmN0czQ3FtOStWaHd2NlZF?=
 =?utf-8?B?SzN4UVJFb09LRzNDbFQ3eStBc0ViNXEzZXY3VGx0OFFKV0NpK2QzNHFWUTlU?=
 =?utf-8?B?U2w3L2xlZDVNczVSUU9iSFV2WEZzWUdWbnJ1WjcxbzhoQ3JUTTFLaDV2WGxR?=
 =?utf-8?B?MEVmSXNFTm1YaFJEZkkwd0xRUWxBYUV6ZlF6NG0yNms1RC85L3hjSExiWHJi?=
 =?utf-8?B?NXVRZUJQNXVhbjlwWGZFaHZmWEZYMXBIUE5PK1pLOW9rK1VyOVJidWNmR3A5?=
 =?utf-8?B?eGkvVFMyS3BOUWRtdThyeHdHNkF1NzRsUXBhQyticEMvcG14ZFMwTk81NHhS?=
 =?utf-8?B?QjJRRHkvSHVqSGJJcUJiVmVKVlpmWkZFMzV4d1hPTURtejZteUN0aFVpUGRE?=
 =?utf-8?B?MXk3dHJmVkFURmQ4MEU3emdqMklPTmw2TDFBemdYWVJaNlN3NHV0T3IzWDlr?=
 =?utf-8?B?ZnlxQ0RlMk9BcXJiamhiUGdXWkkxZTVCUmJHcnR6Z096ZUl3UENPNHpVSFAr?=
 =?utf-8?B?bWFNUjVRL0RtNTRQQWFHU0s0WDA2bzdHNkdyR01maENsbWlrMFB4VDIzUUc1?=
 =?utf-8?B?bzB3dDVoMmU3cW44R3RacjdxcGxYSU1KYTZlZCsrczczOEtCeHRreU5lUEZl?=
 =?utf-8?B?WUlGWk90ZTdmR2FhRDV1OEMvQ1MwVEs3SkNwaURZeDVyVVU0eVpTUDZjWmF6?=
 =?utf-8?B?M1lFa2V5eW0yRitTZE9KcGZESW9IM1RIUkNKSFpJUXRoZlJJZENrNDkzN3lJ?=
 =?utf-8?B?VnJuSHFJcWFSSVUrMGZqNHRFVE9pYVpBdXRFRzdaYUFsQms3YmQ4Q2VBZHRi?=
 =?utf-8?B?Nzkvb3FwRFRqdDlqdDNVOGNSdExoL2diK2p1ZnMrakdwSldXWkQ5aENPWlJ6?=
 =?utf-8?B?SkFaWTYva2Nva3ZIUDFQWksxeTl6cUxJVUYwTk1RR0t2UmVuVFI5YVd1aFE3?=
 =?utf-8?B?MEcyRnFnN3lyblh5L1lTQm0yWnRudW5CN21LY2NmY2FzUmpVMnhpL0F6QTZa?=
 =?utf-8?B?Vm5lR1NUUktNNGJ4bktmbG9qc00rd1JnQlB5V29IeEIrNDVKbTRIc1ExTGhk?=
 =?utf-8?Q?dMGaKumLrrWXpuiN94B5O11S7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4ef318-da14-432d-280c-08ddeb8e4fc1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:41.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmANUE7lJ3j2OaRA3jJT4hgTme+5ziVDEAAYxUl1X60hpbvQOyw1VWP+b/Jm5ZFL5vRglce+M9SFy5rE/Q98vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

Support TJA105{1,7} which are a single channel high-speed CAN transceiver
with silent mode supported.

phy mode is not implemented as of now. silent settings are kept in
phy_power_on and phy_power_off. After phy mode is supported, the silent
settings could be moved to phy_set_mode.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index ccb29e1dfe0d07005b4bcd8fefa2787292d921a0..d9fd3564970695d5460ffdc4e8636dd7638d64a2 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -18,10 +18,12 @@ struct can_transceiver_data {
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
 #define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
+#define CAN_TRANSCEIVER_SILENT_PRESENT	BIT(3)
 };
 
 struct can_transceiver_phy {
 	struct phy *generic_phy;
+	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct can_transceiver_priv *priv;
@@ -47,6 +49,10 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 		}
 	}
 
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 0);
+	if (ret)
+		return ret;
+
 	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
 	if (ret)
 		return ret;
@@ -60,6 +66,10 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 	int ret;
 
+	ret = gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 1);
+	if (ret)
+		return ret;
+
 	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (ret)
 		return ret;
@@ -92,6 +102,14 @@ static const struct can_transceiver_data tja1048_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
 };
 
+static const struct can_transceiver_data tja1051_drvdata = {
+	.flags = CAN_TRANSCEIVER_SILENT_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
+};
+
+static const struct can_transceiver_data tja1057_drvdata = {
+	.flags = CAN_TRANSCEIVER_SILENT_PRESENT,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -105,6 +123,14 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "nxp,tja1048",
 		.data = &tja1048_drvdata
 	},
+	{
+		.compatible = "nxp,tja1051",
+		.data = &tja1051_drvdata
+	},
+	{
+		.compatible = "nxp,tja1057",
+		.data = &tja1057_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -150,6 +176,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	const struct can_transceiver_data *drvdata;
 	const struct of_device_id *match;
 	struct phy *phy;
+	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
@@ -213,6 +240,14 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
 		}
 
+		if (drvdata->flags & CAN_TRANSCEIVER_SILENT_PRESENT) {
+			silent_gpio = devm_gpiod_get_index_optional(dev, "silent", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(silent_gpio))
+				return PTR_ERR(silent_gpio);
+			priv->can_transceiver_phy[i].silent_gpio = silent_gpio;
+		}
+
 		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
 				&priv->can_transceiver_phy[i]);
 	}

-- 
2.37.1


