Return-Path: <linux-can+bounces-4386-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EFB3B3DF
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364C53A654D
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23E265CA7;
	Fri, 29 Aug 2025 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQF1bjHx"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2F2638BC;
	Fri, 29 Aug 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451380; cv=fail; b=Zw/1P4TWKdPVTbCj+i5nx0Q4bolLv7zIqQC9uVjT84ghzwnAjze8phFnr6qtZb4TJET5seU82tSlJ4RTj3533rM+J/OwDl4WmtJJOXBYeytPY+Nb/gGB1NaAKjHyhwTiwaOvwT1OgKeE5uj16X4rmR4CKPWkJF7iIVrphQGUJiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451380; c=relaxed/simple;
	bh=ZCVjpMq6HSMsqSYPU6j6CMGK8apqF7LQPLo7RTGaYAY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hZ/JkDz6e63VdSxX1YLJNhNu0KQ/g6dElKrVZRvOUf1sYFfF94ykzZjMBvfQqgjNpFV7gpv9ot5SDZ9DpMMZjROaoOLoeq1n+rs0SFWd+o/8eaD9dm7eb7IYQS53UbWIGPejoBc1I+2k2iBvMwpEspo6uB71E4jxF+aDRPKLiyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AQF1bjHx; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw5k8YZbjNgSjkGpg/ovdxpveM1O3WVa/N1vFkOmsVUlwjMvTXDeErrkC9jtsK+VuzhC2K/2qDZZmGFx96avCK0wSvkZKRSG8QQnoDnV2Dq3VvnhYFw1s3LQpGiwkLe7actHENddLj3jRmxK9p6ffiykERsCnEcZNjeqewo2zBf+f2cieGfoszkhbQfmQOkD1wkfviNwwRH6F3EdGEpjP+HSgT9o1a76FwPbiMdNe9bIg1H9q8vwWb6XIai8YejGGuSV47ZZJ+gVM2f21JkTxKbibWjuCugV8RJMv90pIYdrf0TikjaqOHtsyd44a2X6+95nZp7ScBoH0vAjVU7r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLSEi88NQssx2fR4fLsj+0htxaU7Tg5bJI1BshZTyAk=;
 b=l4v/Y7ANa0USgpkpfQnwWe4YicrP7balvdfwTecYJ3P3xBxEhVuUOHPvGlZYmFMUFSHidW753fWCGwmWkIgZEZlnW4hNmrTzD+WWuFZvv/3eeDOt4DenYg0IGqnm2TQoC1fIdj3NCYew45zoGK9Xq8ngVRunhNsov7o/OM0Bb+CRVLwHa+U9Osaw2oZqx5qXI9nrnXhnVh5c1hDkvnq/yqzHpNAnJ5YmlVFpsMpn6fBBrC0OIGN2wSl71Y9jLsZQoh+2uP3dAxQVp73PlLqpPrHdr2+eVK0EZHBbMMPIDSs8CjvDm6NL6w+6LhrllRSAqWYBFkXxmPUxB4OC8KXAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLSEi88NQssx2fR4fLsj+0htxaU7Tg5bJI1BshZTyAk=;
 b=AQF1bjHxEanxDjAe3yQ2Cg9zbIi1dnUWlxL/H6q+QeyFeZ9j3+TpCBgkZGgQfZ4QlfWN56GkdpEF3L42FgQW6ut6dNo0Qpb5nRz3prT6ocTf7FlUz5/Z5nRrbnv++MWeD4F8whU3CqbKEWTbeOYoAPybtfcfbk6bEt4lqEHDwJDI99Dh6BYsGVh1xw2N9oMw45Mg2/1N/NxygUM6GizGZbDIkaAgUNUkvBLhKJErxIB+QPt7Xg5Xks+9bPs5NppqBS6rrOw3CxCw6fm20cDvW6b47uoy3f/nkBlOTFrTwFxooJ3eOpe0tBpwWWZWhp4veZUDy+Y5WLYsTLEDyIf9PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Fri, 29 Aug
 2025 07:09:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:09:35 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 29 Aug 2025 15:08:58 +0800
Subject: [PATCH v3 3/6] phy: phy-can-transceiver: Add dual channel support
 for TJA1048
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-can-v3-3-3b2f34094f59@nxp.com>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
In-Reply-To: <20250829-can-v3-0-3b2f34094f59@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756451349; l=5939;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZCVjpMq6HSMsqSYPU6j6CMGK8apqF7LQPLo7RTGaYAY=;
 b=0XIP/Z3L71sak++eeg/h/At/PR93QklTe06Cb2H/OuljLaw8VIFDRGSpWJZMmwqNncc1iAjQs
 bLHHrILP+AdBellWoIQpGJC0P1jbgI9kTgPFlhfOaOLVaTLCQUxh0dS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: acddde98-ba79-4efb-d1c1-08dde6cb0296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJuSkc4QmQ0ZzVmSzlqMS84Q1YyYVExb0VGNU5GTVRCSkRreGVRcUZDRGEv?=
 =?utf-8?B?K3NYb2IraEl0TjJzazZ4Z0VsVFRMMm10RWRpZGdWMXBmM2ZEdDJtS1FQb2R2?=
 =?utf-8?B?Z2tsQzkyazQ3Q0Z1SWZXdFpGVDd5cnJQUG45ZjMzd3BUMFF6bXRVKzd3NzNW?=
 =?utf-8?B?dCtrT21TZ1Jtdno0OGE4Sy9TWjJHa3ErdXozbGx0M1RBZmpucFBPYm5hN2lF?=
 =?utf-8?B?VEJmT1BISlhqZ1NidE4vc0o3VGlidHhzZHdqQ015VkxSRlYvME1hU1VsZkVQ?=
 =?utf-8?B?cjR3VHd4blpZM2pUWC8xaVR2S2FOUFdLeUtDRUt1dDdTejNYTEpqR3BLSDhw?=
 =?utf-8?B?bUQwUWtnSUgrMXFMaXVZT0huSXlOYzh0bkdpT2tMWFhhK0lXQjF3c1RweTY0?=
 =?utf-8?B?SnJlVytmK1JtZmk4UGVleTJNQkRsM0dQRzNiaVE4ZktGTkM2c1V4NVQ2QXYy?=
 =?utf-8?B?TDg1TDF4SEFwR2FjRStEenFSQmZUQnYxeldldHZsVFBoRHJXck50anQ3YzVs?=
 =?utf-8?B?bk56dDA3MlVhZStvQUJTUitPK2JzcXZpNVd0NWppV0JZNG9USTRHOUZmVXZv?=
 =?utf-8?B?V2FYOTBJdEN3NDdKZW10dlRBSnY3d2dnRFdwTTNzSE91Wmo2S2Z0RlE3cERo?=
 =?utf-8?B?dWhZVlRyMkNUQ2o0bU1tNno5ZFczZ1Fub2dJcXROQzlMcmpSU0EwdEZnUWg5?=
 =?utf-8?B?Z1pHdjRPSkpQNE1XOUx0N1E1QTNpQ2xJOFk3MHY1Mk5xczRST3hWY2lGWXVP?=
 =?utf-8?B?akVWcG5zVzRxaVBldkxiQlNpb0J5cmcySmdWK0ZyOGhpRXoxVFJkdnlBVkdl?=
 =?utf-8?B?YVgrcm9ieTdTbGY5aXF0WWdmampvUVBJZ3FTemVvTUhQQk9iVDZxY2FJVW5i?=
 =?utf-8?B?d3dNdm4rUVM5YVhtcGVBdUQzM1dYYTd6VitQQy9EQTBjWjYzL1hTa1pScG9X?=
 =?utf-8?B?djdwTFV3ZEtJRmMybHU1cElVeFVQWExnN0lGVzdjdnVYMzRUbzk4Ui9PU2hP?=
 =?utf-8?B?Q1hTT1hvNkt6QjhQTjV1b0Rqdis1RXlQejNiaS95MDJPTVo5L0J3UnR4MU9Q?=
 =?utf-8?B?NkRsREFyaXNDSS8zYVZiRWVDNktpT0tXb0RwR29PUVFnYS9jUVJDRHdmWGFX?=
 =?utf-8?B?SWoyVkwzWGROTVFDeGM1dzExSlVtNWVleGY3em42OVIxSjRIRmI0aUtaREJC?=
 =?utf-8?B?STczdWJtajJ0c2NvZ2ZhcE44MUZhL0E0RXlHUmplaWFsUCs4S3ZuNUtieVk1?=
 =?utf-8?B?YmU2cStVUDM2N01LVU5IMUs1VUxRTlU1SDRMK1hETzRTSEMwL2UyRFE3WUxZ?=
 =?utf-8?B?RzM0cTNnRy9yK1RHamM3dlZRR2dyQ1l1UWZYWGRVUUxZZWVWUDY5dXNMcVZH?=
 =?utf-8?B?eUUzUjBnQTM3U2w4VlRPZm1PZEc3cWNwQzg2S2ZoSHV5c21Hb0VQZGdZZEsx?=
 =?utf-8?B?WDBTbDFrNTFsV2ZoYWVQRmxra1BISW5NdVBRb1hQWSs1MEtXRXRMcDFhVUE5?=
 =?utf-8?B?V0ltdDJzMGE1blhjcG9jYVVEdFVlcDhKL1ZMR0RBQ3ZkcXNKZ0JSdzFVQkZS?=
 =?utf-8?B?WVJPaHZCNUZka1MwUWwxd0RFU2JBaGk3L0ZPcUJtc2pES21Qd0xsZDdNd09D?=
 =?utf-8?B?U0tmTllVZkN0TWNELzl5SjNWRFBtZDhaQVhyeVVLNFB2V2xNck03bDg5bFl4?=
 =?utf-8?B?RVBZRkdKdUdtNjd6Y1E1UUllejl4YjBibkZWMmpVenluUlJUL2pMUS9Lck5v?=
 =?utf-8?B?ZXREL3RlZVJmZy9aTEZlUjlkbmljU3RCV2lmOG5FTS95aFY4WFJKK2RrZXFp?=
 =?utf-8?B?VVVobHFTWkJ4TUc2TlBXSHllVEhBZks3dml3bHBRUTZrS1BiM25JdXRpN0ZF?=
 =?utf-8?B?cnRXeTh2Vm1Pd25BazJTV2MwWVhvZjZ1L095U1Z2NnFzQzNEQUp2MmE4OS9B?=
 =?utf-8?B?aHhnMitIblNBK3BYT2NwL3hvcUN4Z0ozdWF1Sys2SXhqcGw5U3hyaG1PVmdw?=
 =?utf-8?Q?9obZHXChQE3YHFioMM0+Eqe8X9vz54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dC9Bb01tMVRQeDdmMXo4N213NlQxNklWR21CbE95MlBWY1hYQTB4c2x2WE5R?=
 =?utf-8?B?ditIeGlLR1BLRU90bUYxb2FpVFdzai90SVNwNjlxeCtuVHdsMUVnQUhwNTB1?=
 =?utf-8?B?QWJhVGxGWm8xYlFzMlFhbWdiRjlndi9vRFdwQUNxR1NRbVRZcExzK0pkbkFs?=
 =?utf-8?B?Tm5rMkNVYWRZalpQU0JtYVpLVGFtYUxPY1ZUbDk0NFBHa1RHclYrQVhuUzRX?=
 =?utf-8?B?eVN5ZlB3bFp2ZS9uQURScGI2bjlqSlZjbEpsSmdPOGd0UEt5eGdrM2pWS2tC?=
 =?utf-8?B?elBvS09VcTdiUjZER0J6T0xMd1ZDeUEzTlZPTkR2azVLL3FMTkdxOHhSRDNq?=
 =?utf-8?B?L21MNUJoTFNyekVLdkNHOUpSNk5lNisyYUQ3ZXRLWitJamFxeHU3U3RRWXRr?=
 =?utf-8?B?bnA5UUt6L0pES0xwdVJjODdIVC9IOHpnR3JLMlk5ZUlMU0Vld1ViSmw1UGNH?=
 =?utf-8?B?WXVzMHNvUDdlL2VqTzFXVHk3enZNTXdnbzA1RlFVYjg3ZG5UdDY3N1VobnJ2?=
 =?utf-8?B?OXNJWXY5NVdnZkpiTFF2L2lIS1liU3dmL1RUd2x3YWM4V1RRaFJUSWJseDMy?=
 =?utf-8?B?aFMzNW9NSmUxVll2NXJsSVoyQlZ3U0dmRWNESHllYThDNzU1N284bDUybEwr?=
 =?utf-8?B?eGZHTy9SZGN5S3JDL3JvNEpURUVBeVFNcUFkNHYwNmtHK3orMmZNaG5tY1ZN?=
 =?utf-8?B?YXQwMk5yakZQUEFjRUdRcjZjSWp1V2VZMlpJaUFYckxpWGV2SW5ZZE50ZnVx?=
 =?utf-8?B?NXhxQmNTR3NvbXlGMmVUZjA4czlUT0JSaXh3cmJEeGNMcUlhblFubW5lSDR6?=
 =?utf-8?B?T3Q0OG90MlNxenBOQkI2M1FtREFmRmNBVm9sVUVma1k3dTdvbUd1d3FrZmxn?=
 =?utf-8?B?dm5xTlh0Z2VIeXJBOXBIUE1CU3d3TTNRYkgydk10ZGgwV0pheFp0S2V4SFpj?=
 =?utf-8?B?eFBKZFhjQTcxMnVjdFJWOE12U0M1RUZPcFhsc3ZnRFlhYjlPWUM5cnU4RnV0?=
 =?utf-8?B?bXV2YnJpZmwrMm8vRWNFWnJqV0lsT2NkWnNOSTdPblBDOURQNnFYd0ZIT0dB?=
 =?utf-8?B?MnIvU3krTktxV1dGN3J0dm5VMWtrN05jck1Ka0FXWmJ4a3dzY3QrSDEwSGVQ?=
 =?utf-8?B?Vk1ZNktIOFB1dFhzN3VmSkFEdE9iSzNjbzEzQnhwRG00WHBKWEZRNFAyMDJx?=
 =?utf-8?B?bXpZZXIwaFZZZklhSEZxdE8yU25LS3RWRC82aW04NDBqc2lUb3RRWXB0QjZn?=
 =?utf-8?B?b2JPL0JEZzRWUHNrYVJFNzJjT3ZBMit1QllKTEozUVNBVGNCSWkzUHFXYTdB?=
 =?utf-8?B?d0hySEtYZ2FZZUNBT2F2cXFYUE4yNi85UzVmQWN1ZXltL2RmTFV3QzN0SmI1?=
 =?utf-8?B?VDBQdHlrNzZ3b1FCU0FYTllVeUFHTTBnczZXZ2NYbWhaM0VyRlVjMFo2TDYv?=
 =?utf-8?B?WFBKanJlOHBhc0lXSENtejg3MTFTK2x3Q1pxU3hrenR1RnhQeU5iOWM3V2Ir?=
 =?utf-8?B?MWpEUVo0R2R5ZWNQdTFKb3VJWGNUaXJEOW5MNVZOanpWY3JKODl3KzlYWEVU?=
 =?utf-8?B?UkxMYlliVGkzZEgzVlZwaDJaYm90Y2g3SmpLT2FhTVp2TzRSc2ZScGJKQlJE?=
 =?utf-8?B?YXY1L1M1MU9JK1p0cmRhVTM3eU1Ndjg4ZGUyM2tZbFZldEszKzhoZVdVN2M0?=
 =?utf-8?B?RCtyK2IycWlBcWpRbnUxb09OVjZKYStGVHhLeUVtMGpTTjF6eFRTU0pKaGUy?=
 =?utf-8?B?RGR3cFFCVHhnVy9LNEVGeW55TUVzbDBpcjgrdW95cGtSNXpGUWxTZlNXWGNp?=
 =?utf-8?B?cTBOMHI5NTJBTzhYZW9TbGE1MS9xWDZsUXNSUGJVNHZEN2JXaTNJTDVoVGZw?=
 =?utf-8?B?Y0ZhQ3ZYa0FIN0IzUk82QldSVjlPeTQxU1lhTlVTV0I5VUNOQ0xmUDAwTElB?=
 =?utf-8?B?UWZMUU9QdmcwSFYwRHZ1a3d6dXljUzVNMUkyRUFpZk1GeTFoR1JJaS9OVzBq?=
 =?utf-8?B?OFZ1ZVhYT3dpbFBKamxlekF5VTBEVkZtbEVwSjVaUnh5VmM2SFVZQlF3SExH?=
 =?utf-8?B?RXRkWHVZTzBjY1ZmM3kzWXlUMk5nUCsxYmp1eVlRVitqK1RGVU5ML2FPNjZ2?=
 =?utf-8?Q?ZQlJgrvOcVs7wTNGJ7hNIlhk+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acddde98-ba79-4efb-d1c1-08dde6cb0296
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:09:35.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWyUXESmWPX+tND0WKbyoMlSUGhUyknFv/zMOX3quFmdUrRk+LymbYF30+KqUXi4qrhodeqXKO/eXCSWhFiVeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

- Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
  channels.
- Alloc a phy for each channel
- Support TJA1048 which is a dual high-speed CAN transceiver with sleep
  mode supported.
- Add can_transceiver_phy_xlate for parsing phy

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/phy/phy-can-transceiver.c | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6415c6af0e8414a6cc8d15958a17ee749a3f28e9..f06b1df76ada023f432dce892c3346f45397ab54 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -17,6 +17,7 @@ struct can_transceiver_data {
 	u32 flags;
 #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
 #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
+#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
 };
 
 struct can_transceiver_phy {
@@ -29,6 +30,7 @@ struct can_transceiver_phy {
 struct can_transceiver_priv {
 	struct can_transceiver_phy *can_transceiver_phy;
 	struct mux_state *mux_state;
+	int num_ch;
 };
 
 /* Power on function */
@@ -81,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
 	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
 };
 
+static const struct can_transceiver_data tja1048_drvdata = {
+	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
+};
+
 static const struct of_device_id can_transceiver_phy_ids[] = {
 	{
 		.compatible = "ti,tcan1042",
@@ -90,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "nxp,tja1048",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
@@ -108,6 +118,25 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 	return devm_mux_state_get(dev, mux_name);
 }
 
+static struct phy *can_transceiver_phy_xlate(struct device *dev,
+					     const struct of_phandle_args *args)
+{
+	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
+	u32 idx;
+
+	if (priv->num_ch == 1)
+		return priv->can_transceiver_phy[0].generic_phy;
+
+	if (args->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	idx = args->args[0];
+	if (idx >= priv->num_ch)
+		return ERR_PTR(-EINVAL);
+
+	return priv->can_transceiver_phy[idx].generic_phy;
+}
+
 static int can_transceiver_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -120,7 +149,8 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct gpio_desc *enable_gpio;
 	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
-	int err;
+	int num_ch = 1;
+	int err, i;
 
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
@@ -131,7 +161,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
+	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
+		num_ch = 2;
+
+	priv->num_ch = num_ch;
+	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
 						 GFP_KERNEL);
 	if (!priv->can_transceiver_phy)
 		return -ENOMEM;
@@ -142,38 +176,43 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 
 	priv->mux_state = mux_state;
 
-	phy = devm_phy_create(dev, dev->of_node,
-			      &can_transceiver_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create can transceiver phy\n");
-		return PTR_ERR(phy);
-	}
-
 	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
 	if ((err != -EINVAL) && !max_bitrate)
 		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
-	phy->attrs.max_link_rate = max_bitrate;
 
-	priv->can_transceiver_phy->generic_phy = phy;
-	priv->can_transceiver_phy->priv = priv;
+	for (i = 0; i < num_ch; i++) {
+		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create can transceiver phy\n");
+			return PTR_ERR(phy);
+		}
 
-	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
-		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
-		if (IS_ERR(standby_gpio))
-			return PTR_ERR(standby_gpio);
-		priv->can_transceiver_phy->standby_gpio = standby_gpio;
-	}
+		phy->attrs.max_link_rate = max_bitrate;
 
-	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
-		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
-		if (IS_ERR(enable_gpio))
-			return PTR_ERR(enable_gpio);
-		priv->can_transceiver_phy->enable_gpio = enable_gpio;
-	}
+		priv->can_transceiver_phy[i].generic_phy = phy;
+		priv->can_transceiver_phy[i].priv = priv;
 
-	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
+		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
+			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
+								     GPIOD_OUT_HIGH);
+			if (IS_ERR(standby_gpio))
+				return PTR_ERR(standby_gpio);
+			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
+		}
+
+		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
+			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
+								    GPIOD_OUT_LOW);
+			if (IS_ERR(enable_gpio))
+				return PTR_ERR(enable_gpio);
+			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
+		}
+
+		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
+				&priv->can_transceiver_phy[i]);
+	}
 
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }

-- 
2.37.1


