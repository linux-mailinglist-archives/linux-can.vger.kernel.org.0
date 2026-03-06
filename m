Return-Path: <linux-can+bounces-6964-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIruKqGYqmkxUQEAu9opvQ
	(envelope-from <linux-can+bounces-6964-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 10:04:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D221D967
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85B1302BE37
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926C33A6F8;
	Fri,  6 Mar 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FHKDN+i8"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75363264E1;
	Fri,  6 Mar 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787792; cv=fail; b=gtINPDkD/yt2/iX/HosnoSwcjm+GWV62YGqob4+1O7QnqAwGwIU7e59KFtI82fChXfZf+uYuwueTWIXSVaQzd3VTxoiPF4h6I0CEuDZXxOOCh+1XszJE6FGqHTDjfWimvO4z5gaEFRHeFoT79iinYrddSrTO8hyxSok8EeQorec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787792; c=relaxed/simple;
	bh=B9qG/2DjKap+UBB2rRp/93xS88l9UZlnoF0W0JX4mjg=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=prZIat9Pif6CHDWaOvnZZ96rsLcebO2M1NXdtqZvy7PMyn+QBKKWWfGSWSD6m4wPeqMvbjzwDmCom/oWS6KDG8boxpk6QQJ9YbAAJYaQUvnVVuXcUX3KG2SgLuIrE6mDVKC5k5QnXXPmoHeGP6ROCeoGBFG7Eib+rbkuaD9QyrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FHKDN+i8; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bA73YaXuIWJ+RLsWO/iihsadydJ/598f+i6GPW1k9SGdVeUq52/H/wdMxZZdg3zIvHb+QW8/zthlLTf3dChOQvPlWgFPXSEXm1qxMzN0xfhmmsOOmSqEukov2yIUZZIeidn8X/ocaG1jtrab6Vk8m41GIZzxDp//7ehJfYSx7Y/CvuQ5OYDjEnSkyqlwy8XDVCMO5LYjEY2YuvVpv3H+YxoA3IpLQpReRcVpOzpxH8n8ol6NL75FbAozdOzf5lMHxWbhY6txAqa2drUUcMm4GD55R4nC/YyasjEQjaISS0CKA9Q+JXz8Bqy7RxYXffI7MetIpQoB/0gaMmcWqoHYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFLXk3wespIWiBZVTzXiM9RjN1Vy6IQWlW1Lktd7Dpg=;
 b=r48Hjs5QweLZaGaCuhuVKjtgtFN92eGUVO4RvreErFtThoQUSM6TB/URnL4nERgGuu5xdjZ2IUjG9Iz5gsanRxkPcOCyGL3e75RQ3SfgCHH7LWDM0qP6nXv3Ef32lthKZogNRlCoRrSnx3P2jmNqA6fUSANDbYQH+fl1STqrIzC0/BAMUYNQbVQSElzDPZknh3adBeSaRs7fcmzD8ZM49fAs2ksyRFLkdvDhMK593WzsQzl9HYA3UZOIeJCvGzH4RC+hz2XuNzCYSihP0fN/hHr1zFSTinNheNlQnZ4XJx4Otx9WK42XhCw81MQLbo0EjZcp+YupHlwWaab0i5zg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFLXk3wespIWiBZVTzXiM9RjN1Vy6IQWlW1Lktd7Dpg=;
 b=FHKDN+i8HcpATb0FESvsPMxk7QOp8Dkw31dMAFz/dfSVszPKvyBQDs9newzJnj8l2pKJk3zv9F8DBHqFMGVZHHN3XAFu37sZwqAxx46Z/kks+K4trq3UfT/d8umXtyyvgkWe0Ae35+ev88wZDkCEELF1uYfGRQxcNGxEFD9EVo50sHVjD7E7hCv+sRdjXtJO0TUm/M2sDpYma3ysikG8m2+eDZzO1+QEfrjD+CYWBsyYzSIkTf1nHCsCMsVg1absL6qB9QGXCybieoqmq5Hu7oZr7uUFsFif8ngSwGMjAezuTl0rp0DSSLeUhP8Ql4ggNkeFHU3r2DCk6hnphJbLVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by GV1PR04MB10751.eurprd04.prod.outlook.com
 (2603:10a6:150:20d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 09:03:07 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 09:03:07 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Fri, 06 Mar 2026 17:04:48 +0800
Subject: [PATCH] can: dev: keep the max bitrate error to 5%
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-can-fix-v1-1-ac526cec6777@nxp.com>
X-B4-Tracking: v=1; b=H4sIAK+YqmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMz3eTEPN20zApdU1NzUwNLC0NzE0szJaDqgqJUoDDYpOjY2loAhHY
 IplkAAAA=
X-Change-ID: 20260306-can-fix-557509817496
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772787913; l=1149;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=B9qG/2DjKap+UBB2rRp/93xS88l9UZlnoF0W0JX4mjg=;
 b=8lrryr47j/3MPtV/07LXMVb3rAU15F84GQNXWzEukui7KIE/ioUqf1/SimEz+ATXGIpZHBxuY
 ftAfLxayu8SAIEHzmaMnzkjpUGtxX0NbrOmJ5FNvo3+fQaV8pkgSrNp
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::10) To GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12272:EE_|GV1PR04MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: abab40d8-b0f1-4520-9a71-08de7b5f2ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	xQDA0D6RTcsbBdnCbQKX10cAmYrggRYS7g7kaUTLxVd/5DgE1ysxLkiEFek/Y/U4FYPAoGi98FZCPOSb+aoTXVrOtRISvPkS8msyQ1AUuH3XjCUacH5PwkiPJbCIuKeXOZewJTRSRaAVbL/mE3RmbncJgVPFiIxL4wy+AOx/Poa6qDEsG5esOkK5xooqe7u1RRaN1YpYq7ubRiYGSOkr++cYPAU1UBka6yFh4ee8RPAW89fmlWgyEv+cLg9sg328gwqCFrkvvd0vSa8TziluP0m8bP/aet+sEoOPuan+I6/F+zlPz9v1lmaQMBPDk1u6RG018G2O0cPtoJ4fouXaf3yJisoEQ1QcvoP7DOdWN4iIKcM9tIUgAs+CSdQEowvkMrobSnG8r3Jb/Z7oBIhQ605T5yoKEyXgGvqSPNIL7at+iKBEGiLBdYza8Du7DoJf02+ODji86cifZLJNdKf8Sr0LMPVnxI36X0arkf/hgyXWxpae6Y0MaM/sMyN8UyeGBQNCclISA2/iC1bBaVBhCvzU7Zm+m5qzVJUeAy0GVdCUhb2RqVMgMVWz3jXz5Z8MKrH5R6K3S3nKPe8fqShd6pPHvPXZYtm8cGNWU3i6ctpXFvMXACb6nkf8PVc/0yuW5xa75GQnVecRaaimEYz0RP1A2fAUPaJe9I5qb9IKykv/uJj5+RSYFmv6FLIJ4ELqtgeNsJEu78lB66Tzp6k+5iqxppqOa5kqirrSIbm4SITqNJvLqwaN7OSQdGqoKN7OsGnvbvTZvulR9kpnGxLVo1FaL1U8viUrzUS78UHD5bE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRvTUNWZStuWUI3NFpENjRleG9CZFBKUXJsRksyQlpTS2ZZV0pMTTBxSHpz?=
 =?utf-8?B?QnRCUDl3VTNvZm1aaDc2clQzazVMUUh5cWNaZ3pFL3ljV1NOdnc0Ly8zSHJY?=
 =?utf-8?B?NnlOTHJHWGo4ZTFOcU43WlBIbEd3V2R2K0FzZUJUQUtjU1BuRTgwcnFVSFlX?=
 =?utf-8?B?NHFlWTFrZlU4S1hwK0R0THcxWml4MTNaektnK0s0M2VDdUpINTBlWkFLa05N?=
 =?utf-8?B?aUZydS8wL0IwOERYcXpnVEFzaXJCSHM3WEVWSWl2dlJ1OEQrNHhRbUxmWVBj?=
 =?utf-8?B?a25HbndXMDNNK2FvV24wVkJXK3RaMGJPSUdMQXpqa2R0V0dkeWlxdXJGdXU4?=
 =?utf-8?B?cXBGSnBNbi83VU93dStzbnpTZGJkWHlSOEgvaXNZVkJ0OUVlOFpDOEdlT3Ji?=
 =?utf-8?B?a3JaK1ArWWtVQnp6Q2FVQW1QSnJJZ2JpdFp4dEFUWm1mK1NscnNQR1g4enJw?=
 =?utf-8?B?SDdZUGg5SVI3SXd5UVQ4UjJSYVdrcFNFcnBGUzdjSnlxd3dCR21ZWlBjYlJN?=
 =?utf-8?B?QjhIRXF5cnh1dXk0ODFaclEwSXNMRys1L09ydGlKTm41V0xId2VPN0RRNVIr?=
 =?utf-8?B?Qmg2bjhXWWQvVlFucVZGTnBGcVhSNnJOZWNCdmN4NHNVTEJIYkRDaVVydUxW?=
 =?utf-8?B?Z1Zjb3ZXZFRHbzBlaC9odGMvTkh6cU5xelN3NkNLcGY5aDlURkJzeUtpUzNQ?=
 =?utf-8?B?L25qczd0YW5kOXhvc3pDRnpLMEpoZitHcFNsbGQ0cldDNFMvbFkzWWZ5MkhG?=
 =?utf-8?B?M0dDQ09udFZoL1E5SWlKVWZCc0RSWXFpU1ovRTlJbEYvcUlWRXc0SitWdFNt?=
 =?utf-8?B?KzZzZUc5KzFqUWlTc3Vka0djMzIyT1lTeFh5ZlZRQUFBME5ZVnF6WU9NdjZ1?=
 =?utf-8?B?M3JiY2l0bGJITGpHQlZUYWx0S2toNTZBVXc0d2Y0OTcvcjNLTkkyUTMxeGxR?=
 =?utf-8?B?ZDJueEN2dXFNWkNxZjlDcU04RFl3VGNDZDdUSnF0eWJqOE1YbWFocitWblBP?=
 =?utf-8?B?aG5tZVJGZ1ZsRGRrcSs4bURoYVo0a0JaYzB3ZENTdkNJSXp3ZFp4bTJwNzN2?=
 =?utf-8?B?ZncvM3o1NDVHa3NvQ2duUG9kMGpaYnNuOHM0VTBoeVcrVUVBTTVqclU5MVlv?=
 =?utf-8?B?eUpBVFdYS1RKdjBxbXJZWFByL0ZIZXZNazhDckk2Qk1XdWZoREFVWDdxZkpn?=
 =?utf-8?B?ZVIvbThIcHNZTDJlWkQ1NFNvcjNaS3phdzZvcXljMVZZZy9vZnRhQTJrSFJK?=
 =?utf-8?B?WVJTdVlaT0dwb3FmQndMdUovOHRpR1YxMElzbFk1anNaeVl3NjYwMXMzMFhS?=
 =?utf-8?B?YzNyMkkzS2IxdGFPeW9UcjV5ZU5jZ21qQkNXa3lYRGxzM1JmM1NoWm5vaDBD?=
 =?utf-8?B?S1Y1MDN4WnlPWXZiRFh1VDFMV0VEN1JWeHpFL3Z5cmZxNk84d1hLbUdRZVBW?=
 =?utf-8?B?RWdRYk9MZmRjenByUUlQQU5GRXQzdmUvNC9YeWN2cWZqdm5nNWlPMDlqUHZp?=
 =?utf-8?B?ZTJjUGRUQXFJMUk0SlVQSHk3bnJMMTlSaXhZYUtnSCt2bE80cmEvcWEzRUYw?=
 =?utf-8?B?dmFpWElOVUhEcW8vbEQvU2k2Y0RDM3hhdDBySzI5QUdNblRmc1BiSjdPdmI0?=
 =?utf-8?B?eUlIL0RZZjdJdG1jbzBTSmdhY0s1d3FITFZEc1AwaE9xeDVvdVlib3Z5VmRs?=
 =?utf-8?B?b0MrZjJ4b05rVUw3QUJSd1VFc1NKY1phYVpsMmthUC94a1p6UTRxaTlaTXBw?=
 =?utf-8?B?VERHL0pMSmdQZEJQdG5YTVNxellIK0Y3Y0g4cGtHL0w4TldzQWV5UmRyWEIr?=
 =?utf-8?B?R0lnZGFtMFNXSGlObE4zOGJFQUNKYWVyZUdsbVNVV0hhSEJBN2dDTWJrczdH?=
 =?utf-8?B?Y2VZdHcxTy85SXl2eHFaeERiWTQxMzJQWDYxU3FUWWFNakVucHB0akVSVHBZ?=
 =?utf-8?B?bVlmVDZPM21zeUZEN1M4OEYySTA3V09qVFNRdkVKWjZpNlkySUJGUHVOZy9S?=
 =?utf-8?B?TWZnWFpOd2lSbTJJSUgxL1lYdnI1QzBua0hzem9hVlZxc2E2bnJDRW1aa1dw?=
 =?utf-8?B?em1FQTNkNzhzOVR5OG9lS0JUMWk1U1FsVWhTUkFaOUs4SXdKa21oM0lTM1lM?=
 =?utf-8?B?cjAzOExQOGN5aTFpSUREMGtMdThSVUlmZldGVG9QYm1HUStXa1Y5azhXMEdD?=
 =?utf-8?B?NmxUaU9lMW9PVFJOTHZOVHFQOUY4eE1xN0xLL1VjZTZqYUlycVFEVVpka05k?=
 =?utf-8?B?QkMyd3pDWlhiT2NPdVNFSll5eFhjbW1wTGdHZ0VFa3FPMzBGL2RXOFVwTEZ5?=
 =?utf-8?B?NlBCYVRPZUdKRCtidk5IMzd4RlFBK09TZERVSkFhb3k2OUFqcW15QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abab40d8-b0f1-4520-9a71-08de7b5f2ecf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12272.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:03:07.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwLu6SKmjChOrDccBNcQ/qYOYdELlFACzZz0RGY17QJKXGRqAnjjClWiiC0rBWGrTurY17PeD+5HPQlxZmM9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10751
X-Rspamd-Queue-Id: 111D221D967
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6964-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haibo.chen@nxp.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

Keeping the existing logic unchanged: Only when the bitrate error exceeds
5% should an error be returned. Otherwise, simply output a warning log.

Fixes: b360a13d44db ("can: dev: print bitrate error with two decimal digits")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index cc4022241553fa6389c2cde698456de723ef6929..42498e9d3f38dbe8b9389d250d2d53798963839f 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -8,7 +8,7 @@
 #include <linux/units.h>
 #include <linux/can/dev.h>
 
-#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+#define CAN_CALC_MAX_ERROR 500 /* max error 5% */
 
 /* CiA recommended sample points for Non Return to Zero encoding. */
 static int can_calc_sample_point_nrz(const struct can_bittiming *bt)

---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20260306-can-fix-557509817496

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


