Return-Path: <linux-can+bounces-6522-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IwqJx/XiWnZCAAAu9opvQ
	(envelope-from <linux-can+bounces-6522-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 13:46:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5F10EEAF
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35AC13022977
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DF2372B42;
	Mon,  9 Feb 2026 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RbVhZBsq";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="RbVhZBsq"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020088.outbound.protection.outlook.com [52.101.84.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D430C626;
	Mon,  9 Feb 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.88
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770638853; cv=fail; b=VowDDcqzpL+/BVMbzdtYs9sOIkHTVkLw7dHelZM/gEnvf1SXIV0ycoQGsQWT0LsXNv+dNt8bVGvmkYcHJOW/DKp2fxqhSISzMdI6s7LjV28H16pNnuwLOsNmGqsb38F0kwloVieEyliL1zWpSot8v8eBHfDGgdR/8C/BHi2W3II=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770638853; c=relaxed/simple;
	bh=RfhuvU3htr6Ma7PwcglST4HAIM4zC1M8z2Qfmqqo32Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0elh6pW3KaSCQ+uOzrOiAlAXgyCcHIlQITWE3LCY0Nm1ul3Yc+xUAYVaJYH4JAAECm5pZS8zA6H5k8gJmF6wZyY+yWgaY5ShIYlYnUh+hDxNwi7jIRxl290/IXBt2bXo13QB4sn/15KLr4AglnFn86rrQiwbA+XWrOqTeFB3zU=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=RbVhZBsq; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=RbVhZBsq; arc=fail smtp.client-ip=52.101.84.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PdP6yzwUeAlxasvLPQe/J0Q+N/S4oD6VOZ5l1M7ponKhTtD6WON0CCFNZ1G4iZjyW2So+fGLyImqs2blgLF1AdWJg3D3klrct76SvAMej4cP1bX1eZ08MqVVV3FMmabtOVkKaDr4BvEj61RACzogWJISXeisE1mYxrBH8RGz5ad5RGIwfgmFgnx9HBhHLHg+iQFbpzAuqldhtMuPaxcnCSprhdQvAWGTd7LYs1mWEAZh73mwCRnIW2dt88OmSW5hZkyBW3v5tq84b5zYEpl8IuJXJqa5z0t7GkI7lIGv0bgrYOPVj2l4+YtS3uUQ9T0BAxN6FVz6rlPIgIcG1RnDTw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfhuvU3htr6Ma7PwcglST4HAIM4zC1M8z2Qfmqqo32Q=;
 b=KKtLwsS3WR7PePJHhERZpYun3WgfvdVcb4X7ECCWehIf9hGdI8B7kk4SQC61NwqI3bX3oXhXwi0mB+aD0nuA0QxYYZ0sNfDG55RhuzbVkH+0sLcTTjhIdcb9E9h5kA4lFE+kvjAxCIS3YFDWoGqAdbubYPr/U70xorr1o016w7N8rcDCxXO01NPLEF0lVDlVCfs7OKwdlp2N4AljoiSSCwWP0kpCN/5pzStW+FUeh2VzF+J8fsAXBADk03V2P4+S9zYAUKvktht4lq3Oth14kWQXvgdMKNKGsI1ud0W6DYb/TidEEH0kUh3T9NztcAxrVxCNXR//XYSzBAdtLtxhtw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfhuvU3htr6Ma7PwcglST4HAIM4zC1M8z2Qfmqqo32Q=;
 b=RbVhZBsqIqgEmR9rOq4QsSp+gtrPSJa5hHhXGjheZIupYh4QlEmFy6vtSCamRKtRE8JifcqhP2cj186qs/8VejXItC4MWTzCoQRMt32Z/2sxxxcjrRiqDCZOwb+gf5AyKT/bI9wI1aKLTcuwrL/fFPnKYnqxQVj0AYvoqZ/MJsA=
Received: from DB8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::30)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:07:26 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::43) by DB8P191CA0020.outlook.office365.com
 (2603:10a6:10:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 12:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 12:07:25 +0000
Received: from emails-6944208-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-189.eu-west-1.compute.internal [10.20.6.189])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 7D9AF7FF98;
	Mon,  9 Feb 2026 12:07:25 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770638845; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=RfhuvU3htr6Ma7PwcglST4HAIM4zC1M8z2Qfmqqo32Q=;
 b=OuRwrR2wx5ewuQpjUOm5b3g4925XuzjGo0W/m1TTqFNXCeuT8JpFtwyw/gCOcgQ1zRtx+
 QULHyakuKsSYyvJm2FlGDK2f+7qkYu4q+Vty/qRqkwzbNblc9s64nWoBRi1ozJUKCFJ+/Ov
 iYeJoEeG6c+62YcsrJvyf7whxov3YSk=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770638845;
 b=bi/hbYuHy0vCkgSeWFDRUOSyK3Qlqfx9vmg92GaLGgeXG5x5+l6NFtfPGerJBgGPMt5o5
 o266+9mraEdSIo2f5GuuntI0eAHSNB4HOQwU/A9r8Wtd4GOHhB2ScPPOVO+sf25L38KXNxV
 uHb5n8r5YvU6kT28CQof2JYOdC0nJ20=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eozOHLMlxkuETFiUZKgltYK5G4olOlw2Bb0wel/LG/Z3x/xl4Sx6q0Z5A9yoT78+Gglc0HDNIakV2KMxjaq8MK7VZ7AyNzHHCKcZgPeigKiRl3/wSJ1D5pXWL9x+vwqUJGFMuegmg7u+gVFXf2nCmqKFad6TfcGUQA12P47j26Am1l5cHeV5lDTWqDZwG6tSvjbPFQq11NJGmIRq4ATQ1+eCQkVNbvYFN4MviM0wS9S0zTTocNzcwrdMzYHeBoYtD6/ZlyuL3WIdcz5PA9PWK0s9DXl/J2jIAk0TU/RmfkqM8vtCgRvEotoFL3XjFEkpuoRaeH8I6xcVlMiHXz0N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfhuvU3htr6Ma7PwcglST4HAIM4zC1M8z2Qfmqqo32Q=;
 b=MroO6wv4SgEbjHEYQHLEai3UX2uOM+BfHsfV17bPW2k99XVK7sUt4Z3xSivExXWaC43wMHNH7YGiolThqiF1QEnuSto6PbTiqYj51pTMx83okCv9xQTaZ1E+Tai8/2UmGYQzeSqgSuzQ56+Z75FSuAFj+6rfEoSFl9QFjmNnxdz06JSCs+yCD9AtMHZYerq0BeGib7pSQX3Pl/k7/YOUFr4fcx5lJgYRNd80mb+Xwbq/3Z7bBDsmEyqGRXpUmkapZfUV/LoFsaqlTddn6GVNBiodDmGJMZ3eQ7E3tdkryONVQajO/W/rssIt3Ok/De95MCw3KTgwbMelzq82K3EBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfhuvU3htr6Ma7PwcglST4HAIM4zC1M8z2Qfmqqo32Q=;
 b=RbVhZBsqIqgEmR9rOq4QsSp+gtrPSJa5hHhXGjheZIupYh4QlEmFy6vtSCamRKtRE8JifcqhP2cj186qs/8VejXItC4MWTzCoQRMt32Z/2sxxxcjrRiqDCZOwb+gf5AyKT/bI9wI1aKLTcuwrL/fFPnKYnqxQVj0AYvoqZ/MJsA=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GV4PR04MB11353.eurprd04.prod.outlook.com (2603:10a6:150:29c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:07:14 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:07:14 +0000
From: Josua Mayer <josua@solid-run.com>
To: Peter Rosin <peda@axentia.se>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz
 Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
	<andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
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
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Thread-Topic: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
Thread-Index: AQHcmRESUG4499YSf0mIlO8cui8aobV6NzeAgAAF7ACAAANKgIAABrCA
Date: Mon, 9 Feb 2026 12:07:14 +0000
Message-ID: <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
 <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
 <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com>
 <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
In-Reply-To: <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|GV4PR04MB11353:EE_|DU6PEPF0000B61E:EE_|AS8PR04MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: ca54be5f-f4ab-4ab6-9301-08de67d3c9f1
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SFp2M295OXdmSmx3VGdXMlVIdWFMcFp3TlVpZmZkZC9qMmIyRHBjakJKSkIy?=
 =?utf-8?B?eGNrTG1GNlBydzJ0YWpPNlBYbnlCQTFSZlJhTHF4Mlc4K3lObVVWNWpUZTQ0?=
 =?utf-8?B?engrb2tMSkZ6Y29odFRwR255a1Q0RzByUXdaZU1zOFM5YWcxSGJQby94aWI1?=
 =?utf-8?B?TDYxVGxVelc1NXFuTHFsTnorYXprQ2lOY0wvQTBqZ0xqcXg2UHkydjR5MFEy?=
 =?utf-8?B?NWsxUU11YmxkRzh6VHdsYVMxYnBBWmY5MGpYRnAwUU9ROTNXTTN6Q2ZqeTlN?=
 =?utf-8?B?RFNGVWtqc0hGUStEaFg2Rys2VFJrVHJiaFkyL2VLbnl1YWhNeGF4dm1Jb2xE?=
 =?utf-8?B?TFZxOVZPWVlVSXN3MzRWUjJvdXppVWlNaXc3SXFwZDhxQkZyRFA1UHlNWW11?=
 =?utf-8?B?L2ZwNnoxbDVUVHB4Yk54UHVYV1diVWNoQmpyNi90bW9RMWZVeFJxQWFlSVBT?=
 =?utf-8?B?QnBVT091V3NJaXd6MjE3OENEaVBOaUJxV05BWktkdkpRQmlUbU5zOEZaaUEy?=
 =?utf-8?B?dHFWQThxaHo0MUZXYnlyTHdCNnJIN2J4OHdYSXB4S0hGZXY5UlVzek0vRE56?=
 =?utf-8?B?TzBwYmtlKy9DMmhzaWpRc0laSFV3d01aWEQxRzVmd0Y1UVcvQ0RrMzlhZ3dR?=
 =?utf-8?B?bmIzYndaTHhHU1ZCM2xtTHJGSEpuamNtaHVXckMyT05pcGV5OGxnanh6U1pS?=
 =?utf-8?B?cW4yREJ2ZHhRUlVoUkwxZFhhdXB5ZW9SWk9qdTUxazBrdVFkNlNETmtBcUJo?=
 =?utf-8?B?YTAyanVRY1ZsK3dZWkowMFFpOEd3YmRLTy92eWNIWUdzVStwWWtWTlREZVpI?=
 =?utf-8?B?QmJmc2dxbUQ0ZE5lTktRZ0FteVpTOVVISDFQNWk4NEkvbDFYTkdKcmhaZGh3?=
 =?utf-8?B?V3NneFNURFZ4QWRCMXJNWkRpK0VSdkkwUDVaQTJLdzdzTzRWOWV0T2lKa0Vv?=
 =?utf-8?B?N1hMTERGK3RrV3lEd2Z6cWNaMlEwSHFGTWNSaGtmd1RnT3Znci9WN1dEaDMx?=
 =?utf-8?B?SzZSTWZvai9zWEFDbnc3S1VqVExaVmVYUnJvQm83Y1h0Y053MWZ0QzhZKzM3?=
 =?utf-8?B?L1hnSEQxR1AyY3JDbmNCUjJ6dTJtaTQ0Z2JFajhSRmQ4bS8wK2xUM1g1Q0lB?=
 =?utf-8?B?L3VHbnlRWkxTWnFSMnM0c1A3a1daNUVXenBxS24xY3A5MGtRZWlhb1Bhajd0?=
 =?utf-8?B?TTJXdGxMNTBOZXlURXY0TlBPUG5BS1lQZlB2b1U5VHVlU2pyUjZjWWJjSDA2?=
 =?utf-8?B?OFlKSmp4U0xvdUlGRHEwSzkvU2lIYVVXdFhFcno1d2JDYzlDWjFqbHVXb3BI?=
 =?utf-8?B?WFp0US81M1c1bm1SdjlJeXY0YXB2S3pYa29VYXk0akl0MlZNQjBBYTB6NUFt?=
 =?utf-8?B?Uy9DRkpwOGs1S3NENU5iYWZrcVRsMHluaUN3YUFCQ0hPaTM5NjB6aE4rSUFI?=
 =?utf-8?B?bmJaSUxZaWwwTkNBZFI1emxSZ0svaWpCZS8rMnI4V0ZsMER5V2YwM2N3a3lq?=
 =?utf-8?B?Y3VRT3JiK0s0RENaUTdnZEt0Y0c3a29qVmd5d1pLb3FSMXBUTk1qaXZGa21N?=
 =?utf-8?B?WGtyZ3dEY1FwU0NOVndTdnVieWwyWm9vRm8ra240aDYvT3k0MTB6M28reW5B?=
 =?utf-8?B?VTZzbExwZExYdzlBYUIwekswdEdLQTVBV2YyYTNQNXZTYVFJM2lMU2NHdzc4?=
 =?utf-8?B?QWsvdlU3YURkelQrR0tubkJDSm9zSGZUS0ZKQjhRaTIrbGo5ZkdtZ1pycUxO?=
 =?utf-8?B?YnhLOEY3bmRpU3ZOSFFaeGZQZ3BMeTl1UlIxSVFiUWdSa29JQnJMc1AyVlZs?=
 =?utf-8?B?aU80UWhjVmlGN3lsbVhBN2RpSnBydnFFMitYNjlvamZIdTNJMFlIRTJZKzlL?=
 =?utf-8?B?L210RlJhaUFFaHp1VnExdGNVU1d0RmZKSVR3ZFYybjNtYnh0V0R4NkwyZHBY?=
 =?utf-8?B?Tk50V2pZWlJFZ3dsVm96d0RKWW1ZK0t0RThYU3VRa24rcDNFcmw1ajJIVzVY?=
 =?utf-8?B?ZHRrQXQzbWdjWm9sMytRYUJZaTZMVGJFV3kvZmJvNk9YUS9MdUhPbHByaUlX?=
 =?utf-8?B?Zmh5N2M1QVBraVhHcjVHY29zaThaQlU4dHJHKy9uOHJIdUVHczRGR21Na3BK?=
 =?utf-8?B?TGVNQnFyOE1CbVV2L3ZuYjR5Y3l2WXcwWmdoS1VMeHl6aWY0UG42YStwaklO?=
 =?utf-8?Q?amyMqbgdVJ7EphMtBjfSmAx3NPtEBwJfFSbM0cc+dzgI?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DECFEF6E1CBEF43AB53C76FDFAF85A3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11353
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e6b723e8f8cb4f0d944818a1dd825fe8:solidrun,office365_emails,sent,inline:7299f935d81ea421dfac3c9fa9405b59
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7325ce9d-812e-4293-9717-08de67d3c317
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|14060799003|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVpaRXd1alg4Y21FSHZURFpDY1FtbEhzQy9RNXdleVUxUXhab1l4Nk55dC9N?=
 =?utf-8?B?eG1ySWY1RVBBb3prMDRzaWk4Q2M0dkwxSEszREJNY2ZpWldYUUFEdkNtUmtI?=
 =?utf-8?B?ZFBZTVFWbG0xV0tuRkZyTEU5Z1J3UlFGLzlnOWNDZnBoSEVoZjQ5UWtWeEJN?=
 =?utf-8?B?Q2V4Z1BxTGlyazFlNzlIRjJXbjVIU0NOb0dQQ0lKR3JLODRja09SWkg2RTc1?=
 =?utf-8?B?dmxjdG1ZWDlaMEM2OUJGaXBoSFZ4Rlg3bGg2WG1DT2N2MDZwS3BsVkZtY1ZG?=
 =?utf-8?B?c1Q4RHBDN2Z0Q3VPUEN0dzlneFNiSFJXV0VWZzZvVEh6ZjcrelhLdDUzQ05z?=
 =?utf-8?B?UXhmV1Q5UE00YU1lcWJkakRjTytySFFBeEgyTk1iRGNUR1ZacEZFQVF2QUhM?=
 =?utf-8?B?SnFoK3BuMVRabFVPbmlEQjlZT3hHbzRnRTIzMkNEVW0yKyt6cXQ2WmlTWi9R?=
 =?utf-8?B?VUtGamlqbHpNNFlnU3VUd25HMGtpeXZ2Um1JUnBHTjNCMzBmMjFJUys1WmZj?=
 =?utf-8?B?WERlNXU4TmdJd1djUWVJbG1oR1owdFo1VHBFYllGdWxzbmlHc1pMNDhqWDdW?=
 =?utf-8?B?bU5sWUptV2g5aWg0ZUFVTm9DcjF4ZEdLMjV5dGlkMFcrSWkyeWtkRVA2VDd1?=
 =?utf-8?B?a3ExdE9ocitlYlJ3L1RhbGYvZElDdzN2dElIbC9vY3FOM3FUQWluQnRGayti?=
 =?utf-8?B?enNWSmRKaHdQczd4aWVKUFNIUVVKbEpha2pGS1hGb2VIeVRTUS9ZTGY5UDlT?=
 =?utf-8?B?TUlRNHA4bGRSTWU4YUpzVkhkSzVBTVNGMzQ1dkc1QjFJd2NVK2NQRk53Vjhx?=
 =?utf-8?B?empnR1FtTkYyNVdkTU5EV2NrTDVKZWhyeGV3a0I5TFgrR2pndXhRQXJLdnRa?=
 =?utf-8?B?cGtaYmo2bGpsZUJYcUluZi9wc0V5Y29HbXRTK1YvQVFqL05hS09BUGFpY3R6?=
 =?utf-8?B?bjlvL3FNbEFXUUhSK1k2T25FRXd3dnJhSzRpODU2UnBtcWJPUjlvVWRjNzB0?=
 =?utf-8?B?MTFkNlFReXZRSkNWSXNRZWZMQTIvK1VNaW9kNGsrVzR0ZXQwYVhYWC9MOG9G?=
 =?utf-8?B?Nm4ybkdHd2dwSWlQbkc0dDkwVWZ4aFBIQTlQZzIrWERhdVQ3OFVzU2d0Q1NJ?=
 =?utf-8?B?S09hQXBTR3E3OGI1N0N3M09Ud2JIVVloVnVrK3daZkpTcmFRbkdnNkNtMlFZ?=
 =?utf-8?B?dkcxbGtVQXJlM2FYU1NmVXpLZVk5L2wxYlV1Yk5nOFMxejdRSnFsWWtIQjlh?=
 =?utf-8?B?SnpvcmhmVTBFWXp4UFBsWThNcXJWa2FTTGpRbkJMdGNmOTcvSHplVWNwM2VF?=
 =?utf-8?B?OHhuaGEyV29TWjB5TkRROGt2blpRWWhObzhjVlZzQnp0RVJOc3FOZUErTEk0?=
 =?utf-8?B?OGdZVytMNVFRL0RDb0F4aDhwNnFwTVVNVXpFcHJmUzVOdGVvb0Jwa1pjN1Vp?=
 =?utf-8?B?elpGSTJOU3ZqNkloeCtqalNSUThwKzc5UGI1bHNsYkY0U2svTGxUeEJ6djN2?=
 =?utf-8?B?aUJwQ2FUdXdnTXI5TnlUc3crZFgzSVAxN25uWTJEek0vRkcySy85dEk3aWJk?=
 =?utf-8?B?a3ZoNnpKQXVZM3ZZQ0ZYYldGS2RKU1BJVHdJRVcvQVZKQTFPQjJMMlliaVMv?=
 =?utf-8?B?ZDNXUlNZTDR2V3BzdjFsQUFmTGh1c0k3Ym5QUUU4aHJqdXRCaUxPYVFTUzAy?=
 =?utf-8?B?aFNrTm1aMDU5WHQ2YTFEaVBBeWwrMU1KT0plSE5xcWY0RDdkZmJBNEhYZkto?=
 =?utf-8?B?SDcwUHBUVFp6V05KWTRCY0RZaDA0VGZ4dnNZVVNwUnkzR2VYWjZ5WmtzOUNz?=
 =?utf-8?B?QU9FQ0M2YW5iemJQRUlRdnorTzUxRFpsMGpvNmo2RWRWTzZQTm9TeEhLTmRS?=
 =?utf-8?B?MU1VY041dzRRSWlOQkVIck5WZjlpT1hGT1FtdkdzcDV0WCtVU1ZrTU42SUVi?=
 =?utf-8?B?NVBSNzUzMnhmTktmNGRqWkx3SjlFejAyOXE0UmhpbTNKVHN0eEZNa2RsUXJ2?=
 =?utf-8?B?V3FyWS9DTWNKZU5LL3hRRjYxcS9RZy95b3Fmd1BBMUpYY2JVczkwQ20vYm5L?=
 =?utf-8?B?WGI4RjdVS1BqbjNPcUU5eThTeVFRZENqc0FVWWwvNFRaWEVNWmc5OGpydUxi?=
 =?utf-8?B?WVV0Z1BvTk5PMmdCSUxzM2pZaEF0ejlyMzJJbTNST2NDUUJudi81cklyZjMx?=
 =?utf-8?B?NUFqRHBIQ2ZWN255ODFFZHFxRHBBRUk3c1ZtdjVsb2g5WG42YWhGb1RNL2Rq?=
 =?utf-8?B?RWpCMFBKdmluUzVKNVYvcXliNTVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(14060799003)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MWow5yKyZKzVy7Tu5YCPwYXnYDT/0ah97v97i0u/13cF02GNq5ZQaUPu47C9QNMW4FYv/PZgYGaQlR34u5A8E8u3WHG20RKd3v2wsF9+aXWIXomZZzoHMhNAErFfOvhTrAk95WTHPDzCOSfoKWveSTe1dXEPHn0EleQc8jAnzYSpXJZDIHI+8YBFZ5itSHMLJHFdHrVrb8+rbWkOi3I4ztkA44fRMn8cKB/cxb4N4+0//poWUStTh0FIehNBV634yrt264I0bfH2ipS9iJ3JvUyerW606TN//14pD6ak0jMyVarHUsuyn+13wFNB81rL7mg/blMkIvrVG8r0kYpE0xp4TExXbYc4VWd1JXvOVtmJ421QhCFAu21qlITZhLQeszQRF6t5C27nm1H4gY66VMvacmSRvaF668WwGkPXIARKuX7Nq1gjS+burs9AQ2kw
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:07:25.6577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca54be5f-f4ab-4ab6-9301-08de67d3c9f1
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6522-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[axentia.se,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3AA5F10EEAF
X-Rspamd-Action: no action

T24gMDkvMDIvMjAyNiAxMzo0MywgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IEhpIQ0KPg0KPiAyMDI2
LTAyLTA5IGF0IDEyOjMxLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEhpIFBldGVyLA0KPj4NCj4+
IE9uIDA5LzAyLzIwMjYgMTM6MTAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+IEhpIQ0KPj4+DQo+
Pj4gMjAyNi0wMi0wOCBhdCAxNjozOCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4+IEFkZCBwcm9t
cHQgYW5kIGhlbHAgdGV4dCBmb3IgQ09ORklHX01VTFRJUExFWEVSIHRvIGFsbG93IGVuYWJsaW5n
IHRoaXMNCj4+Pj4gb3B0aW9uIHRob3J1Z2ggdGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIHdpdGhv
dXQgZXhwbGljaXQgInNlbGVjdCIgZHJpdmVyDQo+Pj4+IGRlcGVuZGVuY2llcy4NCj4+Pj4NCj4+
Pj4gU2VsZWN0IGl0IGJ5IGRlZmF1bHQgd2hlbiBDT01QSUxFX1RFU1QgaXMgc2V0IGZvciBiZXR0
ZXIgY292ZXJhZ2UuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1
YUBzb2xpZC1ydW4uY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9tdXgvS2NvbmZpZyB8
IDkgKysrKysrKystDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXV4L0tjb25maWcg
Yi9kcml2ZXJzL211eC9LY29uZmlnDQo+Pj4+IGluZGV4IGM2ODEzMmUzODEzOC4uNGY3YzZiYjg2
ZmM2IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL211eC9LY29uZmlnDQo+Pj4+ICsrKyBiL2Ry
aXZlcnMvbXV4L0tjb25maWcNCj4+Pj4gQEAgLTQsNyArNCwxNCBAQA0KPj4+PiAgICAjDQo+Pj4+
ICAgIA0KPj4+PiAgICBjb25maWcgTVVMVElQTEVYRVINCj4+Pj4gLQl0cmlzdGF0ZQ0KPj4+PiAr
CXRyaXN0YXRlICJHZW5lcmljIE11bHRpcGxleGVyIFN1cHBvcnQiDQo+Pj4+ICsJZGVmYXVsdCBt
IGlmIENPTVBJTEVfVEVTVA0KPj4+PiArCWhlbHANCj4+Pj4gKwkgIFRoaXMgZnJhbWV3b3JrIGlz
IGRlc2lnbmVkIHRvIGFic3RyYWN0IG11bHRpcGxleGVyIGhhbmRsaW5nIGZvcg0KPj4+PiArCSAg
ZGV2aWNlcyB2aWEgdmFyaW91cyBHUElPLSwgTU1JTy9SZWdtYXAgb3Igc3BlY2lmaWMgbXVsdGlw
bGV4ZXINCj4+Pj4gKwkgIGNvbnRyb2xsZXIgY2hpcHMuDQo+Pj4+ICsNCj4+Pj4gKwkgIElmIHVu
c3VyZSwgc2F5IG5vLg0KPj4+PiAgICANCj4+Pj4gICAgbWVudSAiTXVsdGlwbGV4ZXIgZHJpdmVy
cyINCj4+Pj4gICAgCWRlcGVuZHMgb24gTVVMVElQTEVYRVINCj4+Pj4NCj4+PiBJJ20gbm90IGNv
bWZvcnRhYmxlIHdpdGggbWFraW5nIE1VTFRJUExFWEVSIGEgdmlzaWJsZSBzeW1ib2wuIEl0IGlz
IG1lYW50IHRvDQo+Pj4gYmUgc2VsZWN0ZWQgd2hlbiBuZWVkZWQgKGFuZCB0aGVyZSBhcmUgYSBk
b3plbiBvciBzbyBpbnN0YW5jZXMpLiBUaGUga2J1aWxkDQo+Pj4gZG9jcyBoYXMgdGhpcyBvbiB0
aGUgc3ViamVjdDoNCj4+Pg0KPj4+IAkiSW4gZ2VuZXJhbCB1c2Ugc2VsZWN0IG9ubHkgZm9yIG5v
bi12aXNpYmxlIHN5bWJvbHMgKG5vIHByb21wdHMNCj4+PiAJIGFueXdoZXJlKSBhbmQgZm9yIHN5
bWJvbHMgd2l0aCBubyBkZXBlbmRlbmNpZXMuIg0KPj4gVGhlIHBhdGNoIGRlc2NyaXB0aW9uIGRp
ZG4ndCBtYWtlIHRoZSBkZWNpc2lvbiBsb2dpYyBjbGVhciwNCj4+IGFuZCBJIHBsYW4gdG8gc3Vi
bWl0IGEgc3RhbmRhbG9uZSBwYXRjaCBmb3IgdGhpcyBhZnRlciB2Ny4wLXJjMS4NCj4+DQo+PiBC
YXNpY2FsbHkgZXhpc3RpbmcgZHJpdmVycyB1c2luZyBtdXggY29yZSB1c2VkICJzZWxlY3QiIHRv
IGVuYWJsZSBpdCwNCj4+IGV2ZW4gdGhvdWdoIHRoZSBjb3JlIGNhbiBmdW5jdGlvbiBzdGFuZGFs
b25lIHdpdGggZGV2aWNlLXRyZWUuDQo+Pg0KPj4gU29tZSBvZiB0aGVzZSB1c2VycyAocGh5LWNh
bi10cmFuc2NlaXZlcikgZnVuY3Rpb24gcGVyZmVjdGx5DQo+PiBwZXJmZWN0bHkgZmluZSB3aXRo
b3V0IG11eCwgYW5kIHVzZSBpdCBhcyBhbiBvcHRpb25hbCBmZWF0dXJlLg0KPj4NCj4+IExpa2Vs
eSBkcml2ZXJzIG9ubHkgdXNlZCAic2VsZWN0IiB0byBhdm9pZCB3cml0aW5nIGhlbHBlciBmdW5j
dGlvbnMsDQo+PiBwcm9tcHQsIGtjb25maWcgZGVzY3JpcHRpb24gYW5kIHN0dWJzIC0gd2hpY2gg
dGhpcyBwYXRjaC1zZXQgYWRkZWQuDQo+Pg0KPj4gU28gSSB3aWxsIGFyZ3VlIHRoYXQgc29tZSBl
eGlzdGluZyB1c2VycyByZWx5aW5nIG9uICJzZWxlY3QiIHdhcyB3cm9uZywNCj4+IGFuZCB0aGF0
IHRoZSBtdXggZnJhbWV3b3JrIGlzIGdlbmVyYWxseSB1c2VmdWwgb24gaXRzIG93bi4NCj4gV2hl
biBJIHdyb3RlIHRoZSBtdXggc3ViLXN5c3RlbSBpdCB3YXMgdmVyeSBtdWNoIGludGVudGlvbmFs
IGFuZCBieQ0KPiBkZXNpZ24gdGhhdCBkcml2ZXJzIG5lZWRpbmcgYSBtdXggc2hvdWxkIHNlbGVj
dCBNVUxUSVBMRVhFUiwgYW5kIHRoYXQNCj4gTVVMVElQTEVYRVIgc2hvdWxkIG5vdCBiZSBhIHZp
c2libGUgc3ltYm9sLg0KTmVlZCBpcyBhIHN0cm9uZyB3b3JkIGhlcmUsIGFuZCBkb2Vzbid0IGFk
ZHJlc3MgdGhlIG9wdGlvbmFsIGNhc2UuDQo+IFlvdSBzYXkgdGhhdCBpdCBjb3VsZCBiZSB1c2Vm
dWwgdG8gaGF2ZSBpdCB2aXNpYmxlLCB3aGljaCBpcyBhbGwgZmluZQ0KPiBJIHN1cHBvc2UuIEJ1
dCwgeW91IGZhaWwgdG8gYWRkcmVzcyB0aGF0IHF1b3RlIGZyb20gdGhlIGtidWlsZCBkb2NzLg0K
PiBXaHkgaXMgaXQgT0sgdG8gaGF2ZSB0aGUgcHJlZXhpc3RpbmcgZHJpdmVycyBzZWxlY3QgYSB2
aXNpYmxlIHN5bWJvbCwNCj4gd2hlbiB0aGUga2J1aWxkIGRvY3VtZW50YXRpb24gc3RhdGVzIHRo
YXQgaXQgc2hvdWxkIG5vdCBiZSBkb25lIHRoYXQNCj4gd2F5Pw0KDQpJdCBtaWdodCBoYXZlIGJl
ZW4gb2theSBmb3IgYSB0cmFuc2l0aW9uYWwgcGVyaW9kLg0KTXkgb3JpZ2luYWwgcGF0Y2gtc2V0
IGhhZCBhbHJlYWR5IGV4cGxvZGVkIGR1ZSB0byB0aGUgcmVxdWVzdCB0bw0KaW50cm9kdWNlIGdl
bmVyYWwgcHVycG9zZSBkZXZtXypfb3B0aW9uYWxfKiBoZWxwZXJzLA0KYW5kIHRoZSBmYWN0IHBo
eS1jYW4tdHJhbnNjZWl2ZXIgYWxyZWFkeSBoYWQgYSBsb2NhbCB2ZXJzaW9uIG9mIHRoZSBzYW1l
Lg0KDQpTbyBwZXJoYXBzIGlmIEkgd2lsbCBzdWJtaXQgYSBwYXRjaC1zZXQgY2hhbmdpbmcgdG8g
dmlzaWJsZSBzeW1ib2wsDQpJIHNoYWxsIGFsc28gY2hhbmdlIHRoZSBmZXcgZHJpdmVycyB0aGF0
IGFyZSBub3cgdXNpbmcgInNlbGVjdCI/DQoNCg==


