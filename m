Return-Path: <linux-can+bounces-4296-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960CCB30D53
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 06:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E493B02E3
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 04:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245392989B4;
	Fri, 22 Aug 2025 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RR+QNzar"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102FE296BC6;
	Fri, 22 Aug 2025 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835590; cv=fail; b=r+1Bq7NCePUEU3HL3FWx+a8GVioq/nB2ChrAD3FwNTWYZjum3r/UcfGw/j4AAK3jC+10E/ArN6tIYcnVYSvLItWacCumCpsStSzOmuZ5cac/igAe5mlhOQt/xpCJohGzIh2Rb92SkoDbHzMPzYws+6+xyZX1HURDypPzUkPLyFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835590; c=relaxed/simple;
	bh=gMUta7OF9+vcGkZ0qjR43jol+NUTS9NEegva8yuQRb8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NNL88qFAP3Hd0Tt/GkHFzuDi0eWZGWYr9tXZ5yPYUsS1J5pyUHgxfNey4r9jWKimHHU2mbdR25g6NMn7kmBNbmUEoypC026aVFCUNairpboXDsV7Dm2CwjSIT6WfmiTrpt0ulzgZ2QFVBIDUDSuDCJyS5S25+76aSjayEqhxDPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RR+QNzar; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbvI/iq3ltkjUX4KUNb+UhE0TCj9sNMJ+6vcS2X1Q8cii+UqdsaxwAN1WbVo/tI5znij+PScVd1U1NqGU8yIqsbJ7K3byg+EuImNdTGUNSfxWjWMf47N8ZNTtmW8ILV9x8+M6BsbXzKegidlgP4FweJTjw2FOFnShUUbsl53x+DEEm9db94RN6fluyKo7Uss43YYomCkxk7R4h6XD4t7RWQzyX5H/ILB0Ap/oq0KCx0jX2y9KXpHOAS+HZRoXnWrYdjHy9KAWhHRLVKDlZUiSDYHs9QgixrelIupJPs8cld+SdZ0xVgB3uGBBqlSkG87B8gcu58fugO0hmPUuXZigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsilJbE3npko+8A73/ssMw/LppOOKFMizWtS+zP1vVE=;
 b=oCS3Oxk9Qc+cTh2ZId0hve+ecIFgzxuugG0mj82YQ50ThbSMJEQ076Zq76NNSWypVDyOh2hwtLa8JBtBcBxJNSswr40rajOaV2HuAWey9SL7WEF7qLOkCpJJwQv3N9fwO6nn7UaywFAXi1la7Mavs224KUNrUz1/mIQ4t2hFV+N7fWhBr/F2c2+kNQb0nfEw3SPMTE+oyZxIhCZ/jSEtQ3v52RNRi1FhwcTl7MILr9tSElgw3aRO7/nFvOC9zLJCmdSL1HMuRegNM881RX7NQRpqrP8cIiXbr0+cS2rnSedDwCbKPoQJ832gZgfcDTF1wDAHjoZuhIYLOPZ17KQNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsilJbE3npko+8A73/ssMw/LppOOKFMizWtS+zP1vVE=;
 b=RR+QNzarecdgUNC9Du1NsXIbnvHZ3LBGq0qnQvrwsHq7xH7dhZTwqddJVhZN1HB7aGIK0SGRun5q+yhPbDmKpfnlcBJRpxosnuoYjRfnlwnrSyTRTVbVQabKKqDZbvYp2QHnOL/gW8cqklrnsV2B2hRBXf3Mgn6MN/dUEZ3NKlkedGdokkFqfk6Uf6G0BrLumaDDkyyl8XaVBlJexjDmZXkeD5Ej2qjHLcIQZE60/IsyPzlwryWYJoqf+J/E7VxaQq9W9yUn+9PbH18nFSVekYwUXbr5xNIedezrdX5+69y/pTqZxmYWlH4DiSj3KOcwXhEzg81ewu/8xsgaIb38og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10569.eurprd04.prod.outlook.com (2603:10a6:800:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 04:06:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 04:06:25 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 22 Aug 2025 12:05:33 +0800
Subject: [PATCH 6/6] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can-v1-6-c075f702adea@nxp.com>
References: <20250822-can-v1-0-c075f702adea@nxp.com>
In-Reply-To: <20250822-can-v1-0-c075f702adea@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755835544; l=1751;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gMUta7OF9+vcGkZ0qjR43jol+NUTS9NEegva8yuQRb8=;
 b=dMqSxRy9MKuY1eKB/OB0aX+sx/0vnWDhiKI12F2yEqncB7U8uh81INMoEDHMW+Zen/cGXP1Yp
 exqttMPxMXAB5cTU8pevHpYb4oqL5mjGqdDQt0D5gvW1aBa4BSYgc2J
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: 37703da5-04be-49ec-5b0e-08dde131431b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|19092799006|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25ZRDV1SUYxZlVjWUVBY1NHOEsvWi9rdHd1L0F5aDNnZVloMHVIY01tZ1U0?=
 =?utf-8?B?Z2Myc1FkMkxRRXNGakpGVlBySTZodkpReFJxVy93aXdpT1l4cmlSMHcvQ0Uz?=
 =?utf-8?B?QlVpTEtpRDVnbnRRdzhDZUtCbnJLNDZjZkpPN0oyR0RyR0QxK3lYWTlEUXdY?=
 =?utf-8?B?aWVuMzF2VHlnc1RSeXE2UlFQejlFK0VnVU16RnBhSVZxNDR6dkF0Y2tVVkkr?=
 =?utf-8?B?ZW1hc2FkdUJXT3B0SVB1UXRwODhFbzdjTzBVSzJlK2V1bXRqUmp1OWFZUjVM?=
 =?utf-8?B?NVN2RjUvYU1ONld0S1BzZEM3NFhqaTBjaWduUjdxM3dEcEwwbXFJSEwvMUl0?=
 =?utf-8?B?N0QrdUVielo0Q2RVVnlXT1Bnblp2d2o2V0JGWFYxaG5JdU9RdWs2RE8xMXlV?=
 =?utf-8?B?NGxGOFRqUWdOUzZ6dVdVZzloUFlZdUwveGFTS1pJaW5oMVAxMjBKYzJweDJr?=
 =?utf-8?B?Wk9zMytobjlMSjBiWGVuaVhWNW94VlUwM3d5cWhvL0dRcTZxcjRGbDZWTTBa?=
 =?utf-8?B?S0ZJbkhzZU1RVTFrRjNkSG9pWHFsUWpxYkdKc1IycUVDN2tpU1F4YUpkT2dO?=
 =?utf-8?B?aTl2Qm1WdkdzeTA4OVRvTjkxUWpCMnlqTGMzQ0FoTVEyTUMyQkoyZmxyV3FL?=
 =?utf-8?B?WjRHRFhHZkFIZDlxVVI3K0M1ZEpLWnd4b1NCNDh6eWh2ckhRb0hHWndxQ1d6?=
 =?utf-8?B?WVBRYlFuanJQY01zVXI4NnNaUHZ6bmtScDUyelJaUHZTMnMyR3BraWJVeTFH?=
 =?utf-8?B?ODhOQThCeEI3T0J5d01ISEhmZ2xRQytZRUJTcFlnZ0hqbGhLaTFvbzNUejJB?=
 =?utf-8?B?VHQ1Wi9MQ1pocmtEUlUzaDdCTjJqeWkwZFgyWURyM0twamwwQ05zNDd4Z3JM?=
 =?utf-8?B?WmpYUEdDZ3JjZ3RBc0ZGMkgvOXk5cjBKOVZiQTR0Yk9WMHBLa2pYek9nSXVj?=
 =?utf-8?B?eE1qNU1BQjdaQzFNTlJTUGVTTE91WDMrTng4QURWdXZ3NjRURHVMZmhOWUkx?=
 =?utf-8?B?cVJUaENraE95ZytnRjdSOEJRYTcwdlNiK1V2RUlqd3NXc0g0UlcrSXVuVzVn?=
 =?utf-8?B?aTNkcUpLN0NsUTVxQk1ITDFKZXhVS3JMRlBTbXFiUkVWVlRjWVFmLzV3bkp2?=
 =?utf-8?B?aW9ubnNTZzF0OW5UZUMrdGVqd2hsZHN1SzU4UVRyYnhsb2p2ZEw0Q2NqVXor?=
 =?utf-8?B?LzJjbldMUXU0NkQzdU1zcjZXbEszb29ZbFpxV2FzdVhpQXBCS1o1anI5Wmtk?=
 =?utf-8?B?TFkva3RFdVhzZUd2N2F1UDMzdXZGUy84OFBBR3ZxK3J4c3JLTGFkdEdOdk04?=
 =?utf-8?B?VmZqNjZ1Rmp1V2NwdGhnWW5sSkhibVZOREJ1aG00RXAwSHlTS1c4YVI3WTU1?=
 =?utf-8?B?WDh6VnRROUFZTDBVQUNQL1dSYlpDcWM4SkRZSkJRYldhQjEyQ1ZQMzBGdjJw?=
 =?utf-8?B?djFuR0RKM01ITzdiNEpCaERvc1dtR3gvK0xqNXg4VFFrNXpDenpFa0ViU2dD?=
 =?utf-8?B?eXlFVVpMdXFVMGw4Q0Izc3pvTmlQN001YTJQdTl6aGVUU3g3dmpmRWJSMEl2?=
 =?utf-8?B?T0xVTFdsT1crOUtIZGJacFZ5ZDh3U0ErdEplME5sMVlFQjZDT3RXV05BU1Nu?=
 =?utf-8?B?a2pEQmYyQ01Wemh4UWI4OC92YW1aeGZtVnNSWXFkZ1c0L1oxK0ErNVRTSjdr?=
 =?utf-8?B?ZGVEbWxIUUhpbDdRMkI0NnVSa0drQTl6V3NQWHpyQUJQTkVIUm45TmdsbFRU?=
 =?utf-8?B?bnFNL2J3Z2hVZVEvQmZjb3BaUHE1RE9yOXR5em9RQU12Ylpxc2t3MDVnK3A3?=
 =?utf-8?B?ZWxPZENVRGtZdExlckNFL2Y2NzNoRGZQOXNFZmxZMWZidlNTMUIvQWpEekhQ?=
 =?utf-8?B?blA0L2pjZXBFdVg3a0JQV2NFbTUxL1dqR3d6T09ac3dkR1ZBNVZPY3Z5Y0hH?=
 =?utf-8?B?SWlVSDlIcE5aa3BnRzhQcTR1cW81dWY2Y215MUU2cjZXcWxZaHdMdThHTTFZ?=
 =?utf-8?Q?rhL/QvcKI0Zi6XqHcYZngJf9mHKy7w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(19092799006)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a29maFIrclFFSlJ2anI3d2w5aDhZRDNwVVZDREVDZDZ3N1dsUDhUNzFJUzhz?=
 =?utf-8?B?Q0dqem5TVUtsQy9USjhRS0Y5bGpuU3liUmtFWEtjRzdNMGlsUmYrUnRyVThs?=
 =?utf-8?B?TUxyQUx3K282cjY3MTFLZVArNDFUSmtKOG1XWUJTN3ppb3U4a2llMmpYK0pT?=
 =?utf-8?B?Qkx5cUZycGt0Sjd6V2E4OHQ4VVlLc0lLRktzTjdMZ1pLVW1LUVhVRE1iU1pU?=
 =?utf-8?B?SFJuY3lXSkJzQXptMWpxZGFPbTFEV3VPMUNLQ3M4bEw5M2Joekp3QzIvSGxm?=
 =?utf-8?B?UHR2WUg0dkhaYzllVE13NlRubTJQNlZhbzZQbzBqQlJlK1lBOW9QZVNHamRj?=
 =?utf-8?B?MzBTb0ZxNUk4RE43MUpkR1NyaFo2S05EUnRMb2trOWllRDBjNHNSOXRvcExr?=
 =?utf-8?B?Zmt6c2VBbTlzOFFpTy9zaklLWncyclA4MHdBaTdTd0JHYlV6TVl5QjZKWDZn?=
 =?utf-8?B?blJSRVJiN3JFRWVVMjhXcjR2aVVGaWFQVUVhN0w2Rng1MGtRcUhxREd2TSs3?=
 =?utf-8?B?b2FKSXI5Q1YvT0wzNEEyNEtnNU9yZnJjU3VmUXJDZkpzU2JST1JrbGhaZExk?=
 =?utf-8?B?RzZmNzkvcGM1NzBOQnhYYlBzWWVCK3pJQ0FvWllwVFRaYzJUWG1wbEVYK3lX?=
 =?utf-8?B?dm56SlhmZzVVTTljOFd2QjZpMHhjZEdGMnpZUmRrM2hrQkVpN0J1R21pbTJ1?=
 =?utf-8?B?bzJnL0cvV2tTbXJhM0JMeXVJTUdUTDcxKzhKVGw3TkQ2WS96TTVIQ1FLRmhp?=
 =?utf-8?B?SzJ0ampYT0NZRis1T2VOelZEOW9QR3plU0owSE5kcFROYUMyYndNSk52N2tI?=
 =?utf-8?B?VkozdGpkcVF5WnpVMmZLSTEyR2crYkE1Um96UW9HUlVFRXhDVnFZeWZOcUxP?=
 =?utf-8?B?cG1xeC9HT1B2Z21SeWFlTS94dTJPaDltNjJGZW1KdFZpcjE0S2xJbWJVa1Zh?=
 =?utf-8?B?S0IwWXlXMHFqMUdDWFhUaFFTZDM5N0x2SjltWVpZSzVMdHQ0SG1OV1pVdHVO?=
 =?utf-8?B?eVlXM0cyUlhQekl6L2dqYndqRURPRjdOSGVnOWZoQmRwTWVWb24xaWp4bjZ6?=
 =?utf-8?B?VlhRa1FRcVZWOXdmOFBrMXNXVlJjK3NpaTk2M2hYcHprUVRGc0RxUkFhZDlm?=
 =?utf-8?B?MVNPZ1NyWHcyMUU0S3hjVVFQS0h6bXlTZjRFMU1tSzNBcXZYNk55OXNLcWxk?=
 =?utf-8?B?ekN2UWJjcmtDVGN4ZDBsTTJ3SGo3VysycHJTemREMnpyaWUwQkt6N3RGVEc5?=
 =?utf-8?B?UWx0V3p0ZllibGJrbzVpOVVqSHhkZ3lzazg2TVJtd05nODdRZmNibVJIZ3lF?=
 =?utf-8?B?STNVRkRoVmdqNk1IRUNWV0tDSUhrOHhnWHk5R0VlV1l5b1pKL2xXaVZuVHZ4?=
 =?utf-8?B?d0RpZ0ZqY1dMZDB6Y1NrWUdmNWE1aWo0UGdSbkNZRkIrcWlhNzBzUm8zazBs?=
 =?utf-8?B?b1FSQ0VDRVB3U2NaZ1I1YWRmTUVKZ0JUL1VRcWl3b3YzZlJvTkVSSFZMQ20x?=
 =?utf-8?B?a0c2LzZUM1N2UE1iTlAzNzBMQmNuYWk4NWc2dlM3dnNIRGErUUxteStKa2RX?=
 =?utf-8?B?M2tGaFo0WWF0STZaaTJtcmd6dzg5Z0l5MTJLdnBmTm1QMndlVzFVQUI4eGYz?=
 =?utf-8?B?NThZbmFsS1o5K1M0aHRGR2xyUVdtOUI2c0ZtaDVkRDZmNkZJN1JjcVc0T3Zi?=
 =?utf-8?B?YkgvMXlrOUZtK0RhNEdMQS95aXp1L2IwVVV4UTFudnIyNVZ2aklEY0lRL1gv?=
 =?utf-8?B?UDBxYUlCdTRmZEFtTTF2aWZrMWF0NTBZYmlxaEdaclh0M2dHWGYxQ0NtTWx2?=
 =?utf-8?B?OU8yaGdFVGdJMVkwc3gvcklwNjdmYUt6dUVlcjNrV1RidkN0YmFMU3VXRzBB?=
 =?utf-8?B?cG5wN3daeWU3SXgzc0ZPUnkyZ0NlS2N1WjRsT2VtY29saE1ES1dqMHBzMEtT?=
 =?utf-8?B?aXcySkpJNXJOSVcvVGprdmRkYkJYNVoydE1FaVgzMjc5Snp2ZXdIdGx1RXVJ?=
 =?utf-8?B?bmh3Sjd4cHVYLzExMWRLT0VRQkd3TFA2eFh5V3o0V255WGZ3R1NVYnVBZS9w?=
 =?utf-8?B?Q0dxT2hJYVE0OTNJMHFOYkxsY1J5ZTU2WllBRzkzclJUZ1cwcDhTZVNOdHpa?=
 =?utf-8?Q?ypnSikbUxijI8hfGv5ecx/5SH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37703da5-04be-49ec-5b0e-08dde131431b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:06:25.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1k2BDTq7s+HIDgqfXDjFQYk4n9pNOf3b8i58IRY/lZ2u6W2k/o+EvVcGxgWt5an8g6DmfvHnY4IbzSuGc82dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10569

The TJA1057 used on i.MX93 EVK is actually high-speed CAN
transceiver, not a regulator supply. So use phys to reflect the truth.

And TJA1057 is compatible with TJA1051, so use nxp,tja1051 compatible
string.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index e24e12f04526c3a08c0bdc6134297fb010e6e926..94be59771cd05c93a6569ee08fff71bc11da21c1 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	flexcan_phy: can-phy {
+		compatible = "nxp,tja1051", "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
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


