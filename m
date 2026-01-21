Return-Path: <linux-can+bounces-6237-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAlDDBWYcGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6237-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:10:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D7541C1
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17CCC46AEDB
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E347DF93;
	Wed, 21 Jan 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QStSNOh+";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QStSNOh+"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021105.outbound.protection.outlook.com [52.101.65.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993647D94D;
	Wed, 21 Jan 2026 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.105
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986036; cv=fail; b=lj9JqIq/kzNg7aSsuBtNUkpnMRTS15hQPZVJnG+Pqg4QDebWKOtbaCxdI7N+DRv/s13cwclgeybjDQHd7Y4l1DfXO2/ncMVeg/hEAheaq/i2SxDpoUPMDfgNe+kxRABmnMxq9QSevmKQLwaXLkOa8xUeCaJ9YbqZBWddPG6M0XA=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986036; c=relaxed/simple;
	bh=NMqXaBypb0WBXHJTyi+aPcqDbwbn87z41uyVs0QpgrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qv1myP+O6iqFQgSItzT85i7wixxiMqaeQ2uUcB637MYHhjXZQOcqFfZYj33+a4DRf2H1X01f+TVwo3b/Bz1ck+CWtTliPNpjqXtOjoV7fqX8m2XsgtF3rf8IOv1H0fwxBdxTiQOk9tIztHAAcO5qEP5qScMzffK5EqUZiAthss4=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QStSNOh+; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QStSNOh+; arc=fail smtp.client-ip=52.101.65.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qzV+aU3l5FWg76lPA/gFnEezNEyoizsU2ncYCQ/eGpcqY2tJXfvR2SQA5J28aZ2XFe8wbRO9AH9UccuV11cSw5Us0GjYQO3kZIGFbVSnZOfYAMsIeUhhiceRdjoqyaw52KUstmeb5VWn0ohUIoruajkuaj/KGUT6U8O+LM5JLAeAF/4ei56/wDOqOfiTvrJKObUVpnZp+fsHsIzKsDdn8/IawXV1Twh+iLH/ufvmp+4N702VVO16sVr3/u8BR4fR6O08YU3QPNbEdZdSYk3IXUkdFmiE4X8PwHE9KHOR7bj9uwsLLDGnX1VWnk5P14kn/8y990H+amD4VW3J/wW0Mg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMqXaBypb0WBXHJTyi+aPcqDbwbn87z41uyVs0QpgrA=;
 b=LU4b+k1AQi+5SXbWqAIlCsJodKLsowcaZrl80F3zH27emDwRQHhzhN22tPArZYJ0d3g8/FfFKxyG9KN6s/jzfEquXFm9ydsYPDTdJ4X6y4Uj2sb+txiCLEASmOsGQr3imSk1O3sflwlkPwkykCaMgQp1+dbNC9c8+Ti6kHKneyZegFuFKo8sVasb4IjmAXJJeJhcY6HmXv/6VE6ZgWyA3Hz8Z42GZ1ULwUDgyUgc8HiP2pR/fhZfvRTsodG1zmavdGSl+/MeRDLT2rvcCBDTptXdGhhTRUqsd5kA3gDIWTuqTbcEUywAlMPy39hkXroRpHQQC9sOzJq9WptEvoo4UA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMqXaBypb0WBXHJTyi+aPcqDbwbn87z41uyVs0QpgrA=;
 b=QStSNOh+zEgaLq31Xwz+1yHOVFi0CgWEbtkSwLlzXca/5TIN20wXRBdXbXer9vxCZDKgOshqfwpEIvAJWisMPPmHILRswZ80fzzjq42G7+fto3nFcMjp3SUuvEdCYvYT8IpQZQCMSa2SadvtgKtSX0ByYqpukCiBvL+Ld25sfEY=
Received: from AS9PR06CA0266.eurprd06.prod.outlook.com (2603:10a6:20b:45f::15)
 by AM0PR04MB11932.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:00:28 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:45f:cafe::65) by AS9PR06CA0266.outlook.office365.com
 (2603:10a6:20b:45f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 09:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 09:00:27 +0000
Received: from emails-8668735-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 220D280617;
	Wed, 21 Jan 2026 09:00:27 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768986027; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=NMqXaBypb0WBXHJTyi+aPcqDbwbn87z41uyVs0QpgrA=;
 b=CShvvRf6nxiPmB89/nF5g4po3EBYVrZJBHPy4owk83VZNKjkW+z7qfdb4uqHw6TvT1q8u
 PB9cfYDl/BrD6nFkBrzy/jZMxmy0u2mg5HM7M/++RT9IcBbo6xmQ4w/9tW4J3bPvjukHFdB
 bLj9Nk59wW1cPsqlsbBFtwCkHr2a/Pg=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768986027;
 b=G7uL3nC3zxlU8zcitg2KKNm/DC5725MPs71ZgDcOi5ljneGa325azbdaA+g/kLTQLCCnD
 oFVVsEXRvYqOrCPBOOik1m30tvR7CO1zECZjnVPjT69Ww+NUQ9O2s+sKGI+drMge6kHJ6qu
 DGth++AHdSGwqDxYNDHATNSgtscVBc8=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uACswkdkBpnzkyKNtHvar8IRX9NUCYYPT7go8n5lqGNGKpVbL/IAK/BtOsX7UBqw/32UkxYpy43yrSti/eirG9G2ThcLQs5mQeC26q/cpIzQ6Pdhflx8h69SkyCAhAhrHqbFYL5HQYNEGXnNYNBnEZxL/X/eh2n0gTgAzwvgyH5pKk/6CE7KyBZK6F1cTEbgTbXppErBR37163jQ+e1fdIu9er0wcOh06GLlpkPmNW0aU9Crw7ZVsVq/DUedl1YXk51rXXy2JFK9iG/m7qW8XVpK8HvsGxxcYbzqfYcus1yzM+go/XGI5BilQ0gNBnFV3WqiGXLple1j7dVJa592Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMqXaBypb0WBXHJTyi+aPcqDbwbn87z41uyVs0QpgrA=;
 b=hqCtjULaj1sf/zEqBQK3mvfst+SYc3Q1e8CkbUxMX1iuJlWBX1Rs1WI4I8cMlkYXDErRUMTfJYOZ+CE6bLe3qvhPLj+eZI9uxI0+XluRLE8QXp2wTOJRwgHXshDYfplaEw8cFoiYellDDD05HZRwjKygW/WJ9VuSCcI8BWn63ImRMCXCZDqwm4wDgSAhMkVivnRp6Hj5N5pkUvZmlzTMUtOz5cOmxfAePvZ+cAHflhMozKbj16I15kYyJViCsytk29kRDGqLXDvFtvgetv2fpWVNN22gRm3q10s7y38agJW4DEqQkyO7hohOyepT4jBMutODe3RTRsnzzhVOdC96Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMqXaBypb0WBXHJTyi+aPcqDbwbn87z41uyVs0QpgrA=;
 b=QStSNOh+zEgaLq31Xwz+1yHOVFi0CgWEbtkSwLlzXca/5TIN20wXRBdXbXer9vxCZDKgOshqfwpEIvAJWisMPPmHILRswZ80fzzjq42G7+fto3nFcMjp3SUuvEdCYvYT8IpQZQCMSa2SadvtgKtSX0ByYqpukCiBvL+Ld25sfEY=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI0PR04MB10103.eurprd04.prod.outlook.com (2603:10a6:800:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:00:10 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:00:10 +0000
From: Josua Mayer <josua@solid-run.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Thread-Topic: [PATCH v5 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Thread-Index: AQHciGVJHVdDvxtbtUSuVJ6PV8xJ57Va0jwAgAGFqYA=
Date: Wed, 21 Jan 2026 09:00:09 +0000
Message-ID: <04a8bbc4-ab17-4937-8840-893b17114335@solid-run.com>
References: <20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com>
 <20260118-rz-sdio-mux-v5-2-3c37e8872683@solid-run.com>
 <CAMuHMdWnpci1v1oQb34_QRtU-P3S8TSormmNudajT0e34EO14w@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWnpci1v1oQb34_QRtU-P3S8TSormmNudajT0e34EO14w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VI0PR04MB10103:EE_|AMS1EPF00000043:EE_|AM0PR04MB11932:EE_
X-MS-Office365-Filtering-Correlation-Id: c91340ee-a19f-424c-fdb0-08de58cb85c4
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RUVRU29xVGRIOXh6ejloRU1MK2w3MXhYeTlQTGxFdi9ZYW5lb29WRU1wSmk0?=
 =?utf-8?B?Ymt3VlRWUE0wcUxHMkZiQWJmYXJKcGxZcHJCUkwrby85V0RNOENJWkZ1NG5G?=
 =?utf-8?B?NVVmS3RnUGx6K1J3cUJxWFZKdFBQaGpzTTRhdURUUGhsa1hCc0FSUE1sYTFK?=
 =?utf-8?B?VWh3a1FHdFRvLytSNHNvdjRsSnY4dGxGdzJjdjNieVFYUWNOMm82bk5JREFn?=
 =?utf-8?B?Qzl3OEFxY3h0K3BwRlR1dlMvQkZGenNibU5US1l1VjA4Zmg2dXNPbXo1Z3Bx?=
 =?utf-8?B?VGNMQnQybGJIQ3grUUpNZVhaUUVpaFV1eENlTjdWUDBuK0VlbStIM1RuRVBt?=
 =?utf-8?B?cjV3UTdLSDR2YTNZTG4xRGorcmVWR0tIWEN0M0t6S21uQmJZL2JQNWlXOTlM?=
 =?utf-8?B?T1pwQXlzd05JdDhKRjhaaS9MNkRZRGtrdWcwQVBBMk1DUW1scGQ2Rk9LWXRF?=
 =?utf-8?B?UXM2TFgwNUVDbFVva2RFOWJVWEE1QkZhNlVIWG5adVhCQ1FoUkNFOU5SSGZI?=
 =?utf-8?B?WHVFbklyY0FKeFJXRHlzeDh1TURHR241bG90MnZoNUNCTjZoTWxoZnk2aXVV?=
 =?utf-8?B?eWtaUVhQd2YzZ0IweTlJeVAzR21IS2JGbmwzUERBYlRWdWt5UFdzczFwbzFP?=
 =?utf-8?B?R3NpMkppSWxyTUYwZitwbVNRcDEyeUt3cDNvQ1ppVHJTVmQ3WFZ1REZKZzVH?=
 =?utf-8?B?TWxPT0pIRDUzazE5S1JCOElOV0dOQUozU3JnaWRld0VkTlFkejhsRTEwb1py?=
 =?utf-8?B?bzZ6WXdtZEMybDQxbXllZWh4RFc4Zk1FRFVXcURtNHVzcUUvNS9ldGpYWVpB?=
 =?utf-8?B?WHRUSWUzNFgyNlhienp1OEVqQ0U1Ry9mcmFocFlhOHVINys2ZDVKdnl5bmE5?=
 =?utf-8?B?VjY4QncvbXlZN2dYY09hak1pb3FHVFZKQm9QMHgyRW8zS2hyODZKRWZBcWU4?=
 =?utf-8?B?eTQvMGpXNGE3S2JMYkhmdnhpaHpMdWZ5bXFwL1lGNHdJZjVSekl3LzBnZXlY?=
 =?utf-8?B?NDFqVlRyZFpiT1NFV0IwZkJpK0RIRm1XWXlYL1p6cEoxVWNhc0FVVmU4RTFH?=
 =?utf-8?B?WmZyenl1WUJyMXAyNHFGUzFKa250dFcreHo5RkRjY045cjc3ZkF3eWcwbTQ0?=
 =?utf-8?B?UUVkWVJhYW9RMmgxOCt3R2RNYjllcWx3L25OUGpMeThEdC9WKzJEWm5vUWE3?=
 =?utf-8?B?TmxqQ29FdElyYnI4TjBPWEszbkg5citkSytuTXBsakEzN1JoMUpaK0FlZ2Nx?=
 =?utf-8?B?aTJzMkRuRzR6bFppS01LVjVLU0JjV1BHc3E2dWV6cVExUVR3WDRSUXMzaEhm?=
 =?utf-8?B?a3VSNHo5aXVMZ2NjU1BLbUlnclQvVVB0UXR1cWp2anhPMmNRZWpDR0dHU1Nh?=
 =?utf-8?B?WUVvbWdFUWpoT3BoWUplcGU1MmFTeXZCUzQ3RzlEL1VDUkdzNEtMZUFrRWFC?=
 =?utf-8?B?RHlCc1NiYWtvdzh6dHJWcDJwN25kdWFYNVNJaUp2bEpPT2xzRTZEWkdJZlNy?=
 =?utf-8?B?OUdrU1EyUEtRMzcrTzhwNllBdnNDVU0xUlpscVY2Z1R4WG9VWUE2VldxMk9V?=
 =?utf-8?B?YVZsRFlNTm5PVjZlU01EYlEyTUtONFFuOGFneE9wOGVqcjM3cU5qNmJ0UjJE?=
 =?utf-8?B?M3EyRitxYXJBZ3FSeE82dVpVeHNlVEZkaWkwTmxCb2FzRHhxbmh5TGFFZWMy?=
 =?utf-8?B?aUtkbnBjcGdhVmMxNTUwUENiL0pGZTV4bGhUYWNCRDBFUWhzbEFyR2xGOVRh?=
 =?utf-8?B?a05hMjExb2I0SGhLa0NvMjNOTHFzeDJaT2xqajhVRlJmTTBuT2V3L0JtYXYz?=
 =?utf-8?B?MU1ISllCK1MwZGFsSzZyRm1mdnM5V2RPbDRhMlVQK2cxL1Rxa1VtVEZsL0Vl?=
 =?utf-8?B?emZ0dElSK2tqRzJZU0pGWTJYaStOVW1PZDUxRGxaelFqNVdZVHEwTHFyQURH?=
 =?utf-8?B?N3ZhWHJDQ3B5bEMxSXo3WHp6V3EvTXR1WnNoeHBIbU02TTBVa3dCbXBKMHZ3?=
 =?utf-8?B?c1lLSlI4eU5aY052SStadlFZTHJZRHBYdEVYc2Q4S0Q3eWZ3RmdIWXYyZ0Fz?=
 =?utf-8?B?cjFxd2pqZ0NQVGhPWlNJN2JmYlAyQldUR0luNVBVZHhnWWx6clQrUE9lZlk1?=
 =?utf-8?B?MEh3TTZMUnJqbTF3a3RXUnZIVDFWUkFxcjExL2ZXN3JEeVVJTGFlZ21qeUdR?=
 =?utf-8?Q?AoEMxpXW7PxNLIbN9JAfkbQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE30E7874B640E4BBCA6D32331E34D45@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10103
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: eedf2889ff3c4de1b74badd7aa0be0a2:solidrun,office365_emails,sent,inline:8ebf7a180bdaa797d4aa91d708dbd0e4
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b8d4da6c-27ed-43ce-e28d-08de58cb7b0c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|14060799003|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czFaeTcwZDdXeXh4Sk95NmZYZVhCdzhNdW1salZpMlBQUktrVjYwWjgwM0pX?=
 =?utf-8?B?TzVqY3ZVN0xkcUEwNTNENk9mbkdsL2NEeTMreTM5U2VQZVp5TndOUjZ6RUtM?=
 =?utf-8?B?RnJwaFNPemNLOG5XZi96RGhlVWROcTJwbDAwcmR3MG84cWU0dEJkT21ZTTU1?=
 =?utf-8?B?akhIWlJhc3RHTHJPNk0xMldzd25IOXNlVFZxdWo2T2NCaGpOeER1WVI4TXQ1?=
 =?utf-8?B?QmI5U2I5dzYxNXNpYk5tRXpONUtRQThwZVpqa1Q3aVllYjlELzlxeG1UMFk0?=
 =?utf-8?B?VVE1OERNMjNHaUpnWlpvbHIzallxV2dCUWtEdlRQeXNxcTJheVZCaWhFQ1hQ?=
 =?utf-8?B?VlhwYzdpYnR0aGgxcW82M0hUVzgwR0pJWXpoYy81all3MEEwRDN5a0tsZVgr?=
 =?utf-8?B?RDJkVEN0RVFLQkZkVWMraTQ5RHRxdmZsRklORDh0dG0yWlFCNStucE9pUXNB?=
 =?utf-8?B?cmpNazQ3RVk0aHFyRW9YODhGci9ybWpQSXVHNnRJdEU0Qm1pQ0dsdlJMSDNo?=
 =?utf-8?B?WFdMRDlsMWVuKzVOb2xzdXBEUXB5ZFcyS3VGSUthVjBDWURrYzFoWldvNStY?=
 =?utf-8?B?Y09wcDFNZEQrdWlvTTh6b2U3cUJPZzdoQ3crcGFSeVZaZCtQL04wRkpGQWtT?=
 =?utf-8?B?U25ZQ2RJalNwTnBrcnRJd2ppSHZrYmVsZG1CMWFNMFpXU2IxZ25LY1dFamFl?=
 =?utf-8?B?NHoxK21sV29rMzJXcHZXNVlCU2o2bEVHc1FZbitOOTNqZ2xKbHVMT0FUYVV2?=
 =?utf-8?B?TWxqdjdXaC9UdTJOdytvNERVYkZ2U054cE9EVGp1UHJ2eFVDL3U5RS9MV3dq?=
 =?utf-8?B?bmU5QnhsRzRYZEl6L1E2c3Uvb3Rvemh0eGoxNTZYUEdEM2l5eUJaTW5QeTNa?=
 =?utf-8?B?NE5UeFdCVTd5ekpSd3h1a1BnL0FDaDBTWC8rRHNFR3NzMmN5cERpajNUVTYy?=
 =?utf-8?B?MGRjd1FOZ1Z3dTJhVGNVNk42SzBVOGJDY2l5N016Wno4eFpxRFpZT1JDajhB?=
 =?utf-8?B?TE9IYmlkem5aL0NFclBJNTBzNVZQVHZxNWIwMGdjTWtGZE9xMWZpVEw1a280?=
 =?utf-8?B?NFRweHJrc2hjQ1d4bDRqRWo2eCsrMzZsMkZqZVIzWnJJQVZGSytmSUF6OU1k?=
 =?utf-8?B?QjFLa1NaZ0RCS3dvMnlQTHl5NXA2Y1hmMGpNelBlZ3VERm9WNWdiY3RCeHEr?=
 =?utf-8?B?RFI4aDdFcVFQdGpKMVZvNFQ5djJHNWVsKzNoOHIvVWxrYWNRMVZLQkwyOVJK?=
 =?utf-8?B?bzh2YWxLbnpJZWp1Zm9TU1NYT0VyNFVWUlB3YTh4M2lCNy92QTByRUUyYjFj?=
 =?utf-8?B?OTczbWRLTnFRNFZKYVJ4anNndnhxTzh4TkdPTUljU1ZxZkRhOVh2cHlLMExn?=
 =?utf-8?B?WmJEeTl2b3p0bkxVcFlhK2FyT290WVhCeWx1cStBTzFWS3Rva3k3T2VMSTll?=
 =?utf-8?B?eDBRcytyT3VrMGdMMUpaM3pIR0IreXlMdlRBNmdxakQ5aW1tb2d4RWxBZGRZ?=
 =?utf-8?B?TCtjREt1RXBtVEJDZkZ0SXpkVkdpSmEwcXVwS3MrbzZrWk1lNXNwK3FPa2Y4?=
 =?utf-8?B?UmZjNVdSSHVXczlIdnBsVzByREkvVmlFTmF0blk4MlRWeXRRVzQ0aGFBTzRH?=
 =?utf-8?B?VmVtMUV4bEZhNnB4cWQ2a1pYUW5DUnlqbVFXa2RzRzB0bjk4VEhjYXpCNHFq?=
 =?utf-8?B?cDk4SXRBWnpqa3FESG55SXpYKzBIZ2tNd2MxMVNwWGpUTVZaR1hyaUZOS2sy?=
 =?utf-8?B?RDVWTUZUNE54VDI4ZVBVcjcxTDNCcG9LL2Z4RFZmU2JsRGlYZXljRXZuRmxp?=
 =?utf-8?B?ZWlTamlIR0xIMjROZ2M2Y29XVEhNYUxxb2ZFYWxaeFIxL2xhWU52SDhtK0h3?=
 =?utf-8?B?ZEZqL1hVYUZ3YWlYRDJ3azZTUU9RSUM0bDYxVUlWdGRneHNNUGVwRStyOUl3?=
 =?utf-8?B?VXVTOWJORmFzMDIzOUt0eTFOdW5EVE5IclIwb2ZXREdLRWltcXZkdlBIMXZD?=
 =?utf-8?B?M1BGS08vTGIrVXdDWXU1T0RBbGtrZ3FlMDlDZldVRCtYT3B6ZDZMQ1pWVi9o?=
 =?utf-8?B?eUdRaHhLVWRqeEx1OFU5bDdFeFNJL0l1QmQxQkpxbDcyRE9ZU0ZjKzZJcnhq?=
 =?utf-8?B?aUFLdEgwZ1REMVZHWFRZR0N1MEEzS2d4dk95Y2NXb1IvTE13cWFqV0ZWT3I4?=
 =?utf-8?B?cGpZc2JwK05hVk5DSlBjWGZSU2pMK3FKRlM0ZEROUWw4NWNBaEpYeFNtWmE0?=
 =?utf-8?B?Y3Exd3o5eVFJYUptSmh1QXN5RGRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(14060799003)(1800799024)(35042699022)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:00:27.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91340ee-a19f-424c-fdb0-08de58cb85c4
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11932
X-Spamd-Result: default: False [3.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6237-lists,linux-can=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,solid-run.com:email,solid-run.com:mid,solidrn.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C60D7541C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMjAvMDEvMjAyNiAxMTo0NSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBKb3N1
YSwNCj4NCj4gT24gU3VuLCAxOCBKYW4gMjAyNiBhdCAxMToyOSwgSm9zdWEgTWF5ZXIgPGpvc3Vh
QHNvbGlkLXJ1bi5jb20+IHdyb3RlOg0KPj4gSW4tdHJlZSBwaHktY2FuLXRyYW5zY2VpdmVyIGRy
aXZlciBoYXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBhIGxvY2FsDQo+PiB2ZXJzaW9uIG9mIGRldm1f
bXV4X3N0YXRlX2dldF9vcHRpb25hbC4NCj4+DQo+PiBUaGUgb21hcC1pMmMgZHJpdmVyIGdldHMg
YW5kIHNlbGVjdHMgYW4gb3B0aW9uYWwgbXV4IGluIGl0cyBwcm9iZQ0KPj4gZnVuY3Rpb24gd2l0
aG91dCB1c2luZyBhbnkgaGVscGVyLg0KPj4NCj4+IEFkZCBuZXcgaGVscGVyIGZ1bmN0aW9ucyBj
b3ZlcmluZyBib3RoIGFmb3JlbWVudGlvbmVkIHVzZS1jYXNlczoNCj4+DQo+PiAtIG11eF9jb250
cm9sX2dldF9vcHRpb25hbDoNCj4+ICAgIEdldCBhIG11eC1jb250cm9sIGlmIHNwZWNpZmllZCBp
biBkdCwgcmV0dXJuIE5VTEwgb3RoZXJ3aXNlLg0KPj4gLSBkZXZtX211eF9zdGF0ZV9nZXRfb3B0
aW9uYWw6DQo+PiAgICBHZXQgYSBtdXgtc3RhdGUgaWYgc3BlY2lmaWVkIGluIGR0LCByZXR1cm4g
TlVMTCBvdGhlcndpc2UuDQo+PiAtIGRldm1fbXV4X3N0YXRlX2dldF9zZWxlY3RlZDoNCj4+ICAg
IEdldCBhbmQgc2VsZWN0IGEgbXV4LXN0YXRlIHNwZWNpZmllZCBpbiBkdCwgcmV0dXJuIGVycm9y
IG90aGVyd2lzZS4NCj4+IC0gZGV2bV9tdXhfc3RhdGVfZ2V0X29wdGlvbmFsX3NlbGVjdGVkOg0K
Pj4gICAgR2V0IGFuZCBzZWxlY3QgYSBtdXgtc3RhdGUgaWYgc3BlY2lmaWVkIGluIGR0LCByZXR1
cm4gZXJyb3Igb3IgTlVMTC4NCj4+DQo+PiBFeGlzdGluZyBtdXhfZ2V0IGhlbHBlciBmdW5jdGlv
biBpcyBjaGFuZ2VkIHRvIHRha2UgYW4gZXh0cmEgYXJndW1lbnQNCj4+IGluZGljYXRpbmcgd2hl
dGhlciB0aGUgbXV4IGlzIG9wdGlvbmFsLg0KPj4gSW4gdGhpcyBjYXNlIG5vIGVycm9yIGlzIHBy
aW50ZWQsIGFuZCBOVUxMIHJldHVybmVkIGluIGNhc2Ugb2YgRU5PRU5ULg0KPj4NCj4+IENhbGxp
bmcgY29kZSBpcyBhZGFwdGVkIHRvIGhhbmRsZSBOVUxMIHJldHVybiBjYXNlLCBhbmQgdG8gcGFz
cyBvcHRpb25hbA0KPj4gYXJndW1lbnQgYXMgcmVxdWlyZWQuDQo+Pg0KPj4gVG8gc3VwcG9ydCBh
dXRvbWF0aWMgZGVzZWxlY3QgZm9yIF9zZWxlY3RlZCBoZWxwZXIsIGEgbmV3IHN0cnVjdHVyZSBp
cw0KPj4gY3JlYXRlZCBzdG9yaW5nIGFuIGV4aXQgcG9pbnRlciBzaW1pbGFyIHRvIGNsb2NrIGNv
cmUgd2hpY2ggaXMgY2FsbGVkIG9uDQo+PiByZWxlYXNlLg0KPj4NCj4+IFRvIGZhY2lsaXRhdGUg
Y29kZSBzaGFyaW5nIGJldHdlZW4gb3B0aW9uYWwvbWFuZGF0b3J5L3NlbGVjdGVkIGhlbHBlcnMs
DQo+PiBhIG5ldyBpbnRlcm5hbCBoZWxwZXIgZnVuY3Rpb24gaXMgYWRkZWQgdG8gaGFuZGxlIHF1
aWV0IChvcHRpb25hbCkgYW5kDQo+PiB2ZXJib3NlIChtYW5kYXRvcnkpIGVycm9ycywgYXMgd2Vs
bCBhcyBzdG9yaW5nIHRoZSBjb3JyZWN0IGNhbGxiYWNrIGZvcg0KPj4gZGV2bSByZWxlYXNlOiBf
X2Rldm1fbXV4X3N0YXRlX2dldA0KPj4NCj4+IER1ZSB0byB0aGlzIHN0cnVjdHVyZSBkZXZtX211
eF9zdGF0ZV9nZXRfKl9zZWxlY3RlZCBjYW4gbm8gbG9uZ2VyIHByaW50DQo+PiBhIHVzZWZ1bCBl
cnJvciBtZXNzYWdlIHdoZW4gc2VsZWN0IGZhaWxzLiBJbnN0ZWFkIGNhbGxlcnMgc2hvdWxkIHBy
aW50DQo+PiBlcnJvcnMgd2hlcmUgbmVlZGVkLg0KPj4NCj4+IENvbW1pdCBlMTUzZmRlYTlkYjA0
ICgicGh5OiBjYW4tdHJhbnNjZWl2ZXI6IFJlLWluc3RhdGUgIm11eC1zdGF0ZXMiDQo+PiBwcm9w
ZXJ0eSBwcmVzZW5jZSBjaGVjayIpIG5vdGVkIHRoYXQgIm11eF9nZXQoKSBhbHdheXMgcHJpbnRz
IGFuIGVycm9yDQo+PiBtZXNzYWdlIGluIGNhc2Ugb2YgYW4gZXJyb3IsIGluY2x1ZGluZyB3aGVu
IHRoZSBwcm9wZXJ0eSBpcyBub3QgcHJlc2VudCwNCj4+IGNvbmZ1c2luZyB0aGUgdXNlci4iDQo+
Pg0KPj4gVGhlIGZpcnN0IGVycm9yIG1lc3NhZ2UgY292ZXJzIHRoZSBjYXNlIHRoYXQgYSBtdXgg
bmFtZSBpcyBub3QgbWF0Y2hlZA0KPj4gaW4gZHQuIFRoZSBzZWNvbmQgZXJyb3IgbWVzc2FnZSBp
cyBiYXNlZCBvbiBvZl9wYXJzZV9waGFuZGxlX3dpdGhfYXJncw0KPj4gcmV0dXJuIHZhbHVlLg0K
Pj4NCj4+IEluIG9wdGlvbmFsIGNhc2Ugbm8gZXJyb3IgaXMgcHJpbnRlZCBhbmQgTlVMTCBpcyBy
ZXR1cm5lZC4NCj4+IFRoaXMgZW5zdXJlcyB0aGF0IHRoZSBuZXcgaGVscGVyIGZ1bmN0aW9ucyB3
aWxsIG5vdCBjb25mdXNlIHRoZSB1c2VyDQo+PiBlaXRoZXIuDQo+Pg0KPj4gV2l0aCB0aGUgYWRk
aXRpb24gb2Ygb3B0aW9uYWwgaGVscGVyIGZ1bmN0aW9ucyBpdCBiZWNhbWUgY2xlYXIgdGhhdA0K
Pj4gZHJpdmVycyBzaG91bGQgY29tcGlsZSBhbmQgbGluayBldmVuIGlmIENPTkZJR19NVUxUSVBM
RVhFUiB3YXMgbm90IGVuYWJsZWQuDQo+PiBBZGQgc3R1YnMgZm9yIGFsbCBzeW1ib2xzIGV4cG9y
dGVkIGJ5IG11eCBjb3JlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1
YUBzb2xpZC1ydW4uY29tPg0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+DQo+PiAtLS0gYS9k
cml2ZXJzL211eC9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXV4L2NvcmUuYw0KPj4gQEAgLTY3
Nyw3ICs3MDcsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChkZXZtX211eF9jb250cm9sX2dldCk7DQo+
PiAgICAqDQo+PiAgICAqIFJldHVybjogQSBwb2ludGVyIHRvIHRoZSBtdXgtc3RhdGUsIG9yIGFu
IEVSUl9QVFIgd2l0aCBhIG5lZ2F0aXZlIGVycm5vLg0KPj4gICAgKi8NCj4+IC1zdGF0aWMgc3Ry
dWN0IG11eF9zdGF0ZSAqbXV4X3N0YXRlX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNo
YXIgKm11eF9uYW1lKQ0KPj4gK3N0YXRpYyBzdHJ1Y3QgbXV4X3N0YXRlICptdXhfc3RhdGVfZ2V0
KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqbXV4X25hbWUsIGJvb2wgb3B0aW9uYWwp
DQo+PiAgIHsNCj4+ICAgICAgICAgIHN0cnVjdCBtdXhfc3RhdGUgKm1zdGF0ZTsNCj4+DQo+PiBA
QCAtNjg1LDEyICs3MTUsMTAgQEAgc3RhdGljIHN0cnVjdCBtdXhfc3RhdGUgKm11eF9zdGF0ZV9n
ZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICptdXhfbmFtZSkNCj4+ICAgICAgICAg
IGlmICghbXN0YXRlKQ0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsNCj4+DQo+PiAtICAgICAgIG1zdGF0ZS0+bXV4ID0gbXV4X2dldChkZXYsIG11eF9uYW1lLCAm
bXN0YXRlLT5zdGF0ZSk7DQo+PiAtICAgICAgIGlmIChJU19FUlIobXN0YXRlLT5tdXgpKSB7DQo+
PiAtICAgICAgICAgICAgICAgaW50IGVyciA9IFBUUl9FUlIobXN0YXRlLT5tdXgpOw0KPj4gLQ0K
Pj4gKyAgICAgICBtc3RhdGUtPm11eCA9IG11eF9nZXQoZGV2LCBtdXhfbmFtZSwgJm1zdGF0ZS0+
c3RhdGUsIG9wdGlvbmFsKTsNCj4+ICsgICAgICAgaWYgKElTX0VSUl9PUl9OVUxMKG1zdGF0ZS0+
bXV4KSkgew0KPj4gICAgICAgICAgICAgICAgICBrZnJlZShtc3RhdGUpOw0KPiBtc3RhdGUgaXMg
ZnJlZWQgaGVyZS4uLg0KPg0KPj4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKGVycik7
DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9DQVNUKG1zdGF0ZS0+bXV4KTsNCj4gLi4u
IGFuZCBkZXJlZmVyZW5jZWQgaGVyZSwgbGVhZGluZyB0byBhIHVzZSBhZnRlciBmcmVlLg0KVGhh
bmsgeW91IGZvciBzcG90dGluZyB0aGlzLCBJIHdpbGwgcmVzb2x2ZSBpdCBpbiBuZXh0IHZlcnNp
b24hDQoNCihhbG9uZyB3aXRoIHdoYXQgdGhlIGtlcm5lbCByb2JvdCBmb3VuZCkNCg0KPg0KPj4g
ICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgIHJldHVybiBtc3RhdGU7DQo+IEdye29ldGplLGVl
dGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4NCg0K


