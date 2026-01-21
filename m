Return-Path: <linux-can+bounces-6243-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOePKluecGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6243-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:37:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E00A54850
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E122E4E2E7F
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D547DFB5;
	Wed, 21 Jan 2026 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="b2HYAHsn";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="b2HYAHsn"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023118.outbound.protection.outlook.com [52.101.83.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2247DD77;
	Wed, 21 Jan 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.118
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987280; cv=fail; b=m5ynxDg7gzyed2LWy7rdNh5J1Mf8GwPcPgsogx7/3Gl9iSx7mBNkH5G7VzMcvUgF3M0mhv4ioEXU03369/xd1D/iFIDeKpnlk4KYI6lf3QUdJbgSCgPoqUFqtlgCEpD6fvzoll1GyhkWsxNlXl9l13K7xh/Of7eUUHfXnWxsZBM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987280; c=relaxed/simple;
	bh=OAP0sAXZ4WSjfkN8FvNSsMzpnMKyHAIhDY4h30ZvdM0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YsitgOlaysPYnDb3FWS2nMaECXLz9Nar28SyHuwHdpGzcwTsKczMJe0l7OOJPIlpBb6swaRbGSqzoKWx5NgU39M5pi/J88rDxark8VcD/X7XU8V2yGQYsKQHQoHREc/IzuTXwXmkTGLps/JPhl2pDKVphE2r+qHtCFGoylDZWR8=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=b2HYAHsn; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=b2HYAHsn; arc=fail smtp.client-ip=52.101.83.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Qaz0039GcpibHH3Gu+nJqDCT6U5Doxr9EUCvpipu8CVuo64StIa2B/oubHi0YvSQzlCz3uVap6XcXShYh6rkL6zjJj14lwHX8jizvZ5TshskAl9s80auGDOEkARUduM//0NmS6kI+sC6UL5ZztSwcNF9JCR70GjSElv2IHCYnNMlajZmx4gq3PC9wKULSQ2w6crHG+1D5qwMvklTR7QzXAmQGaVMWNiQ4q0NBeGDf+2WbFwFhtzpWNu0m6dBDEflLSE121P3Zp4hUg8Qq/uvcMT5HXntmoB1y8CMkxC/2EsP9xST1TKP3LvboyAZjUz07nTZgEOlrjlzPAuOgzSJSw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92Ve+k38Ep++16PetPRjFGhUl0cIZMJ+bU2W+B0Epu0=;
 b=Zisgo3BPy/TLFPFwZ8eXAgWvRQXEp+klJR7qvsBEJ5+aDwM3ILBEcOr75NRF959wvxGPkRFO9zSW9pqshdEm+TU/Zd1dVqDpRVqz6NK75pgBjokffR91zSKPAN49sBBuHhN2Qdj0D+2p4M4yNDHcS9UBA2z3YXjl5yrLzn2cS5W1LC5UgTIkBiSDUsiw4vx3d49gGJ3MihbZi3CuAMXDW56I35vydinzveDBuIPaVj5+uh2T+Fd6hw3O3yQhVxzwqMWi5B2zi+/k8q2qx9+6ewizbNflbkuk0qdLa+/75rMTzul97GWEWu5HEN5InIZbvoY1mUUBtlcvzIssUhxShg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Ve+k38Ep++16PetPRjFGhUl0cIZMJ+bU2W+B0Epu0=;
 b=b2HYAHsn3Xp+UPZcw9ZNcmj2oIb1Wqpk76Zsi4KS64g8abq6Cfl3+1WwbwU6pMmHUzmyKo1QOOGdI6rQ8DOkpDxjwht+u4wlC3mkHliA5QQbs3VNmPfuTgpeSVSjXNdlG+FLva36UamxgiWIrzk53ZBqtXWen6O+0R9AeE4MjCc=
Received: from DUZPR01CA0212.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::18) by VI1PR04MB6845.eurprd04.prod.outlook.com
 (2603:10a6:803:138::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:14 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::52) by DUZPR01CA0212.outlook.office365.com
 (2603:10a6:10:4b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 09:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:21:14 +0000
Received: from emails-5520345-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1003E805E5;
	Wed, 21 Jan 2026 09:21:14 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987274; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=92Ve+k38Ep++16PetPRjFGhUl0cIZMJ+bU2W+B0Epu0=;
 b=CYAwJc8jctVL6B/8+TquS0WuPvGvKF4kcknmMLbxoNDlWSbQggvJri6x04IYI63tmKLBY
 BbKzc1sZ4IWB2qQ8LmurVbaZONR9jMh+wWWY6UhR2XPdX0OEDGw4cnxG1EKB0b4cvJ+JP5f
 A/JXxf72x+GpUyRI0MXKpPNenTIgXoA=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987274;
 b=a1wQt0Fpt5FI2+qtG+JeaytixgJn9T5BmjTrRaF6zhTX33oCdlM+uCy6pV478Ws6pa9ab
 YBl3o+R98BtSkwYiPOuA5U6JIhDioSLclQjxgFXiAYDEDYj7wIZr7JZN2OQdPaLuAKX0daX
 JLPqLtNrQG4qKbR5LLDI+3rHpknfPY4=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yxfi5A/rvjZCDizfYvnyWndAEDt2iFhJlCWmOrpnbKL1CNextOvBdk26/LCtq/m+n7/f1fxUyzFJzKhJxML6P7+zz4a+D8XaFTU903nJGIsYL9H+03W7GMuxGbvFW32chOr+r6R67+WpB9ySw98qMq/qFUBxOFTlrWGz4m5wBmTDnEi3tP4HQOvBXH85R9XzzYvtro/g3OpBwBuVL9PJHS1E8rNZJ9RdzQOn/AL16w/IreWhpSVg02ac9uspYC/sEGIE7Xl6jqEDNBqnS2gMsKiYgrAgqUrr+jQ4IaQCbt01S4Dzvxdw3SumwutsSh1DoGkEc2Xd+qVnVQq4S/pqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92Ve+k38Ep++16PetPRjFGhUl0cIZMJ+bU2W+B0Epu0=;
 b=nrEWaDXOb37JR8WKQcxizsxYEPtXBDhlcnvjHE1H33et+Wt+76yoenr+Qe8ZxBECk2cNBD8LGGnMAV0NFv7txlLcInO6VBcXI7QAlxPOFYZzjxBZWVwm2nUqNqUG+g1Y4xv6I7/JaimpRrMjtxoDH6ydtLzlKY3XKfgDjjuXPR7BwidA3XatsjmS//hOPlhlt3gvDJcFxx/SYFJcNFlq9VP22TRGeQUIYZtQWN5F0VzF55rBis4teB4IfNnC0m2Mr0DbUFr7P1PKv+LeN5f0JMZ+5cFILNoVkBOMAQ39WJ5Ik/BKBijToRV20Why8PeODLgF9kiI1Na/2H9mGXMSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Ve+k38Ep++16PetPRjFGhUl0cIZMJ+bU2W+B0Epu0=;
 b=b2HYAHsn3Xp+UPZcw9ZNcmj2oIb1Wqpk76Zsi4KS64g8abq6Cfl3+1WwbwU6pMmHUzmyKo1QOOGdI6rQ8DOkpDxjwht+u4wlC3mkHliA5QQbs3VNmPfuTgpeSVSjXNdlG+FLva36UamxgiWIrzk53ZBqtXWen6O+0R9AeE4MjCc=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:03 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:21:03 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:42 +0200
Subject: [PATCH v6 5/7] i2c: omap: switch to new generic helper for getting
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-5-38aa39527928@solid-run.com>
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|DB3PEPF0000885E:EE_|VI1PR04MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea79705-84f5-41f3-54f2-08de58ce6ca9
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?enBUV0szbUNaeVhIN2F4NEYxcXZhR3B2b1BZTmkwNU1OWk9JUFNlQlEyempy?=
 =?utf-8?B?TFc1RTF1bEY2M1ZQMFJEZVJlWHp5Rk9RY1R5MUFqSXFRTWhHeEN4L2F4SE1D?=
 =?utf-8?B?dXZkUlRud3BnSENjRzVQZUZ4OFRPVDE3K0FLR0hsSlBseUJIRDBPWVRTcEVN?=
 =?utf-8?B?SHJzQ1ZDUGZsN0g5ajd4L1pkSkdZT1FDZTZJYXVubXRLclAvaXVNYkxyZE5G?=
 =?utf-8?B?L2lOYlhOM25iTW44Sm1JbGx5UDFzL255d2NEa0ZCZE8yRkIxVnNkTk5ITHJq?=
 =?utf-8?B?bWpEb2piTTE2YzRCNFVkSmhMVVg4cEpMNDUrZWFMT1NveTkrZVQ5bmJuQWdJ?=
 =?utf-8?B?Wm5QMWJOVmJQbU9pZ0pIb0F0QXJPRHZtS0h2cDBNK3R1KzJOUlFrcUpNandh?=
 =?utf-8?B?OW51REdKejlTdDlocERQdmpxUWNia0Y2dzVWRmEyN1FFTG96bkh4aTkxcExz?=
 =?utf-8?B?N2FyN3htazhWOGVLMEJMVXZGZks0WFVla2dISC9mWG8rM0FvZmFYbERCaHpZ?=
 =?utf-8?B?Q3hlR2V0by9SNGtzeXBkN0VGRjU5K1lEcHNWcUh3NDhLc25XdGNPQjNJY052?=
 =?utf-8?B?Y25iN1RpTXIrcXFWdmt0VzJzczRTWWZRVVhKUkJwK3hzbXVONDNJWFR3a1lo?=
 =?utf-8?B?RFgzNEhQUWlvOVdaVGZHRktKaUpIZm9hZE9tM1dNZGYyK2VhZ1VMUW1kYzJK?=
 =?utf-8?B?TzVoMzNCbzl3ZWw0d3RSSUduRjY0c2hVak5nZzV6QkFBTFJSTTVaMUFHT2xQ?=
 =?utf-8?B?MnYyallubWlhcmdFSXpXZ3pHR1VpRjdDZTg0Y0dBYVkyNFJiZ2Ixa3N4OXM5?=
 =?utf-8?B?NE9uL0Nsc1NHd2tuN0hzalJCbXZ4YXc1U0swNTMxVFdaMUIrUkhGUEsrZURU?=
 =?utf-8?B?QzE4RXk0NU5yL1FXejJFWXNuQlJtaFBWNWlEYSs4bkhOaGtSMDN0WWxzSDZ6?=
 =?utf-8?B?aFJRRFp0WG8yUmNwdFJ0QXRKbFl3a0hvYXpsUjNDVHVrdlh0SjJIZGhjbFV4?=
 =?utf-8?B?SVFNaGduakxmTlE1RnU3YU51T1pzOHdPQUNqSDBCcnk5YVVjSGFZWTV3a0gv?=
 =?utf-8?B?UHNZdDdKUDAvb2svS0hqNTlnZXFoWWxkR285Szk4NUZLbWRnUkR3a3B2dXNt?=
 =?utf-8?B?bjhxQ3RCZEh1aWpXTnZocEtjNEhJb25Ja0hXZlpTc0ZpRFFpWDBISXpZMnBJ?=
 =?utf-8?B?OU1PRFo0VUgvWkdURmR2Q3FzcHhyNE9iMnRuV1NHamNkQ0ptaXZpanN6bmJ5?=
 =?utf-8?B?VWk5YnJ0MURhU0VQTHNKdXhTRnlHcExQMXQwZm5XN21tZUNjQzd4cng5cGc5?=
 =?utf-8?B?V3hvUXF4TEJiMHo2YzIvV29FZjkzNG1JSG1sZFFLeDUxU2VUNnRvVkN1djFh?=
 =?utf-8?B?RlJ0VUZNZU41a05qcUNLNVlld3ZkdFl0R1g0UmloNTlsdjhTandtZFd5M3Nx?=
 =?utf-8?B?cTJ3bTZTWlQ0bUd1VFFkSlJrMVcwa2NNNHdsY1dIalF2aHFKbGR5azJYUS9u?=
 =?utf-8?B?cytZMGpTWDFsNnVKSFM2aXNmZkhZR0FBSURkU3hTaUVxUEhuL0N6V3RMTnRj?=
 =?utf-8?B?NnV2amJYVzhDZTdQVG44TllnWmJINjF0Y2swU2VQVHByc3lUQmtHdUlIcWc4?=
 =?utf-8?B?SVk1SVRQUDhXRDBkcnhOOElZUDA0ODQ3ZHVIcTJMd25pY2xsZHJLTGMyaG1F?=
 =?utf-8?B?bE41MTFNdm8wMXlIeXNqUDVTTkp4VzRaMDVxTHQ5UmpWNlZIZ1lKaU8yeUlJ?=
 =?utf-8?B?NmJJN3FvQ0Rmc3NzaWc0SDdXMGc3Q3BBbHBhcVVBY0M2R3oxWmlnQlNiT2cx?=
 =?utf-8?B?M2RYN05nbzdFVjZnTVJHbVpJcE5WdTBycCtzdVcvNk1nbVZ3cC94SlhyOFZY?=
 =?utf-8?B?WWl0VXpFMXZyWnVyMkc4V1Jwb0tEWnNQK1ZpYjFBN3o0WkdQN1YyYURzZWRT?=
 =?utf-8?B?NDJKSFpPOFFXMk9VMVRiY2E1LzBPcGdzdFRkQUxQV0FGeGR1TG1rejh1Z0xP?=
 =?utf-8?B?eENxb2tUZGw2d1VoZjV0Z0dpa2xva1ZxR1FDbXo0c1ZRbG5HK3dxeGJPLy8w?=
 =?utf-8?B?NDJtb3J1SGF2dzZxbElwb2lDOXBNejlpRXJ0WUVxYklUYllDNE1DcW9VT1Vl?=
 =?utf-8?B?WEVMMG5OUUFBaVNXblpSeDRlQTZVaFJyelBnOE15M3RXUnlLS3c2UEoyYUR3?=
 =?utf-8?Q?87CW5rKr/OQW7xMLrSqMw4bWsZtf4D/A1qNFDMbsfkpl?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 42f5895ef2b540388bbcc7e703ad6a60:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	88208455-6fe8-46a2-0d6b-08de58ce65fc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|14060799003|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTUwdFE1OXRJVVllNlJlRzV0M1FyaFJxR1ZoMkxBK254SmI5TitsZGtvYjRM?=
 =?utf-8?B?L2RaZkdsVjZrM3JxbUlKVlA0R2tmVDllSmVBQVJOQmk1WTVjYUQ0UGtHc2wy?=
 =?utf-8?B?SkFmSDNDRjB5NTJpQUhCTksydFZFRUdBN0c2WUNoQXB0Y1FaMkJyRG5mRUxr?=
 =?utf-8?B?VFV6Z0JzSUpLTUdHYk9EUlVLQzhFM2RFNW1OckJRZG5qd2dBc0pXVlR5all6?=
 =?utf-8?B?Z2Q1V3k0b1NvdXNWRjhiZ0k5Zm5xZjRzZllZMFV6T1kyZFVTUU9BU0RJdE9Z?=
 =?utf-8?B?eWliczVPdlVqd1ZqOGlOV2M2MkIvNnAzM2ltUzZWZUUwRlQ1Z2VTOEl2U2ov?=
 =?utf-8?B?ZktpK0Z5QWVGZ2d2OWJYSmZQQzQ3V2JOTWF4My9wVU5TV3NGMzMyb3RBZExj?=
 =?utf-8?B?eU9zZzVyVFQxUnRQcjRLR3VOdHprOW52ckM2cWFEd2Rha0VZNnBiSFZWZGFW?=
 =?utf-8?B?YlZWY0hGZHNuVUxXRWgxNWxJMUNDb0YxQjdOVnFyWC9ia1N6OS9JanZjL1pD?=
 =?utf-8?B?L01jTStyeFBnTG1yMTk3anpYcnJxd0lZMm4rajJQVzBFb1ZzUWdqRXoxMzhT?=
 =?utf-8?B?RmxDanQvaEFJYVlLR1ZtOGdYL1FkZWR0eFBWUUd5NzcvQ0NXMHh5UGl3TG9U?=
 =?utf-8?B?L1llVm1BMzd0R0NyTFJmMkUvSDQrMUNXcDlIVWptMWhBbnU4RWZJc09RbW1q?=
 =?utf-8?B?cisyK2w2VGMwYXN3bEpaN3hJZ0dLRzJtNGREaGRJbVpBTTgyNk93NEp0TDgz?=
 =?utf-8?B?aElDbVdNK0o1WnR6ZTFIT3IzanYra0ZKTjFld1lCK3p4d1dsSEQ0cFlXY0Nl?=
 =?utf-8?B?cklhUXE0Z3FnMjJxcVpobFpHVEhDSHdqU2N4N1Q5dE91c0pHMC9kMG9EaHlG?=
 =?utf-8?B?dnY0UGNjS01xOVFncmN4RjM0b2RFOUEyNDEweVdXL1lRZk90MWcvbFMwRWpD?=
 =?utf-8?B?QkVRb0E4TnEyenZwVWJGOW9xRHVycGJPN3lQREVJY2NZaG82U2NaOHBYTHVm?=
 =?utf-8?B?UG8rZ0RNOUxmbkk0WW4xcEd2ZmFVeHJTZmdnVk9ZSm1mc2F0N3ovRHRPZE9u?=
 =?utf-8?B?NEFPMENtMWQzYTBSbEV4OWVQWlNPTVZoOVNaaGJZVEdmS0wrUGhPc1B2bFhz?=
 =?utf-8?B?TlFLMERLZmxPUDFLU3diM2Jqdzl1aVJEMTgvUExTT0dzY0EweGJCNkI0OGlq?=
 =?utf-8?B?V290eTRSVU1mZWwzM2VrODNzUUVWd1dpSCtUSURodm9KZzJzRmtQR2UvakZs?=
 =?utf-8?B?OUlnYjZxeFhQb2swM1MyTFkwS2psNHh3bVdxMGNpVURNMVYxNDhmOXFnd2dM?=
 =?utf-8?B?MTR1YkhhMEVsZ1kzNUt6bWFMRUNXNnkrT0NBNHI4cGtBTDByMFRGWmpkdUd4?=
 =?utf-8?B?RWVwTFFYaCs0eXBoR05DbjNsNFQwOE5CWDdCVXoxY2t6NXdpb1Q4enBadWNn?=
 =?utf-8?B?V2NaUnlNR2Q0QnZpTjJ3ekgwMzljZjd3TUROL3djVk1kc3lMOEl5Y3laT3lO?=
 =?utf-8?B?OTh2MG55ZEtncmpORXQzMzZ5dlVabi9XVDNDZk5tdHl6cGoxUjVnQUQxSmc4?=
 =?utf-8?B?TS95eUtXN2pVRUlXVllNV3FvU1dzb3lMbjRmeU9IRmdrbnJBQjBCbGFkZGxi?=
 =?utf-8?B?Q2t4c0pkZzJ4cGhXWWRIb0lFNGFGUUZNeG44VGpzRks5ZC82bXY1bmhZei94?=
 =?utf-8?B?b0ZFb3c3RzFQNk5ZVzBUcTBraGpVVkJ6ZzNFNmlndytmQUdQN1RramlLbjIy?=
 =?utf-8?B?UW84cUo3OFZYellVeDBWS3l6SkhHSHFhMGVTYUN1YlhnZVBDSDhZVWR2TGRj?=
 =?utf-8?B?VjFmN2NyMWMyQjhQMSs5Z1kyQ3A5MXRGSUpyMzlCWlg5Z3NDMW9EY0JNd3ps?=
 =?utf-8?B?YSt4Q2ZmMmoySWdMekZBeTlER1ZjMjRPbmpwR0xjS3hPQkRYN2pHdkZLdkZ2?=
 =?utf-8?B?R25YY2ovK2NiZW8vc0JkTVBNZGgrWmxiN2hDTGcrNFpxZFNIbUpoZmRjVjI3?=
 =?utf-8?B?YTNmd0E3Ulhka3BXaWRMUktmZlBXaldNb0d6bElIbE9iU0pTQ3dxU3laaEZW?=
 =?utf-8?B?L2IyWnFBcFdWZE1JT3pIUGszYVBuQ1g2M3lVR3lOdDVpWEY2MU1neWVyNFNR?=
 =?utf-8?B?bksrZi96L0c1VXE2cFJsTDY2RVlVejdORUoyRWZjQit3aTZrZUJwNEZ6cmF2?=
 =?utf-8?B?K0xTOWxxS21wYUtKYzh0bUFYZWRaUEhNWXY0RkZDbEt1OGJtQjFSYVNISU0w?=
 =?utf-8?Q?IubCiwWB3VqTiNvgpJ6CX8ijWQ6odh/EvpN2OFB6c4=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(14060799003)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:14.2293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea79705-84f5-41f3-54f2-08de58ce6ca9
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6845
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6243-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,glider.be:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3E00A54850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiplexer subsystem has added generic helper functions for getting an
already selected mux-state object.

Replace existing logic in probe with the equivalent helper function.

There is a functional difference in that the mux is now automatically
deselected on release, replacing the explicit mux_state_deselect call.

This change is only compile-tested.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/i2c/busses/i2c-omap.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d9f590f0c384..f02d294db42a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1453,27 +1453,16 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * omap->speed / 8);
 	}
 
-	if (of_property_present(node, "mux-states")) {
-		struct mux_state *mux_state;
-
-		mux_state = devm_mux_state_get(&pdev->dev, NULL);
-		if (IS_ERR(mux_state)) {
-			r = PTR_ERR(mux_state);
-			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
-		omap->mux_state = mux_state;
-		r = mux_state_select(omap->mux_state);
-		if (r) {
-			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
+	omap->mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(omap->mux_state)) {
+		r = PTR_ERR(omap->mux_state);
+		goto err_put_pm;
 	}
 
 	/* reset ASAP, clearing any IRQs */
 	r = omap_i2c_init(omap);
 	if (r)
-		goto err_mux_state_deselect;
+		goto err_put_pm;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1515,9 +1504,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-err_mux_state_deselect:
-	if (omap->mux_state)
-		mux_state_deselect(omap->mux_state);
 err_put_pm:
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:

-- 
2.43.0



