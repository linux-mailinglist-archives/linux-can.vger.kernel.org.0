Return-Path: <linux-can+bounces-4468-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D53B435F1
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC76A1BC8A1E
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB92D0C95;
	Thu,  4 Sep 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Enzc1Kpl"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943302C0293;
	Thu,  4 Sep 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975056; cv=fail; b=C3T9lHqqdmEUrCmxELp8jZ2LQbpkrBS/0D2BN5hsosx9T9ilp5e9yEiq+5bqMY0tzlBR2nGKzBfS2EHz/WctLFEjwORFdjHmpccTwjyiRyD7xDvhevcY+DA0T65/XrNDGp9KGasnBuoEepkxiGHSs8z+sKyPrnpNEhb1/GWieYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975056; c=relaxed/simple;
	bh=YKGDMNLYg/NxJJXSzfnnyl3khqx1hHk96DKMvJAE/mQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uPZtJ9MUNH4fc1BDD6BQO0aALTYL2nSlzcO6sWUQkrwAHD0zkrmwA+9AYdJqc41IUufBol8ZEcLHVo++xE50g7j5Tm3ogXdZLkBpRhTUQw52CwIXxYm1lHx+SQIy54+vyqyhJpgGk9DIpllRvWw1oPfr6rQU0XuJp8uc3MctjPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Enzc1Kpl; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALK+JoDG98+GQcOOGtuWTObBEEgRy7mka+kUu81rxrHJOTCJGhsmJ9X9Xj5+YL+vKojg7ipk+CQ7YwPNPWwPKeUgUmyfwwElVIC2DcIvmSrKgRkVjZr99+aWHmB+SGSAGJrVrIS85f1/W0DpS4Lgibbquv6d1Q1s6AHnh/vU5TslyCwm1V2qoRSsk5QIBpRUCuM0C3RGqv1h+sugNgzSeXwJSDBbxAj9rAKlpRs0MmLV5peh3HD+5eEmCwDyC/ptyqGV3j+6/FIy+Ir9XsA130s5+paT/Uw+9ZVySIiNeTE4fsvABJmlbY+v8Va+vJFG7Pssi0d9PsDgJjwK840hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4svSazKcshLtWcKR8E8o9ibVII81lS+1K6uJY1nlGWc=;
 b=JTccV8l2/LH3vurK40hImpNjhiLWrikjnUy4jlABmgU1+Vj2FASsU1pyFCTzxhqoaK9wyBWz6g2ss8gp8LHBw7Bj9Psberv28I15YALmri2ENrOfxwt7cTTCTRFqXxIo4PfQVfgSMpq5n+J9rGOjzHZi6BsF7cbgZwI1RXT0kcsrJqxHP9Rxjkk8KKg96fzD6b6O7k6CBveWqdMHNcjQtD1oVNLhv/nocRMyKv3kY70hrulU+dMVwAnr+0kKDkBg1NJXauAR8Ai81wpsCzObLO3lU/FGxbVCimjCQgRCUq99z+YBZTYKDXD94ZNDQLZU4l9q+w5n2fGoDblfBM6U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4svSazKcshLtWcKR8E8o9ibVII81lS+1K6uJY1nlGWc=;
 b=Enzc1Kpl+I3OLd6TOlogURsEQMWRIhUhJWre4IVunNAzJB+vWkehIUo2dmPPv5D0C1pCiFLPL+DFilj49Xwi0DU3Byu2u1kLvBjGZz8tXfek2jee9IunzmYQ7GRNEUTDwDCCgKvw1cCsCHxJVoFxZftQbfR3lMwjB+zQGxnsZLqZfPSa5IzYviW3LfKBwdxfEOXWcnYm3qbqqulSbZerlEXlPqxoxRtzY1ck3KhMc1u62rU3GD/+yMcjwBWLObmgOs/c5TbI7DcqySqiGesJwk748n59JDgzq4DNw2YFbWgmHcVmmtr3sX9Xa+9N2/pW/LeFCjdQQJ7ZvQ2jV1Kr0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6876.eurprd04.prod.outlook.com (2603:10a6:10:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:37:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:37:30 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 16:36:47 +0800
Subject: [PATCH v5 4/9] phy: phy-can-transceiver: Drop the gpio desc check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-can-v5-4-23d8129b5e5d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756975018; l=1693;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YKGDMNLYg/NxJJXSzfnnyl3khqx1hHk96DKMvJAE/mQ=;
 b=/FD1CIA7Cxq4TpYp87rMVy3t1L/mtByaqAA2WyzTEBquXTNajyccR1e0hsEe4kmtXqgxoK53U
 QZLtnXfwgerB5xR+kA+7TtFJHIxGh+HOLGksYSP3/0O2r9Hhvs/mLi9
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
X-MS-Office365-Filtering-Correlation-Id: 9c8286df-8a0b-4e3b-63ad-08ddeb8e48e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUtCb2tmOVkveTBTNDFqa2F1WFg4aHBzK2FvK1Nyelp6K1ZvZ04zNUh4WWdI?=
 =?utf-8?B?Y1lUeW12NmkzMDJnUXdUL3gvVS8wOEdlZjZuUUFISkxEUGxPK1NjdllMd3lM?=
 =?utf-8?B?T2Vxd0xZbHk5bHNYTGx4aFJlaytVVEFvNkRKU2hVT3ZvQk5nbzdqZU1jY0hU?=
 =?utf-8?B?T2hjaUp4eUErNjR2Y3Q1QllxbHlGZWRTMGdQaFQ4dlFuOXlCbzBFZEU5cHVu?=
 =?utf-8?B?MVBhNkxBRkFnK1NrNmJnaHoydC9RM2JGeEowK1p6SE94dCtwemMraWdVcEhW?=
 =?utf-8?B?NVpiOXJhMXRTS3VIWkxPMHNIekRKaW1US3AxYmtzSUIvcnRNOVVqOUdFcmFq?=
 =?utf-8?B?K20zd3JKakRHSHVUYWJSaXhkY0lYaDZSZTg0WnFQMi81cWNHK05EQXBZZElY?=
 =?utf-8?B?U1R3cjUzQzRlZnJ4dUNPRDhSemoyWUM2cjU1R2dwT2Z4UE9KbDBmOUdQSFpO?=
 =?utf-8?B?djFkZmF4WUhKbklNRldySFdEWlVxNG52V1lHb01WRk1LNElsc2hWUzl0WWtt?=
 =?utf-8?B?bkt0OE1iMFJoRDNPclVhVHU2eEdhaXNKTnRoY2JYVDRPR0t5dTFpUVkzSWJl?=
 =?utf-8?B?Qy9DRGZvbmQ3Uy9lejh2ZUpiVm9lUUVQc01QRTFRajBxSXprdjVtRWtzN05k?=
 =?utf-8?B?ZjhKQjV0R1AwVkJoOGI5U3RaM05Ya1BIWGI0cHhDRnhOUzBLKzlMRHo3Wmt3?=
 =?utf-8?B?N2orT2luOGhUdTJlR3A3b0Vwa0FJTG1jdlVSckZUcVpjVCtJY1ZnYzI2SzA1?=
 =?utf-8?B?YU9qZFF2aXNiaWNCQUk0TlduVkd4SmdPeWxxK3dsSGZIU2JPOGxLSlRtdk1I?=
 =?utf-8?B?cjRRUlFta1U1YmV5MEZteDZndE9ZclFuYURVcmlDWVJJenBnUkRRYTZ3aE1D?=
 =?utf-8?B?ZjJ1RTc5MFIzT3VOM0pBL01PQ2lOL2RxWDBJUk0zUGpiZG1hOTA4MG5VdE1t?=
 =?utf-8?B?SXFLWkQ5TkhKYlhTM2p4SzMvbmVPYlMyWm8rSHZYdmZuZGo5TDVjZzJyTUk4?=
 =?utf-8?B?akVzbkw3cDNXQkVFZTZ6MGVuRVJuN0dYd0tBQnNxZVRZaE9hWWtnSTRFMEFn?=
 =?utf-8?B?ZnN4RHBIaGFmZWhENjJRTG96Vi9Yem5ndXZ0R09IOE15aUdDVXRpamJKRWMy?=
 =?utf-8?B?QzFiYjFCM1ZsTTk2SjlIWDVjRGFWa3BwY3hHYlRmRmY0STYxN3htS1Fjb3E3?=
 =?utf-8?B?YWxrV0RkeXRTOUNFbmkxMXIzeTRFd2NIRTErVlVFWjZBWGV5OXh1Y0FRYjFp?=
 =?utf-8?B?dTJIVGM0WFE3VDFMT0s1cUsyTWllR2t6T3RJSGN5M0RacmdDNnlFbnlxOWdj?=
 =?utf-8?B?eUNXbE56ZUFvOFkwdlZ4YzE2cFB5OHFSQW1heHVEZkhneWFoQ2JEYlJUbzZK?=
 =?utf-8?B?SjBhQ09tWDdSWlU4ZjNBVk1WaSt5bjN5S2ZzVW9MZ2tNVXZHZEN0bnd3UWNj?=
 =?utf-8?B?RTFjeHRabWZLZ1ZnRUNWdUpGTzNzUW5ocXM4eU5VeHg0V05YN3ptMFFkK3Nm?=
 =?utf-8?B?Qklwck1xeWxNV1FWV2UvSEFsejhlbld5Vlp6N3oxVWE0dldjbG5MVmJXYmtK?=
 =?utf-8?B?U2dNSXF5b2FUbGdQVll0bndDeWxEOFExWGFjTmtyNlp6WU8rOWF0QUtFalp6?=
 =?utf-8?B?MWovT2dKTE80QXNNc28vYVFyTzdIbkVDY1JsZ1FwZ29Ka0NpYVBZR3BoTmdE?=
 =?utf-8?B?a1RVQmV2T1NLa0RaWUV0UlRqYTQzWUFIT0hzZ3FYWmhWVnpqVWVVdGhmLzU5?=
 =?utf-8?B?YkFnazJYdjE0bStTMXovb2V3TE15cGZHQkFwajFVcVFrYWlsRko5cnlMZk5K?=
 =?utf-8?B?bkZnVFNxbzBwTkRGckRYcXFqOVNZbWZPdEpEcFVadzI1ZVl6N083MDVkVTNt?=
 =?utf-8?B?WTdQbC9GV0w4TmhiWW1VcEgvRGJVMG1jMk50WTF2ZUU1UEJuY1NrUitsajBH?=
 =?utf-8?B?QUpQNTJSUjNyOTNOWGUxTG55S0lnYjI0NktSMjg1TWllMXNyUmdlczBWcTNB?=
 =?utf-8?Q?z5ps3/lfTpFV/leAJBtm5tnEzJ6eiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWIwbVlpbVFYamdsSUNhRWtkL3RKWEt4T2YvOHYyZmNsdGJrQ0lMQlYzQWQ3?=
 =?utf-8?B?cWxYVGw4amdjeENiSWFsdHM2MmZOY0p5ejRWdnVUS2J2TnpxQTVBUFNNdUMz?=
 =?utf-8?B?SG8xTFVNNkFnOFBwK0IzT2hOdDJwOUFWTUNwblpEQXAvaDNJVkViMngrS0li?=
 =?utf-8?B?L3NRaTBzMjVGNWRMUUtEZzdRUTJnRzUxTzFDbktId25nS3VGdFJNNTZVcHZQ?=
 =?utf-8?B?cG05ZUlGUHRBMzZObnY0ZjhEVGxQZ29YSHozOU9xTEl3L0RQbytpVDc5dVpE?=
 =?utf-8?B?MHlpdFhZZmlYTVpveXE5bXVKY2FSQmNPM2N2SnQ4WityOFpXeWxNV1J2LytE?=
 =?utf-8?B?d1BoZ0gxOFpLUUd3R2xwcGNvVW5LMFBUOUw1dHRwV3V1UG1FUjZTVUI1b3Zo?=
 =?utf-8?B?bXRTcXdlK1REWUt1UGV5SFVUcERTWjNNWHlHSXZzejNoZi9UQW5DMEhLV1lQ?=
 =?utf-8?B?c2tNQUpQZVFXejBLdmorQlRxcEsvTmZCVVRrcjQxSDRpaU1WWmllcXdVc0VK?=
 =?utf-8?B?Tml2V2NWaE00VFJPYjlhNDYwUUNtSnoza2dzV0VmRmZpdXk1cVc4aDI0eVNR?=
 =?utf-8?B?UmV0cHlDZlJVQWpaaTl0NWJVYVRsUmRqVTJtcHltVnc1NlNLUnhJQWVoWWc5?=
 =?utf-8?B?VDBFLytOT2RMWkMzUFNXRGIxT2dXbVJPc2YwdDZIaGwrNzRWSDFvajBuTktP?=
 =?utf-8?B?dTJlbnlLcnZiUXo4OVBud1hFSE1YaXQ4Y2IyL01YR3R1YS9haFh5aTZocExR?=
 =?utf-8?B?TG1tWFMzSG96M1FyQjBpZXlHdkxDRGtLMmo5UWw5N3lkMVI5cjhzdnpoeFlt?=
 =?utf-8?B?MmhreGNlSlgwMXBIODcwYU0xcnJaZi9xUG0wc1JEanh0bDg1VXM5M2s0bVhO?=
 =?utf-8?B?UE0wM0xHVzdZaDlGd1hNNGxaK1BTcVdiOFA4NGtrRFRYeW1WcWZXOS93MWNN?=
 =?utf-8?B?aW5CL2tuZ0dhSFhEOGNqTVVHZW1lNmNoUG10T0VSQWthc2Y5aEdPQnlRejdx?=
 =?utf-8?B?enlINFdkcGNHNzhuY1YwaHF6WmxPK0RUaDQvUmhWUWVnNndtRzBkQVZIWXhI?=
 =?utf-8?B?TlQ2SkJKVWNVb0VtNHJRUDFwcGNCUzhtTy9LYytHN0hXb2IvVkNUZC80cEZH?=
 =?utf-8?B?TkZkSEhyUFEycjRZaklCVzBXMkdJYlBDRk5IYjFzUTUwZ1ZNbTlTQm5RUmcr?=
 =?utf-8?B?ektzN2RPRkhVR29BczJmWVd5dUg2Q1BuNm9IOGQ4ZW5HWTN4YU5Eb3JtQjRn?=
 =?utf-8?B?MEhVeEF5Ull3ajFNWmxYV0pndG5nMzVFeCtpcmwzc0tNWTFGRkFRZ0FZWXB3?=
 =?utf-8?B?Y2JLSUtNZFltWjNWTkVFOWNoNFZXMEpuaXljamxuM3FjYVBWdHZ4MURUT1Vz?=
 =?utf-8?B?bTZydkRxMTBUWmJnSWxBTHZGaG5kSzljRGFkSmxRdjdJL2o3UmNrNlE1Z1BW?=
 =?utf-8?B?bk42MWV1NUlmUmNXMnV4SGNBV3QxekhwQnVTU0pOZUU1ZUUzZjNaNzhtRWV6?=
 =?utf-8?B?WGxMclFBUnBnV1pxVWlKZGlqdVRxVVcxVXdjTXBaK05JVCt4QlBHT1J6MUIy?=
 =?utf-8?B?Tm12Q1RxNkF1aXIydzlWNlEvTW5aVFptVVFWeDh0VldsYnBSSXFCdHNOT3JW?=
 =?utf-8?B?VXIwbStDNVRhcWxKN1lxZDZET0dhK2U5OHlRRWpDYW5uaHdSc3A3NHlCcjR3?=
 =?utf-8?B?S2pxaGtRYWhKYTQzQ0xGdHJGYXRHOVZONjNPaGVlcWtwZVp4S1V6bzlyM2xj?=
 =?utf-8?B?Y0NwL2JLTWRjNmVabGlRMEw5akdEOEdpNXIycTRsNWlDUU9YQnliQk4yVmZZ?=
 =?utf-8?B?NDBCT2xMbUFUY1d3MnN2M3hFZGlMaG9ldmViM0EzYksxMzg5R0swV2hPSWpC?=
 =?utf-8?B?bzE1WkRvamlxU2pFTGlCM2c0OURDa215UkJWM3hHbTY2aW4yOE5hZXd4bnJr?=
 =?utf-8?B?Z01LNUlpb2x5K0lxY1VmN2FGS1liQ0ZEOVhxN3lZR29ab29lQjFkK1BINVVy?=
 =?utf-8?B?SHhMV1F3NUl0WXBwUWUxNTl3U1dEWTgyM2wrYWdnWXhYaGFLL3lMTGJ3bTcx?=
 =?utf-8?B?Z24weW0zdFp4aGVrMnNOb3E2ZnFTY05QMjJCMGJWakRsSzJXRTlxRmZmUmY5?=
 =?utf-8?Q?9c6srWw7oLnZ+sM8n2plkyqyP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8286df-8a0b-4e3b-63ad-08ddeb8e48e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:37:29.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9xVzHywGoB1SXAd0JZ2PIxSh9Iv/A5PdyZdZcUwIKwjN64dj7EEaf81UlGKTcikptsPt2nkQRNF0JYORWsTbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6876

gpiod_set_value_cansleep has an internal check on gpio_desc using
'VALIDATE_DESC(desc)', the check before invoking gpiod_set_value_cansleep
could be removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index f06b1df76ada023f432dce892c3346f45397ab54..b7d75a78d9242e2003660a87d2d4c9f784aea523 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -46,10 +46,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
 			return ret;
 		}
 	}
-	if (can_transceiver_phy->standby_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
-	if (can_transceiver_phy->enable_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
+	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
+	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
 
 	return 0;
 }
@@ -59,10 +57,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
 
-	if (can_transceiver_phy->standby_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
-	if (can_transceiver_phy->enable_gpio)
-		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
+	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
 	if (can_transceiver_phy->priv->mux_state)
 		mux_state_deselect(can_transceiver_phy->priv->mux_state);
 

-- 
2.37.1


