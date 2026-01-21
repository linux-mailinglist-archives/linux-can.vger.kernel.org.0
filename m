Return-Path: <linux-can+bounces-6239-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ5nBmadcGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6239-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:33:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D589854714
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90F235A341C
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6FD47B439;
	Wed, 21 Jan 2026 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Pcedldyx";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Pcedldyx"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021127.outbound.protection.outlook.com [52.101.65.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A343E49E;
	Wed, 21 Jan 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.127
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987269; cv=fail; b=s/f9XkmHFMmA4gsn4UGmSNPLqRBrwQCgAOIL6YdmBjQhMEc26K2V9/4o0aEaZMJ1xP3U/liZjOnY7NWbHRMWkGoRuuV0tFktsi8zWVkq4NnNC7tcmjdMNvPo1I2+/1EcmahVtpI57jdPYuW3F0ZzDpNFkuX1iiSEKCBDbXfdCWA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987269; c=relaxed/simple;
	bh=gYxqo/2VJerUEIavom4wmNBDs0nXuI8lm/DHf3T2axo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tVdALEsbmSs93os4OY87e9MxuGE1QWCxsqzcq3RHGJu5Af/7f3uyNcc8gC+7oybYrWCnfvSah0sptP4Zieom+hWeiHRboWt9J/bI0CXmW+1IWGBeWHUDp7KJus7q/2fM6TmsSclMIuErQsB1yU1W0nwyI+802aJGqkZw066AFXY=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Pcedldyx; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Pcedldyx; arc=fail smtp.client-ip=52.101.65.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=owCmVYvr0uGjw7U8Q3hZK1JqZ4yw+/x+TpdUx9Kt077jFap4bbxQdFqBQr6kIXNECvzde8uBVzSdv8L+l0h5Gs4wY5CjOQFGjKx7a5/AaE+d6nP/I1hNeh/9fj/MjClmCb1v0vPth+wrYB/3/x7CWVZpTwNAFLEPqME6zOZoJrKJcY5zu6pf0mgNhgv+1a5ewVEhssVj9lZdki6yYJrNf9OVg9VlFzIByowibUGDG2BwOgjUmUQx7lf1ybfiQtyql6UYaiO4eCg1wii8DTvB3Zk+kO0P1KBXwBgEPagCuokGp8MBU2g9wAmELbupYDXbRdUV4Cmjhn31Cdtab/AbJw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=VHlVELMtUb/CN28AwXwcdIWo6L7fS19CCvjqdyyjiyDbY4xwU4hEgTsPiqd7o4oHwt0BPAkiBJGyubwO6VpWgFZMckokh6l9GpvRTD+4Qdp0P3PWQKjWCcLS9npzP78e4OL2kevVn9aNa0rn9fPMlWR0w60ueFG9J8VxBBkkI9+w1B/YkKzhxy8r1DShjSnbetBE0nHFcdzjDMz2jd+bcnbv2BHa3nOC7kS6U1xEYamAcFlngcxsHPQt/R01bK7vGfucCyW5sHoAgiJaBh4cOO8+fXdaWdCSuiPg6LSmH2Qcc2nsEdUSutivD2y4Uin+0QN4/QejdT9yeKSllftCNg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=PcedldyxGBqtLl1QTVC6TMaq3m5XWPRaTxIWMmOVV1Auug8gu8T4hIRqjD0KRyH8FAIPs/hCFhvfHVYGBYsNP6ca5T+PYoRC8olVfOVf3wICRWhuYTnCOqaIywfcmpenV2xuig6HGWruZeGmA1cQ+Xll7HZ+cE3CHnvJ2zAR4Ac=
Received: from AM8P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::21)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 09:21:03 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:218:cafe::eb) by AM8P189CA0016.outlook.office365.com
 (2603:10a6:20b:218::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 09:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0 via
 Frontend Transport; Wed, 21 Jan 2026 09:21:02 +0000
Received: from emails-8925427-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 8A50080616;
	Wed, 21 Jan 2026 09:21:02 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987262; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=FhAu6jt3h8ldFsXbBbtiCi3LKcnjS4x4hzuuSGi/Wt3j631CF8oRSYoSZQIOSsQqFDlyd
 hpiQMbfBwwnNhAQ6wUp76C46UCtNzg4EihTtxT6n2FgktmUhUAcL6J9hb8sQkRsSXEMHDTa
 2llOPmL0L4usQrc6Q4bR117iMgpll3Y=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987262;
 b=pLIgLNLxKdHMdreikoydEt9n8rxE5+jV1GCRl7jbmy6pV+h/Ue0NdCAd5fySsn/j/JpWi
 YigtMEwHuT+XnuY4/GJO6xCuRU4FPkE+kxnZEmUJ+MNRBdiUa+m0oBB3xnZn4OCXDAAMOtE
 YObHgRon+sSr3BXeYE5eUkfr4lEbuAM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAguBXB54uX5f/B4zILbRtywx2EFDWi5WnBqniB2qHNXT06rfSbxIhubvWVwYvLizGIL6XXQZI5A1j7MYik1x4rN3nE8nImC4AiZ0sx/uQYMJwGz6AzSVb9QUYIAKtFA3/eDTEwc2glALw6l9jZkjssa002E9YdnkOjXu9qNveGYfAne+/8IcwKqCukIDv37QabcBnB4rrFpNqMAXUjtpYr4m32COwVd2WCybHBdaJdxsnwAAjvTs5VBAMKd+ooYQ3SmxjqxzVb2Ls3JCxYmKR+4nA1dOxBZceeaxZa0m1wzl0CCZ0yNReJRbmT1AM5VecQ1somRS3udT/5p2WAIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=pEJFYRtoNPaFhVuTwJwZlxqJELNritHxmv4uqXxu2Gt7/9XOlIYjgFWV0f2XcvKnO+joaeNNiPhiuIycgMz/1aW8wkyLfb4Os8eN/poJKtz+tU5SYmUQWpfMFXnNAcLJb9pE50mJmDDhz2Vb6Z4iRf0kwOwDAEU7q1OgDMRA4xn1kdxLMvOml1cSIVUCV0nJP6M9j6L2w30gKnivirkqhmA3X88GxO6AOgYBXB9VJpH7a1l2YUnLw3BB8iC0L9s0QjhuT6AQtudBS5UMLRDeLVsRVtQYUGWREfE475PyCDf23gDBAWTE0DZDNtuzXfy7m3azKluHTXbOJr1GvZ8Veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fe9HEnhBGZ7R2bsDXykEoxfI5fKCH+sQXw4RTgj2/E=;
 b=PcedldyxGBqtLl1QTVC6TMaq3m5XWPRaTxIWMmOVV1Auug8gu8T4hIRqjD0KRyH8FAIPs/hCFhvfHVYGBYsNP6ca5T+PYoRC8olVfOVf3wICRWhuYTnCOqaIywfcmpenV2xuig6HGWruZeGmA1cQ+Xll7HZ+cE3CHnvJ2zAR4Ac=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:20:52 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:20:52 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 21 Jan 2026 11:20:38 +0200
Subject: [PATCH v6 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-rz-sdio-mux-v6-1-38aa39527928@solid-run.com>
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
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|AM4PEPF00025F98:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e08d1a-1fa0-45bf-cf6a-08de58ce65fe
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bllISENyQkZRTHpaSXB0L2xZbFFyd1pCQndZSGVEZTA1QkFqSVcwbkhueEtx?=
 =?utf-8?B?cG1qSU54S2Vod2tYS044ajhyL250WGRQUTlKQWxEampCTVA2MTZEQndvd0oy?=
 =?utf-8?B?K09OOGtrVENkNWVMY25vb0p2TXJuVVUwMEN5YnNQS3kzS0V5Rk51UUU0YWk4?=
 =?utf-8?B?eWNIbFNVU2hkRFErMW5zL040YTN3R1NCNFlIRmJ4bnRFeS8zQThrL2kyTVlY?=
 =?utf-8?B?NlQ1RHhuUUtHeldmRDcwaVQwd1pZaG5rclJGMWc0RGFpNFRadnBpUnJlbjI1?=
 =?utf-8?B?WTlQYzZCeW5sbHFaK0JBeFRtaTJITExsQWZaV05NbXBsS2lwWGFnK2Y3UmN1?=
 =?utf-8?B?MUdxNStCalZpMCtCYlQ2SU1TS2FzSkxuK2x6QmNsM0p5TXZHVjVBUXh6YVQz?=
 =?utf-8?B?QzlQWXlUSms5Y1M5NEo0VkE4c3Zvay9tVFQzTTFtR3hXWlVIRjNTajY2b3My?=
 =?utf-8?B?SnJOOWJjSUlZcDZPaW0vdDB4ZkJ5b1BMSm1ybUhRT21RbzlzZTd3cC9FeWdP?=
 =?utf-8?B?ck1aYlhwWUI2VDJCZnZ6UkZQYlVldkdLU1BMQnNadm9TL2UrdTN6em5kaEZH?=
 =?utf-8?B?MmRpWE92QXlIMEYvSk1Fc2F6cmNsL09VVDZ3S05zdElzMHFDRGQ5czNnNEZF?=
 =?utf-8?B?Q2N0cXFqbjNIaGtlOTdLTGdQZ0VFeDE0bTdaYTZrUEZDQ3MwQU16QWpwamJQ?=
 =?utf-8?B?MUFpbS95R2lxeExObldjUVYxcXlUbHcycXlUTUF3RzlQbHhaOVJDYXFqL0Rr?=
 =?utf-8?B?L3huOVdvZWNDYVpGd1IybkdpY3loY0NFYlFaSElwRjQ4Y2FSODlCOUNDN1l2?=
 =?utf-8?B?NVFEa3BFY3MyWUlPUzNGTWV2VWhxcEdoZWVDZ25OTUo2dTQxcWdwTVd4NUQ4?=
 =?utf-8?B?aUlaZnpySmtpbE8rZEdzdGI3dE9kR2lZWjhlRFdVREZFZS8xUmxwVVR2OW54?=
 =?utf-8?B?cWt0Z3A4UHE0WkFRZVJwQWNEVUVkNHFxek56QmpRV2pObzh6NHhCRVpxZWc5?=
 =?utf-8?B?cW96K25neUw0N0FHaU5vUmh0REVZZ0cyajNTOGV0aWtuZEVnbG1wYmhPanFG?=
 =?utf-8?B?MjU0RkVkY2lRVjFsTEJ1cXd6SzgrYzNqNmdMc2tDSzdBWk4xdkJwVk9wbnNH?=
 =?utf-8?B?VVpuTmkrd3QyOVZMbWd4a3g4VjVlaFJObUdHTml3VWVLdHo4TzhnQ09hbmdL?=
 =?utf-8?B?VjVRVDRjU2FpZWtyTmZEU0c5dng0NFNPVnNzSHIwMWlEak5LRUZxMERvWWl0?=
 =?utf-8?B?bk1xZUp2U1BDQy8wRVVHMmlpdVVicUVWem5oc0ZYUFNTNWtOYjU2N2hiZE45?=
 =?utf-8?B?VjRtZTl3SkxlWGFPQ3JGaW5DdkJjVGQ3UFhXS2lMdDZJL2dXa2ZWRjVFS2Nq?=
 =?utf-8?B?ZHo0Vy90M0dRcVJjQTlOSlNoajNMZGg4Umw4YTQrcGloTGtLNFMvRXFWaGV2?=
 =?utf-8?B?REZqOHBNZk0xVEpFcTJjeUFQdERLaEsxRFEzdFczUTU2R3pRODJnb0YydWsr?=
 =?utf-8?B?N3g5djQ4ZEJqNDVSSTkrQTRpQmRkT1VacFpWVDh2SE1qWFNhRVpqZ09tdEVJ?=
 =?utf-8?B?dmhHOERSYkFHc0pjRXNiVFUyWnhFY1kzS2dBbVQyS3pZVFFkT1I5Qy9VZGZr?=
 =?utf-8?B?UklLaUo1d29sSW1aTVh5VnJWUUdXRjQyYmpDNmJ0ZWpwUUJ2TGZ3dUI3VitW?=
 =?utf-8?B?SUpyUTRETUZZZWJEcHU5TFVaMDllbDdoRWJEajJGaEtSR0ZKYkZqK0VVc1hG?=
 =?utf-8?B?SlBFR2lMeU5DOXA5UzI4dmFJWUNOejhaVTI3c3lYWnBzaDBNZXlHLzFWeFFI?=
 =?utf-8?B?aFB2dy9NMzZ1NlNMZ0hPQWh1YWlZWXRXaU5CSDlsR1Y0K2l1RWJYSUNnVWQ5?=
 =?utf-8?B?dlVxNG1ENnRqWFdjZlJNOWxhQm42ZlNWM3ExL1MwUmVMVjQ2NjZSUGRURmc5?=
 =?utf-8?B?SjVISXgvc0w3SGxoeVF0b3ZzQ2lGRGs3clA3Vk1nNlpHYU1hcVlodjFrZmJw?=
 =?utf-8?B?ZmFDV21xcmFqOEdYS0ttOFhtMmRGaHFxdmRCTkYvSHNJTERueWR3RjNLekI2?=
 =?utf-8?B?SHRIbVFzTUMxMnRvajAxOXpyY1ZBOHFhbVNwTGJzUS9mT2wwOXVDeE9UaUVl?=
 =?utf-8?B?OXNNRTNseWlVTUFWSHhQaVc4Z2ptbkZyVmtVUy9qVmdEenZXdHlRRmVDYVdW?=
 =?utf-8?Q?aTBGsIx65fSHwZaZgwgAcur/pefH4TP3twbTZMwI2CLt?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b386ac8ad1fc4398ab982d20b0339979:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7ec5815e-fff8-48a6-0186-08de58ce5f80
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|36860700013|14060799003|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3FPNmhsM0p0OEs3OTg4V25KcU5oQ20rTEw2Y0ppVGMyMmJvcmVQbHRDSU9w?=
 =?utf-8?B?c3RoS09wZ2xDVWpPWE9seTMxbTBOWkE0UWlBUTJqNFRhdEYyVFVCQm9IMStR?=
 =?utf-8?B?dkl6SHZOSkZQcC9POWJ2aWlheVJuOXA0Vlp2THZPNmxQL2RIbndZTlFtNXpT?=
 =?utf-8?B?K2lrTnc2aUhGR0E1UUJmSXc1SVNjbW1zWTF6ZmJBQi9LWk04bFEyeHQxUlc5?=
 =?utf-8?B?b0FaR2thejFHS3Vkd2VWWnFPbzBxc0NkMnJueFd1L1NHWFc4MEZkdGZ5Qi9L?=
 =?utf-8?B?N2hGYjZ2S3h0Nk1oK05JVjFNVDlaZm4wQ0U5ZFppckF2clZETi92LzMxRzBL?=
 =?utf-8?B?blgyWjlMVlNSTmY5c2UvWGdjRmx4TW1RQ1EzS0ZDZnBSaFJucFRHbkRwdUZl?=
 =?utf-8?B?MHhQWGRJb0lHWHNDOHpkUVJoem00R3NIQ2o3cmNmKys0dmNWRm8rcEpSc3dG?=
 =?utf-8?B?eHpvN3NvSnhzNVBiVUU0SC9kbmN5bGsvMHdCcFkwL0Y1UktZQUFRbFJhdHNT?=
 =?utf-8?B?SHJiRjZXaVN4OEhPTkR5M1FkVkQzbi9sQktBY09ZSzJJUy9OeEQyZnJuS2Mw?=
 =?utf-8?B?WlJoNis1RTNsVWthVzBIWWQwcUluVHl5b0dIRzRuL0FBT2JERHliUE13eXkr?=
 =?utf-8?B?Y1hoeXBFajBBcVNqOXlDRnNOM0toQ3MyemFaL25uTkRzWkVmYm5XZFl2KzI4?=
 =?utf-8?B?N215VllmbGlFSjg2a3Uxc1pTUTk5aEZKQ01LU0hqaGtwQ2h4aW9PTUFOTHUw?=
 =?utf-8?B?ZW13N0x3aitScWRFbGZuSWY3YVl3MHYzUUNpK1ZvakVDWUUxM0N4RkpMM0xT?=
 =?utf-8?B?VkRqMXFrcWRkMGg5akszY2s3VHV6ZU1HSDg2VzJuZ1krUnlmZllhN2JMM0ZV?=
 =?utf-8?B?K2hEL3VscEpZejM0WW1DNzh0YmVaTEVBeVg5dWQzRmNCa2grdXQ3VGVZRUs0?=
 =?utf-8?B?Y3h6eUVXNEFGeUtHdDQ4bE91ZHJnbllOeVhJRVpDSk9hWEp3d0NFY2pheVox?=
 =?utf-8?B?UHR2YTQ2bnA0UklrbnNUUWZDdnNRZ1VEY3owM1JTQjVXeDhYVG05Qm90OGpY?=
 =?utf-8?B?dCtSZHVlQ0lQMUZlUld0Y2dVd1psd1oxTmRyRmwzc25iRGFZaER1ZHkrZnh5?=
 =?utf-8?B?aWlUNVFGTEc2dlBMZ1Z3U2MzOHlzTnQ3dXNLV21wY3RsVW1lL2VuYjkzaGFJ?=
 =?utf-8?B?N3Y3NEVVN2J4eWVzaHVrU3l3Rnp3b09CTGlUNmZKak52WFA1ejdRY25GK0Jv?=
 =?utf-8?B?em9nZmxHQ0lMQ1hRY2dRcm1CbmpnS1A4ZUxtZm9qeGVWZnNjTXFiUnMydnJi?=
 =?utf-8?B?R0VzYU1PR0d4NEVOQzh2SytxVWQwMjNXWkJTcHFXeEsyL2QzdGVtNjdlbXZL?=
 =?utf-8?B?c3R4MWNTb0VuTkpaUUtBaUJRdEU2dkV4TkxHSVY0MER5c2xPekVOZ2tVZVQ2?=
 =?utf-8?B?TDlzZ2VlelhNQ2I5QTAwbWw0NjRIeDNWUlhRY3JhVjBCRWJRS0ZzdS9tNG55?=
 =?utf-8?B?S25uNU5aa1AvTmdPZWZWOUI0eEVpUWsrZmVlZTJkY3FPM05Qelk3eldHbzRp?=
 =?utf-8?B?WHRzM3ViTnU1STRFZmxVOTZaUUdkZ2lBN21YaGlHWmVUN2c5RnJKRmZQcDBi?=
 =?utf-8?B?cXFnUmlMck9LUEJiaGNBNDI3MnNRTWhHOW91aW9YOFBpcnlJZUZUS2loL0VF?=
 =?utf-8?B?SU5LY2FWRk1XS0Q3bXRnTGZ2NG84bit6M3J2UXFkRDMySzBucm42UWVaaGp4?=
 =?utf-8?B?QVZGYzRqWGVYY1ZPVVZSZGE5VWt1Wi9yNXVjODQ2YnM2SFlyS08ySVpNNU5Y?=
 =?utf-8?B?V0JMdFFhZ0hrN1EyMUpaT2c4U0JkcStlOGlRb05mcDY5Rm1EaFRMZnlWNVpR?=
 =?utf-8?B?QVY3YUFUTkdpVzZvNXZiNXFjOGxjaFQ1cDRuRzBJempHTFYyUXdOWW9HcEFk?=
 =?utf-8?B?TkVONzI5RngySE0vTFhsMTRmRGluZzJaTDNzekV5RkZ3ZVVsVXFoem1CVFBR?=
 =?utf-8?B?MkFnZXRIWkNrVHJ4WnkvRzh5bVZWV0lzWU41YXcwRzh0ZnptUUNEczlTYUhy?=
 =?utf-8?B?YitOVHROdkh2Y3hzU3RCSU8zN3oyWTBRQTMzQ0k2MXU1RVI2MS9iVldhZmVE?=
 =?utf-8?B?U0NvWDJnTVhid0NqeCtaUkJtQnRWcHNtMWFBbFhaTU1TbXUrd2ptY1gwRnpS?=
 =?utf-8?B?VVFMSjczSGtsOERyYnR6TW41d1h1cXA5czI3OVZkOVlxTHVDRk0xNndENEYr?=
 =?utf-8?Q?gTRD2eubXbc+N4A+4stpXw7jYqHINQkpR+tnjPvbPk=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(36860700013)(14060799003)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:02.9867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e08d1a-1fa0-45bf-cf6a-08de58ce65fe
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6239-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,glider.be:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D589854714
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename the temporary devm_mux_state_get_optional function to avoid
conflict with upcoming implementation in multiplexer subsystem.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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



