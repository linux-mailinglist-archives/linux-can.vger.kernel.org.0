Return-Path: <linux-can+bounces-6504-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCmPHzuuiGkSuQQAu9opvQ
	(envelope-from <linux-can+bounces-6504-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD16109361
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90CA4300E3CE
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B31365A02;
	Sun,  8 Feb 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="N+p2V4/f";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="N+p2V4/f"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC103659E1;
	Sun,  8 Feb 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565166; cv=fail; b=EmwFqGh5UyQFwgyCo6TUryJxLhKahRtkVrz4eX6gIP3M7Hm/7q3A34p0mpjKcGxqD9giufl8CalhKCeFGhgEvAgTzTloxxF0IUQ/dlxdawDQ/4sbfwIU3WAcWH7gNbblBTkD3ryq0IhXMB8PWBg3o5MNUuLIHfosXIAnIM84zV0=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565166; c=relaxed/simple;
	bh=bLLDBW6rlsBYrKB6/YOSJ2lDL3P8G2bUC8czH9eC5fQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pco4O53Eq9q5xPfDdr9Kyj1uZwq3FVmlUU5DcWP0HBzi2H6brrfrmw5Rp7F2uZPO0enL4PSqdPNDpVJMwZvcAelp0AfFZFwlsNa+czaNbWVgXQ4z5xUCMMyBN6eV0qoRO8ppOadG/l2CUYE//OcqvJxFGcLWzkqPieOoVOG3TsI=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=N+p2V4/f; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=N+p2V4/f; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=a7vZHO2LZW5SK7vvr7fh89zJME7yND8WkwDXniUL1AjIbXDjg8tVSNt8bzetLY5FnPQQu7qiQe/8s0wb8BcTklNKNWdqlNqw/lA0C/WNFro3um0dJ/37UUk2XvAsfY4sLHqrmNPKwuj3GJaV7M2f1oCzvYVTnf0zUHwZse7ez4zPHDMWyaGMHAQmZ/CKZo7Jq9udJr+21y7oIFESL1gMdPeJ2tkA6nNBvvkO+nh7AgIMbPKs+HeiPCMumt+3fEq46SPdMhoy/S/TUulB+GUSO/6jiMw4rFFHWdxdgCvAoPsUWfUyPAncm4N/mXBz7fqrzJtelXMKeKsdKrE+FaPP0A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8aeQD9NhAGdBVFv0pp48k90ERmzosrgg9CUU+FpXq8=;
 b=qcF1L+nmPoK3SnMhZMWBKArcE8G/PArJM+7RDh9m3k6H/p4fSiX+WFhlRmdOwAy+S9ieR0/v1JRx1BRcz3G1mK5s3zdiZGH4/T1CFAtIC+nl+t6403Pn/9fhgGlz+cJdSLuaZJLGT8O1vATm2e9ouC9OdL2pt61OhZyyqxzV9HcK9h5zZTP4MBznQQX140XhO4v+CHambWxhpxqEFb4RJzPwoucx4Hgn0pL4px3ejZntGcGja+AflXmM5vs/qDMshCsX2nYFbkxKbuakmk7NX0zIexfb5iUb9pn6+e9uNmNl1TL6hDFwdnTs/sEVSUwqelKkUBgZxQVLpKnPxfo8VQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8aeQD9NhAGdBVFv0pp48k90ERmzosrgg9CUU+FpXq8=;
 b=N+p2V4/fgUjM92yRTNNWHnBNvySbl0S5x47Lemwo9Rtj1uLSGiH3OxH5rzGmFnPsbH9W6msYvRFAZfJvUpMyW0AvfekYrCgabgBfIcBsA4/06kgQ0NyJ8BmbFnqD2fZNXDV6muwU7EmLFk56sPDg6qPokswp7fH3oWnmhPgfgLk=
Received: from AS4P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::15)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 15:39:23 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::59) by AS4P251CA0026.outlook.office365.com
 (2603:10a6:20b:5d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:23 +0000
Received: from emails-2350297-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-212.eu-west-1.compute.internal [10.20.6.212])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id DE8387FF70;
	Sun,  8 Feb 2026 15:39:22 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565162; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=k8aeQD9NhAGdBVFv0pp48k90ERmzosrgg9CUU+FpXq8=;
 b=LvcDPlIqpCdTSdF405gj6q//E9RpfMYTK36l/S4lRw/QaZxBN4qDoWJv1i4rWWtZ+gjJv
 ZzJSqsXan/v4ahfbJwXeOqm5h4KZwJlyq4RxocBFrvRYAScHwNx2Fs4XtX2+vw1UfPpC1hc
 dUmeiIN6NiB22KJTnn+diLJkjIyLlqY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565162;
 b=V0XE802Bmo5JTnyKPvA0crG4k8SWocpHx8Pt8EPAJv20CTPWvu6nGgpmYjVnejspdW5FE
 UYeGPwGjdHtLv3ytVuBqkyOPyFoxia07PPUOrt1oqR0OtaPYLS++ziyzY2dW2GllSPk4gch
 3E5XUwxgT4FH8iAjoxrPN2Wx/j2e0ZM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYO99C4Ntm9j76LRQE7FajvnJU+X0ghx/GFG1ZTUrY/kdvNtedhu5FDcdWHZ55oWxkixBr18jG36OfHyRyoi0FAJlqCqG5vrjmiACOnPPsZDv8Xx3rGbLT8ZRsZNffoZG9aZPbyiMfGmsK/Wje0EovTQSSNZEOJYXB+IBrsPkoguKhaw6oaJInKeDaQwUw0PA4cf1wBtY9108Avr4Nf4wnJCMjZfw1TflM/XNIdN5XpmCA/erkdQ3TMUGDa2mBxSoNOl7qS/BnW9OAqBHTqiK3/lJgnR9gIYV9uR+stgbyT3TyT3VtVk+h7Nk+MG3slYL4wLHVHCs/PgpjrY2s3EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8aeQD9NhAGdBVFv0pp48k90ERmzosrgg9CUU+FpXq8=;
 b=y9HDxB2MqEnu6v/WAC3EKVFp91kM7Gm+nC2Ti871RRwaxREnQCzzVPFPlNOkaUZM0/vbF3e1SEs2CovhhXgGhVzozTExyInGkoeIv/BZaxs/dtQzNysbg5dxo+mxNQ4i+6Tg7wZ4WRYx0GHq/b+rtWfnXkmAiawnZ3i/hBBpi7m8nP7vT4+iAqqNbYTPCi6xqXOZcvGOxgUFJYEzSkJZJj4wwQ14PMMM6nFuZQ3iF59iwW1iMunr1goaKy8WMDcZMcOmGq6tP+nydQ3I51znXhXRNt9ytNMuZXiQGKvaFmsgPV7CRvWnqYQqXzJjMCqKT4BrJ24irgIjy0SBVewMUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8aeQD9NhAGdBVFv0pp48k90ERmzosrgg9CUU+FpXq8=;
 b=N+p2V4/fgUjM92yRTNNWHnBNvySbl0S5x47Lemwo9Rtj1uLSGiH3OxH5rzGmFnPsbH9W6msYvRFAZfJvUpMyW0AvfekYrCgabgBfIcBsA4/06kgQ0NyJ8BmbFnqD2fZNXDV6muwU7EmLFk56sPDg6qPokswp7fH3oWnmhPgfgLk=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:12 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:38:58 +0200
Subject: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
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
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|AMS0EPF000001B5:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 04813c11-1f85-4da2-51fd-08de67283bd1
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dEk5UHB3TWp2Wm1IV3NkU0xscEt0aVhRbTlqRnVWb0Mzb0lVTGlHcDgveUVO?=
 =?utf-8?B?UnN0V3ZCYk4xRWs0NHhtTWZvbFhpNDFJWnFnbktDeVJMMEYvY0JCVHZadDdQ?=
 =?utf-8?B?TmZmcVdiSUYyZVNGeVhCdVZDZzlkS2VZTk8zd01GMUdCSEpWSDJyR1IvKzhn?=
 =?utf-8?B?RlVCZFZCRnNDTUVHQi8rNGtWa1RZQTloei9MdnMveGlEdTBNQ04zVEtkTHh5?=
 =?utf-8?B?aEx3RGo5ckdiUm5yUE41VnAxMXk4bWFuY1duNG5DK1JHZzhNbmJycHNKNEtZ?=
 =?utf-8?B?UVVOOWw2dVNwOHQ1NGR0cC9yN200SENYVGpZZkh6ZnBDNTRvMGE4ZHltalZh?=
 =?utf-8?B?LzZESlJJNGI2SU8wNjdjODlXZWdiZm45OS9LVUpia1k5bkYvMk9SUGlJa2hv?=
 =?utf-8?B?dDBtYjlRN0NJODZvL3dIdTVvVUdvdzNNY3NlbHJIWWhMZXZ0WWZnMkZaUjJB?=
 =?utf-8?B?ZkZSNU1vQy9uZnY4NWlaNEJObkhDa1RHUlVDc1BsdHg5a3htOUw5RHV5L2Ew?=
 =?utf-8?B?dnB0R01YTFdMV2hodVE1eGRhcytlOGVFOExidkt1RmtFUnQwdXFKbTU2Q3BS?=
 =?utf-8?B?Q0dZbGRiYytzM3JtMjNEQVJ5WHBhcEp4b1hWbDZRazN5Q0NtNVhGZVNqblRS?=
 =?utf-8?B?V3E4YXRKRjJLK244bHZac1p3M1lRdGdoN2FvRGd5WUlza1VVcjFXNnk1Yzhn?=
 =?utf-8?B?UGUzaC9UVFhrTmZQYWtNTW40QnpxbzNsd1ZxRXlrU0lMTjZGcXZnTE5idzlk?=
 =?utf-8?B?MVVlWU82bXNnQ2Z4c3BtMmpUTzdhS2h3Y25HS2RvdTNHV0kxbVM0VHVseVVx?=
 =?utf-8?B?K0hOd2RmWDYzRmhiYkd1THJDeVBEUHJ3YXUrVnNsdzZ2MU9iWDd1aTUydUxR?=
 =?utf-8?B?VGU3eUM2c1lhTjRsL29zYVUwd3FNaEowTlNqTnhFamxlN0pzZ2o2S0FvVy9K?=
 =?utf-8?B?ZWZicjZQdThRc3puRnMwdkFuRE91M24vN1h3d3V2bGxNMUVGdW1uN21TTHdZ?=
 =?utf-8?B?dUhKMWF1UHZPUzcwYkc2bmZSb0REMUovb0ljQy9GMFRXUjBOWWdnMW14azN1?=
 =?utf-8?B?MzdHcG1FNk9HektUcnFFVEoyNFpFMHdkRG9ZbHRiRVFIV2xSQldRTXN6ZWlF?=
 =?utf-8?B?TWdxaS9QK0xaTENhZGZkelRRUGlJT3pkcUVjYWsxL0xYdlo4OW9KRm5WS0Ft?=
 =?utf-8?B?NGZtSElFWHpCbktxVVZldWNmQjl6bmZLdXl5aDMvQjdCMXB3MVY1Yy9VcmZz?=
 =?utf-8?B?Y3QxemdEcUhCcjdIajR1SUppUzlKSXhjV0I5ODNCNHB4M1MzTTcxWENEL3VF?=
 =?utf-8?B?aXlVeHhZbWRTQnhlcjFTZFB6eEppRmRvVVJQb1B3RHhnUTJQVk9ZMjAvQ1o0?=
 =?utf-8?B?Um1lRHVQRGtJZU1SQ2h5b1I2YllZb3Nhc2pQNURrMjVSVy9tdFppeU9xQStn?=
 =?utf-8?B?eXpacEkrK3ZnSlhhai9kSFQxQzNpQ2I4OFFNckwvaVNEbzJhVTdxenptWjJE?=
 =?utf-8?B?eXRCMVdmeEEwalU4UFBsM3JiQVVkMHE4R1BoOEtRTDAxeE40YWt4K1hJTWhR?=
 =?utf-8?B?eUh5dHQ4MC85dllWemg4aEYvSXBpRlRlMXJDNDNXTHZkTUtpVHpmQVhWY1Zn?=
 =?utf-8?B?SjQ4OVdlTnVJbmNTdGI0OU03QVo5ZTlselhkZTBGODRZdzR3bHhGdWZKTm9i?=
 =?utf-8?B?UnAwVHFla1RJK05VeE9vOHF4Y3JUYWQrclJFcVpxaDEzQUVIWG1MMEM4dHBE?=
 =?utf-8?B?dWNNVzhZdEtpYVNZWHpPZjExbFJ0b1lGSW1jMHhEV01aYzFRa0hvODgwMmgr?=
 =?utf-8?B?bWN0Sm5Zc2FORFFCalEvYzVmZGVodEZkTmdLaXdDSE1TQjJubzJyWWJTQzBr?=
 =?utf-8?B?SGc2eUw1MUlvc2NMOUVrRkZPY1g4OFhQKzdQZFJ0dUxuRmJ2d3Z6Z2t1RUJN?=
 =?utf-8?B?RzA1ZDVEZHR3U1FBZ202S0NvTURUQlN5Q0NqUEZnZ2ZkTUVBblB5bEIrU1Zj?=
 =?utf-8?B?UG80L2dtZDZhTnAxQnQ1aVl6SXFkTjF1VXRkUjVoaEpnZEpCa25LcGhHMDlH?=
 =?utf-8?B?cjNQT0RXd0MvSFV6Z3hoaTBKNk5rUUFrbDdBSWdOaUdSTGNJMGZRV21uRVlU?=
 =?utf-8?B?Qnc1ZjFiMTJ5bU4yM05rbXpocEhSVFZNTC9JZzNrYyt5QnM5ZWw4ZWcwTUFS?=
 =?utf-8?Q?C4LJu1se5raTiFtHQCQO2+8+3VVykWzh1RAEqGWLyqHM?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e8866656486c416ca782690491d990f3:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	856f6bcc-b775-47ff-955c-08de672834e0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|1800799024|7416014|376014|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVVVcWpkbGt0Tm90MkI3c2xOUmxuSEhzdFBpelcvR1NBWXZyQWo1YUpoenZK?=
 =?utf-8?B?TzQ0TlYyRERVSTltZXlDNGxObzhEaUE2V3dxWU42d084dVNiVG1SeExydE9E?=
 =?utf-8?B?Y0lKU1JadHcyVnE1Vm5GSmxScFNVenY3VFIzajZWZ2VKVnFJNno4Y01RaWpE?=
 =?utf-8?B?Tm4wVXJqV2JzL3dIMVBuY0gxQlI0YVdkRmx2WE1JVnJSc3dzSzNKaFUya1dm?=
 =?utf-8?B?R3U3dnpFY1J0WWZaQVIvR01MMVRuZ2hmOGxiQUVZUzhma0NUQ0lmZjM0Vm1D?=
 =?utf-8?B?Yk00bUV0cTJwSVkveTljQVFOZWRNSUd6RHR5czZKNTZrQmxnWHdLZEpJSnR2?=
 =?utf-8?B?aWU1S0Z0aXZ3dzlhUzFQVHFBeDdOb1MzaysrZStEZWF1MmdVamJsZkhYRjlD?=
 =?utf-8?B?K2RHVUI5ODNXRXVsYlZUZkxsWHBBeW56NmpGcXBjT2wxVkRnbEtzVlBGQmxG?=
 =?utf-8?B?WVNwMWFSWWo3SzhEaHA0eng0dDhjdlN6NWF0cUNwTUxuWTZqYjRrWHRqQ2NV?=
 =?utf-8?B?bnh4bmtpRlY0YTN6SFFzVENqOWFtV3FkSjlYVy9IZVZRUGdoaThxYXlJYUk5?=
 =?utf-8?B?dzZBN292RUJJRU5sUDQwWW90WlpKWnVvYTZTL0txSmF5NGlPNFpMSG1ITlNV?=
 =?utf-8?B?NmN0RFZKMlJ0a3VkTkU4MllUdDF4ZnNyLzhtUHI4TmZiVld0QW9mS01ZRlJX?=
 =?utf-8?B?VE1tTUFtY3F4NlJET25UU0lwU2c1Q3VnVXpBMjJpVHcwUjNVK09rYktBSHhS?=
 =?utf-8?B?N2MwYUVObTdhT2dyelBTTmNzbUpETmtzWG5OQVlBdnh2NjNSTXpTdncrUll1?=
 =?utf-8?B?bzFlRng2OTVacG1WaUVtRTdJczU1LzNTaThJRnp1SHF5YmVwY3MyZDFObXVm?=
 =?utf-8?B?TzBmbEt6cWhJOFNHeWZ3QjZhSVdXZFJtYTNXdFFsbWtOUkVaRy9IK0pEdjVj?=
 =?utf-8?B?cXdkL0l0Wm1CWUJrVENsRlJaRHRxU2FkbEZwZ0dnRzF2dDBsbjFaZlVDcjZZ?=
 =?utf-8?B?enJPaGJmL2pxL0FLVS9GOS9hT1ZpVWMydW9TN3R3eHhVMkdBNGlqQnlrVWJY?=
 =?utf-8?B?UjlxTmZBR2hWTS9SRkdLdmtmNDhDbXM3cXRNN3dTQm9SZEJrR1ViU3JTc3Bw?=
 =?utf-8?B?R1ZwT0dLMGVXY3NMZE0wd09VY3VHdkRRWXlZZ1FBR09XbUF0d2cvRkpwZjFK?=
 =?utf-8?B?enovaU83WW1hcEY4clFiUjl0TUtEc3JpcU9ZQjNETjlkMnQ5QkVUd2xEYnVj?=
 =?utf-8?B?OHBZV24wMUt2OFdsTTllZEwzdXFWNTJVMTZFeURIRHRnZWJaWm44L3dPck5E?=
 =?utf-8?B?TGlzdDFqckR5dHA1OUNKK2hPVTljMGxubkNqNXhsVkl3NlQ1NDhLU2hIUzJM?=
 =?utf-8?B?VDRVR0JhMXY0b29IM2E1VDNvVHBjNjN5bTNyWFVab1JydEFzTlQzQTZRNi9h?=
 =?utf-8?B?ajEwaVoxK2NGZDNtNXBxNkVIZW44YXFwb1R5ME15ZFBqb1ZtN2RGamVrQlV1?=
 =?utf-8?B?a08wSm5nblZ3SmJkT1l1ckRmcWN5R2ROVnZzMlNNeGNQRVYyZjduVXJDckdj?=
 =?utf-8?B?MkFTUWRxbDhkUkZSb2h6QWVkR0JoTzhqTXg5c2ZVbEc2SmM1RVFSL3BSMGp3?=
 =?utf-8?B?RE02eFA5SXNocFFGb1c0UEV3UFk4VG1hSnZmSzAvSEN4ZjUxc2d5UER3L0hI?=
 =?utf-8?B?dHhjaldzVXhCbUJWUnM0RkdtNVpCNGd1ZzFJUGVTWFY1YjBSTkhJQWVGdlFy?=
 =?utf-8?B?REpMVHVtYzA0RzZoam5YNkIvL2s1N3J0eVNVVmFQcE1NVjFSOHltWGxjRlB4?=
 =?utf-8?B?WlUvcVdoZTBwK0dUT2p3RFpmeXU2SnJ1NzQzNGxRTVRWVXM4a3cvQzlqdU1Q?=
 =?utf-8?B?SnJEL25LbHhERWt4ZnlzVDVGT1l4VzZncUJmWGk1aUs0SWl0RXhudCtySDJx?=
 =?utf-8?B?eU5rY1A1cHE5c213elY1VXc1QkwrQ05UTk5TY3ZCOGw5dTRwRWI2NkI2TUNa?=
 =?utf-8?B?YWQ4alMyL2JvclYvNVA0K1pVY1pKUGhsWkVYejlqdTgzYldjaXI4OGxmcDNo?=
 =?utf-8?B?REFXNGNROVc0akZrYWpTL1VoNFJSTkpEZ05IVldZYTB2Nklwa1duK0lpOUJT?=
 =?utf-8?B?OEgyWi9lYkdQdCtQSVgxWWg5LzRUTWdjZnJBMEtkR3NhbkluUXRQbTI5WjhW?=
 =?utf-8?B?eGZ4VmpJQnlUeUhaZWJML05JM2pQTktEcFZxMmRuOTVXS2V0elU1dDY2b3ZJ?=
 =?utf-8?Q?KO2A1yOe0z7mbLQWejCaoqG1Z1AzJQwU/1jrzUZ8jc=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(1800799024)(7416014)(376014)(35042699022)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tlHcuXATkXcWst4STw21mVcfMI3FJzDChQqKZeE1/rCQWB+bVejvsObRKSPh3lxC8enROIxlyr3IYEIU4W7fJ1bcAy+gbF9vkFMM7KhgVPb9qwRuqmO4zd4jU0VsRv9P/g797OuDBQSu+7EZFHz7MlMFl+SirJsxhtvuCr+jXDyPmW7mNZczYohSwgIBafJ68uzmFfF69uWx4bIX8CiUx1lqMpBxMVeU5YqWvYPdfrDOSt3HGyFRbeY3TXwfxuZQkPk5oeaD9ooYYPpGng13W4nNu0mT4BC2yFf8CmPIVBqvYIM9ImxNME/iAZ3Ik2F1uguC3bawM958JpNbRPkXMr8WFhxzNZ5wOtZR8D5m7CEDM79TTEnWgjat3O4/C4y7RC6HFaSLUOeQ4lUW7gPZ98HT1SiueVqvBFFZd0pCuULeQ7MfsHRKsmC8OGvCSFaX
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:23.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04813c11-1f85-4da2-51fd-08de67283bd1
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
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
	TAGGED_FROM(0.00)[bounces-6504-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: EDD16109361
X-Rspamd-Action: no action

Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
option thorugh the kernel configuration without explicit "select" driver
dependencies.

Select it by default when COMPILE_TEST is set for better coverage.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index c68132e38138..4f7c6bb86fc6 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,7 +4,14 @@
 #
 
 config MULTIPLEXER
-	tristate
+	tristate "Generic Multiplexer Support"
+	default m if COMPILE_TEST
+	help
+	  This framework is designed to abstract multiplexer handling for
+	  devices via various GPIO-, MMIO/Regmap or specific multiplexer
+	  controller chips.
+
+	  If unsure, say no.
 
 menu "Multiplexer drivers"
 	depends on MULTIPLEXER

-- 
2.43.0



