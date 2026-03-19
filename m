Return-Path: <linux-can+bounces-7142-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODsXB7zHu2kooQIAu9opvQ
	(envelope-from <linux-can+bounces-7142-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:54:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889C2C9194
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 10:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9925B3243E6D
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03663B9D9C;
	Thu, 19 Mar 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hFQIJ1wY"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B03B95FD;
	Thu, 19 Mar 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913244; cv=fail; b=E2ehv+AY6//urjHI7mYHqFA4jRsPPNKfVhLOLhoTVxuAt0eE8wFgNJhKg2NTcxxZB1yR2a0LktS3ab+koiV0iBC+z/PVJXuLvSmT/CRvxWLz4Sx6H4QpGXjaETY+VTN7xKCs4B45UGqL61/InhHUuP3WdGNziYv87aW7/xUb3QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913244; c=relaxed/simple;
	bh=GPnlqvdRXsLc24d/1zhbOXeDWpcKpTQ51bLonFIvvws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jbOwmQtWFrrCFS2Pvrcz0NvHtjzPEzVmM/it8hUFxlmAgyKr+FZDzzSyzLIZU7kwiKKWQWvRQMWXXLBUoa5mOqyilz9Yk1SC3Neoklz+u42BGBSqJKiF0F51TJglf1Kjn9h8S93bAmN8oxQYZqaepcfdxnsVmSVWrxHUcNUfU/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hFQIJ1wY; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl/MjfN8J05ZohwglNfbgHWjeJiucIQD2kWEJM91lu6hEp6TWz857J1meBRwQjHS6dUrhaF7P1G7y7bMNBoY9AjeWaQUJcQLh7rOy42PaHZXBGKSRpNDK0N3QLhyLz6iT+ALzCSOFpH4Poiafan2wR3GfC1GOnCnto4CfXgod0+HRe4NamcESijUEjB3tf8wTzvMyKx48wp0PMgbSd7vS4OK4iDsdcE1RsATKW9QCRNM7yG3qbEaoV7eE38xjR5o2OETyJVRMXpEpv+Dj1qty0FZ2nXheQYHJJLxhhFLoeec1gLuwFHvrvEs/AHk8D/ULfJ76axxxAlD3oNKogOe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRUiXFGV+EzrITNxMGgXV1L6TDZxT0VZaihtxvf6DI8=;
 b=iE+wjLPXjfViPtvFre6ej2+cm272d8SrcyBcSbpDe/CIBYekwbu2btzmLJ7nVBU83PGMxdWS9LgrLgAdsNzmJZiU7Ih0iyAkWUg4kqRu0wMX8jYeKWJScdXefDv5cbnrKomaoGfaGorhWfAv8lK9vx6TJflrOShOFTesapGqC4++RiSo9gu10wc7hZviMmOHpo6k1DqV0VkuaaZCTZHxLvGSem2SCK1uxw4rCbWNpmD/J2ZfFk4j0X4W4eJZGFie+b6HG7mRplKCoDRPnrdE7dd93af1qmk/eyUOp++kGnnAgWepQj3zzmFJoAdWd9KSappJ5+hVHKz8ZDPOS5lyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRUiXFGV+EzrITNxMGgXV1L6TDZxT0VZaihtxvf6DI8=;
 b=hFQIJ1wYfQEkpqrEX1Sat2ipY5GEC9e66Bf4piT8X0KJ5ybTWkF1P2A2i1pi+t3bHJN2sgaA1SrVsQNMdtvY8WpBKUPt1ZoiayXswAHJkOvEplFHu7JF0NtzEY7kH0Ukq39actNrcB13qihGEOGuRX4lrfEc0KOuN33T51iI8jHr2Bwyv8i5tphe5LBKGs9e+CSsiYeFk6M35zoQ81vi6jU77Zvt0/Hwns6DiVYwwiTZRygZuCYmR0UKitq+zHrhJmSKPVR9evLuw2ucRIHjozfZDqfv1h8DDJdfch7hdlrN0kMbnkWKLW6zXraFmRvdye+FZa9KdIAwfsEYpJsZoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DBBPR04MB8012.eurprd04.prod.outlook.com (2603:10a6:10:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:40:33 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:35 +0000
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
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v2 1/5] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC support
Date: Thu, 19 Mar 2026 10:40:28 +0100
Message-ID: <20260319094032.427697-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
References: <20260319094032.427697-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DBBPR04MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: ef69c7e9-d709-40df-8924-08de859b9271
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IpcfTYTeqMfQMVWLSKmuq0MQAKKqJu4ffJqu45S4m9UzHfezyJgNqrpNf3uOvVty4WKLYkpaBwJqlUyDvsIiiFzQ/UtVMFSfMrzrUIpjpbG8ViR0zDfTW6lZj7/jtGlhN9VeeH96/1XgxIxQwiUQ6ESwG51cZ9HoUBdTJ06tmJDEo+yh/4BEM2jnKa3PrIOuCFkbqDRkUxTThAq6BiEE8i+FiXRmHzIE3QHMiF3XxMi8K04Mtkzc8vQ5OKaQVOZNMO5tQwXEWlE6Ec8Ruo4EWksLZmlqLBnjCkMFvyrUs7A1DHSc/TjBEBBMD6x0MQWJnf4OVx6xAbZsOywAHFyHj1ZFWEfQCAQnxZCE7J0Mim9gr6Wb2oOZruYrJFuez15eiWgNXhU2z+1s1ksXT93buWHXoHI2tTddFMTk7tzIaONcAh4qtVlmBiZmCF0Z3MWz0dUtyaWBVMcZCNaqhRxHUPp0nIyzkD5wwVc+jnqZc6FKWaaxlR0NVKoW9vKiMdcagXYxYY3e5R9wQsTKZU/h2P+bJvqmHB1JTbxbIcGqs5ORn+xA5OtD7zB3aun/vQ/qLj+DDDOE/i+FMIzc9MGu4sw2v4RBT8Cc0pSziUQ0/Os/8GgrfAYfDw5Y1PNmFAcKNGCZRD0N9dpR1hjNDSUXAExIgMp2WiURb95O22LwwCCNedlazy2HymHKFSiJzfAYmkYf3SaCUqbxFuFzuKU43UAYplWOL1b+GZdDbIRneD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElWdDh3di9iYzJTOUV5TmsrMGNvdDJ5b2wrczZ6UU9WaFNvaVBuU1lrbjFV?=
 =?utf-8?B?TEFyS2pJQmpIeldhcjAwMUtQbmZ1VXl0ajdvYjdTYW1hMWg5UWJPSW04elZO?=
 =?utf-8?B?T3poUXZLUlowS052VHVxdWs5ckp1VUt1M1JmQno4UG5zZ2R0TC84c0VZY3FB?=
 =?utf-8?B?Z2YreGRqN3VFNHEwV2NuVkJJWFZQMmpMcThvdVFHRFNKcjdRdEhhcVFNQk5X?=
 =?utf-8?B?Skd1R1VqZFRXOWVwcjZsUHgvM0VMWkh4bXdSNC9TNzNOQ0FDc1NwKzhHeHZX?=
 =?utf-8?B?ZEw5QUpMVFBacktJRGt0cDBQbDk4WFZEc0g0K0J6a0ljRzdtUkFDSytOSnJY?=
 =?utf-8?B?RUc1N25sejBqaUUyTE8rdk1QRzVzcEtlYjA3K0F0TXAzR3RsSnZCWWdTRmpv?=
 =?utf-8?B?M2RJdEVpT29Jc1Q1azhPSTIxbmg3ODI2Njc4L2ZKcXA4bFM5ZDN4NW9Melpm?=
 =?utf-8?B?QlBKTmUvdHpMYmJhdzNxTmN3WlN5UE15bElaQWpxakYwUlRtOXJMOUZjc1Vy?=
 =?utf-8?B?MjFHaHdMMkJ0QzFmVElzaWE3bFhTVFNsWWpRR0RqcmszNUFOZG9EdWtJZ0Fh?=
 =?utf-8?B?K0pMTlVmYjhmdkEzL2dYSUJnMkJyOEplR216cVVXMnBHK2dWYllONnFCZVk0?=
 =?utf-8?B?YzBGTzdGelpiZVRBNFRaakFnaE9iMTdPeEtmam43UVZTSnhvS1ZveUJkMG5s?=
 =?utf-8?B?VzFabnJPSmd2Mk9WOGNkRVBHNVE1K2RGRnFLc3c0dWNpODFwaW4rQzYwOHhz?=
 =?utf-8?B?M0NBcWtjU01iQmxrTW5yaVRXUlB3RElpNXp5cUJnaVF6clZiVzVKem5pTlVD?=
 =?utf-8?B?YzFaTFJZalhsdm0zbTMwblV6c083UlY5em9hQVQ0cldJS2NqTWlPWjMrNEY1?=
 =?utf-8?B?REZmWFFCcGhkSjNqVFZ0QnhmUy85d2NmRVowSFY0SDF1aWo5VUg4Wjl1SHFS?=
 =?utf-8?B?akQydGZkVmtvUmNQeE9NR3Naazlqdyt0eHUxQW9hbzBuZjA4ckdBUGZrT2wv?=
 =?utf-8?B?YlZob2o5N2ZoV0tVSzA1RzVQblRHU1JtOGFYTVFNeU93ZTVrdnI4dmM0Q0xJ?=
 =?utf-8?B?NDZ0SjVyUjJDUEFVaXJGcGtGR1ZMUkZCcjQzTHRVdzNjY2o5TTFUOWVYUEt6?=
 =?utf-8?B?V1kweGo1K0NBUHhCbkVzeU55MHgyUW5kWFl5MFlSeURlTFN3eUxsM2ZQdDFU?=
 =?utf-8?B?VSt0RXBDdVRjWThERnJETGEyZ1FPSllObEZuVjRCcE05ZkZ4OXBBY1FsQ3B5?=
 =?utf-8?B?cVE2czZINEExUXJTaUV6Qzlkb3ViS1M0VkErQ25qSGdNQlVyeTZpOGVwMmFm?=
 =?utf-8?B?RGYrSGhrdmJ6R0NCNjBFMFlQRUozbk1iQWtQdWZpdjd6S3RUblIxQUQvSGV5?=
 =?utf-8?B?WmZZYjJmNlNqM0RBYkQ5a3lENFp0VkYxOGVzZk94cnVrZ0dxOHRacGpZUUE5?=
 =?utf-8?B?djA4QncwOXNlTDZod2JPNWdIdXZodW9XK3RrZXQ3REpPNWx5dmUwdy9wdHJM?=
 =?utf-8?B?L1BxVmpnTFlVWmtCN3VYTmloTWpPM3RaQ3c5Z0N4NXUraElHTDV2NmdkYXhh?=
 =?utf-8?B?dDNRR2UrQU15RTJZa29jOTVId2RIOSsvUWlNbGQ1OWdVdTl2UkRhUmxMRzBE?=
 =?utf-8?B?WmhiSkdsSmJVRlZSdkJyODVaNjdmQWhSN1EwWXA4WDRFS2NVVkF0VVdPQ3ly?=
 =?utf-8?B?ZW9ObHFwSEtuMzErNHFOMTRIQVYwbDJzNlVoNktwcnpuWTEydDdSZGZoTmRR?=
 =?utf-8?B?dzZ0Z29mSHR3MktPRTNCa0pLZk8rWlBVYVNmV3F1V1MzZXhSK2RMQ1lpbms3?=
 =?utf-8?B?Q09EV2Mwbjc2czRiUmlKekxlaUVJbWIzdndyTEFlQ2JKWWxqUk5KUThCVjFp?=
 =?utf-8?B?OTQrOUJ0ZUxWSmRvZEMzRGl6WFIyOHk5U2JUcjJrTkNQMm1FdjVCUWwwMDZs?=
 =?utf-8?B?UENGaDN1ekVaYnQ1Y3RRNVB3ZDZlOENwcmdvaEhsZ2ZScWVRV2VFUHMvYkFG?=
 =?utf-8?B?ZDJPdTV0N1JtUGdMZ2cvZkFnSHR1MGErd1I4QWFrRXh2czdFMnZmd1Qrajcr?=
 =?utf-8?B?Y2Vuc2xUVTlyS0w0YVI1NFprVFhWSzV3TTd3UHVQNVhGaGdQdmNlQVhIRGJh?=
 =?utf-8?B?OWRYSFpkTmwvVDBwYVh2Rm8vODdIaTlGcGxyM0hZL3ZuVEh5cVRGZEVGVVpD?=
 =?utf-8?B?UVFGTnVtaFB0MXNMcTZHRnlLNVM4S2doVWhHaUNEYVMyYlR4dzV1Z2FPYUdJ?=
 =?utf-8?B?a282MlZPTzZHRkQvQzlVRDNzNnNqOHViNUVrTG5IZU8yd1lBMTlzL0RncW1D?=
 =?utf-8?B?ZnJhT0UxN2VsQ3dMN1lvRDJxSmZRWSttQ1UwZ1ZTVFo5ZUFZR1AzYzd3NGt1?=
 =?utf-8?Q?o33MHm3SIQjJ2lRE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef69c7e9-d709-40df-8924-08de859b9271
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:35.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLqYzcRWfGH1QcaaL6H6/bLaKPgHfCElmRvhL9eSo6WRWTx1TfCYnls3WVv+8vYqCsgM8U7fquvY6DIGsFXU+FZYPP0IBb4RAL5codW3eTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8012
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7142-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciprianmarian.costea@oss.nxp.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7889C2C9194
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


