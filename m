Return-Path: <linux-can+bounces-964-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82D92EEBC
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCD528946F
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225016E895;
	Thu, 11 Jul 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hOsdqt9e"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013064.outbound.protection.outlook.com [52.101.67.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F716E860;
	Thu, 11 Jul 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722025; cv=fail; b=K+MNGTVrVBCueTa3aj56qZqwHdCqzB5e/NKRqZB/Arz6QAtDoDGsYMMwKFNnGC6LUG5YEeuuYDz6illZ3jiaOQzbGBgK/qJRuAQw6a9rgMbK8/aLpxoe/z1zgW48FTG2/JwpuEc6s/U6BY4mE+jzBesmFvsHFI41gCgTdi1Y6EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722025; c=relaxed/simple;
	bh=4rNUMSwGXrDCiKs1Q8iacBJbJRObprUdl9Ahwx7xZYY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TaYA0GpQJVm8T9XvExCtblS0rha28XQ1Z38boarGGgs1U7bKfS8/fFubPYGzFrAh1684+yofwzI9/4dp9CCv/mP1Nr2xnQnNLpLO8DQwXseS2cJTlagK8J1p1fe0/sbx9XvfVNQcCIPBzQWFLQWuXMB4jFD5i/SgjziuGg1AdaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hOsdqt9e; arc=fail smtp.client-ip=52.101.67.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2amJOF65gBniG6uU4wuN9h/0fPbmDUMLch3KDZKr5fn4nVjOptq+Gl53lIoDAlLGkQJWf7sKX3mMbGyw5IIpo5aoRYYM9sRMmIQtQjNl5Gr2f8cdTw3gZwRkxIPIc4qr0PW1apr8g/VvfAQkmh1511qEROdPB1zjh0tMaX0dfHhcg2BRniu47cMsepTCyyxWACP+CwczVVMuIPHYsVWE1Z/wnQSYZCv5iAy3cl6pPzt7fwSKQ10Pd4KNq2YaKcxT7NjM2oqiYBYGFV1nEYRs0IqF0IIOxotDhJjuz/WWncnBdMdFMVzKqNCsLWJqHAhRwPqasr9TXNhXcHutLpD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV7eQR6jDZU7rASAOAvnO+8mczfS8U2uWUsaRyUaJVA=;
 b=F+AELOYMO/rLk+QFgv9sfVKIds2wsrPlKwQgHK8UmXMlPZYNr+CNZirSWReYxRPm/B/PW+bIgQxBEX0363AD3RvJgWZBTq/hpNoczYnjY99e/WC+0+rxEOjzoD1Eu7XhjLo94Ize+I8iKNtX+RAwcb4ZM7QHkdQHgYh7tgXKlOiCW50qpQ7/3JZbCPbxlBljlLP8Vs750x6aAwR24MXrx2XyjLf7xV/CnCfLyrBahoy76b0hzsb7feADD9RmAqVrVwS1IAC6TjYk9Z+GUh93s9K7RlJ+hoYPVY6xWGRkiHOvzWkhpDxt09KaEa42eIVNlnztkVTe3wLS+Me/kSbMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV7eQR6jDZU7rASAOAvnO+8mczfS8U2uWUsaRyUaJVA=;
 b=hOsdqt9ej2VkN8e8siP0SyTg883L4F3k3sbJbp7ZBvC2lWXjQ78wCa6gnroBlrG8citV27iZldz8QVrWkXvZmwZBPTP4fbgOOpojpSPLc8mto3rsOrX+ZkeQK5sdXf0X0O/4ge16RpssWQGsxgjmQwOu8AyEqt+Meb7+i6p/ncQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:20:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:20:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 14:20:00 -0400
Subject: [PATCH 1/4] dt-bindings: can: fsl,flexcan: add compatible string
 fsl,s32v234-flexcan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-flexcan-v1-1-d5210ec0a34b@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720722012; l=777;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4rNUMSwGXrDCiKs1Q8iacBJbJRObprUdl9Ahwx7xZYY=;
 b=yMxQVbFOeJJDFtMbqpWQF8kKUhtIscn/MwwVTYnZFAjLiWAmeYw6sgqP/KatmQoAtfZquyWE5
 JLJEdx23YSCA01rW6BnBr1TtSqzvjL7aFGEUcQaz2ztrru1YJKuPv4R
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
X-MS-Office365-Filtering-Correlation-Id: 65c75bd6-e50b-40b9-af64-08dca1d62049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zlcvd2hiejhJdkN3N3ZJOWNMQmE5QldnOUlqZURHNnZrQ3I3U0V4d0xJRFow?=
 =?utf-8?B?YTU0Q1JlRi8vUjQvMHBweC8vU3lsOUw3SXpSZzBNUnlWUklaT0ZTdHN5cGtk?=
 =?utf-8?B?MzIwbCtJVGY1eWRpU1g0bG83ekMyRDhrUTA2cnZzQ1VlZHlYdk83bUdzNGtn?=
 =?utf-8?B?OG9PNlNpS1prWUlwd2g1UFlVOWtmdzkvcWNSbXh2bU4xbzAyUUpkRUR3VWFs?=
 =?utf-8?B?SmxMTk05djJLTUxUeHhWNEhnYTZTQk14QVp5U1UrdU5aQ1lYWko5WXJOeEI1?=
 =?utf-8?B?WEdISkhYd3lHeDJaMkpiUnVsQk40Y3ZzdW9uQ05ZMWMxL3FsQlhac3NsOVV0?=
 =?utf-8?B?VDZBZ0UyYU5vZ1MrRnU2WVlCUlB2VUJsNkdkOXN6Mm54ajBycjNCV3JKdk1C?=
 =?utf-8?B?NXE0c0gzZjZqalZpV0xZUkMwcWhXOFNnUlloZHA5UUFyWjhodnI1aWlWdEdq?=
 =?utf-8?B?T3NxT1J0MzllKzVjbHV3U2ZCVjllNjFzUnFJOStSb2huOUhQREdJVFhPcHFa?=
 =?utf-8?B?NXdXbStvMktkTlhHUGljbkpUbHRsSk9TTVNCdENMMUEzZDNFVkJtdTZVWS9x?=
 =?utf-8?B?VDFZMXNPQWpnY25WWVpsYWhxUmkxUDloV0FWK2tUYkg5b3NPdEFrSDkzYVY2?=
 =?utf-8?B?djI2TDBudzdvRkYxQWFMYVEyM3ZoMWdQM3RTbXhzektTeVJVb0dvQlpieVBM?=
 =?utf-8?B?UHgrRnIvcnZtVHAra3NyWE9ueFdFWXRESEZtcnRwYzFJK0FwMjNVMGw0Wlc2?=
 =?utf-8?B?VkQ5NFRhcFpSdFpaMzNkdVJQaVNqMVpEZitNa0ozSEc2Yy9ZcjlzNmo3d1Rm?=
 =?utf-8?B?SUdqYktISVdCVlVXdFhpUFRiWSt2c1ZibldlOXh4c1c4dkVyV1NoemVvWU1E?=
 =?utf-8?B?Nlp6anM4aFlsVFloVzJ2MlhETWNveElZSW5JcnphZDJNcHRONWdpakl4anFx?=
 =?utf-8?B?TVFNUXg2SHlSZG5ubWhMYjA1d2ExV28yazMvd1ZkT3ZCQm5HeFp6UVRrYS9F?=
 =?utf-8?B?TkgzaWkwSVcrVHRZYVdkZUlTZDdzN1RMcGlXQUtTekphdmNhcm9tRkE4czl4?=
 =?utf-8?B?dE5DQVZFRTl5LzJLRlA0WnRXcUZTQTE2OEpvbXdoRVdubnIvbHhjdDVzazJD?=
 =?utf-8?B?NGRJRVV3a3RtQ2Y0czZZQVZ1OEpEU1FTZm9jNmEyQnFWOWJvRzMyNyt2cmJ2?=
 =?utf-8?B?UENkUzVFelEzR0RMRk1JUCtwZCsySW5TZjVFQkpRQ3Y0NXUwWTA1d2o5dFp6?=
 =?utf-8?B?QjAxZWhSeVR1YzNQdjZXWTh0eVQ0cmJDSWRVTHc3VHVoNFdBUWdOMmxZUTZR?=
 =?utf-8?B?VkdSK1kzcmhVTi8yWWZmVkpoanpkVjV5RlhleklrQmxPZ0RQV21UbDNma2tU?=
 =?utf-8?B?SytzanB1ZWpPeVlXOEV4RGxiK0tGQW92dUcwR3RxYnlPS2t3THEvTG5Xa09R?=
 =?utf-8?B?U1lOZU92WHNtVXN0cW96bHI2NTRPRXowVUYyL1lkTVpiRjNGUDFSdjZBQ0lp?=
 =?utf-8?B?NC9JOUNYci9FVXE5WTFQZHI2Q2dONG9EZ3RXdVNLRHZLQXJPZENwcGl4RFpy?=
 =?utf-8?B?NHhxVmRmSEttcVlYV0Zxem55b3oxNzBtTEJIamEwd0Z2Q2l2bXg4d2J5T29u?=
 =?utf-8?B?dW1rVEF6R20rbGU0Z3Y2eit2QzZ6cWlDMUxWSFRDRFRuSm5SeTg2OWZoeW1a?=
 =?utf-8?B?TlBxd3VlT1JqMkhCUndsWFNDb3Bia3QwN1h2K3h1K3psYTdHNnUveld4N0Fk?=
 =?utf-8?B?ckRobjRCZUU3T2dZbU04K2pON3Jtd3VOdGE2Z25PSjRqNHVzVWxKaG5GTHJl?=
 =?utf-8?B?RkQyNk1KUFJUOEptQ3VHbUd4MFNjbGpkRzN0VFJGVnhVb1EyRTNvQ3lyK0gy?=
 =?utf-8?B?UHArVUlQN1Z3a1o4NEpBYzc4NUNJSjcreVV0KzcyOXdNZlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXhqS2lFbXBIODV2b3VFR2piOU9ncHVQUHFiNlM1d3JmRzAzMGNyQ1pXNFZy?=
 =?utf-8?B?UkJWcXliNjJuVXRvNHk1aWpEdHp6OGVkb1NhdlhmNVpTbUpNa3lEdTB3dlF5?=
 =?utf-8?B?NzAzWDJBeTJYQ0xaNm9xYklwcGRjUXdwZVg3WmpCWFIvL1FhYVIzQ25BazBV?=
 =?utf-8?B?T0wzOUZ1OFdGa0tId3dNczE2alptSUJmT3ZIL2xGU2JrdnQ2Tk5JaWNQcUlp?=
 =?utf-8?B?VmpCVUtSNjFMKzRSOHFEb24zb29mcWVycjJpK2hSdHdCVGFGOElhZVpsOUpX?=
 =?utf-8?B?ZzlOZmVqSE12ZXBobkhOQjd4dUJUVGVRclhkbE5lT1djNWN2eWJTdjVYbkFL?=
 =?utf-8?B?dy9XS2FBRVJXTmt3VXVmb3ZIbnVtV1JVVVp6RE9BYUZBWU9MWTNsS3hOVk1q?=
 =?utf-8?B?SzBqZjArRkR6NmRDQzVoUWpJYk45dlAyZ2dwOXdJbmdHZFhTRG9ma2QwRzZn?=
 =?utf-8?B?WWwwU1NlWnB0TWoyenNVQ0JYY043UXgybHNkbEFJMjZTR0NwSUM1anJZaFhI?=
 =?utf-8?B?emtqTVRjMjNBb2JMcUJkWHIvd2VTRXVJbnF4WDEzQU82TVRJamJSVUwzRlVz?=
 =?utf-8?B?TzFSKzIyVVNoRUhCZGNhYVVvK0xSQzJjbEhJSzluS2l6cW1YQTV0K2diQkxq?=
 =?utf-8?B?cGhXSHY2eFlPM3AyYjEzR0RDaWovQmc2MEtQeEJTMVVwM2gyeXY2czlOV1dm?=
 =?utf-8?B?S3ZLMUEvUmxiQTczTm5IL0luYVRQRDltNEpRT1FhdGdpTXVONktkNUN4YVN5?=
 =?utf-8?B?amdNZTE5OWprQk52VDlTRmc1YXhQdG5rbTRvenFyUHNSOExyNDdHMi9hUnVR?=
 =?utf-8?B?V1NSMnpQM1hyNmRxVnFRczR2M3FCUTZESEE1ejhhUE9zZlNxQ3Q1TlpONlo5?=
 =?utf-8?B?NGUwUWlza0JWZXRaVE94cmJBZ0ZLaEFSdmxTTFdKUnoyTUs2YTViTGZWNW1B?=
 =?utf-8?B?TWZFcWVzeGZOTXQrN1VzdkYxV0NZTUl3bFhTbFl4a000bjhOSXpBeXhiZEp3?=
 =?utf-8?B?Q2FWQ09KVjcrb0M2bGYzUzYvRE5kckFOdHhPak9Tdklsc0xyUVp5NkJaSTIx?=
 =?utf-8?B?L1l3TGF2d09VbjhJNmFLeEtGdzhLaVJtUkhPa3dkZ2dKRTFQVFJnN0NXYnlt?=
 =?utf-8?B?NzlOcS9ybG1LMnppSjlsQ1ZZYlN4SVVJYkRPZVRPQThuV3Bja2g1Nlhod1dk?=
 =?utf-8?B?N1Q1K3hBQmMyWWZvTU5yNDhEK3grMWJwblBITFlJUkJtbXZkanVXV3B2d1ND?=
 =?utf-8?B?NkhibjlUSHkySGhrY2tJS0NBNUlWMnRpMkFRTFN2RnI2R0drQUswZ3ZORlhH?=
 =?utf-8?B?OE9YcEc4dURqRFZMd2JOSE05eERKaGpXSVVnVTVscEp4T2RndUR6WHNVRUx4?=
 =?utf-8?B?TlNkdUN6VnpMR2RpYWMzaDQrMjZJSmxxcDl3MFBPTlh1MVVXL3hJZW5aRmRo?=
 =?utf-8?B?MW56YlltdzN3M1ZwZjZHWWQ0dWxsV0M1bkRWSlBuR2xwQzFLMnF2ekxWRXd4?=
 =?utf-8?B?amlYWnFMUEVCMlgxdm5IOURSSVovTGlHKzltek5rSGRPUWFZOEpjSlF5NDJ3?=
 =?utf-8?B?aUxmeWp4ck1JbGRheWJRbDN6WTlIdHJtZ0UyeVdSWU10eER0ZFd4YkpvNVVF?=
 =?utf-8?B?UDVteE8xYzRQaEFhRUJNTGl0NW1mUmYyZVBDamhnVWtUYzVxeGMxbnlpclhE?=
 =?utf-8?B?Vjdsbmh3SWw3bkZaOVNFeWs2QmFnVUxVZ3JYR0NBdzBScG1Qang1d2pqdzFT?=
 =?utf-8?B?OTZqV2dpMEJzaCtHRlRFZHl4dmlBZFJ1UVRVVWFOMDNEK0ZQcmpwSjNmbC9M?=
 =?utf-8?B?M0w3Vi94ZUNzWDNBRGlqbmhTd05CY1JnTHlBclBsQU9zK2tTS3luSzlCdnE3?=
 =?utf-8?B?Yms2U3VyTkFyRGpsUFpNeENSSkd1dkVOWllSMkl5dWhzajZHK1pIdnNMZHMy?=
 =?utf-8?B?RzNXZ1hINm4vV3A2UDNKNzloVEYzcGNhK0NCdktxaXhERkpSRVRCS2s3aDd1?=
 =?utf-8?B?Qk41N1E1NXJ4bmhuN1RaVHNDaDlkN016ekdGYThIOHorRElYR0UwYUF3MEdu?=
 =?utf-8?B?ZnhTNG4xYmxZeW5UQWYybjNVcXgzWGNsQzFVeUlIMXdQM0d6TnF6VWtpR3ZB?=
 =?utf-8?Q?nfUV1w769v0hkXg5FDulXBFFc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c75bd6-e50b-40b9-af64-08dca1d62049
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:20:21.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TN0V8wRD7ZtMkG4TZWI5eMKIdcSyfihaiVOTi4sRRWa2mE2RCaYfit3u2ULgG8Kf6ff8r/jTfqQe/WhEbxRhMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

Add compatible string fsl,s32v234-flexcan for s32 chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f197d9b516bb2..b6c92684c5e29 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -27,6 +27,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - fsl,s32v234-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan

-- 
2.34.1


