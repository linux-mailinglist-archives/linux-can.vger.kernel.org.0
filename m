Return-Path: <linux-can+bounces-6505-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA26G0KuiGlTuQQAu9opvQ
	(envelope-from <linux-can+bounces-6505-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:46 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC321093A9
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91E143019103
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CC366076;
	Sun,  8 Feb 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pEXFfHDU";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pEXFfHDU"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023101.outbound.protection.outlook.com [52.101.72.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109B365A19;
	Sun,  8 Feb 2026 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.101
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565168; cv=fail; b=tff8t82XZJtekeaIs6+KvGw2yyDNVoOqOXFrWtovjAcMG7BDkvQ8pYUYKwUVfNdACSG8FTeKlxUVoRi+qeVwOf84pT9Iz6qNeeLRiB2Mr1y60hmkaeUQwiYu+COMEy6cXo/FOOw5BXsGCcgfaLP8qAN2iyEOWQviBtvaT2ZMDdo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565168; c=relaxed/simple;
	bh=Exw4FOm3n3YV/7zqss2WtWQHfZybSYS25sbrGjMOiXg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eEN2L2JSeg2Nc8UrbglDz2Gc0upDk+EIWmSQNPm+dounP0KNgJrEdWV0xx411QqEbYeuto9ytKw3XYtkSpkB26MjBsLO+1vxA0iUAcsBYe6PsK7zsMXgFa8YekAv4JNG1+e+kWSMp82SEPITRiFIuYbH6i7LhScabtIFwOoDuos=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=pEXFfHDU; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=pEXFfHDU; arc=fail smtp.client-ip=52.101.72.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UjtYlUYLFdghfeyspM6pRaqCDy2QyVU8QmAuHYwhV5Y1CuzEo5iJb4jmy+vmJgxQayaFlQJJJtTqxsugSuQurztJ2nqP9Q2uD95tSS3Y2+KP4/FHyqgi0NLIJDzuK877hMCfSPs1mwjuKCFHYwojFQL5XixCEwX5ZYARf9zqjRWQYaTo5vqDUqOTo0oFbLMLAk5VCL2LxuiyPb/vZWl3nin4WI5SdeJDNJ8KuHxZ41MgjKeE6jp9HzligldFT/XolsTC1ZuYBuGjoVgj3H+blMzl4kkNKUQk6kQgBXxZAheCn3syF93E6b1bBvKsI/gP38HjnO2lyq+c4JpeX7Hh7Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcrPdd5V7JVI+Z4iqSY9JnnlAHfAmAt7JLa4RTerNpw=;
 b=YDQdIVLyMuGZl/yGDniHY3aHUSNBRWMmXSPqMeAJ9wFSfBFoFv8mwLrCjdlPVjc6RP5jXPiBcm49+eN2N/ZcrjTtZwNZgwceOfyIX1jN8hi9PstPoqiATgKi0X3oQZEikFmyNnbJhZisy58eSAuCEXi3uerJvCBPPnkMmmcWQcuBXqlVzN+kNWkq/LF+/NHHb+XQToYaNJriAhSwKkfBNbJQUDX0KnvbwbpekX9iH+kRjIhJPFrqm0gL4xTqj/cjM5yL9oooGKpL8jl7+B3SStc6mq8JWuE3Nu/btVMvvQjfbIf4M0KJotjMo8nK8bMR3sY3RMFVGtWwQu92JLftIg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcrPdd5V7JVI+Z4iqSY9JnnlAHfAmAt7JLa4RTerNpw=;
 b=pEXFfHDUx458Rz8RJQBFM4BVIx6tFwaqeP8Wl/7qtCpMTBArc3YKPi/zKIfPAHO/Z5CaEwx6SVMTo6kYc06Ha0ytyBqQlOG1GaXlAC+4C1r8KSG6dWgYI7f1UXsOXm9GLy4NW8aNYVzZrT4EZjacX4kCUF1c1PQdd3NI5FtHQTg=
Received: from AS4PR09CA0004.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::10)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:23 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::52) by AS4PR09CA0004.outlook.office365.com
 (2603:10a6:20b:5e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:23 +0000
Received: from emails-2350297-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-212.eu-west-1.compute.internal [10.20.6.212])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id D1FD080010;
	Sun,  8 Feb 2026 15:39:22 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565162; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=rcrPdd5V7JVI+Z4iqSY9JnnlAHfAmAt7JLa4RTerNpw=;
 b=cHPNsNNJbNDTWElES9Grmx1PkneG61CkwPqm+HE95v1jsv8gZmKZSX6HT9CQaAhdCLkQM
 wNte5AtOJNYRsq0FrF9wwf41WpFepm1B9LRNv51LeBs4C6hSePNlsqTyrBx5ESZU30LOR0k
 hNhxAUdVeV2qUqNvL6W+YsgvUaXBMKA=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565162;
 b=Lx9Z6rvkCWHa87H00/C4w+U1wdBj7O26NCUxbFALBRg9Y0O2Q9ogtvYc5jmTYo9Im8/n3
 d75ycJY7KA04sskm1qjpDCGZDG5iH1PEOrlTVQ6hW+dqKGDrcpUuioOU1DjcrgGqa4o1WRt
 73PVk2JYXwF6rEPvW/xrGgZEfNeS7Bo=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMbvLd0BeFfTUUulA7cKm1IYI1rfFjVLjgQAZzSwu44iGD1gzSnl4ibp+Thzak6ddVvEBFsUXg2iYexMd/NzrKlRIMDs2yM2T1GRmEJDQ3iNWSLuGq23WS/CzGa3+8N3OK/WAKKrrSp6bAlV3xWkEXSLB/iocVLVILZHvfvjJAoIGl7EkRU39Qa1nFHnqopqSg6jBA+DFb1qar5Y21wh8M86lmdNwUqlGF882shEwvd2O6JWWh/qAdKiFH5JsFMZ+TIxF/++mZyN+6tPZxQSBpd8W70jvRrCYCPa6fHfoY9CZceQ95w5JyNxlLghVRG8B/GO6uPyWd2+PwBMcgzZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcrPdd5V7JVI+Z4iqSY9JnnlAHfAmAt7JLa4RTerNpw=;
 b=PPakpEQ77QV9KJbfkdX8/QimwGFLeXMKlCLobCPPxz5mm+BZzYzeWz1UgMugoWipPNQHdPNwds7O9l4PMYJf8sfSZUCKXeg2hIcf7786VFViRl/s9B37me9LnM4NqYFlbAHX23Gsmz//+kxqCO6BU+PmqCo0is2zu7keUG3QH0Er1HrsyOl/5E080SI7D+kT2cZqwRsfe2/I6eoB4wPzp+rwr5BF+KUpNn38qiLS1sdcknLr46yKLkNrTBisScn7zSLgCbaoq/wnzt+rTWg2/bIKAnynCpSw3xQTM0/an5qL2uOSHkT6x7mZAGjc9+QXx7rav/g6Z8DQbpOMEe1z3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcrPdd5V7JVI+Z4iqSY9JnnlAHfAmAt7JLa4RTerNpw=;
 b=pEXFfHDUx458Rz8RJQBFM4BVIx6tFwaqeP8Wl/7qtCpMTBArc3YKPi/zKIfPAHO/Z5CaEwx6SVMTo6kYc06Ha0ytyBqQlOG1GaXlAC+4C1r8KSG6dWgYI7f1UXsOXm9GLy4NW8aNYVzZrT4EZjacX4kCUF1c1PQdd3NI5FtHQTg=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:09 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:09 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:38:57 +0200
Subject: [PATCH v9 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-2-9a3be13c1280@solid-run.com>
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
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|AMS1EPF0000004A:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 562cd626-5577-4c34-bb27-08de67283bc7
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UFZsS1FLNy9KQWZXRHRlemVuSitBdkdaN1NTRVplS1VoUittTVVQRlV6bVpS?=
 =?utf-8?B?Y3VQYWtjemg3WGY1c2xaMkRYSlFuYUFHSWRKdHFDV29tY2k1NGcrN1hqWDRp?=
 =?utf-8?B?OHZTdzNkZTFYanpXeXlmSkR4OWVYbzFPSjlQV1JSQmNGazRxb0E0bzNQWlcy?=
 =?utf-8?B?cHozUFVVTjJSdVJ5KzNQVUM5NUswL2tCcVBjdVV0Y1EzOVRhRDVhVjJsUzRv?=
 =?utf-8?B?aFp0Wk9JQUR0UFptd2U3RFZDTURmY1dMVUlNeG5Ha25CNnIrRStWK09aMGVL?=
 =?utf-8?B?ZHRKaXIva0xyaHgra1ZwSS9JRlc3UXVuMWpTdUwzYnkyeVdLL253N25Nbjh0?=
 =?utf-8?B?eTBkZmxHU3VHbmk3WGE3OUZVSkhSOVYzeWc0NU1ubnNqdDZ1UzB3eHhxbzNh?=
 =?utf-8?B?SmNrZzJSWGhxZFpsSmpOZVFIQUJRVkZyQ2J3dDk0Q3FDOGVpZlJ2R2k5dTVM?=
 =?utf-8?B?Z2t1akZRSitUMHYvbXprNFJ3RWw2NXVrdlcyWWlobDgvL1drVmJETHZBRDdr?=
 =?utf-8?B?MkY1SzdQYzZvdnUwUDRraTZKeGYyTFdIN2lkUFZJR2xvUmtENGVJSWJTZGh3?=
 =?utf-8?B?cUtQUS9UY3dwQnFhZWhTRGtFbVJjYVVWR2NGRlRVTkFONUR1elo1UlUyc2Jo?=
 =?utf-8?B?ai9zS3VZQUJQWG9XbVVtZ2dKbkd0cVdBUklBQnlFUHZmYVgwajRMeUoxMm1S?=
 =?utf-8?B?WU1lc2o3Yzd6NlZMazUwa2JVY0JrdGg5WFVXSUl1N1lkZ3Z3RW9pcEQwMkxG?=
 =?utf-8?B?QUptT1hnWGlkUFVxa2tmbkdvNzZjTEJIdGlYMWk1clpNYnVKQkMyYmxldmtX?=
 =?utf-8?B?UGhZaHArRS9jVERFcmJNejZLRGRsQW50REdqTlB4U0kxd3MzaEt3TlhnSmpr?=
 =?utf-8?B?QllCZkczNWtoU3N4Ylk1d1VvajZ2aHg5SkEwaEtzTC9sYktQUHFZcVJsUExs?=
 =?utf-8?B?UmlaTmR5NEVWckMzZEt2VXlqcFZmY0d5cnNkRkg0MndRakVIbU9wdDhCcTBW?=
 =?utf-8?B?eWJLTmZxT3c1R2xmaFlKVlBzSHN6d3N3ejlmWUlVMHR0QWN3bmYrYU9HL1hK?=
 =?utf-8?B?UmFqbHV1dnROYVZvRGNOYkEvcHgxSW0rc2JDT29uc0tnejhCT0Q4NEo2WSs5?=
 =?utf-8?B?YWxHd0kwaGgzajdtdmpVVllBTWVwZ2VoN0xuMUN4alh6c1FxVXhneU5LRVJE?=
 =?utf-8?B?YmlRR0RIYWo5MlJVU2p2U1RXZmw2d0E2WjlHVjFjVjZ0WDhpZ0dlSEZZbUJt?=
 =?utf-8?B?SkNyYjM1WDd0QkRUU3lzdFFJcXlQZFNmcHdxMmFYczlPQ01RTWFHL3A4SmVQ?=
 =?utf-8?B?dm8wUDI0NngrQUEvRld1YitRUHVMNUFyMmF2UmlMYUhodDIrMFc4WnlEVDlH?=
 =?utf-8?B?bWM4NzhiZm9nSm9tV2NYa0VkUW5wK0RMRFVmN1VwNXVUTUpCZWNZNDIvL2Ur?=
 =?utf-8?B?cFRxN3NjZE0rd2hEYm5IWTU3STFXTVA1aUpiQUFvRXFySWo5Q25qZzVqZ1Nt?=
 =?utf-8?B?cWdMUXFxU3YzTVh3RXlWLytlQWk5STVoMGlGTW5vZlB5WmJ4aTRXdzR4eGZk?=
 =?utf-8?B?ck1oRDhvTUhlQnd0bXlXTlRwUGdCL0xuNzBOemRBVTNtSFQwNmdCd1Ivc21K?=
 =?utf-8?B?YkhDbUs1eWRPSkg3bUtXYjdEOUVsQ05RdUhWdDBOUDk5Tk9reUFna0pOMUc2?=
 =?utf-8?B?ZENVdVY5YWxqV1hqWTlzZFAwUGxIY1pkWUdRZ2EyejRmUWJjL0VReHc1L3lI?=
 =?utf-8?B?YVhKcTQ3ZzMreXRwNjlCRnFDNHh1QW1YU1JSbGkzdzJVRVBnMEg2WWQxd3Iy?=
 =?utf-8?B?eGo4WW5jaWtHNGpqWnRzYXJnOWFrU0JDcWdVZEpYZXR3NGN4SCs0V0hnN2tS?=
 =?utf-8?B?MFd2eUMwU21QOEh0MTRjbHdKMHFoUmg5VGtVVUZGVmNPdFZpQmdCL0hmZ3pk?=
 =?utf-8?B?U3FuM3FSWFZ0OU1uK3lQMFFUcXJ2UStNQUozMVdJMWtOVW1hTklBOXNaRUdG?=
 =?utf-8?B?L2x0alRMbVgyTU9EcHRQbCtTeWlRTWpjMXFNTnJOMXdnWGR2Q201eUZwOWtH?=
 =?utf-8?B?NFVoY2M0dGpiWWFaVC9GdTdOa2FGaDhDOVhiU1hXY3M5Mm4yZ1UwUDdIdlh5?=
 =?utf-8?B?ZWZnN1FtUDNRZDBERk9yRDZ0dVp2RzVxNC9ONDFZbTAzT0wrdER4bWdYdDBR?=
 =?utf-8?Q?qL/lvhuR1r9lAudc05xTPlG5r0q2rrC+0XqqLkXABAkB?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a89241e2f87e414295adc7746ecf8b41:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	11141a7a-cce5-454e-1631-08de67283386
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|1800799024|376014|7416014|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVlN2l6eG5CZkVDaUxXdzNSOFRGUUlySzRLMmt2c3BBTzN2OWZ2NFUwRFdn?=
 =?utf-8?B?R3crazA3d29RRDR3STAvdkRVM05HZXNFZkdTN2htN0tnZ1dsVFVBK1J3V05E?=
 =?utf-8?B?dTBESDg4QmwxdlZjMjlZL2FIM1VZanZLRWV4ZnZsQy9ZOHRyZS8veDBlMlNV?=
 =?utf-8?B?aytHYktScGlubnZid1NseXl2VU5pZ1dBY0tlWnYzb3I2SHJpVVM0TzFzODFX?=
 =?utf-8?B?TGQxa1pydTRBbWNDY3RCRUdOTVhBVy9DNzZGREx4UW0ycnUrNndJMmMyRFVn?=
 =?utf-8?B?YUdPZk05ZGZvUmowVlNOaUlWMjZFekpLTDl3ME0ycG5XekZodEorYjB0dWNT?=
 =?utf-8?B?TjFiejFXdFV3L3FaSGdZOE83MUt1M3NISjJ3dnRMVXRPLytRSFl2ZDZueEpi?=
 =?utf-8?B?QWRsMG5nSXdlK1FmYjJ5T3dtcGRVTnRiQkxiQ2V4L2hvTkVjamRQTVhlcFVo?=
 =?utf-8?B?TnA1ZzVRcEY0RGtPWEF1Q1dQdVpMNzRHMzNqbmFOemFKNzVZblI1Yk51NUVT?=
 =?utf-8?B?TXJnVHdicHM4dzFCeU9qMHo4VVNiUDFSVjFLWnBJK3hzVlhFNlJJZUhsVE02?=
 =?utf-8?B?MkhoS25BVVhKL2l3VVhRUXpoeDRHemlUN3hqTk04LytPWlNDeWZ5M3JnZHd4?=
 =?utf-8?B?dTljd3JsMDlPV0tKNVlnNGh4MXFUTTRwdkJtUGwvcUpCdnQ5RG1JN3pEamM3?=
 =?utf-8?B?VVB3ZVVVeGRrMnJZYTczY3N1aTNqeW8ycEJSbEs3VGprelJDc2VnSW5iNFZ0?=
 =?utf-8?B?WEZNSkp2Si9Yd2h3ZWdURDRtejRMMVFMNFQ2TEVmUG1vTlk5b3g5VFRuT20z?=
 =?utf-8?B?dkhHRGQ3UHFWWkc1VlFIajFoMW0weHU2VGRFSGIyb0R0YXZ4MmprdGcrZ3NY?=
 =?utf-8?B?dmp0cUlJN0Qza1JIMTBXcVI2cXdTbFo5UE80ZEZOYkh3L1p4di8yTk1mZ0ZS?=
 =?utf-8?B?M1lDZHc1MUNhOVJvS3RNMmQ1WmdUTDNwaEFEUFJuWjVOQS85SWpVQi9xZFBx?=
 =?utf-8?B?d2ZWL012NXQwcm50ZVBaeUdObWxrYnVMOWNGVGpzMjlnY1dLNVNRa1MwdzJY?=
 =?utf-8?B?My9IdVMwODY3VlF3bEo4WUJhWDBPeHZkWG55RENtSTRUUUxOa0gxS3UreE53?=
 =?utf-8?B?WHFVSGxVR0ZxTEJqTzJTanIzQkFyMmcrZ1lqNTRzVGZ1ZUNaQ3M5bHRHN1RB?=
 =?utf-8?B?WkpnTnlkYjFKeWpLbUluS3JhRFk3SnBPNEJrS01zZytWM28wQkhFQ3lUOVlT?=
 =?utf-8?B?Z0taYjZ6UlJiamZLcURwMmd0NHFVMEw1eVFDQlNLRmloL05jbVFnRkVOcEY5?=
 =?utf-8?B?aW1RTDFZbUN5RndLZklPcmRPUitqaGZJWW1PSDdFL0tKd1ZrRzJxSDFDc0tl?=
 =?utf-8?B?NGxyNG9yMW1aWVEzMy9IL3lVWEhBRzRkU21sTExNYTdUcHlITVdOZ2NHdlJv?=
 =?utf-8?B?OG1uSVYvZnBDRGpVMTY3WFo3UEpsNEluRGZYOEp2d0JJYTh0QWtVbmN2WVZh?=
 =?utf-8?B?ZEJOUUUxNnZQbkhpUDl5RzV6RnNPVTlMMXFIMmNXSERPeDYwbGxsbEE4K0Z4?=
 =?utf-8?B?STNLbHl3MnFFTmxuSktSekllSVQ1MHhMTHBxYWpWRlRCOEd4OHJPY1VraXdY?=
 =?utf-8?B?cEdQdE5ZZlRyZEc4RXB1NUpmQWZ6N0kxb3IzdGhmV1lkQWk3R0ZLM0JKSXNz?=
 =?utf-8?B?WDVPZGVrMjJTSHkyQXNadkt2VXJ2anQwK0YzMWhaTmx3V2Z3M05OSUlMMXRQ?=
 =?utf-8?B?WS9pWVl5djlFYzBnSk5iMVR0MS82dUw5WmhYcFhOVS9YMWVDbWp3N1V4bTZJ?=
 =?utf-8?B?QWVHdHE4aHBEWC9qMEpvSGxRVXBvRXV2QUJVTjhQQ2pLdW5HdXhaeW9oNkpH?=
 =?utf-8?B?MmgwVjZqMVZVUnBnSWtqczZ0NW1OOTQ4U1ZXeTlTUno2b1ZNK1ZvTjhOTEls?=
 =?utf-8?B?Vk1ZVWpDU0NHaXNzNjdCWDlWT3dLaFhidUpWWEIybUJkYTFRQ0EvaThZWWtr?=
 =?utf-8?B?N2FVUEJLam1OVVdrVitQNVhNRlJVMFF1eVVpaWRtUTIvLzZTeldCdGVBek5h?=
 =?utf-8?B?WjNOTjFnOG1COWFxYk1RNGhFRUJHR3FpeU5tY3dNS1Z6d2Vod2l5SDc0bEpC?=
 =?utf-8?B?VmJFMjA1WTh3M0diYUpYdDVackVTelI2dWphU3pMcFdlUDZ0NHVGTC81YjJx?=
 =?utf-8?B?OGVtTWVsdXBMTUJxa0VhcWQ2Vk5YdGVtRFNDSW00K3kxQTA4dHphcXE0OEdK?=
 =?utf-8?Q?zHJ/VQ6C7IEVJZv/L2w1Jp01Vaj9H1L3ZNJS/OaaEo=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(1800799024)(376014)(7416014)(35042699022)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eZEOXs51+DGRZ4UqgxU2tbxaRCgNoCQRJIuJaFM4itcYWsm3TLxdHkCsVWEgsK0ugAdVwF1p3XCxR864xCMhueIoY7ZHs0Mk6BSygoYNXL6dTxY/UZfiPsSkrznI3/y2W/4g5oy++JckGhywL8EVHCgpZBQYVMX0x8ntz0SbQW42C7gfIZQTAELuMkxzkowfs21nA99FCRPOrZjFIHiJ2oxYn/RbJ2d9uXxyZ5NcaTnOKpWufIHkwyB72Wx8Fe5L5LNlf8F8tX1Gi3LCqO4GD9FpQacR01W3Xx8D7OIqchAUJ6tnzOMqPc02T6c6Qw8cpzWMBGfkDoC8/UJUxFfJ32Zj4At7w9jGMzoyAMwTM1Qor+jhB0BMhtEuHSfK7lFabbLtegI4akiX0vqYN5wSCiFpjW8khNSO3ecNVGpj8wiEKbNBbYchvvCIHsgEaX0e
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:23.1433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562cd626-5577-4c34-bb27-08de67283bc7
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
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
	TAGGED_FROM(0.00)[bounces-6505-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sang-engineering.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1CC321093A9
X-Rspamd-Action: no action

In-tree phy-can-transceiver driver has already implemented a local
version of devm_mux_state_get_optional.

The omap-i2c driver gets and selects an optional mux in its probe
function without using any helper.

Add new helper functions covering both aforementioned use-cases:

- mux_control_get_optional:
  Get a mux-control if specified in dt, return NULL otherwise.
- devm_mux_state_get_optional:
  Get a mux-state if specified in dt, return NULL otherwise.
- devm_mux_state_get_selected:
  Get and select a mux-state specified in dt, return error otherwise.
- devm_mux_state_get_optional_selected:
  Get and select a mux-state if specified in dt, return error or NULL.

Existing mux_get helper function is changed to take an extra argument
indicating whether the mux is optional.
In this case no error is printed, and NULL returned in case of ENOENT.

Calling code is adapted to handle NULL return case, and to pass optional
argument as required.

To support automatic deselect for _selected helper, a new structure is
created storing an exit pointer similar to clock core which is called on
release.

To facilitate code sharing between optional/mandatory/selected helpers,
a new internal helper function is added to handle quiet (optional) and
verbose (mandatory) errors, as well as storing the correct callback for
devm release: __devm_mux_state_get

Due to this structure devm_mux_state_get_*_selected can no longer print
a useful error message when select fails. Instead callers should print
errors where needed.

Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
property presence check") noted that "mux_get() always prints an error
message in case of an error, including when the property is not present,
confusing the user."

The first error message covers the case that a mux name is not matched
in dt. The second error message is based on of_parse_phandle_with_args
return value.

In optional case no error is printed and NULL is returned.
This ensures that the new helper functions will not confuse the user
either.

With the addition of optional helper functions it became clear that
drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
Add stubs for all symbols exported by mux core.

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/core.c           | 206 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mux/consumer.h | 108 ++++++++++++++++++++++-
 2 files changed, 279 insertions(+), 35 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index a3840fe0995f..b3ed3a094a09 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -46,6 +46,16 @@ static const struct class mux_class = {
 	.name = "mux",
 };
 
+/**
+ * struct devm_mux_state_state -	Tracks managed resources for mux-state objects.
+ * @mstate:				Pointer to a mux state.
+ * @exit:				An optional callback to execute before free.
+ */
+struct devm_mux_state_state {
+	struct mux_state *mstate;
+	int (*exit)(struct mux_state *mstate);
+};
+
 static DEFINE_IDA(mux_ida);
 
 static int __init mux_init(void)
@@ -516,17 +526,19 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 	return dev ? to_mux_chip(dev) : NULL;
 }
 
-/*
+/**
  * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
- * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ * Return: Pointer to the mux-control on success, an ERR_PTR with a negative errno on error,
+ * or NULL if optional is true and mux doesn't exist.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   unsigned int *state, bool optional)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -542,7 +554,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 		else
 			index = of_property_match_string(np, "mux-control-names",
 							 mux_name);
-		if (index < 0) {
+		if (index < 0 && optional) {
+			return NULL;
+		} else if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
 			return ERR_PTR(index);
@@ -558,8 +572,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 						 "mux-controls", "#mux-control-cells",
 						 index, &args);
 	if (ret) {
+		if (optional && ret == -ENOENT)
+			return NULL;
+
 		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
-			np, state ? "state" : "control", mux_name ?: "", index);
+			np, state ? "state" : "control",
+			mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -617,10 +635,29 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	struct mux_control *mux = mux_get(dev, mux_name, NULL, false);
+
+	if (!mux)
+		return ERR_PTR(-ENOENT);
+
+	return mux;
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
+/**
+ * mux_control_get_optional() - Get the optional mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if mux doesn't exist.
+ */
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_optional);
+
 /**
  * mux_control_put() - Put away the mux-control for good.
  * @mux: The mux-control to put away.
@@ -657,10 +694,13 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
+	mux = mux_get(dev, mux_name, NULL, false);
 	if (IS_ERR(mux)) {
 		devres_free(ptr);
 		return mux;
+	} else if (!mux) {
+		devres_free(ptr);
+		return ERR_PTR(-ENOENT);
 	}
 
 	*ptr = mux;
@@ -670,14 +710,16 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
-/*
+/**
  * mux_state_get() - Get the mux-state for a device.
  * @dev: The device that needs a mux-state.
  * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
- * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if optional is true and mux doesn't exist.
  */
-static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
 {
 	struct mux_state *mstate;
 
@@ -685,12 +727,16 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	mstate->mux = mux_get(dev, mux_name, &mstate->state, optional);
 	if (IS_ERR(mstate->mux)) {
-		int err = PTR_ERR(mstate->mux);
-
 		kfree(mstate);
-		return ERR_PTR(err);
+		return ERR_CAST(mstate->mux);
+	} else if (optional && !mstate->mux) {
+		kfree(mstate);
+		return NULL;
+	} else if (!mstate->mux) {
+		kfree(mstate);
+		return ERR_PTR(-ENOENT);
 	}
 
 	return mstate;
@@ -710,9 +756,66 @@ static void mux_state_put(struct mux_state *mstate)
 
 static void devm_mux_state_release(struct device *dev, void *res)
 {
-	struct mux_state *mstate = *(struct mux_state **)res;
+	struct devm_mux_state_state *devm_state = res;
 
+	if (devm_state->exit)
+		devm_state->exit(devm_state->mstate);
+
+	mux_state_put(devm_state->mstate);
+}
+
+/**
+ * __devm_mux_state_get() - Get the optional mux-state for a device,
+ *			    with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
+ * @init: Optional function pointer for mux-state object initialisation.
+ * @exit: Optional function pointer for mux-state object cleanup on release.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if optional is true and mux doesn't exist.
+ */
+static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
+					      bool optional,
+					      int (*init)(struct mux_state *mstate),
+					      int (*exit)(struct mux_state *mstate))
+{
+	struct devm_mux_state_state *devm_state;
+	struct mux_state *mstate;
+	int ret;
+
+	mstate = mux_state_get(dev, mux_name, optional);
+	if (IS_ERR(mstate))
+		return ERR_CAST(mstate);
+	else if (optional && !mstate)
+		return NULL;
+	else if (!mstate)
+		return ERR_PTR(-ENOENT);
+
+	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
+	if (!devm_state) {
+		ret = -ENOMEM;
+		goto err_devres_alloc;
+	}
+
+	if (init) {
+		ret = init(mstate);
+		if (ret)
+			goto err_mux_state_init;
+	}
+
+	devm_state->mstate = mstate;
+	devm_state->exit = exit;
+	devres_add(dev, devm_state);
+
+	return mstate;
+
+err_mux_state_init:
+	devres_free(devm_state);
+err_devres_alloc:
 	mux_state_put(mstate);
+	return ERR_PTR(ret);
 }
 
 /**
@@ -722,28 +825,69 @@ static void devm_mux_state_release(struct device *dev, void *res)
  * @mux_name: The name identifying the mux-control.
  *
  * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
  */
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name)
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
 {
-	struct mux_state **ptr, *mstate;
-
-	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	return __devm_mux_state_get(dev, mux_name, false, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get);
 
-	mstate = mux_state_get(dev, mux_name);
-	if (IS_ERR(mstate)) {
-		devres_free(ptr);
-		return mstate;
-	}
+/**
+ * devm_mux_state_get_optional() - Get the optional mux-state for a device,
+ *				   with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if mux doesn't exist.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional);
 
-	*ptr = mstate;
-	devres_add(dev, ptr);
+/**
+ * devm_mux_state_get_selected() - Get the mux-state for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_selected);
 
-	return mstate;
+/**
+ * devm_mux_state_get_optional_selected() - Get the optional mux-state for
+ *					    a device, with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state on success, an ERR_PTR with a negative errno on error,
+ * or NULL if mux doesn't exist.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+						       const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, mux_state_select, mux_state_deselect);
 }
-EXPORT_SYMBOL_GPL(devm_mux_state_get);
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional_selected);
 
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..a961861a503b 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,8 @@ struct device;
 struct mux_control;
 struct mux_state;
 
+#if IS_ENABLED(CONFIG_MULTIPLEXER)
+
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
@@ -54,11 +56,109 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name);
+struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev, const char *mux_name);
+
+#else
+
+static inline unsigned int mux_control_states(struct mux_control *mux)
+{
+	return 0;
+}
+static inline int __must_check mux_control_select_delay(struct mux_control *mux,
+							unsigned int state, unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
+						      unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
+							    unsigned int state,
+							    unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+							  unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_try_select(struct mux_control *mux,
+						      unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mux_control_deselect(struct mux_control *mux)
+{
+	return -EOPNOTSUPP;
+}
+static inline int mux_state_deselect(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_control *mux_control_get_optional(struct device *dev,
+							   const char *mux_name)
+{
+	return NULL;
+}
+static inline void mux_control_put(struct mux_control *mux) {}
+
+static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
+							    const char *mux_name)
+{
+	return NULL;
+}
+static inline struct mux_state *devm_mux_state_get_selected(struct device *dev,
+							    const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+								     const char *mux_name)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MULTIPLEXER */
 
 #endif /* _LINUX_MUX_CONSUMER_H */

-- 
2.43.0



