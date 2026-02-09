Return-Path: <linux-can+bounces-6517-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ90MyK8iWmkBQUAu9opvQ
	(envelope-from <linux-can+bounces-6517-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:51:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F010E5E9
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D146D3021E50
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD6367F5D;
	Mon,  9 Feb 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Vf+ba2Uu";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Vf+ba2Uu"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023075.outbound.protection.outlook.com [52.101.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00B2D7394;
	Mon,  9 Feb 2026 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.75
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634069; cv=fail; b=H23BxrHKWdqgdqfRppVN569mjzCSgIkZtJVnGahirRUFEuWvnyp4ntV/1PY6fr6setp8dmHuxHc22TW/vz1OtheUMyUIX4mlYxpoi5K6VgkSuD9foxWk1UXXWFzwFKmGB+DwDKzWPM5AG82UZ2adfAjdyneXBQH5tgitrDk45hw=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634069; c=relaxed/simple;
	bh=yatRKAwazWl0TjW+w9YnU9sn9lcwbNMqRDZr5sLZZIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hivy3fw2aU5d35YnJ6TESiOylJj6S9uPZVuBM+387o2fUppAszsFijVwFj4PU+mfKO2MW6cPUc2f7EMDB+lKJ6YoRc5Xy3kOsw/QKcJhc3ndJyw0y9tjGVR7N7wkNxW7NQkqrWCNKep6q6NAFQyj6IJo5pxNP/yB7CTACRGmils=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Vf+ba2Uu; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Vf+ba2Uu; arc=fail smtp.client-ip=52.101.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ICJXxd0kwDpvnvHmWnuWUFgr6G8V5CE0hPSQow3t4+TIMU083FWATYJbU4uEDxELhhUdwZVwkKWDJvUqVWf8zsfmCTZlHXPmSmkn4HligHMTT7SWLWleu/THXmI6mORo33p4by37yipWa2e0FFO9KHTupzJcCPFTBZ7ulDzbpH0gFwDLYK8Vm+QeUHh8ZwYSG6YqsS57liNFkDYCfqm4ZFAot/9nvYkQSAsUdiW2UzXZY8JDJYWm/BtHlxUfZ/AYX/LWidwi/WzzIgxjDYYrITzRrVgYo/P2tSCJe+RgyLZwAjURQitGofboq3r5VC/Rx/wJM9qrDHS8URBbuW2DYw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yatRKAwazWl0TjW+w9YnU9sn9lcwbNMqRDZr5sLZZIA=;
 b=aYFosbbJ0k7BnA5M1F8eAHU6brjC45wQ502REPqga9XTz6HY/SOs7xs6cUwbPtzHENa1TT2eMC6cyJqkFOchgMUO/uV69apQzXLUmNkgtjgAVzc+KH4bekuyvWJF/HTm7KZIKzqjkvJk5zi508TsiHyrNvv8nLqcbNR/znpJcjR8kqx4hf/grAiPks36nnimx+0XerE0aWR8DS+EkfuDTPmdY3zT9YcrI+bIeIW7X3plqViv6fXmPzBJ3rfhI+cjbJz7EP2Geuyb+WIS0dBSzxbPtcBz6SlCoUiQwKYN6sTBYcI9rwBgXRH7r74kQbuBfGlfkFXbFsdfKMGfjhb+wQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yatRKAwazWl0TjW+w9YnU9sn9lcwbNMqRDZr5sLZZIA=;
 b=Vf+ba2UulzkyvY/6VxM0YGEO3+XcxNj3YycZkHfK3DUscEVH4BIcHluo4yXLxOWZ9xx1k/As8z+JAxdup8hYLMUwYtV7JbA8z0Ct3EIEVAesamUO0qw305ZkyGPaB8eja0FTPwEG+ow22fCFL9C7D2t6VZYbUDvUezrPx24Wc+k=
Received: from AM8P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::11)
 by DBBPR04MB7705.eurprd04.prod.outlook.com (2603:10a6:10:209::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:47:46 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::73) by AM8P190CA0006.outlook.office365.com
 (2603:10a6:20b:219::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 10:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 10:47:44 +0000
Received: from emails-2847890-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-8.eu-west-1.compute.internal [10.20.5.8])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id A5E8E80301;
	Mon,  9 Feb 2026 10:47:43 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770634063; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=yatRKAwazWl0TjW+w9YnU9sn9lcwbNMqRDZr5sLZZIA=;
 b=LkwK4CZFoL5uEdB3Xw2lDFqF942kytXBNZvi5WqI877Ezcg6e+TVNTfWQyOjtFvylZEg2
 UprquaBYFRdZGX3Drpn9dooazS9qhhTr5v7sAMVPgOoehu9aGJ2jALi+RxdD0Z2EpBS9LIb
 YL753B0LAGai37GgwzBLZ1iTKhwWQDc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770634063;
 b=WWrt/cwCSkkuJY299W+BvYc4Oiw1ANyPrpfwk6stUDgr8MlGIIAa9emtkVrwpq9RQUrrJ
 AbjRAVLPNKXa52vAPX9OzOuwciIpdwj34SonqqQNZYnuOS1ZctRiGIeNmCcvHhVJ3EapDrP
 yyB68uXchQuGWV1sijJXpIcFJhH2X9U=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG4hLbu640j/Hl3pqs2IhMgbKB5p2o/l7+ERIVV4ii3CutvchNy/Kdp8wuFUb7rlsM0PWzJuqS7O0GATi5Fp28qdowLTsXw831sPVk8OfYu+zbk0q+q2lQrZlkt3VvaVceaAmkzMWDc6toz11X1kjXU6kM8u8FNwi0S6wraNvb4q5Eo+pos8aj5ZmcCE3JiR4uT6MO3aPo6PlWJ9JsEy9YP0FOKTfHQyvDlAuFdSnW/nWql9xt2wd5vmo8q6qVOi9Vyh5SbNCY6NPmVwOZF1kQyH0C8cLe+xT54N9E67rBC9MY+430H55dAy4qPoURKryHIx5IIFCMRDnbKl7sx+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yatRKAwazWl0TjW+w9YnU9sn9lcwbNMqRDZr5sLZZIA=;
 b=hpiJ5gFCLFXitsBR+ScBcrHWXuXxnj8G0dQ9QZRAee+ts8+/4yJlo1FaVh+Ikd7zW91VCPAufiXM96RzUSC8NZLsKEX9aMAT2vuOXAW+5regyZ9Rpro8FaqTI+QLMlILaEVbgriY55EVpFDoxlP07BBbjDh4ZRd4rLQ3RAb5W86AthohFOBf17EzH9TCCVwZ1UtACgemrr+rNBNw9QNGEFlcJlq5IF5Y48xbyIFbxFcGXfPetv7196prkLF1MaT6O34Pu9OTuRbBXtTxEgVKbBvAT5c3pJoxZ6XW2ANOLJxR2Zdcogt4pVvJuVLMCNa6YW1dlQJXEYU/u9Efp03Y9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yatRKAwazWl0TjW+w9YnU9sn9lcwbNMqRDZr5sLZZIA=;
 b=Vf+ba2UulzkyvY/6VxM0YGEO3+XcxNj3YycZkHfK3DUscEVH4BIcHluo4yXLxOWZ9xx1k/As8z+JAxdup8hYLMUwYtV7JbA8z0Ct3EIEVAesamUO0qw305ZkyGPaB8eja0FTPwEG+ow22fCFL9C7D2t6VZYbUDvUezrPx24Wc+k=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DU4PR04MB11845.eurprd04.prod.outlook.com (2603:10a6:10:621::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Mon, 9 Feb
 2026 10:47:35 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:47:35 +0000
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
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
Thread-Topic: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
Thread-Index: AQHclQ1B8HejTmuXEUSnLC013GRTOLV48bmAgAEaEACAACM/gIAAAXKAgAAIagA=
Date: Mon, 9 Feb 2026 10:47:35 +0000
Message-ID: <1a4288f2-ee5c-494f-9fbe-ea3a90a16014@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com>
 <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
 <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
 <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|DU4PR04MB11845:EE_|AM4PEPF00027A6A:EE_|DBBPR04MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: dff2849f-d114-43dd-516d-08de67c8a7e6
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?N2h6MktLYlhNdUVaeVhkL05VTTFKYU05d0RqdG9PejRzUXd0QmVmYlBKTjBo?=
 =?utf-8?B?S3JLSjdEMFI3cU5OUWJISitxSVd6S29kaU4rRHQ2Nm1hT1N1TGpMdDFsemxp?=
 =?utf-8?B?M0FPODdrNUt5cDVJeGtHT0Z1emFPdm42NjUwRDJJL1N0bFZvM3VhYk1iS0Yv?=
 =?utf-8?B?V0N2NnFFODVvREFTcGs4ejJRVDYxOTNibXUzZFZJTHhXRE5IUWVJLy9kOFI4?=
 =?utf-8?B?ZmNMb2o4T2JMT3dzd1BlVUF0N0t3YzZtWFdBSFVCVGphc2c2S2RFNlJJc3l6?=
 =?utf-8?B?NUpOeDdmeWVMak9hNHpGQ1V4TTVPMitCNHhZaEx0TncvaVpZYnRySGxKanlF?=
 =?utf-8?B?cWtKR1kvQ2luMDV6YjlQbmR2ZEJqdzB1K2lxdmt5Y2s2ZG15K1llWURGc1BU?=
 =?utf-8?B?VDVtekNHQXNKNUljdU1wbjR0Wjg2bi8xcEhNVDNzejdrQ0ZOYkNXTWFqUWo5?=
 =?utf-8?B?M2E3REV4a0Q0LzlHSHQ1WVBIYjlUWXlYSjBRY3kycXcwem10cU90SzM1Wnlr?=
 =?utf-8?B?ZE8vdjB5L25wUUhJbytlNEpGalZ4RVdvSkExcFB0Y2k1czRjcjZqb1VlTGZa?=
 =?utf-8?B?THp2MlBaQ28yMkxnUitjU3lVK3pzNGVoV2RwWExxUmRHWktnczd4ZFFwdWk3?=
 =?utf-8?B?RzUralBoeUl1R1pQdGgzUU5XYlFoMURBaFoyeDVzcng2VDNqMGZuN1lQSlNt?=
 =?utf-8?B?L0pkWHNNdVBSRjZCVnRTZG5vWjRvOWVOUWxTbTBTOFVjMFNaVnFZQmJ2NUov?=
 =?utf-8?B?Q3kvcjk0amY1ZjY0Vk10Mm1aQklkeWNnUkJyUlFNVXowNmVPTHJSaHY5UUcy?=
 =?utf-8?B?dTBGdGVBTUgwL0syaTBUSThVUkZOd1ZDZW5qdkthUFNsMFFuY1NZaUY5M1k3?=
 =?utf-8?B?dk1TaFNaNERWUUtxMzE3bmtrTjRzbnY0aXZZM3ptK2tZdittRkl6Y3N5NFcy?=
 =?utf-8?B?cUtDUUFpU25rTlB4U2FEcDVRNUp1UWdKdUdlNm5WY0tJVk9Gb0YyM3p6VDJO?=
 =?utf-8?B?VEpUbEJvUTc3Y2RZY1BmK1JmVHZHbVNKK25oVjhoSHVOQ2xsdTc1Y1JiWVlt?=
 =?utf-8?B?TjZQRXkvYTNQUEMrWnd4ak05OStKbXpXYWEyVW9hRjl5bkxvbUhwbUlJR0sx?=
 =?utf-8?B?WEUvdEhuRy9uRXU2MkptMWdUNUtFWVcyK3B5bDBDeE1SRkk3UFgrUnUxRys5?=
 =?utf-8?B?K09Uc2g5YnFSdVFHcEMzVnYxUDR5QnVvNGM0VDZsV0FtcllnbDBaUS9DcDJM?=
 =?utf-8?B?ek52ZzhPU0JhTlBhdzZpVkZQTjA1WHV5Ky9pelJ4UjM5VnVkYnlvNkhZN1p1?=
 =?utf-8?B?RVhuekc4dXNFL0FLT28xRXNHWG9HYnhuVFArSUlDQmU4QWE5cGQrQUU1a3pz?=
 =?utf-8?B?WE0yWXZOLzh2TVhZdkF6aVJRV0Q5Ry9KeVVwMmV3VndHQjBxZ01VaWRmUG44?=
 =?utf-8?B?WEJMR1NXTmNoRWJQa1gxRkpJV1ZHUTFPT2U4VHFBZUZsMmJUbUFUUVJrY0da?=
 =?utf-8?B?c1BBQkpYSW5rYndkNGNsYTNNS3ZEc0huNGwvYWFwVCtaTFVjeElkblV6TDdo?=
 =?utf-8?B?VGQ1cFJTVVRqMml4YjEzK21ZRW5JMlpmRGFmbzRmczlVOEtRL2dUOEFsK0J0?=
 =?utf-8?B?RjRMOWhYUkRHU1pQRTJvcEtibi9MaXhhT1lycjhZZjdXOTRHd2NDb2gyMzdV?=
 =?utf-8?B?cW5hUmRhaFRzUUFyN3VzOEVVRXZwdklMajMxWkQzbnpqTEFCVzNjZ1dtUFQy?=
 =?utf-8?B?WWRLbk9rMGpuNlQxalRtTkFac2daL0hUSElsZHgvNGkxMjd6MGZTbFhwbjNM?=
 =?utf-8?B?Wk94ekVONDl0YSt1WWM0cURmTG1MWi9OdGNKYWxENFJCa1ZvVVhZdzNhaWFk?=
 =?utf-8?B?WGE1UXU4cGFYTlBFc0JMWkc4VnVMNTlGWTlKaG1XREsvNFhvS1UrNmwrNVha?=
 =?utf-8?B?dkIrT1NZRTR5Z3dYMjUyTXNoNkxSK3cvSHpHZTNHazduZjdCdEhLeXFFMm1Y?=
 =?utf-8?B?dGh3Zi81SnRMYS9DeEwxWU1IODY1bHhpR2k4ZzZqM1NJMWZsSktWQzB0VFF1?=
 =?utf-8?B?SzQ2bmJSaTkzbWsrdmcvZk9OUXNSTXhCaXlKQnpWazZ2TmZrK0Q3aHNoeEN6?=
 =?utf-8?B?d1dzb3pXZERmS3JuTnp0OWZhcklla09zSjNUaTQrampqSGZ2YmNwbUN4cE5P?=
 =?utf-8?Q?jHnPWX4a47j2qGhHdZuOlEI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8F7B8D91BD19241AE06FAA719D443B2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11845
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 6cdd5711b4e9446da30f54a4bb9af96e:solidrun,office365_emails,sent,inline:8ebf7a180bdaa797d4aa91d708dbd0e4
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1711a4b9-ae32-4168-8ad0-08de67c8a28a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|14060799003|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z002OGhkM05wZDdMWVp1clpGTHJVc0MvTHQzVGN1ZnFVU2s5SXhvakl1aUJH?=
 =?utf-8?B?UFVOTldrNFk5dVRVR3duQTl4eDJQVEFrVXV5cHQ5ajVBdTZSdXVjVDIrY0N3?=
 =?utf-8?B?Uy8rb25GeDRIbmN6L2U2aXVnN0N4emhNeHVNRzdpdzVCY2VxUytOQmsvcTBn?=
 =?utf-8?B?R0pDcWZjMXpCRXRYcUxKczQ2dDBLd3N4VlgrUFFwVUVtdTVDTnVEQ2FMTkVD?=
 =?utf-8?B?bXoyczFLQmRIRjM1SXA2ZHhFNWU3K1Z3TVBnWVpyc2IzQTBLbHJ3QzU3bnJo?=
 =?utf-8?B?YU44cytmU1lSVTk2czBtZStmTC83eHZvMTBwYzF5d1BCZHRVNlVxbzRDckU1?=
 =?utf-8?B?cGpha2FZdk5Qd2hxUUZ2NTlZYnRhNzF1bnZUSFVpaDhiLzVMZ2ZWRSswdG5W?=
 =?utf-8?B?bFdGdDhORHVWNDZYNWxtVTBYb1NpWkZpK00rVEUvK2pSRkl6Q1ZkRWVpQXNh?=
 =?utf-8?B?MmROVDNlRTFKQUk4S1h6cmJqVlF6bVJwUjVwb0VxU3Yyd3VxUjdZRFlXRFRu?=
 =?utf-8?B?T1hPSjhDbFk1VXJtbm9jdTYydUZhTmpYaEptV2JxallWRENJVG0wYmZQSVE4?=
 =?utf-8?B?LytndUJxc2xnRmR0T0hBWmM3UTJWMGk3T0hnVHl6QmtSSEEyQ0pWUVd4bFg0?=
 =?utf-8?B?UjQwTGRYMnNPWGIzay84NWZZUUMySktsaVNhejB3dDY0bGwzcEJoR2RGY2lY?=
 =?utf-8?B?UmZmSW9PcHJEc0YwcUVhTEMvdjVRNThYRlZaQTQxSGloU3hxbkx6MHV5SU83?=
 =?utf-8?B?dFRjZkhCQnFOaFEvTGVKdTRhczBkMlBERnUvdkdaT2pEYVF5SnkvZ2xjbmdo?=
 =?utf-8?B?UGE0OEphODBGbEh0MjB2M3p6aEh4SDRvKzU2djNtYnFvY0NjUWk5b2VkcWc3?=
 =?utf-8?B?Zzd6WjZWZ04wcWRQTnpsUTZ4a21nZ0tZcEdqM0NVdVNwVXVyVThIblBwUm5w?=
 =?utf-8?B?ZjRmcFVUWXB5T2pJb2xWVDVlcHBnMWJkeVhydHh0bEJlS2x0aXhaeW9IM0d4?=
 =?utf-8?B?eE82MjB0dUs1bkR3WmMwK1VpaCthNzFQYlVQclpoNkVDTUVUWDhmcjhuSnBt?=
 =?utf-8?B?eGxmMFRuSG93Z3ZxVTViK3JwUk1xN1VmK1p0UHpXb1pteGJkbjFaVWJDYXlT?=
 =?utf-8?B?WEZUM2F6ck1NVTlaTG1SWVdreDBBQTdJN0RpSHd4cWhsYkdJR1pWOXNFQkNW?=
 =?utf-8?B?K3pHR0NVZjFPSGRFTHpzRTdpUDA2MGZ2RDV1ZC8wdXIrOWl0ZkFKb2xaOHJW?=
 =?utf-8?B?c1VadU94L1JVRUZzSnJ1VnFvdU9DS1RRZ0R1dWJzb1gxeklBNWdneTJYdjVF?=
 =?utf-8?B?Nm9MVEt0MlRwMHVKVEZneC92NjdMeGhxL2dMYzFjK3B0MnM0OXN1cjVNQjZ2?=
 =?utf-8?B?R1k1TmdlbkFDWFpRVEI1emRiNnlpWkhUbVdNVnZGdnh6c24yWVUyZFpNQXdi?=
 =?utf-8?B?V2w1KzlBa1ZjTnVBTVB6NXFteVFLUUNVRDhwZmRIZEUwazM4ZzJrZUpCcm9T?=
 =?utf-8?B?YmhQVHBoYi9jK2ZPeTJmTHoyaGJuV2ZNMnFRVWxmZ0JFQ2lEMlpHZ29LTzJF?=
 =?utf-8?B?em52REZSbllzUGJYck96VVkraitaK2Job0FhUmxhOEN3OVFLY1JITXRWeXcx?=
 =?utf-8?B?S2E1bFVVb1FqR1hvalNOTVh5M2hQdFdYWWxZb0J4LzJOajE0eXpHZ1dDYjVZ?=
 =?utf-8?B?RnFLVkxWZUw0UTVFcHFjTndwYzMweVI3S2pLdU13NitxdEhHSzNGZm9rZlhm?=
 =?utf-8?B?ZDZjdDVOb0VDRndYcVdSTnBhM1RmZ1RUZWxUMG1sNlZqMnlIcXJMMmF0bE9I?=
 =?utf-8?B?ZlJOdWx5N29DZmxhclZoUG41Qm5LVlZQMmtjcThmaEFLVE5iVUlPR0p2SXZp?=
 =?utf-8?B?cjlPMXRvTU5xMmFWZkdZd0NVN0NZWERhdHJ6ekxRcFZrKzZTWHdaM0NOK0JD?=
 =?utf-8?B?b1RXU080d0htZnZMZ3paSWIxMm1Fb1BnVVZmMWFXS3daRTArY3ZUL1R5QU0x?=
 =?utf-8?B?SWp5V2pZMGlGZHd5SDIyMkhURk5lY0ttZ0t5OWZlSWxwR0lVWHdOU0pBbGsy?=
 =?utf-8?B?b3FzR2tEY1BLRWFDek8zcUFTRk5Bbmd5Tis0eUlXZEhWV2pQUVVrc3Fpc2Z0?=
 =?utf-8?B?VEdvMDhrSkJRbTh5czVkcEMrb3JlRWp0TG44SThKdEErWHc3anhmOXdqSHE5?=
 =?utf-8?B?SXhsYllKb0hhZEkrdG9CYVV3MWgzUzAyeVlaN3Z2dThXNWM4cHNVSGJqUE1k?=
 =?utf-8?B?T2ZiRTQrMlNIaTNWRTdFQVQzNWVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(14060799003)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IPTElWbNvk6RpVqz0OpL0418xsQ3+fBQU6CrC3W9S0rkXGJCMTh8woj63UkzFm9FhOeijo5SC5zEi8demnT4I8DYxkvVVoZMbIrLpPyE+HnODpTpAvTZvUfOyjl/ixCdWTWo951x6+/ZGLkEK9HpHWj8OABFKSmkGyP+aXTzbFyxv3jNohtspolCXwHSzjn3kdy38AxQYxCCaDIInJFkCN/G+0FtnYDxaHFFTmPqnV0u8m1NOYw40GAygVUM7OoYRtNOENpqS0/ktHdmmaAfpGMZhZfP5hxHfvpCGS4HAiV5xaQefVHN21JM0GZ/+cSvzOkxUb5p4mXolofzgImQmewcRQ9IuOIgL8lqSs7XiD4T9GDyL/LvcUdboAxoYckb6RjCIDlk6pi3j782vmA/QXsqBC50fBa03tR1QUuE1Sm4EFEMiKMxiXOEoj/V6HUE
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:47:44.0082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff2849f-d114-43dd-516d-08de67c8a7e6
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7705
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6517-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4F6F010E5E9
X-Rspamd-Action: no action

T24gMDkvMDIvMjAyNiAxMjoxNywgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBKb3N1
YSwNCj4NCj4gT24gTW9uLCA5IEZlYiAyMDI2IGF0IDExOjEyLCBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT4gd3JvdGU6DQo+PiBPbiAwOS8wMi8yMDI2IDEwOjA2LCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6DQo+Pj4gT24gU3VuLCA4IEZlYiAyMDI2IGF0IDE2OjE2LCBKb3N1YSBN
YXllciA8am9zdWFAc29saWQtcnVuLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIDAzLzAyLzIwMjYgMTU6
MDEsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4+Pj4gQWRkIHByb21wdCBhbmQgaGVscCB0ZXh0IGZv
ciBDT05GSUdfTVVMVElQTEVYRVIgdG8gYWxsb3cgZW5hYmxpbmcgdGhpcw0KPj4+Pj4gb3B0aW9u
IHRob3J1Z2ggdGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIHdpdGhvdXQgZXhwbGljaXQgInNlbGVj
dCIgZHJpdmVyDQo+Pj4+PiBkZXBlbmRlbmNpZXMuDQo+Pj4+Pg0KPj4+Pj4gU2VsZWN0IGl0IGJ5
IGRlZmF1bHQgd2hlbiBDT01QSUxFX1RFU1QgaXMgc2V0IGZvciBiZXR0ZXIgY292ZXJhZ2UuDQo+
Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5j
b20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgICBkcml2ZXJzL211eC9LY29uZmlnIHwgOCArKysrKysr
LQ0KPj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdXgvS2NvbmZpZyBiL2RyaXZl
cnMvbXV4L0tjb25maWcNCj4+Pj4+IGluZGV4IGM2ODEzMmUzODEzOC4uZTMxYzQ2ODIwYmRmIDEw
MDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9tdXgvS2NvbmZpZw0KPj4+Pj4gKysrIGIvZHJpdmVy
cy9tdXgvS2NvbmZpZw0KPj4+Pj4gQEAgLTQsNyArNCwxMyBAQA0KPj4+Pj4gICAgICMNCj4+Pj4+
DQo+Pj4+PiAgICAgY29uZmlnIE1VTFRJUExFWEVSDQo+Pj4+PiAtICAgICB0cmlzdGF0ZQ0KPj4+
Pj4gKyAgICAgdHJpc3RhdGUgIkdlbmVyaWMgTXVsdGlwbGV4ZXIgU3VwcG9ydCIgaWYgQ09NUElM
RV9URVNUDQo+Pj4+IFRoaXMgZGlkbid0IGRvIHdoYXQgSSB0aG91Z2h0IGl0IHdvdWxkLg0KPj4+
PiBJdCB3YXMgbXkgaW50ZW50aW9uIHRvIGFsbG93IGVuYWJsaW5nIHRoaXMgdGhyb3VnaCBtZW51
Y29uZmlnIC8gLmNvbmZpZy4NCj4+Pj4NCj4+Pj4gV2l0aCB0aGUgc3ludGF4IGFib3ZlIG1lbnVj
b25maWcgc2hvd3M6DQo+Pj4+DQo+Pj4+IOKUgiBTeW1ib2w6IE1VTFRJUExFWEVSIFs9bl0NCj4+
Pj4g4pSCIFR5cGUgIDogdHJpc3RhdGUNCj4+Pj4g4pSCIERlZmluZWQgYXQgZHJpdmVycy9tdXgv
S2NvbmZpZzo2DQo+Pj4+IOKUgiAgIFByb21wdDogR2VuZXJpYyBNdWx0aXBsZXhlciBTdXBwb3J0
DQo+Pj4+IOKUgiAgIFZpc2libGUgaWY6IENPTVBJTEVfVEVTVCBbPW5dDQo+Pj4+DQo+Pj4+IFRo
aXMgbWVhbnMgaXQgY2Fubm90IGJlIHNlbGVjdGVkLg0KPj4+IExvb2tzIGxpa2UgeW91IGhhdmVu
J3QgZW5hYmxlZCBDT01QSUxFX1RFU1QgZmlyc3Q/DQo+PiBDb3JyZWN0Lg0KPj4gQnV0IENPTkZJ
R19NVUxUSVBMRVhFUiBzaG91bGQgYmUgdmlzaWJsZSBhbHdheXMsDQo+PiBub3QganVzdCB3aGVu
IENPTVBJTEVfVEVTVCBpcyBzZXQuDQo+IFdoeSBzaG91bGQgaXQgYWx3YXlzIGJlIHZpc2libGU/
IEFsbCB1c2VycyBzZWxlY3QgaXQ/DQoNClRoaXMgaXMgbm90IHJlbGV2YW50IGZvciB2NyBub3cg
YW5kIGNhbiBiZSBoYW5kbGVkIGxhdGVyLg0KDQpJdCB3YXMgZGlzY3Vzc2VkIHByZXZpb3VzbHkg
dGhhdCBkcml2ZXJzIHN1cHBvcnRpbmcgb3B0aW9uYWwgbXV4ZXMNCmRvIG5vdCBuZWVkIHRvICJz
ZWxlY3QiIE1VTFRJUExFWEVSIHRocm91Z2ggS2NvbmZpZywNCkUuZy4gdGhlIHJlbmVzYXMgc2Ro
aSBkcml2ZXIuDQoNCkhvd2V2ZXIgb3RoZXIgZHJpdmVycyBhcmUgYWxyZWFkeSBzZWxlY3Rpbmcg
aXQgZXZlbiB0aG91Z2ggdGhlIG11eA0KaXMgb3B0aW9uYWwsIHNlZSBlLmcuIHBoeS1jYW4tdHJh
bnNjZWl2ZXIuDQoNCkluIG9yZGVyIHRvIHN1cHBvcnQgbXV4ZXMgaW4gcmVuZXNhcyBzZGhpIGRy
aXZlciBlLmcuLCB1c2VycyBtdXN0IGNob29zZSB0bw0KZW5hYmxlIGJvdGggdGhlIHJlbmVzYXMg
ZHJpdmVyLCBhbmQgbXVsdGlwbGV4ZXIgc3Vic3lzdGVtIHZpYSB0aGUgDQpjb25maWd1cmF0aW9u
Lg0KDQpUaGUgbXV4IGNvcmUgc3RhbmRhbG9uZSBhbHNvIHN1cHBvcnRzIGEgbGltaXRlZCB1c2Ut
Y2FzZSB3aXRob3V0IG90aGVyIA0KZHJpdmVyDQppbnRlcmFjdGlvbnMsIHNldHRpbmcgaWRsZS1z
dGF0ZSBlLmcuOg0KDQptdXgtY29udHJvbGxlciB7DQogwqAgwqAgY29tcGF0aWJsZSA9ICJncGlv
LW11eCI7DQogwqAgwqAgI211eC1jb250cm9sLWNlbGxzID0gPDA+Ow0KIMKgIMKgIG11eC1ncGlv
cyA9IDwmdGNhNjQxNl91MjAgMCBHUElPX0FDVElWRV9ISUdIPjsNCiDCoCDCoCBpZGxlLXN0YXRl
ID0gPDA+Ow0KfTsNCg0KU28gaXQgY2FuIGJlIGdlbmVyYWxseSB1c2VmdWwgZm9yIGEgdXNlciB0
byBlbmFibGUgQ09ORklHX01VTFRJUExFWEVSLg0KDQo+DQo+Pj4+IEluc3RlYWQgSSAodGhpbmsg
SSkgc2hvdWxkIHVzZQ0KPj4+PiBkZWZhdWx0IG0gaWYgQ09NUElMRV9URVNUDQo+Pj4gTm8sIG1l
cmVseSBlbmFibGluZyBDT01QSUxFX1RFU1QgbXVzdCBub3QgZW5hYmxlIGFkZGl0aW9uYWwNCj4+
PiBmdW5jdGlvbmFsaXR5Lg0KPj4+DQo+Pj4+IFNpbmNlIG15IHBhdGNoLXNldCBicm9rZSB4ODZf
NjQgYWxsbW9kY29uZmlnIGFuZCBmYWlsZWQgbWVyZ2UgaW50bw0KPj4+PiBsaW51eC1uZXh0LA0K
Pj4+PiB0aGlzIHByZXNlbnRzIGFuIG9wcG9ydHVuaXR5IHRvIGNoYW5nZSB0aGUgYWJvdmUgYXMg
d2VsbCB3aXRoIHY5Lg0KPj4+IFVsZiBoYXMgYWxyZWFkeSBhcHBsaWVkIHRoaXMgc2VyaWVzIHRv
IG1tYy9uZXh0Lg0KPj4gV2hhdCB3b3VsZCBiZSB0aGUgcHJvY2VzcyB0byBmaXggdGhlIGJ1aWxk
IGVycm9yIGZvciB4ODZfNjQgYWxsbW9kY29uZmlnDQo+PiBub3c/DQo+IEluY3JlbWVudGFsIHBh
dGNoZXMsIGNmci4gVWxmJ3MgcmVzcG9uc2UgdG8gW1BBVENIIHY5IDAvN10uDQo+DQo+IEdye29l
dGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4NCj4g
LS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQg
aWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPg0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRp
b25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+
IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIg
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLS0gTGludXMgVG9ydmFsZHMNCg0KDQo=


