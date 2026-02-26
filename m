Return-Path: <linux-can+bounces-6642-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OLhOfdJoGkuhwQAu9opvQ
	(envelope-from <linux-can+bounces-6642-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:26:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD511A67ED
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EB33311C905
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341B334C3F;
	Thu, 26 Feb 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jO63Bjtu";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jO63Bjtu"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020110.outbound.protection.outlook.com [52.101.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94833375D;
	Thu, 26 Feb 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.110
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112111; cv=fail; b=fsVnwgd/DEoC3p6YfeAC4KUMRbQO88Mbl1d4XH5vP7bC7LKLYJOBL84LgiGEqgLPtjKVSjX3FPXQODAizGDyUSI1VjNSnyCU0X/xKTxFjgTj+4K8ZyshORpQBFEtPwV20Eiz0N01u0+As/JVfom5tynVXPXwHPLLrQfepK7WCsY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112111; c=relaxed/simple;
	bh=EiycPCNkiYnw6lURDciYeTpSQH2tmn6O2DZT/yLyL+c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W45uyAJ+lNs9eztotR9YrhuxZDqJRzV6SHbKzM4Urklp1hE46nAkMfKcG79O83UdAq7YtFDfGS3MFR0zUJPsci476CkiSodtcUltTFeEK2XC9tY0qAGw6s/5vgkuHHlyIJk5CCvQ6LKWtOYOU1ly+8OqRH0x/OiSVyBaOelfNoM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jO63Bjtu; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jO63Bjtu; arc=fail smtp.client-ip=52.101.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zEDwGXtmq/8YulQm0k8Ds7BpJc2b3UO0Z7U5sJnGnfdlanlyy8vVr5vLaTKA1QWmQYbZtw1EIGKdCjn9Ol0tJiqYDOIXX+BAmoHAf4BYbXOmD+6yIcxkJZqwwVSFCsUi9wVwe7TXKEQOb1BfP5spWb6x7HoJ5VhWWRiFcFUjxa5HBL2R0pGBJNqLZkxjEf2qDQ9H5DhAmFKO/pohMriKBFTD8g4UNd7QSmwJvHdwmnt9EthXKeJ+Cv8So+Q8ATU6e1UZ4pY1faxOhDbZYtnSsZLYJQY4uTetlxr2e8SbBeTF9KYLgD9Y23yLoztf77LDus92DjRLJDCMXm5mCoWhMA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=PJ+/hr7PNqs9bXyfloq/nEH/IWE/SSW9PzvVRfht4teUt+vED6C4WdPwVo5BlYkqJ7Sa3Gd4s1uFmud/ZYbGlYdAImxHl43lwz3l3IUynhivj5iWw8VSYLwGonBAZ1eNlHkQf6DKjRf9+aajFd8nlptSn2zqrqSRnrv+IZ2K69KynXTC6cjarxZdXYMe+mttM7oeUDBdBT1nHLJVmHSiP5AL9yQgxJK/88pJ86TbqCddVtP4lExN+BUqG2a0esWG4KKTZxwsFKrGFwKTwyWhp/CjjyzNOK1ZSiUf0YOkh6agJKQ9y+Vs8iN5G9uMOhgmE3PAv3k2QqvOq0r1O/+Btg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=jO63BjtuBsg1xhhY9kaIK1mGHzk8Lzh9ztgi4QQWlv3xpMqaK0yiE+W68bl86VNgn6+KLUjoCreiueGxVWG1eKbjrUrkq4Pb7fvXzNyGXnzgeVP2zvv8DvC0L+HClfIfH9lEG/x1VGb9qBpUEMbUCdB4+zFlgMQDfZcZLjQ3q+0=
Received: from AS4P195CA0051.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::17)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 13:21:47 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::95) by AS4P195CA0051.outlook.office365.com
 (2603:10a6:20b:65a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 26 Feb 2026 13:21:47 +0000
Received: from emails-8387101-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-107.eu-west-1.compute.internal [10.20.6.107])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id D208280737;
	Thu, 26 Feb 2026 13:21:46 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Feb 26 13:21:39 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBuJ2uF2PDO2SwEfh0J70s9P7Y2xqQbcnVF2WFo5nR+toLNu8HPXZF+M8zoDTuF5uuNqfHrtnLNyOlQIII8wL5FvrIKgBoZ/G+gE9l5j2KP6nLLwnV+iDosK5VRHG8UrBQy1mbkY8oQJAejuacotrhE6OM/sLleTst01zv3SZdJRccAR0sJL+ylbsfGU0UGel0RhmLMo7lUqqOpfsED7TAjJ1/kFZBbAdv9nc9vF8pyS/mp0XHpj97R2sxr7LBW4UdJ1AaU36YsyJL1cC29FDhnFbWMVizZEcT63nw/J6gNXcbytRIEcYmf44RTZe60iXD9z14lDq+A+iwhs4CpdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=oG9Pz7sHI1H1rIsQPj9y0ADDFSOzVpgqmr/MIf3SGJR6TLTusA7TNDevSeAl+GFj0QyjVGhF+ILTTPSxBwE2OUG/S5FL6hcnxX/ZMyyrInZ9rdWaUzWQ2KHNKZvOkFVF1K/3IzkqBOz3g94s5NiXCHpKUMfCrl1qaK6JABET9SHsMffmNvSM3BZAR1MfotpZjwFdfl/7KVddFGIbzj/i44EtuwTSuK2/to5tiLW/DodqBbdhaqzwS5W1OKtHRnnvRvOXNbN+7ZTQ2kajz+XTbjS9tGdJZIJuCqry8QZiSFeFQXNpJid05JEWBrY0OdpFK38jJ4bWP5/TA87/O8lP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzjHXwZElFC+HUQNbvYMVDLUt/jeNMj0vzfEleaL0/M=;
 b=jO63BjtuBsg1xhhY9kaIK1mGHzk8Lzh9ztgi4QQWlv3xpMqaK0yiE+W68bl86VNgn6+KLUjoCreiueGxVWG1eKbjrUrkq4Pb7fvXzNyGXnzgeVP2zvv8DvC0L+HClfIfH9lEG/x1VGb9qBpUEMbUCdB4+zFlgMQDfZcZLjQ3q+0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com (2603:10a6:20b:408::11)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:21:37 +0000
Received: from AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a]) by AM9PR04MB8747.eurprd04.prod.outlook.com
 ([fe80::a0c7:9bd0:56e1:576a%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:21:37 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 26 Feb 2026 15:21:14 +0200
Subject: [PATCH v11 6/9] i2c: omap: switch to new generic helper for
 getting selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-rz-sdio-mux-v11-6-c2a350f9bbd3@solid-run.com>
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
	AM9PR04MB8747:EE_|GVXPR04MB10450:EE_|AMS1EPF00000048:EE_|DB8PR04MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 7762847f-9f08-4cfe-c32f-08de7539fe3a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 i5m+wgi4Oe3JllYcbuUrQ+mdcOGjlU41lAy3FFRNhPw+2rG7Iobuzmq0WOl5i8rSwPCuf1UA22Bfq770R1PcwQlaHYsOcviePrSv2OUKqZit5JfWCjl6T4+mo7sQcLxL2eA77LP4IrvsIqQPCOrWHOdtpIkX6Eo34g8B6C6Gd/vlW3oPbaYb9g9zxPez8L3yixuST3oXNvpdIcItRqzIophraCACBCZ6RAZNqoR/deYqXO3QcwRH8UC3E0S4pk1ltPutUzheA4dSVE+xtm8LaiYqWLGRyoY4kts1zk1tlYhjHtZzRYxb2iRW90bs7Uc7HIEpnW9qtSUihczLlnunys59mDWUVAD+2vF/WaWLGLSNhAnYWmreEBnv3QTdHIGIKol8OHKG78S0cmGpvwIkybj1vaacdKjcmdJFVzeg0eQAsXeQpAScPYFjGu6Q9riygz2kTjmyZJJdcfBchvol7TJIpZfzdHW5Ga/TKqyvuG58Tb2EC3LwepwY2jpRIRXgX6A9RbMEduksJngbzdns8c3gWM1dx5LSJZSHyt3MEKC1n8b6hbOgtnIPkkfymv5d/e6pLXTcXSXUFSrEDj9DdvqP/3clYje/MsELsAZfkSzWoAFf1DxtfPxiSVsN29jB7ZJPMOaJ9N+hV+wHAKezn7zjojYxTiRoP4zwvCTD7HXaeQPFOscTsx12rMwXIKyx8PMlcHI/Kmfl0txIr9gcQgd9LwokxZxfrLxdod738DMNL2sVgneIlXuaNF6oo5TuDqvEhcW2m3m19qM39FGPcCgOEDdVWNDzfEIQ5Ypaic8AdWt8Gxh27Y3fhEbkMmGI
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8747.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 7de7abc3dc274b2f93e97945ca613c04:solidrun,office365_emails,sent,inline:8cf0ea1661083c475b94cab10e2af9ef
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0f27980a-3e9b-4a5f-44f8-08de7539f81a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|14060799003|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	32j+HH99TqVaPlEqWttTTq8NyaGkRqj4u6em3cxQ+PZZejVtrJnxXu5YfTLflDlWvE9WOpYxrv5jp0AELn8e+r0y5Ll7rUWy6LKm1ION6RdV/gClPASpkRzweP+4eJpclBiwpIPL7a/w07z9xTpYGur9Aa/yeazbLjRQCjc+pCTGb1jEKj/0C+MC9rR/DJemocdODYH68Q1lpbPAd0J3EwDIExEE8ID3iL7hBjK++V768Lp7clEyp5tIIUhCQJT5RzLzHEBR9+A+YIq7TTfDcTlFtT1Wi5EDMCBAL4jo/bLLrQppPlcroeva0agDNarcesETSxTl7M3DGrpdkebJK7E2qJouEl4gp32CKKDol5DhJJpIzuA7CtViSp4GPZHLf8NeD2ovtHHge3vpxMqzv0gZPXeuEm6kYf5aWEGkB8QLel0/HTbGdQ/jruXa/zIVInjDosA/Tek+neO83qLBBVGXtL5MpY8nxv3ovJrplFaVcNpuBPXHLsgSizeH6qptTU/k8G5DVe+ldV5OTfsunsmMIxZyHvLduxfkfCQePIcj06ybDEn6lK0AbTOkeTAS2oRlPPjod/AW9UwgcVLSVN+esEzo+p4JAyflQxVShf4bsza3g6HBLzePURjNMutqYJY3EJQPy4iOrOT3tyPu7ipV0jtrkO/brsP+5Dfq3eSKo9YHxZAxYh2S7Al/YHd9FtSQfSMmud/i/LjPzDfBLoV7lBNRsF9E1GhxuXLK9VWHa8+Rf3v+Rw+OEmz6Lt+oz5ei53QSEXs+iRjMKAUi5Hhg22t8YJeMMdB3+KwAxJJYk1F7ZcSyE75Mq5OPk37dBcIRMyUjNRFR7vTTNDDEy/6ipaqAKOc6duXH6LSJB7E=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(14060799003)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vooL7RdQdtcW8ZE9yUNxjRnllvFEhSgHnbVX0mEqzaFz2uKVj5OxR1U6+9Q4t6BbYbE2CsfLajnkdeIsLDf4MTGx04SL8zW4PGb3Ku+Z3/Z4lzsS3sJXVhJ1Y1timGkwnFngHiEZlLnwrcrtUdJox4vEgwIq/ZlWEou5Byit8DDr8Av0RR5JIcgCLGJ8o3vLLS6/kR3R2ibF5+9SkPy5Sx6Dve6JrAafn2Nj2mwdL0lkVpQ1nD+Ig9Mbp5Pw2jLFnugRix8999TtEOiGBO2R+7f6OUutJ2TLiF2A5TdUnwP0kL4PfsID3RiCHMTj5TO7DU50X1K4rFk2ZVVDCLtkQ49Uko03w531VEbT/VvjmS6aT8SLsH59FbQQ7ypabULofk5d0cvlvaj+KX0VGMVvepbQpeJ7pbtgiTMKXJ3USIn01QHCalU70kOrJL3i1elO
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:21:47.1036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7762847f-9f08-4cfe-c32f-08de7539fe3a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
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
	TAGGED_FROM(0.00)[bounces-6642-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
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
X-Rspamd-Queue-Id: 5DD511A67ED
X-Rspamd-Action: no action

Multiplexer subsystem has added generic helper functions for getting an
already selected mux-state object.

Replace existing logic in probe with the equivalent helper function.

There is a functional difference in that the mux is now automatically
deselected on release, replacing the explicit mux_state_deselect call.

This change is only compile-tested.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/i2c/busses/i2c-omap.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d9f590f0c384..f02d294db42a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1453,27 +1453,16 @@ omap_i2c_probe(struct platform_device *pdev)
 				       (1000 * omap->speed / 8);
 	}
 
-	if (of_property_present(node, "mux-states")) {
-		struct mux_state *mux_state;
-
-		mux_state = devm_mux_state_get(&pdev->dev, NULL);
-		if (IS_ERR(mux_state)) {
-			r = PTR_ERR(mux_state);
-			dev_dbg(&pdev->dev, "failed to get I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
-		omap->mux_state = mux_state;
-		r = mux_state_select(omap->mux_state);
-		if (r) {
-			dev_err(&pdev->dev, "failed to select I2C mux: %d\n", r);
-			goto err_put_pm;
-		}
+	omap->mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);
+	if (IS_ERR(omap->mux_state)) {
+		r = PTR_ERR(omap->mux_state);
+		goto err_put_pm;
 	}
 
 	/* reset ASAP, clearing any IRQs */
 	r = omap_i2c_init(omap);
 	if (r)
-		goto err_mux_state_deselect;
+		goto err_put_pm;
 
 	if (omap->rev < OMAP_I2C_OMAP1_REV_2)
 		r = devm_request_irq(&pdev->dev, omap->irq, omap_i2c_omap1_isr,
@@ -1515,9 +1504,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-err_mux_state_deselect:
-	if (omap->mux_state)
-		mux_state_deselect(omap->mux_state);
 err_put_pm:
 	pm_runtime_put_sync(omap->dev);
 err_disable_pm:

-- 
2.43.0


