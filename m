Return-Path: <linux-can+bounces-7742-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iXE/DDzVH2qfqgAAu9opvQ
	(envelope-from <linux-can+bounces-7742-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:18:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB66351BD
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 09:18:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="Imv/dOcj";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7742-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7742-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAC2230FCFAA
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229D23FE352;
	Wed,  3 Jun 2026 07:14:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD513FC5BF;
	Wed,  3 Jun 2026 07:14:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470843; cv=fail; b=UOKFYvbl4Hr8vdROtW2L5VACx4L3UCFbqewbSRrQP8qZP1FP7KPowUVmi+xIDByNOtt5BZ+AF9k5EqF0zzFBIdDE9eHwKuOnTgjX4yfNxnHTUHtOBuvbjjErJfx4pgQxEI22hQmyTP17NxSYK3Hm8SCvX0YbW2JLfkrfwMqulNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470843; c=relaxed/simple;
	bh=qzems42JZDALtZjOyylkBxSamEuZvhtzQ6EdLzhOMsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AdF7BvusWfuLE/Ya9CAQCHXcIKQEd15R/tAx9aXrR+9qXsifoFoQaJbW5LIXkfQ6NUFMFv/163C9dNiBAfIRfs1MeZAmwqPoMZHeg4i4dk8zPjHF+qCieQxnU16AQtEOsZb6yNKpSpFVR16Zm79aBevvQh3ptQYMartdUBkq97w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Imv/dOcj; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYc1MHhJeudN9h+5nnYl8M7uMhrmOef3lgUEQ5VAxwYIOrLFKohVPkyY7UO6A3rxVygzVbq/f5VrOuZMUiW45/CX2sGTZ5TPYJki0kKze84DXvFkvlIuIIBHr4QjQ3fStUu/usObJuoa1ebfIZ32c/KJr1AML0f5vElSRHJXhMJH/iXo2nARF4Qm8kus6mWNv80sZid+i2XAHPEENs1rwWvEhuYvG49/cR7aGkg3OkPFOIrx209oWIlvWcmbPPNrzyKMvcV/DWWZJNqAZ9upe8gONRw641nXdT55sN+7U2kMa0rvIhrX0tP3dg7iiriuZDEihzJ/zYMrRYlKGiISwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uss7/Ijtj0jsVvVvdMGWuu3tCDw6dMlREoi5kZ5o+Q=;
 b=zFR7otfIYCdl9JLbsjLSpJGTBQubGeT+eESJaJX4gt+E0E21KGyM+WY+JH/ROK///ibhR2JkKf/RaUE1YvNTHxbhQb5lFVpaIVzkJhV/OtFj2h8T4+73WRMT5K3v0zK74sOuMrH6NAaPi8/hfaBIIvkMRW1Ag1gF7ylG+TF2fWnocyZ3I4iAF2TPwcJ/0MWhsBZNbJ3L7SffC1xx8kIT9y/5ua61+1i90Brr+jtSzeZw3FD4JuvTXKvy5A/vxZGB6bhDFYbRjL+RdEFPzPVmQmE7kuRLj8rLJkC5iSQmvsjklMX7ZnNbLM+nlvbgFzeeYvjb3onTGhJhxsBqJemnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uss7/Ijtj0jsVvVvdMGWuu3tCDw6dMlREoi5kZ5o+Q=;
 b=Imv/dOcjw8qAqhSMoEti2m2Ehl2WX9qoERf8XE3PF2O4vMxYGMi0VYjqxG2QSX8TY4ap/nl6Ly0PyJVKgh4SXuu3nW2jZNCHn6KFTswAGOvAuLZoPwRHUk2leEmS29eISXv3XEYV2PWK31BgOccFBCfV2QOqsnGpCtB9dvGfUMIY1W+C65BCHn1oKqY8itdTm1ESfLS6TVziF3UQssOMcWC6T7VaZJZ6AKKOEx3aGi5m6iN+jXzumIdWhQ4m+Kx6qJqRAOFxiyrq1Db/um2eaAx/cS6dpIpCDeMiXfbNeagt9rVTRmctSwZTqgYTTaus0nqWqXGQIhrvSe3Qh26GCw==
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com (2603:10a6:208:132::23)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:13:56 +0000
Received: from AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6]) by AM0PR04MB5858.eurprd04.prod.outlook.com
 ([fe80::bdf4:c9d1:4e3f:68c6%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:13:56 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH RESEND v4 5/8] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Date: Wed,  3 Jun 2026 09:13:39 +0200
Message-ID: <20260603071342.641874-6-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
References: <20260603071342.641874-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AM0PR04MB5858.eurprd04.prod.outlook.com
 (2603:10a6:208:132::23)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5858:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ca4a22-580e-48cc-5d91-08dec13facd3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|18002099003|22082099003|10063799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 Zr2et2LStq23qdzgPDdbrJoLOOI3TW/JZFfvULoc8t+97O7HDHLgco5XrOgZyDhthl/4BcHwlJZhd5oBRyczCW/R+8SnGXS1qRT3nladSqh9ned/y1e805ks2jgnu+m9B3ndroehIxKA7/s/MSa3cxKCuOZUQ1RNpYGfapdhjN/8RRfHO0ngV5nJsst5bEoNPVNUm1JYIFq/xyeGUb7vj3/H22OuzzQohN/cJVJMyD6mMov9W+9Isa2ZF6MkOxcBqsh6QWlVjg25DoB87CYGw1BeCYTxr2H5OQccJhFPpDA25PoJXMc/2fXISUwPvxS0payb1HdLy7F3KZZDUruYIe+PmJPljFbPQmeQ9JyymEYdoC/UZXhFNmuAh3EJgjdZPepCckD7r1wA4TZLCJTtQ3ywbxMZXK7K9+KuMbuHVq3rEhz8abseoVKEgRWHrlH10qeVVnB1zxi84zECh3wIp8XFZ04CIzBmpHhU3Src9fSz512tNTlXff8ZZbHk8E004AK4TOZZwkIYLlbC+eAnKifQQjFh8wwD3S/5ZNKnpvd06yDRK2MgEKx9krpZYVv6Qc1YqlAFC5irymnG3WFTcif4Yi/jsDNdWx0c46PQVXYadltlqfE81H1qDvSu9+nmXj0M+BJkckrym3FbZOZDfq3WYJd2566zC3AkAFHV0VqDD6IhTDO2tWbyo37BDOoo
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5858.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(18002099003)(22082099003)(10063799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZC9XcklyTGg5Zm5GbFBnMDhLMXNxYnZ0S2wrVDlyL1RuaDIzdUkvTy9oOTYw?=
 =?utf-8?B?SEIxNzFsWG9pK0dzNEVsQWQvT3d0VnZGYWZQN2pKeDhSSzJyY2d5dEI1cGIw?=
 =?utf-8?B?YnJHN2o1Yk5ORk52MEk4a0MxSmFMSmw3ZS8wT3JsRXRGd1ltWGJqOUJJNWpP?=
 =?utf-8?B?YUtyV2c5a0Vaa0dkekg4d3FHamFjZ2JhU1R5TGJ3UzhSZ09hOS9ndUNGUFVh?=
 =?utf-8?B?VldIQkg2QWh2azF3eExDTEsrRWEvazVvM3UvTHNQbHorb2VMaU1zTW1iRW5t?=
 =?utf-8?B?YjZldGNpMGdIUHF1OXUxNUx6WjdDMVhnakVNVFlIMzJmcmE1V3VkU0hRNklx?=
 =?utf-8?B?TGZLeFpERUxYcUNoWTU3Y0J0UUFSeG5iTjF4aWZZeXZYME9tUUhlcW5KZU15?=
 =?utf-8?B?a3oyUDlWd1JKMHVqbi9ZSThwK3RQVTF5U0w4VkV5WFAwN0E4Um1QaGFRTGJE?=
 =?utf-8?B?MFp4R0hlQTJsWkVxL1NtREhKbzN3MTdLWm9Vbm1Uak54ejJ2a3gzMXpiamNT?=
 =?utf-8?B?WmRzbkFydERoVVh4aDhHWkltaEEyWGdNRjMyMzhPNUFORUNzMjZkS0crd2Rz?=
 =?utf-8?B?Mk4yNDFCTWFjbGw4Mk9vaFNJZHhqTXB6bFpNRVRrcFZFQnFqa3cwazh6aGZi?=
 =?utf-8?B?b291M05FZ2kvR2ZRTVlQRU83NmU2QThnNTh2cjNrNXJRWjJkVFhDUG52S0Rq?=
 =?utf-8?B?UFhVOXpsUkp2TFRYVktUbUREVEVIMFZWcVNUczRBd1paUzg2eGF0R3E0dFVW?=
 =?utf-8?B?ME5vMWoyRkpVMUlmaUNHT2JGdGNEaHpvc0pYR014NUFZd05ldGtoM3N0UDFJ?=
 =?utf-8?B?NFdsWXM1TVA3V1FOR1ltVkRMaks3bFZYYUdkK1A1Rko4alovWWUweG1wVlFu?=
 =?utf-8?B?cVFCVUhBNVZZNXhCVmFaTmRTei96WmVzZk94N3BQVzV5QXF5UjlYS1dJZDhE?=
 =?utf-8?B?V1pIQUYrN1hwcFMya2l0STRpUXJ2RjBKRkt5cm5lc3hPT3hsY3BlbC9YL3pt?=
 =?utf-8?B?dlBVMnBia29DY0YzWjRUbUJnSXQ5WC96UWJmOHkvNStpa29GSEtTREhLdkxH?=
 =?utf-8?B?TTh1LzF3TTcreXdmVEpNSHVsSUlqVVpvNW9ZY1NIdUtKTHRSSENOZDlRYSs5?=
 =?utf-8?B?cmFvQms2eXMrVGJNS0J1cklIejU3M1Y5dWUwdE9OSlg4cUpWSEZqM25QTVlr?=
 =?utf-8?B?czBiN3YwNnI0ZmxSay9POTNHVmw3TTVIUjBiUUtwOEt0UzRqKzNlNzlYY2FK?=
 =?utf-8?B?dEtxWTNjWUYvMllUaGs0SHNGRU81aVZ0anY1UHdTNzVSeGEvY0h6ZzNFODQv?=
 =?utf-8?B?NVQ4YStkdEhIN21mNFZXSk1US29HVG5UODlMVGdidnRYeXlyQ3FLUGh6MlFK?=
 =?utf-8?B?K1B5QmhCUnNxQ2xjN2VlNVVaZEpxQS9scG5ETG9ub3hTRXFLcWxzbytDMlZB?=
 =?utf-8?B?SEVBeW9TOUo4RFVpeFlPbWNDWjFnLzMraEM0VnhlcnNYTlptWld6M2VhT1Q3?=
 =?utf-8?B?RXNwWHcvZzNtMUdZQTRlcjYxenhKRE5sQjREMnFkUGpGMmR5b2JvTkhwTFor?=
 =?utf-8?B?a1NuL3VXWHYyODgxOTBhWkdYL2Jvc29YbmJyZlFhWjdDSGtEcnVGL1VocFZj?=
 =?utf-8?B?WkhUbzAwb2lVZFpnVWdGTTRyWHYvS2lBNXY2NWoxWHRtZGllL05UdzNNRHpi?=
 =?utf-8?B?bXdIQ0xQclNFdVhabEYxZERBbXZreDNwOGxpNWo0SCtwZ2NEWGY3UHF6Vkl0?=
 =?utf-8?B?c1BkWDVwR2pTaXV6MW5nUC9MVXlMYi9tUkw3cUw0aUM5VC84Q25rVW9USFJ4?=
 =?utf-8?B?UzUreUdnd05lTmJZenh0MXJQMXZkV2pUZEZOT1puWm50bVcxcHNyZTJPV3R5?=
 =?utf-8?B?K1lYV01BRysyR3o4WnE3SHJwUmZzVEtVeXIxcTFLUjZmTTkwUGVOdUVSSEYr?=
 =?utf-8?B?cTBnRmFYVUtUME9vNE1IeEdvT3N4OWRJRmVZR1hPcDBFWHJTZTVSYnFacmcx?=
 =?utf-8?B?WUgrb29UOFFuTXFKTlc0VWVvQ0ZkVldiZFoxVG5aVVI1MjZ6SjU0azE5OUNm?=
 =?utf-8?B?eGRqc3RQdzFwalpvZFdkYlRuTThLOGRzUXVYY21EOXpnN2dZaWpzakFPK1U2?=
 =?utf-8?B?emNNVk1lYmo3L2hhaTk5TjRrSXJ3RE00ZUhKZzRvYTMyUS9oTkd6S2ZKRW5J?=
 =?utf-8?B?Nm12Sm1pQ2NLR2E5Uzg0MjVHQm15VUFqR1R1b0VVNnF1ZUZKcTh2L3ZEN05z?=
 =?utf-8?B?Zjhod3U0NDVxdWNpdy9JUThGT0p2aGpaejBuNDJjNS96QUVvd3VOS2NNdjQ1?=
 =?utf-8?B?Unc3SGNiWG5YbWV0THVaZnliMGdlSEprdjJKdDdCbmkybWFmS0FZUnFmbnBE?=
 =?utf-8?Q?ovf5A05MnVtopGXQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ca4a22-580e-48cc-5d91-08dec13facd3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5858.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:13:56.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5gatpLs1fGvhg+rL6CYk3lxW8s7buNXcD05UYae7dd7FB8n31ZDX75mH+uiPk7BXY6iC9k09QHvUV+7BpRAkYmXizwiRSFOEETHcqqVQkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7742-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:ciprianmarian.costea@oss.nxp.com,m:larisa.grigore@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,oss.nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6AB66351BD

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes.

This adds the flexcan_irq_esr() handler which composes
flexcan_do_state() and flexcan_do_berr() to handle platforms where
these events share a single IRQ line.

Also extend flexcan_chip_interrupts_enable() to disable/enable the
new IRQ line during IMASK register writes.

This is required for NXP S32N79 SoC support.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 54 +++++++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h      |  2 +
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 32e4d4da00a1..23ddf7910641 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1293,6 +1293,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
 	return handled;
 }
 
+/* Combined bus error and state change IRQ handler */
+static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
 static void flexcan_set_bittiming_ctrl(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1549,10 +1565,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	u64 reg_imask;
 
 	disable_irq(dev->irq);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		disable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		disable_irq(priv->irq_err);
-	}
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		disable_irq(priv->irq_secondary_mb);
 
@@ -1564,10 +1580,10 @@ static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 	enable_irq(dev->irq);
 	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		enable_irq(priv->irq_secondary_mb);
-	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
-		enable_irq(priv->irq_boff);
+	if (quirks & (FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		enable_irq(priv->irq_err);
-	}
+	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		enable_irq(priv->irq_boff);
 }
 
 static void flexcan_chip_interrupts_disable(const struct net_device *dev)
@@ -1891,7 +1907,8 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_IRQ_BERR))
 		err = request_irq(dev->irq, flexcan_irq_mb,
 				  IRQF_SHARED, dev->name, dev);
 	else
@@ -1912,6 +1929,13 @@ static int flexcan_open(struct net_device *dev)
 			goto out_free_irq_boff;
 	}
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		err = request_irq(priv->irq_err,
+				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
+		if (err)
+			goto out_free_irq_boff;
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
 				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
@@ -1926,7 +1950,8 @@ static int flexcan_open(struct net_device *dev)
 	return 0;
 
  out_free_irq_err:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
  out_free_irq_boff:
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
@@ -1958,10 +1983,12 @@ static int flexcan_close(struct net_device *dev)
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
 		free_irq(priv->irq_secondary_mb, dev);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
+	if (priv->devtype_data.quirks &
+			(FLEXCAN_QUIRK_IRQ_BERR | FLEXCAN_QUIRK_NR_IRQ_3))
 		free_irq(priv->irq_err, dev);
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
 		free_irq(priv->irq_boff, dev);
-	}
 
 	free_irq(dev->irq, dev);
 	can_rx_offload_disable(&priv->offload);
@@ -2348,12 +2375,21 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (transceiver)
 		priv->can.bitrate_max = transceiver->attrs.max_link_rate;
 
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
+		priv->irq_err = platform_get_irq_byname(pdev, "berr");
+		if (priv->irq_err < 0) {
+			err = priv->irq_err;
+			goto failed_platform_get_irq;
+		}
+	}
+
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		priv->irq_boff = platform_get_irq(pdev, 1);
 		if (priv->irq_boff < 0) {
 			err = priv->irq_boff;
 			goto failed_platform_get_irq;
 		}
+
 		priv->irq_err = platform_get_irq(pdev, 2);
 		if (priv->irq_err < 0) {
 			err = priv->irq_err;
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 22aa097ec3c0..43d4e0da3779 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -74,6 +74,8 @@
  * both need to have an interrupt handler registered.
  */
 #define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
+/* Setup dedicated bus error and state change IRQ */
+#define FLEXCAN_QUIRK_IRQ_BERR	BIT(19)
 
 #define FLEXCAN_NR_MB_IRQS	2
 
-- 
2.43.0


