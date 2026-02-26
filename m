Return-Path: <linux-can+bounces-6643-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPxkKTNKoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6643-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:27:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212301A6873
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB1B312F105
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2093358C6;
	Thu, 26 Feb 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aYHIqWp2";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aYHIqWp2"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021106.outbound.protection.outlook.com [52.101.70.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E9335542;
	Thu, 26 Feb 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.106
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112114; cv=fail; b=tU1xKL5iGpHk/Mi+iZFexDQjOkijn69l0MzMtr0+0mNuZaIZDcGwR8Ok9HP7bJLhYefrcRnuM3pjTN0JCFuF7bZWxHC7GnPRLl1tbXgk58UrdbDDLsMjt+//0sBBzOgnDXXgKKZDaVHnsxZTw7uFJfMBfU3/esxlnVfQR3RNoHc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112114; c=relaxed/simple;
	bh=+7AXzRDdO/6DznkCVEj7nvWGb+MksP8sfm3UBQHqum8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q4KUN9t2KeN9WMSqMPG0ARciXEwuIBShNHXCYXoG8+D9Am4G0gOIXiK9bXy4cCFbYVBSVZ/mnD75ZAywZmign+RUpC84lIk1oHqiiZPqUkscJFQ6Sxiq+otDXsye8P6jw+WOAt24FouQBDAf4UI5Wd4G7oeUqJBEYtSJcS8n+Zk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aYHIqWp2; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aYHIqWp2; arc=fail smtp.client-ip=52.101.70.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HA3Xf3N7UdCOQEpW25LSsL6W/TgsKBfwAGkaVQ5y3IgHxD8Bctnx/QNVGYzzYTplMAXZsv1cycIJyRE00Z49bc+oxiorHmlf39Ojxz4CJWq8KKuDAFLixyEdc+wMOkCuPpGvzpcwXw6r3quBudT3g/JztCnbcbrV0vPvZED5dxQROZXahYq8uz/wsoYUoZpprAtrE0jXOGyyWp4+V4m5U3XTxwMCi0MnGBMfHt7dCwajXADlcSosHUJ35qjSmYwPyhSAsnnf6ArTWGn4uJ/CZZqfEAXM53Awy2N3RmAdKUGktX2jBY4I/qH4IfbOs6g7pA90boj0/0xSxnMMIwSKcw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=UmjQDhlMMhgQfzkZsZWh35Q8sQ34ARZ4F55OkrK86T5j2kiTsRF6pnlw2GKC9ccfvS/OgJkhqO38fBzPQGjNz34ln9fLoDKeU2BZDI5ivhLGws3KA9klrztZd9a7UUCMjThvTtLxReJTCC7Szk2WqlnNnvJbOsYKKzWApnuF0azjLYw1aat7HzoUTQESKxocHz5jrTC4ucTGMRnizblKmQZVNWa62JWhcMG/zHlYzantFur/Y9vgWY5Dy57aTCxT1T1stcQc2jYYtlRmzxjm2bd7Tx1oj1/+54sylSqoXJCXIO7nAhrE+WYauOJFHPz41eCfMk5zO/kmHEgk6YxXxA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=aYHIqWp2RcEeFYZXi8lTHHB50II768zlme/xgCZnueKRxjaxI+cYaLtqv5M6w2lFkOH28vr14wn+SsTkPxsbObGADb0kLlPTpAqztYBFWdSQm2m3fcGjzpW+L7KHKM9xUmkFdphkPQAjYekzWtf90rXbbvK2lW8+1MjlpxqWIfw=
Received: from AS4P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::18)
 by GV2PR04MB11142.eurprd04.prod.outlook.com (2603:10a6:150:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 13:21:47 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::76) by AS4P250CA0012.outlook.office365.com
 (2603:10a6:20b:5df::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:47 +0000
Received: from emails-158417-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-107.eu-west-1.compute.internal [10.20.5.107])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id E53CE8073A;
	Thu, 26 Feb 2026 13:21:46 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:41 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDLcVkLhHBd7Dxyl+DSUOUuZ8+5dJQLu7iwUGW4AzgB6WskIaT3R4/iU3ptOhBpe/rTTgFzJ6FszyeXCPFqFJ4DXvzunblYI3IJDNohC35cUozRr/Yo2Z2Ixddf3bQuMSF06LfcwIvivms1foXPy4QMcxMmGE+qr7Y+z1O61SUtisVI6kSKdWL35zdQcTe7s1aCoX20rF+plkZnv6iFfsZlYklmVa9CECosy/AkBpraCi69m+EuAvCb8z+igkxeAjjoShsshEf8PcL4rSrqYt+GEiieTYOr0RzmKoy+LtfoxdakLR86eAjNthQSe+5fYoyOYxxtKAJBVpPLw9T6y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=tlV/u3FWemxqLnnim2Wu06Q3yS10aVEAv6uA3c9jINDaqe8JQ1ig4MvVRa6eH7wENNxdgKPFmyMhRw7M3oUNe9r2qPn4P6cDDQhmEtml0j6tkFg4CcZiaYy3FQIicT9hpxuPpd3faD5oSb04pUW+IAd9MIQLFaAh96UMBu2uKhjwlQd7/t5MmVnRJSjKyES2QjopOrb/HDZ/qD7nxXP79NuxpU2hi+TMSzcslI+obgdHGMhAY8o7vaS6xtstmrBeEK8c4V4d8LS+D7iEcbbaJok/gRPAbDr0i1miP7FX94q64ASFM3f1ebJSaUXmzHfyyEfoZ0onB3H/asOYoLk7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=aYHIqWp2RcEeFYZXi8lTHHB50II768zlme/xgCZnueKRxjaxI+cYaLtqv5M6w2lFkOH28vr14wn+SsTkPxsbObGADb0kLlPTpAqztYBFWdSQm2m3fcGjzpW+L7KHKM9xUmkFdphkPQAjYekzWtf90rXbbvK2lW8+1MjlpxqWIfw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by GV1PR04MB10521.eurprd04.prod.outlook.com (2603:10a6:150:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:21:39 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:39 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:15 +0200
Subject: [PATCH v11 7/9] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-7-c2a350f9bbd3@solid-run.com>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
In-Reply-To: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR04MB8747:EE_|GV1PR04MB10521:EE_|AMS0EPF00000192:EE_|GV2PR04MB11142:EE_
X-MS-Office365-Filtering-Correlation-Id: 509492de-c766-4047-052c-08de7539fe5c
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 PTJCpzCXL/9Wy/HdX1zucvjJKbf/oBMemk9En/R1JFwggpt6Eu4eHmbZCVygV91qRpwV7bq5as5tMO/CofHksgSYsh9qThQCFPhtI2IG7ulIl9WvryUUurfJC05ldMOV8U5OJ2GrZRH3cOVcFDKmsurOu2MTLeRCyJtLI6YdDPm/sjDNAGN+ByaII7KEAlx0jcEu9k/2pl8U9clwXALttCprnBO/aslrFV/oEiPXo8lBkFZktBgIOvX3PYudvqjXlUagSFGB4f0j7W8v8WC2BSC9TBW4P40B0j4OLxYlOXHLs1UDjwD4Nw6Kks1Onit8/pEkQbGPUVjGXPtGtHfDP1aE4tHHh25MgFdAJhQVFwNkK8KjLIBoy//W59N2RvtRLqYV7UWBaxrcdb+piUex77OIpF0pkhl++EVn+vK5C4R8evO7RBBjsPyqpfwSOylUQdJf+UNZ+R/aSrdjf9tPX/rWBjJCcLxGOBgyYrsXQ/6KaBHdqx/m+T/QuU1BTwbmmnrGLMLOdooXILPruk2OyMSQhlghCpOgfh0BV95O3AOsxIcyGZ/4XqoG09SreK/TkTM0oZsRmaYHpWEbU5U08Uu2ghG74rcf0JGBBtGe5nRQ1Ot6ZUH9SzYOQev+J4P4dxr3hNCFqMyCllDWMYe1y40CJPImkhj1fCvNwjoVTZT02Y4SXGvI2bf3vouEyjrYeHcWPOiDE5a4wXvrWDKMU6Q97mWh1KTbHOXHeST/6j8nHBN7YzygsoKGvGm4gXud85aqF6x2JoQSHl/WPulwS9mSEvIoWX0xMcFCJw87czWpmFWdnDtcsvp2aVdQJmWR
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10521
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 137f2b79e0d34516869db63dc2f6f57d:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4eb1183f-0f97-41b7-7a12-08de7539f9b5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|14060799003|36860700013|1800799024|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	62exL+Fgz2in+6QYA8Co3IieS4yKOYlD7l5hoibfj3vv4rQaibFInaH5fg+978sSNGtbndxbTK1vNv7PALBwrRfu47mU0Ok8wVglg0qjgN15mbnLj0AeYetnLuF2DOnl8jKJ2RKrA4vg/dqWZZSXVKOpSXSk6F3Rh74tdyTR6YXX4Jpsp2EaOvz71HhC94IAo01Sx5A/qB+WhpN0rXWJBrZwM2BNnusuTs0qSmDIlznaIX3/iAQ1cQadoNeNYsAQX6ObdNVV70Fm+i3e0XkxRcTMaHxh8AS6rgtMAH5+IOUtCIkjc2c3Yw4pKwwHxPmZnVkbUsZ31GyHRouZ57k3BmJOgsqGIoDd9OSXI+pCGwctXkYKsvV6JDZmWWLj0jbcPcMhd0M8Gdb5VyNCAuJw+EU/xupOc6MmjSGAeeKZs6uowwz9Sk4KLWi6YLYkyTJZhb88t8p54XIhqxfGA8w+ePTEvYyXdLTuqZOZy8qBlmyCdiTkxtZQSAgco4SfaRiCJo9mHP51bEoh5JQHypUBVN05bWl2nVQ0Bq+yXWkEKPHnyKrv5VwDZrdnocarGZeFtylltCsOFl4IMzpjvMq1R5yBffrj7KGcdmCjiAKKPw1EXWCAmfn+dsTEdjbyyxmWqESvnlKtaDTQthhJDiDJCznYRJv0zHnFokurJEx1AvFsiXlS35MoChyfAowy+20ysQJCvP6z+e3Oga0M/Ey805sdmoNX8+CcXQitmgiO1CKWjLvFOJY+h/Xtmzmn6pMH+ccg/8fyWWNIwJx7wwPsMnVzbnjw5byK8xX1IFOJ4znAIGrwRcBES/+19wmUyU1h7fVWJzri5LnPyTA4RKlszg==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(14060799003)(36860700013)(1800799024)(35042699022)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B5lAoz4SDouk+voisBmPSiaOcckqq9MBUMHQixoeYojgOISHtEDRiuMOomuIRdLIe3iJKw9teMjPlpFMlS4Y+DjvJG7RjW0/5Y4Hg3X2pI2MnWWc1/pN05NyFziHlJv5lCGF3wMxT94Sy6kj+f1X0dUktbzZG9ebkfRqiXG2Z9XGvrFdWm0v6ANyJKXLGxCgvw06h+NrHG9uPzmgmGh7vapfROyoBkU0O1EjOf/ET/5N+ut0b2oCRxZLczC4y+GzDmAJtbFLW3umHuGDx9lqfzfXnWbDlAZxWVz8vyPmh6lgOvfnLT5I3dQiTHWDr1JgodyTMDUgiZfhOf8eH1JYyGuxsNfyZ/VwF3ytDqnRkOozX9t5SHgmZUVTF/jOWl0afqL0amuOyixb+uTGp83ok5BA58RjjW1UbBAQGI7w6bTQuOeTe5ttkTNFamWFqFZR
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:47.3215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509492de-c766-4047-052c-08de7539fe5c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11142
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6643-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ee120000:email,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sang-engineering.com:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,gmail.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 212301A6873
X-Rspamd-Action: no action

Add mux controller support for data or control lines that are muxed
between a host and multiple cards.

There are several devices supporting a choice of eMMC or SD on a single
board by both dip switch and gpio, e.g. Renesas RZ/G2L SMARC SoM and
SolidRun RZ/G2L SoM.

In-tree dts for the Renesas boards currently rely on preprocessor macros
and gpio hogs to describe the respective cards.

By adding mux-states property to sdhi controller description, boards can
correctly describe the mux that already exists in hardware - and drivers
can coordinate between mux selection and probing for cards.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index c754ea71f51f..64fac0d11329 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -106,6 +106,11 @@ properties:
   iommus:
     maxItems: 1
 
+  mux-states:
+    description:
+      mux controller node to route the SD/SDIO/eMMC signals from SoC to cards.
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
@@ -275,6 +280,7 @@ examples:
         max-frequency = <195000000>;
         power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
         resets = <&cpg 314>;
+        mux-states = <&mux 0>;
     };
 
     sdhi1: mmc@ee120000 {

-- 
2.43.0


