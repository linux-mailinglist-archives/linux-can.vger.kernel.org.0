Return-Path: <linux-can+bounces-8358-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2MEUEmSoVGrQowMAu9opvQ
	(envelope-from <linux-can+bounces-8358-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:57:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C2749036
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 10:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=MCU7RYqm;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8358-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8358-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81BF23013D74
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCA3D47A0;
	Mon, 13 Jul 2026 08:53:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BB3D331D;
	Mon, 13 Jul 2026 08:53:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932802; cv=fail; b=G0lu6S08cMqLBi/H310R6amz5yvtVzxEyzLQGAkMDYfuj32nqL5hkvCJhVBrvBSrDBV3nyDEEfaoojWiG0jpDoJHuep2HFtyVv7d/NZF5AULIcLN8+FmcYUvUjYa8VI9hvc2i38vyxvAw7cwT27FgEF+aNHPF1xLzIKpny8tu7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932802; c=relaxed/simple;
	bh=YAexm8pVlZDny8Ten3hso/o/Gvry2HaPfLMK4PB2AjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S80gPaNIavsczYOe6GBDNWalB4jfRzV2iuim7vUfGb+1DWmW3qYIl7y/YPxSMeMW47dcyxNzB1c1c1stnro1+n3F0AdEFzQaNKA4fjbqbo1HiKV04aLq7hjcD+0NImiGlah88WQ08c0Hl9Vzah1/4S+NL6gIM1htxjuA1lHxqe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MCU7RYqm; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvM/G0vrOqAYd+92nvNkyTAXXX18X9ml1kcvB4j2tDk93TD3oaLTbo6CbongbrCWZ2RQ5+ryJBsuND9V9JU+EGZXkRczdqLjA0tWj4RDa+E8yFtPU/kPXlTAutKA7snMUEDquYWIS+5K+LZ41Az/zCht/r0u13z+0i2GR/rAmAG+wODof0llqhwNN7mz3uc9rrvJS2Niv88tCNVibuM9LhEmt3YGVM/mMTNWLIj+bUwW98di29IfxJyN6PM0zc/3a37nJAmtpnNTx25XVLq4tFPiwVzkAuzgtcs8TAZ9BDxUqS80eSqWvna4oIDx+BS5tpWjuw20gNKY3BMW755VyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTZLozdaZejLwtCbU/HyeDKjbs0bUL40fVmInykkfXA=;
 b=EGGd6x78r6sLF1B1Ng+UfVG3Bdl0rEAmDfZhn4rPQVRK5vhMOY67O2R+KTxDRgN8YKtVvyBaHZ6xioV36jwY5tK/4D2yoz+Plsd47uckbPahP9jYyJvpYZLRGbEpxUz4PGdkiQrv6OyqQIIsCjx9wGjYXkU2sQiMfssaVImUHDvgHA7p1KdiTbh4CSaUWjRJHq6IJdn3HLixIWCYkcZrnVeiQABM9aHrwOolP1q+bsvO7pI9lTXP6BBNnGshmFT9MNKdYP3fHNbyDBOBbqUxksIj4crMU87Yr9xx409jMAS7J0huo8xlOIpJQdY068kCiqscgm3iEbdDjrE1qdpjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTZLozdaZejLwtCbU/HyeDKjbs0bUL40fVmInykkfXA=;
 b=MCU7RYqmxMr6NYCNXWBW47FCzlM1M39AYXbBUjq1B2jYf0ki9S83m3KCKtKZhEyWoV/7KTJxUEVnu3go8KiyLHWAx5eSYKgsFLy4xYV/ftQAKcrUU1vpyfciEcFjHzp01q5C7FvRApLrbakMUNfmsKjfFy265fc4ugBNqklMTy7acX3ArOW22cGcEqO76FWDsvuaPErSPiJ6iGrO41bFU+T614MxQYm1WEkoC5TLsdbwsFoEFzPRsnJ1asUcUu0SgWh+z2qyu4QaBfY8QKIcFpQ2uLx6AWWL2xSW5Pw7cM5Lg5zlv6aXB+f6n5ufyplabwwNluDNlENYzIvGW+ADXQ==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:53:14 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 08:53:14 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Dureghello <angelo@kernel-space.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ line
Date: Mon, 13 Jul 2026 10:53:03 +0200
Message-ID: <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::11) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: eebb0d66-ef03-4651-f99c-08dee0bc2c25
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 +KXSst3ngBGuXG/nMcfFhuDU/yeLxSQV4UmiwBsEtd8uo5C4/bvvJI2JMXl3kfmRQFfrwN9vEgd+rN57DFnfrW7I+uVIDlUxoempgjhYq2KFqo400fl4LZ+4raCe7I7ge3v9SLewR7pwwHx5D881NTQLccAq3KgrlC6RiZAHP8b757RthV2n5JMlp/Fiuu1oxQK16rUA6y21meG14oQ0j5nXDz9kZZSWIJZeBx3auXdJuxjrQSi8x+rtnJYUX/RPhxbIiGXCy61ilXf1dDdXl5pzRRDtrlFsKsRiGzYEM0KxbOiaof/Gjw87omqi6rjsyNm5XoaYRCHhPTtxt9GO4cTRXF0ODo/jEsDbrMVmkdPRH8UrofG9CBh3vM8/Dgk3yW7w5nRlgqEjxAomZqEyHtNQhrGkUZyv1wmruGJeSDgwOunWeUFFVvjq2jmF/s6wwVZGNi4NXyPSsUIVNREilfYsE8kaJpHwxG9+Ijeh6Levx6fhxLWGJs8/UMgtzLJIlAUxHHI39ruLoxAlBmthZoiuFqY4illi77iVL88QNb5BmmRmOgn2Eqg0AUpNLBGEeJvSaYVMI0YgC3Ikb6vjfHoeam79ygQgFsuNaj1Y4W8IjJZtJYoDtcS8IwhIwf4BDjuCX21QCxTk3VFnF5PnpjJstUtLEyqtNGvufjgB35c=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VDdwVGtCd0NyTEJMTVR3Q2NQM2E5UDJ5QThKS1hKU2ZWcG5DNGduV2o5dm5C?=
 =?utf-8?B?TUgwR29GaXJLbzRKdncxWTRFZDhKRERadnhUV1dpTzAzTW42ektrYnJpc3NI?=
 =?utf-8?B?Ukg4OW13NmxUSFd4Uk02bEZVcHJ5Tm1lYUpXaGZjd05kWGJFS0Y5SldmQjI5?=
 =?utf-8?B?VmxNQ2NiL0pENSt6cTZBU2NHS0RxVzZycGxrWWlndWo3cTFhMHJmcEJqSHlO?=
 =?utf-8?B?ZnRoZENvMGFxY253U0txWnFHeWUzZ0tJT1BWQytDei8yUCs4QnhYcS9rTk9X?=
 =?utf-8?B?ZXZtUjZ1SGNCS29La3lHL3A3eXJ6eWVMUmUyWWFQWUU1ZllZYm1wQXJ6cGZH?=
 =?utf-8?B?RHdSQXJiOXVkVzgxVUtNQ0FqQ0pHSzJVK2JaR3dLYUVaRzJmcjRNblQyMEZH?=
 =?utf-8?B?QzZCU0NoUUhkbWdMSWkyRVJGN0VDVUE0bU9Xc2JEUW9WWXNSZ1VCSkdvaG90?=
 =?utf-8?B?VzFTbEw5cWRDMGNjSUxONGZkZk5xN0dIakE1U21iMXJrRDR2eGVxUTRpenFP?=
 =?utf-8?B?WWRmT2lBSGVGRjhET0FoaU4vMTBCVDIzbHV3cEpSbkUrU0MzTEJESTlwWWFS?=
 =?utf-8?B?ZjlmQmxBcHh5NTRGRGs2U3pYRkV6blFaODVIUEFmcDJVNW9HZWhxbEVDdy9q?=
 =?utf-8?B?WUZwZHJUSGZRNDNzYzlMaElKZHFHMk5lRzlUaGs4RGswSit3WFZuTWU3OEgy?=
 =?utf-8?B?NkhVckVYZ1NZTmRuVnA2QjJyV0RjbGJqcmtGM3pkUzNJcUg5c1cwTnZIcnhD?=
 =?utf-8?B?T1l2K08wb0xsT3NUelMyQ0JLZXJYaXpkeDl3UGszVXI1QzYwU3dTUWUrOEpt?=
 =?utf-8?B?L0NNbWIwOVFMU0Y4WVRBZ3E2UG1FR2N3NkVSNlRTVS95akFHZkNXR2hTYVIx?=
 =?utf-8?B?V2tlSHVYVEdjczFGdzQ1QzFnWmdsdzZkb0EzNWxvcFB2V2J0RU9iSnBkZk9x?=
 =?utf-8?B?R3FNTHZNbmZJWkNoeUxSZERZN3RKblJOQmJGVUo5NkI0SllVdHFyVld6MFVV?=
 =?utf-8?B?dllpN2hETUtoMDErMnpYQlVOc2tTN25FM2lkNzc2c3F2Nk1Ld1pzYjd6SzRC?=
 =?utf-8?B?cUg2aVRuQU9tWS92WUFkQzVtd1d6RnhkbndicGJTUlBycXozN2lOZG8yUzFY?=
 =?utf-8?B?ZG5lYWVaaEtoNEdMdWdadGpYMVNsQUFJdGl6Q3FWYzhyRWNGSGJpNlF6OUhG?=
 =?utf-8?B?NHBPUTdVZUUrZVdGdkVuTjJHTWlocFM4Y1RxL2ZnT3doRS9qMUZMZmxSV1g5?=
 =?utf-8?B?aHVwNmdpekpLa0pSeVA4WklNTDRyZmNxekV3QytDam45bkxHLzY3Y203b2ww?=
 =?utf-8?B?OE9MUG1PTGxKYXJtMjZub2dmbzFkSENnTS9hVUluYjBMVWpWN0lsRTF6a2RF?=
 =?utf-8?B?cmRTOWFRSkJ4d25qdVlDM3NTN1J2bTZSQlZVTi93NFg5eG1leVdGMzk5ZmJx?=
 =?utf-8?B?M0U5aVFvMDdPN0s0aHVPSzEyMUE5NlYwdk55MlN6NjdzNkdQVkllSGZKcnp5?=
 =?utf-8?B?OG12eW5UWVI0aS9vU20zSVNGWWk1YzNReHZlNDgwMEp4T3pkSXo0aWpMbDlo?=
 =?utf-8?B?bEw1ODlodW1qVTRGelQyeXJZOVRoR3VnNVZud1hvTWFCSFhlanlJYXBkdnl0?=
 =?utf-8?B?b1VORFYrK0Y0bk9Wa2t0OWRlVGRJVU5CY1JrQ3JGdDVRSW1iL3pEZ05hTmV6?=
 =?utf-8?B?RHlsWkV2VXpORnNxQWFGVTZsS0hvWFU2Z0NZZFlOb3pFMkRhWmdzSWtaNEEx?=
 =?utf-8?B?eTV0QWY5dHlzRXpWaS9ObnBsYjJ5a0kxUjU1dEJKKzgxRkdXeUt5b3BZbDBX?=
 =?utf-8?B?Q3M0c3V3UmF3WVN4Q2NNOWlrK3BrZTZ5Sm1XSUNOT1FRWXJZeHd2SGRJdjB3?=
 =?utf-8?B?Q2ZYRDNTaHhLOENGNGNLaXZOVVZMczR3aGZZK1E4eEdibkQyV2RQVG5zTnZO?=
 =?utf-8?B?THIxV0JhMWtzVkM3MjFqRkwyK0lQWEJSTGlmQjhzcWhKV0xvMDZmSElVMDlH?=
 =?utf-8?B?b3kycE42azcwd0ZIS1c1VXlsR0RyU2ZFMkl5UG9OdFB5UHBHcUlMaktBVTZO?=
 =?utf-8?B?eDNUZ05YMjU4Lzc0K3ZuR3VwaUJOUnJ4YkluRTZnM0h1KzV4YlFkajBIYzZN?=
 =?utf-8?B?ci9SK0FsbmNXSHVoMUg3TXdmNElVdm9TTC9ZNkFCbDZYbThxU1BIU1QycXoy?=
 =?utf-8?B?NW93am9CbUtkei9yeGwxSk4ybnZYL204UEFLUVh3RjJrM2IxK3oydkhRU0hu?=
 =?utf-8?B?OUhabVNQcVVsWGh4ZmlLZU9EUmVRSTFheFdKZW9iZUFUNHVvclYwWnAyOGlm?=
 =?utf-8?B?cllydnNOMzMwUk8wSWE1NUYrajNNbVFldVlhbStJM2dpMXFDVU5zRXRodnM0?=
 =?utf-8?Q?mw7x0Bf0YYsJT738=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebb0d66-ef03-4651-f99c-08dee0bc2c25
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:53:13.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXGl6vYeZZ/38BkBYeCf0rsegxhNNf07Y4XJXucHVPD4qHTS9EwpEN/UQjcHNEWLKe7jNpSnZXulqbjlU2TBy8HOxIHQhuUrqWhbfk+nfiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8358-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:angelo@kernel-space.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E2C2749036

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On S32G2, which has two mailbox IRQ lines (mb-0 for MBs 0-7, mb-1
for MBs 8-63), both handlers currently process the full rx_mask/tx_mask
range.

Introduce FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK and
FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK to describe the split, and pass
the selected mask to flexcan_do_mb() via a new mb_mask parameter.

In flexcan_irq_mb(), the irq argument selects the correct mask: the
primary MB IRQ uses MB0_MASK and the secondary uses MB1_MASK.

For single-IRQ platforms, mb_mask is ~0ULL with no functional change.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 39 ++++++++++++++++++--------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 7dde2e623def..8b70952f7f05 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -182,6 +182,12 @@
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
 
+/* On platforms with FLEXCAN_QUIRK_SECONDARY_MB_IRQ, the MB IRQ lines are
+ * split.
+ */
+#define FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK	GENMASK_U64(7, 0)
+#define FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK	GENMASK_U64(63, 8)
+
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
 #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
@@ -957,14 +963,16 @@ static inline void flexcan_write64(struct flexcan_priv *priv, u64 val, void __io
 		priv->write(lower_32_bits(val), addr);
 }
 
-static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv,
+					    u64 rx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->rx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, rx_mask);
 }
 
-static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv)
+static inline u64 flexcan_read_reg_iflag_tx(struct flexcan_priv *priv,
+					    u64 tx_mask)
 {
-	return flexcan_read64_mask(priv, &priv->regs->iflag1, priv->tx_mask);
+	return flexcan_read64_mask(priv, &priv->regs->iflag1, tx_mask);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
@@ -1071,12 +1079,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 }
 
 /* Process mailbox (RX + TX) events */
-static irqreturn_t flexcan_do_mb(struct net_device *dev)
+static irqreturn_t flexcan_do_mb(struct net_device *dev, u64 mb_mask)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
+	u64 rx_mask = priv->rx_mask & mb_mask;
+	u64 tx_mask = priv->tx_mask & mb_mask;
 	u64 reg_iflag_tx;
 
 	/* reception interrupt */
@@ -1084,7 +1094,8 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		u64 reg_iflag_rx;
 		int ret;
 
-		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
+		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv,
+								 rx_mask))) {
 			handled = IRQ_HANDLED;
 			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
 								   reg_iflag_rx);
@@ -1110,10 +1121,10 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		}
 	}
 
-	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv);
+	reg_iflag_tx = flexcan_read_reg_iflag_tx(priv, tx_mask);
 
 	/* transmission complete interrupt */
-	if (reg_iflag_tx & priv->tx_mask) {
+	if (reg_iflag_tx & tx_mask) {
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
@@ -1125,7 +1136,7 @@ static irqreturn_t flexcan_do_mb(struct net_device *dev)
 		/* after sending a RTR frame MB is in RX mode */
 		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			    &priv->tx_mb->can_ctrl);
-		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
+		flexcan_write64(priv, tx_mask, &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -1228,7 +1239,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, ~0ULL);
 	handled |= flexcan_do_state(dev);
 	handled |= flexcan_do_berr(dev);
 
@@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
 	struct net_device *dev = dev_id;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	irqreturn_t handled;
+	u64 mb_mask = ~0ULL;
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
+		mb_mask = (irq == priv->irq_secondary_mb) ?
+			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
+			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
 
-	handled = flexcan_do_mb(dev);
+	handled = flexcan_do_mb(dev, mb_mask);
 
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
-- 
2.43.0


