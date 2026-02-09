Return-Path: <linux-can+bounces-6514-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMHKBhmziWkUBAUAu9opvQ
	(envelope-from <linux-can+bounces-6514-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:12:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18E10E043
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE7A30086EF
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749143644C6;
	Mon,  9 Feb 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oS6aOuSw";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oS6aOuSw"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023132.outbound.protection.outlook.com [40.107.159.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF3308F05;
	Mon,  9 Feb 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.132
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631951; cv=fail; b=uIL4xzuxqF73GVMByoyiR8/BI0wMxyI9zAWuZeLiDbYDjeYANMCpdsDJERk11SaMXdkkzkY1gUaBuKNDhTHjuTD2umzK1S/BtFhyvMON7EqeDJwGf5etzV7gAldtvJbF122VGety6aiWAcHfyNqoQfJCFx/f+y8JzDVUcaFdzXY=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631951; c=relaxed/simple;
	bh=YIi4CYnF7QrzoOM2pWNI+woQeEJY3g9qtkc9vrs1cZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pm2HT+dnsnxIDBlgxkpKALFi8Od6TWMtCw0Gm1U1ai2cbDwQs8H27lO4XwSMcNU0k9o7PU8XAD6lhymCkObdlyU2ipqmiJc4EYA/2lt3QOs/KyBMatKgeF3JKnSRMtkxTklpkprX3dVKaRC9dta3M05ZVLxWkyjQTQpYna28qxk=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=oS6aOuSw; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=oS6aOuSw; arc=fail smtp.client-ip=40.107.159.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xiX0puFaC/2gEw5XuJWJiy5G/fqBzm6TyKVBJBC6B0pN3jDE7zjgogllEDfwfe8QCZ3HT3qa64ksKxevySK+UzoZR+FKYJMJHI4zYe/mo71jlpGg3pkvQzbyzDAa5PtmY/IozEWTqflHpTJ/sTfNsx3lm0y6+2MR3SEgagMw0Cy4bSzNbE2ZK+8qExb6Bnf7cRnuW0FBxlO8vMo/AORNOpvrYPrJGj7idcZq/MYJUSLbgsffyntFb8g8TyBjmqH4zISGEhypGeBk8WdTLSkOb53oROVQ3F4Gni8KMcVzOiPPE4+g9PwaBzc7ljBitH6G7XI4Ni+OL7D70ARxCoR4AA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIi4CYnF7QrzoOM2pWNI+woQeEJY3g9qtkc9vrs1cZo=;
 b=DCqggTxN6BWpFgHcTdi7CO9kiMOQkkBBO1QHbTeHfMDWatEKayiUefXy+HP0BfpL5heUU27TXQqD8aS9j4IBsBXHrvPS+TdyDA6XlqomWpTUwJcyUEe9/+95ZO28bONAGfcU7mFI8v2PTRoUK2SD2FaHo+nB5Bwj3eRsCiTTghJBp8WHbUgei8QQ7X5dxoCtDg8mNECjrOgwFCyn7H2XNCwrocn0GXyGWBe9BKoNzLAGDNJwdQbmr3NkQoUdJY++TDKogV0vL7q3CExOocf0RRkTcLV0NmGBT1rnKmPDeaq+AKvWgx1L6p58KkfWr7A/Fu97RD0TN6jxAzEfHAH0nA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIi4CYnF7QrzoOM2pWNI+woQeEJY3g9qtkc9vrs1cZo=;
 b=oS6aOuSw11UIyaRWuQONE4BGmaD7fmFLDJrVioAZITAf/1pxOYN8ifJCnZA8qyU0JIxq648P38i7wT2HgtflHzcXSYhjEiA1+8WxpEo18NbTurowaqaR56umMLRzfsLHms8zrvB3a3vDyXoXkeAskOia3MHCELAVT3acPWmLZSk=
Received: from DU2PR04CA0179.eurprd04.prod.outlook.com (2603:10a6:10:2b0::34)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 10:12:26 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::af) by DU2PR04CA0179.outlook.office365.com
 (2603:10a6:10:2b0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 10:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 10:12:25 +0000
Received: from emails-3319980-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-189.eu-west-1.compute.internal [10.20.6.189])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 9C4B4802E0;
	Mon,  9 Feb 2026 10:12:25 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770631945; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=YIi4CYnF7QrzoOM2pWNI+woQeEJY3g9qtkc9vrs1cZo=;
 b=Fp9UKLaQvcqvea45pcnzFZcPldgvZey5KU5G7gx+xIGXegbSLfpmvE894km5yPh9kATfi
 eP5BVxfgowT13RsOehUh59Igqs1WJ9AqU9j83GbcoPa1UBrgg4ng4gLiIs+v2MsSNFvoae1
 ygUHScetnHoAou04T7LphYAleZw+lj0=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770631945;
 b=BEWyhn7XAmgsh+oKuWn8qt9uPLRwcxgI2PPhtozSm6lO3UAXptY65pDQh0A2lDW3WrznL
 FALgGN1mVTmUDqEj29efJEkCWAccskKdM+ewNJt/xcgACTiUBognHp7p7YL2Cyj0Q1rIebu
 Xcm+TkgOVQN+ubYbl8eEyCGw8PQYyjk=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmMCn8aImZgffbyzarVladj4Y6fo/4OFExGKxMABYfuR+1DslgxDh5DjSf8Og3wn56PrjVVASr2fXgTKb+AjANOkyUJ694P6p05g3FwwPqH/5PwOsVdxm+SNdW6/2PeWWyie4Y9i2zHtrBrTQ4+DT1QcZSaFrsdX7SR29Hykl6K80B1VZUFTzjLbX/huJrX4xSroKHNNgaKIPXmE4RQ8K6ZOZPjCqkzuFhQzApL+2Eq2Q+tD7XwtsRyWs3bOMrb0mWXrKW2FKeyNGKoXSq9HYWS8TRmh0ARfV5x181TdPw/x31NhZ9g811RSH4uI3dMrla3XZMTeEpj0KXoPEXSlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIi4CYnF7QrzoOM2pWNI+woQeEJY3g9qtkc9vrs1cZo=;
 b=IA/yNhmaxQXiU8KPkV/X7ivEZAJM+p1/mBx+3p1W1Oiy9+0x116qSxUqgJ3FGmshxKutw1mdMp92G+C4j1ZWVfzHgJkQLerDyacXUJJkxM6lX7ZoFRAfyF7a9DtEpyEL4NCYQOnpfBgdnCbcBl5DDXMUM0XUGc1Z2NZ8iL+IawjQldJlOL3hSNmTKLn3gDNQzi5atfQSWEkI1M6xdFt6aFiYSJyLaZ+Ra3+bpZEdm+uj2vUGgIWjNkjhnTn83yDhiMmb7SNI8MkNcXVvJ/V5ykft8WehbLyKcEddFEvVMiM/4j7vVvV5GEnaHpyG0MMnY//bohjlZAsfDi/9LoFHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIi4CYnF7QrzoOM2pWNI+woQeEJY3g9qtkc9vrs1cZo=;
 b=oS6aOuSw11UIyaRWuQONE4BGmaD7fmFLDJrVioAZITAf/1pxOYN8ifJCnZA8qyU0JIxq648P38i7wT2HgtflHzcXSYhjEiA1+8WxpEo18NbTurowaqaR56umMLRzfsLHms8zrvB3a3vDyXoXkeAskOia3MHCELAVT3acPWmLZSk=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 10:12:17 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:12:17 +0000
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
Thread-Index: AQHclQ1B8HejTmuXEUSnLC013GRTOLV48bmAgAEaEACAACM/gA==
Date: Mon, 9 Feb 2026 10:12:17 +0000
Message-ID: <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com>
 <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AS8PR04MB8689:EE_|DB1PEPF000509FD:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: e00aa027-81ff-45f3-00fc-08de67c3b940
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cmtIUVpuT3p2SS9TSWR2RjdWeUJocWU1RlRGMGFENkxZSlZSbVVNcm1FUzNp?=
 =?utf-8?B?NTZiMnlzMk9aalhFL2VqQStOVHNEQ3hJNWpMTkROM3JZVS9WZWt2YXdrZFNW?=
 =?utf-8?B?Yk9VamhSY0M5dEZaRXRQZ2pnREM3ZkRFcHhaZm10UnUyN3NjYWtKN20xc2lD?=
 =?utf-8?B?YjV3RlR3blRwd3k3UmtvUks5bG1LR1ZPL05wU1FFdzdsUHVvanJYeFhoOWky?=
 =?utf-8?B?dDB6eXQ5RE9kQWJOTkl6dE1mcTVobHE1MnFLbDdxY25pZFk4ODVHanY5eHJl?=
 =?utf-8?B?K3kzb0tFejVrQnVtZVg0ZXBnaEgrWG9wTFNSQm5KdnlwV1FkY1kvSUlUcUUz?=
 =?utf-8?B?bTZacy9RcDdXaW81eUlLV1B6TVFKQldTZmZwRnpPOXpkSVBoRlhhd2NORWhT?=
 =?utf-8?B?ZkVMYzFDc0Y5eFpCWElCZSsrK1Jrb0JsdTZ0SDVvcks3elp1YXRmeUY5Z21i?=
 =?utf-8?B?bG9MbExLWlo1N3d2Um1SMlFqcWcwZ1FWaFpHUi9SaTRrWkVCSkgyVUx6eFVY?=
 =?utf-8?B?WnVucVRHQVhyRkNYakp2VGVIcWJ0SHdBNG1ydzVKRlpzM2xvQzB0dUpSMU1T?=
 =?utf-8?B?QjkzcnZvaHBWVEFIbXFRTGVFUHNOZmQ1SUJqR01MbDZ5b1BFUGZDVTJ1NkVm?=
 =?utf-8?B?R2QwVm5yUUdGUy9IY3pRTHdFR29xL0srdys0c293TUc4RTFsbGRaRVIrNUpQ?=
 =?utf-8?B?UXhKdlBBRXdadGkzRlRaOW9PUW9ldUJZTmU0bWg3MXlyMEZNR1RCTWgxYzdW?=
 =?utf-8?B?Z1daRmZsYUFBTXZWcS83RCtoeE8yS0VnWk5uWnY3OW5qV0tndWs1eFhORlh0?=
 =?utf-8?B?aVB2YU03a0k5TlBYWGp6bXZ2bjN2SlQyTFdkM09LSmFLRVR0ZTVxOVR1SFhB?=
 =?utf-8?B?YU9uSUxJbEltdlJuQndhbDRVRkFqOXhyd2FVckVwWjNFZS9RL2FncDMwa1BJ?=
 =?utf-8?B?Slo4UDk4U3pwT0JQTGdvbzFuaTRJeXdhRDJ4U1JVYzVyU1lhY2l4MklqM2Vj?=
 =?utf-8?B?bEhJRnpqN3hXdjNid0NuRWlIb1R0RWI3SEpwQ051OGVqc3pOVUZnSHZ0MURi?=
 =?utf-8?B?ZUNHNS84VzZ5TVYrdjh1Z3E1Z2ZsWjg5bGJPdVR0Y1prSWM2aGg0T3VFSXRn?=
 =?utf-8?B?Y080bGY2NFpQenFLa3laQWlCdi93MHdsVTRiV1NWalhsd0sxZXhBR1JqRjhR?=
 =?utf-8?B?R0hYVGhWWVlvQXJ2QXdZNXk5ZnZKaTl2NUtyMFZEMU5aZDU5NFd6QTlIVWZH?=
 =?utf-8?B?WGNXMkdLRDRnK0dkZFJ0NFQ5aG43bGtZQ3p2UUVEd29DMDZDZGRUVEhaTFVp?=
 =?utf-8?B?RTZJekxyckU1QzlaeE9QRUpMUkFYaUl2VGtRdUhoSGRHamMydENLaG15WUxv?=
 =?utf-8?B?TndKSUl4RmV5eGZleEtXME1UY2tBS1FGOTFnVytmT1ZpOS9OeHY5c1ViLzBC?=
 =?utf-8?B?RHlFRExzNGpZaEYrUlBON3RTN20wVmZWTzJ0WG5DOERxdGYzUmF0Vkd4TUFs?=
 =?utf-8?B?UWlTU21raW9kQVpxQXErY1FVYktoNWlhenh5UCtvUWxEY0lQWXpFSERZUWQ1?=
 =?utf-8?B?Y0xvYnRxczAyM2ZGNGNUWWNLWS9NTU1tcDYxWjZjTkl2VnJNVTFoU2JKMWEz?=
 =?utf-8?B?S09MVVlzUzVrcVUxY3FRa3NxZE9oK1ZlT1Y3WWRIVDkxT2Z1ejF6ZDNMaVg2?=
 =?utf-8?B?eUh5T3JhYjNnS0Z6TnBlQWtwVExMNEQ3NGNOMWNhWGkzUGJzZVRjMkhERzA4?=
 =?utf-8?B?WkVXVi9rbGpUNGR4SDdlS1RyRWdkYS9ISnRxenZjUXVDSlg4TjFISk1LZzEv?=
 =?utf-8?B?UTBEc2dZeGhRUG1MWTBtUmpQTTRrT3JhZm1Sc00xRlVMUUZKR1dMT0VvZlJX?=
 =?utf-8?B?WjNFZ21NN0RQRXhQeWFpaVdtZE1GZ2psclVWSkpMQU1KVkMwQzRIK3p2MUlL?=
 =?utf-8?B?QXB4YUptbi9DejI5RFVpMkY2bkpSOUFCQWFEMHBEd3lva2NweG1Zd1hJbXVH?=
 =?utf-8?B?WDlXN1ZSbWZvK1hpbHpSN2ZNKzN5S0tveUFmeURJcVF1aHI3ejlXYWV2UVYr?=
 =?utf-8?B?bG9OY2hLM0ZqZ0VrbnlQbVc2bnp5SlhudG5EKzhFNUJsY3R5Z1oxNEVYNHNM?=
 =?utf-8?B?ekZ3c0N3YWx3VVFjdFR1T0dyejJsTlcxazAvV2VyanJNUFJkU0pyRUI3SUtT?=
 =?utf-8?Q?7zxAFUcLyya7JeZyQzuRYbk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <23629D40D473814B981310C68FBE474D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: f851a92321a74d4cb570fae50d18ae5d:solidrun,office365_emails,sent,inline:8ebf7a180bdaa797d4aa91d708dbd0e4
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3a05d46c-b34f-41bc-3d94-08de67c3b45d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|14060799003|35042699022|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDI4dFJYYTdBblI0L2dqODc1WG9ZL0lXbG1qSEs1eWNGNytOM09rbTdvRitG?=
 =?utf-8?B?Q3E2QjFzcnkxUmFLY1hLL2RBWWR2MVQ5dTl0TWNMRnp3VllFazRwUWlmL0th?=
 =?utf-8?B?bktMVmZDS0lYL2N0ZU14MXAwNUQ2MTgwSkVnSXBBV1hzakNpS0VROFA5WENX?=
 =?utf-8?B?aXNIbGthMUtidktPWGFzMkdPL2pHZ1dRMUxxTktRZlo3WkZVS3h1Z3NxWUoz?=
 =?utf-8?B?S0ZjcUwrRldwczlDa2ZmZUtOWW0rWEtvNHFOT21udGdFdENlNmEwd2RZMkdz?=
 =?utf-8?B?RHpnRE12ZlRQOE9QcDFIR21BUmxpL1MzL3NtVjF4Z20xQTdvc3Nwa3YvZTlM?=
 =?utf-8?B?UXU5SUoyMWlQQ3pWajh5eHlPOVoraWp3UG1ZVW9hRVpvRVlSZ0ZSV2k1RENn?=
 =?utf-8?B?ZEU4enRtMm5ZYjUyTzMwR2Q0YWF1WndSQWVPSHA3bTBhbzNpWklxUjc3L1Ix?=
 =?utf-8?B?MXZvK0w0VE1CQ3drdmRycW05d1JBbDA5OVdPeHhXeUJPalpRTXNJTlYrYk1q?=
 =?utf-8?B?YVNtYXhVMHppcS85M0VuZFZDVWxzakk2UDJSUWh1TDZpZ0lMTkR3bDZkNWpj?=
 =?utf-8?B?SmR5bVdaWkdDelJjRmJQOWtOZDFKUkRBNm1nQWk1K3gwTG5HeHBoSW1oNUJ6?=
 =?utf-8?B?UHhRWlVDeTlaUDQrTGVUK1NGclVacUJmaUhkbUVZK2Z3YVp4WVR6dzg1YlND?=
 =?utf-8?B?WEFvVG1aUHRNbVhJN3FMZStrdU93RXJhRm43K2RJNkFWbDBZd2NWKzFEb2s0?=
 =?utf-8?B?WWxJalRWUmVOUW1iUDZDMFJQQmRxanlzNmpmeUVjbnkwUFM1bHU4UksrSi9L?=
 =?utf-8?B?ZnZzUlRaaXlTNkFmTEZodlpsK0IxOGpnNmNiMmFqWVBVZDRsaTJ6OWpHTktv?=
 =?utf-8?B?bEZDZ1dRNGxYbE5qNiswbFFPUFZxdmZnMm1QWmM2Z0JDTmZ4WFVtK1h1ZjlB?=
 =?utf-8?B?R3QrT3hsYTdxSzFJZ1o5WTU0dVdhNzFaaUQyb1VnV2F5RWpJYU81eUxCb0Uv?=
 =?utf-8?B?aG5aaER1QThIQ05GNkV6ZGxjUnZYTXJRWFhwbWltR054T2FmdHUyWnlGL1Vh?=
 =?utf-8?B?cHMzMzE3aXVabkNhYnJwUm1CelRoc2RhaUQreXYvWnRTZkwrZ2l0RzBGTUtC?=
 =?utf-8?B?ZklFU3BjRy9tVGFqZmtreG1Ta0hrbXl1U1QxMm4xQ0tyUk1lR25nTlFJZTRJ?=
 =?utf-8?B?cmlhUEhFOFFjNDZKZ0lCS1kwNzlybUJlZndQNlZ0ZVAvRjN2dTFERnVOd09I?=
 =?utf-8?B?Q0J3T2JjQzljVmtkRjlDelgwaDl3TTBGWGxwbnZZYnFDaWc3ZGhKMnFicHlM?=
 =?utf-8?B?QmFyRGR5Rm5CaWozWnBuekpnK1E1YU5JZDVUb0l1M2JCeVk0RzJYbEZBSDBu?=
 =?utf-8?B?aUdSUGlsSmtzWEtYd3ZDcERVckx4ZmhrWisxTUlrM3E0a2pqOFVMd0RVRmRp?=
 =?utf-8?B?WTNKR2s2aDFabC8vUXdQRC80QmhLcEtzZlQ1aklYK0lvRXBvZk0rVGY4K3Az?=
 =?utf-8?B?eW1wcUtTdlV6UzdBOUtoVXFYOXA4NlFmRGtHcDA2ZEFMcVN1VkJCL2JYYVhh?=
 =?utf-8?B?bVlnMllUMUk0NFNXMGpNL2xyRVJBRmIyYmxxMUNjTnJaWlkxMjhocjhPa0FT?=
 =?utf-8?B?eVlmUzV5cXdZbGtBY1l0TUFOeC8rNTN3M3hVMS85L0FrK3FkMkFqOHBuWWJu?=
 =?utf-8?B?blpVRHVQcFlrNVZKTjJOZWM0S3RWcy9icW1HV2x5c3lDamxUL2FtaUZhRHMx?=
 =?utf-8?B?T3ZIaEVWSGFiemlJbW5PdDg2RG02NklhdUhjWk9XNElkZU9vU29Od0M2Wmh0?=
 =?utf-8?B?c0dDNHNqWUdoWlJqWm5PbTdycXpUWUUweGtuN3lTSmVjS25kWUNvWUpiQU5B?=
 =?utf-8?B?N3FscGtvaXZ4S2FuNERiaXRCdjlqNkZqblIwdEJ0VzVFMDdIaXhPVkdIdDlz?=
 =?utf-8?B?bFBRSTVvTjF5VytpOVRjNFBkNmRhTzFkNEc5TGF0TTlHWXErc1RCRkJyd1J1?=
 =?utf-8?B?RHlnN0pVUVp2TEpXczdiZmo2YmsreEhhWGxIcGFGQWhLQy9teE05YjYvVmRo?=
 =?utf-8?B?Zm9SZ0djcmlqeVpINlJlSDI0RFdpd1VvL05oVUlMWnVqendOYUJsU3BQSDU1?=
 =?utf-8?B?OG1aSjJqVnJJbGNkZmgyaWZkNENOREpRK08zVXRzTlJFYkxWUkc5VUFUQUM5?=
 =?utf-8?B?REJvL0EyanF3dG1UMnNMOHNpdFlDQnd2N211cElmdFIrVzJ5eC8rb2k1bHQ4?=
 =?utf-8?B?U1ZYWE9XM20wT1daQzJrVDBqcURBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(14060799003)(35042699022)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hXr/fYweE0IoghdTU8sJIVk0cukjKKat0+jlLN/eHKr40/U0wMytt+OxIBRJKU3K3zNjtThj6sS2o6lQWjw84jDnKTvWCALiDFjcYCawZBypfv5o+Bx3znRcclERS42fbrEAYJV6H/D34WimmVvaexYQB+ISowYJhLxvxvZQuzeT05jEwzjzowycFJM7G+JEbE6aePTYjtmTVQWJWgaIuYJG8SecSNoRZxCKN6b8jfrrscVJO2D5uTTHql0lmupwgWKGmwj1Wb1CPPSFbm2+PWrU1xxmWL1t6G2f0d5Aui4fqsLuhfuXq4rmFfUgp6AuA9s/Nct+R2E/elTSpSgzsYZAHEgIchyvFvga7BIqr2LNKa5DVeTIDJx361YOr+HyeQrtCq4W88zjFxeeS2jA3E595Bmtr5OtPSrfyXltGwRSg4nS2SHuiTcMMCbBw9/B
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:12:25.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00aa027-81ff-45f3-00fc-08de67c3b940
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6514-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8F18E10E043
X-Rspamd-Action: no action

T24gMDkvMDIvMjAyNiAxMDowNiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBIaSBKb3N1
YSwNCj4NCj4gT24gU3VuLCA4IEZlYiAyMDI2IGF0IDE2OjE2LCBKb3N1YSBNYXllciA8am9zdWFA
c29saWQtcnVuLmNvbT4gd3JvdGU6DQo+PiBPbiAwMy8wMi8yMDI2IDE1OjAxLCBKb3N1YSBNYXll
ciB3cm90ZToNCj4+PiBBZGQgcHJvbXB0IGFuZCBoZWxwIHRleHQgZm9yIENPTkZJR19NVUxUSVBM
RVhFUiB0byBhbGxvdyBlbmFibGluZyB0aGlzDQo+Pj4gb3B0aW9uIHRob3J1Z2ggdGhlIGtlcm5l
bCBjb25maWd1cmF0aW9uIHdpdGhvdXQgZXhwbGljaXQgInNlbGVjdCIgZHJpdmVyDQo+Pj4gZGVw
ZW5kZW5jaWVzLg0KPj4+DQo+Pj4gU2VsZWN0IGl0IGJ5IGRlZmF1bHQgd2hlbiBDT01QSUxFX1RF
U1QgaXMgc2V0IGZvciBiZXR0ZXIgY292ZXJhZ2UuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBK
b3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBkcml2ZXJz
L211eC9LY29uZmlnIHwgOCArKysrKysrLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL211
eC9LY29uZmlnIGIvZHJpdmVycy9tdXgvS2NvbmZpZw0KPj4+IGluZGV4IGM2ODEzMmUzODEzOC4u
ZTMxYzQ2ODIwYmRmIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbXV4L0tjb25maWcNCj4+PiAr
KysgYi9kcml2ZXJzL211eC9LY29uZmlnDQo+Pj4gQEAgLTQsNyArNCwxMyBAQA0KPj4+ICAgICMN
Cj4+Pg0KPj4+ICAgIGNvbmZpZyBNVUxUSVBMRVhFUg0KPj4+IC0gICAgIHRyaXN0YXRlDQo+Pj4g
KyAgICAgdHJpc3RhdGUgIkdlbmVyaWMgTXVsdGlwbGV4ZXIgU3VwcG9ydCIgaWYgQ09NUElMRV9U
RVNUDQo+PiBUaGlzIGRpZG4ndCBkbyB3aGF0IEkgdGhvdWdodCBpdCB3b3VsZC4NCj4+IEl0IHdh
cyBteSBpbnRlbnRpb24gdG8gYWxsb3cgZW5hYmxpbmcgdGhpcyB0aHJvdWdoIG1lbnVjb25maWcg
LyAuY29uZmlnLg0KPj4NCj4+IFdpdGggdGhlIHN5bnRheCBhYm92ZSBtZW51Y29uZmlnIHNob3dz
Og0KPj4NCj4+IOKUgiBTeW1ib2w6IE1VTFRJUExFWEVSIFs9bl0NCj4+IOKUgiBUeXBlICA6IHRy
aXN0YXRlDQo+PiDilIIgRGVmaW5lZCBhdCBkcml2ZXJzL211eC9LY29uZmlnOjYNCj4+IOKUgiAg
IFByb21wdDogR2VuZXJpYyBNdWx0aXBsZXhlciBTdXBwb3J0DQo+PiDilIIgICBWaXNpYmxlIGlm
OiBDT01QSUxFX1RFU1QgWz1uXQ0KPj4NCj4+IFRoaXMgbWVhbnMgaXQgY2Fubm90IGJlIHNlbGVj
dGVkLg0KPiBMb29rcyBsaWtlIHlvdSBoYXZlbid0IGVuYWJsZWQgQ09NUElMRV9URVNUIGZpcnN0
Pw0KQ29ycmVjdC4NCkJ1dCBDT05GSUdfTVVMVElQTEVYRVIgc2hvdWxkIGJlIHZpc2libGUgYWx3
YXlzLA0Kbm90IGp1c3Qgd2hlbiBDT01QSUxFX1RFU1QgaXMgc2V0Lg0KPg0KPj4gSW5zdGVhZCBJ
ICh0aGluayBJKSBzaG91bGQgdXNlDQo+PiBkZWZhdWx0IG0gaWYgQ09NUElMRV9URVNUDQo+IE5v
LCBtZXJlbHkgZW5hYmxpbmcgQ09NUElMRV9URVNUIG11c3Qgbm90IGVuYWJsZSBhZGRpdGlvbmFs
DQo+IGZ1bmN0aW9uYWxpdHkuDQo+DQo+PiBTaW5jZSBteSBwYXRjaC1zZXQgYnJva2UgeDg2XzY0
IGFsbG1vZGNvbmZpZyBhbmQgZmFpbGVkIG1lcmdlIGludG8NCj4+IGxpbnV4LW5leHQsDQo+PiB0
aGlzIHByZXNlbnRzIGFuIG9wcG9ydHVuaXR5IHRvIGNoYW5nZSB0aGUgYWJvdmUgYXMgd2VsbCB3
aXRoIHY5Lg0KPiBVbGYgaGFzIGFscmVhZHkgYXBwbGllZCB0aGlzIHNlcmllcyB0byBtbWMvbmV4
dC4NCldoYXQgd291bGQgYmUgdGhlIHByb2Nlc3MgdG8gZml4IHRoZSBidWlsZCBlcnJvciBmb3Ig
eDg2XzY0IGFsbG1vZGNvbmZpZyANCm5vdz8NCj4NCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPg0KDQo=


