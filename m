Return-Path: <linux-can+bounces-4344-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7962B339A6
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE707AD992
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C829E11E;
	Mon, 25 Aug 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCZuV7KA"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD828CF76;
	Mon, 25 Aug 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111025; cv=fail; b=igWAXiHaAvTth+gsD1TFA76M3s+kjyFxArldrTHmu1SmExEacwviH38u+wW1yoN4wBBaaR2rJZX8qSgnsxwD4UxSK21zvSmPG9Ol0fkZHLqXYxQA6BLjBFAw2ShOllko9QNHj/Oyj2zH+oY+njAlGGfTynlz/QUQPdg1VUpMcMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111025; c=relaxed/simple;
	bh=gF+wW0KwKUXe66iZxiC9xweCKf8aQOVHFqX+HJCAx8k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=a949N4lIxmj2uOUUB8r7bHzWL3lTYM+60XQcyRPT56eiGfz3rsE6TxVs1RdU2gty0SZY6V42jVakTe3K5P5O41u39yIkDqKejRQOt9fsgNHTiVlN7hULmnjTsL3OGvvkIK02cbQj54dPB9YCOzEAO3dk9jSqoBMlbir2fpd6q2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CCZuV7KA; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrf1a+YJIafalWzlKSyihEaV+A7KnIIdEGr7e4FLxMTZ/6dvqatxP/dKFEVcwqBXXYACehi5S+WR7gNnqudaRlNjSkiLJE055m7V5eyc338QO0mqi2jbqT15VdyFOxmsNrFw7CmLcNz+yu981f99d5Nf7FvxyHQ/4WcLs8SFFKuRCHn6rT9mS6iBHV9I2+3UqS6JegCCwB4nZpBRUydqM6ulY73uJWU+AnqhjCX8bzhMlc7OBXb9ri4x0k592Vsq+a1pzUjYA2txnnNq2RAi7S+BG0PSJ7KqBg3QIPSQm4izueyJm3BtaJ+UJd8UeepTCFKkZgo3mWWhIF8W6ao7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt4L6Iuh/EMjsjJEJtROqYbE3qIt9SvTHTd5nI6QJoQ=;
 b=F+F8W620Bk5OLRhXoELN7eon96ubRHQXk5z+1hncENjxNHJbOgLl2fCNo6UjuIJH/wCqC1kVY8ucRUHOjjkiTnjefW3Qxm7f1sqz/2FJPGumP2i1sWDQHh+7DE0MfZoQ/a9PU+G1CQTPh3A1ejdrlowFiVQk6+EFzl6VHCuWX4jpBtROMrER2XvI40tEBoAAtWaRBR3+4bovqOwZad6rTxT97Dk8QKC0qzfBz/yaoshjQwyHjMN4nIUNZZiPQVpEtP0TWl/K7YH7rS0N2e5GYxsyi0Yxb4Yt0bLBtGNchdZbWKkneNruVnOoAwtRQDsWyu4N4NZsrzst3caXkj7K2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt4L6Iuh/EMjsjJEJtROqYbE3qIt9SvTHTd5nI6QJoQ=;
 b=CCZuV7KAW9zcmUWkpOp/Y6p5Zv42moBxZgOmPHX+jyyavvOXhG2p0YlhOK6J4Fsm84NtcD06cSlUVsdT/whMPdoDcs/wMbuzCrczVLUQ47DGwQaciB6mRXLbxrnX2WTtERV4jg37rkDI64ugLI8TM2QuWhH+Suo9fA31Ji1z4OE9LyEYmifI3iOo5aQ5VdwU5S+RDxRsmDiRg5eDYLIvic67qB65B2J6X+nn61mXVlEovgf4c2wDYJI8Ex8pxsV0C2lzr820RPe3vJU3l2W8Jg3u/1wok18GBnDKu4bPdNqRh7exrH5NFH+54ToAFd7Fm2hDEmvkfiGSgvo/RLMB1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 08:37:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:37:00 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/5] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Mon, 25 Aug 2025 16:36:41 +0800
Message-Id: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkgrGgC/1WMQQ7CIBQFr9KwFgOfEhpX3sN0AR+wLIQGDKlpe
 ndpYzQu52XerKS4HFwhl24l2dVQQooN4NQRnHS8OxpsYwIMJBuAU9SR4iAATe+ZAEGaOWfnw3J
 UbmPjKZRnyq8jWvm+/v8rp4yaXmrNuURlzTUu8xnTY499TPiZyJT0ioG2Tn/Ncdu2NygvOau+A
 AAA
X-Change-ID: 20250821-can-c832cb4f0323
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756111013; l=1651;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gF+wW0KwKUXe66iZxiC9xweCKf8aQOVHFqX+HJCAx8k=;
 b=goqvaiZ0osZsDGWDxlmx3hdaWghIDe76c+hrB1wOKYC7kLDpRbdG7iBR6d35TibLTEz3Euv2W
 qrA8ow0Rhb6D6wQI6BdBLAo02YhkDi2+HKb5e9HCaf/vwBmsnSGGA6W
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c80b026-2564-45f2-8bb8-08dde3b28efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU4xb1l2NWNVc2UweDRZNmVCd2JObVF6ZXV2UThWZHFoaEVJOXA1aHkzUkFG?=
 =?utf-8?B?OWpZNnFaUTI3UWdzaGJzcDllNVI2dG9UeGg2TmJja1FJaUtLc0FNZGlObC9q?=
 =?utf-8?B?djloRWpXUU9WNVphRUV0ZzBvUll0L1U4U2orcEtlT1NGRGQ5eHlSeDFhYzVG?=
 =?utf-8?B?bGgzOFZmWldKNjdvY3VKZ1FuYUU4elBOYUhEdU54aG94eVFtS0RNcU1nTEFl?=
 =?utf-8?B?L3puaXRaSGdaZTJpbmszU1RGR2Z2bkw5OVNpMEhHNC9xQWdJaUFHVEZsNEdC?=
 =?utf-8?B?L09rQ01MU2dTQlZTc3lPTVlnWUNYRnYxM1V2dFV2anpYb0t1eERtU3NvUkhs?=
 =?utf-8?B?aXRCcTRuM3JFbjhaN2RzRTI0aEtSN2VaKytVbW5IS2FiSkFJMEMwcVBjVG5T?=
 =?utf-8?B?OXVXUDMzeXE2WC9wLzRPL0E1ZzNjRzZ5T0dnSHgwV0NJbWFLbit0aEFORzRB?=
 =?utf-8?B?UXk0c1lRN09KMGVWd0MzN3VWZFV0YVVDYzh3NmJJZFNmUzZKbGJQNUN3M0c0?=
 =?utf-8?B?eU1YbnhXbGZqWkF1T0RVOC9XR29RNWo0OEhva0hFb0d6dTdGdzRQdWM3cHE3?=
 =?utf-8?B?dTNMMFVaN2RkbzM3SHZadHpaUEpvTzJOaktZamhGUXJyanBrNVcxNW9KQS9F?=
 =?utf-8?B?aDhUNU9Rb1M5K3ZmMFF1c2M5N1ZLcWRYdTZwNzhEQ0lka1h3SGE2RWJxMjNn?=
 =?utf-8?B?cHVwOHA5VHFMcFFpRThyVnhMeU5sQnM0aFA3eWx1S3U1eTcvYUlMNmtyVTM5?=
 =?utf-8?B?YnR2UVh6WkUwQjFMakh5d3dTQVBFTGJKTUl0RW8xeFFRSDhuc25mMTEzSWFj?=
 =?utf-8?B?Q0JuY1c2cXFzUkZtS29ObWE2eCtCUEliR0JmdXZXTnZmOE5wTE5NYkJrRE53?=
 =?utf-8?B?U2hWSkViQ1dPQ1NGN2dsYThUbXlGemtaczIvU2FaSmhWR2s5ZE1iT1BHTmk4?=
 =?utf-8?B?S05RNFB5Vk81M0lVSFlqRUxkTVRCYU5CbG9adndEM0hrWnkrc2d2Tkwzdmdw?=
 =?utf-8?B?alpNMXpQeWRXRlZrQUNHS2lkdmxkcmxmSjdUcW5uS2hHQm51SW14ODk3VGNT?=
 =?utf-8?B?ZWhOblZQUnZUVk1MR0gyaVR5TGhwcXpOaXM5bG8vclpseWs2OUNPWXRFVnBG?=
 =?utf-8?B?L1FNam5DTm9sWVU3U29jMDVMZGRWVDU4ZDlPc2Z6YUF1SEk5S3A3Z3dUSlBM?=
 =?utf-8?B?ODV2Z1pIek5YMDBKK0g1Z1RaczdLb3hqd2llU25xTmwvdURNQlZZdWhDVTlG?=
 =?utf-8?B?OWtQSnhFSGhTQTI3RC82SE9BZXBWaCtlS1BnY3JNRkVYOC9SeU53SFlpZVBQ?=
 =?utf-8?B?dEhibGpTallhTVM0N1MzYjBmTkx3UGFCVUx4UHVBd2EyaFBuVFcxdGpDU0xz?=
 =?utf-8?B?ZVlVeW9sZldzNFhpazY4aWtHSkNhVi9zTWc0SVh4SHQxZGs2YmNwaGNRMEpO?=
 =?utf-8?B?ZUJiTXF1V2Y3alRibDdoc3BZSUozZTNVTGF3QUtkVjRCemFnSDVxL3RnYzh4?=
 =?utf-8?B?UTB5MVU1dEZOSyt1K1VadWdNNHlKZExWTW9HbUpWRklGa2xhcEVPbGw1ajBr?=
 =?utf-8?B?aHpPYWljUGQ5VUE3ZktXQTE5QnUzTDBDRE5GelJ0RjlEdXRNYTk5U1Q4a0p4?=
 =?utf-8?B?blBrd3dUZklybGc5MlU2cnF1bHpjNFpva1BZdjN4cXRNZUpQYVpWNHc3WHpW?=
 =?utf-8?B?L3lqRTZLN3B1WFNDcVNGaDFYZFV5cnYyN3UxcFdmam9WSkpPaXFjS1M2bEl3?=
 =?utf-8?B?NHlvV3pjU0V2QmRzeU5wY3FFMzl5Y1cxaHRiOWJOYm41VGRjbG01d1NFMkRv?=
 =?utf-8?B?L01vZW9scTY5V0RrOHFyRzlwMXI3MHNNbFd3ZzdmZzl3R0VvbytQTXYvVEc2?=
 =?utf-8?B?ZGh6cXoxUE4vUjkydXk4SWZ2cVNQaUVuZUZSTE5GMzVhWjB5NysrWUJOY3BY?=
 =?utf-8?B?ZTB4NlRxWkthWHFyY1FoYVE5Y2VLdkFDYVJ5SUtLTTFDNzBPNXJSeVAvUEdC?=
 =?utf-8?B?dXl2K0dRZUtwNTd0SkcxdnpidlZvQ01RekQxdU5vaFhqNEFvME54U05oN1pm?=
 =?utf-8?Q?XggcBt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2VqelZIRWJYeUd3YjU2Z3NRYWsvTFpibkFtblppMFBDaUJQbms2N0pOajlj?=
 =?utf-8?B?SHlJVE1LR1ZRc1pOY1NweWhmQnh0N1ZHYzJlcUhMN0RRcTFLWUdHZy9iY1py?=
 =?utf-8?B?Mkdiek10bjQvMlFJUTNIeURqbE5CUlNsNTRuYmFLYURuZ1I4Q2RzYWNWMWdx?=
 =?utf-8?B?bjFqVVR5a043cDVKWTNDaHpxNmhjSGlqUnFNTVVpS0hqdTF6L2pxd1BPRWVG?=
 =?utf-8?B?N2p5NXF5N0pXUHpaY0ZyNVpHTWJwVnh0VFBSZlovRzVCbWdidjRKWEpvM3V2?=
 =?utf-8?B?ejNocDI0Tis2a1dFL2NyMTVnTXdPOE84MUM4VTIxRUtkNGdIOGoxUGNxTHcw?=
 =?utf-8?B?ZklhS3NWSlJrOCtTSUdYUnNOTkdNUFdVK2FvOHFhdWN6aGV5WVk2L0xqSVFG?=
 =?utf-8?B?OW85R1lEbWxvb3ZKY0pMZERhTFg5a3dLRHlOWUE1akswaFBCL3h3bW8zSkdt?=
 =?utf-8?B?WGRSbzM0QUVsK2wyRFNDWTVKVlNtN0FXaEZVU1FJWDV0cjdnK3M2NGVEdkdP?=
 =?utf-8?B?cm1TVWszbHYvWUN0OWRtN0VTcFBsbFFjS2lTNkZiRWZhQmh1eGh1bHdMZThK?=
 =?utf-8?B?ZVdqVVdiRFZXUEQ4WXFvK05WK0NOWHg0ellSdzdrbnZaN05SeTkyM2xqY1Vt?=
 =?utf-8?B?L0JTY1AzcktYMlQ1eG9qZXV0NW1HeUMrTlJjN2s2cHh6enZBVEtiU0wzb1ZV?=
 =?utf-8?B?Sm9zbWRERGpEaW53ekluUW9jeEVXRy9FbDZYN3NHekZheEtDUUlKSmVTeTVW?=
 =?utf-8?B?Y25zdnpJZ1Zxb1ozYUZOdlpyZ2dHdExvWW0wRjl1U2tiS2dyOFNhaEk0cDdt?=
 =?utf-8?B?Sm0yQ3FDNnB0dnNRK2I0L2RJV1RSVmZ5aTNTNjBZdkt6TENyd25LT0xuQTJp?=
 =?utf-8?B?eStRQWhmbDhlMVNPQnFkV1NtdWFxc3lkWDU2cGF1UmcxbWw5R2w4L1dsSmsx?=
 =?utf-8?B?SXZGTFkyVm9yVmJkUGxsZHBaVXdHTHk3VWhDbllBN0ZybDFVMjhFelkxdjhr?=
 =?utf-8?B?YlNEbGJ6d05Mb25YSnBwZmZmMVZLcDNveDZtMlN1MjNFM2g2OFNsOWxYcTd5?=
 =?utf-8?B?WE95MUs4SGIrYm8xS0pIa2dlNjFyUmJ5R3lZdHRzR0RwR2xsMXloRzhpRHla?=
 =?utf-8?B?dDlQSmNDVU8xcllkRDVDQkN1bDdNSlJyU0xwUU51WXNsNTQ3T2V4TmJhNGJG?=
 =?utf-8?B?aTZ0ZjY1dFFkdmhha0IrTXpURlFURHNTU1RNOTlRYStHWjIrVlk3TFFraXJn?=
 =?utf-8?B?R1I3S1BJRDVlT3U3NFYxRExubmFMZU1memJHVjZ3K0xuT3ZGQm9XaEJVWkU5?=
 =?utf-8?B?M1VYMG12SitDNWt3WlBQdDl1MWJwcDB1UDI0TzdOVEVoUUVNS2NMRWpiUjhY?=
 =?utf-8?B?SmhtNG94aHViUm9KVFBCVVNCVHJWd3lVZkgvOHlSNG5aZ05BK1YvSit5Y2wx?=
 =?utf-8?B?MDJZMGgrbUZVc2JEUFV2SmRidzYyUFkzQ001ek1Gc2crb01qOUVJaXVtdFFs?=
 =?utf-8?B?aGpmWmVGUjNpaFFUZ292Z0s0Vkx2QWFWNFVuWGdDWFhIZVFaZVo0bG1NQll1?=
 =?utf-8?B?MWdNdEM4Q3Q3K0locExnVzVCdjFCU1N4SjlleTRlZndYeFNDbUtJMzUwSkxj?=
 =?utf-8?B?a2sxN1ZzbmZoMzk3YWFTZmU4WXVjM2NPVStxRko4UW9LN3BZeHh2QzQxUkF4?=
 =?utf-8?B?K3A5dnBOa01LNG5tLzZxWXhFUkdTNlVYU2JEM0h0MjIzQ1kzcTFGY1VqS1RU?=
 =?utf-8?B?UEFzLzQ1WDVzNC9ocWE0RnJJa3o3SDZJOG1FbGpWN3h4MTVzQUNtaTlNRmlW?=
 =?utf-8?B?QVB4MGF4anJBYzdMMXBGbTY1bXhRWFo0dndBeTB5MlNSR0NBdmpKSWhqdGsz?=
 =?utf-8?B?NlJqN3lWcHVXc0ZZUU5pbkd4T2pqaWhobTl2TkdIQTNOUVBVL3VUMXUzaEcz?=
 =?utf-8?B?Tm5JMkZTT1hmQTJrVnA2TGpwRk5IUFpHR0dPYnpBc0FzT29KZElvQWEzUjky?=
 =?utf-8?B?dXVPeXhwVHBsamErdnMxRWYycnRZejVMbjRVR1hqRndGYUNDVDRFTFZjMG9V?=
 =?utf-8?B?YksrNmcxMHVyTzhJREFzT1dxM2JndkF3di9maUVaTHFIMTNjNHNGZEVjc0lT?=
 =?utf-8?Q?3/fn/g0h0+5/odeWMYSQv7fwy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c80b026-2564-45f2-8bb8-08dde3b28efc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:37:00.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smg588/JEmwWMfHh8/tCSjnYGsT3SauQWvCaqjNSJZuL+/OK5PIodpn4Fq7zgRIYgCHycZv3H9bp0wMBKzu4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA1051 is a Single Channel can transceiver with Sleep mode supported.

To support them:
patch 1: add binding doc
patch 2: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 3,4,5: Update dts to use phys

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
---
Changes in v2:
- Update standby-gpios constraints per Conor's comments
- Drop patch 2 which is not needed.
- Link to v1: https://lore.kernel.org/r/20250822-can-v1-0-c075f702adea@nxp.com

---
Peng Fan (5):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA1051/1048
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  33 +++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 +++-----
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 ++-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 ++-
 drivers/phy/phy-can-transceiver.c                  | 117 +++++++++++++++------
 5 files changed, 140 insertions(+), 83 deletions(-)
---
base-commit: b4498e5df1daaf2832141a27c1e5bc34a7553087
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


