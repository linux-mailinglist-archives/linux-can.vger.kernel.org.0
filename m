Return-Path: <linux-can+bounces-5080-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB1BB0798
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116994C20EA
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355852F0688;
	Wed,  1 Oct 2025 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaG8LuBX"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9B2EFDAF;
	Wed,  1 Oct 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324982; cv=fail; b=gmJBz0vLwdNBm1KqAyNfjmmU0872TD82aAKyHTMhhUDZ9ffVCpL0IXT7oS8DAyCycOPf7oXSufQPXBu2XUclA93eIDqNsIc3qW145elxS5h2w7yMbdGhZCTVY4mEUBXDOrb5XsMV31zSjBgAU9iDaFJCYV7WqWvOwAP/DzbD2fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324982; c=relaxed/simple;
	bh=gdJasKzZxOGY4tphDV5yDp1k8JXWI4Ixs8C6ID3c3uU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lGYnKc8EBsRpNC0an/d6G7KzdhZbiIHBqoHUvlhfnEKNgMhk1kFCbAlYl37XFJGo1ePagY5kYRA5/QRv1rUxUaj7PeGya0rcb85iM3ej6KItFzZ7fclDrg30r3HSmNvUBflaPwCS7C3oFtOUuIprB3XXJWXpjngMQYcduaI8VOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JaG8LuBX; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndRRk3+0tihBukC3FusuLPwqTuVFTUSYBHJrk1lHgKUgxwtN7NEQZqM441nVJ+B2lJviqt6PiiMf96BX+UZNr7b+WICHN2h6yednBHZvrZzQBugTsVqA04JRhoy21UA5xIvBAKXmid27/BzKdjYda0DeRn7VWQCsKeDJM5+afba5PBFLOd7ZLzNqSjJMOlg1ux8nM49aTiD58cCCt0zBCQ4Yt1ZLc+YKisY20IYE0HLDfyMS9Cut6WGaqus+x4UYJpDRWOuAHw+bu7MIp5KtwFYfPEkoqzCBm8YuBBUns343DCwKtpS61fjKGrD7FVPwyKUBo0d0QkhOZOLtY6NVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrGxr47GkXVFlJZ19qRvgVSN6QtaK4WS1dZQeeGysDE=;
 b=sSeDXhPieslYbWGMntWYr1c+txoys2vfj1bDifQUtxqJy94fEj0HheCcHnQ+2wUnSJllqg71C+Pmo0fvLf75Gx9BMyKMC5KnSWlAten8a84cnuDV98MknwZtsUTPmo2nypNANFLx65xyiuzNC3ddVuk1w/5HD+roFeGvPSziGYJgoZ3BnOF9NE31h6Y/ken6nLVVdX6VB5d41p/fIMOGAcpNzJ7CiaAggoYaLDzfUasQDoLq53Z9OThCR/V4gmD17cAj69eJIFDeJuBDG3+PjFxBpnYi4Y46HCPyn9IE4SAU3bWMbaJi0HZUPqXx23de8IkKflvM83dCLLx26jUqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrGxr47GkXVFlJZ19qRvgVSN6QtaK4WS1dZQeeGysDE=;
 b=JaG8LuBXhy9jzaAVBXZncu5333qlCxnFOPMlts7zO9srcOlBZSzkLDfyE61oZ9jeIua5cdMr5wh4qyIT/2K/TPpaoYXDrHPS+yisOF0en+SwZpfQbDmT5GRCaTKILlwftHRIqayOE9VWMl0v92jR7Dy+aC/MhyGivmdYbOUk2tVWJMgyBVLBgn4kCbppVAlCUO9x7mN+e/bPEvnMSFFkanbaI31bGBQTzpFnirpiLCslGRmpCOXXnI578EKdavOlwejUqrDh2fF7ispxkEKyF72pd/A4k+phsUnb0NQt2qoSQqnJ3K+NcBlQRyJ7LK1l0RVOeGZszdh5xlde+DOZNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Wed, 1 Oct
 2025 13:22:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9182.013; Wed, 1 Oct 2025
 13:22:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v7 0/8] phy: phy-can-transceiver: Support TJA1048/TJA1051
Date: Wed, 01 Oct 2025 21:22:31 +0800
Message-Id: <20251001-can-v7-0-fad29efc3884@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABcr3WgC/23PwW6DMAwG4Fepch5T4sSE9LT3qHZIHGfNYVDBh
 FpVvPtCQQOkHR393x/7KQbuMw/ifHqKnsc85K4tg307Cbr69ourHMssQALKBlRFvq2o0UDBJKl
 Bi5K89Zzy/dVy+SzzNQ8/Xf94lY5qfj36UVWyCga9VwrJxvDR3m/v1H3PZWsStiRJi8lK8JH9X
 3L+Z4R9Ny4CZmFqxS5RIGWOQu+FW4QuQgdI2khnErqjMJtwct3fFMEGAiYGSo6PAvdCLwKLiAk
 tsPag/rnYSbMlQcdGgQvIGI/d9b573b8uQhFpaRUCGNrENE2/jv6OzuIBAAA=
X-Change-ID: 20250821-can-c832cb4f0323
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
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
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759324965; l=3925;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gdJasKzZxOGY4tphDV5yDp1k8JXWI4Ixs8C6ID3c3uU=;
 b=lH8QYSUm0fXYD9rAY/ZqROi7RpA4giLhpG+Zj6a8NTbF+i3kS0qEFzDqVI3UafCobDpaQvSaA
 wLXUELOcMrZA2I5GjD0XwZcZcweAD4cIL98iigaFRk6Me0O9r3V3QMe
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: faadc9c1-a13d-4023-f786-08de00eda0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUNMRk5NSTZhZHVBQzJXVDJ5TG43SkJXRmpqY2U3ZFJEZGF2cGlweXRVZFhW?=
 =?utf-8?B?OStDbXdZTU0wNzhqY3NRNDVMZmh3ZkpxbWFjMzVxcWRCZ2I0NDNtWU8rU0o1?=
 =?utf-8?B?cmtxbUs5L1FpN1d5VmRoWUxHK0F4S21kOEFvSlN0dWhUbm5CRFJ5dHN2cSth?=
 =?utf-8?B?d3pNTFg5ZW9PREhSNTF4MEZ1Ym4vTWhNWUdkOGNuclVFRzlxSFVqNmYrUjZh?=
 =?utf-8?B?d2gvMzQyY0VURk9kT2tkSzRZRVpmUEpta0ZJUXpISTJZUkc0dkl4SFRYczls?=
 =?utf-8?B?eHA4NUg4WFphVWxVRm5QQ0xNVnVZZUxiaUpVaDRYa093R2l3UmVqUU9EUldy?=
 =?utf-8?B?WWhoRitvTTJoL1NtQzBtNmgzanlIendlQStqdWVvTkE0OXA5TG9Cc05PSFlN?=
 =?utf-8?B?ZWc4NTFOaFNEdk9Ra245d1lRVkdQV1F4U0FlYUhGanJHTHdmb011VWh6bVQw?=
 =?utf-8?B?amVFa0J0QWIvOWkxZGd5R1pQYjF1WktLUjJ5bTk5ZkRzRGZLeVcwUi8vVk1N?=
 =?utf-8?B?SzNXM3l3YjFMVHNzOFB3aTU5OUlHelFrRFRpUTJNSURFZkxYNXVYTUZybldF?=
 =?utf-8?B?b3RMZXI1N1B2MlFyQmZOR1dZY3M2WjNmb0dYV1hlR1QxVlNPMndZSmFvVEda?=
 =?utf-8?B?cTl3QldGQ2N3RGRmYzZNWGp6TUFNQlppWUd3QVREb1B2VTY4eWgra2Y1b3A5?=
 =?utf-8?B?d01ncmJsZ3VBMUEwZE5QYTRlZDhqVWtBZS9Edko2NDNzNVVvN0N2ejFKbVhl?=
 =?utf-8?B?VkhUY0ErZHUvSFlzRmpENHV5OThPdDBhUGJuTW5JeHNxU3JQczlkRjZUNkhm?=
 =?utf-8?B?UlRKT3VyTDd3ZXgzSlhoZ2pVOStsTjRITHh1cGxpejE5V3NaUUdrQ2UzL2RO?=
 =?utf-8?B?N3NQUGJHRmkrcEtvNWd5SWRqQjRsaGxLMm8zUmZOck5qRDVSMDl5aVZyK2FO?=
 =?utf-8?B?UHExTTRQc1ZSVWtjdDFZV2lOMTFhRjZvYVp2T0RlekVIYkdQRHRVY1NMUGVY?=
 =?utf-8?B?bzRBVnhIUWhENDczczdjRHZtRFBOWlhmdlM5d1FYSForclV0WnlmejFXdlQz?=
 =?utf-8?B?MXQ3YWNEOHhUZ3EwU3hlOENqOTlGMXBqdGhuSVE4K0hkYWRWUmpPbjArZ2R2?=
 =?utf-8?B?c1RnUTNaU25YcnNodmVib2NGTnU1MW9TY3BoUDByY0FxYzRlWWRUM0U5d0pi?=
 =?utf-8?B?Wnp5MGZQc2ZRb3lrSGpnRlpqTGN2eEJQSEd0ckordXo4Zm00YVlsZDdxakhB?=
 =?utf-8?B?QVlyVlVLV1gwT0c0N2UxUldtQjhkSm1ya1pwTXVNR1dGdDZKQTVYYjk4RUxx?=
 =?utf-8?B?ZjhiMXRQNVpvakRGRGVuSDJDcmdLR3lFYjhBZnVNay8wdHJFZWNhOVQ1NUdC?=
 =?utf-8?B?R01GcWI0VzN3bUhEc1drQ0pwNU9rbzBjTzl3NzYrclRYVnJFTVlCUXlTeHla?=
 =?utf-8?B?aFJIWlFreTBweFV5N2Npa1lDbW5kQkVBQ0taampsdzczNTdzS3FtOFhQVFVm?=
 =?utf-8?B?akJKYWVTTEUyaTdpT0NzZHMzanRJM1RpMnEyMjdIODYwRkxaOTExbDU4MXlJ?=
 =?utf-8?B?K1lnUXg4SGJnS3R1S2dsTmtBRU5UUW53OWVpNy95dWtlRVNCZlYvdGZPdFhV?=
 =?utf-8?B?NU9kS0l6YUd6cG9SSjAvSW4zc3p3bVNwYkFYRDZudEJQK0l0VGFUTDFJMjFN?=
 =?utf-8?B?NWtsc2hTMldPM3o5T3RSY0dVTGEraXVlclFjMkpHck0zb3gwUWMrM1lvdjR1?=
 =?utf-8?B?K3lzV1p0dmQ1MEl1KzU2Y2g4WFRINGlJRC8yT1VOaEVJa0R1UUlRcWlEWTVY?=
 =?utf-8?B?YU9pV2QzUVJjbjZMNGdBcFErYldKeUs5VmJZSFNWaXU4VFR3c0V1MXBDeEds?=
 =?utf-8?B?ZFhqR2RxZUh5YUJYSzB6bzl0M3BCSE9QdC8yVkpWVzAyb1JwRmdVQzl0L2lD?=
 =?utf-8?B?Z3BrSUNKdjBNTFp6WTg0Z0JYaXpzT245K2hEbjJxNVdFdTdocXFYSWtPQzBB?=
 =?utf-8?B?TXhXcFNXaWlSeTNVS0s0dTdwbGFaRkM0L3ZUcDlPZXBXeWdic3lIZUZhb0t1?=
 =?utf-8?B?a3k0YXVqQnhSMUNmbSsyc3dnbHVGa2pTSWpmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk5BOHQrZGZicDdvZW9YMWlUVVV5aHN5SFR5Y2FDUXhLN05nOTB3TDNOUVQw?=
 =?utf-8?B?TUQwaXZJWFRkb2ZMRitGZjc0S2swMTBHM2g5dGJGaGI4ZzFJZGtUTloxNDdG?=
 =?utf-8?B?alM4TXRLcDhiQVNmRzI3NHhOdmRrb2VOT3UvQTJxOFd2bU4yQTJmdUZyRThQ?=
 =?utf-8?B?UHVKTDE3R1UwdmllOU9tVDc4UnVIMitaa0tUYjJDbnNvYlRVaTM4bzBMU1dO?=
 =?utf-8?B?UjFjdTZueklLaVlPNGJsZlMyM3V2bm15Yk5xbzY2OE9nQWQzS0NTWERpYmhn?=
 =?utf-8?B?R2pUdXdOUlpRZ2VVaDhFNWhhWVhyWUljcG9NWHdyMWxQVEFlQzR3MDBFbzhx?=
 =?utf-8?B?bzdTODdqRlhoM2JOS28wd293ajRWUGRVRFVLYzU2WVM2OUNzUXRMU1Z5aEZX?=
 =?utf-8?B?Um9MbEFHcXpzQ0ZmZzBQbDhrbGF1SXJObENyaktWMnlnTEJkekRka1FuSFl0?=
 =?utf-8?B?QXN0MmNjbmh5d09Ua3VVUVllVGNDd3E1VkxrNHJUeVFITDc2WXJHb1N6R0Rk?=
 =?utf-8?B?MDN6OU8zZ3ZZem5VOXpEREJZK24rT0pNMHpMOUU3TXFQckNsL21Fd3FEaUEv?=
 =?utf-8?B?azZhTU9pYlpNTFhGU0RaL21XMDZhV3owM0tuUXZrSkNEbjhnaWVVOHR1S21z?=
 =?utf-8?B?Y25iNlRsaGwxek1pQm1OenVEaXRFRUY1QWl6QlRXdEwwY2hsVjQ0dGpoa01a?=
 =?utf-8?B?a0cxQjNxVEdIODdBUkdEbTlYNDFjZFZ6YTdiamwvNDY2UHJzM21GeWRJK3V4?=
 =?utf-8?B?ME1NVVZ5d2hGeFpYZ01YblRpYnFPeEEvUnV2Q1lnd0ZUQ3pRRUV4WWFBTnBn?=
 =?utf-8?B?RzRlblhKaEk3NkFudVBZK2hMb213dFJLN3dkUkc3R3pJVStINytwMDBxNVRH?=
 =?utf-8?B?RTBXTGpMbWhQcjZleGVZNjNVci8wMk54WVFOOHFjV2U5ejhacHVXWm5kZ1hL?=
 =?utf-8?B?d3Z3UVJ1dWZQNklWZlEwelJ3SEtURXJ5b1RsVWFMRk92VVZrQm1lK0N1MmMx?=
 =?utf-8?B?Z0VvU3JROEZaVndUM3lFWGxKRk14VUVwZmdrL3hHVlNxcWxsRGpnQXVDOUJQ?=
 =?utf-8?B?R1ZMVnNidXo2ZjNQOHpJVWdxQ2xWbU9ma3JaNFRPNU9qOGRhR3FRaFV2NEVz?=
 =?utf-8?B?MUR0MXVMZGtsRmYrNjBWK1pyK3RkMUNscWJYcTZramNDQkc5SUNweTc3S3BR?=
 =?utf-8?B?WTcydllFVjB3YWZsdllrK0dTUWx5L2RBQUxaK3FZN01RNXVScWlBTzU0Mity?=
 =?utf-8?B?Y2E0S1FTc3BWNGdBVHcvckpWbnFiZm9SSlJibndnM1phaS9pS3ZvSDhLc3lM?=
 =?utf-8?B?aW5XN1ZRMDhZTDFLSlR3SHRSS3ZsSTZ0M2hJK3pkTFlwcXFyeFJQbkZhRjV2?=
 =?utf-8?B?S05XWERTeE1OeEVscmR6TFhXVHVTdW1aaERCbHlEczhjMWxFMkFhWkhBY25I?=
 =?utf-8?B?UDg2WjI5dUk1cFc5ZTFsWTlpQ2tSMUxhWmVobTlVcUhqbnlYTjVGMjBDRGxq?=
 =?utf-8?B?b0ZHejk4QWJjblZtUllSVWZBMVBUbllTQ3NtL2NKbEVCZzQ0Z1BkeVNzT0xu?=
 =?utf-8?B?UzR0N1pEUVpvWGYvRDlwQ0IxVXlHWXpOUE1uUUMvQzdvK05wNTJuYzVtLzl4?=
 =?utf-8?B?ZXkrNHl3Ulc5a2ZmOGZMVlNhaFREWVJHN2llRFJaQWM5dWdFbGptR21MK3hx?=
 =?utf-8?B?eTdJTUlYL25UMEtnUk02eDhyd3ZxOUpPSHNuSjVWemIwTURyTFlCUFBqZzJ3?=
 =?utf-8?B?UGhadnB3bnVvTHhkbzNoUldqcVJORmNOWGJXSlBvUHlHdm80b3RVR1dkcXpY?=
 =?utf-8?B?ekppQ0ZUSXRrRGRnbFJSMkltU0M0UWh3eGE1Q1JnZDdxcUdibmpheG5wTlFp?=
 =?utf-8?B?Tlk5RzQ2MVRwWERzVit1L0NxREM2bWRLNC9GS01wZjVJMFBvQkppU2wxYlhE?=
 =?utf-8?B?U2RKMDdpeEh2amJoL3NQQXNWK1lqODhkbGdxNE5iN2lVWmpJTGxGeXMxSXBQ?=
 =?utf-8?B?TndXWWhackUyaGQwQy9IMXA4N3NkaGNUWnBzK05IbkpuTWs0MXhuQ1dQeEJ5?=
 =?utf-8?B?TjdTN0VuUWMrY2pmLzZQbG1ZQ2UzM2xERVhvcFhwTmczZDV4dXhkb00rK2tv?=
 =?utf-8?Q?CoVC/h0QDEfv0KJTgnMp+K6os?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faadc9c1-a13d-4023-f786-08de00eda0d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 13:22:54.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YuRMpNCBqyXqIvUPVU6ZVTqMak4EBceXAecXa43oaJwwzIzGl6exHqcENLW/Uvcy0KevX8UEMOB7w7+CifvYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

TJA1048 is a Dual channel can transceiver with Sleep mode supported.
TJA105{1,7} is a Single Channel can transceiver with Sleep mode supported.

To support them:
patch 1: add binding doc
patch 2/3: To support dual channel,
   - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
     has two channels.
   - Introduce can_transceiver_priv as a higher level encapsulation for
     phy, mux_state, num_ch.
   - Alloc a phy for each channel
patch 4: Simplify code
patch 5: Add TJA1051,7 support
Others: Update dts to use phys.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v7:
  Since got v6 comments from Marc and Vincent, I was busy on other
  stuff, so delay about one week to move to v7.
- Patch 1: Add R-b from Rob for dt-bindings
- For Patch 2,3: Switch to use flexible array for "struct can_transceiver_phy"
  per Marc. Use a local variable to avoid multiple pointer based access per
  Vincent. For mux_state I still keep it as phy chip level, so it is still
  in "struct can_transceiver_priv" as previous patch, so no array needed.
- Drop patch 5 which was to check gpio API return value. Since no issue
  reported, and error return value check here will make code looks ugly,
  I not find an elegant way to do this, so drop the patch for now.
  We may add it back in future
- Link to v6: https://lore.kernel.org/r/20250909-can-v6-0-1cc30715224c@nxp.com

Changes in v6:
- Update dt-bindings per Krzysztof's comments
  "define if:then:, without any else:, for each variant"
- Add R-b from Frank
- Link to v5: https://lore.kernel.org/r/20250904-can-v5-0-23d8129b5e5d@nxp.com

Changes in v5:
- Update patch 1 dt-bindings for TJA1051 and TJA1057 and allOf entries
  for them, per Conor's comments. Thanks Conor for detailed review on
  the dt-binding patch.
- Add two new patches patch {3,4} to simplify code and check return value of
  gpiod API.
- Add patch 6 because TJA1051 and TJA1057 use their own compatible strings
- Link to v4: https://lore.kernel.org/r/20250901-can-v4-0-e42b5fe2cf9e@nxp.com

Changes in v4:
- Add R-b from Frank for patch 1, 2, 3, 6
- Address the minor comments from Frank regarding min/maxItems, commit
  log
- Link to v3: https://lore.kernel.org/r/20250829-can-v3-0-3b2f34094f59@nxp.com

Changes in v3:
- Patch 1: Add TJA1057, update #phy-cells
- Patch 2,3: Separate patch 2 into two patches per Frank, 1st introduce
  can_transceiver_priv, 2nd support dual chan by adding num_ch
- Patch 6: Change to 5Mbps rate
- Patch 4,5: Add R-b from Frank
- Link to v2: https://lore.kernel.org/r/20250825-can-v2-0-c461e9fcbc14@nxp.com

Changes in v2:
- Update standby-gpios constraints per Conor's comments
- Drop patch 2 which is not needed.
- Link to v1: https://lore.kernel.org/r/20250822-can-v1-0-c075f702adea@nxp.com

---
Peng Fan (8):
      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
      phy: phy-can-transceiver: Introduce can_transceiver_priv
      phy: phy-can-transceiver: Add dual channel support for TJA1048
      phy: phy-can-transceiver: Drop the gpio desc check
      phy: phy-can-transceiver: Add support for TJA105{1,7}
      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  69 ++++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  43 ++----
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  17 ++-
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts  |  13 +-
 drivers/phy/phy-can-transceiver.c                  | 158 +++++++++++++++------
 5 files changed, 210 insertions(+), 90 deletions(-)
---
base-commit: 92d0924341d014dd4cc07720916ba4ee317aabb1
change-id: 20250821-can-c832cb4f0323

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


