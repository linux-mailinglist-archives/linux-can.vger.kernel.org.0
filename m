Return-Path: <linux-can+bounces-6471-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HbYMiDygWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6471-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:03:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81421D98EC
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDE9E30A9157
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21C34C826;
	Tue,  3 Feb 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YIHQF3zZ";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YIHQF3zZ"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626B34B663;
	Tue,  3 Feb 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123724; cv=fail; b=KdXe8G0h4X/KqJOFs82ji+nd8Skuuy3i2esUfqkUVM7hk3jsAfxO5UnOfK33hHEOmtpecPmKmxT+A1grHXSEqmw8dBri90GCClOgIVDNa6a59S9SV7y7KMhbJQI6vhGlnAtftqzYChvgCQtzRjLm2bych6VwuGsiZI8SFeRmyjQ=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123724; c=relaxed/simple;
	bh=9A/EYo28auXk8IibV7c7H0RjB6JpZbUB38gMlfK8I/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DZ1noVoZ+tySfIds/lIRPF0z0EIftpw/MsTps0CP2+a9F1H+DRsesoqwZZ9GTRGIWgFdLUlJDo34Ro/BMBUM5IlBva7dkmpkIzvNAP8IjTgg1oy7ohAh88XG8mWzrB+L5xxwL1w/aPcntJbeT7x9ryJfVN5RA8EKwJV9kdH+W+0=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=YIHQF3zZ; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=YIHQF3zZ; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dqiEq6/dASqG6RYdDaS5iOxbCrwCFLm9nusEQJNQUimqJqHhnN5XPw5oNjwLqlGP+OfY09SI2rCfo9VKYRudpHgCjqo8SNB0CgQJOYKk3QBmWlvutzNXWZgx67FfrOhCYUDhhTD4pct2YYge5alpsAvDuBtiE/L6z1xsU3yaMfjL7pIiESH/Ki2WllcAGXV8Hn4Ty1x6IR3rnCZ8mwZT9iDASCd6Vi85DVU1PauJ7PX9iAB3BYGcZ33pCqFa32TwQUVs86182ayDGn60o4yJl57IUguLZ4yxo18CI7pVpV1cbf4gkUwa7spagOTr32DVXwXzWXv3VG94wfWX0MPQTQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9tmqJcwxPVulwLSuB2nmuhM0YmHBmtnG08fz3u9FDg=;
 b=x2ijIn+Mk/IHac2+t4hMZDJtWWd6AadbWD1Rwo6CF1vVoLj9MYxu8raeSYBHt2e+o+zkg9nt2mJvnD8qrR1XSb+t05LQ3o8Gm6aCaXcjetXmA2i/c7nSQiGF99TbWgrlzcMLNNThexPpSju9TcMDdfgfn8M0JUtPlBGBQNvto26Ds1U52Sb28or1fBqGiR7ZZs0i7Q09V39C0gH8VwSAoOtU5bzC+l6MX7OCF5ZHyekLptp6nmFffsfxifiVbgRPX3F6CScbqvFc0bCyyOl32ypvi/dBjqaKbAkeAg0fG6SnAQmyydL29qsFYjCTiOZ+M4TwWgXfKElFgb9C2YOQxg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9tmqJcwxPVulwLSuB2nmuhM0YmHBmtnG08fz3u9FDg=;
 b=YIHQF3zZhtzHgy8niVYHWkugZCBH1JFxOm2tjok1q6XHkjfrAbWCATTwEW0afbeabdxQIQQIPvw9/Cv9rF+q0pgN+Zv9YYDAns20syhA6LYJbIplCUan5dkitSSLAYLENkQ6FokYrIBVFy+XgmoA3fCsm627Kp1bk84VmiPYM/Q=
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by AM0PR04MB7074.eurprd04.prod.outlook.com
 (2603:10a6:208:196::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:59 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::cf) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 13:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:01:58 +0000
Received: from emails-4118545-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id C131680557;
	Tue,  3 Feb 2026 13:01:58 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123718; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=i9tmqJcwxPVulwLSuB2nmuhM0YmHBmtnG08fz3u9FDg=;
 b=pe5232wDIREt83HBI87Y5X91p/8dRjA24Eu9Y5+Zu9reMVjFDl3FvJA4k6nEy569FU2CA
 Q2QKTghXprs3J9G6kjrDoqplc/y6k3AX0IyFTdI1StrlqmvK6LU2sMLgD/bdtp6ZYMSL8gy
 mfBPPWhvoUrkTcgMHLIa3l5LrzYttuM=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123718;
 b=GRTzX9LeNVotcSBQT47bS6uUxAPrKML5RhLM/KUNKwCleOPC0jK5wyaQeLWVY1p8xImF1
 +yO2QxOE6PyInPurrKAoEQOFMzU+OtSHAbJ7xm46NTTUNVLAnFBz4xYzr7r89SH9d/2ULLp
 rCwKDIOTUKsOxMNnXvQJ2F6CKs0xJog=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXKH8h3HWm+WMVbRsxUTWQ2OuR1kRWKjzQnu38NeJQHT2wzOWy9cRlrJRbCPDkWgr8iMLhG8JewpXRqbMhrhitcjOjE8I3xEuPaB+EjujZU/hgWZUgRjx3fKquctlXxgE2UWTflTq1T5TI9uXJhYUBHQWXygkPpDYlWKimDkg1xOCyQGd7qbmZEZ9S2XrpiCoN5Uyb6462rQih/O83dxEFdV+v5iZKzhAzt9VCrW5udkr9AVLpdyPj9EE3zzaDuE5SW03xYOez6PbeNl9PgftObDtlWFoRz02eNvLvRL3ogVfP14JKFJWpUr6o0RUwT4iaAvjJLDH9xKTaTW1NGx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9tmqJcwxPVulwLSuB2nmuhM0YmHBmtnG08fz3u9FDg=;
 b=T1JC/g/liwnWTZiDPvxVkyVapz621QxIUXzofk6Q9ESmrYucD9+PCOjEpgod9iOitNZ2fMyCJmucyzt48T52QicOMAvW83NnwklJjl3rUmRv89RI4LnDZq12EuetnernOV+dJ5HwpD1TiI/fXNXwByDgfmukHh4FKC54PL47u5l9sr0EL78gJqFJhtjSAYZY5ZhiA+KurtpGyKGnNdXXLh3e9nxIc3lpQ6T4pYpYUHXiBmKlxGrbQfcDrwWWEyGaPO+8ay4W7AmZVzzFDBKZBPardPAFfBdr5aydOpoRuut7KaciVjkkpiJ7uK2E7SJM+Rdip8cPdPGYTzHGWQJljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9tmqJcwxPVulwLSuB2nmuhM0YmHBmtnG08fz3u9FDg=;
 b=YIHQF3zZhtzHgy8niVYHWkugZCBH1JFxOm2tjok1q6XHkjfrAbWCATTwEW0afbeabdxQIQQIPvw9/Cv9rF+q0pgN+Zv9YYDAns20syhA6LYJbIplCUan5dkitSSLAYLENkQ6FokYrIBVFy+XgmoA3fCsm627Kp1bk84VmiPYM/Q=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:46 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:46 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:35 +0200
Subject: [PATCH v8 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
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
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|DU2PEPF00028D03:EE_|AM0PR04MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a7550a-6faf-4c22-a318-08de63246a7d
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NmhYL3l3bGdyTjFBNSs1QWxTMjFGNDIxeW82M2pCd0tuMVkyZGdLdTFZdFps?=
 =?utf-8?B?YkRjKzZhOXk1cnpsM0x2cVJLQ0JoT0J1ZGx0T2kzU3JzNWw4RXQ2OXlHLzJv?=
 =?utf-8?B?TWNVZWFHWHA5a3EwZy9nUkQraXNtZ3E3SkRLMEc2RTU3OWNwTmhIMW9iZHA4?=
 =?utf-8?B?cUR1VHhzaGFsaEVNOUorN3VLZGpTZlF4LzYrWUplS0dKQUdLTjJXVklRYkln?=
 =?utf-8?B?WTRXcm1zQk11a0xKUjN5TkZVRjZJdUJqNXFOMGhPNXpvb29DeGh6ODFIakVT?=
 =?utf-8?B?ei9abE83SW9NUkUvRVBZbHRjeUJqZUwyZHQrZTJ4Zy9yaEUxaUsvbk9mckI4?=
 =?utf-8?B?OU9aeXVXZ0U0VkFXWnZDUHVqVFZocmhRcUkzSE9XQXp0TGNuNWhsVS9TdEJT?=
 =?utf-8?B?U0diVHFJT09Mem5wcUNsME1vNTFtSW1NRzFJNkphY2E4SDRTaSsvaHdhc2pv?=
 =?utf-8?B?WXhBU21ya1dFRlpUbncwR2pScXV1OUMvczlldDBmQVZ1S0JvWW1SV2t0V0Qv?=
 =?utf-8?B?dXlVZDlQTVdiRC9YRHUyM01tQm9vTTFHVU1WNWZ3SkkrOUs4N1hEa0pGb21Q?=
 =?utf-8?B?Q1RTb0Y1MzlKRWc3T09KYmF2Nmhya2t5Rk9TUWxqK0Y2R2crb2tyZzZhdE9l?=
 =?utf-8?B?L25kUkhZT1pFVmRXWlVXZDI0b2RsWGZkZXRzMjhPQnBETmtHaFRZY2J1eE1F?=
 =?utf-8?B?Y3BReEFmdUtpVG03OEdiZzA5eW00UFh3aVo2S05NbzJYY3pvSm5IQUFtRmRm?=
 =?utf-8?B?ZU56ZzZiYmduZkY1aElzQ2lNbGlHNjNHUVQxSmJHUEVHdmxtYVc4STBJRHEw?=
 =?utf-8?B?clF6V2FFSTgvZjF4Q2M1VlhjUEhYRWJ3LzIwTjVPOEdTMkhETzlaM1loV2di?=
 =?utf-8?B?ZEZTQm1RNlBSd2tpMGJTOEd0SDd0NVg0ZU1yakV2NnV0dEZSQm5TVUhUNm1D?=
 =?utf-8?B?cFJWaXRvcUpKUXE1VXJ0ZGszOEdidElnWVJ1eDdaV0x0V1NDYS9WOW9qVW00?=
 =?utf-8?B?NWY0WHVTSEFUdk80SUppRUloVHM5bXVxemxkWGlpR3hTUmdobFdIc1d5VzlM?=
 =?utf-8?B?LzNJREJGTTlLVG9NMjRWTWRHTTJ5YUllZnloci81QXZ1dTBDRVpNcGR5dHBY?=
 =?utf-8?B?czBzSnlkQWxTNHlMSkxDOUVsME5rOWVxejk5YW1aTmhZRU1USnN1MDQ5UDgx?=
 =?utf-8?B?Ry8vclROdHhuTm1ubVpPc01pTXB0cHdKZGtVby9nNmhKNGpvcDZoTWlqMGdj?=
 =?utf-8?B?TklicjUxcUo0UFJkSUJDNCs0dmJmbEk5ZWVvazRpZXkyZ3lucHNzMS9ITHdN?=
 =?utf-8?B?RFZVZmgyZ3BKRDJNSlJvRjJ2UDlra3ptSUlQR0MyU3JBU0tvVkhGY3VvemVm?=
 =?utf-8?B?STVoZWo3UzRWZTRnZFYzYTlyTnR4UnJnRUxHdkwvbkRTbmFsWkdMUnpsbXVs?=
 =?utf-8?B?M2RqaHZCek82ODBhODZNTUlqUkJBWURMUncyYlJPSVlaWUZXTElORmw0U09W?=
 =?utf-8?B?ZlQ0QW9YZTE3ZU1QQnNBaEVGRmRYREtmaVhpY0hSZytwbGpmeXlPb29qbGR4?=
 =?utf-8?B?RGR2UmhpR0k5bEpxMGVIbzFxS24xMm13NmpROGNDQ2lIRHpaMS9QSVEyMng4?=
 =?utf-8?B?WUhjZ0ZXQlVoVzkzZzV0ZDc3UzVkZGpaaDQyZTNZem5NQk5TdHpLRXUxUU13?=
 =?utf-8?B?Qkc3VXJNcWRCOHJ6YzJXYzRnRW53dzdTQWl3bHVCN29MV25ZdHY4QUZxUXY4?=
 =?utf-8?B?NjMycFNVUEZvTGhUbjhEWWlTTHRuTVJnVDNDck5VaUlOeXZENnVhb05DN01i?=
 =?utf-8?B?SHgrdXlneDBUVk9jN2V3VVE3TzZOMmNLSXptc3V0TDFZRFZ1M2hBajdQTFNR?=
 =?utf-8?B?ZEFOOEdORFlYZko0UzAwamRWRzBBQnBRNzFNekxldzZ5d0h6RXZPZWZpR0ZW?=
 =?utf-8?B?bDNuRjJJV0Y2NTlkMng3QXEwUjVkVmFnWXBBRkJGNVZEOGtiQ2YxYTJNcHBk?=
 =?utf-8?B?QUU5ejR5aDY4NnE3NUxHSXBUV3RwV3l3Z0dNL0tuWU4xNnJIMm5uTk0xbkJV?=
 =?utf-8?B?aEpNR0dUR0ZIMDlrTnZxb1l6OVdCRGVabzFqQnkwcmM2Y1pSYS9RaEJLaFdk?=
 =?utf-8?B?aWN3aTJMY29ITnBneUM3RlRMdWhvOTVlNmhkS2UrcG90TVBhbE5UMS9rY1pX?=
 =?utf-8?Q?+Q3aAaowuPUAWhYSzZBAicUnkHlQwA9nyn00Vt5XXIFH?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 70bdf91d9b2f460b8a022b50788b2733:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3d2a1f80-8291-4558-1c01-08de632462f3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|376014|14060799003|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?encya0JWYXljUlFIT0ppRmdnUWUySGdHL09IejBiSWRSL0doQ3p2a3BjL3RN?=
 =?utf-8?B?a3RmSlF3NVlCTWJRa05OK2JUeDc4eUpZMXg2L0dUL1JWK1NnNnpSeURhcmRr?=
 =?utf-8?B?cmN3eS9wdXNXcHJ2dEpuUi9vYllqdHlySFZyREZnU0tIMmtYT0VpV3UvdVIr?=
 =?utf-8?B?V3NadjBCKytCL256TUZabVptczdHdWJmL2w2ZUFoQTdzN21IdXBvdzJaeHZD?=
 =?utf-8?B?YW5peStRMXJqMC9TdnRPTGkreEtCQUlkQkZ6TEZsZWZEUm9nRm1aMitBUEtL?=
 =?utf-8?B?bkdqUlMzeHNVTjJCdUp6NEhvN0xZM3pRYW1kd2J6SDVuczl6M3dUUXkydkZI?=
 =?utf-8?B?dVg5QmZuUVRBdklzRkN4eWZBeUVML1FhSlhWMG9nVHVjcXFpQ2w5dVNtVEtK?=
 =?utf-8?B?ZEg5QWQwSW1MN0F1dHU1TGZqdHNMaWZyMGZmM2poUUV6RTBKMy9RcTEySTcz?=
 =?utf-8?B?OXFkOWpWNjJvcWRDNjFjS3ZwejZSeVhGQi9RNnR4Rm1LUEZqOURpRGFWZ0NG?=
 =?utf-8?B?WG1KekwzdGJuN1VhTlluZWNUKzQ5cDcvVXluRkRDZC83TVhiSFAwb1lVdDVx?=
 =?utf-8?B?eU9kNDJXVzZmMTdhV3g3NE1MdHRwUytidEVjU3hCYnV0Y0EzbUJidEZ3UDc1?=
 =?utf-8?B?YXo1Sis1WDUxbTMwc2p5MjNCb1hDNGwzdHNZMU02YUxadnNaZ1djSDdYMjlS?=
 =?utf-8?B?ZXhYREY3aDV0NkRSMUhwNGJOQkR0SW5KKzYzS3IwOHlNTUE2NzNmSmt6Qmow?=
 =?utf-8?B?Uk5wM043elp6Kzlhb2o5dVRneXVFdURLeXhkWnFrVllYTkVrUmkrb3ltV21N?=
 =?utf-8?B?elpnU2JKcEdpUE1VbkxRZHRvYTNyOWtJN3p2T2JQMGJiV1V2VFVHSmh5MTRZ?=
 =?utf-8?B?R0F2WWRMNnhjQTR0ZHhDNmt6d3BrNUE4cTVEZ0VBME42alFtckV5bG1HSDJj?=
 =?utf-8?B?Tk9WMkFYR1BEQk41UjFuNTNPWU9SWTlzT0VSSWZYZ2tsZ21ZSW1GbjN2c20z?=
 =?utf-8?B?bkNpOFptc21nZU91MVNueThZRDZndzVPbldhSnJHQUxPbHFobVFMdGw0OElt?=
 =?utf-8?B?MERFTG5IaVA2Nm5KS0VvTGpINlpNMDcxUGJldXNHb1F6QmV6Z09nVXphREVm?=
 =?utf-8?B?dFYrZk10R0Q0RW9TNjBhTDV3bUpPWFRNUGZnNmFMdFJlTmVnWTZkRUUrWHB3?=
 =?utf-8?B?UUM4RldNcERXU3l2b0RTRDVsTk5STU9CaG8vQlRxaTl6Y05nNk9CRDhxUmg2?=
 =?utf-8?B?OTZTMU9PNitEVTRCQXJyT0w4MmJvSm12MGo4TWpIclBUUlVZUUVPYlBRdXJX?=
 =?utf-8?B?OUtnOHhwdVdmK3prR0lYREJGMmpsaDd0M29LNlAvYlYyODNrYTR3aEQzbSsw?=
 =?utf-8?B?Wkpmb1NCYnRhdHFwUFArZVZ1bEVpL25jczhWcFM0a0s5VjNzTzhxUzhZSUlK?=
 =?utf-8?B?aURFU3paaTRUYXhrcmc1WUtkd0c1MTRadUloejBuOGFWRWIvRUUzNkJrVllp?=
 =?utf-8?B?T04rZUx2eUtXZDRJOEhXQzZJazJvR21BazZvbTZWNHlPTjhXOFNOVXRqekNh?=
 =?utf-8?B?a1FBd081MW5TZUtuMHhaSkcvOEl0NnhzZnlKb0xjYzROVXU1RW9NS24rNC9Y?=
 =?utf-8?B?NEtLYTExMi92L1Y1bEtwSHFxSk9RYS80WEV5V1ZvLyt2NkZMdUN0UVRoM0tw?=
 =?utf-8?B?SFREbElqSXRiMTNoRXM5UVpMdnZUMG44OVBRMWFMK0Nzb2gyYTRRVUxkUTZZ?=
 =?utf-8?B?dzhJY2NhcExwcCtwWEJjaGMxM3phVzhyK1RsZ0V6aVF3YldZWDNJNWhUTHNK?=
 =?utf-8?B?VnlpdDZwd0ZicjdKTWx6eStZaGpwYThnOGszQ1hTZ1MvTm5MNjJpVVFjRnNx?=
 =?utf-8?B?SGdwMmRFcUkrSzI4Z3lzQjRndDkxVjlSQUpxSVpwVkFDcUZPa08xK3dhQzIy?=
 =?utf-8?B?UVBwc0lPdWRYaXhSbE1PbU1ldStnNFdJRlNJSnAyMzI2Uk1nSzZaOVhhc0V3?=
 =?utf-8?B?cXpZNkR3ZUhpdzNFSXVuM0xuSUNaUTViTzRob3R5cDVOdkMvSGluYUFCSU1l?=
 =?utf-8?B?R1ZTL3NSdW5sZ0xjb0M4V0EwZEZLK3pybGZuYU53a3laamMxTXcvV05aREda?=
 =?utf-8?B?cm5XL0NYSUxtaDhGUk1ydEUvZkUycTZFbUg3VFdJQ0E3bmZoZGdTdnNtY0NE?=
 =?utf-8?B?RW9jdG9tR3EyZGYxOGVSajNGRjVHMGphSCtBSVRxNmxPZWhSZG5HVmE5QzN5?=
 =?utf-8?Q?KX7PUVnqxR9/4tw2zcG5Nfm833C/8zSoSqBANfAyQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(376014)(14060799003)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HVPaYVOF+/jswF8qy1o/ZqSnekXNd0glS0gxbCKvKnSkp5dWOalw70LpNOYMLLz1WThSUWTn3mEouJPJ+0U13dl0wH0T1JcuyyI95MnjwiI2vp7wOlEtxx8kR/d6qyBo3RAFfE861kzDC5+1wVIGuv7j7glhWoxnDf2iStDlUxLTFKuWbuaIwb1mnejCE3+3OiJb7Obkq7VECy2m42N+VVP1VB8XvXp8Vkb5pT1zMWvPi12tTcUqtL1due4xjzyTTWdoNy8gcgNwQDEW5VX9IiYRG2lLTgswnfhfg6wqp1ixOPFiynqt/YSo9YqTOiohNHhUcmpglOBLb9TWVLd79Vi8/2bXrUkouNW/Z8xej2ZFanpqAJOJfg/3xozD5fahC7y0ZleYHRtkZ4ULAMW9kqvVRszcUhEglLyaHM7kMuZFreDfhSxZR9Wl4l1JH3Ax
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:01:58.9353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a7550a-6faf-4c22-a318-08de63246a7d
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-6471-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 81421D98EC
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

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/core.c           | 205 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mux/consumer.h | 108 ++++++++++++++++++++++-
 2 files changed, 278 insertions(+), 35 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index a3840fe0995f..2e8295e3aabe 100644
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
 
@@ -617,10 +635,28 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
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
+ * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.
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
@@ -657,10 +693,13 @@ struct mux_control *devm_mux_control_get(struct device *dev,
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
@@ -670,14 +709,16 @@ struct mux_control *devm_mux_control_get(struct device *dev,
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
 
@@ -685,12 +726,16 @@ static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
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
@@ -710,9 +755,66 @@ static void mux_state_put(struct mux_state *mstate)
 
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
@@ -722,28 +824,69 @@ static void devm_mux_state_release(struct device *dev, void *res)
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
index 2e25c838f831..3ede55b907eb 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,8 @@ struct device;
 struct mux_control;
 struct mux_state;
 
+#ifdef CONFIG_MULTIPLEXER
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



