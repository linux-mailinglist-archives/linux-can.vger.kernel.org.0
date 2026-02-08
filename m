Return-Path: <linux-can+bounces-6509-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGO/HWquiGkSuQQAu9opvQ
	(envelope-from <linux-can+bounces-6509-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:40:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E993A1093FD
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3B630166F4
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E8366804;
	Sun,  8 Feb 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="f67Cm459";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="f67Cm459"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022132.outbound.protection.outlook.com [52.101.66.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A433364EB6;
	Sun,  8 Feb 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.132
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565175; cv=fail; b=LjKxInlZdgoWTBpSh1ymGWcrY+qjUODAdURekRSQTzgkQNMeQtL3AyH9KmVrtnHtjEISwoiHkizXMn5Lx5oONqTIMexEtwK3JERnn8A6l/zHBkwBR8lIvgdzrDImBGQHVXkt12fDExHOKI40e0+78wS7Cr3EQshyHg+zKiZt8Jo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565175; c=relaxed/simple;
	bh=+QJRxh/jf68BWweDPZK8mn8LB78n+Nkn6YVbKutmNOw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fLkfZqFgOkMq5MGTSZrMw2h7YD34SxADKCSYUaHM0qunHpzUaGu9Rf2ra3kKtvSygxmveaVYiWyDABk02lAaOUVZD83jefFwvcbTjFKhcQ2xuzgZPLhLAySCPdspbi+6nEvLwMKA5Z0awevDLoAmKRRFYqFsxxIs06kqjUxAUh8=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=f67Cm459; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=f67Cm459; arc=fail smtp.client-ip=52.101.66.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UAEjXDPKKYfh/OcDCcgIMq36l+x0nRpPMlVZYCLUEqRG54XfBzJmZ9jXmKTKF80tiDlkby8zqZKm0lcVE366htOjGEvkMYv2+DF4CGk6dUvTINEuWPVL9VQoA1zSJydr4/l/JLZ/zn8IvZeu8DM02gK4e3aE2VXaoJnzDJTCWTGus2Irk/Ug5V3fl3uYlcwPBJPIQhtnKbnSxsu6x63TT2uGy5HIIJqjGAZpmngB1VxoUgE/vHb6v5QxoIg5QEt2Yeiw4MRUj66PTo9xnzGrf8e50M1rjT7PuT/mYkPMoTKWjRayhKgnS7TuKTYo+M6Hdy7hjDbr1QYKJgPb+7IKtw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx48bJKtqorCYfNGzyYJyHORmEWeQdhXDHG15H8dsqc=;
 b=rJeRpmywcl5XBEZc4jAetMP3xeILA0ZFM8A4GiiqYtQZjsS/Q8Gnq5WbDqlxxZXtfdNFh7MYpTw1+i9+upwiw1FXJClxs5iUEf/qiO1PexqnJX8UoNemNH9BCulDODJXd9yxlwyY2OzebIviNedYcHolstlj5YWte02UKj52aUoH26Y+FG0k/DtwtNfMyCqsvW4jyGyS53QxcqFZ3xPU6C64v4BhUqHhddIkcISYDndP1qjxtxVs8x4q+8rEu7Z5Gerq3H1OAPEK6l91lPznLYCk/KC0gkb9sXFbNmkOHnWJM9bD6Oh8hUsG1Ln3FHFONmNDZL8Tx/s6B+OsH9zBfg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx48bJKtqorCYfNGzyYJyHORmEWeQdhXDHG15H8dsqc=;
 b=f67Cm459JNbRqbTeodoESARs5/uT3xVm5aKUkhnsMpYcRMgXl4QgYW7/5VW8DOzQaMx4Dk+zOrONWhmRRLPA+1FPNHE1MjWDbWtrJA+ENPCj06FgQ1RcYwI/4kxQRtITPPnunwgESdV2D40CzdGTpMGUBDiCuCf9ty+0ahmDknE=
Received: from DU2PR04CA0278.eurprd04.prod.outlook.com (2603:10a6:10:28c::13)
 by AMBPR04MB12243.eurprd04.prod.outlook.com (2603:10a6:20b:722::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 15:39:30 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::75) by DU2PR04CA0278.outlook.office365.com
 (2603:10a6:10:28c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sun,
 8 Feb 2026 15:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:29 +0000
Received: from emails-7798774-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-47.eu-west-1.compute.internal [10.20.5.47])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id BB8FE7FF5E;
	Sun,  8 Feb 2026 15:39:29 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565169; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=vx48bJKtqorCYfNGzyYJyHORmEWeQdhXDHG15H8dsqc=;
 b=V9EctlLThJ8Fh4TlwGm1dD+I3rcunVKrXd9oJt+YUENoa79+fF4JQznRue9LC4vQxaZYG
 5AaJ4c63ElG/OKaAgCVhzTd9+12VxjXn7nvC9/RYcrZHNYG7MuAfre7eAFEZM66xv2bBS+a
 iwtNqCDqVt1I1KeVCj5pvW+ekIXcmBM=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565169;
 b=oxi2y+Xycdf+gwkFF0KhHD9y8ua6f8n62LZ904b4yWz5K+S3Fk3y/MizxQnttpeTkpkT6
 CmVUAs0Nam65pp6M5zxrbZtOlS51dFfNJ3CpC7H7nQPw+uvJ/r88wEvpMYaIWdYG0AgM1r6
 WqtSc35H/aOkamOEBMt/bFMlVj54y5o=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAXuGoaqhc1rYCDcpH8qg9U+YYoo+O1rAzry91UTnQvorwF3LMG1hBS8Qt+lpsOiuhZC1VA0JnM5V5gpsQ8po//lH0dubbM7GCyYtdgp/UfUl1CQSALDXWtJFxzt7bUfe8VkVAdP0xd0HyBAJDyBr6pL6yjZXhbf4lBK4lFPJbT06YV0IFpJnvdh06y1qLQIz4GV4v8Of5cn0/DPaS+a1C7wLz4jm6u16sBMXCmUUVAfXnoSspCjDhQxjkNjnvg7H8LMT4TOmSsrHjuPJfeBzBeFUiacJ9zaAxUJvLNZv6bGUr3w9C8wRpbUDAgqnKSdIQQfz5lFTkGCAqDwggVz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx48bJKtqorCYfNGzyYJyHORmEWeQdhXDHG15H8dsqc=;
 b=S1QkF025gZT+LgfiEHh79G3cP1KYccroOdsHdhakYQ/+WmWlDZD5RH7UYL2TsBKCML2tm47yLLuDhl9AgH7t40ZAn+RKlLNNAndNLOe3/xsiVpLojsLQqM4qml7qlOJ6DKyc/zIygMaxDNTliqelu1w3tZAss+eK7S1JsrTJtjwY2RuJKYlTfmiv9pRV/DmQFxd2fn1C1+GInq8BFjn0zbHVeyafzT6zbKC9+tEElkoo1tazKFyJdr++qkqyRiZ50J/MFLr+Y8bbqN+8OixVJY7o/6AaEfybflnfHGxtNx/a61XN3+vxTAB9bCXfAPUJFiUuYxpjy3PUZzybF/oI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx48bJKtqorCYfNGzyYJyHORmEWeQdhXDHG15H8dsqc=;
 b=f67Cm459JNbRqbTeodoESARs5/uT3xVm5aKUkhnsMpYcRMgXl4QgYW7/5VW8DOzQaMx4Dk+zOrONWhmRRLPA+1FPNHE1MjWDbWtrJA+ENPCj06FgQ1RcYwI/4kxQRtITPPnunwgESdV2D40CzdGTpMGUBDiCuCf9ty+0ahmDknE=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:20 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:39:02 +0200
Subject: [PATCH v9 7/7] mmc: host: renesas_sdhi_core: support selecting an
 optional mux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-7-9a3be13c1280@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|DB1PEPF0003922D:EE_|AMBPR04MB12243:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f42c327-5bd3-4dc2-3668-08de67283fc9
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dlI2RXVrUTd3ak90T2pkNUlRUVRPbCtVWkdXYWVBa05EanBpUUxnaEs1YUh3?=
 =?utf-8?B?TVRBSTQ0dnRaZ1dsTjl0QmdKaXlQSTZYR01ielNScm1CcU9vbVVlZzBZSFBn?=
 =?utf-8?B?MGJpMmVXeGNuYUxuT1U1K0x0NnBKdHd1ZXZaR2JlODhTdWQzdjFNdHpRQmR3?=
 =?utf-8?B?SjRkMDVWeFRqcGdGZzdNQUttd1lLZm5wQmtnWG1sc2RzaG8wVm1TTlp4MGFW?=
 =?utf-8?B?VkZHODREbFMxQXB5b00rSUFDeEpJbndMMDhKWHl2SDdiLzdoRVdsTDdXQmhv?=
 =?utf-8?B?UkJjYndGak0rZmk0Z0RHREZ0U1MxZGVQbFM5ZXR5V2JrQjljWWpkaWVNaWRq?=
 =?utf-8?B?Y01JVWZrOXpvRWM3dEpqVjEwRWI5SUVJWXRnTGNJME1UVjJTVmVLRGV3d2hU?=
 =?utf-8?B?b0dZRUM0MlJ4OVBRbzFmcEZ5NjJQc0oyYVY3a295SnBFMmkzZmt5dzhUSWo1?=
 =?utf-8?B?OStEZlJFSDlVVWNjUXltQjFaRVlTKzRJRmtxNVZISTBtR2JjajVYUVdrN0Zi?=
 =?utf-8?B?eS9DSjRzbS9yV21abnJTMlNET0IrQW1PbVJyaGtlZGxWRWNrYTBaekNsWklu?=
 =?utf-8?B?U1gvQk9ZNGtqZGoxMGQ0RVpVREtzUmtob2Vyb3pNeWx3YlREWGtRcTV5VHhI?=
 =?utf-8?B?NmNrYVBIakIwbFlkaUd3dUJNR1RVWFY0MmNtSDRWYkU5aW9BYmkrSjdOVU9U?=
 =?utf-8?B?YWptaXZhODhFaDdLVVFJOHBidFFDaUxFVkg5RzUzakFoeGVwcTJvSzI0cllL?=
 =?utf-8?B?QXo3SzRmRnY3QllrN25IRElrdjNtKzZqSXc2RFV6RGFTMUFkWU95M1V5Q3Jz?=
 =?utf-8?B?QldoSDkwUFBVWWlmcEJVcGMzYmkvV1N6MVBndVhVTWo3M1Z5MDNqK3FzTXNl?=
 =?utf-8?B?V2FFQ0RwTjdwMGhKR2pTVzkxS2JLNUFsR1Q1M1NoS0pGTFh4UTZpTlp2dFdm?=
 =?utf-8?B?R0hQM1NTamE2QTlwcC9Qb2dYZVFud1cvTGw5M01RRjFkSE9XTEo4aWtMV0dj?=
 =?utf-8?B?TnlvVkhobUZuVlhkVkw2NUcrRDV4VUJTL2FvYWxYMnFkVGhodWdzYXd4RlZX?=
 =?utf-8?B?WnRQaWRzaTJIS0pKRnhGdlNOK3FDUDhOenRNQkNWbDB1VWV4L0ZlVVdkeDkr?=
 =?utf-8?B?QmJPOTArS3hVZGg5Rm5oUVVINktIdnBscG00dS94WXo0WXFGVDc3b1RoalFG?=
 =?utf-8?B?bG4vbmJRZ0VUWjdNR25xN2pmb25WcW0yMXZmbzlvSTdKd3BpcHI2amlZV2dQ?=
 =?utf-8?B?ekQvV2JnNE42Nldib0lzK3V5ZUJhc2crblBRNUNVaEh1VTZHZFRHU2NhL3ZK?=
 =?utf-8?B?ZkY3RDJQRHJnaU1LVXBDS1locnpCcXhiU2Y2N3M2dEQ4cTNoTUMrU1ZzT3ZF?=
 =?utf-8?B?L0xnODhUeXUxTFdyaGR3KzBzN1llMi9yQ1RTblFIVHFWb013ZG0wSVZjSXI4?=
 =?utf-8?B?RFJoTFhjdGV0Vk9iNnN0SDlOT3o4NkpOT0RaSlJyZUEzZ3NIU0tpZ3QyTnQ1?=
 =?utf-8?B?ZGtBeUxIaHdEblE2VEFDNVJkQ1dHUHF4bEFTMWpXN0NPUDZyeE1VaXNkS1BJ?=
 =?utf-8?B?Z1NKTzhRbDk1Y2pTQzVIL1hLTWhZK3lJanhzODlkN29DTnhnd2JtOWVuMHV2?=
 =?utf-8?B?UkI3M3pabDJubjNGcGZoai9QTDZkZGt6YnVUVnNJU1hSenZzSksxQUlTSFN3?=
 =?utf-8?B?R0F1aDBlM1hMUS85eU9wOWFaUnJCOVI2SDhUS1F6TVVqSURjY3NzRWV4ZlJm?=
 =?utf-8?B?UXQ5NGFxU0hxa1ZQRW16WGFlUUR1UzR4bW9rdHZDUjloaEhaYkFiUlZOdC9q?=
 =?utf-8?B?L1RrV3oycDd2dlRKWVZXQnY4NHRPR2hnNkNIMWpRaXBEbmczeU9VbkNNY0ZS?=
 =?utf-8?B?aWpHNnNsMGNSYndFTGM1aHBKS1EycjZpOWt1T3BPL0VhWXh6aVZjajVCRzBP?=
 =?utf-8?B?am5UVlVUdlZ4M0RZUXlnSUlFZ25KT29lTThlTnpmKzhIZ0Uvajd5VmxaeERG?=
 =?utf-8?B?MlNYYndwYnBoQklKek14dXNJbjVSTUlKd2RDTm9CQ2loK0tudzlURk5ac0o0?=
 =?utf-8?B?dHVyR1N6eTNZeWdQVmg4QnN4ZEE4UjNpWmx4R2tnOXFWZG9NS2ZPOGplZk1w?=
 =?utf-8?B?bFE3elhCMlRicHlsMlgwYjVjSEFjV2hpMG53T0gwSzArelRVbXpzckw5b0k5?=
 =?utf-8?Q?XbVB+rQheg2cjfSYGdi65VJ4tr7eqDW2npZ9EMYqUyns?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 611ddf51fb7f46b4a3727cdb0646c506:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	81ba43bd-68dd-442d-637c-08de67283a20
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|35042699022|7416014|36860700013|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm1WQ3FuUERhWG1qTzNwUHhCQ3dSV3FKTExTQjZZNHlVTEFvaHZKWW8rK3pt?=
 =?utf-8?B?Z3ZRQ1VKQWVHSTJaZTFnN2NpcHZ0VW9IVnloeHplS2xxZU11bG44WnFQaVZF?=
 =?utf-8?B?RmxDQUNnSzFyaFduYzdEMy9JK3BSYnJaakNHWEM5S0FsOEpJY0RJSFJCaWtM?=
 =?utf-8?B?THk2WnJreFVXbE1XQjdRaHVlcG9KbEVQNDNUa05NYmQzYmtGaGRLRjBlVmxr?=
 =?utf-8?B?T3lkY3hBTFMyOTVmb3BLYmlPUW9CajJUdzNIakFXc0JWWjM3c3pyRFozWjZq?=
 =?utf-8?B?VkZJREFKUkp3cTlTOERCS1p3SzA5OCs5aytuM3lkcFBqb2ZaaDU1cmJXazFw?=
 =?utf-8?B?YTgyZzY3YWh3azBHcVZyelczNDlraFFyTHJ1dnh4WjJhUld5RU1qcVB5bDc4?=
 =?utf-8?B?N1J4UjFXam9jcTBydk1HZ0FjTEEwMVVNVUZSSG5vS0tTQXZpcEdnN29PL01m?=
 =?utf-8?B?aG1HTlpsUFNxYjdOeGgrckFMK3lBTmprd3RoUW5vR01OK05PQVRrdmRhSEhQ?=
 =?utf-8?B?NlFlTnpUM2V6dU9KYjRzVUlxeFZvdmRlOUNoU2FtN1I3OVF5TmpabVArd2Yr?=
 =?utf-8?B?UldUZFRmSVNBbkZnejdTNzBTWEp3NjNxV09LeGRPQ0t0VERvV3ZTN1M3UVEz?=
 =?utf-8?B?emJxdlZGMEdUanN2bk1wbVRiWm56RXB5b0d0WEE4S0NPdEVEekFEalpOdXdB?=
 =?utf-8?B?eUhwY1V2TFJqdVhoM21WN2xZNHQ2eDh5YjhOMmhvZG5aaks4RFgxemlkbWZl?=
 =?utf-8?B?c3pwcG1WUjk4SmkrZy9vaDlpUEM1Z0tpbFp6aXFzbGJUbGxDRWlwaW1QYm5m?=
 =?utf-8?B?Rm1nNDFNcG5tNml4dVViVkZkQUpFUWpVYW1XQVVzZVYxVjdHMjdpVTFmdEtD?=
 =?utf-8?B?MVYyNFkxV0ZWSXE4bUh1OXdtcWJWcE14QXpxRWR0OXBBdHd4aEt5cE5yN1FL?=
 =?utf-8?B?MFdLWDFLUnpxT1hKUGN6THZOS3dpbzJUV0djcCtHMXhkbzlMMVB5bCthSDFI?=
 =?utf-8?B?Zi9DRTBQQzlQV0UweFdkL0JuOFM5cVIzRThWa0ptQkdFczBwUDZNK2FWNTVE?=
 =?utf-8?B?U2dmOEI5VldpZFNmbnhaL3BWK0VMOXNXT3lrSXFyS0Q0RGo3V1NkOTR0U1Fs?=
 =?utf-8?B?M1U5MlFWQWpFSmlpMVVWajN5YWcyRnFTbmZDTC92R0VhNFJKallQUzV3b2ZN?=
 =?utf-8?B?S2RPbXFvb01Tc0xtZzl3RjdUTHpoVnZqWkVaQWRBdG9QLy9OcmpxMzBRSG91?=
 =?utf-8?B?SjRmUmlaclJZY2JOZmkvL0Q0U1k3ME05WDhVSElia3phcU82SDZMTHJBVmJI?=
 =?utf-8?B?TUxFU3FjNjFYTUowbVl5b2VCTndDRHQyU2U0ODhpeVNKb2Y4d25RcE4zcnlh?=
 =?utf-8?B?WjVQYjR1Ui9YVEdlM2N6bXFJdTVGa3NQQ000UjRHenFxc3Z0NElacm0zTjA1?=
 =?utf-8?B?c0JKTXVnQ09MajlNY0Rud3oydHpVQ0VXS2hFcUpvbElEQ1BJY1JQQmh0NHBF?=
 =?utf-8?B?eVM3MUdzOW0wNm1vY3d4eFJzVEJxazZNRCsySEVCWTh2c215cG1LV0JneDNQ?=
 =?utf-8?B?ZDJweUU0RHJjeUErRTgrVGZUeStWd2FnSG54WGlCOGoxVnNpYmdiQ3hSeFA4?=
 =?utf-8?B?dXFyamNPNGVNY05McU5DVWRkUm82WWgrVDhCZVJiZXhST2RPS3VtckJDc3g1?=
 =?utf-8?B?VlpHb2IxUHF2NGlNT3lFS21YKzkvRDN0ZVBwTVIvVEwrZHg1UlJRbmcycUs4?=
 =?utf-8?B?S1pGRUZQQUNFZFk3clh5TE82UTFhTFlCdVpNdzRzT0FKNStjR2ovQ1FKc3pF?=
 =?utf-8?B?VVJwNmNmaEx6ck1pbWJsYlVJT21yNm1IYUd2ZXlLUGtRNmpqbVpXZDFxTGQ1?=
 =?utf-8?B?Uk1lVlUvWmJnaTd0WGhBNFpZN3JQZ013NWQzeDlZd3R5dzQxUnlPZk02b3Yz?=
 =?utf-8?B?Wk5Jc0MwbkhxcE8yRXRYdkpsYUlLSCszcnpIY2gxNGxxU0NnSVZ3ZXF6Kytq?=
 =?utf-8?B?NWtXVjlJUXM3cEt2a3UyOTFQVllYZ2lYbGdDVnJheXdnTk5GdmpqUWtTL0JQ?=
 =?utf-8?B?M21WeFlHQXErSEhnQzlEdWJLcGZDelVBZUM2MlQ0S3NLYndWUHEvVU5UT2Z2?=
 =?utf-8?B?ZUVkaE01eWFpN3R4VWZyeE5KRkxBTDJWOHN6Q2w2bnMvbDlkQ1BvTUlZdWg1?=
 =?utf-8?B?c2hoRFJaSW9Ubi9zK2tFQ2lnMG14RWViOHpoVE5aQzFrQ05LQmJTVUgwMkZk?=
 =?utf-8?Q?rK1iIaC3eqBiG8jPdQm7rB6Y69LXjFFhNsq4NlyJ8U=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(35042699022)(7416014)(36860700013)(14060799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4JUf+kvQdXbh+9fJHKqKE2YCGmvZ4CtKdttym7MncUbcIflx2mz3kXLg9MWiOr0iWUeaDeDGW4hbwIjoqiYR738gwx4Ld2NUQ1k4yXVTt8sLuEg8a33Jg3S5o7gTXSAjbAysN8b+QDGRn72vc0pV9tqf2kwIFk5DSTcJpWxadiKWmjq8lAZ6v82Oi2H6McSe1fmjVvTV0zgi+WKItfRSXcd/Rrv0/rBmuCxmZL0i4sjJDeATDIE2VffM9poQ87fGTlC1wCTufxvNz18TlZLEv7KkHtceroj90lI3NIeMzilUWNdV/g2X698AlaZUhCEYiZmyaWSHNWHzxTj4HMFQAIKc9Srhdm2HCEWHmEDhxSkXfGCuwTbXYYdFMJaYC036w3/viBtT6jP97zEk9j/zX88hflGWCedDbbpXaFqwvJdqCEoCVLSA6rLudCSdT/OR
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:29.9284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f42c327-5bd3-4dc2-3668-08de67283fc9
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12243
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6509-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,glider.be:email,sang-engineering.com:email,solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E993A1093FD
X-Rspamd-Action: no action

Some hardware designs route data or control signals through a mux to
support multiple devices on a single sdhi controller.

In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
switching between soldered eMMC and an optional microSD on a carrier
board, e.g. for development or provisioning.

SD/SDIO/eMMC are not well suited for runtime switching between different
cards, however boot-time selection is possible and useful - in
particular considering dt overlays.

Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
it during probe.

Similar functionality already exists in other places, e.g. i2c-omap.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2a310a145785..f9ec78d699f4 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -26,6 +26,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
+#include <linux/mux/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_data/tmio.h>
@@ -1062,6 +1063,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	struct regulator_dev *rdev;
 	struct renesas_sdhi_dma *dma_priv;
 	struct device *dev = &pdev->dev;
+	struct mux_state *mux_state;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
@@ -1116,6 +1118,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 						"state_uhs");
 	}
 
+	mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(mux_state))
+		return PTR_ERR(mux_state);
+
 	host = tmio_mmc_host_alloc(pdev, mmc_data);
 	if (IS_ERR(host))
 		return PTR_ERR(host);

-- 
2.43.0



