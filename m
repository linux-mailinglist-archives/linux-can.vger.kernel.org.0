Return-Path: <linux-can+bounces-4349-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1FB339B4
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 10:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46977B2A36
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51C2C21FE;
	Mon, 25 Aug 2025 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UeueZgB5"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A72C21DB;
	Mon, 25 Aug 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111054; cv=fail; b=grn59lbQIAROT3Jynrl2tVd5BzGceGyw3cWKfpr2VsnqcWLgO8r41GkzCYCp2oVlMf7bMjUGENBAlaI0kOEVbnkAM74ymLQFr8yU//FSLlYqvZqpvFO/VZywR0fxJNT55bNzkAguzSEnathfRRrNaY43Rk0U5INMp0FMfriGU2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111054; c=relaxed/simple;
	bh=gMUta7OF9+vcGkZ0qjR43jol+NUTS9NEegva8yuQRb8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qmpGcMIPHoNFqyAx+cV0rfH3uLDD9x4Xoyd5Nhr8umcZiS30eqTEtvtd/YGh6SYxTqYg68gmRDWnZz919qmXOz88DQphz14PEnloMZOq4sHfOuf0Taf/WPBFAwELOsaRNCVJk0emEmNfVLY7Qt29+G1qHuQBJSKXlN3U0lf0xv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UeueZgB5; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/UN3bnoePYe3phue385GfQodQC+5XfyDaJT4SdWndFIQ6W3t8ZKmrBQCyktehecacHH602EUVWNNCML7BSvfjFb72sq74Fo04LAv4DLc42H/CntI00fip+rL6wDX/cG/OjPsM9ZtAqjf44lvraZPYAFYT5IBT86okvopYSYEFUtLj+kz/7IrHV98ON/98WQKruv8fjYw6joMnet9tUsvF39sZJXUxwPpz8w7Oas2jqTFd4DWH7zV78MR0fVh5VLdfmx0++pechXPVO8b9E1NX6z3WCMQhkc0XVUJD7x4pmmVbkiWVn7F4xUKdPndbkLAvuobb3uVBWQLwyxjRR3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsilJbE3npko+8A73/ssMw/LppOOKFMizWtS+zP1vVE=;
 b=t8GGM99K2f8ohRj+CNxpxFY7sYJcJakYgqkP0y0AfVm8tmzAaon329e2cMmfhUiz28hOgXfiFDDhtBFairy54Rzu82cwpsbVnEZrRyuJjhsngQWcHYl6nzzf8jV0EipoEmHTkic+N9WBuxrcYBsofberxaOnvMpbJGHazvfyCoKWTMJ3KoaaTImPwDpurUyqv73H+9KoJnaLKPkgD5ot74J7FgnpNsSC0qIUaYlDKtdTlhB69ZV4pyKwhAnjoBrMv70P97mvofn/fXkZTULmFtVr65/ltgl5jnx3ca91Gqok2a14g1y2CJ+jlN0zqWEy411WdjGUr/VCg13IdyKsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsilJbE3npko+8A73/ssMw/LppOOKFMizWtS+zP1vVE=;
 b=UeueZgB5lJHmOrKmviCD6LdiOlJzlEGUjPwy2eb8o/LldFmGkj0CPVzHvn0oh7hn9K1FcGZqi5D4WtpZfSc2fIkpRKm0wTWe52+P2KWidIUMmcNkSSDU3OsNLDAI8FFSUfCk2fYoMA6xxkjcjPcjIDVPs8mPNBgnF+nzh3D2rNEEP8tVHGPP2BEmHaIwnjd+F2vg2tJvsS6kA7WzHmfz+kXbGR09tkM2ZjneT6pt6Xsznur+G/8+rKI0DbYEbAKaMdfez8RlRKyhxpcr8yW9yGNPdgpkTO1t2kFdFtmTtVT7LHBcZJDqHQ0TIqKlQQpR9RUx5L1z6KlMOeq+t/O9WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 08:37:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 08:37:29 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 16:36:46 +0800
Subject: [PATCH v2 5/5] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-can-v2-5-c461e9fcbc14@nxp.com>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
In-Reply-To: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756111013; l=1751;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gMUta7OF9+vcGkZ0qjR43jol+NUTS9NEegva8yuQRb8=;
 b=/IP1hJ8i/mv0NTXvl2BORte/KHtuybDaEECT5MxXXEftXZQzzr5pBORXMKeJK/OG6nrV3GgHV
 sc6q54NkSE3CZwgdG60L4W9EWB8GLY0oG6Y3JO1xqBFwemabIrqFWaM
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
X-MS-Office365-Filtering-Correlation-Id: 51b47c0e-cdde-4b8b-5a0b-08dde3b2a0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVM4ZDUrL25pY0k2RlZkN0VNM0prZnI1WGpqSVIzTUh4UUY4bnpUU1ZvL3lm?=
 =?utf-8?B?MU5XNnhZRTJlcXpySTJ1RWl2bXp5RFRKVGs0dW9HaktXaE9JaXV6UVpyRmR4?=
 =?utf-8?B?c3hYNE5CYnV4NXcwb2JwdlFTK0JxdFZkMjRWUnNUTUtuaWJFa1NGSEJybStr?=
 =?utf-8?B?TFRGRC9TSkEwRjdGOUlRUkExb2lxYTJKQ1VYa1ZMYmlETEVuNCtyYUFYZFRr?=
 =?utf-8?B?TWZkb2ZJdTBwNmF3RGJLSFV5UVViQVA1dW5iS1E4d21XVjZ6ditxTVo5Nlpo?=
 =?utf-8?B?ZlFobGhpMnc1TG9ua2pMT05hUmd4VWZ0Y0x2bnBOWDBJU1FYT2ZndjhjRjBK?=
 =?utf-8?B?YVByNEw5SWlHMzU1Y1ZGQzBhaGhKWGNjMFQ2T0Z0Z1FWaTAxWjNQL3Y0YWtM?=
 =?utf-8?B?Qlo0UlFaeHErUHl0NkZmd0s1Ky9MRU9ZWjhDUVE5ZDJWVk1TaERkWkF1b3Jt?=
 =?utf-8?B?K0dtRUhMaGlNRkhMdzF5VC9MNFVGVTg5cGNIOXBmbFNzUWRPVWJGL3ZSV1VQ?=
 =?utf-8?B?NFpuRGRGZUdZeXJlZWNTZklHTGlJS1N1OG12UUZsNUpvU2RvOGdudmdNYnpv?=
 =?utf-8?B?SVVIMUVvTGdOU0htbjk4ZzR1bmNFakF6OUJMaUVZVzU2TzNYZVhQMXk2RVh0?=
 =?utf-8?B?WEdwdG1hc28xT3BhMVZqRk52Mkp0SWxnOVhsRXl6VVlCbW1sdmYwblRnOHpp?=
 =?utf-8?B?OXphYjVoMjBUS1dreDFkZTF5Y0UxZ2U4NHpzMC9DSXhGMjN6TGFTekJYY2Vy?=
 =?utf-8?B?QnJqaDhjK2hvTnN4SHE2Mkh6QzRSVUpFMS9aa2ZWUXozV3RWNjV0ZXV3bmdD?=
 =?utf-8?B?STlsSlNqZE9TUk5FbmNnd25GN0xmeDNUUXUwczNvNVlFMzhicFgvT2M2RmU2?=
 =?utf-8?B?UktUOXJuVDcyS3VzSUpyd3VvS1pJUElXazg1c3BFL0o3QkhpVXBQU2lmWkZa?=
 =?utf-8?B?b2RZUi9mK2IyQS94T1J5R29CSmdhU1FhSkpsOHdBRjlZQVQ1dzU4YlVRdmg5?=
 =?utf-8?B?U0phMWU4ZEUrbm1NenpTMDZ1cVllemZqTS9jQWhwNzBiblU5cE5pYWlnTGxT?=
 =?utf-8?B?NnhLVG02UWs2VzBpY2pEWHduZ0lHVnFVbWhxWGxyc0NDcnVTanZzSnV3WUdh?=
 =?utf-8?B?K3A1dWxTcXlOSzhBMXVrMkpvd016WHo5V1BaWHlSZzY0L0JlVG1tUTR0ekJh?=
 =?utf-8?B?QmN0cGxySGJYdUI4MXVUbGFHODR6Syt0YWxEbVh3ZmpQSU8yUklaQW5GbDE5?=
 =?utf-8?B?V1hPWlhDemdTVHZnWkpuTUtjU2p6VThGc0ZoRVdlNlhaVEJDQ3JwNUFEbkZX?=
 =?utf-8?B?bFBCWDk5d3huaWp3OENPdDZvd2d6N3p0YjMxb2ZOYnBSTWhzeXVSL3A5SlJ3?=
 =?utf-8?B?TUQ0a3pjS3lnT3ZuYm00L2ZiWWpqVmVIcWhtN3kzZ0M0ckpXTXY4UEZXZHVL?=
 =?utf-8?B?ZFVCL21rNzN2WG1WUUlDSWV0ZTNnUThCQlEwUTVrdW5wTGx4Kys5KysyekRu?=
 =?utf-8?B?MkgxKzhKSE5LWTd0ZWRNNVdGVlg3YnhhWVRUcmUzWFd5SnFJQURLUkJVOXV5?=
 =?utf-8?B?ZS9HMHJEYTdRc3R5TGFYaGIyUjQ0SWRicTEvSkVDcStna1VsR0FMbDRzdkhY?=
 =?utf-8?B?aUw0L2JmZVRxdlJkUTd6c3VFWVl0ZThJVXlOb1ltWE1aV0VlelRqbUdheE0v?=
 =?utf-8?B?aTVUVE5ZOG10QTFSRUUwVmZDdTZ4U052QTlBT3VTOWJKVHo2RHJPaVVqdDcy?=
 =?utf-8?B?aWxvazNUUC9SUzZtU3Jwa1JURktOcS9LRjVud1BRcVEwclhaVFlHRTZ5Z3p5?=
 =?utf-8?B?R1JuZU5nKzZ3c3BveEVvMHFlck9nM2hNVU1FR0laWXROeU5TV0FtMEhmbzNs?=
 =?utf-8?B?WnZrTTVyN1NMSkl6L085ejJ4NXZGY0VnRFU3cENzbFVHazhwR2ttQm1qUklX?=
 =?utf-8?B?M0prbzQ1blBSRHFyTUg2YlBnVVZTQzdDUjdlckpMbHdLbXZFMm5SZTlway9l?=
 =?utf-8?Q?HTQjhaXsIe6I57ZH3mAZ33hN7x2p10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGg5WTB5eFBmWGdURUtJYWVEUS9lVlYyd3krYVpLbUR3dHNBQkdiZ21PVW9r?=
 =?utf-8?B?cmM1SHVEdVNCMjc1L3psYkxlaHVqdHE3SDhlaUhnWDNpcGNPa0xCMVFFaTBy?=
 =?utf-8?B?MC9ab1lzU2szbXIwT3YxdFJxSVp4R2tWYkpVNzgyREkyQ0lQZGVqaWw2ckli?=
 =?utf-8?B?SW5VS1ZPWU8wR1RvZGJmejJhL2ZPOFkxdC8rQ3RGbXhxNVVOSjVlSk13V1Vz?=
 =?utf-8?B?NVhIVHg1RXBsZk9vb0xGWTZib09kQlNhckJDNTlrSVh3RXFSc0g2REVOeGF4?=
 =?utf-8?B?YndTSTU2eWRhOGF0eHJYbkZWK01aYnU3bHV3YTZCNW1RVFU4dzljS1JKc0U4?=
 =?utf-8?B?Wng2dlJpU2ZMdUc1Z05mQ1ZWTW9uRHAzNWJSV0xES0ZLejY3T1haK0dKeWxx?=
 =?utf-8?B?QjZTSWhYTjkwM3drUmNGVkh6cTFjdEkyVkZkcmZTTk1QSmxLVnoyd05JVmY1?=
 =?utf-8?B?c2hXNENrbGJxY0hEakQveHZJUTVCZFV2aUI2SFZoTnRXNi9ZV2Rqb1lUZlRH?=
 =?utf-8?B?Ykx5R0kzWDdFVzlqdFVrOFl6cGcxL3RoQVRHc2J0SXVTUnFFaFFOZ2FMQ1hH?=
 =?utf-8?B?MklRKzFnTGNUdDFSOCtpVnJFenQ4UFNnc0NObEdkK3JGTHZrYk9YVm9GLzNs?=
 =?utf-8?B?V09OL1hBaUZ5NExmK2NMMVk3d2RrbDFRNzQ0eWhYVkFYeFUzampidFNuR3pu?=
 =?utf-8?B?aHNCTFpyMTFCZXZzazhkcmtMWis2MmppdWMwVWZZcmJKdlJHUVBScGhPOUxr?=
 =?utf-8?B?T0FSTUN3UmtDdzYzWG9Kc2JCL3MyYTkrY3hoRGhIeXRmTnBCVkpCZTBGUDRr?=
 =?utf-8?B?bDdjUmR6WGdpVkZ5cEpsVWtrMCtuZkloT3g5OFRwckY4QXJ6cktRa1AyK0dh?=
 =?utf-8?B?cE9YV2tvelVJNDhjdTRMNEtOcC9nVEk2anZNNUt4TXhnR0pOcU13KzI5TFJW?=
 =?utf-8?B?cVEzcG14elFEUFN0NzRBOSs0bTNHc3Q1WmpNNk91VFg2bFV0bmVxbC9YYURI?=
 =?utf-8?B?cnI2L3pyclNka1dwR2JGUmw2UW1tTTYwY1FEVEVUMVpFT3plb0xieFAzSU1W?=
 =?utf-8?B?aGtQenZQQW5rYlo3WGJrcFhhS09JUGxRZkpFY0NQUXArZFJ2OVRIUDNpUVhS?=
 =?utf-8?B?aVZKaWpEYXhJRi95Ui82a0pCWVh3cWR5MXFPbzlFNDBnVHA3VUFidSthakRL?=
 =?utf-8?B?YlhJY2ErNkFpSTZ5ZTJPVVN0TnFjRGI0Q0l1VmZuSGJTYTBBb1FIU0FNQkdR?=
 =?utf-8?B?akMvc3E1Znk4dGt2Z2U0SmpPcGRVQmxRcVhhWFVHdS9aWk1Kbi9QWEs1VnFI?=
 =?utf-8?B?ZEFtMlozanRwTS8wVXR5WXRhdlJ4eEpHTit5Z0tVYVd4TVExbmprQ3dGWVZ3?=
 =?utf-8?B?REI4ekJuZFluNy9iTlBHR3ZxdmFpczBXcVMxUXByUFgwSDE3S2NGY3dUR2pI?=
 =?utf-8?B?a3NUUWlHSEpTWS9yaXYzU21rYUkzMHpkYy9CMmp5eVd3cVNBd3dVVlZqNCtv?=
 =?utf-8?B?WnYvYnZlR2xJcVNobUFBU01OaWJPVzVSRFhhbW5VMTNhOUQyZ3JKNFlJMTQv?=
 =?utf-8?B?Q2lDUEM3WHBzSUM5K1pPVWt3VjQrV1VRQ0NHVjJZbEs3TllHbk9LTjdDblZs?=
 =?utf-8?B?WFZybEVTYU9QK1dXMUNIYTlGTzNxSVo3dDRpM2Y2RW4wWnMzTU55REl0c3k0?=
 =?utf-8?B?L3FxYjR1RzdjUkU1YWFnSVVzVUNqTFMvY2hiTU1xY0RTNUNKc256ZUd0RTVq?=
 =?utf-8?B?RXRMcU85Z25MMEVpQ0pYZkVSOEovVDU3aDJvOXJqbjQyOEZ0d3FKTzhKZHBx?=
 =?utf-8?B?d1ZiWFlzL0l1S0RieWI2bWozTDFwOXhydGdkRGFLYTdlQXc0TE1ZSmtwbG9B?=
 =?utf-8?B?S0JzVUd5UnE0VlhsWUxFN0ExQUxNN0NhUWZlTFN2NjJmWmxqQlBpTFphYnAx?=
 =?utf-8?B?RWk1dm45WFFxLzY2b0c3cVhXTmVJL1FUSWsrT3BUR2YwbHBOYXdvd2NZTTRH?=
 =?utf-8?B?dFd5ODBsZHpQREltN3VXNjFkRzBsUkFJU0xRYnJlblZTVjc3RE9WSitPR083?=
 =?utf-8?B?SitTbnZPQzBSR3hnU0ZZVERsdWtGVHY0RUJ2M0dvSGlzSnFFa0oxYmwzUGtQ?=
 =?utf-8?Q?3CJeHuMcOiFL9v6aL9DKTMf2r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b47c0e-cdde-4b8b-5a0b-08dde3b2a0a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:37:29.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3TQgkFUQOk6+Dd1/2LbI8Y7J8qn6jsooYvmpb1EfRd7CC3umHWlkMi3d0yOQL7fTlu8ABtUCheFsSdErtc1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

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


