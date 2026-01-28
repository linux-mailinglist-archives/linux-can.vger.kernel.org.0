Return-Path: <linux-can+bounces-6342-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAyGBaciemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6342-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:52:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E322A33DA
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBBCF3090911
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A172361665;
	Wed, 28 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HvpIY5YB";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HvpIY5YB"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023119.outbound.protection.outlook.com [40.107.162.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2E298CC0;
	Wed, 28 Jan 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.119
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611601; cv=fail; b=EDIo0DpCn93/iLCFQ8ks/Th3u+m9dcT/DCjPVMEt4JvHEjiCDvygBWH22HLOt76Js4lgAvgooR9JdUMgX4GAAXFV8dBNzvPjXXQcDOJRvZ1tOOPOtB+sEgTHfk0cLn3MQSS4yD+LQehGZ4WqwZ19zsPXdY0zpW4PwWB8cYW97DA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611601; c=relaxed/simple;
	bh=KtFa0ZbVU02zVCjGIJbMfjxmw5gLWgwDuOX3EikYKFE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P818dPVXTLF5oGxyw9V5BI3h1LeLgNzNk7outy/7ZaYJXzBtRmGItXZtQQ5LNqj+jpAYN2xlvYnDtNgajFm9RRlDVaGgnZ0cH36YLgQPHgQO4dTk6HuTpjZU8BWsjTXyhq3gut8RQR7l1q4/RaKMxoQgvwy1QXblXaqL+hjEKX8=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HvpIY5YB; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HvpIY5YB; arc=fail smtp.client-ip=40.107.162.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ee3Pakrw5bfPIVPeH7AUWNIKZe9dhilHVqk80nz7XggbfP40rWIl0xVaxQjl1IjDIQes2Rhw3TUhv7OmwWtVA6E1yk+9Enp6OayYTHM/7aaAsjVrLxc7naNqdLwY5zf7PDqPy9tWkXRxnCJOEHHyoTf7c+LJMkCa1rDDOMIQx7axSnCd4xMRSGC0U1T+RfNf1xLGhOe+XZDvGY4F2KgOKqNkLABZMnzFEVLqXhwCqA/2sdChCTfxBhNTVTxit95f1WiEZCknJRNaxvOI9xTbWMcOS9iOh58Vlz5gO+zXIo0yfz/76paKr71/cP9QEDRzUm+ZPZ7+G4c1N86XXCvziA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=KIPNe0HvLvLbo5XY65ggaB8YFpFwVKK3rjqJAOs1Bca0jJ7r2pb5r6wiy5fKMuomQZGTpF72KHhMM4MDToXaxu49UMpSvMM4ZiS6KRxGB7f0/dE36ckEulXLtvUZlrEeZ+do3dNYnEsYuFx6Tz3tMkO+7QND6cAIprG6cDgYl+TKZhUZiXLs+2JhTSeY/gd/o7JphJq+omKy/0tjDW8Kj0zFM3pRiZkt8sxM+daDyDxhCOMzi6ujY6KlZjp4nhn8hnICIHNZ9eMwhhsR4IBDN21hdD6ymS4Cr4NnFw4ls/bhWet9cpZm8pIzDgJjcNqBgbZL8BAiAFjb4CBby6WXZw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=HvpIY5YB+PyR9EKw+UzIBp8wAR9GxA1W9HSgKWbGIcuBxQaJHB6jLU2eZ4jc7nvP8qanAml6aYwSflDdhjjA1NfWjS4qMDvSJ7qJ3Kyjt9Wzy+O2C2b0T/HowHY4m9VaEtOfJRiMEoZuSj25jQWn7sOE9FkI5eNfuI4DyDmsjaI=
Received: from AM9P193CA0004.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::9)
 by AS5PR04MB11417.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 14:46:34 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::50) by AM9P193CA0004.outlook.office365.com
 (2603:10a6:20b:21e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:33 +0000
Received: from emails-3759714-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-155.eu-west-1.compute.internal [10.20.5.155])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 404D9806E9;
	Wed, 28 Jan 2026 14:46:33 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611593; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=Ne93m8SbO4i4sZQRft3TznWaDa9zoSgIAUFFL9wQe/iJ1MlDWLmLGZ2flBo3P8DHfL5nt
 tBeuydOqB/kSxTtNixGxVLAfJ5n/1XA/vpqWqPrICrtq54s6IzqGkjN07SpL9n8l3flhlqz
 kJrBgTYwaJWdrBwAbDVMCamSYtNNHj8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611593;
 b=EwRtaKCQulo4se0gIir7p9Pj4C/kLYRtJlCGddsvnRlHDwOofiN1eK50COOsYr+RbhQDY
 OadTXzu12xFlRCZdufX/w8M0XC2Skw3kBK8UkdFF/3NSPE71ExqGAMOHTn/jduq/oR0r9KJ
 J8hC4XtBMYjoizXB/QfKdqDf1LU7RJs=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAFtenrkWBu4fUJvPiRBstU0ZeXN3DiE6b0Ubrn9aSiPDvi9NIVOieWDQcOOG7R32LnV6tOevKRAd1or8esUR+SunbQfbTL194Cz/rF5KIqKypYQ79R0Sasql9BSJ2QfZ5nEoRO29ySDsElUupxfWhTL+TmD0Ff/En+vihtYGet6Mr4v+CRJO4hmaBjcSbPv06L+EJjKp8HwLTpySXP/jVQ8VXEPc07svupCsDSXYkS6ZB85JfPZrKSRCMCGnJWqK5Y9TwmE0XB//CoumZae1sadUsVdpx1VEBv2fj6Ri88b05yNPDUJVtdvdmRFCEUNnZ/DcES6APjhjsX6IZEjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=Oe99lrUWS6Q9/y7oii3J1Qf1PWI3qUswCnU5f65I8RXY8vPhcAd6R8+767wK57yiLqBzO22tr+jq3Rt6W4C2dfXqMWn9RpRPlGQ66I7suv69sxMUA4yw9s4SwD1CTTu2cAYeqD87g0nIgml0BklnX+e5LpgM47qDmlZ7p2sdR9CXPqRap66FPiuAYqehmrJLRVrgaGtPQ5edySwNeFJda7zzD/H7icO7n33UfGvFm9ZAQlx9oDOqFvhEhKL0naGDlsntJix+gOMnsYNtQ6c3XWa+UwEXStritDxHRFUfpfC5LJrisowXxpkbxIBcxrjiV39LyigAnDXNw1zDXl8SIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=HvpIY5YB+PyR9EKw+UzIBp8wAR9GxA1W9HSgKWbGIcuBxQaJHB6jLU2eZ4jc7nvP8qanAml6aYwSflDdhjjA1NfWjS4qMDvSJ7qJ3Kyjt9Wzy+O2C2b0T/HowHY4m9VaEtOfJRiMEoZuSj25jQWn7sOE9FkI5eNfuI4DyDmsjaI=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7289.eurprd04.prod.outlook.com (2603:10a6:102:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:46:24 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:24 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:11 +0200
Subject: [PATCH v7 3/7] mux: add help text for MULTIPLEXER config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-3-92ebb6da0df8@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
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
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7289:EE_|AMS1EPF00000046:EE_|AS5PR04MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f633b9-9694-4ac7-a1ac-08de5e7c080a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TktXdnZFZnNtZnV6K2ZWSmRGaXVpY3hQNFZtVkR3QlJtRUs3bzZxQVB2ZjJY?=
 =?utf-8?B?VTVxUXZQM2V1OUhtQXI4S1FMcXNHZi9zeUNpOGx2NG5uL0NkZ3hFL3dlNEpy?=
 =?utf-8?B?U0FCQlpxQ0hrc1d2L1hES2dMZDNObE9PQ0J6Z3JXZEFta1JXNlkvaDllazMy?=
 =?utf-8?B?TVlaaDl5c1RrakNBUnJsL2kwaURyY2ZpWnJCeTc4VCtjblRnSWNVZHNlTTd3?=
 =?utf-8?B?QnJlT3ZzeDZpQUg4SkZlUi9YdzExUS85NldhMS95elNDaEhzb05HRGpaUUVp?=
 =?utf-8?B?RloxL2xOYWNkWEdkeWM3ZytteDZiSVhDNlZUcGFDd1FVVjlJalZIRVI5ZnIy?=
 =?utf-8?B?emFETEJnQ0FIazNPdmRSUlVuVUp5UnJDVGJGQmJwTGk3K3oxVDI2di9lLzlY?=
 =?utf-8?B?c3Q0eXJUc0lSVUhYWENtYW5pb3VNRS84aTBJb0d3SjhSQUwwZ2Z6NmRsTUph?=
 =?utf-8?B?dVVxQW9yQTJKSkF6TkpEZWZIZTI4YkEwczN0VWRLRUU4MCtsdVJ1bE1qNmcz?=
 =?utf-8?B?a0NZb0JRditJUEU5UVM4RzlvK0NETkErKzlMMnJpQ0lGejREWUhialluOE5z?=
 =?utf-8?B?emxjTnBxencxUHhBb05nM09JcEoxMlNmNU94LzArLzR5ZFN0WFN1V3BQWnA4?=
 =?utf-8?B?TUduQmVNSm05L0pnMGxVQ25NYTRQOGFCbWloWHlndTZrVmpucmdCSnJiZm9O?=
 =?utf-8?B?Sk1mSDNNZDE0VFR0TXVhUTlJNmU4R0Y2L3Y1eEtBQW5TckJkZjRZSGpxMFBj?=
 =?utf-8?B?QmVLQ1p0dnEwMWJtSmgzNitJeU9BOXFFOFB1WDN3elJhSitZQ2xINHBuN1E5?=
 =?utf-8?B?T3JqdFk4Q1FTOW5Lb0ZWVnFySUhIMXNkNi9OYXRRWlRCc2pTaDI0SHpDSzU0?=
 =?utf-8?B?R2I1d1lBVy8xOWJLTFVBY1dnMnVsVVZIVEJjL04vWDc4TWVyYWszdTBTdG9G?=
 =?utf-8?B?RnNMWFJHeXREUUVRbnVnZGhGOXkzQVBjR091cWNUd2V3dytJeTdQNmV5NG51?=
 =?utf-8?B?akkweFdGdVFXdUpyMi92SnRvelRwZUtIT1JCOXFEZ254bDZRUVdkaUd3eTdK?=
 =?utf-8?B?T1Z1bjdPb2JzOGRLdTg0T1pWVVVSZDBncFAvWE41aEJrUURCTXI1cFkyRGRH?=
 =?utf-8?B?NmdneFFvMkRTTkZxc25kTWlmL3Nyd3dFT1dTaGFBcFlDdDVQTzFVTmZBcG5O?=
 =?utf-8?B?SFBYbE01bWJlTHJDb0o5dkZFL1dmSHhUOHdsSFhHc0tGWnNhUUVlS29zS0o3?=
 =?utf-8?B?K29BZkpJc2Y3Rnc3MCtIM1A4a05hbUJoTTc4RngzSERHK0FORW8xU0JWaCtE?=
 =?utf-8?B?MkxDUmwzTnQ2dkZPYi8rTFZBbUhtOUgybG1mQ0UwaXNNc0p2K3BBVi9Eck15?=
 =?utf-8?B?OXpiMWlCckxRL0R6c1dUTUtqTWVWMGk1bnRNa1NRbmQzQXpOcHVoZk8zTlBh?=
 =?utf-8?B?Q3YrZGEveHJGRjVOY2UybDVhM1pCdGpVTDB5c2E1cytrMU8vcGJqZmJSTjZZ?=
 =?utf-8?B?T04xYU9DMzBHdXZaMTBWZG9wY28yTTkyRW9OR0UrRkdZVVQ5SHlnOHk5TXNj?=
 =?utf-8?B?N0JnNlFaRTJHMitNVTUrRC9RM3oyQzIrVGx6NmQ5SDhHSUVKa3p4YkV4VXFz?=
 =?utf-8?B?Uk9WRW1vNFJWVkMwQytEMmhTRHA0dUp5cDI2aEtRb1dESjl0MGJkTWY2WEoz?=
 =?utf-8?B?Nlp2VWtHYW1iV0lJT21rOGlCQXlDZkZHODlQMzFQcGdIVTRoRDlDTkF0cGNZ?=
 =?utf-8?B?SXFqNGRuaVNvcTJ6YXQrRlgrUHd6TENxOFl5LzBzMm5VaFN5NElyN1JPQm5J?=
 =?utf-8?B?eXp6NlIrYTdWcVI1b25MZlRqazlCbzN3NGR1WnVtdGRQcE0yRitZTGN5aXB5?=
 =?utf-8?B?NC9rT2ZLaHRpZWdoMFlzNUpvMHZIbTRaOFdLME1HdG91RS9JcnJCVkJwZkdL?=
 =?utf-8?B?OXd0QUU4eXpjelJ1MGo2RGllL2Zwc3F0eVdtTkNkaXlCT0xCSEE0OUpZWG1L?=
 =?utf-8?B?TEdteCtNSURPS3NRNWRERVE2TUlMeEJ5WFNmdGl6b0lDNUlzeEtjSXBESE1p?=
 =?utf-8?B?Y1lxc1NVeDkyN3hqK3RmKzhPSXh1RVZ0dnBsYWtqcG90TVlIQkVndHJBN2ZK?=
 =?utf-8?B?RDE1QnJiYk51ZW9aRXEyblkwTC9TSkFUMzhMVG4vYnE2dzYzc0huRUZLeTM4?=
 =?utf-8?Q?HeJQCFcZ3G9eX2pZ7oomweQG12CiCh/7GWgMPbWxc2QT?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7289
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 98ab54e507d14019bf9f0b8da16bc937:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6295da8a-87b3-4b72-bdd9-08de5e7c020c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEpXM05XUWZxQ3cyMzdtUGRPaWp5bU1PdkZYNnZXWThZZzV2empDVFdkbnZq?=
 =?utf-8?B?WHNnaGF5NFJXVXhUa0E1U0paQ3Bzd3J2UkxBZGFpRDQ1SElQeHJ2S3FyUysr?=
 =?utf-8?B?UnJ2TW9YRzduS2pGNExYNmlHeUdlbnBpQ1Z5b2kzQllwMUhscG54cnIzWkdF?=
 =?utf-8?B?ZGdhdWxKSDdnUU82UmgyTW5FQjRQYU5OU2RaNGhNUWxhT3ZMWkI3K3BienhO?=
 =?utf-8?B?WG5mSjhDNEdPbnNRaFV5RzEvSG1SK1lmblJWaDV2dFp2SWNSSGEvSUliazBu?=
 =?utf-8?B?QUZsOTBrRk1DY3ZaS2M5UXI4cUs5b2VxMWlMV2VaSDdoc0JKS2JpZUtxeXJI?=
 =?utf-8?B?NmhHRnpkaU1DbzA1OGRCKzNXbDJQOURHTDU0WjU2MXNCdTQzSko5b3VFaFlQ?=
 =?utf-8?B?ZDdxUnB2bDc2dit1VEh1UTRPUHcyQU1CZU9DeDk1azhWZEhaWlFYT0xuZWZJ?=
 =?utf-8?B?emxDQVE1S3d4RExwSUYrU0dHcEFLVlJOaDZndEtBVTVwT2NIM2c1ZHJpNDkx?=
 =?utf-8?B?TURZYjBUSFBwTEhKYWdqZnYvNG15dUN4aXVMRXE1UnlLek5sb3hXTUlhMEhM?=
 =?utf-8?B?c1NYR1ZJckpLRjZkbzBRcURhOW4vd2tCOVA3M3FkR2xycm00UFYrN2psTXpi?=
 =?utf-8?B?dUY2R3N2ZmREZStZUk1zeWRObmowaTJVa3VVZEMxOVVISTBwZGFMY0dLaHJH?=
 =?utf-8?B?dWJJaEkzaHZuaTNCaGFCSnJ5STBhaExjR2VDUXYwMkR5eFpjNHJ6eVBtNHRF?=
 =?utf-8?B?UjV3Q20zSEtodWhWWHdWUTF1L1RyTDBtMWNVSUhFNXNIcnlXa2pLd2hGdUxQ?=
 =?utf-8?B?cWVEMmIrM3ZTVTYvUlBBVDhnMXBieFA5ZW9mRGpNcTJhL3YrVWt1QXdVeTh3?=
 =?utf-8?B?R3ZMSllNMlFsRFdPNm9mN1BnSnVFTWN4eDV4ZEtZQjFOWjRHV1NEeEtNbEpO?=
 =?utf-8?B?VmFQbkErT0I5TjUyZitsQ2ZHNmtMenF4N0Zzb2dKVmJFOUFZU3BWUkl4R3Nw?=
 =?utf-8?B?bkdWOWZoR2tsVmliU0dWbk80bmdhQXV6U3hCZjRHSVkvTzByUUd1OUNBblNR?=
 =?utf-8?B?cEllcXFFcWlCSWpqVnVCQStWMXptSzJzeEkzdzdjWVNqdlIwbk9IMWFqeEh1?=
 =?utf-8?B?MDBJYzc4SVlPdDlkL243NGdBb3RWUXJ1L0EvZ0hPK1NIZUpMaFIvcU1QSnlZ?=
 =?utf-8?B?L2ZWd0dBK3NzWDk0ajFJM1hzRDk1ZmtwczdRK2hFdkNZR05oemxGRi9GbCtz?=
 =?utf-8?B?WmFwT25ObGZ0ODhYMmJUTnB5V0FKWFlhU1B6RUVJT0hVRmx2YnVnUkk5SHBB?=
 =?utf-8?B?ZFhTZWV1WmVXRVExRm1oRmVyTXRweTlKa2dPZXZTWFNYajRGQUhGSU01dHdk?=
 =?utf-8?B?RlJJR2R6UEcwcDk4dWRVb05jZjFhMTBkMW1mV0JmT1ptbVNUekJtNVBOc25r?=
 =?utf-8?B?OFJtZ1F4SmJKSVg2Y0dwVklsQlpjbW5TZlpiMnkzeGNjVlUrWUlrMGx4ei9q?=
 =?utf-8?B?QUtNRWIvenhaa2xraEFBOFd0dzdVVVh1WHlQeDE0ZVZ0K1U4TFJZYzczM3Ft?=
 =?utf-8?B?Z1JhcmpRM2N5WXFkblhkYlh5eDhqbjlqbnVKQzIwQi92VGR5K0xsbkNLaHVS?=
 =?utf-8?B?aStOUFRQdkttODdkNk00T0VPZy81VERJQUxIT0h6RW9hdHZUWUFTbUZwcThx?=
 =?utf-8?B?TklHd2R6RnFDU3dpeVdibklVa2RGUlNpT1RBdWpWR3puQ3h3YXR1OXNHNHZ2?=
 =?utf-8?B?T25DTExBZFpjOHU2VWJCQ3F5cnJyVzdzWXJZbHhtbmk1cmh6d3hUb3FHS0Nq?=
 =?utf-8?B?ZGppMjJzSUpUaFlLS2M5K0NqbFJZc2V6bGY0RkFrekRMZkQwQjJLMy9qcWxL?=
 =?utf-8?B?MHdLRGpTRXZXVVhlVkxWQk1pNms3anFlSE53UjVPbTV1Q3p1UFBrdlBDa2dv?=
 =?utf-8?B?UXVHT1RQN2Z4SHZxTEp4V3ByKzU4SlBRQ25WSDBMMjhQcDRJVW1ZeW9HUWc1?=
 =?utf-8?B?MjVITjN1NlNNRUhwc1NwQjBSMFhuK0V4bzkwUlREbllLTWQ2b3A2TFN4R3By?=
 =?utf-8?B?WU5OQ25GVW5pOXFTWEsyck0yL0NoUXUrYXVOajIxYzRyTkNlTFRzZno1REZT?=
 =?utf-8?B?a0pjYkFDYXBMSStJRnQvRFNPMHFLUVJyMW9DNENGb1VTbjRvTVJKY1R0Mmxh?=
 =?utf-8?B?RVVBNkIxMk5NZ21IZ21rd0pMRktrTjd2N2tEb3QreUkyVC9KT3kxRGxvS292?=
 =?utf-8?Q?CxOuRz0cZgC9ugK9Np79HCEtD17t1cXWKfCt6wW6sE=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:33.6074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f633b9-9694-4ac7-a1ac-08de5e7c080a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11417
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6342-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8E322A33DA
X-Rspamd-Action: no action

Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
option thorugh the kernel configuration without explicit "select" driver
dependencies.

Select it by default when COMPILE_TEST is set for better coverage.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index c68132e38138..e31c46820bdf 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,7 +4,13 @@
 #
 
 config MULTIPLEXER
-	tristate
+	tristate "Generic Multiplexer Support" if COMPILE_TEST
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



