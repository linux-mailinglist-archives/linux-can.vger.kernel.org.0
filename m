Return-Path: <linux-can+bounces-6469-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGAkCQL0gWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6469-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:11:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7DD9B93
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0488630DB010
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655DE34AB01;
	Tue,  3 Feb 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lghVEJdX";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lghVEJdX"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6D20B7ED;
	Tue,  3 Feb 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123717; cv=fail; b=OziSxeO1gswybZmaQsVxPocm5i2QSLZQcXRem5kVWQMudE3duJNd6BeT1r7wMrqANfUG9jDrhmcMXeEYeYOr8ymNaA2ayuKAm3xf0mQOXsl20C160BZL/aDp1KkEQ9Xjfqp6B1+KED7l72ddb+S3j30ZAVEMlI2RNrC8so4K6rA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123717; c=relaxed/simple;
	bh=TCuGF0DlEBjlvmWF2k7C6H69sLHZ/4JOdOyN7BnS/zo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QT9hHjF8ghF74ZvJr0OgLIVDj9Oy70l2COr2woBbBKHqxIXPWVYXFNQ9SDRcPS5sMmrw+bayZhj0O86+71d3N+jbsrtaPi8oq56ur8IgXPQanjdndPSSbXCiqW8JQto0desfWChZ47B/dlXgZB9hFjSkusrVDfqyuSaZLT+Pja0=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lghVEJdX; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lghVEJdX; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CVG+IGbEliYFSNn9bTHK0Q+7T5FhAmbHxKzDJMQwxeYyTVohlgPPZkPLENBhfgcr8NFzwI+hZnq+rt4pa0EqeOSYwDK0n8J+pk7Q8hnC1TSvcgVlhvSJFD3ZZHOF+lCgWgtzIMA960CAYiKh2dMcje2lmPbMtYQsEuXjwv7uyTFPBEs9bWuLPIMZtgmTq3rgT9wceqEXQHFw7b3mMMUeYlc2DpY2fLLKgKb9LQCGQkmy6KtCx9dMU4/f59wEplAdiFBJ2Y38CK/gYmuYBJ6wZ82bQVS8TkzQXplBcv/aCVaFzt9Ae2QfTGExOjJ8GCzXd7umBdKC/ZT0lJh7bwxBvw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz8Zw+XHFgY7YEIHlx7BJdulrJ3iTT37i7tLFzFepGw=;
 b=T4rAQCbO9SsSU27oRJLsQmIs/NqU65ooITBaKRNr9tRupL8Cbo3t5llkmiAXrTstrrtSXTwXvJtzK9tyfOZ3HcyNBHfnqSkmkWunnKv97MQuJ0HfDlll75j/5uUd/OXqFWL2gWIB68B0uuWBfi3ea3sfFyEL+pHz28loEFzsrInmvtKJ85kmJo5M7O6zXJe584TTmpr5tAt/iSzoVVJtceXBcMIYDUyQadz/0hI7eDxShF+1VGZZHJez/Kd5lwBZuQVgPss1/yoCn0NTLVOMmzo+CSB9iu5A8OOYrMXWZ+1zq8OLiCPr8NaNPr/9lItdd24N+L5Xcxaeb5YIswqVaw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz8Zw+XHFgY7YEIHlx7BJdulrJ3iTT37i7tLFzFepGw=;
 b=lghVEJdXFVpw3PmG0aQ6GRI8FHU1TsjRnd2YOmwSlToPQM4qNtfynEvvEtN0rvgskFoKpTVjKNEAwY7JGZ/R2ZdzUbr6zmaH6NLaSsaS9ke9ShPK/9qHcdaEZEyORbumhlBaG0vwGUcQXdqXbJl6a2x6fJR6ir7FyQw1MLUae5s=
Received: from CWLP123CA0249.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::12)
 by PA1PR04MB10503.eurprd04.prod.outlook.com (2603:10a6:102:446::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:52 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::48) by CWLP123CA0249.outlook.office365.com
 (2603:10a6:400:19e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 13:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:01:51 +0000
Received: from emails-505177-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-175.eu-west-1.compute.internal [10.20.5.175])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B149B80558;
	Tue,  3 Feb 2026 13:01:51 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123711; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Bz8Zw+XHFgY7YEIHlx7BJdulrJ3iTT37i7tLFzFepGw=;
 b=pWun15XiiBH7RNL4gUoMlDdBo5O9QhJE+bKw7lNlhrtDLfDapzOoe2yEQZTwYSuwaJyVI
 n7zlRKyDcFES9Glaq7hkoK8nBLyN/wlcJpyYiAmlhUqdl5hJb2Qxweq8hSAiiXLSU0obJvm
 eJPlOcE+Sq0waVzdX+BiJP3ILm6+qDM=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123711;
 b=VhRGpQY02KPau+xlSMA+XGeF2juTIFhNxZAhHxtwzElDI52faJbco0J5R6p4kjhsoWpNX
 YT1dFuPrAUa5K3DJyhKKgoYUgu5/nkpTdAAVF2b1GD0VCtAWQp7mMfgF4ixMu6Pj4TA0Rd2
 K2TLyG4JDDo1l8JqJTtoYnqCvHad1GU=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQL8fOvlkGlIrUr4uKnbzvF16oPU3ytcTpCVLBIonJq8nY2asHmd85CvQBR3Q1BJSfZtUElAcMLMUgSQ0jx8F+jMSQ0JSDA7XQp1+hXwaLA8RHa0FpGoRSg1qF2mDvX6ETkuSOgA06qugyjcfIddcPIrNCtSCjlY6t+ysXuDsZPw4qZm16TvDNyEtzQ7pRHNSw02KJezVp73gzsmzlzHtZS4zly13Ok23gB93G6KFBFmUyV6Zmyi2LZ480IbS4ETkqsHZl4Iz2rIECk182cheU2Fs3mfIfUNuHaqtWr0Ulk9ux+UHIqujVSg+8JJ0xTOVm2vqFJ1scEh48QbZL++7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz8Zw+XHFgY7YEIHlx7BJdulrJ3iTT37i7tLFzFepGw=;
 b=DVycuPECc6mhdSUtOfSmJh/05FxL5611WVhDg19L1yyeSlMENGGxVBXRKYIT4PzFMFZAwxldoG1SWeSALGSsyQayUtY83/jq3UpW2aTWKCaz4DKJgAS9OCz5UMmxy5REuMcG7vnCV4Zu4smd54geQyjkiJlDN3VaSRmQX2A44/3EyLhcOtM53QS1FjASQQaQKBJ3glkHH+QKHBBNQrzyjxMdE/gW0BuBKbO5VsbgW0w6bb/CwDYFf2L31mGNTRpW1XEV5jt1WZ19RWRiUj9f+KbkyBgYuk3oVPeBtYAiyj1W65CjVLjCdDZlfJLSE5oLN3SMwrYcg+SNTL4SEj3QRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz8Zw+XHFgY7YEIHlx7BJdulrJ3iTT37i7tLFzFepGw=;
 b=lghVEJdXFVpw3PmG0aQ6GRI8FHU1TsjRnd2YOmwSlToPQM4qNtfynEvvEtN0rvgskFoKpTVjKNEAwY7JGZ/R2ZdzUbr6zmaH6NLaSsaS9ke9ShPK/9qHcdaEZEyORbumhlBaG0vwGUcQXdqXbJl6a2x6fJR6ir7FyQw1MLUae5s=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:42 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:42 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v8 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Date: Tue, 03 Feb 2026 15:01:33 +0200
Message-Id: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK3xgWkC/23P3U7DMAwF4FeZck1Q7CyOyxXvgbjIX1kktqKEV
 YOp7046CdGVXh5L37F9FTWVnKp42l1FSWOueTi1wA87EQ7u9JZkji0LVGgAkGX5ljXmQR7PF+l
 CMKBtDwQsmvgoqc+XW9vLa8uHXD+H8nUrH2GebveMIJWEFJMGjkCqf67De46ynE+PYTiKuWvEP
 48K7j0274M3DJ45Rrvl9cKDuve6+eAIOXpDkdSW3/96UqBW9++b76IjReB6dmHLm4WHlTfN66B
 tYrZIrLc8LTyu/qfZs3O6M2g75C1vl3613873Y/KeolOx/+enafoBjhFB8CoCAAA=
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
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|AMS1EPF00000044:EE_|PA1PR04MB10503:EE_
X-MS-Office365-Filtering-Correlation-Id: ec639460-5767-4b29-41e8-08de6324665e
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZUczSzNINm95UTBNWk8wdU1taENlbHZqZDJpK2lkQVFxeTl6YTZMdy94U2Vj?=
 =?utf-8?B?WVQ1M0w0cGdTM3BIUWRKMG1GZURRc0M4cDVhSGdvbDA3V1VhdndxMll6dllR?=
 =?utf-8?B?QXJHVEttN21qZ1RKcDdtQmw0YmFHak5lVG9wcFFTYUsvbFZEYk1sQkd2Q0p1?=
 =?utf-8?B?UjFjTWtGWUI4SzNVOEZYMnIxTGx5TGU2bGdDVGVKempDQkpMY3R3ZUQ4MTZL?=
 =?utf-8?B?U3lCYUZKeUdNZTh4N0NVNmJiaUN6NzBEMWF6a1hwUkVTWWV5WGgzaE9sL3Mr?=
 =?utf-8?B?QkhHUDZPTDUvSzVjMGh6ZzhqM0NRNEhrcXV1QmFzeXNyWmNLbHB6NURzeVJS?=
 =?utf-8?B?RkNwUG51S3haQ0RhVXBoREhPQ3ozYTJSNGF5S256OVhtWWpJY2MwS05GclhN?=
 =?utf-8?B?S2NuVGZpT0NURndkSDZyd3VDVGhhMEdGWS8xdEhOTkFqeVFCY3hLbHdnQXZI?=
 =?utf-8?B?Vzcyck9VYWdvZGRjeW9pYkt2dzVnVlZVZVJwa0dzVTRkY0dUUWNTbCtFZDhu?=
 =?utf-8?B?cDNzNVdmL0owVHhGRVpDR3lWZ0w5R1VzM2N2anpub1AvNll0T29lK1EybmRw?=
 =?utf-8?B?TFNqaTNTL3pGZ0lHMHVDS2lOR0hVWUVUSmxQYW1mZFdjc2J1YmxYTU9wZE9O?=
 =?utf-8?B?Nkk0S1JXaVRpS21MUXBvU3M3M0JyMXJWZ1NyYkJhelQ2VXpGZmd2SEhxMlNQ?=
 =?utf-8?B?UlJ2NWszM3RtdGJRN2FkaW5TVDlZdHpJNzhhd1Z5SC9wL2haU2hXQzBxQTVT?=
 =?utf-8?B?SzcweWZVcFZyT2o5M1N5alM5dS8xckJBanpCRjJPR2U0VStWZ01iMXZVTjFZ?=
 =?utf-8?B?WExsdWJEU29TeGxhd1JPMnBCZ29PbElTaWtTK2lTbzh6T2daVlZRSlI1Um52?=
 =?utf-8?B?T1VFbXJJYXAyWDRTcmNKNm9mYmxqY0NmL2ZjenVHaSs1Sm1aMk5kUWFOazhr?=
 =?utf-8?B?bEdCL1h0RFRKc2QxQksrejdNQlU5cFlHNkh6U2hhWjExRVpISnpSSWNwclQ1?=
 =?utf-8?B?ZzJMK3IwTnp2MTQ1RmFNQnVQYWQ0TVZGOEVGR1NQZkx1dU1sNk5ESEVmOFo1?=
 =?utf-8?B?SHJCd3hXajFqK3hpa2tpdG5GZWN0NjBFT1pQRFI1N0VmM0tMMnp6cVRFUDIw?=
 =?utf-8?B?bWJkNEttUjB4U1FUMmZYR3YyWUd1VlRXa3dsc0k2S1o2cFVBSEFqMm5ub2Rq?=
 =?utf-8?B?K2hLMW8ydlZZU0N1anNQM3lsM1JYQlpsTk84TUdkSVlXQ2Y4WUU5UGQwczJ3?=
 =?utf-8?B?dnhRYXRmRXU1b2o1dThoc05pQlNYWjFOaGlWMThrREZQREpDMFVPT1B5Vk9t?=
 =?utf-8?B?eXQ4R3pWcGtUZENhWWNSUzNnN2wxMnZnM0ExRHBaQ21nL2pKaWZsMHl0MWJP?=
 =?utf-8?B?UjhBVmErN3h5RjhWOGp4N2ZGT0d3TzJyMmxNRHNhc3JiMVM4aTMzZ2JRcDFw?=
 =?utf-8?B?cU9XdUowd05nblNrUngrWG9HOVQzeW1lcDVEY1pNSlJVNGxJU211QUNEUk82?=
 =?utf-8?B?dGpPbGpqWUQxVU1VRXRISm5FbkRpUVd0eWgzUHlyNVhGbkUwZko5WVdzYVFQ?=
 =?utf-8?B?eWdtS3JjVWtVWjRURFpBYWY2NVdEbTFWL3A3NXR5UWYrQUR6RmltVXJpN2Jk?=
 =?utf-8?B?My9iM3FVQk5nMXdTSzNqbjdDWWVzMm5jVmljaWp2QXRxVTBLbUpLb29wRm5m?=
 =?utf-8?B?MlQ1d3BDaWNvSmlYSDc2eWtFWEpZbHhOSTJYbHE0MXFNeDAvL3VHMHMxcGQ1?=
 =?utf-8?B?MVZXaS9lRnMyZmFTaDRWbkc5NUpHMk5yeUVTbzgzMTUxYk1JUEcwekJzSUtW?=
 =?utf-8?B?RDJUYmdiYklDNG9RVWpVZ0FPVDZZbUI4RVF2NGI5eHdTTHdJanpISk45WnZB?=
 =?utf-8?B?VmJuM2Jud2xuYUZQRUJmT0poSVNkTHBrUXVoOTVkREZ6eUJSMS9MVHhRWEFF?=
 =?utf-8?B?VnlSVm9ZeVZkb1AwMktVN1lkOVFCWUIzQ0lNVDI1YmlWOUVzVjFxVE9pOGlu?=
 =?utf-8?B?REduZzl3SjgwYlJNR3FiTmlUTjBCV0RqYW9iQ1Y5ZWJJajY2ME1JcUhQQlhK?=
 =?utf-8?B?VUZlTndSVUNyU3Q5dGpTclFKbERrMzZsM2p6dXhnWGY0S0Vzank4OUJJTmVO?=
 =?utf-8?B?Zm42NlMwQ2d4empSVzkvVUtGVnBMNkFRZVBpTCt6b2tLN1gwNWZ0d0krRytK?=
 =?utf-8?Q?R0y5oNADPk0GCjsh8GsoVb9u8LpHn+aQMGqjnH6ELYJ5?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 0cdb429071b144d38f7af6658b8aa6b9:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	88a141b4-2380-41de-3da1-08de6324602b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|7416014|376014|36860700013|35042699022|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlR1YUhsVElBZ2h4bDBxVUpwdFFXN2VWSHRUOVl1TzBLSWNMcURveVlseENU?=
 =?utf-8?B?enorb3d3SFNHYkNXU3NsQlFJTG9KMGY3cUs5UkxkVFd1TGJwUmZ6akl1Z1I0?=
 =?utf-8?B?aFZ0L2RORVJuaG1NSzZUUkoxM0prY1hHZTdtQ3k3YnI0KytHNVV1NGM4M1JQ?=
 =?utf-8?B?a2NZUzNoVFUwN2ZRbWd5c09ya1VOU05GMHFycURJUDhGYUpMcXZWRDJEL2d3?=
 =?utf-8?B?NFRxUkwrR2NHRzdGR1p6eUZidzMxeTU0M3Rjb05IQTNMYk5wcWpJaTQvZTJl?=
 =?utf-8?B?NTZPZE1QY2h6L2lLbXMzSG5KOGpTK3VyVlI5N2N4VlBnbm8weDd4cDc5RWNp?=
 =?utf-8?B?S1hWODY0MWdnV2tweElYTXY5b003dUVsWDlSOGp0N1JiamdwaTQ4RU91MEJ5?=
 =?utf-8?B?TUFVUlNENTVxMXhwNzZNWXk3R2xFYTBrVUgrZWtERWE3MXRTZGovMThKSDJW?=
 =?utf-8?B?c1F4UTZpVkNqWXpNOXExV3lnSmNCQnFyd0dPVU5uL1FQZTMyR09SNzdMT2w3?=
 =?utf-8?B?TG5GMzdkQVRDK3BwbkpxaGFnV2U1b3RCRVdJYkF4a0FTQnR2dlVNd0g4OUJS?=
 =?utf-8?B?dkRPbEphd2kwckZTWGxmTS81eUJ4c0tVTW43UE9XUkpLVjJPOHM3ZEExa3Vx?=
 =?utf-8?B?c0FmbUVtM25HNFJsTmJYZnVqZHIrckZ0UU1nWjg5Y2diZGE3b3VmNWd0RUFh?=
 =?utf-8?B?MEl1aTVMaU1wRWp2UjBUUE5lSk9sTDJpMlhDUEVyNmRvdjdTbUdvTVBVTGJi?=
 =?utf-8?B?eTlYQ09WckVDRjVKSWRqMUV5S2Y5OUtjN0tRNi9WbjRuLzYvMk1WeGlxMDVI?=
 =?utf-8?B?RkdZSnd1RTRBRFZFY0pzeHJSMTV4Mlh1d1RTOU0yQ3p5aG1DR1RiRFc1bS9L?=
 =?utf-8?B?Qk1rSVQ1QU9ZVlRHTzhSTDlWYmhSUGdndlZoUVBQbXpyMlZ0YUtsam9VOHhT?=
 =?utf-8?B?cXM1bXBrTCt0bjJOeVdRRGNMRE0reTIwMlUvUzZkSUIzSFpMWHpQVzBmWktn?=
 =?utf-8?B?NCt5dGVsVVhWbC9OcVFDa3VWTnpRU0x5K1VkYmF4WktxTVlPTEp5eEo4V2M3?=
 =?utf-8?B?bVBKOFBybXdhc3BMQmlYeFlmaEZhTEJNWHhSWmVhRWZTZElmT1RYVDI0cGdP?=
 =?utf-8?B?WVJuS2tSQ1ZKRm53RTdyUmpNTFY2VlBpSmVhZ29HNjVwbCtFK3ZhREs2NXIv?=
 =?utf-8?B?VXJ1cHFabm9CQ1FyTTR2dnk4ell5bGRrMklMSVZBM3ZLcGRtUHk5QnYwSDdk?=
 =?utf-8?B?a2xxWk5UNy8yUVBDSmF1azVTNUE2dGhVbHVnVlRhRzdSZ3RIdzR0VEZnTUJ4?=
 =?utf-8?B?ajh2TjZ5ZTdXb3BiN01pc3RxYWF0TVJRMk5aUnZ0VFRIUm9aSnlvM2JkREw4?=
 =?utf-8?B?ZlhiYXRrR2tldkRoRS9oZEhRWXF6MGNDaldHVjQzc3p5UE16M3NZQ1dzdFg1?=
 =?utf-8?B?alc2OHBqSjkvVUhGR0Y2QUZaV0d4MDcxVGdMS29HdW9kdHRzLzVWZ0hUa0lk?=
 =?utf-8?B?dGZka1RZMW5xbHdSRzVzMHZVVWVrbXE1RDFsa3V6MTdzeC95R0Qrb0Z6SlFG?=
 =?utf-8?B?RGQ3bnByVDMvSFBIOFNsNndnc2RGc0tqZjNSTCtxNldEZXg3SmFQMVp2cFh2?=
 =?utf-8?B?UGZJMzBEUjBJYmgwbFR3eTBtSlBRR2lPYURnVEl0RS9icDEvZnBiUm0xRVlG?=
 =?utf-8?B?cnphelZKR0luYkVhWmZHZlh2SGVpZEhkOGk0SllhOFRrTlNTMWtHejQ5TkZG?=
 =?utf-8?B?RUFPTmtvYTI5YmFyV2x1bHBEU1ZsMmpqcXRiSU1YQW9tQ3VGZS9rZjhFZjJI?=
 =?utf-8?B?ZFJvQ0pBakFGSTdZUkRuVXVBTlQ4ZXdETytTVjhqeWhlbWljVlQzVWJjdFZ3?=
 =?utf-8?B?dFR1VndmUFllb0ZTTEtwZDU3UEgwb0dsUXFhVVFpeGFNTFBOK3dtMTJjdGow?=
 =?utf-8?B?cHpaWHRsMjdtL3czQW8yRm9XK3FBSG96UWU0OHdxcnRRVFhmVlhDT2J0elNj?=
 =?utf-8?B?c08wTHdLN0cyK1RTdUdJVS93MjVmeTZDZzVXT1hvWlhYaTBhVUhQOFdCTnJn?=
 =?utf-8?B?cmZSZXQvMzdRQ0tkVGVoRktRNFFSUXpTTHEzbVZwekREYXBLc2NHRU1PUEV0?=
 =?utf-8?B?a1I4S3Zlcy9qc3BLRmwyU0xvYVBHZ3gxTnhhMnBQbzBLbnAyM2RLTk02N1pk?=
 =?utf-8?B?V2w2V0VNZ2hWZTRyd3RiUnBpaVU0Z0FaSUFRUjZ5MC96blZ2bUo0QjlKcEJz?=
 =?utf-8?Q?62muOfCh4NstSCBWuNu2I31giVDOUprQcQ4fZDvGHM=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(7416014)(376014)(36860700013)(35042699022)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MF6c+CuGPa8weSALc4ArrhEoXy4XLMJSTBvdUqAa6YU2Moeh9YS2gbk8NkjbxNdt/gvwOr9nJ4JrrtDOhIgEzf9XTVxTxwxkzfjq7dEU7H+/7di5WZJWTiv+af8C5aJ5gKg3gLSZoPN58EziPytup+Cc1ZAKbyyPA/+Cow4osYGRQo+/UssDtjDqrpgKP1gBtkax6uxA4th5umAcB9RG4/URZvAwEjXTp4f3M4HuJAcCWD3PEYOD0S7g5qn6iXz0bj5bSSsDWipvQtD+vDAkrrgYmqIc32PqWO8J9Z3gRhl2sUhfv6g22rrgof1Ed7iO5sFn4m4rGGjyhdCmGaxfxvOZvGJpCRg6d5IJY+cPT7wvEkK4UA2qUWDBd0UxgdP6M+C5RyRnsW9RDa2K2AqD4NaRszJFq1hgYXZaBlcoeCrCHICNHkYh1y4PHjHcf1e+
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:01:51.9620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec639460-5767-4b29-41e8-08de6324665e
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10503
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6469-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linux-m68k.org:email,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 96B7DD9B93
X-Rspamd-Action: no action

Some Renesas SoC based boards mux SD and eMMC on a single sdio
controller, exposing user control by dip switch and software control by
gpio.

Purpose is to simplify development and provisioning by selecting boot
media at power-on, and again before starting linux.

Add binding and driver support for linking a (gpio) mux to renesas sdio
controller.

Introduce generic helper functions for getting managed and selected
mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v8:
- Add defensive null checks for all non-optional calls to internal
  mux_get function.
- Document NULL return value on applicable functions.
- Avoid IS_ERR_OR_NULL and ERR_PTR(0) to disarm smatch errors.
- Link to v7: https://lore.kernel.org/r/20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com

Changes in v7:
- picked up reviewed-tags
- fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
  and enable it by default when COMPILE_TEST is set.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- fix another kernel build robot warning: undocumented C struct member
- Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com

Changes in v6:
- replaced /* with /** for devm_mux_state_state function description.
- collected review tags.
- fixed checkpatch warnings (space-before-tab, void-return).
  (Reported-by: Geert Uytterhoeven)
- fixed use-after-free in mux core mux_get function.
  (Reported-by: Geert Uytterhoeven)
- fix mux helper error path uninitialised return code variable.
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com

Changes in v5:
- implemented automatic mux deselect for devm_*_selected.
  (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
- because of semantic changes I dropped reviewed and acks from omap-i2c
  patch (Andreas Kemnade / Wolfram Sang).
- fix invalid return value in void function for mux helper stubs
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com

Changes in v4:
- added MULTIPLEXER Kconfig help text.
- removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
  not required for all devices using this driver.
- added stubs for all symbols exported by mux core.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- refactored mux core logic to silence ENOENT errors only on optional
  code paths, keeping error printing unchanged otherwise.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- picked up various reviewed- and acked-by tags
- Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com

Changes in v3:
- updated omap-i2c and phy-can-transceiver to use new helpers.
- created generic helper functions for getting managed optional mux-state.
  (Reported-by: Rob Herring <robh@kernel.org>)
- picked up binding ack by Rob Herring.
- replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
  commit descriptions.
  (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
- Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com

Changes in v2:
- dropped mux-controller node from dt binding example
  (Reported-by: Conor Dooley <conor@kernel.org>
   Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com

---
Josua Mayer (7):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      mux: add help text for MULTIPLEXER config option
      phy: can-transceiver: drop temporary helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mmc: host: renesas_sdhi_core: support selecting an optional mux

 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 drivers/i2c/busses/i2c-omap.c                      |  24 +--
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mux/Kconfig                                |   8 +-
 drivers/mux/core.c                                 | 205 +++++++++++++++++----
 drivers/phy/phy-can-transceiver.c                  |  10 -
 include/linux/mux/consumer.h                       | 108 ++++++++++-
 7 files changed, 302 insertions(+), 65 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251128-rz-sdio-mux-acc5137f1618

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



