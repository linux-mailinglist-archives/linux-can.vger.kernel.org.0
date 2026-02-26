Return-Path: <linux-can+bounces-6637-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO9vBldJoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6637-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:23:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5B1A6661
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3960030BC105
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9526732548A;
	Thu, 26 Feb 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="e3D7DYK+";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="e3D7DYK+"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020130.outbound.protection.outlook.com [52.101.84.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7D326D4D;
	Thu, 26 Feb 2026 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.130
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112099; cv=fail; b=FT/rwXZPXdDiZTwi/FGP7gKmNMHZFeUS7MYy7Emrsk37LByqV8UdJ5+rW3E6so5r4wO5v4tZeXL6U0rSddLWRUa/AlFGIRvIe3XqiPalngdI8HPg4fC8iFahtxrokctWwJjQFB9yLEWMkaJ/A93qqShhJgRcwMLY+zZcQivRz3I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112099; c=relaxed/simple;
	bh=gIoxlHu7rlzYmhBeBqU5S+sw7hNrppAAqkVqt71hd3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C631CTPB39eq8sVZ8mTKpKIBaeg8j2l9jf10eBJFdAfLqoIZYjZsblE1l0HAHMIi8TDL5S3tIrUE5CkEpmrsQaw5LmMOlRhmpzsJ92fPBHS0J9BQhIH4LJ+dFT8gX0TCahNDCSNwEvpRzCKPDh/3SYU90ZFg+7eptWKrsHJr7xg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=e3D7DYK+; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=e3D7DYK+; arc=fail smtp.client-ip=52.101.84.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XKG2Aarfhhnj2I+JQ7X9Ixbm2UVrQvrNrVvQ92jC/Z4D2yp9iRV5mkJBWcIfEMHPVrnB7DXqjDA7F2ItxWdtrXh2y4zwZArxSbxA/XJOtLcLD4J9A13DMoDZOidU6NcO6++xRo66zXGtFRIvEg5H9Jk4tEJBaCAMT+b8HsPXBgSfvVyMtvaYNH8i8GN49S/RWtR4BXMx4DeG+YbHvRP1z7zIACzG+TGE5tuk3VZPderr06hoZI6Xi/T2I9E/RYnrHaBh1685ziQJVMXgX0msM6ODxoa3Ivjh0W/Ojfw0BU5BpnDF8ePWcw0/CXrRUAzPJus5Ptt9YMFHI9uDCegJ+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=MlReprIfXE/zrtClWti5lQVYFdNgcBcHin+FrRsId1CMJdJv5mJxTVo0mB5xat94B+GK2NmWDC5TdpnS9WFVuidYSydtM0mJPXdfEhXu4Skj+fMB5cJFWdaV4jygPceTG/QZ33NLQ4RCz8h9D6zLDu1QyaxJAuu4wpJYtKr+ZtfHhpp4FBCHmugnop+W3XXhYscT/JWiqR0UMxP0RSynAJC+IdBg9GfpMtwESdz+ztxmRg8JZuMeoNjkxotoye3ON/7bPVEcIY8XKD6WbJwsxqcxAWfcAv9rTNYI9ZWzciCpxkrKS7EuCFyuSYGLwbM9NetCou8E/BeDdrWEOslyPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=e3D7DYK+68e6sgm0RLGJU/PiIo38EBY8CgnGLpahUKCGYpdC5U7eDk3Qwpi/zb+sugVcumq4xHv2FUFmLPVyGjzKig4rkWEHZIsqfoVLAfkAFwaflhlCGsb2Cdj7C/Fhf6MmseaRPKWW2QXdi142pRme52rDq4z4BT1EMI5VGLE=
Received: from AS4P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::17)
 by DU4PR04MB10621.eurprd04.prod.outlook.com (2603:10a6:10:585::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:21:34 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::c) by AS4P191CA0026.outlook.office365.com
 (2603:10a6:20b:5d9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:33 +0000
Received: from emails-7686594-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 6BAA080762;
	Thu, 26 Feb 2026 13:21:33 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:25 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTG/GF6VPoZPaFnT1B6cPSMGugL16sju/30C3DLVb2CxOac0UNtGpQrRhTPxqL5+BsUyhlV5IGcQ8+kwamZWfQbjRscrHWKPAE3GUvvhMJeQVRAa2P4yOJSkToC1TZHvCCX6YP4NbtlrReeb0EhsJWmPZNZ8RBS65wp0OSwLHxRQGH++SpJRBjh6E6JX4YRcXyspQuTEyV2zEn4K7bFNnb36oQQ/EV2fxM4b5fwEITFHgozij9TTRF/gXI1NejYQN2+q/dOXvEg4uvbp3+Z8FXYWRzq8W2q+eq6RSg0f5trxQ+f55hJpOdTwfoC4M1nialHHeSrh4Mn2dRFFy5IEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=JnCez7zlbjAQQICjU1u/5h6tuNjj7n95JvQxP5f77ojSZzwCw7H/7RCqCjVMsPJsvlumb4iawNys1MlLpvoT+zENgvQjAol8iZ2685WxO5GKsy8btNvxczgNIPXMoA8ZBM7V2GGjC+rUHtGqo9SszQPwLE8EW0rgYLuBBuXETxM6CFs28a6z0dT6Eo4isrco5AoOwAwGkqdVLl4G7Sio74+fneAinzAyatxkhhVg8bVyb63SUJCzq8WOLDGbSIMVR+Gi6IfVpF6ijABuBW3mdQ7JE18k0/NfIrxLgSLZEWEMZpJ6I4TUvUhygPCckn0KT8il/dWuij0ERPe0UREg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzAyXBOs8pV58MkKLE2L8RWopmmcBRu6qI84jVDHazs=;
 b=e3D7DYK+68e6sgm0RLGJU/PiIo38EBY8CgnGLpahUKCGYpdC5U7eDk3Qwpi/zb+sugVcumq4xHv2FUFmLPVyGjzKig4rkWEHZIsqfoVLAfkAFwaflhlCGsb2Cdj7C/Fhf6MmseaRPKWW2QXdi142pRme52rDq4z4BT1EMI5VGLE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:21:23 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:23 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:09 +0200
Subject: [PATCH v11 1/9] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-1-c2a350f9bbd3@solid-run.com>
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
	AM9PR04MB8747:EE_|AM0PR04MB6786:EE_|AMS0EPF000001B6:EE_|DU4PR04MB10621:EE_
X-MS-Office365-Filtering-Correlation-Id: 0555f600-fa4b-4ca0-baeb-08de7539f637
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 tv090wHkRnCjxhKP4AGVFWhmxHaIdq4N1GyXK1fHkPrSAk6VLTjjjs1raIIe/KlXIio2cca6B9Ws+ppyFfm7sH38X5RUD3bje23KTDZInO/akqfVDBllhCB5zuymtsqUIGIej7RJYVgBGmebMoqnNgWAQ/MxdYzXRHDn5zmOImxPM1IYo4Wjz+BdCzOAbG/K4BiD9NuvrM+suXW5zd48ewxRH3pt/craC3/qDt4e7Tpai4APKuWYHdP85hW+0lqcdNma4VedI9IdthOQj9Pz3VYnUtuJEF5z94j0M1kHZC+/ttD8tW++ChnexrZ6E76FapDtS8b9wo9yaF1sWMCYNqktZ/VwcFHNjzdVV4YcTk1TCDQPu/V631EQjcB56NBbUv1zQbG8fZG4YzlpsC3zltIrNr8tMGG9JKFhyJU0i9ANbVuouaH9QgK6qoM3Xc6wi0dODJiUylld0WYKeMi5/2LsBSrsCgIRJOl8low2x/9StCFallc4zYqxPVg2e+nZPShkrzjaDHrRUe080XDTL2TPhdmbFL398vLRoqYuW5yPqqnXQvMhyNVXtc3MwSiSUlzo+wKrj0xBvPD1u4hrycmsBN4xDQ/xQkg27kZRkmNo6iech7/6E4sEFm/R1ah60UhH+v/bddVgZk5StOLA2fimRIjY/n0NWjqlG2UQ+PtiGgw1BVbXmyQJcDIElmZWUEIQsmFAOkmm4dubBuf0ohenBGEaJYQjGA2cbR9Y+6ECK8sFDn751FgpeYNy9CPj5FQ3qsFGdeuHTJtLyTXxvzY/QajZZCyadjLqSRnI9K46PNNxUrMM21V5ikPmLAiL
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 417c6971e37343a587131f2b3bc62170:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ea7a7f00-6e7f-4e68-f33a-08de7539efbf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|14060799003|35042699022|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	vIkEQb+LBaKOa9FaD6omjV7I6eZ/mCZYo4SrLIf0tpLJL3nrYvmbp6mRfxMPN53EpRIh09e8K1pbKgK+jMWs+xXnKZHWnE5ySlLf3CHJCjjLFZyZQtO8Q1A8IOJ0G0NcyI1RH9F73sa/tM3Yqjg1uV5BCXlg9u2N3MZG9bL6WEjLlyr4pG5tAeejYcCtnvm3ca+iTXDlUctCu1EoseueegqWNo0zTlsbzk4UKBAdPemBCn76nPDS/F+VSEePr4BfBAU8Je/TGbbjX0pUskY4++3modsly/MV9CipITxqimnEFQra733KVpsyyZ5IaJTsJqBNA7Ux1hXgIW343+o7b60Fi+WwIIL1n79zxiokJpNfAfTL5dxu8vJVqrE/4uhi97Nu2oN48yF7j0YFUIa3A8UEX6Hh56iGZFFJrV+by1pGV0iowg1IyXi8UNawlM8F2Ndd2041jgFhLEf6sw7DOihhMtFtMWZGhko244XHS6gQrUfBUlju02KNaAbOp30Va3xqJmiFXNwNayyWALi5ccFaFgq/FiXvSUaPuq/zv7Hn0yMNRW4B7pE4Eei8Z4WKXndBPnkp3RYdSugn+iZQI9/OFVMODnb8aEIl6cjBlRqAWJ0YVbwxD/z9kUJFMDxO0dvGXP8j5S49EjtHC7kOqxw608Y+ywdG/qVoU/XiVmUVumBuoYiXhDtOn+v5T3cktO7IHwHGz4APjkHIrhZQS83yXG3YNfYfq9wZ9ExZrRzVXMmT6HZtaGVbDomY920Okm6qt8i4vj3esDv7No3O+axW1kpVDKAM7EunbXuAHVnYv6LrTS9cMeECz8UsOFmcBy8GCb6qxutJozdIdxCEtxJ4a0j9/Ix98r5bi4ESNWA=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(14060799003)(35042699022)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YAXMzK+RKKMK1WGFmYXDv47FtR6VyTb/91tKUM6ULXH6JLxKO9PL1KXGRWsHpaTObiXZcM/z/snPXpx3s+hHitkJ/jQmk8wGZC0ZgmnSi66WqTGR9eSEkwJwfHIRYBc/oKHClim6dX9ucI7tpYzg+aWU/GTQBMPn+V8OfqTJ7VBh2dWt85Se5nlCaikZAAE2+Uc7Ggm9fKBgvVNqCkI1yqxnjBqoCQg4MHnE4riVuKLmm0mcz2mcBlH57h1HjeEnSti1h93aPB2Z/3synidfHv1YQYgbPIIoqGjdUVlE6batR/wyZLyE2aoYIzJcP8UiAsZ2iHgGg2teomedD2CUWDD5qdJyf+NG/jEr5pfxt47+FOIttW7Aw80FX1hWr7IreyMDJ2rmQBBzW3oAhpdPduCS3r8c+ZpH+N/ZuQH4PNinDdS2jh+YL6xyJ47SqSF4
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:33.6630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0555f600-fa4b-4ca0-baeb-08de7539f637
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10621
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
	TAGGED_FROM(0.00)[bounces-6637-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 83E5B1A6661
X-Rspamd-Action: no action

Rename the temporary devm_mux_state_get_optional function to avoid
conflict with upcoming implementation in multiplexer subsystem.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 330356706ad7..fcbca9d2bded 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -128,7 +128,7 @@ MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
 /* Temporary wrapper until the multiplexer subsystem supports optional muxes */
 static inline struct mux_state *
-devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+can_transceiver_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
 {
 	if (!of_property_present(dev->of_node, "mux-states"))
 		return NULL;
@@ -183,7 +183,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = devm_mux_state_get_optional(dev, NULL);
+	mux_state = can_transceiver_phy_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0


