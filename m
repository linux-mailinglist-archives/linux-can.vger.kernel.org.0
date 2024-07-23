Return-Path: <linux-can+bounces-1001-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD2293A84B
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933C9282DBE
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FEB14431F;
	Tue, 23 Jul 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G8k0qkS0"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B64143890;
	Tue, 23 Jul 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767747; cv=fail; b=ayDZeVDf/jjBsg1pq5RwTME1id48gJArfS0aPO+pO8rOA22b/XpqPIUZPaIg15phbLLMqzkYarz9iAKp7hfmcLL6T9R69zH4kg91CQ1MDO2qr2kpYQLvZl1rd9Iz5NYM+o8JpDBYeM/q6wSwt2m5yXMdhI5tl5pNWve9Fyt66aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767747; c=relaxed/simple;
	bh=+DIGgBkBWyrtYQfrFvCkUgA9e8HOpEMFLYOPNyi1qdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UHqNzTW8VgjJnEPBBejfQyyhn8iw1lwl8CmDPGIBF59KFu5FzFam68w+4YQQP7IQgauSefjnFeNPR+/FjV6KKs1/K/E1nGwFHqhCQbfw33L2crt3d88SAzXRW5D2OKDCFL035oLyXMe2SsEubhs9sBnRBBqeG1VyWr0gqzUyDjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G8k0qkS0; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YudmypOx/lqotYiK4pRRq+1jhaWoAthh0iVoZ3egbWxUAfc5OgZZ7EYfECZ7rsWuX6RqGne3BJNzpVPgeUHInqw14t8TtAUPKBY+W/ASjnKrRDNy7Leuj8GvPD7etYerjYK/TmYc8byQ25frg2DKC3dhq8IqFPGBdpdVK5VRfcaerB3LfhE0FYh2fdOUApUFGTK5pmlGKZrIauJ9bcifoXfKK1JPRHpnKowMpAsA+ikr8FTkoXC0VnMHc6To36rxM/Dlq3RP4dPhD79sM70ZE0Xp0xOxHN1bssrQV3e85DxK/ZLYrApF390uyB70sH/Zsq6MTH8NLIElLrWawNOecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOd6FLZLIcIbPo0Sq0J+NOU0MeVyh5JVCAAuAq9yNW8=;
 b=npXPwP2G5czNupn2CKSZ6kRACgw/EoEMVu4TYIHVCtrNiACs6DhR3xnYpiFhmm/G4uprfJl2QTZMy5o7FfCZ7dUTw69crEqdZ3+4f0HpczevKbpOXPSrRrteD+ztU3eeEUmx2goL2EVJYIKRChACBB48EEUbRkKN5EYgG4li72Y/0mWOhTQs54pDIl1/z6GBZnaw7JSp0aVzSLG8KjCfdhtKeY9ffT+B5KHPTvoYnF2wyAv9eph1VuDgnAjPYAwmCcas+tafonulorYYozN7+McNF4kg9qOlnYm4Wmznxe5OJu0HIaoaAorKykU3ojUf7yNcIIEhge063/wGz3KVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOd6FLZLIcIbPo0Sq0J+NOU0MeVyh5JVCAAuAq9yNW8=;
 b=G8k0qkS0OuLi2QYdeXL3mPf2HmZKt47BUUCe+gIPqgktqEF8QZqRPmVgbDSzKrY5xTc0KLN5U48JqkOGFUyVRF3LvKUvg5ZgPMtAOCFn6J2TPqYH3+qupYjisi1uwvqgJw3LiAPyoyPqRY77hkj6zYNjhI27JxCKWqQMGNUtHEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7470.eurprd04.prod.outlook.com (2603:10a6:800:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 20:49:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 20:49:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 23 Jul 2024 16:48:35 -0400
Subject: [PATCH v3 1/2] bingdings: can: flexcan: move fsl,imx95-flexcan
 standalone
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-flexcan-v3-1-084056119ac8@nxp.com>
References: <20240723-flexcan-v3-0-084056119ac8@nxp.com>
In-Reply-To: <20240723-flexcan-v3-0-084056119ac8@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721767734; l=1301;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=27/RZ5zCVbTg9TNZoQv/itKKz/Wfggk4JwdgIMWCZlY=;
 b=v5JugKZkOKWzrtL3E16bSa64AWylOaks00Mc+2pPbTbpiOvOM3c9r9v7dSL69ciQm2QVrByKg
 qy9174fat0qAv+61RnAxRTYwG0mz7HHw7U3fNEWOeNutjgJpk9xVP9J
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: f296aae9-6c7e-4ec8-74f4-08dcab58e2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGluQnp1YjZNRTVON0JLVjBLdjNNckdNeVVNY2RodU1ndGtGenJTdkNEUmhI?=
 =?utf-8?B?MkpvWCtmemhra3ZpV2hlWnhzRU5yNmNzZ1VxQWU2SWo3NVJpNlh4Z1VRajg2?=
 =?utf-8?B?bnplS2FuUFFqdWpjTVYwQTYzQ3FDc2x2TzFJUXNTTWkwN01vYkE0MEdXMkxD?=
 =?utf-8?B?MWVPS214U1N6Vm1FTndvOUMyUlJxVG5IdHZrYTQ5NVVMb3k4QWNPRlZHaGZ4?=
 =?utf-8?B?bzJsYzNWZm9ack42K0gyaDVuR25RYzRBdmFzaHcvT1NIUFp1SlJUdDh4WnlS?=
 =?utf-8?B?bU1JNnR5aVcreURwYUZFSE1LZ0NHY0oxY2FVUklVdDI3VVNzN1RibXdCTWZm?=
 =?utf-8?B?czg0UDAzWXJEWi9mMXlsOXFMdklyTmFzRE1YdHdxSUxnajNSbHBpUlNCcmxZ?=
 =?utf-8?B?L2J1ZGgyczVJUnpDZDJFL0pJeUh5TzcrZXpLNEs5UDR0SG1POENhVDdJdWVs?=
 =?utf-8?B?Sk4xWlh6N0NLOUR6Rys0QllnS0xhcUg2V1MxTG1hdkMyd0RIZnBrYWIycUN3?=
 =?utf-8?B?VDFrYW1WUUY1S3lrUnVXa1d6c0EzUVRlRkl0cCtVa2Z2QjdyZ2VVcVVDWC91?=
 =?utf-8?B?Y3YxQnNCc0dMWU1MVEdvczhKWU45RUpTWGE2enBhaVVYOER4dTJvTkJZcGZy?=
 =?utf-8?B?KytQN2VLQWFlRGdvdzNJRzZjSng5ZmZCQ0YvcVFBQ1NyTmV0TkN6K1E3dUxT?=
 =?utf-8?B?K1BOQjdRWmRyRnNFNVZYRWU4ck1ybkpKYlZGV3pYYjlHQk15bjl1TUJrai9P?=
 =?utf-8?B?cHlQcVI3aVErZVV0RGRtcTh1NVA2V3dNemVmdWRHbHFmbkxZSlpaWGQwVVg0?=
 =?utf-8?B?RXNaSWhMRHN4d0lpU2ZRNWdjWCtudXlyT1F4eGdwYlhscDljV3pSM0FGcTVm?=
 =?utf-8?B?R1VRTGFLN2ZOZ2FYcEkzRlVYYXZISytpNGxPVndYY2VPR3VMQnM1aWNOa2tr?=
 =?utf-8?B?NnQzbTV4VTkrT1c3QStsd200SFg5NnozRWRPUHZUOFBvQ1dnVC9pVnM3akYr?=
 =?utf-8?B?SC8rSlhCNzNXT3NacUhZL2lOTVJlcWRMZlRtSW5PbGJ5RTgyY2VMWTVDU3Rh?=
 =?utf-8?B?UWNNRTVKL0RSenJTOE1TKzZCeGQyM0RyTS91WVFJdjI5aGdqR3M0dW01VTMx?=
 =?utf-8?B?YVIyK1lZeU5scnNhY1doVllqZlI4WCtPWWRWQ0hSNGg1ZmV5dEZ3VW1jUW5z?=
 =?utf-8?B?RTFkbUdaVWFzclpLOTJkNm1VNFZ0WDQxNmNicXRkMy8rd1U2cldoWEhXWFd4?=
 =?utf-8?B?dko4MU5henErNThMLzJRMlMzTWt2K2ZtN2IxalF2cnByR0xDSVlFTFd3cnFL?=
 =?utf-8?B?dXB4dmVTMGpYSUVBNG5vYnpRdTRwS1J6a085QVRPR2VuMURCc1JlSTZpNnlX?=
 =?utf-8?B?dzRtOUl3WjcwM3k0cmY4SjlpV2RCUnVZNXVkYm8xZlNoeWpyNDZPcG5vTlBi?=
 =?utf-8?B?ZVhuVnFUN0R1aFhRWWxFQlNYYXJHaGhMd0lrdHhqNjhaV0EzM3NvWjIyQnFU?=
 =?utf-8?B?My9LUDhGV2hjM0syQmZqcWh6VWlXdERXRlV5eTF3WXFyUEtUak1JNC9aMzZ2?=
 =?utf-8?B?V0RvRnpIRHNBdGNaWmRRQkpJMURzTWM1UkJUUG5NUm1ZZ1dCN0RESlZPK1Zv?=
 =?utf-8?B?Q0JxODZNcVcwMmY4K2RmS2JNcm5xZVRsajNwTndMejlqUlFZQkxPREozWUsr?=
 =?utf-8?B?d3YxWVFXekh2VExPUDV0NmZWRmJmYUpCRy9vSVJ0ZGZBd1lMQ1V3NVZwbzR6?=
 =?utf-8?B?TkEwTTQ0b1cvOHltcHB2MDZDa2s3UEJRc2JTcE9XeWFOUEZ6L2IyNFU5YW0y?=
 =?utf-8?B?RGJTYTJGanZINmxBNFpDK09CRTQwNzlkRUsvMCtZTndESyt4QnE2SHVtUlph?=
 =?utf-8?B?cW41ZXFGSFY5MXZWUXlER2dwYzJYZzFBT3FGaU9SODcyK1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUVOUHBmbm5PZEt6em0rOHJ4bkhpanl0dnczUmo2TTFtcG1GdWVzOWNsZzdM?=
 =?utf-8?B?TUFPbzdpYjByQmhYSVZYOXhqNnZiR29CZWhIZk93QmZyVFlZZEhQT1dPS0I4?=
 =?utf-8?B?V00yRGZNeE0xYUs4aTBvOGhnYjdsUkh0K3VxeXR3UVFUSXRpRmxmU2xoOWFZ?=
 =?utf-8?B?WFRiNURySi9YMkloTzFYZXhMZnBnYnBMTTQ0dGt0TFdnOVU4VGhkanVKQTlL?=
 =?utf-8?B?dlBDZWN3MVNNWjNibzB3bExmVFozdlJDeDRaQW1aT2JFQ1hzMExHcVFCYmxa?=
 =?utf-8?B?QmoxV0h0Z2JBNHVsYTk4aVRxSEhRSnVuVFpaaDhVSlJLWHNKdWRvSU5vck9s?=
 =?utf-8?B?QmExM0Y0Vy9DYzJ6cG9Vc2VsL2wyU0pvUWhzRTVGdzUxdkZqOXVtTHlOdVhi?=
 =?utf-8?B?L2xTbXRIVlU2c1RqaTBPMVNMaU4wSUpsbG1wRWFMVXh1OVIrcWZXTEc0b1lZ?=
 =?utf-8?B?cTRYdm41eXBjTndPWWptTUxHNHlsOEJ0TEZiZHBraUVRVGNyQmE2aElkNkxI?=
 =?utf-8?B?ZEE4Wk9Yem5HSFNId2FVNWVLa2g2M0UvODl6MVhodGZ3T0E5VTFBVGF2NXlN?=
 =?utf-8?B?QWRzbHovcTZvOENsRS96OWplYml3SGhrTnczREVlb3AxaEFUOG5uSzcxWFZZ?=
 =?utf-8?B?YXFjOEpWcDlkaWZBU1EzTTRqS3Uxd0VjbGVzVXFZdXFmdnRIWWh3SktCNUpo?=
 =?utf-8?B?emNva0lkbkhpeWhINUw0R2Q2OFFXYlpsdHhJQjQyWWlhVGpydGc2bzh3WXBk?=
 =?utf-8?B?OExiVFNSRmFham15QjRwTWZTUng3YkRJSFg2ZVM2OHJrUEdxK2pDSk1ESEJM?=
 =?utf-8?B?ZFhMRnZja1VDdkJ0d2prTWVpUFN5YjI1Mm1uYitSazlmNzZzTGpObHh3bTJr?=
 =?utf-8?B?TXdVNGNneTVZdXN1dE03d2VUSXBoWmIrdVpkRllNdi9pM3oxTXpZYm5nQ2xY?=
 =?utf-8?B?M0pnanMrUDA0eGNUbzc0SmJTMzZnS3VzQWRaK0JUMW44S0ZxdXFGb1BFTFVw?=
 =?utf-8?B?NjBOY0Q1WHpkZE9kM09GS01XL3kvZnk5amVsU0ZyTjByNHJDem4rZGhQb0Fv?=
 =?utf-8?B?UFBXcktOY21oQTFIOXFPYVZTZTV1alRIQXBHNzgweFBFNVZjaXE2NFR1d09W?=
 =?utf-8?B?Z05FM1pJbVFSa3BRSG5Tb1hYU3NQZGxjTGI0d2ZmSmxtQmVmQjNXWU0rakd1?=
 =?utf-8?B?WjEzWXlqZlRWdURpOElkck9uRXREVkhCZGpEMmV5R005OEhFWVNtSWpqYnl4?=
 =?utf-8?B?VTRUdFJrRjF2cjRqNkNDdFVIMlRTb2dQaHp0UURZUUd6dnZPVWw1eXdJR3lY?=
 =?utf-8?B?RDBvejZiZjhiQjdhZTlReDgySEFEYkp0LzNRa3hRSW1sK1NrSGRHVDAwRjBJ?=
 =?utf-8?B?MG1oUVFNdytRL3A2RkROTDQrbzIrUVdxbkdjMkpad2ZkaDBPWUN1Tzhoei9Z?=
 =?utf-8?B?REJ1cHlDS1ZlRVNJVE40YmJuejFpTjVBOXk3VVpxQ2UzZWw5eURudjdKMFFz?=
 =?utf-8?B?cGlvMDBDeThMRHVrdFgzS3hVV1BvQldLNUJzS0Qxd1ZCL21qaE1rQmVLM1lB?=
 =?utf-8?B?Tm9uT3FFNk1ickFtR2p1T2xPTlJFOGprZEc1b1VTanhLdFVkNWc4L2JnZzBj?=
 =?utf-8?B?MmE4SnlzNjc0bmoyVlhNNkRXOFhDdFJtRjlOcDFsR3lvNGIrZzY1eVdEQSsw?=
 =?utf-8?B?ZEdaNCtkcndHUEY5MkZoVzdrQ0UyK1c4TXVlTk52cTFWQzdFTXJCZVJxRER2?=
 =?utf-8?B?TWNEL3lvTDhXaEp5NEpRdmhDb1FUSGNNZkhtMHgxL2h6ejBiTkt4eWxMYi9D?=
 =?utf-8?B?QTZna2d3dmFOSWczc3NGcGo3Mld1c0Z1QXJDMnJLZGVEMEo3eDNib2dJY2tX?=
 =?utf-8?B?Qko0T3NjYjJuYm83MENWTTBPK2hmU1JONnFWQVlNaEFHRXJTUUdjTDc5TU91?=
 =?utf-8?B?a09ZSmpaTW82VGhDUUF1UkpOMUJiV3R4QVhaZVpIOXNaL1JkY3dncTlINU9G?=
 =?utf-8?B?dXNldmhjOGM3ckRpSTlIVnY1M2g3Wi9lblpEdnhmMlhCdDFkODhHSEVsdGxr?=
 =?utf-8?B?L21zK05CWGY0T1FmdVI5anRmTGF3ODN3dVllblFiZWNFcnFWd2t3b1VsL003?=
 =?utf-8?Q?91uTzHsr6UWcn+gJRGFO8pMVi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f296aae9-6c7e-4ec8-74f4-08dcab58e2b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 20:49:02.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FcoqP7nHleB7H8klB/RJg9rF1/pncOAyP1wIhdF68pN8bXpdeZVuiciC9h5F03d2S43VHyDmjCuwXKrcInOtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7470

From: Haibo Chen <haibo.chen@nxp.com>

The flexcan in iMX95 is not compatible with imx93 because wakeup method is
difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index b6c92684c5e29..c08bd78e3367e 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx95-flexcan
           - fsl,imx93-flexcan
           - fsl,imx8qm-flexcan
           - fsl,imx8mp-flexcan
@@ -39,9 +40,6 @@ properties:
               - fsl,imx6ul-flexcan
               - fsl,imx6sx-flexcan
           - const: fsl,imx6q-flexcan
-      - items:
-          - const: fsl,imx95-flexcan
-          - const: fsl,imx93-flexcan
       - items:
           - enum:
               - fsl,ls1028ar1-flexcan

-- 
2.34.1


