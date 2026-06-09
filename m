Return-Path: <linux-can+bounces-7780-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j72mGbYlKGpM/AIAu9opvQ
	(envelope-from <linux-can+bounces-7780-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:39:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E53556613BC
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=potbl3Pc;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7780-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7780-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2563C30C976A
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733B35028D;
	Tue,  9 Jun 2026 14:30:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46834A78F;
	Tue,  9 Jun 2026 14:30:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015412; cv=fail; b=Qj9Utg9vURL43K+nbCgRrUksPXrdDREZelCK9ecYiTi7axBqZjhxeiYq1319LSoH/lnuSet7tcn+8b2m+dv4rIp2N5QvvUjUjtox0ti/ZB5laADeHQUw8pUK2aZY7yTCyRHzD0Raz0VAVilYKNectgvQsa70Qryia08zSEshwWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015412; c=relaxed/simple;
	bh=DI8NbWiRRAIb+JDEt639lowZjnGhU8VOLTZ5BPXZH48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBpKCb6gw1rmN1j6NzWNIkRnwdPuohTECA67I6f3psHNEKrLJNT4hmOcNQQx+8JJzwKyIRZFV32MzxRAkG7El153sp56WK1IkJj+5xzbm8iCcO3boDQEPC6t7eYCJ8fUtgkcuejz0yt4Tzm8aPOc51I0Jx7Yp951Lt2n23HXQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=potbl3Pc; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJt4ev3/ne+ZvulXb9V2zlHDovXqOL6zEGM8AnwETrcQx+kXNT0h29kXaFaLgCnCkq+kU3zI40mByO0J1uXmUqkXrHwYgA9RNV4fXPJ4nNCu6//QmfPbUDa0NdG3ZM1oFNCyMoGPI/OeTc6odjNxivq4WahQldhscAFYXF5OvEBa9Z+iHjTVAIb7pQalKWRnAcPHIGnA1XMwz+n9Euwglc1VgyY/xgms2hzH81UfcuQiyM6EBDRDvf99lfPekU/ggYEAmBtyV91mJGiKPeYfsBCPar8Vqcb/f/EYmo6h+Vb85ejKkY6RetNJIgJ2exZcJw8XtsEcG7pYHK4sZGEo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymbqo3sQf65nxypSQJAoEHnEh6imn6MCosTpIapEuzc=;
 b=f9KkTlacfBMuAEr2+jRatYZipPRd5Z+9qd0HXTK2SBX4bRQrYjU32/JShfCj39Xj11c/jscQ4V0Jz+Qf8MoB10iJeEthctoEUdn4+sgwN5A1hNn/k3ugontZ27gNsud9VgcDQkPMtEKe9mJvcbyhMB2NRVWK9OGyD4r6tEGyAy3mwAG3NtYotA1OXHveSMlAFaT060nu0Jr9VXOyyz7Z0P0ZUnStC1h14gX4QMSui43vst9iMQf8zMDBLitY2fHUOf5fBDAiD0wHy19jAgP2gqAfiM7G3awmOToLU1OS1qv1lu6RHDveF1N9FqZx6J1gnzoHOY2BtrH4Hb4uveDnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymbqo3sQf65nxypSQJAoEHnEh6imn6MCosTpIapEuzc=;
 b=potbl3PcXah4KSpTvJ2144EuTnOfZWnkitANAJRYzfKKSR43RZyX7dsC7ay/s/cMgmA110FdAZjOt8Marw+2C9hrwiuNQDpC/zN7FiwDDTNoDFynYyttPpUPihWs4uYcOtyw4HBoKqiKYsuXWqeEITMgwRes6KcZwn65wmNUFhihh2bjO2GnN0wMTYrmCEWHBPNWFwJegW6KSKBt0W9fAlPXaQ3qMT0wqmm8uKDBRhTNbzNJSwm2lDoeY5QjK0B//MpjTCl9ydj5R62996gVzXencKwhS5QfVPD2k54+yIN6uzOgxW1NGRLHoMLhL40pPVZCFjTtql3tlW+2CAIa9g==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 14:30:03 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 14:30:03 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v5 4/8] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Tue,  9 Jun 2026 16:29:50 +0200
Message-ID: <20260609142954.1807421-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: cde6ffef-9f4b-484c-c6be-08dec6339822
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 2l+g4asPG+rq7ccIc6HosnPUETzCvLVSYDxELk45JdDkw1ekdmE31ucIX/kc9IPMP2dp51vmyZ/vvTOG7jq5Zk/t4bMcCAaIoJJkr1cibHydhnPL1UNB0sDSTvPg5+TnxbQs7cjugYU5jNtJz68qxQlM1mYr/t+DbqNwMQ1ADL8wDdA/G7KFWiQpQVT/r8rrjSUWCVNt5XvZTKJKobCMdVVjnYIedN9qfFlaP8CTr5T91ta+xYxY5BxBxtESXOPgJlBZqpOhSxhy8o6G5Z63slJ65b9W78LHN8LdFogS22Wm0bEVS37tsfNP06s+XGgTMkAJh2BIcUleurlVRVclqO2i+sYblFax1YW8jDEuLZQHMayOKavM53EzXJphCRLqPq8A3f4YgNs819rZofYLJ2/2Y76byGAwuznPh7n3uJbd49Zko6+RgpLA1arNxBtQDElxNHzMdnXANeyOSb+qsYpDMukS4dfVBp4SbRgfkEyPbPBRK+rcWPBnwnNRf2LW/hJox/S4y82pzPOOk4aypAmc15xxKJQ0NVRT4ws5nYibu64NUiOxSIQdbJHPv6LuQi1KtOpRBaGPotvq/rE+79hVNFNSJ3uNylP06kihT4QVhpihver29y35QLXhNZcU5hZvGl15sO2yxFR0aQJOON6wSO/nQPkELa0FpFlNa3mPzfUa1lKY1zngZs+HOGvF
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QU1OQUxQYis2Q29uRjhzdzhuWEV5c1BhY05LMTlyVjMrVVFZUW5tZkg2eXd4?=
 =?utf-8?B?WGJRY0NUQVEyTlFFOTVpbFRqK3dCUGgwbTRadE9ON3hxa1dLb1U1WGhZSURC?=
 =?utf-8?B?MjR2RlVkYmUxTTZ5Tk84U3ZLN0pva2N4Qk90STFGUVFjK1ZKVFIvbmVmN2Fp?=
 =?utf-8?B?V0V3Y0luazRxWDNaZkdzRUlWRFZwQTBSalJOd3pTWWphZlFWM1REcGZYQjVZ?=
 =?utf-8?B?a3REa2Q3SFRRUzJBdFNuQlN6RjU0Z0czRTAwaGtRU3daTzBFU3dmYUNJNnpD?=
 =?utf-8?B?Vk9hcThROVZOMGh4RXFYeXllaDBxZEZQSkFyWlFMWjZNdlozem5HejZ0aCt4?=
 =?utf-8?B?R3Rlck9sekZJcm9TWXJQeHg5S0dreXpYOHpWWWRPUTVaWG1sVXdWUXFNeVBT?=
 =?utf-8?B?dWtSYnVsdXJNNFczaHRDQ3lKUHdTVEZJd2lIY3l4UHdEVWZycjRTRHZOdEFt?=
 =?utf-8?B?eFJRR3lMYncrVldsM0xRZGVvbjRVRVkraDN0ZnNXVHdvR0M3VGRwc2s1cmZ1?=
 =?utf-8?B?eVhSQmVQVG80ZXQ3RkN6M3RuSGVuYUNXbGJTRGtvUWlEWmljc1dVRlQ4ZkRT?=
 =?utf-8?B?M3k4bnFKZWNGRUNxMUlacmtUMkE0em1iTGE4bTdwWDRvT1FMK2NqUk1Ud2hw?=
 =?utf-8?B?RXB2RE9xOXNhQ2s4b0RjNkdaR255TXRYVXFoSTNMbHVVcWJBSzlSalNCVlZJ?=
 =?utf-8?B?ZmdxbjhYWm5HazRCZ096M2syNktnaUFNN3B5czdyRTlOMHJFM1g5SS8wQUtv?=
 =?utf-8?B?dnVuU2sxOUp0OThseE1hNjd5aThzd0RaUnZST3EwaE8zSTdpaTR1cS9mT1RN?=
 =?utf-8?B?WmlIMVp2TFFaTUxtRGFoN2YwUmlQNVdGYzl4SjJ1V1FjUnZFeWlNMEdPeXo1?=
 =?utf-8?B?b1c5NXRLTzhKY2tNZURSdktGYkdINUhhNTNqMEQwYjVhaGVXWXdLSFpiRmpM?=
 =?utf-8?B?MjR2M3pINlB3T0FkbHJYUm5YZFdPaHNPQ0NsNUZnU0RFOUM5TVFqVGFDMDg2?=
 =?utf-8?B?bE9IMXhIaEVoZGtXSlVIS1ExU0JkRUFicGs5Mmh1OFZlVkgyNnVnTFBFbWV5?=
 =?utf-8?B?bXV6dXJ6Z0ZDWnNSTFYxUmhkTGwrcXFqWFQ2SFNMc3ByOEc5SkNzMTkvc3k5?=
 =?utf-8?B?bS9JTDN1UGhVczhWbzZoYVh1dEZGTmd2N2w5Vms4UGRyS2NadjBzVE9oR3JH?=
 =?utf-8?B?WTBMYUZhYS9Ra1UrOGI1NDFmTDBnVUhneCtXeXdhS3I0dVNqMXUxeGJLOGFm?=
 =?utf-8?B?NGhJZ2oyWm83QUZoMjVRYm5nM2Ficjd1RjZERVBnTW1ZSDRtbzcrM0ZtamNE?=
 =?utf-8?B?eWE2QjY2VDN0dEdzZWc5RVVBYVhIME9MSVBDZVJTTWhqRHNoQTNyUTN2RWs4?=
 =?utf-8?B?U1hoelJKeGcxamVNTUx4eFZxanBOTkdaUjFVcTV4bmx3N3dUWGczT0F0anFs?=
 =?utf-8?B?ZzF5dTc1Q0JsMVYwM3BBT2xKRkNLR3hZU0NFTi92OS8vQjFUa0lQaTBqcDFh?=
 =?utf-8?B?NTNFYW9zV2M2MmZ0SEZUS0J2bXFqVVdmblRhVWFZbFNWbS9lL2x2VnpPdHdW?=
 =?utf-8?B?dDd6QzFkUVgxcFVRemNBWnNOd3V2L2g1VWFxUWxqMDlDRVNJa2FudVc2a2FY?=
 =?utf-8?B?SHpEWk1rVHhuenVEZGZlbjNWRTBWR2dxU2JzSDRIVjlyRDFzQjB2d05uZVU3?=
 =?utf-8?B?NXdPRE9LSXBUMWZkL3ozcVlBK216UlZqUGY0dWxWRzdFcHM0WGlqcy9QTWFU?=
 =?utf-8?B?VUd4SG1DeGVhU2k3bFd6bzRabWg5RkNWZzFld3krcGRTN1JvV2JZdkF0VG11?=
 =?utf-8?B?ZUk1UCtFOFUyTEg0cmxsZlhoR2tuWll6OVpLV3g0dHVtaTVocGtoZXlzaEw0?=
 =?utf-8?B?WHF1SHBoVmhieFk5cktYbDc3T0c0VllKdWlET2ZwVDMyT3piV1VaU2xrK1Vn?=
 =?utf-8?B?VGg2WEhtTXRLdVJwaHdzMDdyajIrTWI3QStHdjZNVFJ6QXRqOFRYcFFKajFr?=
 =?utf-8?B?TjkyNzhadXhGVDdtbzVwNmV6ZmlXTnphM0tIa21PV0FOM01HZE8rOUNTU3JC?=
 =?utf-8?B?QlRvem04S3BJUEpXRHZ1cCtFVjZhQ2tUN0N2NWFnZjkyZDV4b0xLYk9GWmdp?=
 =?utf-8?B?SDBSMCtZN2ZaZXhlVGFzRnN1Q3Y2UjF1QWtwOWlWVjlIR09jS3VaUE5tSDhL?=
 =?utf-8?B?ZWIzYVFwY1NRQXlmRE9BVjNFSGNwVUJPTW92ZktTa2M1cDMrN2ptU0Q4THZy?=
 =?utf-8?B?YUx0aVpBZUFjUFFYVjc2N1Fob0hLTGNvK3FaQWZockloazk4ZHRTZjRTTGpz?=
 =?utf-8?B?RXoybEhiR0g5UlNyOGtFSVo1YVJBZWJNb3BzVjlRNFBnWXBOKzZkcTFYdWFi?=
 =?utf-8?Q?jwqeDFWqMZhGLMHA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde6ffef-9f4b-484c-c6be-08dec6339822
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:30:03.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIaaGpHcRSMNs601zt1wdMXX0nmuZ9wLaiTyQSZ/dmmS3DqRg4r7akKUnP2qnqOBCTDvn/jK1ly1jYFAXfZdEhNyUu/hVutT12AzNKTfU3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7780-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:conor.dooley@microchip.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E53556613BC

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add NXP S32N79 SoC compatible string and interrupt properties.

On S32N79, FlexCAN IP is integrated with two interrupt lines:
one for the mailbox interrupts (0-127) and one for signaling
bus errors and device state changes.

Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f81d56f7c12a..d098a44c2b9c 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -26,6 +26,7 @@ properties:
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
           - nxp,s32g2-flexcan
+          - nxp,s32n79-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -173,11 +174,38 @@ allOf:
             - const: mb-1
       required:
         - interrupt-names
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32n79-flexcan
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Message Buffer interrupt for mailboxes 0-127
+            - description: Bus Error and Device state change interrupt
+        interrupt-names:
+          items:
+            - const: mb-0
+            - const: berr
+      required:
+        - interrupt-names
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nxp,s32g2-flexcan
+                - nxp,s32n79-flexcan
+    then:
       properties:
         interrupts:
           maxItems: 1
         interrupt-names: false
+
   - if:
       required:
         - xceiver-supply
-- 
2.43.0


