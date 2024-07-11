Return-Path: <linux-can+bounces-965-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F092EEC0
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A174B2848CF
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8016E866;
	Thu, 11 Jul 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="azdNNwKg"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E016EB76;
	Thu, 11 Jul 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722031; cv=fail; b=i83mBsqt26yKKq/6s/6linJ+1oIIQNU4Jboa57uTr/pWXbSzaAilEGgkYhPlWS1jKiwKY5zGNtBKht8FhBtHGUsBnPbl6tsKZpL4digl6ni+k8f+lmAjSvDtpcoyoWdnZ+XN3D5NTNkBLP0xkjSIDwcirOrIU+dsxPOVoTYUiAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722031; c=relaxed/simple;
	bh=mT15hObaWTwSv2SHLwwESm2lVFZ3gRWzH0sKOD9wxi0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eiePskgziBX6Nc8ZNcuT9VEzcMtf4uikz8DUA2F42DAKaQdw+MOizbfTUdrp+n3bs9+kwjph2Wnd8wyI1DMNi3lDyHlBFZxr/yL7NNhz9tR6eSER8tPwsbEAPQZRpRuEmZco8KDMCLDo7VRS9veL+upDTgkfS3aeFNr/VQnZ2qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=azdNNwKg; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUxroqSqq7/eYiX4lhORIv/sY89uQBxFAICXSzp08Isorvzp8N5tIyDwYCP+HOg9ntA2qVAHIKNxTnt/h6HoMHRwTLD/ctOKuSEN6IvXBSL5MxonSY+gVmCJvTVRz8r0ysxUPv4xX1VLllKyvswgk/oIz6GgwXHjT+1ym7oFF5YdxFdlD/Ps1P5UlJo18MPdAxHkiZEq2KPVcJPX3HzmBynIUQxgnTrGKlVLiDKaCz8mv72PrD+jAYUdE7JXZDBAmhjAD4qSA7HMKbVkFdmdOWxlce3dp0ZzOh4B99C9T3WLfZLZBSZHsapNIj3EUxZvM2UW5jJBM25anX/DwNGJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbkVXBQxQVjnfM11TBjBsHzyJzL0huUuh+g/T+f4+Tw=;
 b=p0va/SeJQORm6tLb1bM4Go3fiQ4+zq9uN6LxqoCpdSPguEYfzjRIVRnUCUhqnokSl0+bGB/Sey/6hvKZInqjCA8lhdJ49J4kATq4l/Rv715/W3P7d/+62d9gdPwutWXrCBKrIImWV4JJ0riZ5nSQHtNTGtGZD2IQuSDatyeSZhqco04Z8EzlGQfwnKyR2IUWWLJwexmKFQVvgC4VYuiPPjiNRrIYfyOPBOe0WhGSPMzLTIQ3g6UwJXjNmGMp3DFyobYJIn2U+wSsaZxaaicw5kIvO0yUIbbJ/ARquLFQYEvVm1Iij8WwUQIJ+/3wv42xDpDeHM1nskWp+lHilvBhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbkVXBQxQVjnfM11TBjBsHzyJzL0huUuh+g/T+f4+Tw=;
 b=azdNNwKgxYGdP1IcdejAdqvIDAL9gxP3CsMEzeEMFI+Ulxtcq21FdfrUX5Gzrvrs+2KGH4mBh4Akwkzr6Pmv+gaFgk/pKimWvic3LdG5An7sxO7wD62JZtyYkqkSHNh3TjXZn3upNC1xah0lb44DIDIOsd1SHBLYG0UfB7OGDyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:20:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:20:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 14:20:01 -0400
Subject: [PATCH 2/4] can: flexcan: Add S32V234 support to FlexCAN driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-flexcan-v1-2-d5210ec0a34b@nxp.com>
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
In-Reply-To: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>, 
 Dan Nica <dan.nica@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 Li Yang <leoyang.li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 Leonard Crestez <cdleonard@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720722012; l=1628;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=80mv/LETBsFOYeyZH+dmpgodqlmtmDmGuf9twFeH9aU=;
 b=zHS3VlsJVO/eQoaz5sClQ2jZ3NchcruAtQNcFoDfZ9Aug6CpBW+nWqgoGQ9LAmCmEAa1c69Hm
 dHYZILbIc+SCquJjzIZ70jVgjdvISIQ9Et+hbWavlxWLh0wsQnGz6fv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: e5acb9d0-6962-4fdf-d389-08dca1d62360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qnl5aGpLYnVFMno5Zm9rMjFLeURJaWZwc0hpUGZQT29tZ2dDOGhVcnRmQi9i?=
 =?utf-8?B?TVdoMm9uWXhLTFJDVkdXNkE4ZVpIZzdlZTZBRFJvTlIxVS9lWStnZjdaQTkv?=
 =?utf-8?B?STFFTit5T3BUVGdvTHNCR2VUZ2RsMThYZXI1RENibUE1VDFodUFQRjFlZHBw?=
 =?utf-8?B?cmRJaGpaYmNtNGNHSnZSOHlIcGFyZDRZTWs2YStFbWVvWlkrUzVsak9EZitv?=
 =?utf-8?B?NllORnFncERRY2FnTFRqdFN0RUUxMlp4QWFFTms2anhSbXErYmpUZnJNTitZ?=
 =?utf-8?B?ZVBpNUlvd1VUY3F2QXhKdmoxcDh5V1d0NHk0b2E1bGhhU1Q3T2tjTFB0L0Ny?=
 =?utf-8?B?ZzlITVBMWnRkU0tsZmlwOVJpaEtMdDFja2tuQm0zc1pvTWxUdUVwMlVGVlZk?=
 =?utf-8?B?cjN3OVp2OUNIMTR1Rmg2UUpiUWRURFBMQWxXRVhtMGdIUzFQRm9zdWVUWEU5?=
 =?utf-8?B?aUdqMFFMTnQ5TlRaQllFRDZkN0tmeWFUQllNM1RnZzVxMko5NmtKRWFtM0R1?=
 =?utf-8?B?ak5GQ1BZb3BOaTJjbnNick1KdnNFcVZmd1pkdUNPZVNNbTVmZkEyUi9ERkxw?=
 =?utf-8?B?WXpielJJWnlvcWNFSXh6Z1VMVjFsYndWUXJDYU4vVHhDTmxyL28zWGxpKzZs?=
 =?utf-8?B?K01QZmJzbDRnbFN6bHVPMFJLY0JiTEQwTVB3cmVZb0lsSWNEVTlaeEh1N1pK?=
 =?utf-8?B?Tk1LOTZoMkpQYW15RlhlR3UwUlZHYkJ1NXlDeGR3aC9NNWRnalI2Sy9jcFlp?=
 =?utf-8?B?ejZueDVoakIvT252dXcvcGtZMkh6NmxqRHBsdWpMVkJ5MW1tdEwwOUFpekh4?=
 =?utf-8?B?U0czQVBITXFEdFpNaXN2SFRHUzhmc3dZMTRKcUpmYnkxUk00SkRrcUN5U3BQ?=
 =?utf-8?B?RitsQ3I3L1IzQUN6WnBNb1Vmd2Q3OXRyTVRBK1IrWkoyaytyNWFMU2dpb1ZB?=
 =?utf-8?B?UTl2SHp6WFhEaisrV0pxbGM2UmwvdnAycHRoTk9lcWExeXMzaTZWVkdkUzFa?=
 =?utf-8?B?VHRWVEJKM3l5M3Y3WW5mL0U4c284UEdXdElXbG16akJ0Q2FVdUExa2lJRWZU?=
 =?utf-8?B?YnJreVp5bm1kSmcyZFNhbDAxZHNnZXRBZkU4VVJVUzhZZG55WFR3OTRsWTJ6?=
 =?utf-8?B?dUdiRXhyREdBVXhYeDhDazQ3N25BUk5MREEveTR0a0ZQcHRtL3BqVFl2clB1?=
 =?utf-8?B?THU3eU9oWjlNWWN6OEJhVHB4RlBOZGpIa1AvVitSejZwMzh0NWNkSk01d1RR?=
 =?utf-8?B?S2I1WmtQQU1tK0FjdVBRcFZxK2lrZ1NleVR0aFAreVJvbDk4UXRhUW1QK2Y3?=
 =?utf-8?B?WHdESjM5T2JLd1JHTzlvb2NCY2JwV0s3UjNGKzhNUEF2QW1EL0gzSDloaUph?=
 =?utf-8?B?K0tzZzFwNXprcVltQWhlUTNBcjNoK0UyMmFPR2IzNWNpQUtlTTBOT2RZVWJi?=
 =?utf-8?B?Zll3c0F3L2pNK1hmMkJ4b3h2RDhTdkpDV2FHaTBtVGYweHRaOGxod1RHRldS?=
 =?utf-8?B?bEFjeUtvNEpHRENFS1FlOHZKbGhIUEN4cU9vQXhNVXJJSjU5YUo5M3p2a3l5?=
 =?utf-8?B?Mkc0OU5Ta3Zjbjc0RDZPZm1XemVLM1BsVG5ubnJiQ2l5VklTZ3pWUlhGVE41?=
 =?utf-8?B?b3ZtbXdudmd1UHM5ajJEdEhmWE9Gdk1PNGpMVExIL1JoaHVPSXI2Zlh0YnZV?=
 =?utf-8?B?YlJIK3JGMDJKQ0F6K0lnMGpiZXlxQkpLU3RUSVhKQ054WTVhek15Z3p6Wldw?=
 =?utf-8?B?Mkw1VHJReVZFV2krbEpWQkI2UEM0VFFyNldXcmZSZ05hM3dhRHpGK2dVQmpZ?=
 =?utf-8?B?NEdTbmcvSGdmdWNBZzFhYjhNckg1WDNzb0laRmhtMUFBdDF2TzVHbzlOMG9Y?=
 =?utf-8?B?ZnNML1JpenB5ZWUzUldPL0RyK3FlTmpkSTlRK2IwOFVjaFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0pkRW1nNVB0Tk9TdGUySThLbUptQXZQV01LV1lTN1JkZThKT3JVU2JrWHVo?=
 =?utf-8?B?eEdZRSt1RjVVeVFxd3I0eGlja2YxNTFGejhrTFBYRFNRTUlsTVJCYkN5QVl1?=
 =?utf-8?B?UkJQYUkzSFZaNEQxdjNmK2lQYjgzQmEvKzNqNlFRWFVOMUNJRlhabW41TDQ4?=
 =?utf-8?B?a1FNdlhLRHNTWVFmbVdKNS96REVjVVJJNS9NTHAzRmJzV21FSG4veEpiSHlY?=
 =?utf-8?B?YTRCNlFibnJqdFQrWVZHZUl4T0lKN3RoZW9pdkpWZXNNSFM1NTdVQ2tDQ2hU?=
 =?utf-8?B?TFhINkQ5VVR2OG45WlR6L20xcURJZllHdDJBcklPK0tieFNGWENobzRSS2hE?=
 =?utf-8?B?Rk1PdGJvUW43R0FVcTgvblg2Z1k4SjJTTkE0cHV1TzlLWmJ5WkM0Vk9zUHZ2?=
 =?utf-8?B?cnlrdmV3TndqaVFBelFKRHJaTGRsdTVmdVJ5ZXJ3Qk9LTmZieWw2QkkzSGl1?=
 =?utf-8?B?d0NLcXNXamdraXFEd0ZkTTVqRnFuUlJyVjlML0dVcFp5WUhQaENMekhQR0RF?=
 =?utf-8?B?RDNodnNGQ0hkczMvVnIwVVFDdFZFcmRrOXEwQ3pSM2J5ZExDVFNhWG1xWkhS?=
 =?utf-8?B?S3pFRWtCN0RVME9hZ1Z1dHJ2Nmg1ajRyUGpHUTdJL0NneE1GUWJXQS9kQ3FH?=
 =?utf-8?B?cmJaNG9SZ3E1aU03NFRlbUErT2duaC9ZT29hQjE1Ni9tM2VhNmhscjI0Vy9t?=
 =?utf-8?B?Wi83cVNmSDA5YWU2WmdPRUFqb1VrdFdqWlJnOUlobzFlZC8ybTdveXJBYURw?=
 =?utf-8?B?QkdCQXUwSkpDUUVNWEo5UUtCSWRqSG5rZlpMUTNTUjMzSWlTKzIrVkJsOUY2?=
 =?utf-8?B?K3o2b0U4cUxNU0JvaDJnZ3gzSS92emVCOFZxbTF0UHVNcUNaZndrYlowQVFi?=
 =?utf-8?B?dmRKUG53MFVaalBIMk03OU1NNHRpejV6T2VNN29yR0ErLzBZeGl4QTZUU01m?=
 =?utf-8?B?YkhtdmJ6NW90aWprZmtWU1JhVFE4NWtTY0h5RHhmaWRJU0VndnpmZkxPZ0V4?=
 =?utf-8?B?bE5aMjl3QkkyTlE2R0JUZEo0bFYzRTBxM3dDbkpjdk5MOFpDQ1Y2c2NxcjhH?=
 =?utf-8?B?S0lobnJaYWpaaG83YkYvaGtrL1JPY3M4Q0xXNXFqM2h0NkdKbGt0NGZ4Nmtj?=
 =?utf-8?B?dXQ5NjkrN0F6ZzlFdU1SSVUvTzRsS1NPSGloY3ZzZEhLSEx4M2taSEJtZU9t?=
 =?utf-8?B?VjVESDNQWDQ3aHZTUHphd01xVk11cWUxZHNMQUlId01kK2dxVTY5QjBNWkdR?=
 =?utf-8?B?akVEYnN0QlFhc3pZTy9KV2xHMGU2Z281ZTVVL09OTlp3R3k3K2Q1L2MvQlRt?=
 =?utf-8?B?R25ZOE1HbkV3aTZrczRnSEFhbnpQTTVtRmJ6ZjdyY2xjVFpBVThnbHgzN0Fp?=
 =?utf-8?B?MlUzVU5uK0VBZThzcXhocXJiaHhCb0UxZkh0SEtpLy9vUVZzVFJrTDhWSlB4?=
 =?utf-8?B?SkJkUWFLYmxYMXRxM2tlZHFNZFQ4R1AvbGJGZEJocy8xdGVwRkFNRmYvZFo5?=
 =?utf-8?B?THlCVGlINjlFcnlYdGxJT2VLS2ZhWnl0clNSTmV4bFpJQm9RNlNYWGY5UjFY?=
 =?utf-8?B?NkxQenU3Sys2cWJyVUM1V2dpa096UDVmcElTU3VMODVQaTRjNmxHU1Fvb3Jx?=
 =?utf-8?B?dENETUZkYVd3WFlKckxxOWhJb2E3UmpUOEcrbFdFSGw0MDFBU0hMNFdQbURP?=
 =?utf-8?B?Wmw3K0lRSUx0aC94VEN2MWh1bllJaUpQRHRtc1FZYlNMNWZPajEwTUhTOXVV?=
 =?utf-8?B?a0t3NUVGUUwvWGpEeE5peXVjWjRHV2hSalpuMjdVYThocVEvalRJTlo2SUlz?=
 =?utf-8?B?WHgxOXRDajJDVWh6Y0VtVU02a0tBNVc5VjNqNkh3R1VuS3NPRm53Z3QwSXlk?=
 =?utf-8?B?WUFPSVk4SnViRnY0WUoxNzl6VXpoeWxSL2cxSEg3dkRiekN6d1JkakJZNEV2?=
 =?utf-8?B?MW5GbGE3Y1hab1orWmpSMkRiK1JGRFgwdGlxNGJjRStUcjhkeTJ1QU5XNXdj?=
 =?utf-8?B?aWZmaldQV0tjcVJCRmJ6cFM1Q3lpYmV4VUdkNWgvUWRiMkZFK2FHWjd1Wkty?=
 =?utf-8?B?VEJEd3BWSW93cDVXQUd2amZjdlZ1alFMMFZnOE1FeVBxYS9IOFIyRERMaXI3?=
 =?utf-8?Q?gqO3XYodU/H5RhVHPldMiOvD4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5acb9d0-6962-4fdf-d389-08dca1d62360
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:20:26.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMb4xltugaV1kTQ//UnR/JIPoXOiP5ZiU6xO4gYAfTpWqYvD6EUgd70NnQ54iGOLa8aB5deZCVR3PejjJZip1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

From: Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>

Add flexcan support for S32V234.

Signed-off-by: Chircu-Mare Bogdan-Petru <Bogdan.Chircu@freescale.com>
Signed-off-by: Dan Nica <dan.nica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Reviewed-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 8ea7f2795551b..f6e609c388d55 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -378,6 +378,10 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static struct flexcan_devtype_data fsl_s32v234_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2018,6 +2022,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "fsl,s32v234-flexcan", .data = &fsl_s32v234_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);

-- 
2.34.1


