Return-Path: <linux-can+bounces-6470-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEB1MvvxgWkMNAMAu9opvQ
	(envelope-from <linux-can+bounces-6470-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:02:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB1D98C1
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13877300B538
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD434BA20;
	Tue,  3 Feb 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ryWi7H2o";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ryWi7H2o"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023134.outbound.protection.outlook.com [40.107.162.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3E34B68C;
	Tue,  3 Feb 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.134
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123724; cv=fail; b=QfuyWfH2qeKLsk6LianlPgRyblEFxGBKOyn9B4zZGjqjbUkLhtdgZ2vkDPJAsE+4nVTjVGmzt2rFRiiuQ1i/OazDo22F/m90mQbJb1Ecg1lASloTkXqNr3JRrnt1vvPrFxpzGf5nykuvTclb3HLEEdGbALW/GGNItfhNB6BXlzM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123724; c=relaxed/simple;
	bh=KtFa0ZbVU02zVCjGIJbMfjxmw5gLWgwDuOX3EikYKFE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KfjciQJJkLmJPiybwvhefQd5nCiGPGIey4ynreEeiPnM8Anvww0yy5KMCufA1NCe27w6oGI5xT+vLqztgEcAtTSafVg6QcHkpU0VpZwF+zDJgJqHliimtXKGnaYpNA+zH+aQX4/uWGaeJGqNbI0csfgsk99FRVhW0XnOovrGBpQ=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ryWi7H2o; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ryWi7H2o; arc=fail smtp.client-ip=40.107.162.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gq2jIhz8TKjoFQz27D88/QQMZqdteeRtA4Plx/2N++0Xz5J+owecKhS99uls1sFX3lorzB5Ozg5+XMTvCGKPhQnypPXP9+PP9v1ZvQiZYmTkrM2zhuszdiXVYGjS/KYkt0pJvmevAeRQgKcP0cLIQGyqEjUtiCoglndNowjAVIi0qSlIK6OFkwD/W243OvohzSVZuokHKci5CvQHZ8cZPeqEoCENWSejETqG85V3kjvipSVsrjvS0t5muThddoq/l2zmS+IUpuzH0BMSaQ9aIaFiz52lDcpRdUIXA1J/Kr6k2oemdOzaGsrbSlK4V5D2ZvaiPoo3vvAaVcoovJSYPg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=QIMHKXMe9zBKQ0ttvI23wLhSXXa9sQ0Bz0rFk4yysgsDfF+f8AkDGBGtNbYsNZmQxdRoaWqSGAv2fg7DzA422vUK/NYIrszWeo+4YL0QUk2JwRVMirkWcvF8RWzenHdFVC629jurVACsDAl9SsvF9lYYOv/zaf64HWwuJNAPHHyo8j4whrTGWHf1FYJV/7tp2/w6aFI04wkDDY8hZsvrjuP68+jM+4BoahfrYTGPXJoI3a57NrtQZn8ZMQe7wR1y5LcnVIxEPNmH3QmfU6lwQYusBV+tZ0YN4rC+aJIKle65lF+xyBnFVF28qcqZ5UlU9o5QalWhYPoRsz+aTFgDqg==
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
 b=ryWi7H2oFD1tpKa7ILGeXnuqDLkiGxENp9tTcjLPd2fe6ZB4y7p8zFYADHIAj+CKOttNmGVLqRDhAHvJlJYuSoBfj3TsuxglBZkPYmOBXKCPGM0VARfJ5s94k1dX2zTrU2+D7/CpF8PCN7Tx4CfVS8dZryLPWXnJc+Y33x6wyt0=
Received: from DU2PR04CA0049.eurprd04.prod.outlook.com (2603:10a6:10:234::24)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:01:59 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::bf) by DU2PR04CA0049.outlook.office365.com
 (2603:10a6:10:234::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 13:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 13:01:59 +0000
Received: from emails-6863448-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 83F0280525;
	Tue,  3 Feb 2026 13:01:59 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770123719; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=p+tNnd0EdfEQnK1ryyq9GIwt/gxPXnW6FU7EDkC1h4K2Kigg0DlD5QYSigpvyko86rclI
 BT+xys0cca6wC42geCzVLydmPOb1Zs+YTyj0/zc5wQTCTcXwAAnX/sGNz3v1mkzXZ7kljMP
 ZprwKvFs8ij5/NFoI/GbP8jjSO1psu4=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770123719;
 b=kFzrgJ1q5evIariwWdMv7yGmE8whmJGvcYpNTc7P0Tg1itLAiD6zQPJ/Fa0xkMD/nmSuu
 FYpm8Ufh83fGeVmkOvHboQmahdg+JZxM0k1LxvInoOACSvvTcVaLvu5weR/xR40zul9xOcH
 0+sIOz3sAoYZzBFK2NF0u55phYDXkSw=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnnhLLYWcmwafL/FJlaI0z7ClsUqIEKaPtOtHquMolV9ece6irO/6esIORNd2cPrS9qyPLtMdi7H3inALWC9geYMlDD/RHE9OooM4zVmqVN5zNLgqx7+C65qIImtDFnSbXfw2sYSTfu4FMekVPY4F0LcdrRe8qNqtN9ccTYdFVrgnPtNXjtm71np+W+iR9s8to1KbGy6L9tDqB/bWznoNZIqKq/vqivCrak6BybNV2hTWsCkqqarITx9rGKg+X/paE0DRX4XDIX28LfXESBhx+D7L+V3o+IlkFaWuAAKU0Wcl0mnwepe4NrG5/vFsd9lZxuI2d3pZ2J1PZfrwTucdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=rLlPKeoSm1323kK+8dcCZcD035Zo1+trsIEf3k3y3j9BfVsIraHla1XFRL5U+pvH0kEOGmjqcM2IoBxfsY0AR/7OrZn37ywwmPz/vQJM/YqsAETzDA5tNiqgA+R/J8kR8RR6Wy1+omprQ9M/uZOzwlul1Mm5Idhy883+voZN+uEYC/IXcViWZMALHTS43mDKUH9ELxtYztsyDT7g/pJD9XcuS8vD1KZceC9S/oGHEVyQSW0cHtVswaRPn2YnC4YuAJpbchv+imq8MpBIlJ6YL2VgEwcb0FWNadv72nH1PCv9DFqoC167jwKfYkL8bDmTBs9G9TWclnLT9yJg2+Xljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbCOoPUKEGpa/SNTxRE1Bn/yoR4zpZTjgoQPj1ZrPrs=;
 b=ryWi7H2oFD1tpKa7ILGeXnuqDLkiGxENp9tTcjLPd2fe6ZB4y7p8zFYADHIAj+CKOttNmGVLqRDhAHvJlJYuSoBfj3TsuxglBZkPYmOBXKCPGM0VARfJ5s94k1dX2zTrU2+D7/CpF8PCN7Tx4CfVS8dZryLPWXnJc+Y33x6wyt0=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:01:48 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:01:48 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Feb 2026 15:01:36 +0200
Subject: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com>
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
	PAXPR04MB8749:EE_|AS5PR04MB10041:EE_|DB1PEPF000509EC:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 228fa1a1-462c-4315-3d42-08de63246ae0
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bHZZb0VySnBnR3VrS1M5eGpNN2dVT2Y0bnQydFd4Uy96ZFcvbHZGNTl5Y2JH?=
 =?utf-8?B?NHdtZ2s3VkMyQmpINHJWYUxtdGE4MVdxS2FRRjA5T0tGeGNLM21uZ2d5UUM5?=
 =?utf-8?B?SU0wM2lyK09ucEtzMzdFUnJnYi80dWpSVWhFTC82Qnl6L3U3QS9xdThYWUlD?=
 =?utf-8?B?YUFNc1dBREVhMGRKbFV6MmJHQ1htRDhwcjFVZmRORUFub0ZVUnFPUXZDMHpr?=
 =?utf-8?B?NjE0bXFqSk14YTA4MllkcDFEdDB6MXRIeVBkZWxKVldNaURsRmtJQjFOZWV6?=
 =?utf-8?B?bVBsUnIyQU0rOUI1dVFOa2w1ajFjSGFNREtnREp5ZDNIckh1NXVUZDdwNlo2?=
 =?utf-8?B?WUd4eEw2aVVnSnZiNHQ5Zk5tWDUzTHlhV2I0RUxSMWxqYzZBMTRWOEgxcmtY?=
 =?utf-8?B?V21idC9HeHgxUGhoeXBiL0gvUFVYTWJzdkpMK2pIa2hacmxiQk1WMEl2OXRo?=
 =?utf-8?B?STFXdUZXRmxqbFlwdkpvSEtmZ3RhNG9pQlIvd1NCZ1Jwa0taNS8yMkxtOHBl?=
 =?utf-8?B?V1lCQ21GNFJHckNnRG1PcDZlSmlzRXY2eE9vWkFjYmJzOFd6ejVoU3ZkYWx6?=
 =?utf-8?B?bU1MQzBGTnNBUjBoUEJEWEptYkUrS2dFTytQbWZOSjNXMXpwMGM2KzZOcGlK?=
 =?utf-8?B?czk5UEo4Ykg0ZktFdWVRcTZvK0hDWkF3OGFvTWh3NWVGdEtneG96eUc5UWpn?=
 =?utf-8?B?bVVabjZpY0JlODR6OC9WcFByaTZaZmRzSTY5dGMxZ2wyaFErYkVQNFVQdXQ0?=
 =?utf-8?B?TVRrclJFeGRqYkJpVHViNDhCT1pVMzFRc2Y4dVk4YTZwVEV3enYxVnhFdHJ5?=
 =?utf-8?B?bklkYUsrRTIzTkFyeG9YVm9OQkpySXIvUEVIL2tuT3RnNUgvYmR6dUxxdE9r?=
 =?utf-8?B?MkRCU2RoOGlkWFFTM1hpWUluM0pOL0N4OS9CbGh6ZTZJRGE1VnpkMTY1NjlY?=
 =?utf-8?B?WFdUeVFQNkNKcTlSZzVEa2hoMDJqZUF1ZWFaY21GL2pEVm9pckhjdUZhVXBV?=
 =?utf-8?B?NXoyakh4anhSMnoxUllEV1lXWEZ1djQ0ajdjNFFyQXZXNVFvUUN0R1BiaStJ?=
 =?utf-8?B?eVNZNHo5N09Dbk8yNWltNnllckhXZHJtak9MZTRDcEoweFBVelBDcmxjaUZY?=
 =?utf-8?B?VkwzRUFpWHBIKzRaaXkrQ2hGMEhCNG9VRVdhVGVYS0gyaE5tdWU0MVhhcmxG?=
 =?utf-8?B?eUk4TXZzVTFiczAyL3d0dmhsUmZ4bWtib3RiQ29mSVVJZ21CdEwzSWZURkF4?=
 =?utf-8?B?UEZCSUMwQks3MHRZcUxHcVVJU29qdnZ1WEZDM1N3UnV5WkpDN1EzQzdPSEV4?=
 =?utf-8?B?UENUVWFyWWVpNjFsWG9jbzNaV3lycUJkektHTHNkSFMxcVZkeFJ3anlHbU5p?=
 =?utf-8?B?Z2J6OXNiOUYzYWcwSVFOYWNNK000bUJmL3Q5RlVVbmtGRldoUEFVdFNES2Q0?=
 =?utf-8?B?R1NIdmRGb3FFZEhBSGpBTTVKb2dlTmo1UElOKzVxWG5yZ09FakJBdDhrWXg2?=
 =?utf-8?B?d0xLQ29MeDA1ckdjbTFSc2VMT21FMFhnYlgzT0JvRlp2aUZWVmRjT1U5VUJw?=
 =?utf-8?B?QnVWMHpIaUw5OTkvT1c3K0FUL0kvQ2s4SDN6UkpHVThlR01LZVJmMHUwak02?=
 =?utf-8?B?MjVybXoybzRiQUUrbFNEdVltMVI5Z2k0djBnNDlkaG9HVGFHL0h3eXBzaEJ2?=
 =?utf-8?B?Vzc0ZmZDR1ZkbXE2NURhRnAwcC9NNmk5WG9oL1UwSUN1Q1JEVE5vSjlqOTF3?=
 =?utf-8?B?RXRmMk5EL0ZKVkgzdmpIVDN3bUVJdG9saEVNS1J5RnNINFpIcUdxMi8vZnp1?=
 =?utf-8?B?ZHFYRi95d1gyaG40OWxha3JyTGppMkpMa0oyOHhBZE9sMnRPaEpuelQ1Q0s3?=
 =?utf-8?B?RFJtUUx4NUxzRFhSVW96b0xNZ3VjSlZZSGM3RGRDaTRkL0dVQno0S0lxV1Vr?=
 =?utf-8?B?QXdHMnZnTjBzOHRpNktiWkZZTkRNVWVIbDhLMVBQVVJpVUQvQU1PMzBQN0Y3?=
 =?utf-8?B?SFV3V3V1TzZnMnd4dDJiRHMyWWluaHE2QWpoYVJxT2RObncyT3NleUlwNkZO?=
 =?utf-8?B?OTVFUXl1K1pUMHErL2tMREpnQ1FwRFNWVEdyYld0Ry9JMGJUQ24zVzhHQkFU?=
 =?utf-8?B?NHdGZHVwZVIwU1Q4ci9sVEJWZ05LMFN1RXRPOUZVTzRid3lDcjZ2YWZ6VUtQ?=
 =?utf-8?Q?hn1+p/sSZASA9ljA4SuwHNGcx8DAZjvGzw5ZJF4DFx6p?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4752f6a644704bfeb8cd0bc9d4c91862:solidrun,office365_emails,sent,inline:325c726d7bb4eee7ea0486ee39a741b0
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5ad81f24-89c4-4705-c45d-08de6324643c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTZlMFRmVmo0RHUzNkVPWVc3VWtoQi9BVTNQUkVOMlFvMUNDd25WRUZSN2Yx?=
 =?utf-8?B?eVdDQnltZFg2TGVSc3Bncjh3WGx1Mm5FT2lsZTI5Zi9Vb2pLcWV4WkxlclZB?=
 =?utf-8?B?UGF0WGNyWUtoYWtETUJxR0JFMkJjVW5EaHNveGN1WkZnakg1K1l6eW9ibm1T?=
 =?utf-8?B?Mk1BSHJ0eGJySnRncVpDbUl1Q3R5Y1VkeWRJMXY4L2pYQUxnQ0txQndQMmRC?=
 =?utf-8?B?MlhLWW54UWNPQTl2TDBtdnpWNEV1elpQbXBKL0lPZGRIQlVQYUxKemhMOW9V?=
 =?utf-8?B?OU1jeG1WVDJhWXZlNEdIMENQcVpnWm90RkgvdXpMVDhON2lKTkJoSkh5dU9E?=
 =?utf-8?B?SGYxSTN3Zzl6V0lhUFB3dFplaG54blVETW9HOTlwQzI3aE1YQTVTaVFnVjZ1?=
 =?utf-8?B?L1VxdTV5VlM0eWRxVmkvSHh6ckJVTDNyTVRCMlEyQWhhb05DanpBc3BLdHB6?=
 =?utf-8?B?UUxrNUhWNFBTWjBnUGlHVDNpQXFMWWZwRklhRlByUldKUUNqSUxlOGZ2czFm?=
 =?utf-8?B?QUdSWTUvUDJVWWprRlA1L2k4bGlzUkcycUIrMm1IS1pGM3JoVmFaWEFuVndN?=
 =?utf-8?B?bzVSM0xab0M3cURqVEZPTDdRQlEwUTBGMjVCeFJuZHZMQk15ZlpCWFh5L2Vi?=
 =?utf-8?B?cWhFWnVPdDU5b0toUi9wUEZwbHlEVGxuWjl6aXJpWHZMM2lVcHRzRDFBeUNq?=
 =?utf-8?B?NkROb0JSUkwydHpaRXdQcDRpQ0pNRjU4cGphTm5IYXlqMUJkZmxRdHRyYXBv?=
 =?utf-8?B?aHRtK0dqeVNLRTZDYmZzZXVyaXlKQ2RKZDJrdEdxZENBSjQxbUdrKzJlc0dM?=
 =?utf-8?B?blViNjR5UnpOT0xScGl2Snl5NXNDUXQ3Y3dkZ2J6V0o1K3NETjNKZmFMN3Q2?=
 =?utf-8?B?Zkh5cTR0T2c5SXhWSkFhQlNIak9PUjF0UEx4NVR2YkJPL0JjM2FlV2NOQ1Jl?=
 =?utf-8?B?Tlo4WUZScE9pcnVsaHRMRVlIYUVoVVowWmtQUU0rY0V6aDF5b2tIMjhDdFJS?=
 =?utf-8?B?a1RLdGlvaUttcXhqM2lvRU1lU1E5VFB0RFo0MGtVRk94VHNSNFl2aStRR2h0?=
 =?utf-8?B?SzRQWDUyWXFOelFyM25FZGRvYkF3NVdyVEtLM3lIa2pJQmhOWlZJR0dXVlhL?=
 =?utf-8?B?TFBBMVRpa1F5SlRDWEhZMlQ5SnpxZTA5WVdtYTgzRFN1VGg1Q2pqV3Avd0Rp?=
 =?utf-8?B?SDVVNmVLb1VMb1RkM00vR2p0U1ZSS1RQTjJzdHFCYURsMHRaTkxwRzR1SjR0?=
 =?utf-8?B?TnlxamU2WWlFU1NOV3NPa2lyQnd0K1lDakl3aFFjS2Rkc1dSSGFEZFZSSWov?=
 =?utf-8?B?emVVc2xrd2FNR3h1UEwrZ0RwT1VwMDNGZGs2MmZkUzFPMFdGK2dRN0NGQ05v?=
 =?utf-8?B?TkNCaWNIMFZvdVNZclRLcnhqWVJCYzdPYjBNbkZQc0F3V09IV1liaE01SFZV?=
 =?utf-8?B?TUFjTDJzMDBJS1hxUFJUSDE0V0wzNDBRZDBxRzliaUtLQlZjb3FIZm9qeWY1?=
 =?utf-8?B?eTRnZUp6QnQ3Z2FMZ0lUUzB1K3ZGY2pudlMxbGlQNFdkdzhpbmw4YStHWlFw?=
 =?utf-8?B?RVpHOUgyQ2FFNFVFVUtNL0NsSU8rYjd5eU81Q210T05qcDlGd0FZcHZ5Sk5Y?=
 =?utf-8?B?SSt0eEl4bWJjVEh0WnNLRGw5Z2lzd1NQc1o2bDYwb21pd1h1bGlGeWcyM3Qv?=
 =?utf-8?B?dzlrS2pCbStMb3o2MVB6UUJpNDFnSytJUjJSbGkwL2VuN2xhQzBhYkxFelZV?=
 =?utf-8?B?emkxT2l6UUtQcjAzSldhakFobTlRZ1IwQUcvL2x0cHNkb1pWbU5yUmM3M3Zv?=
 =?utf-8?B?QnE5K2JxUVlqNDdITldFeU8wYzB0YVY5aWJEeWQxbDIwcHpBYXJZalZWWDVp?=
 =?utf-8?B?YTdaQ3pDWHVvL0dJSVVQT3U2MFYraXhqYU9CMEFrK3ZaV2lyS01YUU9WOFlB?=
 =?utf-8?B?UjZXbGtlSFpJWElsMFVYRXJuQU4xOUV6UlE1M2FEUHVkR2dGU3k1a1hta1px?=
 =?utf-8?B?Nnh0SFVKR3BKM2l5OTNZMVNsbTVRRmN6Y3FPODNpekdhQzdCQUJXSE9JcHhG?=
 =?utf-8?B?T2lYdFF6UUt1Q1lDZ2MzOHFEUXRCWkxicHVaRFpCQ2o0Q3p6S2docForaVkv?=
 =?utf-8?B?OG9DQ1IraHZZWkJycllraVBUS2o0MVNGVnMwNXdzaTMyVkpCd1k5NGhocitP?=
 =?utf-8?B?MFNQRzd2RGxockswc0IzcHJMMWxHOEUxMEx5NnhzeElLdkY0NWx4bGltZ1pm?=
 =?utf-8?Q?DACvC0yCQqV3PRJ27AbZVOuV6WxnRheh9pF9veceYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QiZiGeafT0hsI+lcxgmAlBFfDFTV9M4mw/aEoCLDM7BA32FQwZKYW4g0hJ03ffQNG+zvki+dL2JI6sYxmtwNQAvIHv9THt7IRyO9swIdqLhMUT+S/tUue2SOMVtsYVXKi4hRxQeM/T3GLnuAYGdBzuiqwHli0upRZabsMnlonVVjAo8k+8yBzMrKdmEM+Ku0evSJb5ynbxsjt3H4x4+jdaw76C/WSFV7AoYsUX3okbaMSS2jxjFnjs56dLw7M9noYSuu77o871uB60fFL46HA8cFy6CkKahvYfDxrsLZMRajm7dmInccDsna4vD2g3lw0UFTqJYXEtPiN2/FN6UrnsgjWe14NUsWzsAnT4Oo3F5aT762EEhECXwxoFvC2Lr4I3kJJwLaJMn0v4ATQRLeaYI8hTGLRJ2OufXZvq7OZlgpj4anD+F4GfCo208Vz0f8
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:01:59.5796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228fa1a1-462c-4315-3d42-08de63246ae0
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
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
	TAGGED_FROM(0.00)[bounces-6470-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 44FB1D98C1
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



