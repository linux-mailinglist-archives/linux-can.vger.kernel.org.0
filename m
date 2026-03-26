Return-Path: <linux-can+bounces-7254-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHGRK3E9xWn/8AQAu9opvQ
	(envelope-from <linux-can+bounces-7254-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:06:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217DE336823
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51F53070AEB
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2026 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE130C37C;
	Thu, 26 Mar 2026 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aSspFXR5"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D66308F38;
	Thu, 26 Mar 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533517; cv=fail; b=Wpp1Utf8MIlS1HESQmPadxYFGsIwmOm68P5jHAnwTbycd3uqlJH1ns1m+6gM+3TeA2z3mVF29bj2aTk/pxPGP2YaTpMRCMIyeqnh6Bq/HP0tlxxVWJZQO4/QDATglcVDW2GGUKVuOiUKgXVfRzBsTSUYVYD2iKdLtvVY5gPBCdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533517; c=relaxed/simple;
	bh=VlaV463z9LAC1wNALjkbRCbO3hKIHhq6Xil8Uqyaj98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr79wY4i4FsFp4nEMiGVe9mWhTapQXbD4s7PucZSmIHkTzosK955z1kegcScQtDOC1M/klcrKVD0XYICYPuLvsbgPuAW8sjWDlztfQMfYD/1BXzQbVSxrcQxH31nqQqGjsWmRPntdFc2iVdrRxTjVUvF9vhAcnlvV5GOrpYn5rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aSspFXR5; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx4gukX+a1IfEoxM7hZLQwRF1nLWlxmPovP+UGjarBSrNTlR9cvAYsJC/3TMCCrCdZERt7Sr7nFyW5yLkK+EVzZk3Jli21vlDS+W9bTIzq9oxeUYM6zuJ/ejtIhYuxkEer69aZb5epKDajoxkW4MJgzOQR/AhrKiSTmXbqMNY0MLZFJ/84AtjiJNfie05IUN0MoCtHTOLodcelhEtE3W5T5ZE6x2ye9SKkDPaZ1T8/ECCRB0ut9QYiyuFK2kWDD1T1aPDk4lzT+Yap42KGPXSJGN1KpYHl/bmUPaeeVYcB2vPwRu3QT9mzqhSIG4J8QfviEcl+VpCoFFgy2oEd479Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXj4YTgfkV97oBYFc/OQX7btN0RSqrP0NjNGEYWi1+c=;
 b=MfdKYOdgEbrBG3/RNYhcdQ5wOSYd7JQklp03gceECw0X6OUSt4igzTMSNdvCHya9ipFqNymdqb3xU2yfhj1TtBsR1ibjWGh3ODswQc1wgYovCM+09jpdte/6oNQa5BJjSSh1d4lpveXCYw6l2RTg3ZHTyKwO494xcoC8mNwt+qkOqqgM1/d1yBjqqivIKo96bAOscmBd09NLQwQ/txER+K0ll/vu+dWectCC5d96s5NnhhWE46m7OGDbgRkofus/8F4y35z4PG5KUVrOuaDMdQ0YoA04mqCLnX9RrX2w4srpHe6T2zFoX897gE9K9djqSlepibUmixREZpEQbe4U4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXj4YTgfkV97oBYFc/OQX7btN0RSqrP0NjNGEYWi1+c=;
 b=aSspFXR56eHlf0d/J23YaqZN7w1w8C/9ZsRucmU9J7xTsAhOprBNgPhHJuoIht13tRfH1vHfIJ1exr490ocXpmZZgOlr4zWS+tNZkMYJQCMHbORt21I6D7PtqTQx1sxU2mIjIzhQrCdbnf43NVvesh/xveWAWt59vjrSN7eJlPL2PBzt+La0DuE8Z8D5Max5CLN5NOxygiy9gTEgdoh8wtpmHIXaPXOBfHVFoOpVV3sjZGCMgJrgLjvNKpd5S3lCUR0bA70xhcvQYkLARvByNGUU/Cy4kiFVZbiusCrD3hQQhFdnH7AMuf3iUtPeaXfKLsm5KgBHL+ugkOWZ5WYGSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB11261.eurprd04.prod.outlook.com (2603:10a6:102:4eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:58:30 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:58:30 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 1/8] can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
Date: Thu, 26 Mar 2026 14:58:18 +0100
Message-ID: <20260326135825.3428856-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
References: <20260326135825.3428856-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::27) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB11261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc4247c-7924-4b4b-2c38-08de8b3fc2b7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oKgWTmLTGv2VF0yarSC257TJne8iH3B6uIyBBGMPRklGhVCiManUve0I85kxFwyccUQI6uG8Lk2nCqNrmW/La/m6hvrN8OJpRShCJ+BZvtHUwYc9eWh9l3TWCRfl5Fc5tzNKAuoI6uJldEYHyAZIs6nq89XLeGwJMGM+477kv5K9bBVtpEbSrj1ZwF1XcHmqoO4E2QwrPCh07LIU691tE5dn8umYfIkDQ0RMulyPMJo3vkzpcce1opgVCYgF7GPMMaQ7nGVTXawW/YTygnczx5DAnPkVYK+g6KwoMTJAII6Fx8KvBI3sDYfWcQYBnHWt7Qq2k7Cgftevi5QUK5MVMRN5QvcP4agXbQsD/bro3Weuh9yYXpSz2e4M/rEVfD2dveiF0SpEs/bvi/RchvQK0jC8h9ooHUygNLYEBhYGeIERqu9K5GbxmUqZh9cYN9CmFy/d7PRjdoQFRYLdnhdREDhH10onUbupQpJOZvA1UQkJPhVoKFouLp4rEfYLEvvnnGQ0P67TYGw6+F7JagV8ZYhS/SVLmpbS3FJndZjTqejtxtf1g89ffnNmfysGgeYIQQn1utupW/B4qHvTq/ZJW3EpZwqn0u2S9KrGbL8YRJbv6bh9YcFccQsSEBXwSfzgt8wo7SnBMC6l7LYKR5i51E6RMneyrZxcy85FvaK/3PSVqAFQhBGcG3Xp4pQDLw8reMa90LvzfxDnfllzRDz8uJvQN2/bLg4typbCo1RXnLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWRSbEtlVnhxNUNSZ01aRGdVWVNkSmRwc0hoS2NPT0kzcGl0S1hLYVpENUh3?=
 =?utf-8?B?SytCbFphUFppdWtlZnVsdVJaRkh4UHJudUZuTmV2VlZRRCtiMGlBa3RQSEt5?=
 =?utf-8?B?MnkrNWlTTVJERGhXNXVWWXQ1QnJXSDQ5NzdrYy9RYTZJSnFlRm1JMW05cU1M?=
 =?utf-8?B?elI2UDRWMlE1VXdqZmF0NHd3bGRvZzk5eWNaWWJRYVBRNnc4a2gvM3BMaVFu?=
 =?utf-8?B?eVlIRFNYQkhuYzhCWjhTYnh4M0Fxd2trVzU3S2o4TVJsNjlyMmtSMUVHcno5?=
 =?utf-8?B?aHhicTVJVlMvRzFDZVpYUEI4WVRnUVI0LzZ4Wkk4WnE2VWtROUFPZUNvMmNn?=
 =?utf-8?B?bjM4bTBQTVZIazFnMEdvVnAvZUhJYm50SFdKaUU4UU44T05Sd2hJcjl3VUdK?=
 =?utf-8?B?VHVEVTA1YmxkdmNBUTEvQTF0T2xuQm5oNG1GUXNuUVpiZ0lieTZ3ZEdWQUNF?=
 =?utf-8?B?blMzR2x6TXEwSGRuVjI4UTh5Uk44SitZUE8ybS9SOEk1azM1RXlsM2hvNms5?=
 =?utf-8?B?cGorSXBqZG5JUEc1VkVTcC8vb0RucXVTb2lWblVjRnptMk55cC9KdTRNN2I3?=
 =?utf-8?B?MlNJcFMxTlFCZHhSMnJURHFZZnRBZzJ3Q250c0U4azQ4ZURRTFBNbkdXZGE5?=
 =?utf-8?B?MEN0dkdxM2pvQTI4dE8vdVZ4SXdBTGdYd1Ezb2t6aWpWd1ZoaE80bWpsd3hj?=
 =?utf-8?B?S2Y2dU0rZm1nRC8zNXN2c25ubXM2N2ZsNFdpNUVqN3lSclhkYXRWR3ptVVNN?=
 =?utf-8?B?SEp5MFRLc0Jra2dZdFVsRndRRSsyVzJzUEdiMVJLUWErcVREa0VaeGUyTStr?=
 =?utf-8?B?cEJhT0Vzd2sxZVB2OVpJUnMxWjVGb21qbVVqNTB3MnJJRDlHSSt1Y1dsdGNE?=
 =?utf-8?B?WExQRkg1WjhDSjZQdDVjZS96MzdpZVFuTEpicWlQb0R3ZEwrNGh1aGpEd2Zq?=
 =?utf-8?B?WmYzOHZLMEZ4b2ZwUEtzZGNwREFSRDYxTW1KYTVsOFBPTjQ1YUJHT0VUNUhI?=
 =?utf-8?B?ZDdjOG5aRXVuZ0pSQ1ErYVdONngyVFVZMXRUOE1aNkVUcHRrV3dtMk5RNmQx?=
 =?utf-8?B?alZYZi9HWFZmeWhjVHovZlFSM1NVVC9DdmJ6MVAvVXpZQmxkOVhEd2hKWlE3?=
 =?utf-8?B?TFR6L0hFTDloSGpyVUlGTHQ3aUNJdGtoUUx0cU5nR1Z4ZG9pTVFxMHFod29D?=
 =?utf-8?B?akxZVnJRbXBxTTlxNXB2R0ptNi9MRWp4SUZPVEFsZUFmUGhLc0xmckRTczVa?=
 =?utf-8?B?aGp2dzRpYUZzT1U2WTRLNjdOZ2R5QmtLditzWTlSTVhFclZhSTBNYTVwM1hW?=
 =?utf-8?B?K2ZFbG9LRzI2b0pKNU5rRFdmSWtkMDdwNUg3b0h2cWhMNW8wYzNvdjRsSnpB?=
 =?utf-8?B?a21BMHdXOXlaQWp6dk1DZmxKamw3ZVJpcy9vTHJYOHNjUUhMSTljVWFNSXdK?=
 =?utf-8?B?TzVIQ2hRRUE5dTdVQzF3c1RBZG5qVFhCMkE4U1FJdEJKVFlOcEV5NVlRVHNM?=
 =?utf-8?B?K1NrbDZmblVxT3I3TGxRcTV2MWxRSGNWaE9jYktGNlphaHBUZTZSRDgwY294?=
 =?utf-8?B?UTBLa0ZkV00rSEsvMDlYa25ZclFDWEIzZ21RK3RJL0hwWEh2c0x4RVkvRUFB?=
 =?utf-8?B?R1dLckZmeGo1aitXNkdkL2d4ZlFpTGRaM1Z3OFlkS211SmRjRStCSXNkTk9K?=
 =?utf-8?B?WnVJb2dFbFdHTXFFSGxwd0syOVVIaGIzYlJPM29pUG5mK2o4R0xJcDFuRzFj?=
 =?utf-8?B?NWo0c3JXQ3o2Zkk2aXdMSzRoMUhQWmxobkJjM2ZMUUkxMkNGZk9vZ0NtZUlz?=
 =?utf-8?B?NGJ6WkNpVFM0NE1XaSs4eWl5S1kycThGQ0xRNmcycDlWRUpabzFXM2t1K3ZQ?=
 =?utf-8?B?UkpPM3dnUXBUSWE5eHJKdThpeGNUVE5yeUdjVXdzZnlJZGZveHE3TmszS3JC?=
 =?utf-8?B?MEUvVTIzVUI4UzNNTWErV0hINGcxTGR0NndjUWFRWjdZVUlZSUlWY3hPNXVx?=
 =?utf-8?B?RWEyMUhsMGtJcUVRZ0VUdDRqcUFVWm00cnNMcVBwV3lwNmE5N0pBUFhTOVla?=
 =?utf-8?B?REJUVlFWVjdCNlVGcXRGUzNhY05ZcEVpR1B6MXlmN1lhZDBad2dGVDNkbVFW?=
 =?utf-8?B?M0xKWVpyOU5RbDVmMUJOR2ZtbkRsRUx3VDdpNVZ2Tk5MalRIMmg0TFg4Zi85?=
 =?utf-8?B?cStRU2haT1E0MVJjb1V2OFZiZElObjk5ODZXVzJBL2hVZVpERGM1OGNGNFZw?=
 =?utf-8?B?VVZFa0RIVTlSME9ESXFwaWwwdm5yTGl5T3hSbDcxUEdoV3hwckg2NU05c1lB?=
 =?utf-8?B?VW02K1VSTkxaenBzdCtrN0xTanlCRnl1MkFVSW1RVDVRM2lmaXZNcjhjbUJr?=
 =?utf-8?Q?YwPij+xDvyJHuLbI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc4247c-7924-4b4b-2c38-08de8b3fc2b7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:58:30.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddvfNOYlDH899DghXAyQ2WM2qSbs9UaLaYGq3iPetSkgKeTqb5DVoo2uY1Wc1ARRxy6mRJDtdCG3qfHLJKRzGn9PviI/o6KKoiqgOyUVx7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11261
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-7254-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 217DE336823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events

Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line

The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 128 +++++++++++++++++++++----
 1 file changed, 111 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..f73ff442d530 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1070,16 +1070,14 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	return skb;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+/* Process mailbox (RX + TX) events */
+static irqreturn_t flexcan_do_mb(struct net_device *dev)
 {
-	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	irqreturn_t handled = IRQ_NONE;
 	u64 reg_iflag_tx;
-	u32 reg_esr;
-	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
@@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	return handled;
+}
+
+/* Process bus error events */
+static irqreturn_t flexcan_do_berr(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+
 	reg_esr = priv->read(&regs->esr);
 
-	/* ACK all bus error, state change and wake IRQ sources */
-	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
+	/* ACK bus error interrupt source */
+	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
 		handled = IRQ_HANDLED;
-		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs->esr);
+		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
 	}
 
-	/* state change interrupt or broken error state quirk fix is enabled */
-	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
-		flexcan_irq_state(dev, reg_esr);
-
 	/* bus error IRQ - handle if bus error reporting is activated */
 	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		flexcan_irq_bus_err(dev, reg_esr);
 
+	return handled;
+}
+
+/* Process device state change events */
+static irqreturn_t flexcan_do_state(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
+	u32 reg_esr;
+	enum can_state last_state = priv->can.state;
+
+	reg_esr = priv->read(&regs->esr);
+
+	/* ACK state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT)) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & (FLEXCAN_ESR_ERR_STATE | FLEXCAN_ESR_WAK_INT),
+				&regs->esr);
+	}
+
+	/* state change interrupt or broken error state quirk fix is enabled */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    (priv->devtype_data.quirks &
+	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
+		flexcan_irq_state(dev, reg_esr);
+
 	/* availability of error interrupt among state transitions in case
 	 * bus error reporting is de-activated and
 	 * FLEXCAN_QUIRK_BROKEN_PERR_STATE is enabled:
@@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		}
 	}
 
+	return handled;
+}
+
+/* Combined IRQ handler for single-IRQ platforms */
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+	handled |= flexcan_do_state(dev);
+	handled |= flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Mailbox IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_mb(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Bus error IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_berr(dev);
+
+	if (handled)
+		can_rx_offload_irq_finish(&priv->offload);
+
+	return handled;
+}
+
+/* Device state change IRQ handler for multi-IRQ platforms */
+static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	irqreturn_t handled;
+
+	handled = flexcan_do_state(dev);
+
 	if (handled)
 		can_rx_offload_irq_finish(&priv->offload);
 
@@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
 
 	can_rx_offload_enable(&priv->offload);
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
+		err = request_irq(dev->irq, flexcan_irq_mb,
+				  IRQF_SHARED, dev->name, dev);
+	else
+		err = request_irq(dev->irq, flexcan_irq,
+				  IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_can_rx_offload_disable;
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
 		err = request_irq(priv->irq_boff,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_boff, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq;
 
 		err = request_irq(priv->irq_err,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_berr, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_boff;
 	}
 
 	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
 		err = request_irq(priv->irq_secondary_mb,
-				  flexcan_irq, IRQF_SHARED, dev->name, dev);
+				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);
 		if (err)
 			goto out_free_irq_err;
 	}
-- 
2.43.0


