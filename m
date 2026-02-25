Return-Path: <linux-can+bounces-6627-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FCSDrTfnmmCXgQAu9opvQ
	(envelope-from <linux-can+bounces-6627-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:40:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE65196B68
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B473132DC7
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC939901F;
	Wed, 25 Feb 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Ndbzicij";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Ndbzicij"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023132.outbound.protection.outlook.com [52.101.83.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91992396B6D;
	Wed, 25 Feb 2026 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019308; cv=fail; b=nbnvdBwpt40+A8qbiQcYb1epO6liURowC9ez93vfCYY52Y0fcsBsjIN/7ArQOGCMdmnBR1awi1TOM7ZuPB7FIAXSKjjqwz9e+DhNwBm0C7KN67q0hOb3eZ57YZ5wMZ7UEGlkHo7wX/OiqW04MfzfUV+zHPp71qSbwLmA3rAgOMg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019308; c=relaxed/simple;
	bh=+7AXzRDdO/6DznkCVEj7nvWGb+MksP8sfm3UBQHqum8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EXjPNbAvvjx6bFIiRUFAc2yp0mAsI8qLHfVg3Y9aSJSWXxnQqdXwbAoqA4jqeg7vpFWWfBYFqrVTbKmGXQZXKSt/+Xt35dWni9gpizBt2kepch1KKb2zMYooF42SbrFAq3bMVgHdxZ8LBUkJMl1sVjX2pg9Xd4LIPkqy0TA5Z8o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Ndbzicij; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Ndbzicij; arc=fail smtp.client-ip=52.101.83.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ADHJQS6ySRzh1GORYrwtL4WZ8EzRgH6NwyHl35sQfvcKIx/xDddNYt8da5gmvDHUOmBM0hX3WnHqO5QMqStn6dIoepoh+83Z5kFqjCGJlOkEglbBB5F3qTORUewhdAD0Bx3hYKeo2/qSHCYskM+b2JZojlEmCnE91KzVY4eJynBfnf719/83h0EwGu6NOQIIQXc0gwwyH2Taup713VO+HUHkp3XIL1s97dwse2B1AEM5DwQ1gUlNQLCmg7Si5Zv5iv9yjuOJNG6ieedLsfFAMLuL8uBAOdjQY5aCE17ldtYb/nlD8DWA4QgtyeWRpDgCoHgmm3IF6g0Ims6t+MrvUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=BjpgdAj/Y6ZzKbf5BBpmENe5LFDgLXcRVbu4H/HHpcnNx90It4S4AXfjku1whDkUXFZ+6LHiMrHm+8R/JmIvav9EY9mm+8BYIJ06mO/zsKMCrD4ZG7UqlAdu2Wbaek4Orwj8QccEsZighH679wzRBhoYCSyMt39rPbakXdL2+J1vyyVx2LK3+H7vXifia1Nf3ij1ocDhRO3msNh8B9dptLg2xrWMV28xubBTRTotFSB8CJi4IWTbauPKp+gC0v7UEuDbMg9eMUQpTx24GMgtrTbQdPGI7j+OFNtnVKC6H9OG3KTSc+YRejlGN2o13vknTQavRsnPGVC6mDxHFsTBOQ==
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
 b=NdbzicijW3watOO3W4kAko2POdC2E7Oi5YqJwOFfqU/PTGlY2zYKtRkUI0ZXE06tiU1dultsO7hNhJgXwV+Ohb9o5n+6/amvx/5wrVzswFF5Y+rX9UJLn/ZiptIT2J1yvad5q0BGdgGSh9c7gyti/Oytbkgywc4AVRniu7DRNdQ=
Received: from AS4P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::20)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 11:34:57 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::be) by AS4P189CA0029.outlook.office365.com
 (2603:10a6:20b:5db::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:57 +0000
Received: from emails-8955119-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-236.eu-west-1.compute.internal [10.20.6.236])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id D2BF1800AF;
	Wed, 25 Feb 2026 11:34:56 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:48 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6bW5HXvjXDWcZ0Q1SlP9A5RBJouyHa2YnOd2KFryoksq4NTfEuvoxxlJ+BEKi3Faubp8taOt1LutnmtE4qZAyDGlqhFMqApo0ecmF5HRT3cXBadY6FVHU/a4BgP4czSPJiYaiuUucQFCY3LOX4UWKEAFDAvpOVyunmNfU69Zoid5+svIJdjc+rTQpi3CO4IKXadFsq/6RpMUvcs5210DDhT9G6cUEE8Y5LwvxddyBPbWsROBATC6RJP8/6yhrNb2h/+tGpEfDGfpTiuFWgiisMqLvczSn9gDsYptf/+lGVPVDuXzmegnvCZNUcDjzDG1RAcakaUpeT/4MHTEDk68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=qbBBtvpAnAieje18IubTBXR3dCtaJk3GsPERDFGWsQfJxqaXvj8mTGuNomIY7mjSa4AjQsl6niVd4z07kE+RYjC0Nbotkdrq8dzLUTE5Z4/H3ORuDq/pt9KpS4hhY/qpVL27FnwE2gF+h61ldgw62S84k4RKbwvUfeXkV4ZN0/iSIitV7KkkV0MKbc+ppg552f4l1AVcpy46ckYgik6yZW6gqtIL85+8MQztWwGe1J7i9mYd3cpsvmQ3iB/Ph0Pq8CoyAFAZ+O9XeOY7v2S2ms/TWQJlZSf58Gd1R/divBh/kMY+Xr6pmolIhhH2mz0Xm5TRgeNloU5zFNPsoavbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pz5DJOiL7LFwXjit3f1me5jLlWQVO3kRPLX8AiZ7lo=;
 b=NdbzicijW3watOO3W4kAko2POdC2E7Oi5YqJwOFfqU/PTGlY2zYKtRkUI0ZXE06tiU1dultsO7hNhJgXwV+Ohb9o5n+6/amvx/5wrVzswFF5Y+rX9UJLn/ZiptIT2J1yvad5q0BGdgGSh9c7gyti/Oytbkgywc4AVRniu7DRNdQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 11:34:45 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:21 +0200
Subject: [PATCH v10 7/9] dt-bindings: mmc: renesas,sdhi: Add mux-states
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-7-1ee44f2ea112@solid-run.com>
References: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
In-Reply-To: <20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com>
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
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM8PR04MB7827:EE_|AMS1EPF0000004E:EE_|AM0PR04MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e78255-af6e-4e93-1626-08de7461e727
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 8onVQkSghXWJXhtbVRiZshzGy2czI6Qq2eu3NxflZ0CO+XyBBSaC/B11+C0EdBqRHGB9N/A1+yp0FsUG6xiuHvJ5xgWTadU/BZrCYvNM1KuCtBPxcCCWm3hjOFEqe5o2J94/+7wdhuy6M1G5U6ZW5Fpp8C0G+Sv4AgaNFyQkNaC4Mb+4FLs9poelZ/KQns6zo53fxB1kH0qIbabK6B32hQaqvvaqp5i8QBFgTnTu3MRO4G2Bw40J+f1Cttil6IBnQx+I5jFN3P/A1k5xcc3yB1JAiYHFK9qX1NQF1IzbFQw61k9ti3v3cfJc6pJ4+dFNaj9UsqqjwycxLRY1A3gh+mNxxs+iQHr1rV0g9bfih+GVirvQGFhCWjEXFRZor8quU4D98EIkH9V/8n0wdMQ/tPDl9XFQWoCY6CkkGsFWUTR8/XRNK7DZQFeILP6nEWN7HZT3Ywmd46aVnn0zmR50TOdmZtCI+3gErerMb311tObRsA1f/ltqy5MBVLWkAgqHTgtEgUuwRwuOn2K+AC30340Byvf3r3vhd1xL5852dG5ee10+ksarohI914b2PTgeN25bT28NIBY+UUeZBxnRACoAO9biPORyWg2TxfGE1XYuwpqP21qKbThEvPgZL18B1fxzxVu5tF8MBbLyA7+uDz5gNWYtgpibLWW42/VYVLVDLoIaNf57jrWU0K7W7fggwzyKRQn6FRT0IJvYK9UgwZ8iuGe5E+KvppQD1X8oxz/AafxRoshl/O6l84mJo4pzXyfL1nwbLd7GPBhWAuu9H66s7IH1NfM0o8MZM9tJg5J3KfBjuIz5fb6qfyzuaatR
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: a6e161f487e3441a92562db6092b2473:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	42f2231a-3150-40d9-27f4-08de7461dfd5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|14060799003|82310400026|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	21+vQUqGPf352F8UHkkDqleGTkQQ9umttrbKOCX5KiLdEiMAIWWULOtMJat5AqrPSVjqsDXI704lq28jIwFJreIZB122Jh16hdBDTrcsTtqKhJ0WDrCa7t0cogxI4iKsxx7ue7i4lb5yfuAhw2VsucRRUxeRrOvJ9wNeTU3Ce1WTLmjY8lbVoQLof39Q5WI3TAMhvckv8aSqqGM7vTRVpyXYoUaEE5vYhRTIrvyvQ1pg9chFzBekqzslGC5+lPCQB2W1YV4HBj9MVD/HBeR+GTm0cilHB28ybfSGwSnRRQRB3SvDqgF6wdbKcZ1atNAnKxq2RC+hMS6fDpVLRSJmdedtwxbbpU/Syy3eZ2XTP8NXQMkjmMvKxfYhNRegTAggzeSVyGVS78i2kCzw/W62opEWl91WBp8SAZGlT9c6+8+1VThTu2EYbOwqJu30JFfoxZz4tMdNEGFQIi5cSE5d22MGu5pPin3I5cNmiByjiFuZBWVN3OXUdkJk9BIx37Pa8jWc0JdQ9gqvYKKGf4T+d24vBRyP4EOyKaDpa3fKMcp8amNc4MkL3b1JhgElgX+2sZFZl7qRni8GF3AMaLqMNL6l5DQuekA1qTa2Mx2tisVVUeS44/JRbRik9DgMfam1yNGodFykuaWTYFYNIq28x3zvkbIUNdeTGdurzlB3PkVuC2+5jgGNCMAWs2Y2koEXPsL2F0/Mv2Xqu8Gx+byjLmEJ3HzXWtuzYycfOZurEiI6CD8T5ScsFvEEC3cwMS5sq+H3TB0cu+JuFA8hlewgjGwmGbUOKTd4QIt6xi1YkKeKl42L6ur3jYDtli+pOR3o9fiyXL6OO2I1oVQuTno5AA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(14060799003)(82310400026)(35042699022)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nyDK3Qcz4eouKh8mHYV4qbc4a0MhuhPOxyURCIVf9FlFeoy43qeqJ9b19lF2rs3IDQYvpYkSwMMs2XoeYpwuebPnD5LtJqme3ZQNQ5hQX2UPnaPMVMybd2TqdmHX+zPCd5fNI2mDbIIPD1MnPB2BrhoZTfN78cQx9JOMG6TTQy2GBLSXdlcs7/dfL7cSONO1IEOT2Ox5ccd1EP1LnhHHgq8yM2Kuw/LjzcliK6Ao00wibSPV3sxcquY/0+NsszreWu2MJT6F0uVwUvawbRXTEavP3VvrOxCHPBkOq5nQmv03fDddud9Op4i14qK5SWB1RFQ3XNhcmrUzInZLfUxpZqD3RYWT6b2g4AcmIeGQhwwy+/e2Yym0uUHF4J9k2cV4bvbApCbzSqjKBNOd3a6tTWktFyX8ulDxLOxTj1+4vgC9Hyb91EniW/PmWPP3ARzD
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:57.0940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e78255-af6e-4e93-1626-08de7461e727
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6627-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sang-engineering.com:email,solidrn.onmicrosoft.com:dkim,ee120000:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8FE65196B68
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


