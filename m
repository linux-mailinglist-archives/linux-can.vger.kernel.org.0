Return-Path: <linux-can+bounces-6635-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB7qMgJKoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6635-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:26:26 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA41A680D
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDCA93047427
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00D3242BD;
	Thu, 26 Feb 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QeU05/jl";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QeU05/jl"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB8324B33;
	Thu, 26 Feb 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111992; cv=fail; b=XF3vTHRzjkJ9PecdTrgKpwByXMbzPPOCBz74wXqf5sV8BijxmYN7Zww/AVLaMSViH0mfVOaRlEir3LwPyJtCwJ9AuwulOmptrSUNODpywPmmRmxjwsUzXrWcJDkiCM+0tAzO46L5c/yjJC1TnBa3B3Xy76t80OQqn7tqhO6/kQc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111992; c=relaxed/simple;
	bh=67jxl2N9CFvvq916JbtMtECvuxj48ifVdm/JTLEgj8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1fd5/cdW9dE0pC1gKX0fWFDmAFXbvVuNWTC1wT6D6HEGWqQxlfKxrRzb3P0knH6ZTbGiFWPIQBM0WT58EGZwMniRnV4eIDstQgjmqGOPDAMlKV+S+IjyXZLngIgH99EnJrRTEZeZ0abGWzs3FWwAoCphOfV6FVtoKL3IkeYqxU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QeU05/jl; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QeU05/jl; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ASXshT1Mhi6TPQqLU+xPcvNHtth/b9+ss/Rn3Hne4/AHzmzfvtqis7x6S56d3URJ1gsjqJdWnDnnAjhCKyG/qfTxAueUSin+vLLEZ3oBkJO2IothQvvb9Wd0RalviQ9GY4ZO5hAUZ1x9FKK5K7PhGwemATk1FYoIa7fODpTWvm000O1LGc3DtOyQwc8K+4JXQwUnpWu5KCamxJTeywNuxoM1Kk5OUiJTI7ooce9BGscd2VijpXWLFqVj3gjkyvWLmPSMvRLviwoZtRQUyDLiTYlqOYkI976gEmt5fBuWskLEZurPHKB/vqvGaH1PKGqkB4hq1uInsfjV07dJS++yyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67jxl2N9CFvvq916JbtMtECvuxj48ifVdm/JTLEgj8I=;
 b=Fjrw+POxYpKPSQgWw8vQZACKopiW0DSyt9Vv/+ciPL+q15NX9nTk454CfFLyG0P2OCc55bD1zkTYw/TPUfTwQfdP1Xw0ZIohM33Cw9K6pN2uUnGos2A5gzDRQjaNTcJEhnujAAb5bJtU02seH9mXGxRp4BzydjTOMnbDdUkreYS51d8S2DJcs0fORm6XOf/GfcwEhLoHKW/y8SrJ2fS9ylNLTSXwmyvns8KPHQlrGVKaAM7wmJXyMGa0oVTeAs3EoB2NZ68MKbu0Gsh6LCzLxxm3TyGt1NR0VW2Pb+oWUqj10Y6HoDA6jR2vhAr3tea0hwVd3sClo36eUbbtAQfpjg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67jxl2N9CFvvq916JbtMtECvuxj48ifVdm/JTLEgj8I=;
 b=QeU05/jlv3P36z+cvpiZXWRnkTbGmTSlVq2xRyyjLSTGw3IdyG9EkXRKW6GalYnIIPAPaGREq8w5tb7P5+fZeqGS55i6Tcgy4pqABqEmZkWRS9rr9Uw2IJ8+IJQzyh4kyEbQlJlyzLsGGjH4jAa5QSsI+Eup3XJIMT5/lbSh2/E=
Received: from DB9PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:10:1da::18)
 by DB5PR04MB12226.eurprd04.prod.outlook.com (2603:10a6:10:64a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:19:47 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::68) by DB9PR05CA0013.outlook.office365.com
 (2603:10a6:10:1da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 13:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12 via
 Frontend Transport; Thu, 26 Feb 2026 13:19:47 +0000
Received: from emails-8387101-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id AA3278073B;
	Thu, 26 Feb 2026 13:19:47 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:19:40 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz4TA4mt9zEaHXY9DpsB0BKZdjmt4UpJl5IWdrO6PopFJLrVlW3tKTtb0PvaKVvt9dBjjKVhkagQXektm4zK2f4NkeVlLhj3tpfbSWXMdCfhlAGLpEQ1xEvTx9NuuIc0Rk1P5xyiUwmjEkruA+30kfg52OWJmQqNfcw7Ij2Vk4Hu1CvpP1Z1EygeqhtTeBVmgP93IZSxKyMPhS/qu7FzwqdInVlxkvC5lGEKyF8LiO8e27S11f9jmfZQKapSwjG7EihXxGZnzSLDrB5El56jQVWsnAm/e8ui6kzO/392IudB/4QdVBOWW+nxPwVm98tjp/VauRB6sRs0pr4MBO+0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67jxl2N9CFvvq916JbtMtECvuxj48ifVdm/JTLEgj8I=;
 b=tCY8RM/2OIoh3yttL+aYAXVUEeTZ1aaD9K1KDq7o1HpGxHBHGrFGhUWgvDaUuP8hPt0Z6KqJtKL83FLkzi+0SeO4FAE0G61XA9kQ6GEfenC/AewGvFmp4aSa93VjsgN3L/Av3isWlK+6M2jAJHOtAvOYofF/VtUPDF5Co361W/WLoRrnrel/UdSf5wAJN8HjBUUTEcvhd1aucyCrAQqJvM/we3B7CfIdJrmNwUovETgfrb6kxh/NG4k4gYx2v9VlBQqAvTOKtlLVmvKX9z7iEqmNdP7PCvp0MFUmFWjwoAtN9uJXo0RNwHNoM5YL2IDXTBTuKKYw9RCeMiMLdx5r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67jxl2N9CFvvq916JbtMtECvuxj48ifVdm/JTLEgj8I=;
 b=QeU05/jlv3P36z+cvpiZXWRnkTbGmTSlVq2xRyyjLSTGw3IdyG9EkXRKW6GalYnIIPAPaGREq8w5tb7P5+fZeqGS55i6Tcgy4pqABqEmZkWRS9rr9Uw2IJ8+IJQzyh4kyEbQlJlyzLsGGjH4jAa5QSsI+Eup3XJIMT5/lbSh2/E=
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:19:37 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:19:37 +0000
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
Thread-Index: AQHcpkq+ZzbPSGcvREiqhi8ReKH1O7WTUiyAgAGmWoA=
Date: Thu, 26 Feb 2026 13:19:37 +0000
Message-ID: <b28f272d-781a-44ef-8a9e-fbb04ae836b6@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
 <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
 <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUSU8Y9gj5qJ7qNE1UVhp7=HTjAxEsL6uZXPXFgwTd+7Q@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	AM9PR04MB8747:EE_|AM0PR04MB6786:EE_|DU6PEPF0000A7E3:EE_|DB5PR04MB12226:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f2165a-5bbc-4c82-43f8-08de7539b70a
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 wpB8BT+zWmkBltTTMx8+DiDhjwcFEtZcSi5quRotBxEnKAWqPPJdxOJOcepaMhVUkGLDxfhh6vjf3HS3fpo2EFmawaGaBDPXMJVUj3k6k6ybHeL0I52oXPBmaCFKw1MlddtJlMvuwdR1tsO1cbARkrV3neoEi4ddmLT3QO8/izC8SVTS3PIPy2/d0Div/Bfnt0SpqCi4qHwNixtxfTC7l+T2rpna8WFMS9t4FvsWDPKro4WWX0Ig0JmemeThKypImMhKYdJ9+LiQ7an1nSU090hdR3917zpehaHJx/4CD1WdVnPP+uhDF8P4Jk6vH/xj78kZcbiTpX7HlSVHMa16CZtHVNosAzDQN8HWt89WNiBy/DUMiht7v0hUxccUJeEVOSAorwjm5tMZIi8BfNYikKqCOT8bd9plQ4KOeEJ/p2Goi52yd5AzrGLOrpmgeFhBb9yFUU2MjjKgzUWl3mGuYvCEgzp0+LkQnHjRZDeX5oBv6tn0spxm4rwbspmaD8bVJnizE+ZrM7KWJ7pUPz+vGMPKq2D6G5FEDBFdCS4bjpXPDISdJkkMWJLDWaqsFBJj7ILwiapKtDFwe+X9qN0xVSo3+ParFlqK9qL6b+Jtr2zptVH27RFao0XKY/kJg1HD0WGEb55BIgx82sFFVTcMnyziruyIAKZqumYY/jkXDMxXeY5+MTbJrMjrFlEDvxWGk4w3objTHB4mffXREsjrsk+Nu5Sz2zNFBk5v6liBBdZ5yReYpM71iK8C1F1GOJYRGD1+djJa5yNW6o1ojXeTGyKZQfc1/Xtd28w3mRnGzQY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBE5653CC99AF7469381894BCAAC8A6C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 70ba1d625b204b4ab07ca3a120c12e65:solidrun,office365_emails,sent,inline:173005b73156ed072faa9b4105c2b772
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d7b5e26e-59aa-4884-5b95-08de7539b0ee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|7416014|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	e56KecQgccW4B3DWc2ytPI61mDiaER6HFK5lldZEJBsZFbn9LqHINu+N5sUxctkDJ6LHNd6FZlC1ca+hzXqCyuNTRKOusre3dU3Um9jyMb/S+0WIo1RdibbOvWZAfoHA9mVHGl5n4ymYZ11bVtZ129McYIueS8LM7LQWdBMej0LYgj0YaavGVghA1XmtNn8Mc6wnYBCfJ5Fk7PLC+qoz+JOsnAlIDaBzYFiPOE0NF8ehZSzzm2nFOBNrybPZpR3hB2Q2kxkCT6SVBswRuccbUW5m6bskMMRluzjHIkic+uHA45Z6pWMHiCQofNQoOBtOWX9vegLC1SfBhtZyh4SL1NhzBT1nkuvQcxBW2cMLkM9u1pc7jm8WltBLBVuqHlt+KdC+69MRm0vvoBIU2IADCBioI8JW2lr7AY87Z9b839eFa1GOLQmumFjt2lPiMdt5+KndLjqOKXRAMqxem89VDH+7G4MyqTd7NMfaGvc9BJwRvKf/zecOwFiy44jfCFSy5MbbRwCHwbrvAxmsFBCWVeeUNgMbbXO63HUQ9RwdzdcaxiH1tW+YvvFVM915rssaMb7FqQcmBswxgu3EdURUyEfX5TdV0j5t0JfPdPxEy1VuLlaamMmL6CtukMRJaV3Y1u2s98TobWYSzAnotaGbcnZaevAje6YJ7v0JjJ6gTXtjMAiM/zwZIbwLeeL33t9nHCqPR28RWBJv3Mhp9IJsijJgJIPV9TwbBZTcd1xIXAREsVlW4nbWBbFvGKPIOYsVM0WC4Fmk5cASX2dwjf9g4nszTjw/eezOJ3GBMySypcNNVelDxAPSHw6QlPb9UAH8T9piMBNocgGJzuc6FJWzGA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(7416014)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z5kf3x7F54CNll9sSgjNUJ4QCw7gzSikTliUjQnwmTz6hRO70rbWpKyQ7yZmESsl/6HGTXV/8uGskyj0J5USwnI1xtG0fb219vDU4pvkfT0UXseLN3fAtPLaSliqcZXmwMcHpNIINcUxkqdXxyOFV1ktuZ844tbosQkqpNxse2hnVq3s1C1z6UNn/qP4fwQDtctp6Peq/tmE6tvYDHiBzD9HvRoVuspQs1YZqTnxr8M/IzcepRww0GPK2xPqLJsKVKMSbp3o6nUjWqXXnakz/cmcVL+apTuAmje+Rwg/ViiaaVvq2e4BvnlcQBYQsjJBLyisfPtUYyShaWYGVAgN+tkhC/leW/0VZQqN/zr4G/HgYLSUW87fs+2VDbApPdXi9nc1YDaFtbZAKSdoomVu0fiFWe4P15dQNAKf/MHLkxrdtB6OToBOu4QFlTfkm+Ye
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:19:47.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f2165a-5bbc-4c82-43f8-08de7539b70a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12226
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
	TAGGED_FROM(0.00)[bounces-6635-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solidrn.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:mid,solid-run.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
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
X-Rspamd-Queue-Id: 4FEA41A680D
X-Rspamd-Action: no action

QW0gMjUuMDIuMjYgdW0gMTM6MDcgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46DQo+IEhpIEpv
c3VhLA0KPg0KPiBPbiBXZWQsIDI1IEZlYiAyMDI2IGF0IDEyOjM1LCBKb3N1YSBNYXllciA8am9z
dWFAc29saWQtcnVuLmNvbT4gd3JvdGU6DQo+PiBUaGUgbXVsdGlwbGV4ZXIgc3Vic3lzdGVtIHdh
cyBpbml0aWFsbHkgZGVzaWduZWQgb25seSBmb3IgdXNlIGJ5IGRyaXZlcnMNCj4+IHRoYXQgcmVx
dWlyZSBtdXhlcywgYW5kIGRpZCBpbiBwYXJ0aWN1bGFyIG5vdCBjb25zaWRlciBvcHRpb25hbCBt
dXhlcyBvcg0KPj4gdG8gY29tcGlsZSBhcyBhIG1vZHVsZS4NCj4+DQo+PiBPdmVyIHRpbWUgc2V2
ZXJhbCBkcml2ZXJzIGhhdmUgYWRkZWQgYSAic2VsZWN0IE1VTFRJUExFWEVSIiBkZXBlbmRlbmN5
LA0KPj4gc29tZSBvZiB3aGljaCByZXF1aXJlIGEgbXV4IGFuZCBzb21lIGNvbnNpZGVyIGl0IG9w
dGlvbmFsLiB2Ny4wLXJjMQ0KPj4gc2hvd3MgMTUgc3VjaCBvY2N1cnJlbmNlcyBpbiBLY29uZmln
IGZpbGVzLCBpbiBhIHZhcmlldHkgb2Ygc3Vic3lzdGVtcy4NCj4+DQo+PiBGdXJ0aGVyIHNvbWUg
ZHJpdmVycyBzdWNoIGFzIGdwaW8tbXV4IGFyZSB1c2VmdWwgb24gdGhlaXIgb3duIChlLmcuDQo+
PiB0aHJvdWdoIGRldmljZS10cmVlIGlkbGUtc3RhdGUgcHJvcGVydHkpLCBidXQgY2FuIG5vdCBj
dXJyZW50bHkgYmUNCj4+IHNlbGVjdGVkIHRocm91Z2ggbWVudWNvbmZpZyB1bmxlc3MgYW5vdGhl
ciBkcml2ZXIgc2VsZWN0aW5nIE1VTFRJUExFWEVSDQo+PiBzeW1ib2wgd2FzIGVuYWJsZWQgZmly
c3QuDQo+Pg0KPj4gVGhlIG5hdHVyYWwgc3RlcCBmb3J3YXJkIHRvIGFsbG93IGVuYWJsaW5nIG11
eCBjb3JlIGFuZCBkcml2ZXJzIHdvdWxkIGJlDQo+PiBhZGRpbmcgcHJvbXB0IGFuZCBoZWxwIHRl
eHQgdG8gdGhlIGV4aXN0aW5nIHN5bWJvbC4NCj4+DQo+PiBUaGlzIHZpb2xhdGVzIHRoZSBnZW5l
cmFsIGtidWlsZCBhZHZpY2UgdG8gYXZvaWQgc2VsZWN0aW5nIHZpc2libGUNCj4+IHN5bWJvbHMu
DQo+Pg0KPj4gQWx0ZXJuYXRpdmVseSBhZGRpdGlvbiBvZiBhIHdyYXBwZXIgc3ltYm9sIE1VWF9D
T1JFIHdhcyBjb25zaWRlcmVkLA0KPj4gd2hpY2ggaW4gdHVybiB3b3VsZCAic2VsZWN0IE1VTFRJ
UExFWEVSIi4gVGhpcyBob3dldmVyIGNyZWF0ZXMgbmV3DQo+PiBpc3N1ZXMgYW5kIGNvbmZ1c2lv
biBhcyBNVUxUSVBMRVhFUiBhbmQgTVVYX0NPUkUgbmVlZCB0byBzaGFyZSB0aGUgc2FtZQ0KPj4g
c3RhdGUsIGkuZS4gTVVYX0NPUkUgaW4gbWVudWNvbmZpZyBtdXN0IG5vdCBiZSBzZXQgdG8gbSB3
aGlsZQ0KPj4gTVVMVElQTEVYRVIgd2FzIHNlbGVjdGVkIGJ1aWx0aW4uIEZ1cnRoZXIgY29uZnVz
aW9uIG9jY3VycyB3aXRoIEtjb25maWcNCj4+ICJkZXBlbmRzIG9uIiByZWxhdGlvbnNoaXBzIHRo
YXQgY291bGQgcmVmZXJlbmNlIGVpdGhlciBNVVhfQ09SRSBvcg0KPj4gTVVMVElQTEVYRVIuDQo+
Pg0KPj4gSXQgaXMgY29tbW9uIGFjcm9zcyB0aGUgdHJlZSBmb3Igc3Vic3lzdGVtIHN5bWJvbHMg
dG8gYmUgYm90aCB2aXNpYmxlDQo+PiBhbmQgc2VsZWN0ZWQsIGUuZy4gSTJDICYgU1BJLiBJbiB0
aGUgc2FtZSBzcGlyaXQgbXVsdGlwbGV4ZXIgbmVlZHMgdG8NCj4+IGlnbm9yZSB0aGlzIHBhcnRp
Y3VsYXIga2J1aWxkIHJ1bGUuDQo+Pg0KPj4gQWRkIHByb21wdCBhbmQgaGVscCB0ZXh0IHRvIHRo
ZSBleGlzdGluZyBNVUxUSVBMRVhFUiBzeW1ib2wsIG1ha2luZyBpdA0KPj4gdmlzaWJsZSBpbiAo
bWVudSljb25maWcgd2l0aG91dCBicmVha2luZyBleGlzdGluZyAic2VsZWN0IE1VTFRJUExFWEVS
Ig0KPj4gb2NjdXJyZW5jZXMgaW4gdGhlIHRyZWUuDQo+Pg0KPj4gU2VsZWN0IGl0IGJ5IGRlZmF1
bHQgd2hlbiBDT01QSUxFX1RFU1QgaXMgc2V0IGZvciBiZXR0ZXIgY292ZXJhZ2UuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCj4NCj4+IC0tLSBhL2RyaXZlcnMvbXV4L0tjb25maWcNCj4+ICsr
KyBiL2RyaXZlcnMvbXV4L0tjb25maWcNCj4+IEBAIC00LDcgKzQsMTQgQEANCj4+ICAjDQo+Pg0K
Pj4gIGNvbmZpZyBNVUxUSVBMRVhFUg0KPj4gLSAgICAgICB0cmlzdGF0ZQ0KPj4gKyAgICAgICB0
cmlzdGF0ZSAiR2VuZXJpYyBNdWx0aXBsZXhlciBTdXBwb3J0Ig0KPj4gKyAgICAgICBkZWZhdWx0
IG0gaWYgQ09NUElMRV9URVNUDQo+IFBsZWFzZSBkcm9wIHRoaXMgbGluZS4gIE1lcmVseSBlbmFi
bGluZyBDT01QSUxFX1RFU1Qgc2hvdWxkIG5vdA0KPiBlbmFibGUgZXh0cmEgZnVuY3Rpb25hbGl0
eS4NCkFja25vd2xlZGdlZCwgdGhhbmtzIS4NCj4NCj4+ICsgICAgICAgaGVscA0KPj4gKyAgICAg
ICAgIFRoaXMgZnJhbWV3b3JrIGlzIGRlc2lnbmVkIHRvIGFic3RyYWN0IG11bHRpcGxleGVyIGhh
bmRsaW5nIGZvcg0KPj4gKyAgICAgICAgIGRldmljZXMgdmlhIHZhcmlvdXMgR1BJTy0sIE1NSU8v
UmVnbWFwIG9yIHNwZWNpZmljIG11bHRpcGxleGVyDQo+PiArICAgICAgICAgY29udHJvbGxlciBj
aGlwcy4NCj4+ICsNCj4+ICsgICAgICAgICBJZiB1bnN1cmUsIHNheSBuby4NCj4+DQo+PiAgbWVu
dSAiTXVsdGlwbGV4ZXIgZHJpdmVycyINCj4+ICAgICAgICAgZGVwZW5kcyBvbiBNVUxUSVBMRVhF
Ug0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2Vl
cnQNCj4=

