Return-Path: <linux-can+bounces-7154-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cq4GRsHvGkArgIAu9opvQ
	(envelope-from <linux-can+bounces-7154-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:24:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0DE2CCB6B
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E06131F0F85
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8031F998;
	Thu, 19 Mar 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uIfYou96"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4930FC23;
	Thu, 19 Mar 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929695; cv=fail; b=UezzlRtkfCPKNt2HZDuLwv5oQCRooug74ojAmLqU5IuRwLDoBXYklf9mQkO9unjYACSyzTwmMqAcE3scdr4imLunPXJYCeq5Ru0GiLPGuy2qJxeMYBosUFTnXUvvfVX2r3WRhPzap696+ZRihlZu2XuaOfr430s27nZHr5cl+c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929695; c=relaxed/simple;
	bh=WdLUjUSA57z1h2radFvS2rkzQn0UhDbmk5bFUkXsUn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VZkCdRQQpsdA5LqyRJM35IP9/9MezT5iEz7AI1lOlw8PcK72+Biyzd+3w38cNdRQYCB4CdNC8Sleq2Noj5s1GlCamkxMMyY1QM0tdwbDFhpWGQ7A5qHTZdiJhVBayj5Yu7qPPAnc/t2gbNpSOczrH+ugWiwerkv9J6fwAedFENs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uIfYou96; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfT7SgUzHraYkhuGrobA7wFugSQ2gZNSS+taMp0ZL7Nq6rjDFS+K2rXhD1sOHcJcREv7CPT8alE3wgG/aSb350AhwcvuMPi/hWinL6KSSjL42rbxGlgFu445UvIA233YELLjacuBCpJceFl9be/rvIM4ADXqPRCLG7ZpCYMSc/bldAkjw5cvUqngaFgO/RD+KXfAW0OvtpYqVoxH8jpiPyD21nLXkwb1VNvYixfNIPPPtmpe5aHu06Fli72GbK0awbWNjYXAsqQUXw+YyTxskIYkZdPGxB+KHhzBt8V9HBHTSrTBbRLppZyKghFVAMWXevWXwfrqRDDqy0WYKeC59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMHek7d6iTVXSxlCY9E8QudTZtReEVOg++LkgoQOuqc=;
 b=uD1gZU94CJVL4+YLI5GPkRpTrgB/8aJD3bCbwgXsfQV2krbmmBMS/BURgKR0Yq9P5j3a1IsyEQlUs4666XWk6kVYdWLFtwLIZbFYHN0UXFSq0JSYTue0Om5J0Lf3hI88q8aRkekQkyF383MMR7Icn0B2omdpPdzbeTM7uPcoonS4HgKznY8vYC3S2NyFycSdFUpRbUPhn/hbjRPiJ9lA56TwziJTEAPSIe8wbI4cyK+TkqwCelyM8eetLWpG8aGd+EVWsDG9DZNhMMXOXwgBodArpoajRduoV3RoKzpclYCHMc2iXnZFg/T039+esihvjLHTRTfOlXC94rq0IxEN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMHek7d6iTVXSxlCY9E8QudTZtReEVOg++LkgoQOuqc=;
 b=uIfYou96PD34RR2Kb+2FOvvWyL4ifcTZVXwf6vKoT/gAyzNpkWdoh0//2+An0zX8ZF2xtTyR8Fsgr3A8Qc1vHJeXw/GditYWu9LWDqmPruUWRFT26o7ToSNlzFVQHdFVyFOLOsml63V1Nid8noPg22fKLrRu4u6egNQgJuXve09ZVo9+6s6yuUOcb2vsQQ+oPANLWHYTF1vq4Kjl/q0fkcFZvGHywBmVXoVvEGGeO612hctPH2bem30NB7gP6Ali0xtQNsn583RscXXBO/fDCZhz+7MZqqdU0x5nd5z2RObz3zVaBruV6rsYD5hK+av8EtkmP3pZlYhG+GrQKWXfxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DBAPR04MB7464.eurprd04.prod.outlook.com (2603:10a6:10:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:14:49 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:14:47 +0000
Message-ID: <742c748b-8096-49a3-b1a4-3a8507f6f55d@oss.nxp.com>
Date: Thu, 19 Mar 2026 16:14:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] can: flexcan: Add NXP S32N79 SoC support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>,
 Eric Chanudet <echanude@redhat.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
 <20260319-orca-of-legal-science-88e67d-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260319-orca-of-legal-science-88e67d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DBAPR04MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2abb21-1481-4b27-4bb7-08de85c1e061
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|83080400003;
X-Microsoft-Antispam-Message-Info:
	KhDPs6HoDSMgJwfIzdF/mRwH5j0Gd0CJe3esCj3JEUyr1DFLLJIAOoXCc9QyjWDQvYpJD4ctsPaGBCK2N6U5lni0u1ExduDamKtV48ASprbWzJocfdIaTaG3R4MwAStu5AU5YMrniajlh8kBEUi3gtBhSw/I4NBZhg1BsmACozv/jBF7PVojyUKgTdkYcn4eTP8WChF5jZV5ekKU4MvgIiXxH4K0EWWxHg6lMQtlA/4U2Qig1A4E/OHuJbRsZ/o/CK9r6ftztUE2zjJkdyLWhcFxAdaKNrhyDoPUCM5yxUSwYUvaI15bWzCU7XFX+rzNd92697s9A5mFy3o+OH2hiBViDArShQ8UwO4zHahdjyRzSHNElmSP85XRQJykW6tEt0ILSa4LRPqWSqMvWxn7Ryumd6bQAz2FjDYvWpmgZ8iXcvMTNkNK6XnCcwt9pDR9eNHMTFuIp5v7YwTtD+LHZt34fGAIxyGYzICOQjNybUMmVFJk70wM3phO2/5D+cSB463EJY3kFQW1EqPEBEFFeizJZMtdOItiXvLgbjOd5elbqhd1hIWFgtv+S/9CXdthl5wB85d1tfcvAb6+dKeB7A+gIC5O/yR1gX9YCRe0DttjCqHxU/RGH5hKQOGzBDoHx19d5BhxbzFb9f5v///HTJLMhH9bxZA1rQuQWLOIm9igoun+3dFJ35tnug8n8t44UW8/wWXTdBvLXLoMmmpdESQsifsKyeDauWZI3vWAWy0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(83080400003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09ENW5FQzVlbGozQysrTXo4dVlpUGNZamVpUFpyMzROcXE0bjdnZEFQdkx4?=
 =?utf-8?B?MTZNVzB4cnNiUk1nRjJOMk5waGFlOEp2QWlCY044QzRNRXZ0V3d4VlJoS1Jo?=
 =?utf-8?B?QkxBdUtQWGpYYnZ4UjVHQlNaQ1ZtYjh0NkxxTkoyaVF6cFg5K2VYbEVsaXRX?=
 =?utf-8?B?KzJZSHREcnF2UzZUd1A2a1dXczlBcmtJb1FydmRUdUg3UVQzVnNuRzFScDlp?=
 =?utf-8?B?U2ZPUDZWM3VUQ01td0Z5cWxhUlYvN0FVOWo3QWdpY2xQTC9xdFVkL3BMVHFT?=
 =?utf-8?B?TUxWNlpVVmJ3a0dVSTQ4Y0tmUW5nTFg1dytTVFV1bktoajdCYkNXUzQ3bVBw?=
 =?utf-8?B?bEVzZVBLQURpRkdocFI4ei9McEVRaFJqT0ozdit5aHBBdDFZM3ROVytjTG9r?=
 =?utf-8?B?Z2JNNWlxYkRRc2VSanM0dTVHQUR4VC91ajhQWUtMNzh6WVgrWmdqeGYwVTRK?=
 =?utf-8?B?M2NiMmhyTWpFRzJQa2NPUnBSM1JGeU45WDBSNXFmcnFoYnh2Q0xvUExhcTJJ?=
 =?utf-8?B?UWp3ZHZKNEtkeEErU2p6Z3pqb2dSUjZSV0ZLc291a20veUczWnBEaUJFOEdi?=
 =?utf-8?B?c3lIUSt0dU9ja2hYSm9IQmFQSDZJU2gyd1pnZzdlcGtkeDRSa2JZeWVjUlI5?=
 =?utf-8?B?RW5NMWZ6MVNnWjZNRzNSeXVvbmxacHhkb0RxR3RMcHhiOHg0bFovcEVhc2Vk?=
 =?utf-8?B?TGsveFhrVlNqVitERGtWUkt0YkRtNzRIQXZFdHl2c0Z6aHJiQW1YQzgvd3RV?=
 =?utf-8?B?NzlTcGRFSU41Sy90dFpOR3MxZks0VURqSkwvUzltVHdYYlVaN240Mm1aRXNx?=
 =?utf-8?B?TE50T0NEMHgya1RkQ2JUQjVCQm9jQ211MnR2TjJVMjI3TTROUkk2R25OUW1h?=
 =?utf-8?B?WmlRN0pscW41cTV5dWtoSGVRUGRobWlGS3NiMEo5WENwL3Y0NGdCZDVZYzgr?=
 =?utf-8?B?RGlyVVFFbzFvaUU2cDdTVzVzc25XYU91RmtzWXM5c0crUmdHZXB0b3cxek5M?=
 =?utf-8?B?alYrakEzbzhlbEVkUERsQlN3RlUrdlUzTkZkS3RFZVNWdUFIYkRaYWlKL0pz?=
 =?utf-8?B?M1p3cHJDazlzaVlyKzhLbmxtc08zL1pnd083N3BRTFlhang0RDk5ZHdBbmNo?=
 =?utf-8?B?anlRL1BOUWhnZlRYYzVObGJUNTlmKzk4OWZ2Y05OYTlYZVBMc1lOSk5MVUI2?=
 =?utf-8?B?R3IrL3ZvbzdVbmwyd2NIVTVOL3o4QmlXbmQvVkdNU3pkYklMOUlQc0FZV1V0?=
 =?utf-8?B?emFWVGFJRmJtcFRxa2ZySGpQazV3OXVYOE9xcFdHOEVkL2o1cHpkWE1OcW5k?=
 =?utf-8?B?ZGN4VWdGSGVwUWtaZVlMUkVncE1oaG1DcmxGcEN1OFozWDh5bkdPUFhmQm1i?=
 =?utf-8?B?Ulp0MkhFdTRlUEkzNlUyUkFFaDdLK0FhUnlyU0NNVy96b0VnMnlVWXJTZklH?=
 =?utf-8?B?NUlWbmMyajlIZ29VcENxKzJiT3FEdGR3czVCbFFTVjNlUG5TZmw2d0J0NHNp?=
 =?utf-8?B?QWg5SFk0Z1FzeDdreTRwU1lxbmJFaUQzSFNadFRUN3ltOE5FeUdXeWthNHpI?=
 =?utf-8?B?NlFoNmF4MW5vRTNzWjNDSkxTdFl5ME1ObW52ZFpscmc1UEdzSEhibm1wWk1T?=
 =?utf-8?B?LzA0WXlrRFhLVVFicUh5R1BhUVR5bWZaY21ab2FlZmdiNnZXV1hrRjhxUFVY?=
 =?utf-8?B?NE55SFROSEg5SWJlVXJzaFFlRU9DQjVPY3lHWVdxeHJ4N2EwZ1EzOUtidk13?=
 =?utf-8?B?UlZQQ2MveXpsWFcxK0V4UE9rR0hhNUNHM29uN1hRbjM5Y3F3Vkd5elVHS09U?=
 =?utf-8?B?NlVNZkhPRXV6WWJIbWZ2K2txRmUybC9qa1FqYWw3L0xrNEx0di9lQ0lxYjNk?=
 =?utf-8?B?VVVScElOYjZHMTJqbHFrN1JxQUZlZTExdzh1Z0RKcFdENUxtdUpDeWYydjVu?=
 =?utf-8?B?THpsd0oxV3hZWEM5d0xRcXBzZUZCSzVnOThMU1FiM1lsK2ZvY3VCazMrR2Mz?=
 =?utf-8?B?NXhsajY1OHNldlJabWNtdHZlaGc1SXo5Ym1QM1dEZlAycHFXYkJBRHkvNXJS?=
 =?utf-8?B?SEc4N0pDa1V3bnBFVEpJWDlLS3Zlc3VENmppdHhQWXpsbm0vQjhXY1lmK01T?=
 =?utf-8?B?eitVcFo0TlRqUlFPQ3UyckpRN1d1eHlDUWNEbnc3WVR2cGowc2MzeWtlSEJ1?=
 =?utf-8?B?YkpnVmR4UEo2anloOGVoVjRlcUZPdkRoYjVNazU4Z0w5dlJmS1V0aERTMHJH?=
 =?utf-8?B?Vi9LVGJiNkxiK3p5QWM3a0E4YUZjTFpjMTRQbmNqWGw4eUpWOU1PY0xCa1Bh?=
 =?utf-8?B?bDlEZkhqWWFuckdhVktXRmF2NEVBODAxNjRSalA0bHhaWWFETGxlYkNDUXY1?=
 =?utf-8?Q?wBTiOxsb5UJ/0hEU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2abb21-1481-4b27-4bb7-08de85c1e061
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:14:47.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7R/gOK42Fi3qrPJ7CCUkMe169044EjsGZWYVybM+Z2HcibaeGMY6JpeulXSdrk3xp3j1jRt8O7h1A2xdXV0Wy4oUoBDD6dwbj8yxvV5Q5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7464
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7154-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: 9F0DE2CCB6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/2026 1:56 PM, Marc Kleine-Budde wrote:
> On 19.03.2026 10:40:27, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> This patch series adds FlexCAN support for the NXP S32N79 SoC.
>>
>> The S32N79 is an automotive-grade processor from NXP with multiple
>> FlexCAN instances. The FlexCAN IP integration on S32N79 differs from
>> other SoCs in the interrupt routing - it uses two separate interrupt
>> lines:
>>    - one interrupt for mailboxes 0-127
>>    - one interrupt for bus error detection and device state changes
>>
>> The CAN controllers are connected through an irqsteer interrupt
>> controller in the RCU (Resource Control Unit) domain.
>>
>> This series:
>>    1. Adds dt-bindings documentation for S32N79 FlexCAN
>>    2. Introduces FLEXCAN_QUIRK_IRQ_BERR to handle the two-interrupt
>>       configuration
>>    3. Adds S32N79 device data and compatible string to the driver
>>    4. Adds FlexCAN device tree nodes for S32N79 SoC
>>    5. Enables FlexCAN devices on the S32N79-RDB board
>>
>> Tested on S32N79-RDB board with CAN and CAN FD communication.
> 
> I think DTS changes go into a separate series.
> 

Hi Marc,

I added the devicetree list to this thread.

> Please also have a look at the AI review:
> 
> https://sashiko.dev/#/patchset/20260318092215.23505-1-ciprianmarian.costea%40oss.nxp.com
> 
> Especially on patch#3.
> 
> I think we should split the main IRQ handler into 3 parts, message buff,
> bus error and state change.
> 
> regards,
> Marc
> 

Thanks for pointing to the AI review.

It raises two concerns:

1. Duplicate event processing (can be addressed by splitting the handler
as you've suggested).

This is a pre-existing issue affecting S32G2 (NR_IRQ_3 with 4 IRQ lines
to the same handler) and MCF5441X (3 IRQ lines on the same handler).
I'll include this as a preparatory patch in the next version of the series.

2. Concurrent skb_irq_queue access (pre-existing, separate scope)

The __skb_queue_add_sort() calls on offload->skb_irq_queue are lockless.
When the mb and esr handlers run concurrently on different CPUs, both
can manipulate the list simultaneously.
This is a valid concern, but it's also pre-existing.

The fix requires changes in CAN core's rx-offload.c rather than in
flexcan, so I think it would be better handled in a separate series.

Would you agree ?

Best regards,
Ciprian



