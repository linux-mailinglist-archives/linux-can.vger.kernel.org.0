Return-Path: <linux-can+bounces-2102-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A979D2128
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ADDB21C3B
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E618199E84;
	Tue, 19 Nov 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gEnkY6es"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581E157E82;
	Tue, 19 Nov 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003318; cv=fail; b=tbTGknpuTl7D9wg3WJUEWhMFYUbiQQ7RVggGQQrkjhBnVn+4Yk+4cwIYX2qvmjblngkK1WFyYRSShlHNWhwmpPknFRztrby4pMbHT3PNvwTknBXsQE0TEZWkuDmP8F/QfXVjasN24eJFrFiA1ycJzpF62aWs2i0QnxhzLRP/VBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003318; c=relaxed/simple;
	bh=2lC5tG3oSaMMhEya7MsoBHOSGN2fF94UtT4f2Wd32sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nePwCR9l6QaApNgtfS/ruBN/TpEsVDm8caYZPNnzT41yqAydXNBpeR9gGVK6SWKu6ymFYcwI0Dg2z7q7ZniXVp4IMDVdAAVqCDKeqsJMfUTO23Sr4J3rWJAbdKIicEZotAb5/yOJeMe8dr9mkmEWZ87QbBoOPphobmXAZksVg7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gEnkY6es; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHHXYdZlbhuBm9XjTH91IRB2yx1Oe3jv+RBekL8dDftaTvCTYEoeQa60WYlDCIBvqTeh7nWWRH6Fdqtr2J0QOZbcaND6MbjyHuSU7JaWgSMAECAaSEVGEmLkzE/z/FftX+ikfAUBVTPOEC6+aytCQU5PX3fZGKAiGgqCP/KyTyA5sHXd13DdQ8dS4MCzqD3lROUevHj8Ik4bSFdhbtg3H91pd+cCc5/6BpcZ/8EDK41xykUfSwL8SgxwW+YH52IGrti5JXPhhTRAN7ex11s+9ZFb8yroReYl2++sM7y0OJuNZ6D2r0T9c5FNvxvjOJ/EOSRkz5hyc9s6NlLaZNnZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm+Ou+Qc6KomIYnh+sPgqRr7u/wWjPGAlWW15rwFxcE=;
 b=jlggL2xucX6lIUBHSDbMQAjn2SoLmS0MbwWyQxYWGYdJbYhx04YVXnuCmJxr8aOR7n/ZiXdjslY8VC6tm90LKeKlxivZcuiriShzpCoT89dtEbZnxIStAESFf/gCaErIKRoV7th68vDuPDrg7bVZ+QfEAUkKV1pj/3S50sz49cDzr0R2EeFhUgsXd9V3+TNTjBv79GGewbEH2DTpRVXT+a453rbCkfXm6j8op4g8JfxMtNtMsjLAXcGQDpJmx7PNljL5l9eQycB9CdGrMwSfyKJj2nxBqRUEMHYjqzRl/tJOhSCMUtLgmVj02nDdYsO0fCUKRvHabzBbhHI3Pip6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm+Ou+Qc6KomIYnh+sPgqRr7u/wWjPGAlWW15rwFxcE=;
 b=gEnkY6es6UvHYRwC/GpVEQTR8GZDNj2c+RCVnXs7gjzKVUYUdDEZqZQtLETRxQamY23wrL2W/DiscaZulNfMZ1/bz6vs+ixxrlObSwm9tVaHKlKxpDXD98rv7ZoOLJAUU5m1Pg3oRtVrZvRcMItcYmpIUgCqT0ANRb+uEf05kllelIFn0RK1pW3F/n6NyjV2ABwFi7B8x8BMspgRdwv/m9KWNJdOwnvJ6hqv7zJvqgGbrJR+hUA7FZiP9Y62QdCqNLybW4wIzNbDcgss7zVqJxm7IbPuA1nZ1QLycygwE6yApWB7HkKe7zZQQqJT01VCNDPYHqHWx2amU9HavMAoeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:01:50 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 08:01:50 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
Date: Tue, 19 Nov 2024 10:01:42 +0200
Message-ID: <20241119080144.4173712-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
References: <20241119080144.4173712-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0054.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::14) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f0b32c-78e5-42dc-450b-08dd08706c37
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGIwSTFpQSt3MHF6Q3ZmWFFrbExjY29FQ1JldzFrL0tqSFZ1UFphWWJPR3Ew?=
 =?utf-8?B?bkcrTVVFZUlnbFVsSkJoK3dFQXNoc2xybjgvbDFwVFAxdmwwdE1zUm1UaklZ?=
 =?utf-8?B?UGZmVzNEazRNQ0FUTXpaYUMzVFJ5Nm1LalFBT0pHbnFpbHZyTmdZY1VCeXFx?=
 =?utf-8?B?bGxMOGRSYmtBTndSME92NnE2Nkc4NXB2TmdLR1dvaXZYdkYxNUZYV2QvZlJk?=
 =?utf-8?B?NnlEQkVuTzFuVXVBSHhWMGpEczFSWXp1cFFPUHZlajA5Zm9tWnZjbU1iUnhK?=
 =?utf-8?B?NlRtd2p6clVRTGFSZkNzWXNhTTJKd0hNalpUK2x6c2JjWXd0VjR4OGp1ZHJ5?=
 =?utf-8?B?dHpBYXFNMGZ2VHNUVHBwZkxDdGk0cmMrRVhnZzN2YlZVWElKdC9YTmlVNmwz?=
 =?utf-8?B?RzNjNDhtdWdYektYSU04ZEFqV253T2svL1F2c250L2djUE8vejIzWXhYeWRJ?=
 =?utf-8?B?bWN6SUFyemR3UnZMQ0lFUkZYendTMUlBZmxHaExNK3Jkc0ZxNTZGOXNjU1pv?=
 =?utf-8?B?MDlRMmVqTmoyOG5TV2hjODJVTUN2ZEgvYVZ5Y00yaDZiaktBcWpCSEUxd2p6?=
 =?utf-8?B?SzBTd2pZSEZWb1ptWTUrZndLbEhlVnJtSEo4bjVoekpYakhOTnQ5aWEyenE2?=
 =?utf-8?B?dC90bVQ4T2VPNENSaGJZaHZ5bFFPZ0JJbnlHUlUxcGtxUTdlTDh5ZTBVeWxP?=
 =?utf-8?B?OWgyNUdyaFVwYXJKY1M2TnBXanRQK3dNb1JKeGVXSWh4N3hkNytzSzdMZ3Zw?=
 =?utf-8?B?TjlJZkVqSzB2YjI3RDE2RVpoTHBBVVdPZTl1SEpQMnZzc29mL3pLaHJCOEpT?=
 =?utf-8?B?dndtOHFxcThva09CMXRlY0c1TUYwS2xyV3RMYTdzOVJRUVdydXVSdmx1OWk3?=
 =?utf-8?B?aFBqbWJybnRycVgzVzBlVjlBTCtQV2FEczNJeHdhdmRKODhlVU8xSDJMRFg3?=
 =?utf-8?B?ajZ6TURxaXpvZTFpUW5ZeDM3WE1QUENCc2hndkpjKzNnbkdhUWxSeVFCUEEr?=
 =?utf-8?B?Uk1JTmNWYUN1RHlwWjhBTm4rV2syRzdTdm9PL005QVhDTjBRamFLOUhLQWFm?=
 =?utf-8?B?MXNPQ09GeTI3bkxVWHB2R1RjOFo3S0pIUTlKamNsbDFJMmNIeXFYbXdPeFB0?=
 =?utf-8?B?bmV0cjM0MjZ2UGZVLzB5UHdEMEtobE45UGJDVGMySTltZmVCZGE2T24rSUFZ?=
 =?utf-8?B?UTV0bEpBUEUvSDhHSHpxcmg1V2ZZVERzbEdjOVQzbTBpcG5KRjNSTkhoOHRC?=
 =?utf-8?B?cEhRZXhYR0x1eGJ6WVBsamxIVFM3blhzaXNrS1k2NFF3VnpVNEE3YUlLOVlM?=
 =?utf-8?B?eHNFK09jbWRBd0hWTHh5RWpMTU9ka0VPU3lEeTk3MmZ1S2Q4MUpNMklBeDh0?=
 =?utf-8?B?QlN0R1FoRS95UDBmWnVGakllQkozUURER0RQT1pwY3Rkc09KQm9sd25XdTNy?=
 =?utf-8?B?a0tBaWpSVEJHRm5tWkNkSjEvYk9nK1JSZ2NDNTNZQVNxOU9neXRORElNbjFV?=
 =?utf-8?B?SHAzNSszRW5tQUI4OGRMN241ZGtwYWZNdmc0dEIrZGQxOXR2YXhBN3V3Q2tQ?=
 =?utf-8?B?dkJaa1d4eHlhYnhoa2E4d0RPWEE3MnJvNUNTK0JTTGw1OWJobGhCMks2alZl?=
 =?utf-8?B?NDVFZ2pObWF0ZEhzay9nZzNqU29PMTBJMkczM1lLMGZaalpNeUlDaGFDd0Jm?=
 =?utf-8?B?QnFCTXp3VTF0TTNNTUNxNHQ2b3ZmZEl2dmxnMXJGNnlxK0lOWlNoUTNZYXFE?=
 =?utf-8?B?b2xubVdUNnAydk1LZncvcDVjcTN3QjFqdDFHSE9xL0Q4SFh4bVhvTTA3c1Zj?=
 =?utf-8?Q?k9I9MdIw9+rxJKUzx2418Xr9KPAe71UOW3huA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpOWklNS0pxeURFN045YnQ3dm8zVy80S3hoeENZODZBSVM3WVVZdDZ0OGdp?=
 =?utf-8?B?alc5RGdQQ1JKbnpucDk0NEdlVU1RMFBtL0JQWlUrSVF6QzZXK3BDbFZYZDdi?=
 =?utf-8?B?em9KaEtZUVRmaWc5TlRMNVE0TE5ZTkxkTmxhMVowU0c4R2xLcTRXT05rcVlQ?=
 =?utf-8?B?cGgxMU9lWGxzdmxZMXExWEU3bUMxVmJsR1Jtb1diQXpOQUxjcEMvWGh6YUR1?=
 =?utf-8?B?UjJxTjdiNHdOMGMrRjlqbzJ1VStLZ2lSbjU1RjBVcHJJUjVCY3RJNExtdmR2?=
 =?utf-8?B?MWFFeUpRTTRkUm4zeXo1Q0ltRFo5TVlPUzU4TnVvUmtiMFRjZTRxejh2STNk?=
 =?utf-8?B?M3dSZnhCVkhRWklzeitud2JoRVJTRDlJTlB1M2pCSitWZmduQnV0QVVSbHQx?=
 =?utf-8?B?ejBvVGo3eXdTTWVjMkJTcU5ETEVoL0c5TVhqVDVMcHZnbDhmSlN1VVdnUmdi?=
 =?utf-8?B?RTB2YjJjd2lYN2MyaXBRRVZFK1BVTGNWZjNpWlFSS3pYc3BNOTlKeWpIYjFs?=
 =?utf-8?B?djhReUh6QU1xV0tBSUlyR01URXdnVTR1dXd0eHozN2FTL3VrSjNuYTlKWWZD?=
 =?utf-8?B?VlU4TDA5TCt0Vkp0TDdiVk0wQ3pUaWNpSDdObDdtZ2VSUDVQRDJjQkdkWEgv?=
 =?utf-8?B?TE1qWmcwczhDb3AwS3JiSXFuQm92ZVRSTkt4QnRNc1lKdEd1QXFzbm5SVWVn?=
 =?utf-8?B?a1hobEJmc3dJcXZzM0FZMGFuY0xaK0VzK0Z1cjkxQXFDQkNyb2J5Yk1TbGl0?=
 =?utf-8?B?UFh0UUZRUW9wbTFkaWJSL3RTNWZmR25sOU1vOWdvc2o1Sk1nYmExcVBuVFZW?=
 =?utf-8?B?Zk16YjBmaU9sZ0VOcGZ1eW91enlmWG9BOGhsM0ZWMk9zU1dKbDJodjZJdjN1?=
 =?utf-8?B?WUpRblJNUU4yRHczU3NyRUpPUEpEMk5FbTFCRG1Ea0RxVHpyOXl2UzJITVRu?=
 =?utf-8?B?QVBnNnM0K0dJcUJUd1BJWko5N1BiMGxudkZnWHM0eDNSMndVbW5hNUJta1Nq?=
 =?utf-8?B?RCtLUlhwcDYvaXBNamc0QzV1SXFibUh1VGpCNTY2c254TG9vSGlORXFLVU5v?=
 =?utf-8?B?ektHM3JGTnVvaWN4VXY1bVo0NUhFUGdlY1Z0TjlmeUxjM1ZQTEp5dGd4U2RS?=
 =?utf-8?B?Wk9NUUdUSUFYSzhPRWlwYjV4eEdpaFR5cTRvWUN5dUxsajE4eXRvMkgwWUp4?=
 =?utf-8?B?SHJuVVNReEQyREN4aStxd0ZhZnVmRTlVdW5jNDYwdTRvcHFRaXNUU21JM0ph?=
 =?utf-8?B?ajQ3N0FvcGtWV2IvZE1HS094MXNjdktweWZCNzNZcHhOUXNSZ3Uxa1lWclRx?=
 =?utf-8?B?bEt1dllRRUVOWE1HQWM5UDByVWd5dk9VVm4zQXUyaWs5QytuZG5pOGovWFND?=
 =?utf-8?B?U2swT3VaQXJndzk4UVNZTlhTZWlTR0lSajltemdzMXY3TVV2a0h2UVhKRlll?=
 =?utf-8?B?Q29xUFhoNURDU29hcFNKUmM5Z0g1dzMzMDNpOGZhUjJ0ZWJDblpOS3k5ZHRI?=
 =?utf-8?B?TUlXcXkvYnJpWk0vQVNjVGxpWFB3b25maGNVMXhJZUI2SG54TmYySTAxNitr?=
 =?utf-8?B?NC9pRmpmUGFCMkxjdXBSODE1VGNVaTRTU25ZakpJMzljUDl0dU9XWDVPTG0x?=
 =?utf-8?B?TjZ0UjRaR2FyVHNIcUdWakovL0NGc1VyWll6OU1jTjJ4akxDWFpSek5tVCts?=
 =?utf-8?B?cGJERDloMWM1MEV5a2lzeUtQcWg3aVRyRHZUOXc5SHlMdklISmVJZUt1NGZq?=
 =?utf-8?B?UGxDMzhJTnc2UWFSYjdnYTZKT3FIZjF6blFFSzVGdnFadzFPQVEzVmwrempD?=
 =?utf-8?B?SnlBN2FkdWtydzBBamo5Vm9oNDRDUElKay9hY0dPMURqQWtnM3FPVS8xT0Yy?=
 =?utf-8?B?SG51UVl2VEpyUTA0WU5OL0NMK1BuTEo3Rlp6TFUvZjBpeFVFc1d1dUhlYVhS?=
 =?utf-8?B?VmRqY0FIWGExamV3dU1BVEYyOXFxNHJnYmdRTHhPczBwcTFDRFAzcFE0Nmhq?=
 =?utf-8?B?R2FJdDdXL3Bzc3NWUFoxdlFxQ0N5N0Uvd09rdVZEWU9UdjVneWJHOGlrdGNa?=
 =?utf-8?B?Rm83QW9mSmVTbUFpWTYzTThyRXFFYjFldzN0TmFQTmo0Y0VoUjJWcWMwOXZP?=
 =?utf-8?B?VlB2bEpYR0dSOEg5NHptY2pINHF2UThpSjBPcmErZjE5dGNHUHBoVVJlNWU3?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f0b32c-78e5-42dc-450b-08dd08706c37
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:01:50.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8n6j3Gm3XuNbIlp6ZVlN8v/n628XKnjReplLJieixROkrI7+MnxDnvhUJwacl9jwwULzDgyfybjQAH86xfRPOLDXmT6IrsrDRWoNHUyNXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add S32G2/S32G3 SoCs compatible strings.

A particularity for these SoCs is the presence of separate interrupts for
state change, bus errors, MBs 0-7 and MBs 8-127 respectively.

Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
same restriction for other SoCs.

Also, as part of this commit, move the 'allOf' after the required
properties to make the documentation easier to read.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/net/can/fsl,flexcan.yaml         | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed2..cb7204c06acf 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -10,9 +10,6 @@ title:
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
 
-allOf:
-  - $ref: can-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -28,6 +25,7 @@ properties:
           - fsl,vf610-flexcan
           - fsl,ls1021ar2-flexcan
           - fsl,lx2160ar1-flexcan
+          - nxp,s32g2-flexcan
       - items:
           - enum:
               - fsl,imx53-flexcan
@@ -43,6 +41,10 @@ properties:
           - enum:
               - fsl,ls1028ar1-flexcan
           - const: fsl,lx2160ar1-flexcan
+      - items:
+          - enum:
+              - nxp,s32g3-flexcan
+          - const: nxp,s32g2-flexcan
 
   reg:
     maxItems: 1
@@ -136,6 +138,23 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-flexcan
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.45.2


