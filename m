Return-Path: <linux-can+bounces-6639-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKy8ON5JoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6639-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:25:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA71A67A4
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D8EC309374A
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758E32F763;
	Thu, 26 Feb 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QPYRavgQ";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QPYRavgQ"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020104.outbound.protection.outlook.com [52.101.84.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1841329375;
	Thu, 26 Feb 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.104
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112107; cv=fail; b=OD73PnP7oBXzGYJg1wwpsrG+OcFy460SmWnJQ8wY+7MnvvsyRoao5041Cs6WHfx3lkb5qBxz0guMS2nN7+1yO6ts0ZRvR9QWBhwYhTSJkc9v/DVlRjvM6TPYdsZzq7aneE/d/dVfR0mn5z5+3ea1nnQAiahdvrC1RA0TjqGkoSo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112107; c=relaxed/simple;
	bh=MaXGRVFV5D4+x651nqdtVkDjvYCRYwsLmnrZ6kDPYiM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tXqO7Pxb17ns+SkZuOaJfodAjkY+ftwuBmAav2E+aJ/M1Vtd7Q4WU0QagVlQ7Vgk/NqUSBBDf7XmkGn4K10OEtLRHe2sPVs0LJLBHuPKNjuwi8Jo7n2nJ7UDBfhuTqALaSh6ZSduz7tv36OOcrFMckAOxeCeatlNkemGXb8VDHI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QPYRavgQ; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QPYRavgQ; arc=fail smtp.client-ip=52.101.84.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EZJG25QehBEITjRaxJNUVtibdN1sBrdnEnB7oNCLcarOoaydotL10i0a77p2TVYScdgOL0X/Xevtig+oZdTfbeDNo/hF8XXr18ncFZxXyRWqVrWnJeDZ3paRq0zy+H6uFKHzITI6xdR8Am2BG5Es9GxU7njk4Cwx9ie8EPT1X5mgon9RJsFzTuOOpLlKErzXEICzWntN0F/XNHhrGx5fe+Dk0wbRjAImvEzOuM7yge+v4YXH95u3YhG9Bma9U4OOIQai0SHcACPsdKejwQlDqYe2eQhBOnC2+CFVYctulusdU2k7OZQ+1eu9tBZnUMpS/BqMlG6KH3VyMZWzb1zcSA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=t0XFXb5xy50wYe2DuLbPtBdN3JD8qiMjv5488/vDzh1RlG01b8CoDZoroIYKMpJfAmgHNKK+3QF/UFgdg8f9TH96Vsx41eV9CklIoHE21hp+IpwFWQDpg5qB79VedsJ62Lb8CstUF4LXp9NtT0Rf6ad59ID1TAWJa0OV6hbaR0RgtMMhM1r0qz2lKUISmuzlcx6Vx/+T6NjnbqloTxaNoxMSBBaE0CXL5OstSham+/gFKVwewMY3ULWOerFs058j3PNnkNHpfacLDOOT7X2deukPrcPfDmCUWdqzAErEIN4nHfnyHTh9N+VmqY+2NG0fUAG5ZLRi+02Bqrfivdf/pQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=QPYRavgQIoqPZtlIBC5njZHyTAue8khnRX9sJoFgKMJwNOlIDJJ6JScUFCHsDRs72J8mihOe/ZXLDFro1N2j9hJdO3qTYx1ikWcf8UcpyqL2t1C05UALm5JkMy2HkHN4VKmgNYYp3c15pXFpVO6n6VQNfuPtkNBsgWFcuyi0weo=
Received: from DU2PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:10:232::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 13:21:42 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com (2603:10a6:10:232::4)
 by DU2PR04CA0070.outlook.office365.com (2603:10a6:10:232::15) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25
 via Frontend Transport; Thu, 26 Feb 2026 13:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:42 +0000
Received: from emails-5074848-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 115F98073E;
	Thu, 26 Feb 2026 13:21:42 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:35 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIouZtjxawCuYu958cM6MknsWBVnTWiY8ulD1waE2Mu8FEeEUqpE6MgN4CzMRj3yiDMciqtb9tFRcdCZ/GVNs5sy1q8ixW5rzC1BmbP/AXjgYGh8Z2Y5Qcs5xoFhuUcmiCRDGo3OkZBBHXn3+WAnCkKydo+UwH0iqEQ433cnStu/CKyq/vpugtn92nKkOjJiNFyuLYn/maoMapxrgnXClkatH3MRpCONiR+aYFyFm9bTKxPQ8Z2VfUV7rJtJ00cfS2ii1g2S8yH4O5m8VSrzKv+u9Pesqv4a9uymaXt6yhnNP3cN0eUPPs7fTv0p0c3fKUH5/Y/LdLgDSalE241Lmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=dQ0AuqzSEmc0zcI/RP1bV/HDkEYVS4fVuNSGJM0V4VbmdKZk4FLMPgzn8nlNYLDzGMsS9dRx/pXuzqL8JHO8ZEJON3l7R9A1IpEgQGsLk5NWN/gEF3PF4vSWgYGuQSd7LtohSxVNzXsJuOzQRpRtgEoqedlW2pcSBj7bj3mObe5ZYtOqYeVRRwa50PuxTpHk7P3a/K32crqtuBA+lwfgeTS0eADvLCey3C8V/AeYYmmjMwaJFaiVc9I5XmUV/jGLR2bZKgz4i1XTit7qeePxPfr02D38IFb3kOb2FzpJZlPsIEhuMZuPv//mkDz9/O8SJasc1/cmjOE9wxWoLutSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M2mFq6iCFu+EUCfRCxkGbxkJ8ojybvwsDSHWoZhGUY=;
 b=QPYRavgQIoqPZtlIBC5njZHyTAue8khnRX9sJoFgKMJwNOlIDJJ6JScUFCHsDRs72J8mihOe/ZXLDFro1N2j9hJdO3qTYx1ikWcf8UcpyqL2t1C05UALm5JkMy2HkHN4VKmgNYYp3c15pXFpVO6n6VQNfuPtkNBsgWFcuyi0weo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by GV1PR04MB10521.eurprd04.prod.outlook.com (2603:10a6:150:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:21:34 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:34 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:13 +0200
Subject: [PATCH v11 5/9] phy: renesas: rcar-gen3-usb2: drop helper getting
 optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-5-c2a350f9bbd3@solid-run.com>
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
	AM9PR04MB8747:EE_|GV1PR04MB10521:EE_|DU6PEPF0000B622:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae3a965-33e4-4536-cf9e-08de7539fb42
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 z4LoUlwrqxRwipNEa1pWQIT8M1nCxfUFPo8NO05GYtqVWk9lovXkI1qB/2za173oyc9L+2qKSAcddVubJeqYLU3RKPFc7xSpXTWEoZ699R2q5g8H1Msw3MBiTNyLQbuPx2ncO3IZJMOL9f2ReEXCebzYGNLlIVN4pmwQIu90ICloxVDRTWCwGYhZw72JskBScHcrCQJkiprkaY+JMiVLehdgaRXXH6K9W56mw1wOP7ifVg1hZmcrR6WsdheOldSXTmQ9b3bU8PAVovxZWCR93rbo/BwVYox/NX8kofKhj7W7DOuzDPQPxYaSzYQkyCuVPgDoaBi9sNUM3Rs0/GVKF0notkCYq64/lK42rXZdZgYoxR9cihgFyDv7ZpGkTelaFsaflsZyu1Ylnj6KTm1idj0vKEwiqY8On5uGWFQuhplFzGCR417FTreN5KERkLOtsCpGAoM2kTtilzYFNGwcyJWEwTdfekPHHCMrghvy8tNkbPqY9m8JTilnuv64xJFMYBTY/HLUYbMskRQqFUNNCNb36bf8YAevE1EW5OndZBZcMRwDunIKD+ttZHrN4v5417TcJzBp0rvICFZcqu+FrpoFcBHRpxv5RISk213dTSeGHFQALEnxrE09/e5b0MJEDkPWKQU9CH1/ytnP6S/w9F8iRjWU/wJZKqr9+650WQU88TB7HgK2STPKoPMb9oYQdX4D8tq4wwfJUcaAG55Q4RdLsaB6hQBQQQxE4oHx5MnRjG10pN4SP+gQkGu3Nngm9bH3BIvOSLnRwok552u1rsMgWjA2cX4hlBCcR5CGV8YwvY+ElOXmUB1bQ+yzrlQO
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10521
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 9e9ca2ddc5cf4b3a9470bdd5104d978b:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bd9f60d0-8ca7-4ca0-cf7d-08de7539f684
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|7416014|376014|35042699022|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	IdrkErp1VaSD1B6ergeRuBBAhXshrnsEMtB+8sfS1UXOf1/OrK4HmpIsN9MQ3JdMp3YJ4bxCMB79DBGUVhRNJ5qegY/f0KH77FZsG83PXxyTZwKRFBqihKlBFzR3zavgKOf4cH/qTGe4R26IxMkTv7qm7rZsy3DTRgNc0Izog5oCqNX1sJKH0mgRIVzA8Pf0egShgYKEZ+jR7bsIU+RHjd7ht/Jui8FeMD1EGDgB1O3AdBixr3ptPNs++JqQZcspBGpWEjAh1RnceVfo5xlNSv0kBvUjNGELw2XnBLCWUPAkXFG27GcDEXdtkxcv//X3LBqwkqvbWIh4yLMh1XyQjg4+S0AYIsYYjqTfu/2qf8F+fkKkjZQSTWpMfBXju2brq7ABWnpWhl1OGsA2Sq5cuZdbXnWNTsCHVIq7O+sCtmw4Vs9jY5ouVnxIt2tNNPElRBToWoF/UPzyKIyTi7Hbi4QVt1+5S+EBpiOAYy7aeUXigTqqW+uz7DRz1vQkH+OSjFrGNsz0ueeTHsoYNAZXMVBkhQ4Ru8zlwj7iByb9XeDKlZYpQsu8kRwosTpmDpR4jH5vRAwl6klVC0ZAWfcJn5x7kDRbRWeiyEB9ZM9ScMw4tc6j4YBuXMXbH0D1/47pOS8FVMNlh0FPIN0MsDey5Ul5CpE6N3hbk0vq0Jqo8USOL7eUv656HQki5Zm+ti1q9ehKklTvzIq3padqh9p72z/e4ACSndzLurVQqBJZL4AmZh3ofQvPJlBsaNpfkZFc/fSktZklXlOGApCS5TDoExKlzZ8XzFn9fIFh0ybviq1a9xABpygLAuK1LQ0VjYbTPTUG4kT2E9rKaG5teRVrJXA5qsGCq5fLrz+D3uk02dg=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(7416014)(376014)(35042699022)(36860700013)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LDP2JSvjt2ney950b4onFKkAkRxWmnNkFGmkLFHomPYugRuGDgDDmtKXQeeSJIOcKvq/86wdhj+tWwzm8meZQuYPvpOFDFzAtFK1OflENgetMVnDwmAHGqGQ5dJ1/Up4TohsJitA7Py5MX9xDHhTtb14qONnrw+94aXNIyDOd7U9JZqrJO6ahEWfzBnvQKGF88Hd2ZEjUNF71O12+2xVwcknv0elrKyueyZzfb3a/OyMpQgg1wozib92N9IKZrX7cN1T4RocmgS7VeS6jZiwvaWtr+fcqNppIVyLkt0fRcSTf5w4xtlizooc9XvcPpGQioBIM+iIHHaKlDENg1RgIOAFPtnPp5A53/I0IcTGKW/1csjtZBC3nCYV9zsfb3+bKE5vn4XNtZdPOrydCa05A35BwY2Bnbdun+yyD08ZQpni11lr75Gu517RAF3s7kWo
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:42.1812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae3a965-33e4-4536-cf9e-08de7539fb42
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6639-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BCBA71A67A4
X-Rspamd-Action: no action

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional_selected helper.

This change is only compile-tested.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 1155b111420a..79e820e2fe55 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -939,21 +939,6 @@ static int rcar_gen3_phy_usb2_vbus_regulator_register(struct rcar_gen3_chan *cha
 	return rcar_gen3_phy_usb2_vbus_regulator_get_exclusive_enable(channel, enable);
 }
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-rcar_gen3_phy_mux_state_get_optional(struct device *dev, const char *mux_name)
-{
-	if (!of_property_present(dev->of_node, "mux-states"))
-		return NULL;
-
-	return devm_mux_state_get(dev, mux_name);
-}
-
-static void rcar_gen3_phy_mux_state_deselect(void *data)
-{
-	mux_state_deselect(data);
-}
-
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1036,20 +1021,9 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
 	}
 
-	mux_state = rcar_gen3_phy_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional_selected(dev, NULL);
 	if (IS_ERR(mux_state))
-		return PTR_ERR(mux_state);
-	if (mux_state) {
-		ret = mux_state_select(mux_state);
-		if (ret)
-			return dev_err_probe(dev, ret, "Failed to select USB mux\n");
-
-		ret = devm_add_action_or_reset(dev, rcar_gen3_phy_mux_state_deselect,
-					       mux_state);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to register USB mux state deselect\n");
-	}
+		return dev_err_probe(dev, PTR_ERR(mux_state), "Failed to get USB mux\n");
 
 	if (channel->phy_data->no_adp_ctrl && channel->is_otg_channel) {
 		ret = rcar_gen3_phy_usb2_vbus_regulator_register(channel);

-- 
2.43.0


