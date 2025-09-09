Return-Path: <linux-can+bounces-4540-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABCDB4A164
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 07:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987DA1B27FCF
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 05:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C38A3002A9;
	Tue,  9 Sep 2025 05:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4H1o6Jg"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AC2FDC4F;
	Tue,  9 Sep 2025 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396497; cv=fail; b=KBoDkM0svAeXbWWRzB1gT6wIEQ7rT3TxiZfhap3X9X9Eknff6a2/ri4CQ+eUY/mZU9EX+qehmKhR1iQ6xU4rI0nfy5kuVErz1fNpJ39jWNtaU8arZFUBdkbuSsz2uYqhs4nmTuYtxmWG4ol2bSAcSEfeDHWoQo9cwIVbaTmn0aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396497; c=relaxed/simple;
	bh=7EzhB0LnPGip71YTTGnvX9hHZzkv/sdm8MVGPlZrRHY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TQKfx41XjhqDvPDXe8Zl+Q6gAPd5+g8WLYbBzxXbfV59aZ0gBluxxfWOFlSiSyApput12I+U4//kCE7Ro3TLsgcOtH4B1+ta8sKuKKxMRd9GdK7eySv606yZo4MtiUEBt5KYPC7JyxS+RU8b0hTp1t4gBGQfyL7LQCnhiXjQKWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4H1o6Jg; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I21FEbwttMfPpHg1fhrQ+iUwUKCYeWwXeR+n4E85N45d+ku20tt2hDYGvMMU9ZvZCFbGpUvR+zjd81EH6uoOl2dWvc5JDIFOPQ41QkKrZRV85bwzPDWBYCzSE9n279VBykyj6QjMM/YZWWTVLXwCOspSp7Im3sNcERkCyOSGVqKSdDyPRwiSzGSO2Aj2SmoUfk6s2kBx0WaYAs9bluMkFuBqDouoFnM0KDpCCfWLlQpmF4vkmlEqQlamiImg/7oozwmIn+VMnhIDlF5jTQe9d3TrVdhn4MRwMcU9ZZiMjfzWEbTZ6fB9aAZNw68aj1QgyNYfBiUn+WEz7AukYlnGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gcfSIV7MALdS9CCv3HPcM2vbeSjmjYNNdAIysx2LAU=;
 b=J9AJkeb1WbkN3Oh3UWtI4BncjeLnyedpDyjYrXf/cibmB20wpkECvQePKvgi9Kk3P/roaIYKL4V1ZPBrgBw7AndrJAymVmzThRpYdSA5W5XDZvf1cbWr5c3ma7S0ulCukCl/j9ex00ql1GyqQqAvcHC6Qujrab2hTy9oqq6sxsyey4GyjYr5V4oJmdensPJDbBEePuPe24V6UHO3HFEB3p+3zOuEoTscVS0vOr2k8gNaekghM+PHxZjni9Ao0R8zjZw6OTXkyoVZKfMDmVGuRZ3gTBDbzQmjbDDJdkK8ub3hjY9pgjOkxg9g4ws3jD6WLkKOFxu567cLrvtP0TFQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gcfSIV7MALdS9CCv3HPcM2vbeSjmjYNNdAIysx2LAU=;
 b=Y4H1o6JgxBQ6ES5SeDJBE+izgS8FaQ9rwem6+l/LbUH6RGZ+eXAI+sItJ9dNxBnX5sSW2g9joFt5v7ZTwXywwC3ODT/n5dnWIUhHDBPA83cY4C7qou4CVE9XSaRQCkApQxdu0C21k7NznFpEqMohhRf+Kff9urf0UKz/RBSDrKsvziSSguC+8TBLjPDUHBerlIxFG7zaas68DgNu/b+XjsHRfda6pQA8UqlKN5+yKbMtus2smoAAc/LzsAd+P93nnLjPqPNxBeeUgo4HqEf2ElsDsBwJRl49mEMk2VP1vT5dvYlEVvH4qjMJQwcxFK+VOo9nxBx0+THayLP6jeqBSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 05:41:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 05:41:32 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 09 Sep 2025 13:40:19 +0800
Subject: [PATCH v6 9/9] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-can-v6-9-1cc30715224c@nxp.com>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
In-Reply-To: <20250909-can-v6-0-1cc30715224c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757396425; l=1695;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7EzhB0LnPGip71YTTGnvX9hHZzkv/sdm8MVGPlZrRHY=;
 b=eHDC0a0xYnac2uCVVh2P5OkGo5FvXPc+mr9fBHtDQucI3/86G0SbZoaaMOOwmPo6lMS3NcuOo
 TkRIRmHtdKbBVRIU5Seha3Bs4muDXb4oaS7K68yBai9koNI4Xy8jUbD
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: f80ab484-7e1b-4480-245f-08ddef638601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU05V3dIdmJVUlRuQXpkUUhicFFNaGw1S2J5RWIrOGwvMEJ4dDBSZGF1Z0FE?=
 =?utf-8?B?WmxMbUMxZis0ck1oWlBFbjlHQzB0eGNRWjI1WW10TERMVDIveUF2bUY3c0Mx?=
 =?utf-8?B?d2J4VHphL2pmdE1PaFdVd09QdHlxQU05c3h1SEpQditvbDdud0NOTjk0aXNG?=
 =?utf-8?B?VUJNZnRjYUVYUm50bXhHOXBpY2YwZFJlandheXc5NGZGNWxsWVhYZVNSSVBl?=
 =?utf-8?B?akJWSEpJcitGaTYvY0FwMEdXL2psL0NwaS9PaW4wQkNuYlFDZmpZa3NYa0E1?=
 =?utf-8?B?OGJoWnltK1hmSWFQVFMxUXhTaHJBa0o1bjRyeDJwOUU4bllLZWxFZ3NUTEdx?=
 =?utf-8?B?U2JFU2Qyd1NwbnhiM0doN0RUNEJRR2F5VHF4VVJnSkduZXFXbzlhWUZrWVZs?=
 =?utf-8?B?S1lXVWdpUVFLR1oxdkZjeU96V1RyUEdPS21HOUJSSnFQVHo0aDN1WGwxN1V0?=
 =?utf-8?B?dzArcFhhV1VON2JScnR4aUd3MW9ZRVZYNGhqR2lob3VabHdzbUlGN0ZBSHNa?=
 =?utf-8?B?aXpOTWtmNWZ5eTVSYVoxOTNyOG9QUlBRcUpqcUE0WVZKTXJFQW1PZHg5dEVL?=
 =?utf-8?B?UVNya1N5a1pHZ0ZBRU5LUVdJUGd3K1F4UFJBSG1FbmhTSlowdjBqS2VGMk9O?=
 =?utf-8?B?R3NyMGltQzMrelpoSG9GQ0s1MjVLUkJONjVDdTR6djJSQTAvUEFJZ1FyR2hD?=
 =?utf-8?B?dTZ3ZWpUdzJEdy83eWFJS25FNzhtUHJ6UFV1Mi9ZN0t5UGpZOWM4N1I1ZlRM?=
 =?utf-8?B?SnFsZkZ4Yml1L1VTc0RESFNMdEtqYlZydDJuSTlrQStmVlNyWXBXZm9kQllL?=
 =?utf-8?B?bnh4aTFvaTRpSWxWaDZOdEhtNlpoWVZRNG5KYU9CRDhUTkRkbmNMdHRjcVNR?=
 =?utf-8?B?cytGaHZxZFdUaTdDaW1vOFBZMXlFc2s2R2tNQ1VJMnRaUEFycnVURzM3ZllH?=
 =?utf-8?B?NDlxTjliMWx0eFdET3UrUm5VY0JBZ0d5Mlh2YzY1Y1pFYitNTnVYYlkvZm5Y?=
 =?utf-8?B?ejFGcW9teWFXYzU1OWdCNU15Z29VSzFQbTdFUTNYMGxiQlFFRmZGSEk2cXRF?=
 =?utf-8?B?RTdjdnQyaFpabXluSnBLUi9Rczk5eCtvM1ZyR0cwS0JtT3F5UlFveUpkcU03?=
 =?utf-8?B?UzcxNVpkdDVRVXdHdFZHcFRMZ3M4ZG02eTRlRHN1MVhJQ01CN1R2QW9XRHkv?=
 =?utf-8?B?TGxZWWp1YkVVd0xxV1I1OVdUSE13TStiMndvSmpMd1NOdStDbm9kazg5L3NS?=
 =?utf-8?B?TzMrTjRkdGl4MTNFNXpKU1hmakxUeTZ3eUJlNHU4ZmRZZDZwbnpZYnlmeTNI?=
 =?utf-8?B?YmxsRE94WFpvNDJ0UVY5ZXRnckJWbFFWQTRKNER0VTZMcS9wd3hBN0NBK1JK?=
 =?utf-8?B?VnpVaU1TQm5mTTM0TE1xQUdHRFA4SThkcFVldmNDZEU5WlJQT1dtV01BWEI5?=
 =?utf-8?B?eWpNbnk2Wlp2djdsQ2hUdDZPQUY1Wm13alhrWGo1Z3FhWVlycmQ3eStZYXhD?=
 =?utf-8?B?Rmt0aE5YZjJpSDBHZE91UDFqcWdYUUlGRGIvamhONzJBck9wSUROVkpodVUx?=
 =?utf-8?B?WmFlR1RHL3hlbk9MNW8vc0VKNUxucDl4dlBTL2Iydk5OUzNJOW1adzZXTXNO?=
 =?utf-8?B?QWtjYUxwTUc2U2FXSlhBWEJGbEFQNU92M1VvZU5MUDhJWVBhVWh6YnJid0Na?=
 =?utf-8?B?TkEyemNPaEtuTTVlbmx0Q1dQSy9FZGJhTkpwcUVNK2REbmNFZW9GbmcyNTJJ?=
 =?utf-8?B?Q1NuTmFieVAvZzlVNzdpS09qOHhUSjljbHFRR3R0TFZ2OHkrZWpXeEkzUG4v?=
 =?utf-8?B?VFN1TjVTOGJSaEJFUG5qbGRtR1ROTkZUVkJObzFmZEVJaERqN2ZLMEhDMzdP?=
 =?utf-8?B?V01UazJoNE5jVU1rZzkweUtWcTlPTDVpc0J6eEU2V0lUVHplM1Z5eDRNQmdI?=
 =?utf-8?B?c08rQWgvMTFHdjVEM2VtVGd5TG1ZYjZPN0R4YTZIRUtRbFlqSm5DakJ4SWtE?=
 =?utf-8?Q?SyLsMDDzhwE7eWY1klMoQtdcYF+8qg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THFlNEVUaDA2V085K3lOL2haV1V2SVQyNXU5Mm5KeUhMZjZxVmxzeEwrdWZM?=
 =?utf-8?B?clZzUkJWSDJmSkhENVlGeGYxRk03b0VEL0xCZThRREhuVEFDZmZSMm1LTGxj?=
 =?utf-8?B?TlM5UU9pUkVnNTZvSFRQMlhWdmRHZnQ5eXQ2ZStNMWQ4K2l2aUZHZTRrQ3pH?=
 =?utf-8?B?SmtOREVJUnQxSEsvcVUyQnppZzdRQXdUaUdDdmlLMlhnQkQ5ZFlXQWl1Y0xH?=
 =?utf-8?B?cmN6VUoxMjlScFdMN0ZjUnhldE0wNEhaSEE2azRqTU0ybklPVmlEc1dtS0xk?=
 =?utf-8?B?UXA0WjAza3RQL00yOUlnekU1Q0FDeVVnTktGNVoyMGxpOG0vV0hQa1o5Y0Fj?=
 =?utf-8?B?WCtDa2NIMlR0TEVRelRsdk93cU9TaUQwVm1GRDZ2WmZQTHE4T0xmSEZnZEFj?=
 =?utf-8?B?d3RkTGRuaHMybnBkT3FkeGptMzFkQzNkOUUvREpJOVQwRGpPb2piSS9EUFkx?=
 =?utf-8?B?UWppUFUwQ1NiOTNzcGJiaEtBNlNaQWVNNVVkRXpoa0pTQ0VtcVdlall2ekla?=
 =?utf-8?B?dWxTMDA5VjFiMG1xa0tmdytubzdRdTFibHhJcUpDUnNWMFJPUUxVRnRtcXhM?=
 =?utf-8?B?YmFFQ0JrdEd0MktwUlRFZ0VxMmFSeDVxVWViQjhCRGRXVDlGWEV3VVN3bGVx?=
 =?utf-8?B?MG5JQitneEY0VGVRTE04V3FRa3dTSmV2MnI0V0p5L21WVmUxbVBTcERISnNv?=
 =?utf-8?B?aGpXYWxRWFFndVBEWTkydDBBblI1ZTRsaENiemE3NTRoS21uVllFQ25zUlRZ?=
 =?utf-8?B?SEtSWjVPbGhOT0xZaXgyakoyanFSbjBxL05QdlZZU2ZxbmNtNjMxZTVMRXc1?=
 =?utf-8?B?RGxEeFU3cjBJNVZLWmxrb3BCVHVMcmdIZk9qWVZZcVpwZVloQjVJU1FhOUFK?=
 =?utf-8?B?dkovVVMvRGVBM1ExQjNoM3VidzY5MjNNc0ZJd3N1SXU5N1FnendwYmkzdnZ4?=
 =?utf-8?B?VVYzbjFYU0cvN2VJRUswaG1lSVRUY3IyMnZIY0h6Sk9zZ2pYQXE2b2ZHRU9H?=
 =?utf-8?B?a1F6ZWpGVWxmU290ZEhzWVdxRGtOS3RzdG1ETVJoZnFsQllJL1hVZVEwQTlx?=
 =?utf-8?B?cjJxbUlYaVFMb1VSeU5NQ0U2ODAwUmtMVS9VeStTYlE2VlQzaHgweTJ1NXlo?=
 =?utf-8?B?U1dIZTBLbUVUVGd4WkRSelc4V1pzRnZBN1Q1cThCbG5ZT3Vlb3Z1cU1ZeHRM?=
 =?utf-8?B?K2w3Q2xKMWN2N3JMTjlYSWZ4RTJFUCszbnNETVp2THhqVVpxNjBDSEtEWE4r?=
 =?utf-8?B?WFJtNG8yYmQ3K3ZKVndTZnV3RTNHWnJta0NZYkYva3VzYXo5Qm5ZK3dJZVVD?=
 =?utf-8?B?d3dzR3A1Qk9jOXBkQVowT1ovQVVHME9WSkc5ZHFqbGNHbUJPZ2dRZXkzOEZh?=
 =?utf-8?B?QVZXTEpZVFY1bzhmb3preU9SMTVSOE1sSk53RDJITkRjTnQxSjNBeEpuTDhn?=
 =?utf-8?B?V3NLU1BwS1l6aksvRVVqRm5WcUNkeHZJUW0yQWx4NUFkclBTOFZKdXZVQzN1?=
 =?utf-8?B?cHdDOC8wblZJamZVK1VXOHJYM21pdmJ5Q3R0OXlnVDBkZGo5THdLZ1VBd092?=
 =?utf-8?B?OUo3Zm10S05ndlJxRzZvbHNrVURvWW5MQW5zQTlDeld3bjliV3BObTFEcVAz?=
 =?utf-8?B?d3E1SVNSK1VVaW1aaUdIeHdUelc5ckptWTEzNFIwZkNONUQzNlJIeUEvN2N5?=
 =?utf-8?B?dWhzNWFob3BUVzBOVGMycUNEdzdIdjJhWnQ4aDhxWlUramtIMThqZThSSmFk?=
 =?utf-8?B?ZE1MZXc5WmNadmV5ZEk4Q1k4WW9xNFd3QTE2S25CN2FWL0FzUmI0K3J0aDlB?=
 =?utf-8?B?WTNHcWlmejR4RVFKam5LOFhRMk1VNEdvcElVbkxQZ0dDZTd1ODM0Q3hLcitE?=
 =?utf-8?B?dzVWN1p5cTJuL281NHFWWGZibEsxeXIzR2p0aVZpY0tRRmhJOWFvM3BxN2ww?=
 =?utf-8?B?ZTl1b09hbFl0TlFlaUFiUldLTXEvWXRoTUd6RGJzVmw0RjZkMURFeEJjQnBz?=
 =?utf-8?B?akY2TFowcXpXZUFseXVsRkQ2cGsrRy9ZUVRxOExJbDRNTUhwUHFSTjFSV0d1?=
 =?utf-8?B?UHBxVGtjTWRDMGU1Y05NZDB4eXFmNGUrb0M5YlVHMU5VcExBcHNiMVdqYmoy?=
 =?utf-8?Q?6EMmQFjUIH3jNV4qjUyKg00u4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80ab484-7e1b-4480-245f-08ddef638601
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:41:32.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aggbXX0ObSFk7BJCY3PyvISFmNLplCkijDPfv5CSLM4UGuybPaC9ufxvgrkQSsikRrhv/Bz4CoecfgzIX3j57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

The TJA1057 used on i.MX93 EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index e24e12f04526c3a08c0bdc6134297fb010e6e926..19d63f7efdc51bb097c6e51bbe7bfaa533218ecc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1057";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		silent-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_vdd_12v: regulator-vdd-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_12V";
@@ -87,14 +94,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		enable-active-high;
 	};
 
-	reg_can2_standby: regulator-can2-standby {
-		compatible = "regulator-fixed";
-		regulator-name = "can2-stby";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
-	};
-
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -284,7 +283,7 @@ ethphy2: ethernet-phy@2 {
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_can2_standby>;
+	phys = <&flexcan_phy>;
 	status = "okay";
 };
 

-- 
2.37.1


