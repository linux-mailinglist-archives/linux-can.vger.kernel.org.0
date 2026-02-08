Return-Path: <linux-can+bounces-6502-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N8uDjCuiGkSuQQAu9opvQ
	(envelope-from <linux-can+bounces-6502-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B984109322
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C3853001A6B
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D866364E8D;
	Sun,  8 Feb 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="owf+J/xk";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="owf+J/xk"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021122.outbound.protection.outlook.com [40.107.130.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C827C84E;
	Sun,  8 Feb 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.122
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565163; cv=fail; b=WkZGY5BP6MfXTJB8dUysTtlmOiM9sWbXJO6EQRUyHmHTP6/p7ketNk9Rbu4m8v9KYlXmuS0OVZ3fkzMffDiilbyM7EQkvHEog/OMM7SOjl9XA13a3G95kP5spfI0MHBdsV7/59sGEZ7jlDzrriC/+aAxqtGoZDWNRhCcmAAmenI=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565163; c=relaxed/simple;
	bh=J8Q2KR7Ho1SyGPwX2hqradOov9u8xip/KIm8vz27fqA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VKGKqROj10bhTT9fSOYfZQpOCNWh0dsrKWYrws3uOuuPHxwdR9IR9rffqYeJtOwhni3hBYhdpy4+WoswFs+tY0Tru328ukmpWedPTmNHo3IhPzKTuaPLKxb624BieJXjRQsVoivmLh9Vy4pw0YYdoCjDXVUNLVMFO0fEFHqi8qQ=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=owf+J/xk; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=owf+J/xk; arc=fail smtp.client-ip=40.107.130.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Biabkx/LOsF3yIxCBWJNXQPkPR282gOzyFdcpPcPbt4BSUzTifgh/O4EVTOGhkGQXM5k8KvB/TsxHlly39UP6NstI9p8m35cIGcKK7nc0CywM29mHxRHwNHnA0Uu5Tvdd79o4aXIKBfrs7vlPINuWMjY5tUdlc8XM5ghKu3mzPBtTzbI/x5esRk5+o/l8vjn2NfsPXPUGWiINJupiKwde49drX8ORVYRg3TTQ/cosfEAbtfXn9mYyGG4Gc/MyQbAIc3COXs0c57hgeldstom/dIYmPryBdXTZY7danyLB6E/kbSMQq511m9Ji06ENJYTHOT0pUIWrCc+D/8G9ZNxjA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNf4OQXRu3OXUP07PhiYl7YZpHj5ounn423sI7G03JM=;
 b=uQ74UbG6XALuiZ5dnpl4HVSCHY1x8HMY8548reCXtfCfewHfBchGQSW/NZdS2uy0PYAXgs/ijfTedwRjw10j3r6/kZMjRZ3//AjrvtR09aof3d945dAr089t+ZqNnaywwNBFgq7HeyGmmIdIOIkBlZG9aOtrTBBXOpIwCszvt/iiXuQi5g9QleZoJMOeYE33Zvl86MTgG3SWvx5QdzrNelBa5saQaPAOCsyCNQFNZlepfDnyj76uq+84riLwQTijQ9kUnoERa1v1/DJKje1+zCR98GYsV8wqQz6ZPzqjl+k2tFHntZhVX2bL+VUw8n2kJh7C2xMYeH1PnXLKgID+aw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNf4OQXRu3OXUP07PhiYl7YZpHj5ounn423sI7G03JM=;
 b=owf+J/xks5g5djHl04ubpWThM94OC3VZlTFlfyxpXlxqQ0xmIf5TYlfryyfS042iiUD8Q5RFg+xXglTXUcDG8t8or16ghRLxfvBrldykNZh4YTHBI1hpEnP1RPehbMVcP5kE2d7ueX/6aFFoWpojf+Rn0IAoEfwnSygkxyzGwZw=
Received: from AS4P189CA0011.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::12)
 by VI2PR04MB10116.eurprd04.prod.outlook.com (2603:10a6:800:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Sun, 8 Feb
 2026 15:39:19 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::3) by AS4P189CA0011.outlook.office365.com
 (2603:10a6:20b:5d7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:18 +0000
Received: from emails-5815230-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-212.eu-west-1.compute.internal [10.20.6.212])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 6849A80010;
	Sun,  8 Feb 2026 15:39:18 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565158; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=DNf4OQXRu3OXUP07PhiYl7YZpHj5ounn423sI7G03JM=;
 b=i8GkzIP5R16r46WQ4hvG8h3bb5lcqJwQ6+14RnWE8wnYQ+y//R6j2DZT58PEJjMXlcCbR
 Kp+RRy6CAoFhViXcZ8es1lMN9alcilS4hNirjQIFSVhftwfnYPX5Y1GC2HqUVl5x5gkaLNW
 Fcq6DyAUChPkB0gfiIPq016h2qG6kfw=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565158;
 b=hSv7qFTc1h0yRv+6b5641Tr+x9BFG21OR7indWLuSV8hN4X8xGVV+XswBNd9BQLL+jRXl
 f7qwrs7IzyP4zfvfu/l3FrfNGhcKpMizw53A9rjpN55+UFPHjGNHLnsDvsXNEtsQ2QGG56M
 qDme/39eH10ZMvEWquez1UdHybtnx5w=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbgCsnbQwhy+Lz53CzjxDS7Xs+9pX+nkr2W4blBoGGm4KN7P5P24MYn7Qh6lKpjkwOcKznPMTJ+Kv3FD1MZXuwKMQKs0v/LNk7srM4OIaoH1WL/vDWQq/62ljev/lQfcQPFj9v/E6cXyMjN38XZpeRTZs9qUpEcbmzfG3HjJbtrVCG+IpWaYuYrvqbdq8bmbkkd3wXJf+0GgEiIUkUzYjbgIYB6P50yJwmj+7iWUghiAgV8Dc/5f0FE6LhEJTs46DPXMOLaj4YFevMOZ1tw+G7P2uWueqBCZd2h/3Q6laLe0kOCWXri+trAy+vdhbqhBMnjMa+37YnFc1fBDFir+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNf4OQXRu3OXUP07PhiYl7YZpHj5ounn423sI7G03JM=;
 b=f+bC9Luv89iPdL0VKH3bxw7EXha/jPdzy2ne/ZXL+jUCJtvlFyXJZ614m2D7Ys20/zX48Z4Rf4tXsuy+FPOfU2J9Kcj1f7LL2Kz163MSWCL6IMGRSVzAb7KyVTo+aFppKS0360icJ6lBG6HrkRxATaahRkQO2PlgEEdAMKaMH5scb+1OtxD1YLrC8bVEryNzvKGigVG59ALFIuu64GbROYH/Idz3CWPT22m5nnFFXeaq746kR6gZDF8DhZo5u8X+xPQkKjpC/5GUZQopumYyQFsaSHUuZbxOR4uWivNh/K/RgxxrB6pPEyuQ8d1knV9hlI14nc1Su9yTxZu1gJB5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNf4OQXRu3OXUP07PhiYl7YZpHj5ounn423sI7G03JM=;
 b=owf+J/xks5g5djHl04ubpWThM94OC3VZlTFlfyxpXlxqQ0xmIf5TYlfryyfS042iiUD8Q5RFg+xXglTXUcDG8t8or16ghRLxfvBrldykNZh4YTHBI1hpEnP1RPehbMVcP5kE2d7ueX/6aFFoWpojf+Rn0IAoEfwnSygkxyzGwZw=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:07 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:07 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:38:56 +0200
Subject: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
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
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|AM3PEPF00009BA2:EE_|VI2PR04MB10116:EE_
X-MS-Office365-Filtering-Correlation-Id: d74f5774-f2a2-4cb1-836d-08de67283925
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QWNvcHdKaXJsTjVKaERSdVZ4RU5zNUs5amMzejl3RUVVdjhKdnRCMDFTYUcv?=
 =?utf-8?B?VHdSam5yRWwvVldreGYvLzg2Rzk2MzhMSmZhTGhXR09vQnNWaWZJSU00M0hw?=
 =?utf-8?B?QU9kSk5oN25HbmMwTUxuK1lRMENlSitwZE15eEFBV3lCdUdWQ29zRlJLa1Nr?=
 =?utf-8?B?a0hjN2hHOXJld3RIUXlGMHV3WERhVGNGSW85WU5HcmdtRUlhWmh3anI4SHNp?=
 =?utf-8?B?TmswbjcyMkVUc05pL2Zpbzl6OWZ6YW1vbkJlSFFDY2hJK1VESkxha3pxUkdG?=
 =?utf-8?B?ZmM3VFBwODA5Z1NtU1Fyc0xzby9saFBFZnB6czVxNS9VeDhnVUFWbUt2VkJt?=
 =?utf-8?B?VHRvNWNsanZ6YVl2Mkt0V2sxeFBzYUlhUzhJVDFIQ0U4Q0hYUmJCc2lFRStU?=
 =?utf-8?B?VjduTFNWb0gyU0JqenFHNXdhRDllMFgzZlF5cUw4aDMxcWMxQWFIYkVYOUtq?=
 =?utf-8?B?MVdWWk9FTlV0OTh3cHR5ZlR2M0NHNEV4c2Z0eUFidk1SSmxSUGJIVnJQcjBZ?=
 =?utf-8?B?TExZemdxTEZjUkJKaDUrVitDWnB1YXpoR1k5NDVka1lkREo5ekY1U0NoUWZI?=
 =?utf-8?B?R2lCNnlIbU1nYXNnazhTckIzSmc5OVZVK0YwalJLYS90YkVMKzZGM3pOZDIv?=
 =?utf-8?B?dSsxYVNCTlR0MW9rdmpveHZuQUdIRnNxVjl2V0VxQ2NXZ3E5WXQ5TUlISzdt?=
 =?utf-8?B?ZkpYMWdXMUREY1FBUFQyY2E2TTA1UHNwVWxjSnpTTm02SFNFSzBrREV6bkNU?=
 =?utf-8?B?Vll1dVY5OWRXRG1XOVVIdTJnTXMvaHc2WjRpenJ0STFMV2FoVE9oZEtWTmZa?=
 =?utf-8?B?dk1DM2RYNnFYWjhxb0w3QXpjait0USs3cXVxNEROWFBTMldzVVJCYkJIZjVF?=
 =?utf-8?B?RExMWitEVk1wZ255Tkgydi9wOTNvMDIxOTFzTjFkcnlRd3drMGF4NDd3d1Bo?=
 =?utf-8?B?eGhMZVVKS0hhVlRYZzNha3JrVWkrS29LVUlaQ0w4dzMyZ2NKR3JIQ1hJeU1j?=
 =?utf-8?B?WjROeEY5V1hZNmJKZWFTUGVPbEk3TWlrV3pDYjNGQnRydHk1bnllbW10b1lK?=
 =?utf-8?B?aEFDRjMySHU4NER1TjIzNjRmZnJVa0J5NldmQjVvb25DZlFxd0dWWi9xeW52?=
 =?utf-8?B?V2d5b014NnpOb2txbE11Z1hpVW1pdTdDZ0xqMk5QNk9FdzM1U1BnWVloYSto?=
 =?utf-8?B?K3ZDTC9JaVVyL05OdnlkWUd3MWNPaCtTSGhuelo3bitIRVlHWlVDaDIxL3Jz?=
 =?utf-8?B?OGh4dkR1ZWhNa3hNaTNCM2p5NkFBZ2RwbG01SjFLR3VzczNJcFA0cXFHcTlR?=
 =?utf-8?B?RXVVQ1NzWndZaW00YklldjJZaXUwNDQrWms3Z0JnNUQyU2NWcjdrVVkrVVQy?=
 =?utf-8?B?WnhyekFYQmYrQWhyYmZvNDNIWEw4a0ZIM0ljaVlmNjF6S3MxKzhmU2d4OExZ?=
 =?utf-8?B?TXB3TlBld2FQZVZOR1FjUzc5eXFGVWo3Z1I2SXJPVHRYYWZPOU44WnFlVkRX?=
 =?utf-8?B?bWRwWW1BZktIWDhRdThwd3lYWmJxMzNBeFhKNmxtcDBDQWIzYnI2V1cwc3lo?=
 =?utf-8?B?QWowYWt3NnVyWUhSb1hhR0YzV2tCdWo4WWpTY2s1NDI2dFhWNTgxL3Z4blVk?=
 =?utf-8?B?SzY1dkU2cy8rOENHc2QwOGNlbVVyNGFOUy93UTMzcjJJT0VZZ21DREFNdTZN?=
 =?utf-8?B?MHlIS3d1MEpUUzY1WDdoaGNaODNDcjRVbEkwaFlQMFlaNlIxbnp6NmhhN2Rs?=
 =?utf-8?B?NEdpZys2NE40YWtPajI2bTF5ajZoWHAyY1hPVW5Ic245cTdqTWVETGhwRW5a?=
 =?utf-8?B?N2V6SzNGaXV2cEF1Z3k4UDJINjlQYUl6L2h3QmtpdkpYVE1MbzhUSHNYbkVO?=
 =?utf-8?B?OTZxVThKVGEvdlI2T1RhNjdlTEljQmVkNDZId2R4YkNZQWtxcVoxSFFhZzVi?=
 =?utf-8?B?djVOR0JtYWljR3JxWFNvaGJPWVEvd0IrMHJMZDRBSFBmeFF1c005VlhpUGk2?=
 =?utf-8?B?UGltaXpkVVYrck0yQTdOSWJsT2V3UG9weUcvQ2t6QTVNTGczVDVZa0RkcGM5?=
 =?utf-8?B?Y3BGRlNzTmVBRXR6ZjJMaFFhU1NFVUlVTDJsM09SRDR6ZWwrVHNGZ3lJT0Nz?=
 =?utf-8?B?Q3NnK2VDaXNoS1BPSTJGVmtvWllCcmxZcXljZ2RJdlRYOW1JSmg3VmxyNVUz?=
 =?utf-8?Q?Y/mV1x1muolaJB8LnbFhxDrOLH82P87c5A/G7xzUheYW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a8c8ce56b7cb4360adbfdd355ede6ced:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	449678a0-c5bf-492d-66be-08de67283231
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|1800799024|35042699022|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVdXeXBReDdLSThQWjNPeGhMOUt4enY4Q1hrQkp5NlNtazZDYWtSMTVGVVlC?=
 =?utf-8?B?dDQwK0hHSVJOTHRpcFg2S0hRcG1pNDBidDdtT2QxTFZCVHRnYWE5SzJNb2h2?=
 =?utf-8?B?OFhxdEY4VGs1bXh4bGYyTVRORE84ZzRQdnFmWmN3TVBiYUw1ejdnMjRQWktj?=
 =?utf-8?B?VktOQ2NTYXFWL3VpV0p6T2liT0lYa2thZ3VLeUEyR1pCWnJYVkpCT3JzcHlG?=
 =?utf-8?B?NXJIR01TTFRFb0tTaWkxdml6WEdSdlo3emRNWVJjMDhLYkI5dkJtN0lwRFBV?=
 =?utf-8?B?bGNsV0hPc3I3ZERTSllMZVV2QWFWb3J5N3RTZXhRR0VuNmZiSWRaQVpDQVc2?=
 =?utf-8?B?YWZUS2cyMlEzRVZqcjJxN0t6blM5K0pkd09Id1k4R1VKVGFSVkFablJlb1Zk?=
 =?utf-8?B?b2lVWlZzZXdONUtlM0VFWkdoUmJEZHlISnRuaWl4anc4NUNmaUlkVFFVbkM4?=
 =?utf-8?B?aFVxUWxNa0VtK3FVSStpZityY3Rlb0xZd2psb3pKRXBWZkZPV0NVc3lFQ01Y?=
 =?utf-8?B?VGlnR0U5aWJzU0lidENBYnArS1VBNGRiVDhVZXcxK2VhTVJNNjBYQ25RLzgx?=
 =?utf-8?B?VmJBS0pLNWR0OFZsSkdiSmd5dEFzbm1RU2lBaEVvU05xVkVORFhPTDUxWHEr?=
 =?utf-8?B?NHM2K3RteVRYdVZPcDQwZ2RqdS93U3NhVVc0V3VGQTZVTGxNSE9hYVg5eVJ1?=
 =?utf-8?B?OGx0a1BlVGlIVjI4SU5YaUNVeE94bG9rc1U1cnVscHowWlpHdXRRYjRHWlB3?=
 =?utf-8?B?cUs5bmpPaWVNSVJwUWk3Njlra2hNSGw5aXdzazdkaFZLYUc1TEJwbGg0S1Ni?=
 =?utf-8?B?SkVYU3dscEw2MDl2NlViVzNVck1BYjMvNC9VeWdlTU42L1k1bmlvOTlXeUZk?=
 =?utf-8?B?KzFUTnZWR0RMVWwxTmVtUmJUWU1TRkZ6bEhVRnNCUmxKaE9HTTV4ZGFzOGVa?=
 =?utf-8?B?RUdpSWVRYzlmNm5GazBYZ25JSUE2N0dkcmRYSmlEMGtpWHlmQ1ZwQ01OSjdE?=
 =?utf-8?B?YzVPbHd5T0tNMGc5cDQ0UFJSaXhUWDNza0c1WGZocmttOXJRZDA4MWFqQmZw?=
 =?utf-8?B?dnJ2SHJCQm5aR1RoSTdoWEQvcFk5RDEwc1R2MEJ0VWtxWUtLTG9zN0M1MGwv?=
 =?utf-8?B?bzY3WUJndzhJOGVDS2ZOQnp0Rk1JN0dUTFhVYnVoMUpYQmNDVjErN2t3VVpz?=
 =?utf-8?B?bEovTGMyMVNWdnRoYzM4ZzVvR0NCSTAzNmhnZ0s0aVM4M1hKdDMrQWplS25n?=
 =?utf-8?B?U0FTVVlraFdhOU9CNE5DeUpZUE5uYXczakYrRHpBWWJ3L0JJTW5lbVZXSCs3?=
 =?utf-8?B?bXhER3dNb1ZBVlQ1K0tNSmhwMi9GMlZudm4zcXNJUStBQ2NJM0dsOCtZQ29w?=
 =?utf-8?B?Q3BrNkxKZDNZNGxkbXNaNnpwbFp1b1FjRy90THhxMXh6MFo5K0srVzZLZEFC?=
 =?utf-8?B?eHpBcEpDWjFhUFNsOUg3VkY2enpFbVYyVFhMYWxSSDNzU3A2N0RCYnEyM1BU?=
 =?utf-8?B?allIcy9NWW1UeEFGMWNFYy92Rnpodi9tNUdEQmtRK0NoTUpYeDBDblpYQ2dq?=
 =?utf-8?B?V2s0N0dOdlFOU3MzOXpmK3pwbXBSMWtxOTRiUkNZOGJQbVcyTGRnTXA0cXNI?=
 =?utf-8?B?VktoV242S0pRU1RoOTBCWmd0cU1rTWFtcXdVbmpUQzRrYWU0dVQwWk5ZdlJ5?=
 =?utf-8?B?dWI1YURhNGFKemVhNmtUaExiOEUrWktBeHVLRWxTNndITTh1OTlKbVYyNTlt?=
 =?utf-8?B?ZkpCZ3Z4azJXTDZHUlVEek9PR0NHZk1JTFludVRqLzRyeDlOb2dreWZXNklx?=
 =?utf-8?B?SjFDTkVaRG9va2VhZGdRSDVQTXFHYjhqekRPcnFPd05SQXJ1d0NWZVlodEcx?=
 =?utf-8?B?NEFMcHp5cytsb1JsaXFHTzJlZytobXZqd3M1MFAydUZxNFM5ZVVsdHFQc2do?=
 =?utf-8?B?V0s1d05LNnNpRU9GWXUvZjB4UUxSMFdSblBETG9vdWFhR0U2U3J6WDA4T3RK?=
 =?utf-8?B?SWVpZ1IydURVR2psZDdRM3ZJcDBETFZYNzdFcUJHdTM1TmRDc2dtbFRWNjhL?=
 =?utf-8?B?QmIwdnByMEdoQ3FVZUxuK1IwcjNtVHV1MmRlQUVLc1l3bzE2SGVXZm80NFFw?=
 =?utf-8?B?cVBCai9rdE5taFFFNlhrM2tDZXQ1dWpRemc0S1dOSXFZWWorbi9PNHhNRVUv?=
 =?utf-8?B?cWZPK3cybGd4Q1V1UTM4V0VtcGh6enJsV2xVdW0vQkdnSDg0aVMrNmNrR1ds?=
 =?utf-8?Q?oVgp3qeWHxzAXuog6b9ZNn5alQmlkNv7dVL1HUhzBw=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(1800799024)(35042699022)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mqQHk29d9I8/JsD9arViNjdcEML6Zdke9Y6lNeexLq4XDq3tTMxU1ZuzPNJr/7QqPirW5sWVY5PJMAZ7Ivg8extFITn4jYXYJkRHBDPP+vuSXlsCuLUZwGSuQd3hgG+d84oDkElpKgIzDneCIbeNWYvZS44IuxG+kHCe1TFk7eKMcHppXPfGbOFrT6GbrTG6Z16oEa60GJmPMBqHGPQLOzRYdxNOUD+qqmSwdyeqSxKHhuqoSZHGbd1OvAVatIYw2OooFqn7xtss4U+skIpJVV73PzaABmsk6qkOky4enLGmNLa4GVR5qje7H1jSTXlVIxp55EVxJQl6JOaKDcuKzHIW9HCV1nENGqvCHAiA8cGnUL3Imp/FuN1POY9Vp4CpLb3rl0dc5lIpCQJe5aJkBjNVrLJe6RFUcOHGFn11rqXPIqf5mli4fHPc1ohYdgfK
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:18.7254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74f5774-f2a2-4cb1-836d-08de67283925
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6502-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sang-engineering.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4B984109322
X-Rspamd-Action: no action

Rename the temporary devm_mux_state_get_optional function to avoid
conflict with upcoming implementation in multiplexer subsystem.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 330356706ad7..81591d247128 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,7 +128,7 @@ MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
 /* Temporary wrapper until the multiplexer subsystem supports optional muxes */
 static inline struct mux_state *
-devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+temp_devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 {
 	if (!of_property_present(dev->of_node, "mux-states"))
 		return NULL;
@@ -183,7 +183,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = devm_mux_state_get_optional(dev, NULL);
+	mux_state = temp_devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0



