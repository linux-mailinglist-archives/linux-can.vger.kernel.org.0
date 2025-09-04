Return-Path: <linux-can+bounces-4472-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B55B43600
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDD4175467
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E82D0C75;
	Thu,  4 Sep 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g4CwnK0J"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793712D0C79;
	Thu,  4 Sep 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975078; cv=fail; b=dFEn1ieI4XKxIMATYzfnmbIysbL1tpraXTIxJmbUMxmNDUDpGYE5Y1LBuv01of60PAHU//KsBnjr4INvaFbi9pj9HLQVrP6Vo8BA3ualGOfAz0FOjoEgh07G8stkcAMRnP5Rd4rOB4NJnI+NIg6DpCIorA+FyQ3y/iftVTywIkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975078; c=relaxed/simple;
	bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GCzcUCgOyFAcN9iXqqfW3ZI2dnHbxcFfiTzLmgRkXbtpzrq75cBkP675Vxlgt/4DtGB5FLV/4IXknB2PMZAVhubkLb8fMTUerTb1NcpwMMlec4HG/Z6HdG2nKBZvUZIDFTsVLcTN+1+hmjBlEeWdy6xZNoVYfA7BOizvw+9x1Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g4CwnK0J; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX0n4jW2ljHbbBnajK1GRWRBdNGgqtAPO7oaBRQY3/9E4tj2IWrEbeeX94nFOc8dSl2oSvEPBEp3p4MbpwR2GmNcYnjI53MONvbTYsCFbHCH1evWLPiP5enntr5Q0pi6S5BHa+UfM+CvyJcdegd+2jKAKFLOGf8FDTqFAPR74ubsBbcw60LeY4IW2PcN1X2icOWUU05v+xAVX5Jkb15Ru6A5FT18qUWNEy+VplPJ2LxxT4fC+qTy3HSy7NZ2bunVury/KGvw6dz7tT/W/gZ0YY32T7cExId0weECty/CNCcid2Z8naxCz29tlHGYogpmQ4qxsdyN1bdIVUsXmtqG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=bO9KAcfOHRdkIBFa7hzKEaluoGd1WpTGbcAokEz0w/5+inVi70eXn+ElJHOk311jRihJoYD5RyvnvqIC/QyuQDopDoSspKEdA4nt7FEBTnRYIlDgAnlk/vN1kqvL1hXKNbIZ1AJbTV8K8bcizfdxjxhx9pNfsJ8sTaBTfPsYdszeM0DBPX1BZ3NVL9hl++Fl+EP52/Pp5+/Y505FZ/dlaNWfnAaOKqlCzQJt2VeAQMvccnZ7xeI7/7Ip5fxT7/bU3utRWb8H4khzhJCNSvmA6LD2k8mR4cVNeKCTXrVOfnfgUf5bl9v5T/FRDfrZl8GvIneIG+gza83jZVpjwxUC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJGsqDseOtrXvlkPOas7D4KpqFI0ZXkMojqpv4q8twU=;
 b=g4CwnK0JFTWJBIFO9yPYAJAUQ9hTWIcUKgC7+7vdMPbNnZS1WQuoWnqYoA6K42uCPd2XiV0jJud7AhJD58TXvToM24f56aWxmaviTfm2U3vQ9147Hspwe1qj7lJwHvfrTGlGdmUIyAPwp8opgfIR5G46jPD6AVH5UHJFLuMq6I4omlOb6roTHujoAo8OgLAJHj33T+dHHqzAiLOn4fKbpl0/F8ZdgVBqraoWlWBM2ta2gUXjm+NshBlUKqVi/9cbRx0ZjLP09D8veGo+76/+KbwUr3HUsaVTFjyfhDP5YxZr2pFbDIcM1KcHvsqAE59mltSoS+QsikzxRVpdlpAQag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:53 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:51 +0800
Subject: [PATCH v5 8/9] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-8-23d8129b5e5d@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=2835;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gwYAoI63G4t5m4cNemzDZqyMtsvawPjOsIwclvW3JyI=;
 b=dFVpZMra2uDe5Xg2lpc4w/wPaj3XD0ANi1dnyZdG868zHR9ow6slIhR5Ivxq/xpRh/IS4ENgy
 wel4YTLLgnyCU5YCfS/Ip5H267JgQmM8Z/KlqU/tTUo4hBJJzMuLiaB
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
X-MS-Office365-Filtering-Correlation-Id: 67805927-6a3c-4417-dda5-08ddeb8e56e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHRYLy9seVc2bFd1SEhydlM2eERNamlrK1VKSGFuUFRpd2txTzh6WW4xekhH?=
 =?utf-8?B?UGdTMGhqWEpUTkdKRENVM011dGRXWnlRcGwwVlpCM3NjMlNSWHg3ckV3UGJa?=
 =?utf-8?B?TDZVMVZtbVFTS3l4MWtCbnJ2ZTBuaUtRRVJoc0ZrQnFJMmd5ZFFuZUtad0FD?=
 =?utf-8?B?YWw0S1VUVkVEa0swRDFRaDN3MVZOQkxpK3UrNWdUU1ZDZmY5ZlhwYWwrTENp?=
 =?utf-8?B?SzU1WUw2bmNUWHhTSVVhM2tja0lvamtxcVRveHRXem9xZ3JCOXF4Sm1vb1R1?=
 =?utf-8?B?cHV0aDZiYTlKNDUrTExLMzFrVUJSR21pRldTSjBRR0RFOThKNnpJeko4SnJa?=
 =?utf-8?B?SW5wbmZHc0NpamJSdWpwUnBlVkFSdmcxWjEvc2UvNjhLbG9ZZW92c3djSllh?=
 =?utf-8?B?ZjVpOTRaNWtKcWNZeW9ZMkwvektoUytSNTZBM3ovS29kNHYrUC92VEpqWnBz?=
 =?utf-8?B?T1RjRzhDTHRvb2VSVWNOelE0blRkbjJ6b3pHd0R2TUtacXowQzVEMjh0NUpU?=
 =?utf-8?B?UFZHNkhDSmREK09qOVNYdUlaV3NYZU02aEhvbXNZYWlGdGpqWU9DdmdGZlFN?=
 =?utf-8?B?YXZwYTFQVzJmZmI5NEFJS09sU3hQK1pBZ1FKRWV5bjZzVEZHVXJJY1dHZEJm?=
 =?utf-8?B?YTFUdVkwUXA2UG9oRTZOTXZxaU9jSFgzV0luL3RrdjZ1ZW51UU91MzAwcDZw?=
 =?utf-8?B?VFk4Y1N0dDNjcGd2S3NoVTlCakhubDVvbHFiMi9YeWZ5YTVGRC9Jc2lRaXQv?=
 =?utf-8?B?em1LdWRkaGhmTWFMUzd0Y0E5VUl1SW16M0djS25GLzJrbjJ3U2tqMWUvRTBX?=
 =?utf-8?B?V3hxY2NIQ053VUpqSHdkV29QZ2ZRNTF0UEsvWUlRYXp3QzdZQ3ZNQVdXbnVE?=
 =?utf-8?B?c1c2N1pNZWxIajl3R2FYMkp4ZWttUzBlTThWUUl0WXpSV2RnM0pncFZWUUZS?=
 =?utf-8?B?elNUUE5MY0l1cnJCbHRGL1hjSWJxallrRHZzemxhbHh4UnlvUERITUlhVUFB?=
 =?utf-8?B?S09YSGpUOWduVHlxRHU4S2ZkNHE3OCtXdDZjdXpuYlhCdkRlSlNOZEliZFlM?=
 =?utf-8?B?UUxzaWYvTytXcDBtdFQrME4xbC9uVyttUlQ5dDZ5RE5BMkFUNjFzYktFTW5s?=
 =?utf-8?B?UVJic3p6cnBTekUvNVhvMVZ0c05WS29TZW0wd2JhaTNQTnAvaHFGL1d5WUto?=
 =?utf-8?B?R2NadGtXeHUxT2VjQ05lb0YyT2NWSzI2bldqekViNWVmcEFzZ0U5WE8wMms0?=
 =?utf-8?B?OXE3VTBLYjBIbTljKzJNWnB5N2dwTUZrUHpQSlozL0lwSlptOUlzUVZFWFZw?=
 =?utf-8?B?NE1XWW50Q0hwdWNJTXZ0aVR4T2hCNEhMMlBlMW1UZVoybnRIN0ZIMmZtL3li?=
 =?utf-8?B?WnVrVHFlbVU1SDFmK1J5MExYMVV4WWlFRW5sRUp4c1VVMmFITTBJdjR1dEly?=
 =?utf-8?B?OEJTNzFPZUpqTExaVG5Xc0dHWHQzbGtCS3ZtaWRiVlVDQlYzVU5xelhaa2pC?=
 =?utf-8?B?Uks4UjJqUmdQZGNBNlFoWkFpamk2YXcxN3UxcnQ5bDZ0akRRT2MxZWxzeFha?=
 =?utf-8?B?L2JvQkxPYk1GNWI3ajV5NkRhVCtvTGd2U1FjZDlkUEJZcVFxcEdaM0x2ZDFs?=
 =?utf-8?B?czBlK09Rak41dWtVM2VCRS8vaUZ1eFoyT1NBeWVlZnplU0FabXRCWjlpckNq?=
 =?utf-8?B?NGNFUkdyd2paam5pM2RRRFBydHh3dE9VTVdOOTcxbTE5WnY1NnBVL3MwOUZ5?=
 =?utf-8?B?WlplS3Vnd2FnYmJkMkhOMDd6WUFFY3Zid0I0UE1xTFd6WFVyTVZNaUpqOHRJ?=
 =?utf-8?B?bFd4a3ZrWUZGZXFoYnEwMjVtNFlUS0ZHNjZDN3RNUHJSa0RXK3NuZGE0b3M3?=
 =?utf-8?B?QjJhS05IUXlEOUhOUzZZbStqNVRuMnNidlg3RGZzS0lBZ0dvcHllZzdOVVJE?=
 =?utf-8?B?cjh0V2ZIVmNwVlNmVU9VWHdGWGNKb3FVdVo3ZkZ3NHY0U1BPV05BODJaM254?=
 =?utf-8?Q?6EJ+dh8C2z/SBFXlY6GwO/JtSuyF8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3B6d1FkZWcrdmMvSmRVV2Z2Sll1bnkwaWVRVExtcWVtNHRHSTFvK3FaRlRy?=
 =?utf-8?B?OFFaQmZQbStSazV5UjY2WlVNK01hM1BPTld2MWxaWkxxWk9NRlFOU3UzTnVi?=
 =?utf-8?B?RFVpVytXL2VjTmtOcXltRmJwMC9IM3V2RUxHaXZYN2R1RG43ZE04UmdYZEZM?=
 =?utf-8?B?MkJ5WmFyeU1PZlc5bUpFenJkN0hPcXBYLzNYUksxVUlEK2VKUjZLSnltQzgv?=
 =?utf-8?B?cTUrdWpQaWdFd1hFaTZ0NzlUTW5UaURQU2NiVGQrVjZyaGRJQ1lURkxwV0Ja?=
 =?utf-8?B?SzRHM3l3dDNLQm05NDBMWHRVdGk0N0VDMTlnNitTSEpyeitldTFkQVRqM3FT?=
 =?utf-8?B?NmJhZHR5QTBjWk9RWUErT0huSHZHUWd5WVk1VGMrSXFjYnZsa2RaOWQ3RlRI?=
 =?utf-8?B?aVRwQ0VrWDI2Sy84Z2RXZDJ2NG5UTkFhZWp6QUxWTVViMXU1UTJKTHIzZmlK?=
 =?utf-8?B?OTJkTU02Ym1EeUh2RHg3RGZuNEtaNFBIeVF0Uzc1VGlSczNnaW9ibHp3WVhV?=
 =?utf-8?B?enpKWEJMLzBxdHZwY055N0V5anFubHlKa1NYdzVYWDk0MGVkUHFUYXRucEEw?=
 =?utf-8?B?OUZmd3Fnc2t5ZTNOUEpGZVR5cDV0K2FqcDNaRXp3Q3dEb2poamMzamxyVjVU?=
 =?utf-8?B?MllJRWJGaXVkcjBnU01pMFJZRUNFNUpsZS8xN1ljRU5MTkZCWXNJckRYSFNL?=
 =?utf-8?B?NFM0bC9ZZUw3a3dqckFsYTYrNWxyN3FiYkhadUMvRnhncUxFb0t0blo0bHNn?=
 =?utf-8?B?aWU5YkdOanVVcUJpTTNKNWJ0dTVkMXhFckx5eG1sZ3VzL24xV3BETDJBdDli?=
 =?utf-8?B?QnFYcUZ4aEE3NWVZb0poQVNxSXhRamxkblZWVWlQVHA5WDkzbkxJTm1mM2V3?=
 =?utf-8?B?T1FsaW9raU5ZQzhKdHpCYnlUZng3SGN0MFgwYnNMWHNldStBNjFmSWpEaFA4?=
 =?utf-8?B?bk9mR25rMFdsRzlyRWxXcmNGUDc0T05hck5tMHE0djZIemRTbnhzMlo4Rzl6?=
 =?utf-8?B?RHNwU1hsTHNtMkpqQm1jQmpyMGZ3ZU81SE5qdXFNdjQ2Q3RvTUk5ZjdhY3ZH?=
 =?utf-8?B?Mm5XYWVkRVJxZE52T3BLVis5QVF5TmxpTmszOXRZSHY3MlFnbXNHWG1VNlZF?=
 =?utf-8?B?QU9iSGRBNUFoTDc1dksvK0U1OGZGRkVsaUszV00rV0hIbmxsWTl5VlVwbDdy?=
 =?utf-8?B?T09JY3NmS3JSdU50U09ETEduMCtxRnNKZkc5VzNoWWVnZFlTRHFXdlBRV3Uw?=
 =?utf-8?B?a0pRWnFPOUlTYkczZkRKcHp1ZHdLWGtLOWExc1VZb3Y2TUJWL3F2ekhkZ2xL?=
 =?utf-8?B?VndGaU95WnlyeUowRmRYVVA3SG5ZWC94WXRuNHdadW04eGg4U0hDOEtBcUh1?=
 =?utf-8?B?N0QvamkrSk9KMk8vTWlnWENOY1BEbVBvQWVORHp0dFFvMC9nZmhMYmp5d01i?=
 =?utf-8?B?NVN6Nks5U0tQbnBsV28rcWpFc0dxYk5BWUdENjIyTlRqQ1ZwZURqUU04MW5U?=
 =?utf-8?B?UkdCQit4RDJlOVhnSTcxVmRGTUljd0tST1U4aWZUVmY4WHZwYk5GbDZ3SDRl?=
 =?utf-8?B?a3BpWUFmSnd6ZStOeE1jRDJXdXJOV2xwUHd2N3N2b3V3Z2dKM2FLZ3QwUXlM?=
 =?utf-8?B?a2l3a3VVRGNXYTJlOWRVMHUrMUZPU1NNaVFzeEl6TkN0ZkxmSVRXaUhPZWVH?=
 =?utf-8?B?SGppcFNIQkxhTEpxL0pESlFwVlhKM3ZIVXdEVnJtWnFQcG5OU1BOTEliRmZI?=
 =?utf-8?B?RDk5Nlk4cHNNT0pwb3NoMU1TdkpkSXZLbUgvZjZHVk1SR05YSGRoUjNxY2xn?=
 =?utf-8?B?ZGgvRk5YVVdEYU1aZFlFSEtXZUJ4aWxJOWorNERrRkpnYzBCMGl0Q2N1L2F2?=
 =?utf-8?B?VWRSR1BsekdyYytidkZKb3paZHczVjVwbjYzRGJkSTdxelZTTndPZ20vdzh3?=
 =?utf-8?B?TTZDeFJXdy9FendqOFRTcmwwWm15ZXhBM2RmOWYwcFVwTmQ1aDZjVVM3V00y?=
 =?utf-8?B?WXhwblhRc1YrQkVMQ0RoNXBHMU1mVFhoUUNyQjRyNEpSZGEwdEpNWVJlQkpG?=
 =?utf-8?B?TXhJQnl2Vyt1L0NkblRVMXhjM1BQSjJNT3JGUUR4bEFNMUZFSjZrbyt0U1V5?=
 =?utf-8?Q?3ablgQdjiOfLKE2RgNk7j55BF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67805927-6a3c-4417-dda5-08ddeb8e56e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:53.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNI8IcXm1OR9ybvUsM7/wwPcTDWy1ZYWGidCYVSzueY9mJ9HRhwHeLLYmwiqAW58iRYcsz/lQNjRzEgZRYUxUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN transceiver,
not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3730792daf5010213cbb9f6869a8110ea28eb48a..59891627dc462d37dfd620eb68b893546cc20d6a 100644
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


