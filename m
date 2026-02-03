Return-Path: <linux-can+bounces-6480-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHfAEGYVgmmZPAMAu9opvQ
	(envelope-from <linux-can+bounces-6480-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:33:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C837DB53E
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C6E8300A745
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B93A4F5F;
	Tue,  3 Feb 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Z2qtvh1x";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Z2qtvh1x"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023115.outbound.protection.outlook.com [52.101.83.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF542741A0;
	Tue,  3 Feb 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.115
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770132683; cv=fail; b=ptPkFnw2oDuXUujrQd9TG9haeEIqr415xx1Br5q/VuzWCa5RwRYWP8H/EEq+BOwMYftpjMB0fA+7I6W143N6+yV0GEFsorccT9QQBEPhA+KJJrXWWvPCfGz5os8tFgmXNp/5WsESOZ6KuYdJnjlKAhS0lwaxDK80JqZ28Ja0Uq4=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770132683; c=relaxed/simple;
	bh=38l5XjQg2kme1aeDzm34XrOTd7sqn0sN34sfWZRztUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o8JQRzN910GTh+kEu0ul/rgwg1tIi13S4zV1pMyxBZvkBlNr2VxhEkgnvSlS1iFHZU/F67QQfzzLWnkG7kcNCY8Qoj5jS3L363E3pgPeC+6q5o7i6wSUmc8lz4LqCBVzDM8IzE4ZwBP5TvagvdGYed7IbwFvDYOSf9pDw5rGaew=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Z2qtvh1x; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Z2qtvh1x; arc=fail smtp.client-ip=52.101.83.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=n//chxIaKK+ZBRX1XWP+qL8lBEJV5U3xySpCAqR+ty9Zfb3C33d2x4/Ff99BSFkg5Nefo7nAcnVIS8lN/QCeL2tLSfVjEiMaYIvguthtsFS3wgs4gKgOamu/7zgsIoA48w04Nh5TiWyFesKrQvNJjVHe7y6IU60ZLhW3R2IhadwdgEOYoItyYVq8V2iNi398XeBAW4c3W469qij7r67otuGBQkvTrRB4z5nOGuAtOek5y7njHFQLOdcvMcljXKCLT0oVPMqKpZmYHk61yEKfO7MBgd9RZO3MldEn2O0mX3cgb89WCRYKP0vReRcQjAR8LpBuRmjS1vQi7gmSGy9KXQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38l5XjQg2kme1aeDzm34XrOTd7sqn0sN34sfWZRztUI=;
 b=GTGprq4fvRoRj+bMePy7ISQZlAp8Y+kRvU6GbGnPaLtZtyFbJuuQgicGxF2acq80tXm3Zhm67TRQ/mSbdQpRHTMN38FWPg7KZeW3kOe+W25p2NM3b9Vazv4i5eUh6ZZ5nnUNqLrYVwI2VuJbljA2AT20po7DORIOi9kvwX2gnd8MYl2tgwKobIltwsLRAyKNpNbreY57VQqS32rmCxEFY+ARMzYbsv7GD0Yqp15F+r//+5WjZfLhsAV65uRTtxS55+a9D2e3Octz3wNWOGAm32cGoSoiZefoZVgtXYIac1jSWh0H4GXg1ubpkIiKB/YioxhurXRtqn835n47rLiyDw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38l5XjQg2kme1aeDzm34XrOTd7sqn0sN34sfWZRztUI=;
 b=Z2qtvh1x8F33WMHaERKEP+WYw+6R5XxCF9r+x2xF4uhv2Xj4bnq/XnrW/nQltp7hzml9SOnnO74cAb74EsQKSXqIT3NPZ8uQ93MZMBWgtgoKDXlFsmEA7L9/+3olOouQQpexr8ddUmGiFCYQvFSMUEGmBQTjKa1sAawxgNH7UAo=
Received: from AM0PR02CA0109.eurprd02.prod.outlook.com (2603:10a6:20b:28c::6)
 by PAWPR04MB11609.eurprd04.prod.outlook.com (2603:10a6:102:50d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:31:18 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::3b) by AM0PR02CA0109.outlook.office365.com
 (2603:10a6:20b:28c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 15:31:17 +0000
Received: from emails-4234754-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-175.eu-west-1.compute.internal [10.20.5.175])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 6ABD080013;
	Tue,  3 Feb 2026 15:31:17 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770132677; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=38l5XjQg2kme1aeDzm34XrOTd7sqn0sN34sfWZRztUI=;
 b=LaDoLU2ij+Abd3s5bkFuYR9IoOM3QHvT2Dck+IywHIUEUKgJaNUV8+PEuC5fJXMljwh0y
 vf9Mv+/o7gbrpw/jnUq9pKYiQzTj9yXo8uWYWmosRG5vxJ5bo3h4aTfI3mZjVlXMw+ir2/O
 uZAhK4GLHsk8uFmx9yowNfU565BIslY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770132677;
 b=GmylElgiHLFiSUTuE6j4EmLoipY33YebfWc809ZQweFw141rrE3p8AELzyDpg9MGzSv8D
 m7AUPHDU28A19m6GXgK2tlr7ij5PPYL2vKMmEcAdW80bgL57SIDKN3unGEJV75DCqxCJ5to
 inRB33DwsVPBvgJFRXutPLvNUrv8SMg=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGKsEvdQtdOa4M85j+sW/MBQDWlPJa3iN21m2pbFeWMsoMN++UjfgieyAK00rgJ/whcm0ILnoZxAOUQorpawwzjbdcr/i/SeE14jomhA8Vo6Qbz+UZH7g6bdeNf9OGniiULUBV7ehKx70a0LDbowmKMoqtG8T78Xpe77C/8fHGMSrvET9u7CIv7eH+aHnLeQL9xDGeGlYYdhkRbvnhdc2ZCXroJHxfxpZc6+PZNOZRI+nXrNJNctrda1AU8eeCnBaAzBuquSv9TwCk13Mn/wllsV+nUzaDhX7nIwdTZWTItBsvV9/Y0KlYCkKZGVt5bzDZjUqx4MfE0zYD1dgn6oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38l5XjQg2kme1aeDzm34XrOTd7sqn0sN34sfWZRztUI=;
 b=WrlnUSKL742LFruvcD4SbNg9SptwCKykENXx/6iB7rGDeSebluhIVgx0dtBGFf6ZFjByxTxatSFOKih3l551pwJGNv+zbjIBaulcQSGJgjCUg6k0pu52tmtLWlE74DltMxu09qjunsyXSLiJbF7YLWsVp30NEoBIDZptHOVCeq1w9Q81PS0lqKi/7fguUxAYkSN3NQiyLutkWQsSIOCWVuEIbNR+dd0LusZECnHTYVV7ou48f9eNdJ7q/JJVuc26xUjBSPVsbKPC6mfUBTZ31G7oyvxiNhVy2yV4TO6jhkmplqmfbmk99snsRviNozjYC6Kamkl0tgKHsF8wGxtCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38l5XjQg2kme1aeDzm34XrOTd7sqn0sN34sfWZRztUI=;
 b=Z2qtvh1x8F33WMHaERKEP+WYw+6R5XxCF9r+x2xF4uhv2Xj4bnq/XnrW/nQltp7hzml9SOnnO74cAb74EsQKSXqIT3NPZ8uQ93MZMBWgtgoKDXlFsmEA7L9/+3olOouQQpexr8ddUmGiFCYQvFSMUEGmBQTjKa1sAawxgNH7UAo=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI0PR04MB10320.eurprd04.prod.outlook.com (2603:10a6:800:21a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:31:07 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 15:31:07 +0000
From: Josua Mayer <josua@solid-run.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Thread-Topic: [PATCH v7 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Thread-Index: AQHckGTeQp7u3kOOpk2xNnRQI4AIhbVxHCUAgAAHSgA=
Date: Tue, 3 Feb 2026 15:31:07 +0000
Message-ID: <6f23c76f-9ced-4675-b262-ffa8dbaf6b33@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
 <aYIOnErmiSZ6wnP1@stanley.mountain>
In-Reply-To: <aYIOnErmiSZ6wnP1@stanley.mountain>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VI0PR04MB10320:EE_|AMS1EPF0000003F:EE_|PAWPR04MB11609:EE_
X-MS-Office365-Filtering-Correlation-Id: a72cd3af-dc83-4243-cfef-08de63394673
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MGtobXVVVTQ2dzMxNG8ycTBuRmh2dXlvV1lqRHA0OVU3N1pFYjNRczJ0eG9B?=
 =?utf-8?B?WnJoeUlkMWpVQ3QydzRNS1dIeUVRWWhVcUdTbitpZlg0MGltS01neGo5azZ0?=
 =?utf-8?B?dU5aMHBTZkhQc2RIZHloc0k2Nk9xM1JCdUtndFF3bUI0UTFzdno3R3phTzcy?=
 =?utf-8?B?ZTk3QXVRcTY3Rk5DL2d0cDhncEpxVWhEZzRDcHk2anZIaStjUVMveFl0TDdY?=
 =?utf-8?B?NWZVVG0rbFAwdjQ2SHNQSzdYMitEZVhDSExjbThYdHlKNm5laXBYRVNLSmRS?=
 =?utf-8?B?U3UyeG5yQW5qY2xJN0pVbXpXNWhlendPWFM4U0ROMmQzWDV3M2lWcGR3VTBj?=
 =?utf-8?B?T0ZTK3JIdFc2NTRLeVRxcmw2SlJzQ05IcjhIYXhGOWY5bXUwWnUyZDBaUzNE?=
 =?utf-8?B?S25YUGVZcU5LZUIvRnY1YW9FakM0QVZqYkxwaVBNMk9ha0t0RURsVUN4R2Vn?=
 =?utf-8?B?bCs4VUJLTlhUQm9VWldmcXQ2bzY1WUNGYlhSdjZaSXBUN0RWT2xBY1BkRUNH?=
 =?utf-8?B?TnNwN2dXQTRtVnIramk0SkZYMzV6RG5OdExMUzBkR0pMVVQ5M09aS3Z3TFdz?=
 =?utf-8?B?Q0Nsb25Cbm92TmVRNllHVnMwUW1WNmhIMVJmTDNtNGNDZzQrRHF4MTZ4ZzZ4?=
 =?utf-8?B?R1dnSW5vTm4ycWtyTWlTNGFBWE9kV0w2RCtzaWh5aHlGOEVmZzZKY0x4NFVz?=
 =?utf-8?B?MGV3b2dwbDFseVMva2NkM2Rac0lXMjZqVG5JK0xuZEcxV1pGWG43S2VHWjhj?=
 =?utf-8?B?Y3lrQlpzTFZkR3RUZ3dQTmd5MW56S1BNNHZyRy9TQ0d6VkVuYVhMbGdYaEti?=
 =?utf-8?B?ZGdDUHV4bFVvU1FLSmRldzlNSkZsaUE2RG5oSXlnNkw0ZUpabnRzSlBkUkJP?=
 =?utf-8?B?OUxDcXFUdzl5eGtXUmViYy8rdGdKdVdQSEtDaDJwb0JYcWlXNnRCbW5TaEtJ?=
 =?utf-8?B?ZHdlOEJLenpGck5qMU41WVgwdnFBRzlmTXQwem8yUHo3TTk4YlFVZFpRd2hD?=
 =?utf-8?B?UDRZc1lMdEFybDRZaXluSno0YkdkdjdwWFFQQkZETXF1NUIxdVU4Znc2L3BF?=
 =?utf-8?B?YjJKSHBNSXkySnF1My9PSUpZL0VJbXE1dEFCUXk5MDJBQXhtZ1FnRmJQbFdw?=
 =?utf-8?B?RldlVDZ3aXI4ZjBLQk15RThyeWNKZit5R1R3aGZyYy9uaFh1aU9JbUFFNUkr?=
 =?utf-8?B?NEtKNGJDNjhGVkZjSXRULzVBMVNpWE1PNVBDUkdyc2pkQ0dRajdYaFREZTVU?=
 =?utf-8?B?cE1yUDh3K2JLTTVhMUFyOEVOM1gxZi8xV3VEUElUY3o0RkpIRk02d1IyRlAw?=
 =?utf-8?B?TDlJRWNZN1RLV1ErUXNjZlphWWxRNGZET0hjU3dMeW0wSFpVdVMyUmpqandL?=
 =?utf-8?B?SjFzNTlPWEFKSkluQ0NLdExqUEVGNm8welFtS2tka01HTVlKZnorVXpaeWFy?=
 =?utf-8?B?K0YwZGtCMVpWTTRHdjF0Qm10aFNDbWFJOVJGMWZNRmUyVkE5UDBCKzczSW9L?=
 =?utf-8?B?Q3JCTnJiK244WFpZNUQ2QmFmNGl4TmNrZEpmcnl2dVFKMnlmckJERGpwVXNN?=
 =?utf-8?B?dnA1a1ExcExjNnorOU5POGllTE91Nlpob0RxOXFKSjloMDNGT0xzUVJ0WDZq?=
 =?utf-8?B?NkhYbTRVcTQyV3JtSE1KcFliQ0srcjR6Mk53YUtuVGs5R1FJSmMxaEpSajhU?=
 =?utf-8?B?U2VEMVBZN0tBVWxKclNwN3gxZStnUHdRU2VpalF0THZSMUpGMjJsZGIvTkFy?=
 =?utf-8?B?QmRwWXBGZ3FDSFNlOWMvZHhmekxRU0JjOXRwdVhGSDZYaitNQ21aNWlUVXRn?=
 =?utf-8?B?bnQwNFZ1bGp5UCszNDdhS1BJNlBVci9ScmFqbEYxRkJuaUZwSm1tTWdqR0tL?=
 =?utf-8?B?Vko5ajFJRjk1SzZHRk5ucGtpc3RPU1pqbVZLSkVHNjBXWFlwQmlCUmh6N3RE?=
 =?utf-8?B?Y1dZWTdkajJOeGJrTFBWSlZpQTBTSTZ3VkM3OTZwTUI5c05tNmJucnhtSS81?=
 =?utf-8?B?L1E2eDJaQjJ6bGVVK2N3bWxFMmRhY3hHZlJTRzc1K3RPSUFnU053ZG0veEZt?=
 =?utf-8?B?UXBhdVcvbXFabDBHRXB1eUtURlRobTdNZDJhb1ZjRkVMYXFYa2hOMUJUMXRo?=
 =?utf-8?B?TlEvblU5V2RQR0pZcHVSeHdGZnV3ZnJEdmNKMUkydkxjRm9aQ2VETXIxdGdI?=
 =?utf-8?Q?RLfVFoAK9ZQLbzISPo039q0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9E2E26845ED394680740A66C17A4634@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10320
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4dff955ebaf645b3b4854b7691183671:solidrun,office365_emails,sent,inline:924a1854aa8fe8c78762fb21bc068209
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7a698be4-8473-4411-f9ad-08de63394013
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|7416014|376014|1800799024|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzVOc3l5dTF3NnBveDZqa051a3hya2cyWHY3MmdlUVMxcjVMa29RbnVDTEJI?=
 =?utf-8?B?K0Y2cWp0blh2Vk50RnpzNHAwcEtDRUppQ0h1RFlzcTVRcjdnWXZZdnBtUzlX?=
 =?utf-8?B?dytRbVk3WjFGaEp2c1lrVmJJa0FuNWZWNEV0Z1ZGU2FvZGl5NzVnNXphc1Zw?=
 =?utf-8?B?ZU56NmMxNjhrdkZnbUIreDVPUUViN2lmdXFDcGhPZUx6aWQvdkJieFAvNVc5?=
 =?utf-8?B?d0FPZHpCam1na1lmMTYrUmlXb3RtQnVzWVVxWjA0VThMOVYxYTBkZXp6cjhB?=
 =?utf-8?B?UjlCTzFhQ0hSQXpPdTRXR0Y4a0RUQk5aVzRIY0VOOHQwenloTGxmdGNWTGtz?=
 =?utf-8?B?SlpsYk1IekdoM3JmcDVvQUhDWk11RkV1Z0hPTUpBcytLWFhqdEJIQ0RTa1Z0?=
 =?utf-8?B?QmZ0MkF2bFJNakdUbTY2ZmN6b3dHMFlITm0wU0l4Nzl5aVdqcUFMOXFQWGN3?=
 =?utf-8?B?UnpjYklzZGJ3RGxCRElaZHZXUEZEQnFNenpMVUs3NnVtNGZROUZKZTIrZXBD?=
 =?utf-8?B?SFhmNVFKSkZxQnFXc1hmQWVEZkNiMDQwWlBHWDlFbStYK0pvcnlPYkJFNEl4?=
 =?utf-8?B?Y2JCQnJzcWhEdFhNa2Y0ajdXcFdDeTM5WlJ4bUNLdXFuK0hVdEZwaXVtZkZL?=
 =?utf-8?B?clV5WlJmQXN0WDh4RjBvcHhjZ3R0VzBQVlRLdURCVjZlL0ZCYjlMUWoxMU5D?=
 =?utf-8?B?Ri9SSXkrVGZzdkhmdVRoYVVBeW9QNytXNm9QMUR4b1RCVThCYTQyMFBPckpE?=
 =?utf-8?B?TTFjc1k4WjN0VnRFYVVDUzhLSU9CZlpPUTFhVmJ4TVZ0Yzl5WGs1UkY2V0lR?=
 =?utf-8?B?QkFQSzB2ZXJiSXhKQzBRUlpXemFQTjArYVJUMzVkMG5JUTM0NlgxR0tnbzJY?=
 =?utf-8?B?c2ZxSS9NY3R2VDhHbmRmYlpuSTBMbnY0bCtKQzFzWmlMaVVWV0x4aDZIU1NC?=
 =?utf-8?B?NWFiQ0poV21UUWE2VVlsN0VvaHI4RlI2elBmUE5iK3hwZVZLYnA2eWxVWHoz?=
 =?utf-8?B?ZkYvYU04L3Yycys3YWdjblNES0xkeCtTUVREaGppZUw1ODhnNWtEdkZUdzE1?=
 =?utf-8?B?US9MRmVwUHBUUUU1ZnluYm1MNTVodDVneldRYmNiaG80Tk5xa2NyZEFTN0wv?=
 =?utf-8?B?TFF0Z1pzLzRZTVpMQmdEM2hweFZDcmZ6RHRHbWF1QVp0d3gyMUJ1ZXRTWDVB?=
 =?utf-8?B?OVRWQ2dvMk1DM2UxSFZZczhvR0xtY09Fay80VzYxRk1PcEN6RzZHci9zRUpz?=
 =?utf-8?B?akYwbWdRZVYvZVBNU0NrbFhhekxlUW1jSGQ4Qi96NGZaRENVa3NGOXhvS0d4?=
 =?utf-8?B?V1BSVWFuOHV2Y0NRYzJIbjN6LzZ2Q0RuSytCWDkyK0lRMzRVZjRtVGFUTFFH?=
 =?utf-8?B?UC9oSlhPbVUwYllNMzc5N1JQb1JGU0h3b0lNd0R6OGJpNFIvREFjUTFjMVdp?=
 =?utf-8?B?UUlxRTI1aWtzRzgvRlA5Q2hQQk1CWEhvekZUbXdYeGFiTXVxYWs4MFVkcTcw?=
 =?utf-8?B?NVpXMkxWUEdSQUxNV093MHV2Q1NHMEhvTGtENVVCL0lHdXp0T0k5NEJyV0Vk?=
 =?utf-8?B?cExoc0M2K3pBNDBnMEViTjdkSU45eHNKbWJyTGNuT0F0TWtjb2tRVG83djFM?=
 =?utf-8?B?RUMyMmlnL291ODBCcXp5M2ZCUUJOMXBEdFFxeDN6aGN3MUh5c3d0VEo5TzVy?=
 =?utf-8?B?aVhkYlI5TzF0bXFabFBqTk1DdzlQYTlSNzV4TitIYXR1SGlNdzhFTHpuL3FP?=
 =?utf-8?B?aGVRUk51RmhOa3ZEbk9jWTNRdkpucWcxYVVXUFlFaVlqWG5uSkU3MUtnNTZn?=
 =?utf-8?B?R2NIYUlZUjdsZmpNTlNwRXdoWW5ZbDJpd1NSdW1SWUJvdTl1UFZjdTh2SFM4?=
 =?utf-8?B?ODhneEs4L244eTI1UXVHL2VSY0FtWHgxYmQ5VG9Zc2c0ZnhBQUtrNUhIOTJG?=
 =?utf-8?B?ZjhTM0JRd2s1cndjN2crT3JscFpwbTlXaWpkTG5ZbjJESE1BUDRLd0N0eEtz?=
 =?utf-8?B?STY5dFdtUEo4QUNvcHJjK1FIT01ud0RUUlB3MVZCcHhScm1VcjVkKy9mZ3lB?=
 =?utf-8?B?YU41eWcyRm5FVHE4NjlGT2lBVUx6R1JqZGIzbytMZnkvR01uaXZCQUFCZVpY?=
 =?utf-8?B?Zy9BSUxtemM3bm5TUGlKMzk2enptM2VPd2hYUWE2NDg2WnEzT051S1ZCVjZX?=
 =?utf-8?B?Uml2Q0pHWHk1azFmRkxadXhEWlZmU1lVNEtrRkdENmVYOGt2M3hneS9pL0xZ?=
 =?utf-8?B?c2xQTWFmclI4NnJBOFZFajJXZmdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(7416014)(376014)(1800799024)(36860700013)(14060799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZEXf/rhK0USi3NRePnA/6uBLnv6W2V1Ki/Mk0iRVn5o71/SyHvhd2JgwyQQyrBdR44GqgvJgqtAR7w8NxCtQxQVVtCIA1r8vPuWxRzoqNY4pnxENNwKKtk/72dLRqN6Uft61vFz8G9JRDG6ANqWvuEhzNwl2Uq7ZZlV967OfJUqJDRjqYZXi7maj1frIJqjLmQFYacqQZEIt1ulw2952Qr//J85blxC/6AjHYOo2YmQjFZ4EX2HTFW41Q71x6nsdb/XQtc6h5tMRV1tIl1fQoEvrlTXnfhSTwQ9FkuNzFVwwAzDiYgNKSDWXzsnsFLQ6LIqw9QUzIJDOqLBKikbixwUfSZgRi99oEoCIuu9d/0keg14dsyEQFJWabt9eHA6aBXebjYXVJvSSjBht10w7svagCmjV3SvSk+Qz1tAyax30MizhJVaVaT1OdVOiybhs
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:31:17.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72cd3af-dc83-4243-cfef-08de63394673
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11609
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6480-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,solid-run.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9C837DB53E
X-Rspamd-Action: no action

T24gMDMvMDIvMjAyNiAxNzowNSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gU29ycnkgYWJvdXQg
dGhhdCwgSSBqdXN0IGxvb2tlZCBhdCB0aGUgaW1wbGVtZW50YXRpb24gaW4gbGludXgtbmV4dCBh
bmQNCj4gZGlkbid0IHJlYWQgdGhlIGNvZGUgZnJvbSB0aGUgcGF0Y2ggdG9vIGNsb3NlbHkuDQo6
KQ0KPg0KPiBPbiBXZWQsIEphbiAyOCwgMjAyNiBhdCAwNDo0NjoxMFBNICswMjAwLCBKb3N1YSBN
YXllciB3cm90ZToNCj4+ICsvKioNCj4+ICsgKiBtdXhfY29udHJvbF9nZXRfb3B0aW9uYWwoKSAt
IEdldCB0aGUgb3B0aW9uYWwgbXV4LWNvbnRyb2wgZm9yIGEgZGV2aWNlLg0KPj4gKyAqIEBkZXY6
IFRoZSBkZXZpY2UgdGhhdCBuZWVkcyBhIG11eC1jb250cm9sLg0KPj4gKyAqIEBtdXhfbmFtZTog
VGhlIG5hbWUgaWRlbnRpZnlpbmcgdGhlIG11eC1jb250cm9sLg0KPj4gKyAqDQo+PiArICogUmV0
dXJuOiBBIHBvaW50ZXIgdG8gdGhlIG11eC1jb250cm9sLCBhbiBFUlJfUFRSIHdpdGggYSBuZWdh
dGl2ZSBlcnJuby4NCj4gSSB3aXNoIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGVzZSAib3B0aW9u
YWwiIHNhaWQgaXQgY291bGQgcmV0dXJuIE5VTEwuDQpTYW1lLiBJIGZpeGVkIHRoYXQgZm9yIHY4
IG9uIG1vc3QgZnVuY3Rpb25zLCBidXQgbWlzc2VkIG9uZSAuLi4uIC4NCj4NCj4+ICsgKi8NCj4+
ICtzdHJ1Y3QgbXV4X2NvbnRyb2wgKm11eF9jb250cm9sX2dldF9vcHRpb25hbChzdHJ1Y3QgZGV2
aWNlICpkZXYsIGNvbnN0IGNoYXIgKm11eF9uYW1lKQ0KPj4gK3sNCj4+ICsJcmV0dXJuIG11eF9n
ZXQoZGV2LCBtdXhfbmFtZSwgTlVMTCwgdHJ1ZSk7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xf
R1BMKG11eF9jb250cm9sX2dldF9vcHRpb25hbCk7DQo+PiArDQoNCg==


