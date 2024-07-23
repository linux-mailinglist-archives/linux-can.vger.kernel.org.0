Return-Path: <linux-can+bounces-1000-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF59893A846
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A591F282C15
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88D14386A;
	Tue, 23 Jul 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ntil2imy"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFC140E5C;
	Tue, 23 Jul 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767745; cv=fail; b=a9yOSgLSoB1Yh3wW42LsMMiMk8ERoHlRL97n1lKqE26rBOWUwkuFUIAG23YS95jLAmMf7Ta/4cdghGaaBVBcL8LF1LdAomG5rYtNbGHXUs8XPLaDAawtsH0IPdyFMwq5LBnWXEIxfokNxIjkFrSPwflAKTlw7AFeL+RbRhxM3Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767745; c=relaxed/simple;
	bh=02ixpVxr7I5pGFsYQobdmHMuUtNDHCTPsz4OAFPzH5E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gzooI2xOZhzxyBRpdF+d9RdRfUO/4sDJ9Z9bEIYKzq8M+L3jQrYakiSup8QrqDZI2l9yAIxsluZyv475LmhVcqFRfYwsZ85LWGxxyQ8GG5Q6LB+PnIv/vvljSxEEQGC2ayIkYV6X+3zDGSCgsE6tEMTkg6vL1sEzeis3wbh6Zm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ntil2imy; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP/OpYoJIXFWbFqlygweaigwCx+rWS1CvEUJItIqOrJGkzR0C0jOH+HEWc/QlFQIWeUtHY1VtK4pvvejhcwQnd8VY6dHo6GGF25ZLAiKlP0Go4A8xettBdj30mlWb4hGIsSMbwqIgpZQ5Q4oFqWO/qwWId5ROKvckFDuFcATl+o/FosLT0B1tTVwuveyE+5S6l6fPjmFnGUIQXwsFDcab7g1ZgwkffH8yE1Xg0j2/1ZOu9xpXjOoV8G+/cT8cEoyfrMLphLAbIxebypuz7vIdfGixRmeEPc40oyslIvNy13lXg6a+FlYuKn2nCua6MlGCEBVxRlfnX5vYA0lzuebRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNzAKwFSzo6vyw625zIXo6050e5mdOqKGgw4poz7rhg=;
 b=YsVYsUv8z5ypEECf9zivwJe7lbMtBp90TDLuaB01fOEMAC2xGKgwqkS4XT6umaVbc1nFe/iVgfGxVhRWjfYlw9IpwV5+vohaWpOawpesqGgYCPaQ8bzmEix3tzt0iCIn3vNN0m0obar0ElFYx7ipIapeb32kLtF+Fko5x2FNHQAXOuQ8mwxUuyUf7yaKCnJYPbecy2fX2VykdRKnh0Wn50GdLquW/8Y/zI0R6Jva5iyJsIjYDQ7U6ylToM3GyB4WI6BrPZqY++eoHQ7jka26EI9Qe/mbx66gw7XrvFLg0SrTlaE6uAJ/m8bqMIhH1Ts+yHJndJziXxMio3bvDleQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNzAKwFSzo6vyw625zIXo6050e5mdOqKGgw4poz7rhg=;
 b=Ntil2imy8DnpSV5U5CJ0ouj5SqyPrWczuEHBxHe/HuWNvwuV2dErfXoaTO0nolq8sN4owMyrOyzFuvy10xBHUocCduojCQyA3AMDkaFZmsaiWa772uAhhnamZmV2US0pBbazpf7DEuzwxBCG8FIjpPB2+NMQI6XcHEfgELvGBfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7470.eurprd04.prod.outlook.com (2603:10a6:800:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 20:48:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 20:48:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/2] can: fsl,flexcan: add imx95 wakeup
Date: Tue, 23 Jul 2024 16:48:34 -0400
Message-Id: <20240723-flexcan-v3-0-084056119ac8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIXoGYC/02MQQ6CMBBFr0JmbU070CCuvIdxUYapNNFCWtNgC
 He3ECMu389/b4bIwXGEczFD4OSiG3yG8lAA9cbfWbguM6DEStayEfbBExkvqNZk2aKhtoH8HgN
 bN22l6y1z7+JrCO8tnNS6fhtK/RpJCSk6jUoySVNW7cVP45GGJ6yFhP+W3i3MFp7qUqqKdKPNb
 i3L8gEyHsJL0gAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721767734; l=1571;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=02ixpVxr7I5pGFsYQobdmHMuUtNDHCTPsz4OAFPzH5E=;
 b=6986Ip83TffRqOq4wYK59DkyN7bFib7eUqwmmAUDP0AkquDPKudlXmdGjlRBX+AGTqG2UTGB5
 pPjtFI7lUAhDZtQPYZ3ZVwIQA/Dk4fnilbZTipvWM8aEl274VzLt+oG
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
X-MS-Office365-Filtering-Correlation-Id: 6f574879-31e0-4e9b-002a-08dcab58e035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2FnbklISzYxMUZoc2lxYWwzYnFhOFU5dWhxOFgrNnZUQ1pvYi9oNys2bHFu?=
 =?utf-8?B?RExnRnFrclZoQ1ZTZDFQT0ZxdHhlOUMrTUJwTnVGRU9IendGL2dnOUlqcGht?=
 =?utf-8?B?OGNYTjk1c1c3WUVGUmduNW9Vb1pFMHFTaUVPcEdBVHBLb0U1S1JJTmNaWUFY?=
 =?utf-8?B?QjNBQjBYU0wwUWNSZVRBMjF6QURBbmFYY2tkTzZTSmxPOUFXSFB6YmxWaklV?=
 =?utf-8?B?bk9CdzRUY3FPNEs1MnVMdGErNDRqWXpwSlpVWUVOT3ZveTNmWXY4Z1cxWDBx?=
 =?utf-8?B?N0NGUHp6MytaU05meENHZkRldzg3VHUxNjRuRXVrZnZVbkh6TlQ4ZTlSSVpz?=
 =?utf-8?B?eThUOU1mT0VzTjdzVk8rcU9zSXcvRzB5a3N6TGZEQ3RkektRbWxnRlB0Q2VW?=
 =?utf-8?B?cnNGWjVYNnkydUhyMXJkMitiMjhud0htb3VTeWFORUV2bXBlWnNJM3RkcU95?=
 =?utf-8?B?YmUxQ0dwdU0xaE9xRHRDbjU4OE5qcW1JZmgvd0xkTmx1S3lxekNvdmxVZ3pT?=
 =?utf-8?B?eVBaTkVXMHZ3YWZ3Q21yUnY3YXl3UUhZb3JBVmw1cGV1Nmw3UVVkUXRiSi9m?=
 =?utf-8?B?bjNVVEVnZWNjNXZSa3k2SjFtcG5JOU15RWM2QVVpWUtqaEgzNXYxYndyME9Y?=
 =?utf-8?B?bkt1WEVvNDhxZXBtd3VmY0YxVStFTTY5L2hGcC85dDhJM0J3emF0VjBReTho?=
 =?utf-8?B?TytFRDQ4UmNtbytXSUt3VHlNS1pZNnZBMG1uMzRlcEFLSHpCeXVoZEl5SE1W?=
 =?utf-8?B?YllwWmdEL2JSaEFXaVN2YlgrdGUzWHJTTEgrTjkycXJzOTZOaWxGZG9vMXV2?=
 =?utf-8?B?Qjg5Z0oyU0x4enQ0a2pxaHBhQ1pwZEpSNEowSTFaUjVSZGd2OGN1Z0QrZ29z?=
 =?utf-8?B?alpyKzBPSnB4WG9ycENQWWVicnZ6VU1qTk5naTBnUmxEVnpCeXI5Y1c3dWd6?=
 =?utf-8?B?bWJoeHJCR0VxNkkwLzYyV1ZRMmJFZklqb1dLZkEyMmxZdnNJSXNIcTFBOUpI?=
 =?utf-8?B?KzRmZVd1WFBKU21Kc2o3ZWlnMkg4THI5Ky9DMDJVV0t6blBaNGZNUmtHYnBi?=
 =?utf-8?B?SHgvVzFkTG1JZFFDa1RIOHhOelVUNGVxalRYeGVFeDNiZk02Rm1rS0ljdXhy?=
 =?utf-8?B?SzRmOWwxcmJYSXAxUy81aFF4NTRxMlNYWHNEaS9Gd2ZnZjkzZWdRV25aQ0ND?=
 =?utf-8?B?RXJBRFJJZVRmOUkxTWYzcGhSejc2dTVBQTFGZmtrOFFiL0F3eGN1WG8vbm9J?=
 =?utf-8?B?VDYzU0hpMWQrNitaM0NUWkFUM2JmakdYMVR5V2RqM3ZRR29xMDY4S0w4K1dG?=
 =?utf-8?B?OTV3OG5sV0p5RENsaEtOc2RScFBhdGttQkF2SWFoYXhXV2M3Rk9JbW9LeXJU?=
 =?utf-8?B?Mlo0bVR5N1RLN2VxL2FBVDlSYUdtazJXVWI4dUx0KzFSMGtxMDdZdFRoSXZB?=
 =?utf-8?B?L2t5T2FsSENHR3RMa29kY2p3TTY1bTRVWEZ3SjhQeS9JblJjaTBLc0h2L09B?=
 =?utf-8?B?cjJxdUNldTB5UlVVa1hMd3hFMTF0N1l0cDBlbU1oU3pWYm9tMktIcVhSNEwz?=
 =?utf-8?B?cXd5MG5OaEFRVTJuYWtnMmcxSy93YlFOOWR2ZW9Gck5xQkdSQ2RsNG9MS0tE?=
 =?utf-8?B?eE5ScVhCS3ZnRmEyRHkyVlpYRnZNeENvcm4wOUdweG1uMmhKUVo0Y0JsdVcv?=
 =?utf-8?B?aWJ6eXgyT3ZSZWFCeCtob0lDUHFVdGczS3lOdHQ0M1VNNU4xVndCVmFLZW9x?=
 =?utf-8?B?WGxyVXh3T2tOY1U5OWRMeWpnNW9TOGNTWkRQQWM4eVAySmxsNmtxeDZxYmZs?=
 =?utf-8?Q?YXrGWBUuSXEUxdK2UFUZJLUorCmLc830qtCJI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEkyb3E5VC9iL05uRmpYQmlUUDVvZmVYdmhWWDdQSDBQRXpXMXQvVTZZVlds?=
 =?utf-8?B?RlVnYStacFFCNGFnNHBmZGExUjAvRnFZS1BQS29vTzdUTUlYc1JEZERYbTgy?=
 =?utf-8?B?eUplZDU5Smk5L2tYSm03Q2ZraXhBTm41VG1JR1ZZOWw2WnFraTRLUjdCTVN2?=
 =?utf-8?B?cDJpNjF6c1o4MDNHMWkrb1AySmoyck53SGpTbTcwUGRxRHgxN2NnNHlsTWZ2?=
 =?utf-8?B?ellxRFFwWjZRRmdLR1R5bDEreDRIemx5SGttVEEvRzNSN1I1L0lYdjNpaWEy?=
 =?utf-8?B?ZytLZmlodkw5YXMyRityQUVmYm1xQzlNU3prU1VMd1VKMjZoNVN6ZTVsbGJK?=
 =?utf-8?B?KytqZDhFM1ZCOHFpaGN2TnJGeEl3Y1prTDl0MHNmMFJENUxWcHNUYnprMkFo?=
 =?utf-8?B?Z2pZNUpSYkxKSE9seTRZNk1CVFZ3UFVmam1PdW1jcEd3eHlvSzI5WkFNTjl5?=
 =?utf-8?B?MXF2Rnd4WHdVdDZsWXdNTHRYckM0T2dpOUozR2cwQStTM3M1Uk5EYmhJdnkv?=
 =?utf-8?B?cHQ4MzlDblFiZFQ3UmZ3V3djQ0U4b2RZSGk0ejExVDJ1ajVCaG5hMlhWU3ZL?=
 =?utf-8?B?U0haSi9sODF4ck9Nczkra1BwQnVVNjFHcHB3RUtpSUI5TEhUeEJnVEh3c05W?=
 =?utf-8?B?Z1crRXkrYmw1WU50Z2xEM3JzWGMxdC9BTmlBMGtZdk56S2dpQ3hqUlBDYkFX?=
 =?utf-8?B?ZHZCK1E0WHpoZi9mMjNiVkZyTHYyckhacE1oMzBjZUg3M3J1TUdwQjg0YWRn?=
 =?utf-8?B?eUlCeGEzbWp6cGsxTjN5MDV0ZUNKM2dnRkMyMExMNXBkRGdqTUkyd1ovaDht?=
 =?utf-8?B?SkFnWHgrSU5kZ0dtamh5V0J2S2crNGthL1dWQWEzQ2RpOFZBNzFudy81b1Zq?=
 =?utf-8?B?dEJ4Q0g1OC9wNFNEc3NicDlJYXQrS3R4Y1Z0bWVjNjlSVkFaU3U0cUR6TEFT?=
 =?utf-8?B?UXRyc0RKeHpyWU81dGRub0Y1djJEM1VpSW5CdDZzRmFlSkFvK0hza3lmTksv?=
 =?utf-8?B?VVhGSHBORnp2eE5MQ2x6VFU2ajhrRCsrSU1yT3FPVW5CSlkvTWhicXVCay9m?=
 =?utf-8?B?K3Z1Wjh0Q1gyc2d5eWtPMU1EeGZQSy9sUXM1K2pCVVpoOHJzN1JBOERuU0tB?=
 =?utf-8?B?KzZKbGcxNXZLS01ldzZyRzlSTW9odzBMM3puS0NGb25WcEJtVUxMVHY3bmdY?=
 =?utf-8?B?dlZKZ1RSQWRzeWdyZ0p6YVM3SUxEczdkSVAyYVBEb21lQiswcTk2TG1oKytv?=
 =?utf-8?B?SysxR0xFT09hM0o1ZnNhajhCRlkyQU9zZ21kc0NqaDMvUEx5TWZlUE9zY0JC?=
 =?utf-8?B?bitwZldMU3kvRjk1SGtFMXp2Y003cGR2dEFJRW13aFViNHY1V1h1YjdPSGFx?=
 =?utf-8?B?RDdmcVd0S0dTbml1Z0s0eG9PODZ3eFpxditNRFBoTDFzUlBWKzM1Qmd1cTNu?=
 =?utf-8?B?bEhZYVZFSWNPK1huWDhXdFR2YUhSU2s2YUNabGVlTm1vYlBlZUhURUhoeE5n?=
 =?utf-8?B?a0I3NStVaW4vL243dStmYVRhMzh0b3FWTS9sVjMrUHE4UElqWjJvYUw3NUtU?=
 =?utf-8?B?ejcxcTVhYUJLRC9PajNwMmwxcHRGMlkweDczL0h2WFBhUUlRSEYxb1M5T1dK?=
 =?utf-8?B?MkVwY0tvVG9VNXhQbnlZdUdoQTBrbXY0bzVqa2M0QWNPMGdFZUFFNWZSMkpm?=
 =?utf-8?B?cEcxbTNkZXR4Skx3RHZzVWtxa1E3eEN3clVmMjl0SlovRnNNMnNoR3VmbjBE?=
 =?utf-8?B?a3ZtejgwdU92NVBqMEczQWJGSUIzK3dsWFR6Y1ltOHZLRmJHbThpSkJ3U0Jr?=
 =?utf-8?B?VWxlUHBQT3pkeE1Ldy9rcEo5WmEva0VFQ25KR25SVmJnNkhRWHh4ZWtyZnZT?=
 =?utf-8?B?MXpmdzdsTnp2dlJHdk9sOUs0SlU0KzBsdk9rdE1ZUWxrVTh5ckJONWROWGRm?=
 =?utf-8?B?aEx1NElvRFVHU0lvTDF4b3NUK2tuU0tla1JCN2tsbkF2OWNJenpoMmp5SmM3?=
 =?utf-8?B?aTI4RWVncFM3NGx1c3hTaXhNWEFSVE1xemdHZStweElNYWQxdnBETUtDQnY3?=
 =?utf-8?B?dkVjSXQrS1hqdS9nL1pqWHNYVHRlVk1XdjYxb09JRkcwVnNzWmZ4OXZDeUhq?=
 =?utf-8?Q?Pjk8ccavxD4s+i3DZRplmt0Er?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f574879-31e0-4e9b-002a-08dcab58e035
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 20:48:58.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swxyIlsoZ5PUGbd8p9xkUkaWRfSPBidg+T1NHk7x0B2YTqDI9j6BGknFIXWFiWqmt9Rdi13B83gti4MqI1Wmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7470

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: haibo.chen@nxp.com
Cc: imx@lists.linux.dev
Cc: han.xu@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- Remove s32 part because still not found s32 owner yet.
- Link to v2: https://lore.kernel.org/r/20240715-flexcan-v2-0-2873014c595a@nxp.com

Changes in v2:
- fixed typo an rework commit message for patch 4
- Add rob's review tag
- Add Vincent's review tag
- Add const for fsl_imx95_devtype_data
- Link to v1: https://lore.kernel.org/r/20240711-flexcan-v1-0-d5210ec0a34b@nxp.com

---
Haibo Chen (2):
      bingdings: can: flexcan: move fsl,imx95-flexcan standalone
      can: flexcan: add wakeup support for imx95

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  4 +-
 drivers/net/can/flexcan/flexcan-core.c             | 50 +++++++++++++++++++---
 drivers/net/can/flexcan/flexcan.h                  |  2 +
 3 files changed, 46 insertions(+), 10 deletions(-)
---
base-commit: 60338db30855441b23644e319542abbacd449d08
change-id: 20240709-flexcan-c75cfef2acb9

Best regards,
---
Frank Li <Frank.Li@nxp.com>


