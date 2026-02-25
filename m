Return-Path: <linux-can+bounces-6628-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIURFtLfnmmCXgQAu9opvQ
	(envelope-from <linux-can+bounces-6628-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:41:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB5196B8D
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48DB6310B60A
	for <lists+linux-can@lfdr.de>; Wed, 25 Feb 2026 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B78399032;
	Wed, 25 Feb 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nx1O9+2j";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nx1O9+2j"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023077.outbound.protection.outlook.com [40.107.159.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEF396D23;
	Wed, 25 Feb 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019309; cv=fail; b=lrImFCKG/af9hYf2nFt/Fg9LYafDssu0xdalMZ823N1/WZV/GUkVwHeTQywazI6duZGpSKFt3/tBp0MrVcvsHjyHgKwlMXE3yKUEBN0/+cDvRyTwn62MK4dVZUvYJxHaWvQWe7apudoLncYuzL7f3pavFFGy9gcWtcYzOq3Yuu4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019309; c=relaxed/simple;
	bh=0xgIAzpIx6sDZ0evpwD9L0vEMTzWqF05Lk0dfsHEfrM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ooHp6K3LGDFA+c5mCI24bJdSk0l1WCQzs1yvSOEuyeJMvaKdrWnlqETRvGY3wTGqg3yzQQpHbVMp7H6DgCMYI2iwrKiQmy9ntiotnDU8Mtp1WXH5w/I28hkSSL0pJbX3Q9NxJ/zRLIZ44f3UsmhAUN7b55ByBuehou3wjiROJx0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nx1O9+2j; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nx1O9+2j; arc=fail smtp.client-ip=40.107.159.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=a3IS5DRiP45DstdnJRZht+7DbUb3sRHyMoFQJNKVJ32J+cUiWhhv7+rFexKaCE4TQYx68/Y3CQ2gZ0CqDLv5z1RC9URmOjs5FxcbFVYNnySjryWlrqMJujE/r6tUs+MKZ6rZczPwwk65oLhBojbxl5arraGAesbSjLasbukU4RlkEG2Wcm9zTm5A9ZhKAhvhQDKyLLc3dFhqjAgtO3/RRTwgqjWldjyy3aeYC/JBBES206dlv/PsB6ViM1mGKRsFnAamKhHLBrr+KzbjdFNlQYUqAYJq5qZ5B1M/n2NxjdoY/S3P/VU1JEd+U5QgVOY3gSQYJKrLv4aQ9Ha+/BjUaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op9PnztMfVKYUGE7bIsBgRPH9Ym6EEP9NAUKCO1L3/s=;
 b=rKnksVydv02uv3Dzzeo47vXvcH8KeNZH7e18HKWSFhTi79taNri9R3xYdQIPYdKoXpAh9QUqxngzk34NcB9UhxxUm3CO05CyI0z4XUiBs5vkIIgHLcIYum5zRkCnl+BfuQ5QwWFFkOsSYzwR/UHzh4o4iw7M62AkB6qudNu0CpSTUkGXurz4g3YB4i5ClXmmVujEKPViueLUTnpzqGHDLinGkTVna1l6UIYU746vrDUl8fBQ1JTQ328hlWd/tbikx58MCPly3LG4li2UxpwCCoC404r2u9Z5Y7WZjQKkVn0a97/ebe8eAkhvw6yo9cbmKBSkQE8sNJNiFqYdj8aMDQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op9PnztMfVKYUGE7bIsBgRPH9Ym6EEP9NAUKCO1L3/s=;
 b=nx1O9+2jm/UxPeGHvmA7wCQkAMajix3IyZS7YiXa0MWuZwGddT3OIqpDTc2cDyiEEibjq7TbijCM0nz/IuWgwQm7eSF7aKI4Wfyccof+BnTbd59WPO7ZmFPjoHgp8z7Aj+mLirx3lS0nAXY/LJwqqQrMhRr41zHRPqwKhD+VOtA=
Received: from AS4P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::11)
 by PA6PR04MB11779.eurprd04.prod.outlook.com (2603:10a6:102:521::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Wed, 25 Feb
 2026 11:34:59 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::af) by AS4P189CA0023.outlook.office365.com
 (2603:10a6:20b:5db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 11:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Wed, 25 Feb 2026 11:34:58 +0000
Received: from emails-8729467-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-66.eu-west-1.compute.internal [10.20.5.66])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 2B8D7805AF;
	Wed, 25 Feb 2026 11:34:58 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Feb 25 11:34:51 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVOn7kkvqVukIBnfqLc8x3SGA+oOnXLQNZ1srSGcDCKNB/b2Lxy5fsmACK5iedpAAoPdDfm9DHVsVlqaheMaJv6mfpKuOKbX8JYLN1tEvGwGC7W9XUbQGD4K5ybhLcYOJEV68YEznyJaRxaZL0lUKjrK1x9kEv+NFa01SelmRl7o/0qmKr+TUVjCGaXg6A6Bb5v9VJU5yyZvjoGXxGyjrvGLLPZLcW7h2Pjy8a8bKNv1YIv5qxpaLPOD75Txbnr7NAnEzKUN0y/rZFlSH8np7dsTaLXmq9VVVMF86/yyX4hwxzR4TebxX7qhroJNK24bvwPE9xW2+bMLok/K5aLl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op9PnztMfVKYUGE7bIsBgRPH9Ym6EEP9NAUKCO1L3/s=;
 b=xWwj4JVclUe961UNEgVLSgoM7xXSepeduxacCIKyT36mg3O2QA6DveXOUPOBqte87FrokgdiqKOhNGqy/0wZRvSSSRIeeFS7oE2PxZQTqrRgiqqx3hjMMVPcT5wktFY5qnIQ90B4l3z0rahjGRmGWYA25GYZMFH9DUGwMJFIxrFo/MhVax0QmcheAFH/gNttJ9Wgs+zPzJHowBN5weixCZsmRlEOk5U/XKc4/adeMn53UmQUs9gqW68+jKCncCFJdRrFyUKFUZpCjXK0NfPRUs26ajJEPqSTkKsTSXDg6UebJuBVo9mGVYcMlPpw2NR116euHpxGS67l8Jznt6tuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op9PnztMfVKYUGE7bIsBgRPH9Ym6EEP9NAUKCO1L3/s=;
 b=nx1O9+2jm/UxPeGHvmA7wCQkAMajix3IyZS7YiXa0MWuZwGddT3OIqpDTc2cDyiEEibjq7TbijCM0nz/IuWgwQm7eSF7aKI4Wfyccof+BnTbd59WPO7ZmFPjoHgp8z7Aj+mLirx3lS0nAXY/LJwqqQrMhRr41zHRPqwKhD+VOtA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 11:34:48 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 11:34:47 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 25 Feb 2026 13:34:22 +0200
Subject: [PATCH v10 8/9] mux: add prompt and help text to
 CONFIG_MULTIPLEXER making it visible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-rz-sdio-mux-v10-8-1ee44f2ea112@solid-run.com>
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
	PAXPR04MB8749:EE_|AM8PR04MB7827:EE_|AMS1EPF0000004E:EE_|PA6PR04MB11779:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c5f3c2-5ba2-4050-843b-08de7461e7eb
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 JvHJMuAAh1SUi361pQGBxclGgwJZj0BNT52FCrNtxQkcJp5ExQ+kD65z7SXoQ2PgnUuEAkGCZL5X5Wz9p/Id9rwvDTwVszzSLV1bJmwboWmtZEUODR0xxJcsiGtfvuV2kI/Ld4Gywdj+NuGE77yRCSeOkZDjdr7PqSSrw/DD/e+a4qpl8x4XmktJ4sDIb3r39tNcljz1S91+ux0W1rsts9sKdEiRVqtosFo6Joy43vcYj6oNGX/WZjoMt4aa1EzJadVptqw8kB5mJnKnnR0bIJrosQGyThIJpKhf+fsd66VP7gxDm2Q/PkeJ5TzMwYe+mFLkgKrSSaOo3QiFiiAtahk7ruGtS/CUHwcjmvYl4LOUADOZGGoShkeGhskY0iHpRHsXgP8NdlGZj+MgFmr1PNDon7G3Z+g+WT87L5ZBUlF9TdtdaCgcSbaKtrxifoarmQEmojV4CvXosXmjoK4/bTu+H7QTqHw8zlMzDoIjwsHKNxr/H8n3awiWoyaSVt648+hX5tmuAavOCLNKUtlMRZaEMWREMSv1oK1M1868J3xW8wuTJWznT3G4rDLorxosId6MJqMXxLoP5abnbQxgz/nwiohkvQNFw18joIXmBPWsLnjSbTVrZZiq/wUSNIjhKjmYU3gglxXYwqfE0OVxC3apSKUVmquNCKBYI6B1N5JtpN38olAE5Biv6e4ortGkDiNtzFbex1/EQCd1Ag5qfWvCbC5J+SWlzw9W/hoOjWdSD/KKpE1na68566b26nVpZ2spLsXrFyEFZCdL4awjZGpiBMWpW9Cy5nlHm+zZeK6/l9JZuf7pMKERbl8Tt+NL
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4edb92f27a5b4146af438ad987c20c5d:solidrun,office365_emails,sent,inline:c1cd8ff72a3c708341fd9de96626bab6
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	02cd16d4-c119-4285-f7d5-08de7461e137
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|35042699022|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	u7Ga6/MEgytVffrpcEAL7odzTL+l69xq7GVXeoDiI40H1AKIiY9qCCuIzf28e84M7g/9XCodVrsAqnl7jajGN1HGJMk7R4bRQ7BoaX2D/GjklO1OcyTYAdRNt3a/etG7OMVyRRQbJ/4qJEHUlqOeldkxlAGcWhwX3c8wsTPlbCo0ByI5Z+R1DfhkyVKewScGG0q+bOsYq9y851+GE3gYU12YNl8jY3QYzrrf+bJ0n10A9IrdP3U0bMEMPY+Q28oQskdopPYM4BvEol46rit0n+xdcIm/Xz/Durq55WyupC+3odVxVV56hPkV12V2DhUeeC1yGxhDq8vGyKT3m0nXvk0m5H6nMw0DAuhrGMZJfG5GqGW/krlZ6XmA8RkoXtzOctCNimLG6vuk6n54k6EGplKqXXOfq3n9AsKE1c3pZVpg7NmqNvp02rDWHUeCjeEkCuArzEbTeJKf+PodpEhrr/GSnbn17oCYitWpSOsMtpeE7haLM6H/ZNPeIfE9os91bK5Epe5sKEGo5r1W3Z8wuQ8YFMh3R5UM1nth6zZ9rKZZQckjy1yQygau9v6sOx/5wPb0X9YlVI7sih5alrnIAbm1h2xUJHrb5qvX3GrE4RcWzCzzm6yNF2sVgD8LFt3fwID3Q6CLKFylZl0izfccociwLMWlzhVO63l7rbuHRBKQg413UPoLjAPOKojfpl6r8K1oTxUu4lkvt5lDMmzY+9hBSUdlU+RT65t0VbySHyLT62zktMHJVNNDdf5j0o36yJ5L8+orqhw6rjPLArAGmWUrThxS0PEr0pym/LAY5zBVM19cbk+XljNapWXF6Os04McuQeZETP3kVjS8ULs4dPlLX9VqN6tT7XdpiWbFDb0=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(35042699022)(14060799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hUktw4mTJVXydX67xzt32OCRpPvOYMxh3P1Yk91T5JFcoFXYLHms9BliXwKvWWVh6FSqeInqRC+Ikvf9UGvlLbLuXbJOI06MRz0hM9YPrs4XbGgMENdZR7+TXCgA+UJq9VAm520qLz7nXhPt3JQejHBzjemKabYnERDzMLjtR1M5wAXkBtskoIYkZunKJjETLDNdEz//Czw+0QxKTdVZrCX8SMQrXEcqrawX/m9vM2bI90UrWtthytpGmcSRwbRdI/PUVEiabtxAVF38+8+AjEaix/f6V82LNYEHfEt6gCpDXhjNvcHB2hQEi/Ml9mK29oqb15oQ92XDggvJLoqWcBcL0hHdgXdSoaSRU3JN6BsvYXHGY2r+W+H7LFkIwVKjtEF3sgirohF0gtU8hQbViASwqJg3K7EmT+kbHzPI0ji6Ayjhb/fOkHQpYFAv0P0V
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:34:58.3994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c5f3c2-5ba2-4050-843b-08de7461e7eb
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11779
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
	TAGGED_FROM(0.00)[bounces-6628-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: BFAB5196B8D
X-Rspamd-Action: no action

The multiplexer subsystem was initially designed only for use by drivers
that require muxes, and did in particular not consider optional muxes or
to compile as a module.

Over time several drivers have added a "select MULTIPLEXER" dependency,
some of which require a mux and some consider it optional. v7.0-rc1
shows 15 such occurrences in Kconfig files, in a variety of subsystems.

Further some drivers such as gpio-mux are useful on their own (e.g.
through device-tree idle-state property), but can not currently be
selected through menuconfig unless another driver selecting MULTIPLEXER
symbol was enabled first.

The natural step forward to allow enabling mux core and drivers would be
adding prompt and help text to the existing symbol.

This violates the general kbuild advice to avoid selecting visible
symbols.

Alternatively addition of a wrapper symbol MUX_CORE was considered,
which in turn would "select MULTIPLEXER". This however creates new
issues and confusion as MULTIPLEXER and MUX_CORE need to share the same
state, i.e. MUX_CORE in menuconfig must not be set to m while
MULTIPLEXER was selected builtin. Further confusion occurs with Kconfig
"depends on" relationships that could reference either MUX_CORE or
MULTIPLEXER.

It is common across the tree for subsystem symbols to be both visible
and selected, e.g. I2C & SPI. In the same spirit multiplexer needs to
ignore this particular kbuild rule.

Add prompt and help text to the existing MULTIPLEXER symbol, making it
visible in (menu)config without breaking existing "select MULTIPLEXER"
occurrences in the tree.

Select it by default when COMPILE_TEST is set for better coverage.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index c68132e38138..4f7c6bb86fc6 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,7 +4,14 @@
 #
 
 config MULTIPLEXER
-	tristate
+	tristate "Generic Multiplexer Support"
+	default m if COMPILE_TEST
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


