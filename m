Return-Path: <linux-can+bounces-6633-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCZ7D04YoGmzfgQAu9opvQ
	(envelope-from <linux-can+bounces-6633-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 10:54:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 872001A3CC7
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 10:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2455C3009CEF
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F8313E34;
	Thu, 26 Feb 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Sv/Fz2Fo";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Sv/Fz2Fo"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021102.outbound.protection.outlook.com [52.101.70.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBB30FC01;
	Thu, 26 Feb 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.102
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099373; cv=fail; b=GIjF2xmizPY4cQxWioWvlOZXsTV1+i+vSmUCHa7xTRPp4B8M7dORCTn5Ey/qgNwGOQnOp8+atkx1NqZUPYW4rEEdXaB7e6fKizmCjcpbJeSuemqESo/Stm7wVhAI/pRPCq6cm+RxZVadgZV3+kRzg7XlgWCPkZZpzYVA6bQyzG4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099373; c=relaxed/simple;
	bh=CFFYs8dfwwixlW7Ew0UMWxxsrsLnKp1EfCgmoxqZP2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMQlgWIB6dMYDDrZYCzdgtsNB6gPyP3rkt7qc+b9aGq+mYFZ6qL2J7O4s+p6bsjB64mwpIg1HIrnRo8SG2zDEX5G8EvJJWeQX2Z87N4cbyl8TY6QtXSqI2wjMlBUvqSDg7doECq/wsTwhmDez94FIc34PcOySC5MysuI7xxzY8Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Sv/Fz2Fo; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Sv/Fz2Fo; arc=fail smtp.client-ip=52.101.70.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MYyUnVjs9KhwbHh0BV9hmGFXy/gozpnyuEUVKcQgKG7W4lt/7AkW5Nc/GSfZZwZOz9kTsx7RPybHdlngcWLmR0FBkDgRqOeWLwBRLEQnu+8t2e0mm5clfmcNwDTOAdrRw7LQG/ZcV2BZZPm+EedbJNxoDblLImRrjuhHQc2B5Dmv8pU1RoQtVLVp3vrJDiwybD+RlwPg48JLp6IMcR913gw+mLLSIqzz2pJiTEVfcDjm3b46wii9nHUF8S7REQI6WTcjpgAQnJCIOA6xksy/rG4okMFZFoLBoArpUOp0Lb8gYI1gkCPl8uqMf+1WTXGNZ0/LAxpnQgNDAh0b+6kFsA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFFYs8dfwwixlW7Ew0UMWxxsrsLnKp1EfCgmoxqZP2o=;
 b=GHRrSk9cRJ73YovxIQWE1ZbT6P95xh/0kyIhBS2lZhjqiNTvudT4jyKFI/LxOdKzoA+ocpastbejJPC3jrpcaVinfT0PHPfKP1+7uBAJTB+tx3RrgH+caUYQPiv1P8KW4kBOVFr4f4HeA937K5oyZH+qY8yE0jwZJYrBxVH4Pnd42FgFZ8rR8fXV17J/FhTdpG2eRCIHoAHRjIbed8dCbBPBxQrzwPWNHMAmZ8jSHVImNICD+cwO1tAlzSnrWQp75fDDOYeG7yEsy3CD9oNQZC88wblyIJkJyAM3eQHxw6PzxlhGIX1tNQG1wdgobKIsvJ1tqFJCprn+kNbanpBj8Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFFYs8dfwwixlW7Ew0UMWxxsrsLnKp1EfCgmoxqZP2o=;
 b=Sv/Fz2FoqYYS7fGJfaERN1siaeu7BDNgtqPuz6yOleY88beZamRzdCF8eX1Dp/kGliYm0hpmT5GiyxZII+ASMolxTgjO7BQqcNbCDmRMWO8iqUViFAdV48Eh25+bqd7MNHwNGEP3Zdm2/m3xngufO+y0agvPM30Tx6bOxOHIN9A=
Received: from DUZPR01CA0248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::21) by VI1PR04MB6910.eurprd04.prod.outlook.com
 (2603:10a6:803:135::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 09:49:28 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::a6) by DUZPR01CA0248.outlook.office365.com
 (2603:10a6:10:4b5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 09:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 09:49:27 +0000
Received: from emails-8368798-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-107.eu-west-1.compute.internal [10.20.5.107])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id BD682806CF;
	Thu, 26 Feb 2026 09:49:27 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 09:49:20 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCMDPBD98ZsAd1VdmrpAllqgRtkA4YbyCwo/t446knbIA4ARXHbC6KNpk/G8cfj5z5dp+YSWBsXme/ppRLeqa3LVXkgqZexICg7FfNkNA22WzYw03mIMlOTaKINNbA03AIH5Bls6gkzbCwD2C30vqgLfFSrBFP6RNJ1QLdBjWXmfigadnOBBjNDgQMmCu9SHHuAB9/IdfhFr+qyrrTSI1mZITdCKbPRsO893R+pE5EGIEws6XaCJmv/vKyOeFtfRgll9x+naBLlb9154KEHVkEOsBGToT4H2z6YJfJzIlvhp66ak810k+2GMalf9SYh1QubhQOhb/B6v0o5kXqFodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFFYs8dfwwixlW7Ew0UMWxxsrsLnKp1EfCgmoxqZP2o=;
 b=V9tT7yIjEegX5Pkdghg1pA15ntuPHtvq60fquglCqvGlyrgC2r07KISMQpb7nzQi9nmUBVdVk7OxbhMDtuBwksKlrUnT+T49zD0WAyquVjDl5e9aa+Yv2emAvFV2t79MWVwm0MzYa30CJfRVKP/cdiUMkFzN3s75pIKhZCKvyAorC8uwxlhjaWBz2/m2GbF3VvHr8mvKW4DwFLwfDXVsozNqEnFV8OtF3Epb+e2vWHk3gQkl6qb0k9AqtmhIKaqwrctqySizYqUqqcpa6ooP2CXo1F5EKvbUBy46Fp1phaTiGuXOm9PED2aGWnbZfgqg7TSfN4J0jxBqAHbbDBB3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFFYs8dfwwixlW7Ew0UMWxxsrsLnKp1EfCgmoxqZP2o=;
 b=Sv/Fz2FoqYYS7fGJfaERN1siaeu7BDNgtqPuz6yOleY88beZamRzdCF8eX1Dp/kGliYm0hpmT5GiyxZII+ASMolxTgjO7BQqcNbCDmRMWO8iqUViFAdV48Eh25+bqd7MNHwNGEP3Zdm2/m3xngufO+y0agvPM30Tx6bOxOHIN9A=
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by PA1PR04MB10938.eurprd04.prod.outlook.com (2603:10a6:102:486::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 09:49:18 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 09:49:18 +0000
From: Josua Mayer <josua@solid-run.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas
 Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz
 Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
	<andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Vladimir
 Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
Thread-Topic: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
Thread-Index: AQHcpkq+ZzbPSGcvREiqhi8ReKH1O7WTVu6AgAFm1IA=
Date: Thu, 26 Feb 2026 09:49:17 +0000
Message-ID: <038f9ffa-b77c-4bbb-96db-d6adefb84594@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
 <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
 <CAPDyKFoDZr33tQXofsZzPrJbZM=3VhpeeOk1GqvRA1UK=LO5Ww@mail.gmail.com>
In-Reply-To:
 <CAPDyKFoDZr33tQXofsZzPrJbZM=3VhpeeOk1GqvRA1UK=LO5Ww@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	AM9PR04MB8747:EE_|PA1PR04MB10938:EE_|DU6PEPF0000B61C:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7b6023-65a0-4be2-4f2f-08de751c5505
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 D2uxtes4BD5W0qMi1P69RJUVwb0Yi2VaDwwzKL+WgVhxbTXwnuuHbdx2H9Ip+JjY6T22GY69yZwQEnQBKkT0hgEAFouc4u+r9kJZOeYDpfJljzHkFheAigpZwYNudI9uPDJaSioERDbqulV3TpNr5iXwAoAPws0+xa/J52WVygKlhPD9WF7GVFzhMOSJdcJFORynnU/Es0n+MJHF4hfTCFROPo/zRPOZ9bZqkIy51OJrEARRjusSe9hbsDmX/rlUVHn6pmzLk9W8gpUC4xnC260/QKwck264rwFiW6P1qY5EcKBvORrJ9N7AJeBG+kJ0Q7hgxgVQGsP7IkrzMxXtimz1U7Vg37n6fVaIEVqHtKhUJSVrAY4S8YEjo2AFDOnIgibn1Eshe//thRVnytxYVfFh+SlsVRrdtBQX9JABSzFT8etithmPfQskCIDeYVAx5xUD6val/xY30CwUzz/ptbIkNroGPPok/5UwECK+o7I7YoxRdP1RXN398RSJ5WgCrqBLKv2ozLnjpO4/HA+qkNojzpVc7L0T6+NoIz/ZMgh/QR3LbIBAkVCa9c4Scz43rCA6B+p8lwkWDBWMlb1CwC8GX/1KmBs0yXEngYiLT7YDD5lJhX+o5Q+LWYFctmXZf+Pe3Do9Ya58IhAIG+powyz2jpmgv9UQJnLIQ7+3SoOj2mcITOM3Mpnigb7CWI4TU8x8ztqOxxbFgiJRp0/XWZQXjeEDvLW9WTWab91KNEdGlT/kuc4fPXy3Us7V0JrTd9Hmqu2hwte7/obANMU3YkE4+MpkIyGKnLo9u9539Zc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4422931D7E28AC49944D52878605BF9D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10938
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 3760ba48b01b4e8a9476ad499a86cdf8:solidrun,office365_emails,sent,inline:b6e4dc99cf3285849a7ba83dfa4d709e
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6dc4a65f-57c3-4fbb-25e0-08de751c4f22
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|14060799003|36860700013|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	ln4i8+Uxr41d9LgbUjwYwBRtcApR0UsN0crk0EG4WKmulKk2zr0ZWt9FpOcdnewcl0m+KHzgA8GbRwL/tONk7FvjMKmps/ettiwgFiND2OokEvdR/hFB3ArUSQ0cCdKMD1ggF3lk/p/faHmiObDfKveWSR//7TVArYUZepLMAiCmruPnOgT0MxY5Al5gy6NWNRG4oxLxYw4077MdXWkHcOgs2cQGR/cQlY5zmDq8Eegzy0F/nf3wVQSCVTGHlYGx9izvMjvzWv+coQ/HwjW6Y3/K1DhzUv6CQ1rJ+Oxi3V1SM0+xG0tb96UOYfIwmQaZ6J6Q9bHE90MLZhQRGlHX7+RpsmM/pJxtcnxJJ+qLytPIIAy0rCfiMfINB016UQ0kWdQJ42Mv7rAN3aasaHQv/7lJgQYaZtsLs1IwXE9JITFJdjCpvl5H4wwaLtyFJRv7K56r7UX+6NV3a/p82PcWfxVtCwOcsEDkVyeLl8vhe+HsPtX5KJUEIKuLNhNNIpiT+024rPxjnbCNVLzbVedkmAy0y+0D45U1/rcNPdbEy2OK947RDeBZYgd8RGYxuDjmz2ZiD1Remo8ucO42P3OcLIY7460msdisOa+XtSziyjQGaH9xW9kLL4p7h72op/FXhqONWeRKjXBnTyYgkRA1lOBHN0PXE/u6y27tlvuZH8amCdip9hIS1RMAwYMvRNxwUJOtytGKo4dcD/T0Msq+Gs23dgeuCE5G7yksA4TrYFtbVQAFmQD0cj0K0nZQPJ4p0nzsKRve5nKlmkaHEn2HmBGHdT4BKV0TsZSnDD6YnlOYugOe+LdfL4QXvPZCH6SkogojASElIZTpmp8B8KXMSw==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(14060799003)(36860700013)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hmJtAM9vbYV6eh68dMYIRkgz1h1bzAhnk1Ze5jl+bFwOC9FnRkNzo8b6dF/UWP8oZqpIrWQj9hKuuBsr14ZkkP7MqESx8y8B2F71HOAiaboEtexXAH3fEq1zKvTYjSF/ktmWBPsxHM2GcKAkaKobtFwi0iRqtq+DdvwXTFJcmKzYtbUJkhh22v/Z7YJCDlQWJQWlgPLhrLPtLMvx4NFRRrHSL6U3zsnx267G0DDLfKRwYAiQv4ULcjGnEXUJrvyGRrR6jO9Bjc/o1Ds4wENwSSA3j1ESdm7kpGApvJDEciLy/jf66NFJmLHvk79z8qdT3N9R2N52cV/1lnXZdhvq3VGFqT3Rwpyj+DOJtkQVh+UJA3ss2njWvArevEhBh7CFyPSuKuKmuvLD6vTRTulujTrW+EKr1K9EteBJFmY7OXEsO2jhT2d8T037uAZWepbm
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:49:27.8705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7b6023-65a0-4be2-4f2f-08de751c5505
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6633-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 872001A3CC7
X-Rspamd-Action: no action

DQpBbSAyNS4wMi4yNiB1bSAxMzoyNCBzY2hyaWViIFVsZiBIYW5zc29uOg0KPiBPbiBXZWQsIDI1
IEZlYiAyMDI2IGF0IDEyOjM1LCBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4gd3Jv
dGU6DQo+PiBUaGUgbXVsdGlwbGV4ZXIgc3Vic3lzdGVtIHdhcyBpbml0aWFsbHkgZGVzaWduZWQg
b25seSBmb3IgdXNlIGJ5IGRyaXZlcnMNCj4+IHRoYXQgcmVxdWlyZSBtdXhlcywgYW5kIGRpZCBp
biBwYXJ0aWN1bGFyIG5vdCBjb25zaWRlciBvcHRpb25hbCBtdXhlcyBvcg0KPj4gdG8gY29tcGls
ZSBhcyBhIG1vZHVsZS4NCj4+DQo+PiBPdmVyIHRpbWUgc2V2ZXJhbCBkcml2ZXJzIGhhdmUgYWRk
ZWQgYSAic2VsZWN0IE1VTFRJUExFWEVSIiBkZXBlbmRlbmN5LA0KPj4gc29tZSBvZiB3aGljaCBy
ZXF1aXJlIGEgbXV4IGFuZCBzb21lIGNvbnNpZGVyIGl0IG9wdGlvbmFsLiB2Ny4wLXJjMQ0KPj4g
c2hvd3MgMTUgc3VjaCBvY2N1cnJlbmNlcyBpbiBLY29uZmlnIGZpbGVzLCBpbiBhIHZhcmlldHkg
b2Ygc3Vic3lzdGVtcy4NCj4+DQo+PiBGdXJ0aGVyIHNvbWUgZHJpdmVycyBzdWNoIGFzIGdwaW8t
bXV4IGFyZSB1c2VmdWwgb24gdGhlaXIgb3duIChlLmcuDQo+PiB0aHJvdWdoIGRldmljZS10cmVl
IGlkbGUtc3RhdGUgcHJvcGVydHkpLCBidXQgY2FuIG5vdCBjdXJyZW50bHkgYmUNCj4+IHNlbGVj
dGVkIHRocm91Z2ggbWVudWNvbmZpZyB1bmxlc3MgYW5vdGhlciBkcml2ZXIgc2VsZWN0aW5nIE1V
TFRJUExFWEVSDQo+PiBzeW1ib2wgd2FzIGVuYWJsZWQgZmlyc3QuDQo+Pg0KPj4gVGhlIG5hdHVy
YWwgc3RlcCBmb3J3YXJkIHRvIGFsbG93IGVuYWJsaW5nIG11eCBjb3JlIGFuZCBkcml2ZXJzIHdv
dWxkIGJlDQo+PiBhZGRpbmcgcHJvbXB0IGFuZCBoZWxwIHRleHQgdG8gdGhlIGV4aXN0aW5nIHN5
bWJvbC4NCj4+DQo+PiBUaGlzIHZpb2xhdGVzIHRoZSBnZW5lcmFsIGtidWlsZCBhZHZpY2UgdG8g
YXZvaWQgc2VsZWN0aW5nIHZpc2libGUNCj4+IHN5bWJvbHMuDQo+Pg0KPj4gQWx0ZXJuYXRpdmVs
eSBhZGRpdGlvbiBvZiBhIHdyYXBwZXIgc3ltYm9sIE1VWF9DT1JFIHdhcyBjb25zaWRlcmVkLA0K
Pj4gd2hpY2ggaW4gdHVybiB3b3VsZCAic2VsZWN0IE1VTFRJUExFWEVSIi4gVGhpcyBob3dldmVy
IGNyZWF0ZXMgbmV3DQo+PiBpc3N1ZXMgYW5kIGNvbmZ1c2lvbiBhcyBNVUxUSVBMRVhFUiBhbmQg
TVVYX0NPUkUgbmVlZCB0byBzaGFyZSB0aGUgc2FtZQ0KPj4gc3RhdGUsIGkuZS4gTVVYX0NPUkUg
aW4gbWVudWNvbmZpZyBtdXN0IG5vdCBiZSBzZXQgdG8gbSB3aGlsZQ0KPj4gTVVMVElQTEVYRVIg
d2FzIHNlbGVjdGVkIGJ1aWx0aW4uIEZ1cnRoZXIgY29uZnVzaW9uIG9jY3VycyB3aXRoIEtjb25m
aWcNCj4+ICJkZXBlbmRzIG9uIiByZWxhdGlvbnNoaXBzIHRoYXQgY291bGQgcmVmZXJlbmNlIGVp
dGhlciBNVVhfQ09SRSBvcg0KPj4gTVVMVElQTEVYRVIuDQo+Pg0KPj4gSXQgaXMgY29tbW9uIGFj
cm9zcyB0aGUgdHJlZSBmb3Igc3Vic3lzdGVtIHN5bWJvbHMgdG8gYmUgYm90aCB2aXNpYmxlDQo+
PiBhbmQgc2VsZWN0ZWQsIGUuZy4gSTJDICYgU1BJLiBJbiB0aGUgc2FtZSBzcGlyaXQgbXVsdGlw
bGV4ZXIgbmVlZHMgdG8NCj4+IGlnbm9yZSB0aGlzIHBhcnRpY3VsYXIga2J1aWxkIHJ1bGUuDQo+
Pg0KPj4gQWRkIHByb21wdCBhbmQgaGVscCB0ZXh0IHRvIHRoZSBleGlzdGluZyBNVUxUSVBMRVhF
UiBzeW1ib2wsIG1ha2luZyBpdA0KPj4gdmlzaWJsZSBpbiAobWVudSljb25maWcgd2l0aG91dCBi
cmVha2luZyBleGlzdGluZyAic2VsZWN0IE1VTFRJUExFWEVSIg0KPj4gb2NjdXJyZW5jZXMgaW4g
dGhlIHRyZWUuDQo+Pg0KPj4gU2VsZWN0IGl0IGJ5IGRlZmF1bHQgd2hlbiBDT01QSUxFX1RFU1Qg
aXMgc2V0IGZvciBiZXR0ZXIgY292ZXJhZ2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zdWEg
TWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL211eC9LY29u
ZmlnIHwgOSArKysrKysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXV4L0tjb25maWcgYi9k
cml2ZXJzL211eC9LY29uZmlnDQo+PiBpbmRleCBjNjgxMzJlMzgxMzguLjRmN2M2YmI4NmZjNiAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXV4L0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMvbXV4
L0tjb25maWcNCj4+IEBAIC00LDcgKzQsMTQgQEANCj4+ICAjDQo+Pg0KPj4gIGNvbmZpZyBNVUxU
SVBMRVhFUg0KPj4gLSAgICAgICB0cmlzdGF0ZQ0KPj4gKyAgICAgICB0cmlzdGF0ZSAiR2VuZXJp
YyBNdWx0aXBsZXhlciBTdXBwb3J0Ig0KPj4gKyAgICAgICBkZWZhdWx0IG0gaWYgQ09NUElMRV9U
RVNUDQo+IEFsbG93aW5nIHRoZSBjb3JlIGJlaW5nIGEgbW9kdWxlIG1ha2VzIHRoaW5ncy9jb2Rl
IGEgYml0IHVubmVjZXNzYXJpbHkNCj4gY29tcGxpY2F0ZWQsIEkgdGhpbmsuDQo+DQo+IFNpbWls
YXIgdG8gb3RoZXIgc3Vic3lzdGVtcyAobGlrZSByZWd1bGF0b3JzL2Nsay9ldGMpLCB0aGUgY29y
ZSBpcyBhDQo+IGJvb2wgYW5kIHRoZSBtZW51IGJlbG93IGl0IGZvciBpdHMgcHJvdmlkZXIgZHJp
dmVycyBkZXBlbmRzIG9uIGl0IHRvDQo+IGJlIGNvbmZpZ3VyYWJsZSwgYWxsb3dpbmcgdGhlbSB0
byBiZSB0cmlzdGF0ZS4NClRoaXMgc2VlbXMgcmVhc29uYWJsZS4NCg0KQmVmb3JlIHJldmlzaW5n
IHRoaXMgcGF0Y2ggSSdkIGFwcHJlY2lhdGUgaW5wdXQgZnJvbSBQZXRlciBSb3NpbiwNCndobyBo
YWQgc3Ryb25nIG9waW5pb25zIG9uIHY5Lg0KDQo+PiArICAgICAgIGhlbHANCj4+ICsgICAgICAg
ICBUaGlzIGZyYW1ld29yayBpcyBkZXNpZ25lZCB0byBhYnN0cmFjdCBtdWx0aXBsZXhlciBoYW5k
bGluZyBmb3INCj4+ICsgICAgICAgICBkZXZpY2VzIHZpYSB2YXJpb3VzIEdQSU8tLCBNTUlPL1Jl
Z21hcCBvciBzcGVjaWZpYyBtdWx0aXBsZXhlcg0KPj4gKyAgICAgICAgIGNvbnRyb2xsZXIgY2hp
cHMuDQo+PiArDQo+PiArICAgICAgICAgSWYgdW5zdXJlLCBzYXkgbm8uDQo+Pg0KPiBjb250aW51
aW5nIGZyb20gdGhlIGFib3ZlIGNvbW1lbnQsIHRoaXMgd291bGQgaW5zdGVhZCBiZToNCj4NCj4g
aWYgTVVMVElQTEVYRVINCj4NCj4gbWVudSAiTXVsdGlwbGV4ZXIgZHJpdmVycyINCj4NCj4NCj4+
ICBtZW51ICJNdWx0aXBsZXhlciBkcml2ZXJzIg0KPj4gICAgICAgICBkZXBlbmRzIG9uIE1VTFRJ
UExFWEVSDQo+Pg0KPj4gLS0NCj4+IDIuNDMuMA0KPj4NCj4gS2luZCByZWdhcmRzDQo+IFVmZmU=

