Return-Path: <linux-can+bounces-978-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB16931C9A
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 23:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9622827E5
	for <lists+linux-can@lfdr.de>; Mon, 15 Jul 2024 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D01442FD;
	Mon, 15 Jul 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N4OBeEaE"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17B143C72;
	Mon, 15 Jul 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078874; cv=fail; b=RmLFTZnvLYuQxiLL1uWNkF67BzQ3NgsH17kvKcBntXNsQP6a37amCIEnZipxfA8FxCHtKg9EUpyzOBzn18zGryQULSvANtQug4kvDNNQyrVVH+ijXDT/FdcIZN1Y12xdj0a8COlGbFrW3Lz9B4tzgW1zaBKHqWLRdkQKUb7L2lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078874; c=relaxed/simple;
	bh=BDMPlxeguvTdR7tbMlQo7Ms11jQeZFOQkfxYh+b8HnU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ncU2c2SnT+xnhvMv7Llymgo6jxn9mzLqxZr6qt7FgSZGgE7WdQSGW68uqWCWfYX4urpJEW6gSSvif6Rs+BXUksk2F3Zp1SBpIxbgXdinrueSdqCSBkuXXkgmr1wWdAhtZ8XJ4vfGrBmzoxp3G/LjRWckL2nOnVCA8RjNqDZfNAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N4OBeEaE; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRcra8eLAdR/fjLvauiapmzSERp7pDFMjRZxXwUbpaN3bT5pweEDIVYw8Xskope0TOapjP40O5OC7D0NONd4V5bnQWNUle4p+2X3MMXR4lWAYDmqXUoTxp9kKD7XZovUt1GwJsYSToPLCrj/J35FTIAS8HxiHE7PIpSJEdXfEsmUHU9+119RpfUxFQLXI+QVLsp1bUGLPXX3E7+00j5mkTHhxfps4/V7e53emkmL5WPGvgj41/fPqFPtI5vKqTq2YTuO+dmZ53QZvZcniLmfxit0ttw+VXAAyVtrUeE60pIS+YarfxZwDSIILkxxUofXFPUXgKIpnOD53e6W5miXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcdYbiAS9ICOQCJYY0Q/Y06j0YLPixKjy3Sva3xxNe8=;
 b=kWb8a+ybr4kJO2T/0esC/mxDuWifCK4rq5bGM0b91lXVV6ptzBzywIDMHmG12QfcuUyerQw03p0vudQl0/hOlZkpu5FB3E9dGFTkRt2ya6kWkcrl6sYOhFE6nBNguv36tRxYEVF0IV6P1frLuDusWTWROUU8zHE6WKf4xZVFEAt/hAqWvTQPG9DYs2cntWwyaSTLnqlpdLdkRkfm1AK4lXVmQs+mQ+yBFPBnYEO163y0E9sN2JPH+uhmRsToH8KkQ+gtUenG0enBfCAIdTo18YF0ukD/QRKNRUDcqbkGITzrwR2PCDDm7HOo4oAeTeTzZIqhp2Nphy3pFKnsX530vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcdYbiAS9ICOQCJYY0Q/Y06j0YLPixKjy3Sva3xxNe8=;
 b=N4OBeEaEie10mCp+UvWHadfc8sB33aSP6oOxH3fvwQH++JBtCo1+HB/BQSl+dPmVQMyUPDnYRuxk3xjhPIHcVPPYOc0QxMGCxd2vEZxyWb2FExxvLPijCUL3o+1GAxb0ECPTLb2GtOMprjiZJLbhV0Og060rU5vRZ6qd7A33/Hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 21:27:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:27:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 17:27:23 -0400
Subject: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-flexcan-v2-4-2873014c595a@nxp.com>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
In-Reply-To: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721078846; l=6508;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lqHfROCxFB43LZ85KCvKowdNhLtFntzq/RoPEWnMlnY=;
 b=UbNbkzmUtNEcwqcAuYQsfDgD8VSgtvfB6W8z699TLOOetJbs89DW9P8fDsVm4Aj5lZqZrDoFq
 klpbr91t015CJ1zMymWBSIzGY3pwVN79t47g8Ob+OW5Or/e0pL+lQ64
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0112.namprd05.prod.outlook.com
 (2603:10b6:a03:334::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ee7989-af5b-41b2-073f-08dca514fa6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTk2UUxTK3B4ak5oRHMxYmo0TWpZbTdTNzVJbnNMR1ZoMEZmS2t0RDIwaHkr?=
 =?utf-8?B?VnpzdFZrdzM4N2hKOG5OVmNqSDYwRlFIK1V6NnMzbDd1NlNmVExYQzRxVFRL?=
 =?utf-8?B?MzFxUmRNenlEUjNLRTNHU1lPTnlwVzkyMHFRQWZ1LzBmTnc3Ull1Q2lERUIy?=
 =?utf-8?B?ZUIrV29yODBpZFBURkQrZjR5NjU5Wmh4M2RJZGhFZkxLTk1hUDJ5Vmc4SGFT?=
 =?utf-8?B?VnFoNkFVRHZPdys3cG5SR3BjaFE2eDNuQWFMTUp0UzRDMXg1Ynl2RU1mNTJO?=
 =?utf-8?B?NjBucDFFSWVqUG5GYnRSOEc3L3NtSk5sMm1IdzRaU1c1YmNPMlJ2TjBxNXBk?=
 =?utf-8?B?OHhiRjZnVDdhTnhsZ3ZFeDJQOEVPc05id3lPQWx1S0hDVmFUdmlETzAxYll1?=
 =?utf-8?B?Q0h0UzkzWldpODlseW9halBCNTVHQmhwNlE2V0tJMkJ5dUlWSkZBWHdNRGlk?=
 =?utf-8?B?a2JtcjcxaHhYRWsyVHNUNTJTS1pwN2dRM2NpQnVPY25JckJjb3JKdnlIZWxw?=
 =?utf-8?B?cld5V1VLZTdHVUVOZzkzTEtiN0puWDNJVjBKZVFrUTJ0ZVNzblkza2hSM1Vu?=
 =?utf-8?B?UnQ3bjE3WUpickxNd1NFSEloZ0VLODNxN0FXb0V1TkVKMndrUVRmeW9TOXpw?=
 =?utf-8?B?YzMxYTZzVEo5Mi95bUZjTDJlWFU4dk9neFdVMFNxSFVTZTlTd056WWZoVVlr?=
 =?utf-8?B?SkQyWUhKOEppMUtacnVVV2hRZWxGMGI1YUZjU3ZKSW40SjYvZDVFMmJiTWww?=
 =?utf-8?B?N1hlMHVCQ1J3Y2ZQa2d4blV3cnNPRU9ERWkvMG8vSHRDNHZaMnd5dmNESUxu?=
 =?utf-8?B?dzk0Y0tWajBxL1BsVE5MNGordDJldk1lTURjMUFJRU44OTZzM2N6S2NxbW9j?=
 =?utf-8?B?ZUhXeU9VcEwrS1huM2RQNjZFdENkU1kzVXZoOWFDeXJ0UVBCZ1hnOFAzMElK?=
 =?utf-8?B?emtka3Zya1psTFVGOWNBV1FxdmFhUmw0SkxjcTV0M0xQSHJuL2xnbHBWUEhw?=
 =?utf-8?B?UUl5R2tEVmNSYzU0Z2FKcmlWMEFIVm8yaWx0eUlYMGFGaWNPOWtUYlRZOHU2?=
 =?utf-8?B?T3RzS1JnWjJ6R0V5VjlyS0RlZlcrSlFtaTE5dXk0Y3Y1Y1hVUWdKdVB5cEcz?=
 =?utf-8?B?aUUxL1IwK0Z0b1J3UUtBbUZIRW9OdVZWdTdmdUZkOGM1TUF5ZE5PbUhqSEZN?=
 =?utf-8?B?bnBYbmVjUHNVNGVLSnRPQXR4cGsyRGdrNEJ3bGFVM3VYeXpQYk0rK0hOSXlk?=
 =?utf-8?B?ZFZaUEVRUWlXVTZNMlZXbVRBNDRDT1hhZ05WWlNuT0YyVXJ3eDhZRkQ1Smsv?=
 =?utf-8?B?U2hicGtldEgwZ3UwQ3J1RVlYSjNNMEtKZGVRUGdtWGhMdmxvY0h0UlFuSVp0?=
 =?utf-8?B?ZEJJSTlPVmpXQ0VUbWVvTmY0Y1NQK2tIbCtzU0NiQTN1aVlXODdZMDI5WGpz?=
 =?utf-8?B?cTlkckVtc0VDWUFtNEZEL25HVjlxK0NuRWJLb2xkYnllM05qT1hkSFlRSDk0?=
 =?utf-8?B?ZUpSSjd1L25Idzh6MENvaG1jS2xDb0t5R3BobnU2VityVm9IRmRNQTJiSmtC?=
 =?utf-8?B?NERwdjV6V09kaHFWb3hyb2Fvb3BkWWpEeWlZNXBCc3RCWk15bS8ycFZsTktQ?=
 =?utf-8?B?NzVGNWxUU2NZTlJ1MHRBcjBJWUhFUXFEL3ljendKS1hyOFFiSWhPK2lpR1BE?=
 =?utf-8?B?RUFGcmw2R1g4OGZjckZYTENVZk5kYlBiNjRXTnI3SDkvUWVsZHo5YnhTekZu?=
 =?utf-8?B?cHpmZjErZSs2VjBYOGdVNmhGOGRjOVBpeXlhS1VQMVZIaGlneGRTaWR4ZThi?=
 =?utf-8?B?RE8wSTVTRnM5R3JrN3hDNmo2alpHMDBDM1lEWVE2UHZISWpwbS96UjlMb29u?=
 =?utf-8?B?N2NRUGlNblgzakRJMlZjN0E1bFc5QldDdUFzT2Z2RTZWR0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk92TExXMExNVHJsNENPbjZtbDZZU0gzaDRuakRVRTRCZzdKYkdiczU1Z1h0?=
 =?utf-8?B?QzlHVmFBQUk2Vkg5WmIvbzE4Sk5rd3VaTGZhMDd2RDJlTDBHWFlmMU16RVFW?=
 =?utf-8?B?eUxLdnIyTWhpSS96WXVmUGhaWTVuNE9oMkp0UUdCMEFMWG1md0V0ekFNU2Yw?=
 =?utf-8?B?OGhCbjd2RDVLVDViMitoeVVuRnUzd2hKN05YUDNpN0dESER0UHFXd3l4RlpH?=
 =?utf-8?B?THJKWFltY1V2a0syU3pWUmxtNUVjaWJscGVXYVc3Qml1c0U3QjBTNkpwNENq?=
 =?utf-8?B?VUhTa3JjdlQzRHRod2tUTFVCS2U3Q1lYcThoUlVDK0wvYmpNUDVaaThGSEpP?=
 =?utf-8?B?ZUtRK0tmM1IwaHZlNmNtYmdkNVo4TW5jNXQ0TmkyWTJCVzdaSVQ2c2JJTkRK?=
 =?utf-8?B?TVl1Si81bVBkbDVPYlYzZEkyZHFCZUJzcmdhejRwMTB1Wml6Y3NjVW85c1VO?=
 =?utf-8?B?NDgvajhmcnpaTE5UOVVraXd2M1lHVFVObUlrRTJpWE9mMi9hZ1EyZjZxWXZU?=
 =?utf-8?B?QWtqRTI3dHY0VE9tYWRuaUdCcWhTeWgzUW9LdHE5azQ4azNJbVhRdGJSL1FU?=
 =?utf-8?B?K3ZUcERoUzB4VUZycVBmVEQzVTJmbGF2YXY5QXBBZmlIVlVPaE5oSGZ6SFFo?=
 =?utf-8?B?OHlLSVdrSkFYVW00NVREVFV0YWdmbGkxS2R4VlI2MVR0U3l1SEFvdUN2MGta?=
 =?utf-8?B?d2tIaWRaNTkrYjVWazZ5aDVWbk9lelF2OTExd2l5bmVwUnl1dzFETWNqMWI3?=
 =?utf-8?B?WUdwT0pWaEZENVdWNmJzVWxJMzMxSnNaSEgvQnVVQnFOZy9Nb004UnZtdHVK?=
 =?utf-8?B?NjdtazFFMktFNGt2SUsyV1pMaFhMZDF5NkVDQXp3bzF0M2lWWTRjTmxUY1VW?=
 =?utf-8?B?Z0lhZGo0a2cwQ25WT3ZmQmVLM0p4UkpPT0liZ0FWZXgwcFdzMlUvQVFIT0NE?=
 =?utf-8?B?cHJHVlltL3JGT0Y4cVJUZGVWZHk5SVNQcXIzUXBhbUNaL3Q3LzFYb240UkZI?=
 =?utf-8?B?TU9nMkNxaEJ2K01ZUGRzMW1wd2tCaXN5L2xaS3BQeTFKNjdFT0ozSTdsTEYy?=
 =?utf-8?B?WjlqRlRiWkJMQXdmbVREUzdZaTZDK0NNc2w4ejRHOFRYSjBCNVMyRDZWVzVh?=
 =?utf-8?B?VTVmOEJ3UzNRcktNWWtFR2FoSGY0N0dXYzhuWmRYdjVTMmdBeWdtRktvVGdB?=
 =?utf-8?B?cTQzRE9Jd3A3QmJrdVY4dWdGQzNjU3pOMW4rdThQdXRWTHlTUEpwbnRBTmRh?=
 =?utf-8?B?bEFVSWNIZkhEOXJ5MThQQTZJemJOSzJKZmFkUCtNSDhaVkN1Rm1uaGY5dDRI?=
 =?utf-8?B?dVg0V0NaUXh6OVJSRkpRVCtleG9MS1Z0UUUxd2FuUE0rQjdVTXF5VEdydk1R?=
 =?utf-8?B?VlR6SnI0REJmUGluZTlwcTlBMFNQbGh1SGxwRTB3anp3T1FzaXRLQzUzZFdi?=
 =?utf-8?B?UkxtRGZtK25zc2pFa3Zzc0E0OUsvZnVQcTRpeHFlMlZ5Q1lwMVEzQlhtWGNk?=
 =?utf-8?B?b1pJRGxEblRLZ3pwdmRHdzBucENIcTZOWi9YNitMYW4zY3F1Y1hTWERKS0FU?=
 =?utf-8?B?OXptZ0NyNWJPVk10Z3VtY09oaTVIWWRkNUJtaDQzMW50SnEvVzdvNzloaFFW?=
 =?utf-8?B?cWJWYnVOUGxsdjJoci9zSU1aTk41bFhxUzdOcTBPVk1BVzYzcGZkbUFIeUth?=
 =?utf-8?B?WnVZaitXa09KMi81Y0RiUURuSWNsVld1M0VlUjJLRGtSOVZ3d3FRZGpNWjNW?=
 =?utf-8?B?aXg1ZHlzcm02T1VmVTYxckUzVlJJZTZmTm1EQjB2Z2NidXQyWDVDaks4dTli?=
 =?utf-8?B?eWRqRVNiR1pxT3VIdEhEWElMdEUwVFZaWlArSUYyVVcxRWpCWkMvczd2Mnla?=
 =?utf-8?B?Qm1pc0lobVV2bm1LZkxZNlB0UWlIcWw0cTk5WC9URTBsZzFPaUFGWXdNZFFP?=
 =?utf-8?B?SXNJcSt1bHVxOXFrL1VCWWdMUFlzWEMrdG11VktRUFBRbE1tNDd5cjVxQVZX?=
 =?utf-8?B?YkdNSkxvdTFNeFNRTzBUVWhjaElWN1lwVmpHbHNGdkJuR052VmhJOCtMbG9O?=
 =?utf-8?B?NDQ2VTBsR0V4LzZQRGR5eFVCVXgwQ3JzZSsvY2lrSnhGZktvVStPTVZxdVow?=
 =?utf-8?Q?1g88=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee7989-af5b-41b2-073f-08dca514fa6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 21:27:50.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+DsD44Xhc1KUFiHoMrIx20i/YORqZnuLW6nusXAl18hFin6fMXky84cHzCzAE+XJpQASEesLHp4s+KnzR6sgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Haibo Chen <haibo.chen@nxp.com>

iMX95 defines a bit in GPR that sets/unsets the IPG_STOP signal to the
FlexCAN module, controlling its entry into STOP mode. Wakeup should work
even if FlexCAN is in STOP mode.

Due to iMX95 architecture design, the A-Core cannot access GPR; only the
system manager (SM) can configure GPR. To support the wakeup feature,
follow these steps:

- For suspend:
  1) During Linux suspend, when CAN suspends, do nothing for GPR and keep
     CAN-related clocks on.
  2) In ATF, check whether CAN needs to support wakeup; if yes, send a
     request to SM through the SCMI protocol.
  3) In SM, configure the GPR and unset IPG_STOP.
  4) A-Core suspends.

- For wakeup and resume:
  1) A-Core wakeup event arrives.
  2) In SM, deassert IPG_STOP.
  3) Linux resumes.

Add a new fsl_imx95_devtype_data and FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI to
reflect this.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 49 ++++++++++++++++++++++++++++++----
 drivers/net/can/flexcan/flexcan.h      |  2 ++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f6e609c388d55..fe972d5b8fbe0 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -354,6 +354,14 @@ static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data fsl_imx95_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI |
+		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
+};
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
@@ -548,6 +556,13 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI) {
+		/* For the SCMI mode, driver do nothing, ATF will send request to
+		 * SM(system manager, M33 core) through SCMI protocol after linux
+		 * suspend. Once SM get this request, it will send IPG_STOP signal
+		 * to Flex_CAN, let CAN in STOP mode.
+		 */
+		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -559,7 +574,11 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	u32 reg_mcr;
 	int ret;
 
-	/* remove stop request */
+	/* Remove stop request, for FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI,
+	 * do nothing here, because ATF already send request to SM before
+	 * linux resume. Once SM get this request, it will deassert the
+	 * IPG_STOP signal to Flex_CAN.
+	 */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW) {
 		ret = flexcan_stop_mode_enable_scfw(priv, false);
 		if (ret < 0)
@@ -1987,6 +2006,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
+	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
+		/* ATF will handle all STOP_IPG related work */
+		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
@@ -2013,6 +2035,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
 	{ .compatible = "fsl,imx8mp-flexcan", .data = &fsl_imx8mp_devtype_data, },
 	{ .compatible = "fsl,imx93-flexcan", .data = &fsl_imx93_devtype_data, },
+	{ .compatible = "fsl,imx95-flexcan", .data = &fsl_imx95_devtype_data, },
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
@@ -2311,9 +2334,22 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		if (device_may_wakeup(device))
+		if (device_may_wakeup(device)) {
 			flexcan_enable_wakeup_irq(priv, true);
 
+			/* For FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI, it need
+			 * ATF to send request to SM through SCMI protocol,
+			 * SM will assert the IPG_STOP signal. But all this
+			 * works need the CAN clocks keep on.
+			 * After the CAN module get the IPG_STOP mode, and
+			 * switch to STOP mode, whether still keep the CAN
+			 * clocks on or gate them off depend on the Hardware
+			 * design.
+			 */
+			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)
+				return 0;
+		}
+
 		err = pm_runtime_force_suspend(device);
 		if (err)
 			return err;
@@ -2330,9 +2366,12 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		err = pm_runtime_force_resume(device);
-		if (err)
-			return err;
+		if (!(device_may_wakeup(device) &&
+		      priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI)) {
+			err = pm_runtime_force_resume(device);
+			if (err)
+				return err;
+		}
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 025c3417031f4..4933d8c7439e6 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,6 +68,8 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
+/* Setup stop mode with ATF SCMI protocol to support wakeup */
+#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */

-- 
2.34.1


