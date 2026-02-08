Return-Path: <linux-can+bounces-6501-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDpUF+ioiGkUtwQAu9opvQ
	(envelope-from <linux-can+bounces-6501-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:16:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19A109184
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 163BC30028E3
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AE359FA9;
	Sun,  8 Feb 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aVt2rvdR";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aVt2rvdR"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021140.outbound.protection.outlook.com [52.101.65.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076112C11D0;
	Sun,  8 Feb 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.140
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563808; cv=fail; b=dO94O4sEopxU6AjIH62nNZQVoE0f3LsWgv58OnE1C8NjYbr5VLojjrlnSvTsRRvwPXRBL1TvvgYw9KasMUN8s/w7/yHCymMUK1ir/9fAnw3aQ8ABP6DLuXS/PYs05/kADokmJI8K2GErDtgA8BAG64pdDE1araJWymZcJAHd25M=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563808; c=relaxed/simple;
	bh=I3gc4T6wMf8bq/NsR8Gb3Q7LckcGMRJgjvAxyoaP4FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pcT51cP/LeNbrhZ+M6nePsJKBmPYcckL1StWLgHO6Y0WTKJCGuz49W2QKuf6azz2anfEj4gJgEvvhYNwVm0xyA2BKw0cPgNo5/0aYwu0U4jwyB9L1WXRk0Ho3QVpTszGV+zpW0VRsd1V7Hbo8/lkjIHPRnj5jUm/pVG0rtuD1ZM=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aVt2rvdR; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aVt2rvdR; arc=fail smtp.client-ip=52.101.65.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TvYqQHFwgd0qWsqUlDp0JWuUspnjOueijCwAY0VKCvLbbmZqoQMjOkBa+/T4rLB+J8sZszHXd1WTARwLH/MmCm/bLLRD2Y98x6eZWkn6T5jfxLRPQPnt48zYuk/ApLAcaXADudGIAv5cvaqJjOqRr8ZyuwT+Jo+h/yd6KEcBiu2yvf0qgpIC69AhEEvr9q4+mbAMhADCjIMwn28CSQm24WhPNFXcfj6sl5oMf4UiISa8D0tt+KD70ESQuy0JP3OjZbl4qk5IcAcy89LzbT52VDkkH7cqLbnwVj6pRmLKfFtfopiGkEIO3Zgppo+vEfzyHIEczBf2UHlptEw2g3oUAw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3gc4T6wMf8bq/NsR8Gb3Q7LckcGMRJgjvAxyoaP4FQ=;
 b=Xn6pYG7YMY4NpTuRWHAc3apPCdeYsbaaO0aH8bu7RHpaYcGjVLPZWfMrA3O0uIQjNWGIJPy+RQC6JS4Wa3ICV8ysIwCDVBVSoSxwvEX4MaO7lmGJXxQQQL1hBIAqNy8HaUKRLyFpWyC7UE/UZsIm62C5klNsouTEPiYSX3I1TQ+nm1drRHiwQbe3+8vh25TmsMWO4H7tguD0jqChjBtNkVd4dqIp+e+v9sGgVZgbos7d/jZkpA7XPFCs5cMu6jIWxNpuHT97b5a9FbE9noaD9j5pvoXd1i7x95i4jzr6fsIVknV/ykfE9S4aektz9qAPhMiR2ZKnSkbA5j7tG0fPaw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3gc4T6wMf8bq/NsR8Gb3Q7LckcGMRJgjvAxyoaP4FQ=;
 b=aVt2rvdR+bQQS2Z+LNRFDZWKuZY7Vlop1lmcT4D4P/3WRQA7k+txuB4iBbaQKXTR3lEk6pstv2/wyxKagxYRfZqKbkz5VvnR3N0NAhzbtfbYb8PiYRYxrOSHpmtAFRxrLcECC14glUf67Z5YfhNsIEY6cGIyDwAEy4bP36NVEhE=
Received: from DU6P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::17)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:16:45 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::de) by DU6P191CA0026.outlook.office365.com
 (2603:10a6:10:53f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:16:45 +0000
Received: from emails-9396290-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-212.eu-west-1.compute.internal [10.20.6.212])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1DA0C80084;
	Sun,  8 Feb 2026 15:16:45 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770563805; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=I3gc4T6wMf8bq/NsR8Gb3Q7LckcGMRJgjvAxyoaP4FQ=;
 b=ebs8P01j+E9XtuhPcnYRgEdK9ml6M/Ym8jdwwl2IHPqN4jAMXzLZbu7jR9fHr/moeISXL
 AHyRaZByCkqXtQO9KMuZqb9gdTXGKgexiLfDEPsYKejk6dzLSN3F0WHJyUoi59B0N7MoYzj
 qtnB6RJIm8A9tiwInuPsBkBP8DS30mw=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770563805;
 b=SyQ3erlWIDaS4GRZdLT0B8ETbg9lXe1zf7+RhO7Sx5bFS4HrP3WksLnK7oxnKTFImSHu+
 sQEtZv4ATcFKITC0HM0t3vpgSz8Jend6k5USAJftOJknxe/Ll/SUbkj41/9TopG57IkJHl0
 HuW94xzIij/B7eDhv6yQemqgdlYr7aM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGuybAM+HmDft3tExEqB46kprG1xovPEZFXQiaJg3wILiFDkOj3QaejA7n1mLYxKmqXFo7/oD9tFAfsqr9++Rt3irvKtyX5m85uE7v54srmi/UZH4Qn2JIOQdWGsDPoUtYUVPaPL/4U8dxEdCs1+0uBa8Fxf8nTXqV5wG73Gqsp3BU6X8K8PqbQUpL3Njag5bp0Aur8U1VjtXP6XWkSISlUaOYy3M8dmmSFd38Ew+f45XaSqQ6vfTVo289f3Th6YwuZq+cPP0SYadrxeSlpzwMkbc5YEY6PFp1npp15tjJqxoD0bVKHOiPuSLoBLs5M6Lrrd0cqhCgiX02xNQbrI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3gc4T6wMf8bq/NsR8Gb3Q7LckcGMRJgjvAxyoaP4FQ=;
 b=DFP3NhQSoYhWq7kSH89Ee/XEhTTwHpbh4dJg/olVC3Oab0zgvHN7EAzTljpHVcpsgOCkQKUbHEw7MOBVYKdFMccujgv85NkKtXXR0y+1wHnzauMuou1qBFs8TBcNR+wtWpCIeoYSLqVBpn5nNzAG6RhJPDEX1rPvarRTNJgwkEwxKpsd3YbFAAwHTtD2C+8isKgtCSOs1LhRsn9uCvJFwQrR1xYYS8QDP5AqW6x9k2RLX1JpEP5C8Pc4pugipTt94Rrmq/kJHazupJZwlXhnSRMcnjRpsXH4qpzVqMIqDIGs3HiRgMBDMntQ0jNraSsvlg/DRGQwJVIdvC77/Xt5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3gc4T6wMf8bq/NsR8Gb3Q7LckcGMRJgjvAxyoaP4FQ=;
 b=aVt2rvdR+bQQS2Z+LNRFDZWKuZY7Vlop1lmcT4D4P/3WRQA7k+txuB4iBbaQKXTR3lEk6pstv2/wyxKagxYRfZqKbkz5VvnR3N0NAhzbtfbYb8PiYRYxrOSHpmtAFRxrLcECC14glUf67Z5YfhNsIEY6cGIyDwAEy4bP36NVEhE=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VE1PR04MB7296.eurprd04.prod.outlook.com (2603:10a6:800:1aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:16:36 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:16:36 +0000
From: Josua Mayer <josua@solid-run.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton
	<jon@solid-run.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
Thread-Topic: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
Thread-Index: AQHclQ1B8HejTmuXEUSnLC013GRTOLV48bmA
Date: Sun, 8 Feb 2026 15:16:36 +0000
Message-ID: <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com>
In-Reply-To: <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VE1PR04MB7296:EE_|DB1PEPF00050A00:EE_|DB9PR04MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1d1926-71eb-423f-9762-08de6725125f
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UjFFOUh1aDUyaHRLT00yczVlUTFLQmFPV0Rsck44aHJLSy9TZ01Ua1pFSmd4?=
 =?utf-8?B?eTJuNWR1Z09LanVHUXBxTm0rZDR0QXgvR1JnMkY5Ym1RakpVYi9YdWFJWmRZ?=
 =?utf-8?B?WHQzLzMwQWQxaEs1R1RjYmQyWUhEdllPQlVMcFo4UVFoRzN5dVJxRjhFVUN1?=
 =?utf-8?B?TlVSU1RIOVRsN1RiT2ErdzIrM0grRk1DcEhLMlBNdE1lbE1SNmlNRXJXTk1o?=
 =?utf-8?B?TXBRREdmYWc0Wk1JU0hybGNTWFZpb0lqN3hIMHduR3owRTdtRm1qRVM5OVQv?=
 =?utf-8?B?RnJPZG9ScmZ0YVdoNmQrRmtRNU9ldUVYZXd5YS9OQUttYWU3WUJDcHV0TEdw?=
 =?utf-8?B?dnp6cEZsTyt4Zm8xa2lDeWhwcVNnMm1nMjZYRjF2aWVZRnE3Vm5JM0RNL0dt?=
 =?utf-8?B?NXpKeTNEWThHaUE4dlQybUtUenltZm9qZzBJUHA4eEVXaFdWb21yY3pQejJw?=
 =?utf-8?B?V3c5R0VoRlBHS1I2RU5uMlA5R2crb2UyY2Y5cy9JMXZ0aktWT2ptenBtNU1I?=
 =?utf-8?B?YVpValFBbWtFMjdnSnFZbjh3NkJETnJkUmhTbXI4K0h4aXNtN3lvTHlSaXlI?=
 =?utf-8?B?RmtlRStZbkNGM3FzbFBGNFJTRDRWOXJibmlPUnpRMUJxa1lTeTAxUVRXYTh2?=
 =?utf-8?B?N3c1eEVUVGFjYWYvOThjUE0vRlZma0NiL1doYWYwcS93V3Y3bGpvZEtLb3FO?=
 =?utf-8?B?VHpLOFpCVGVHanorcGVRNi9KVVppdGNVMVUxWFZHS0R0STVyczV6cDN2dzEv?=
 =?utf-8?B?RjNKQXFzZGF2SEMrR1FCZjVKQmZDY090YW85YnBROGFxbFZTak92RlU0aUZU?=
 =?utf-8?B?MlJwbHlIU2FIeEJjRFByRyt2dGdOOUtwQ3Q0bGkwQlUxZzZGUFU1TFk5TWUx?=
 =?utf-8?B?VXJOUnBac3JzS2dLV2MxdzF5MGN5bmZuazlUMVJxL2tsMTNZWHE3YUYvdU1a?=
 =?utf-8?B?cWpPc2NzOW9yUDNUbWd4c2hVNUk0Mm95MFhVdG9zWEhzbzlmY3FDd3c0NGZw?=
 =?utf-8?B?cGJocWxNNTkybFZFQ2JVeFUxeUdLc3F2OW1CTFAvc1pNY1ZyK0M1a1hnbVN3?=
 =?utf-8?B?ZEJoUE5MaU1FbVRhWEg5eEh4RElzeHkyMEtlVlI2UlFsakpRbDlZamFIN1VM?=
 =?utf-8?B?VDRucFVFUmhLN29ubjdaSitPOGFNaGxodm5rVXVTL0JpNHlRZ3FSeUZvMWtT?=
 =?utf-8?B?QUg0d3NDTGVqdVhxa0NLOG9BY0JWcnRzZUhjNDhqWnZYUnFVVHRoQ00yOG90?=
 =?utf-8?B?U0tPL1MxdWc5dThrM1NVSGpBVW5DS3RFcklqanZNQm5QTENNWnRNY29FZEZn?=
 =?utf-8?B?UWQvdXE2WnlaY2JOOU55M3FmUVhNeDR4N2I2YXdsN0d0SnhIQ20rRDN0eEtW?=
 =?utf-8?B?ZStBOFVuRGNDdWVXSXV4d3RLNTA5NjgvVnBkZGVMTjZFUCtwcTJzRHNaYUty?=
 =?utf-8?B?aWU3RWczQ0pMcUFZVnZmS0xFN3NRV2VWNmZiTWp3Zlp0dHI3bjAzNFpXdUdT?=
 =?utf-8?B?bjc1MmdGV2JIL1JPVGhXWHNGSDk2UEc5QW9BZDVHZ1h5YjBaWWRTR3YyeUZY?=
 =?utf-8?B?eDBtWU0rT2VabkpmOW1HRGM5aTRMc3hGOW91ck9NSW5wOWVoUmJ1M1pnWVFv?=
 =?utf-8?B?SnczbEg3L0RQM1hHM1YrVEthVkxFTGJnV1dWY2ZLTkFoMnZ0ZDBWMTJ2RjIw?=
 =?utf-8?B?K3B2dFZzR3hORTFIUnFxdDNHazhLbnAvMUpjYlNUTnJuMzY4RTh0TVIwT3Jk?=
 =?utf-8?B?Y2ViRW16QUZsRE53aHYvUVNCMll1OWdtNkhBbVJSOVNwdnI1S0lFVmxOS0l1?=
 =?utf-8?B?VzNlUU9BeUJqS2hVaXBpLytHUU40eWZUOWdJc2lkZ2NCQ3JVUG9vWGZoRmJS?=
 =?utf-8?B?U3hsWHJUMlBZNWQzUnU1c2kzVGhaT3VjY2N6d2U1S1ZOclMrVWExbTRacURI?=
 =?utf-8?B?NXlBZXI5VjF3WTRxeEw3aXNYVUd0eTJBaERCMWJLZzBIbDViL2JmcWhYUDJu?=
 =?utf-8?B?RHMrNkhKNW0wakd1UVVjekwyekx4ZmJqSkoxMWc2Mjlrem5IbjYrc0RwNEo0?=
 =?utf-8?B?dktiUFJPNFUzTVVoK2JEQXVqMUJTTGkrOXdhZGFUUnNDV3prMUgrU1hKZzhF?=
 =?utf-8?B?QmdGTlVpaEEwQkNIaTQvRUdtK1lJTEJzRExwcFc5cHp5WG9zdUt0VHZ4anRV?=
 =?utf-8?Q?CVMxfMLWHQzQK6u2BKaBNObTWQXLlKWMNpuKEDFaRv1G?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CB5FDC4D3F4BC4C9EBE0C158BA8D3BA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7296
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 35b2f3b141ca49fca2408c294b84057a:solidrun,office365_emails,sent,inline:0c24ce0f4cb5c6dec7fe9235a25b6f0a
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	73dc17ef-77ef-4927-ec53-08de67250ce5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|7416014|376014|14060799003|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0tuRTh4ZTAyL2NKeUNNTDMxU0pUZEhkN2trWUVCOXZ0U2F4N2sySHZkQ3pW?=
 =?utf-8?B?dDBwOWxMK2pBVkxLd0cwcno1dU1NZ2llRkNqOVBPb1pzeG5FcVQ2T1gxNExZ?=
 =?utf-8?B?SFVlcjJ3SFBYR0U1YytNWUNObGpTVm5HaFNvRnFsaXJqa0FhcFVaUVE4ZzhO?=
 =?utf-8?B?LzV5V0NPTUpXeWJRaDk5OGlYOTZMcFlWN25IOGNsUTAzMlBRNm8zZ2o2Y21M?=
 =?utf-8?B?SE9Scll0TThtbWd0NHNiNFpyRjFZRlM1Z2x1U0VlTlNGRVltNzNCb0NCM2ZE?=
 =?utf-8?B?bHNWVkxzV3JSV3p6OXh6ZDc1YmQ2M0E3bWN1bksrSTVvUUN1YWlrVVpvSVpi?=
 =?utf-8?B?WnppbzY4SEFZVGJnNm12dVNLRWI1MmVDcDJiZTZhdmI4Vm05dnlmVFk2bE9N?=
 =?utf-8?B?dHV3OHNYZTdoRzlwRk1QZnFJaXFaSlBSalhMQWZFSCt0YWl0OEx2aHZDU29y?=
 =?utf-8?B?U3FsN1lYRnBpVVFwei9pRTdwL3IwM0xrT0NCMllyQ2FuOGhsU0hrdmNnWkMv?=
 =?utf-8?B?UExXRVVQREQ3Ylpob1pzMUl5Y2pkcWlFV0x6aDhnY1VVMHdmSUtubjJBdDk4?=
 =?utf-8?B?UmJuM3hnd3l3cTFQbkRtdjlibnNwb0tiOXV6QnRTQnA5RitlZkNpNEZWNXFj?=
 =?utf-8?B?d0Z6ZnAyQitjQ09PeFU4ejZxT2JoT3ZHZm1ROUloQW9NWlgwR1A5TnY2a2Iv?=
 =?utf-8?B?WXRFMzJJNTMzRTJYejBMSmZyVTF3Z0p2NFNFbnM1aXc0ajJ0cUQ1eVFDQ25v?=
 =?utf-8?B?S1kxR1R4bm1OY1FyZlhSQndrN2swK0Rkc0hxRFFURndkamkvT09DZGFLTlo3?=
 =?utf-8?B?b0pqdFJhTDFGT3hNMlNxdkxRZ3lGeHR2Ym95OVY2clFCRGswZkxVSWFHOXI5?=
 =?utf-8?B?SVlTNG9UWjJKK0crNVBFWUoySXFKZEtrVWhLYVM0QXNZRGJUelQ4bkVDR0Fo?=
 =?utf-8?B?YXlRYmIxSlRHWkRzK2xDYjdVNHNNRjZQVVBHcjFObUZwVTg1bnFUTFNIVFJH?=
 =?utf-8?B?ZmJOa09xRE5MQU5FQWhVUHdnblV0K3FhNTZROUZubzYzeEU2cmwxclZaYWMx?=
 =?utf-8?B?UmFxSXE0TGQ4c1I5RTI2TStuSS91d2dycXl4N1g2d3h1ZlZvNnB1OWhmRFZB?=
 =?utf-8?B?TFJKeVZOSHB4bFlYUWhmdkFpdG5RWjEreE1mYjRoK3QrbkNhWTVLT0RtbUgz?=
 =?utf-8?B?WWFabjZCY2ovS3dIZis1bjFvWm42NFlqdk9RV3BTa1RSNHE3WTJwdUZXbHg4?=
 =?utf-8?B?SDFQOWtwcWFSQitFY2hmRFBKZnc1OHFxenVDNVB0YS9sWWx3Y1VtMGNDOFB5?=
 =?utf-8?B?NWJVc2FtdlBHOFVwWUs2N1UxK1RBSkhHcFRkYlJVMjFDNkNmNU92YWR4QlZW?=
 =?utf-8?B?QW8vRWUzTmFTY3Z6Vlk3Wk54OXd6RXVnUXlvbm1rTG5NT2pOVlNWTEhyNFUw?=
 =?utf-8?B?UzU4ZFZjNFVUYlI0VEpWRys1R1dkZkVaUlIxZThuLzhRdFN6U3JXdzRJbVJz?=
 =?utf-8?B?VVFGcW1RTUdmVC9yTkVOMWJCQW1wM0gxckQ4ZUI0UTMySEZ4dGdHcXg4emVp?=
 =?utf-8?B?UlhSUlRIZEV1QUFLc2hIeWVEdXRkczlxWFB0dkFzWTBCK0lBRHlLeGpWTzNO?=
 =?utf-8?B?cHpZK1NZUXhPcmJFRzZNMmFWZjFqTVZSbThGcWEvMzFnQ1ZUWTdDNHd3Z3d4?=
 =?utf-8?B?Ri85K0U5eWZaV0dwM2dZK25CRGNsUXVNVkRNVml3dFZhUHg5QzdKQ050ODBx?=
 =?utf-8?B?K0N6a3lFVUZsK1ZhTUtDcTNROXNoWnlySW9PVXVvTFpZdjZaeW1DUXhKUjZI?=
 =?utf-8?B?VDl0VVNheHpoMXkrSmhiYzU3VkdxOHRMaDRPV1pUa1FQQjBkZ3Bpb1dYRlZB?=
 =?utf-8?B?K0Z6a1ZFcVpNVTk2ZlFLSzQzN1F0eVNYeXJxNThnMzRYOXdUc1lDSUFSVm5R?=
 =?utf-8?B?M28yMnd2QUlHK3ZJRndMZERybllVa29jdE00ZlgvSytCWlV0aHcxU2ZsSDlN?=
 =?utf-8?B?cThWSEdvaEZ5Znh6UXlxSXZ3aDFDQkMzOE9zREFSVTlaeXk0K3ZodzkrSFhk?=
 =?utf-8?B?L3lhR2xxTm9adGx5NmVHZXVXNFBOb0JWQ3BnendyZmVZNGo2LzVpSENzSExI?=
 =?utf-8?B?cXVybmhIYWdUR2FCeENrS0grVFEwWmdSbGQ0VWJnWGpUdEhoT1NpWUIzWkVL?=
 =?utf-8?B?UGhMd0o2YitmYkN3Zi95bjdNMGY1WjQxMzRNektibkNaQXh4MHVyUXVQUWts?=
 =?utf-8?Q?Qcm3RReb+/boTP+TEHHjn0j970jXCGv4/7vOGA4hIk=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(7416014)(376014)(14060799003)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AIXKbEr0zGVqogxzJvZMo2XO8tg0RXR2AJXWyoMpSck4VvTH9EA+Ka9rwXKN4JKiMfG+UjSu6lWpp+d+UmmfW1cp/nPpsagf+UWqDtUFUfYdy/d/S03fkcJicL2WW/biTXp01u1R0PP/j+64NZyTBlIWZDPvYPaWZyB4bGbFXERFiJb5ceIuFUnKR0ImOA3oOaB7hpueo0tgmvdTtAJVrC1dCe2kMp5fJLEn07qkzoZvHhgN4hk6CLcHkXnkoB7IM7N/Ije9JWytrqQySRYH6hUqiFAvjVA7Hx1nOptuP7tLEX/M5m8V/2EjjkZKcTkrbhlhAZO8OObvfqbbxeldUtvqLw4wI/ZXwgo9Mp8GxM0uR6Ue9ODdc30FiJfvLX5GPHl44iDSrm3YftiKXnU3ohZYiI7N2m+bPAAX10p9oTS3syrQ871aADf4fzjPgx/X
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:16:45.2482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1d1926-71eb-423f-9762-08de6725125f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6501-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7C19A109184
X-Rspamd-Action: no action

T24gMDMvMDIvMjAyNiAxNTowMSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+IEFkZCBwcm9tcHQgYW5k
IGhlbHAgdGV4dCBmb3IgQ09ORklHX01VTFRJUExFWEVSIHRvIGFsbG93IGVuYWJsaW5nIHRoaXMN
Cj4gb3B0aW9uIHRob3J1Z2ggdGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIHdpdGhvdXQgZXhwbGlj
aXQgInNlbGVjdCIgZHJpdmVyDQo+IGRlcGVuZGVuY2llcy4NCj4NCj4gU2VsZWN0IGl0IGJ5IGRl
ZmF1bHQgd2hlbiBDT01QSUxFX1RFU1QgaXMgc2V0IGZvciBiZXR0ZXIgY292ZXJhZ2UuDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL211eC9LY29uZmlnIHwgOCArKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXV4L0tjb25maWcgYi9kcml2ZXJzL211eC9LY29uZmlnDQo+IGluZGV4IGM2ODEzMmUzODEz
OC4uZTMxYzQ2ODIwYmRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL211eC9LY29uZmlnDQo+ICsr
KyBiL2RyaXZlcnMvbXV4L0tjb25maWcNCj4gQEAgLTQsNyArNCwxMyBAQA0KPiAgICMNCj4gICAN
Cj4gICBjb25maWcgTVVMVElQTEVYRVINCj4gLQl0cmlzdGF0ZQ0KPiArCXRyaXN0YXRlICJHZW5l
cmljIE11bHRpcGxleGVyIFN1cHBvcnQiIGlmIENPTVBJTEVfVEVTVA0KDQpUaGlzIGRpZG4ndCBk
byB3aGF0IEkgdGhvdWdodCBpdCB3b3VsZC4NCkl0IHdhcyBteSBpbnRlbnRpb24gdG8gYWxsb3cg
ZW5hYmxpbmcgdGhpcyB0aHJvdWdoIG1lbnVjb25maWcgLyAuY29uZmlnLg0KDQpXaXRoIHRoZSBz
eW50YXggYWJvdmUgbWVudWNvbmZpZyBzaG93czoNCg0K4pSCIFN5bWJvbDogTVVMVElQTEVYRVIg
Wz1uXQ0K4pSCIFR5cGXCoCA6IHRyaXN0YXRlDQrilIIgRGVmaW5lZCBhdCBkcml2ZXJzL211eC9L
Y29uZmlnOjYNCuKUgsKgIMKgUHJvbXB0OiBHZW5lcmljIE11bHRpcGxleGVyIFN1cHBvcnQNCuKU
gsKgIMKgVmlzaWJsZSBpZjogQ09NUElMRV9URVNUIFs9bl0NCg0KVGhpcyBtZWFucyBpdCBjYW5u
b3QgYmUgc2VsZWN0ZWQuDQoNCkluc3RlYWQgSSAodGhpbmsgSSkgc2hvdWxkIHVzZQ0KZGVmYXVs
dCBtIGlmIENPTVBJTEVfVEVTVA0KDQpTaW5jZSBteSBwYXRjaC1zZXQgYnJva2UgeDg2XzY0IGFs
bG1vZGNvbmZpZyBhbmQgZmFpbGVkIG1lcmdlIGludG8gDQpsaW51eC1uZXh0LA0KdGhpcyBwcmVz
ZW50cyBhbiBvcHBvcnR1bml0eSB0byBjaGFuZ2UgdGhlIGFib3ZlIGFzIHdlbGwgd2l0aCB2OS4N
Cg0KPiArCWhlbHANCj4gKwkgIFRoaXMgZnJhbWV3b3JrIGlzIGRlc2lnbmVkIHRvIGFic3RyYWN0
IG11bHRpcGxleGVyIGhhbmRsaW5nIGZvcg0KPiArCSAgZGV2aWNlcyB2aWEgdmFyaW91cyBHUElP
LSwgTU1JTy9SZWdtYXAgb3Igc3BlY2lmaWMgbXVsdGlwbGV4ZXINCj4gKwkgIGNvbnRyb2xsZXIg
Y2hpcHMuDQo+ICsNCj4gKwkgIElmIHVuc3VyZSwgc2F5IG5vLg0KPiAgIA0KPiAgIG1lbnUgIk11
bHRpcGxleGVyIGRyaXZlcnMiDQo+ICAgCWRlcGVuZHMgb24gTVVMVElQTEVYRVINCj4NCg0K


