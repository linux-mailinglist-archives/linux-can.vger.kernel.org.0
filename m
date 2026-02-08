Return-Path: <linux-can+bounces-6506-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE8JKZiuiGlTuQQAu9opvQ
	(envelope-from <linux-can+bounces-6506-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:41:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E110942C
	for <lists+linux-can@lfdr.de>; Sun, 08 Feb 2026 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46273048082
	for <lists+linux-can@lfdr.de>; Sun,  8 Feb 2026 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A736656C;
	Sun,  8 Feb 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VF6q9a/A";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VF6q9a/A"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023096.outbound.protection.outlook.com [52.101.72.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1C3659F0;
	Sun,  8 Feb 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.96
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565169; cv=fail; b=kYsjlvKbtVwrbpkCsDXJRyi4uYFCky6ULN557INnNL0nSn64mAf/6CsemtzRMyvfCw9DR73XQ32P1xu3u3tvltqJsqtLc9sXH7iAmmXQgRLMDJ57KnjYw0ui4EXg61OFYPxKnyTmRSZnBbVo0G6q+QiEu/G27IIl5kEacktWJ1I=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565169; c=relaxed/simple;
	bh=K/U4thyDXnFWdTp2u98yNVqdSww1ruBk5gCiFRZoLwE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mPgUczhGYMY0re0Is+tiJ9jrpDVg1M4bFPZR0DFYFi3gWou8cqphFZ1+UC5HsU22x1UFYfvk5xltQ3/Fj44jakdCorHJJNJfbuxtCxXQRvd/HqvGddRUPh06iQrBdWC3UcHTHK/1JrZBz9X330k6XfncSmjyzGB9e3f0R8E0n5U=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VF6q9a/A; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VF6q9a/A; arc=fail smtp.client-ip=52.101.72.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uH+VYalIKBkvmlpdpOw7XjOqDQrw8ABBrZsSOn7T21da3/ez0Kx+kTygEyIwFIjXJq/LRNmYR+c/CEE+wd5YehfhoYse3aqToEXnnGgPSiFIMELIqbz2YSSj09U7OwrbQaCmkkYeBJDusPJjKX2ocss3K+7gO0EQ7iMkEuwhNvhbzR9VCJdUacLmD6vCItCOIXf6hLOzpQuT/Py1PkbTAE4LnFY36/6FZSCmcEkQS9viHCErzTWFM5H7HncPi/Jljha6VaXcnXdAnBy6GnF+ZpYjssf1Fuji8HR1pfBfHDfAGbTol1sJEIRqc150k5rrasMu6JQEpIwElkkxo4X3Kg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYPzeen3eURHuUUYW0ehSaksnomgjYEaW+6zNIcaySY=;
 b=ueKRsHuSVuSWI0j8Yi/NSrX+JA3ozLcyL2kGKTfVqVTOUjjni8PISeZ+TpLBwjtK9xYiB+68HpOzu3tMIstxZkm1atmfIbRdiKV06B02WTA0+BSJzJS03sTU2Ev3tFEQHOQsWYMb3MtOgWZgbwjb31yTiSPCTpjOqDG8hA7lU66ycCAh4Yx/pc2xXNuHyQmdxWbOgT+al5MOCh130gZPlyiVKXgJTmiGwADCKLdvP4fQ2vVX0jlVZsMDmK/4ooOIVWyYLKQjOLFOT9VQQGhOY0bt7fpFEO22nIj5EnCuzkin3kdwFYsoRhbAHun4JTCYSH8jnVeDSheoglq8ikMgiQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYPzeen3eURHuUUYW0ehSaksnomgjYEaW+6zNIcaySY=;
 b=VF6q9a/Ar2FfX9P26OQdJJqCSRy5Y6YxbMy3BEdNhfbfsE9kmRrgcKPFUitjg/2SZaCtZutsDRmhzDPuIe6s39MqCVpHABu9M4tgrgUzgxCnrJXTkRJkdp+shY8sRnH5SN602/5ElyMNFnoBZqn2Z3SamnSBVYg9FrsY/qUHzgE=
Received: from DB9PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:10:1da::23)
 by DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 15:39:25 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::55) by DB9PR05CA0018.outlook.office365.com
 (2603:10a6:10:1da::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 15:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sun, 8 Feb 2026 15:39:25 +0000
Received: from emails-2588000-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-47.eu-west-1.compute.internal [10.20.5.47])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 87C0580066;
	Sun,  8 Feb 2026 15:39:25 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770565165; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=sYPzeen3eURHuUUYW0ehSaksnomgjYEaW+6zNIcaySY=;
 b=qp66Ym6I6fxabG1lnl5nmdaHrYg2hc3w4lsxYfvbn9VHSnN4X7Rshsk5Vg4FWYoXSlLeX
 F/yUqqodFTJGbPn/QdYSPwyuOIOHe/annAYtHCz9Vj9X5WRhTckCMgNeSKq+0R9bHgkmMN1
 utfPCCWqmG5N8SJqvmIerxa0YkzOFNk=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770565165;
 b=FgMIiGMwFq5rT3imaN6V1NOcVR6+URwOh/tL5ojcqMYlLFRI5rqXrTU2x1Ul6Xvq7riGX
 euNkbP1Ilroi2YhUyiEUh6VJ1C2yQM6EBekPmCDG6ZwZYoK0bQQgIVetUFocJzCDEIrfkIq
 Ut90BXIIcIdc4ggqCxqd0GSXMrtztv0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOMZxJbarRwHR0DTH+bWz5z/Wz7Iwo0s7JLPUOGrWHmz07VZidgrg++65zn4cLK74I5DCq2H3qzM61YAHCfUeBI8Dt9TidWXKJqEUx5USY9r6pitrWt6KVu78afswNYBxWngSXkbYs/3eZVbSlO5E9gGoD7MlMovE/z+7g2xzNo+dPl0g1xRdgmc9PbQmKK3U118AeHM9MfkiFAdvBXAhoQHuDmGu2BGCvq+tQKG8l2gh2JpJYpo/SLKlWD66OAE++o3eEByvvrzPwrPBrJe81cpXxhBytVYeUYEUmjYRLLdurekWf08JH2x2bQVhSy3IVB54igrqY77HPCKS96SeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYPzeen3eURHuUUYW0ehSaksnomgjYEaW+6zNIcaySY=;
 b=UKz1um4id8ip6M5/ar4Qrwvh2hB2GFg8PBRoPqh2pi1Hj/4LLalJj8eztrLJh5qR6xSmVJdSS/Wdh0uEmTbdQaD8I+iuFDpr78BcT/T2GXGZORFWQcj/GXt/vchuPF3wNM/aVbRY/JC89D2qePF/X0M79C442c4lIZC8nBUf62nf4k0XEgyHDPdBpWxwGWSuypZY1iKv95jSQARRd61CxqFhvTEHD4IcfvItt5JiPfcgxm/50lU1hdmF0yt8RpT6CjVb/yYp3jiLBZCqMFf9zOM973TZcU3lHBQO6E+fUlETHY/mo8GywAT7zzuMQgxLi8bsxAjp8OWq2Ye7pL93cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYPzeen3eURHuUUYW0ehSaksnomgjYEaW+6zNIcaySY=;
 b=VF6q9a/Ar2FfX9P26OQdJJqCSRy5Y6YxbMy3BEdNhfbfsE9kmRrgcKPFUitjg/2SZaCtZutsDRmhzDPuIe6s39MqCVpHABu9M4tgrgUzgxCnrJXTkRJkdp+shY8sRnH5SN602/5ElyMNFnoBZqn2Z3SamnSBVYg9FrsY/qUHzgE=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 15:39:14 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 15:39:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 08 Feb 2026 17:38:59 +0200
Subject: [PATCH v9 4/7] phy: can-transceiver: drop temporary helper getting
 optional mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-rz-sdio-mux-v9-4-9a3be13c1280@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
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
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PAXPR04MB9074:EE_|DB1PEPF000509F9:EE_|DB9PR04MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3a873e-5cee-454e-1425-08de67283d42
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|7053199007|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VllIVXNXZGp3Mnh2Wm1HU3pua3RvTitUNXVTaW5naitTS29Sd2FKbFMwL0RS?=
 =?utf-8?B?YjFlWjRhV0RSZ0NleTZqNE5HbXg1YnRhQ2p6TGJIWjJlN1V5YnVWQkMrQU1K?=
 =?utf-8?B?MnlrNGpiZyszSzJwSE5hYjNKZ281a1g1S3RUdDdXOU1weVc4SnZQS0tMZmdH?=
 =?utf-8?B?ZkFOUFlURmU2RWdzWnVXM3l3dmJyWjUvY3d3U2RIUG1TSUJEVlFWais3RGNy?=
 =?utf-8?B?ejIyRjd5bHVGQlBqbFo4T0VaYUpOUDJhUGhob3UvckRtR3VjVDdGTkgyZ1RJ?=
 =?utf-8?B?VC9IN3NGR0s4cXFKOXJWOXBxeis5clMrczhGNVRpd2VsZUw4QmFiRDg0THEr?=
 =?utf-8?B?NDdNeEFaNG84Qjg0a09jaHM5S0JFb0ZheTRldzdVUGVwU3dWdG1OUjlZM0hv?=
 =?utf-8?B?R1VhcjhZeFRBRkpnaGczQytZQlFmNXl5Z29Nc09QbXl1dE95UjdrRDRHaVJ0?=
 =?utf-8?B?b2hhQ0oyaTJlZUtJTFVhVzBhZzZtWUM4ZzRYajF1WVdaRkhtbFlKVkwxb1ZV?=
 =?utf-8?B?VlZ1RWZ3RjhYN084T1FuTkZ4WWFuZDE1WHNCWlB3MXNrUWdCOFVWOFVJYVJI?=
 =?utf-8?B?bkRGZTFxKy9TdzJuTkREWVR3MVVhTWlWTG9QN2VhdHBqcVRGajNjRk5WWXBk?=
 =?utf-8?B?YVZXSWx2NFFqeFMycXZyeWxRbWU2dU9OZ3dxaVlWend5Y2RyalRnYW1xOW9l?=
 =?utf-8?B?VE9YTVpkUHFyR0tCdWZUZjNDOXdGWmRFa2xDdHAvdWpOTFJyam9mcURBTTJM?=
 =?utf-8?B?NFhuYjMrU1RsUCtEVURJR2d1SVJmeHB0UUI0ZkgyR3paWVZBcW9ZLytTQTZZ?=
 =?utf-8?B?S29KWkhtTDViY2NISHZpdnZmdytqSmNQOFA5ZDNKeGx2QkFUME5uZkxzb2JV?=
 =?utf-8?B?eTlEUFlVd01zT2dhY3p6enROMkgxcC9UWVlPT2JYT0s1VjV0MmZrZU5DbUM2?=
 =?utf-8?B?NGVGVXl2NFNFWTdVWW4rRCs1RjFicnRiL0QxREtETmVVMkRNcG5LTlpxOEZv?=
 =?utf-8?B?V1UrRks2TGpCOTROaXRzdXoydU9kQlRPZ3pocW5YWThKM2xqMC9CMTJId2hz?=
 =?utf-8?B?bmZlRVZSK0dhRlhzNjkrdnlQdjc4b3Y4YXh0VDkwb2FLNXYzZlN2OFFmQjFt?=
 =?utf-8?B?ZjN4dDhscXo3VHNURUswTEZXeHR6cWxFM2FJelJOL0ZrK0hxbnIzY3NRTStU?=
 =?utf-8?B?VzdZSTdncVAvNkN3L1cvWlk2TEE4dWJZSFFMaFpDT2YzZVBxWHJ1Z0tBZjdP?=
 =?utf-8?B?WDF1MXBQMHUxYmFpWklockhhRnNMTjFxQXdOdEhjK0xNeHhHWjVNOFhwNXBQ?=
 =?utf-8?B?aGFGZTNpazFzdGVIbEFpODUyNjRzUjIrcUlQaTNNaU5xQU5pRVkwZ3JmbTlZ?=
 =?utf-8?B?b045NFFSa09wNVcrcE9WNldnZ3RncXUvR0FWYS9VdjZBcmVzbTFZTDdUNit6?=
 =?utf-8?B?NkFmbjl0dUxZbXpOdGFhaVJ4Q0J1aXN4bE1lNmxKSmFCT1dTcEFhcjR0NmZV?=
 =?utf-8?B?cm9LaFcxcTByNDVFTWYyQW8zRWtNS00vMUxLQlREVStpemY4QXprOEEzK01p?=
 =?utf-8?B?Y3N1TFdZMEt0c2F3bjJsZ1J3Ri9kRHZGMTZ3WWJxa2hsdlpISllkV0J5RXox?=
 =?utf-8?B?OU90YmM2dW1TZWl1dmJDQkJjVmRGY0ZWelYyUzBzbjR5b2lZK3U5T3VMQkgx?=
 =?utf-8?B?Yyt0bTdHZkNiVnl3M0YxZHZCdGZaMW5HcHRWcFFWeFE4ViswTGt1RXFsVUN4?=
 =?utf-8?B?Y0JiVlVqaTJxTWJMOENVRkJjSEo0cVRRYzhYN2xxNHJLVVI2Mmtjc0Rsd2py?=
 =?utf-8?B?VVMzWDhpMDZPdm5aYkZXRTdJSFhwSVJQQ0JiL1ByTy81dXg5eER0bkVTdXlN?=
 =?utf-8?B?cWh3a1hiN0hUa1d5d0hZU2NQMitzN0UyZ1A5VWZmMjBtSkp1aTVXWm81UUdR?=
 =?utf-8?B?WEt6cUlXREU4NTFZV0RBeVI0VG5UU3lKRDVMaUVabWQxdjZjcFIrNUVyV2dy?=
 =?utf-8?B?UG1ESnJzbWVRb0hnblhob09kZWN3aEQ1dHkyS0d1S00wYll1a3lDVGtneHZ5?=
 =?utf-8?B?WXpydzlURE9Qby9VaWRVcFNHZ2pJK09NWForWDlqTU5zTWM1aVNoZThhSVRR?=
 =?utf-8?B?OSswMUxMU1FodENMRVoxN21QU2lpRVVKOWpuWUh1NUs3NENKWU9hdHoyVEhs?=
 =?utf-8?Q?bR+74P8c9GEjO2C9AoWZZa6BqUhRzB6pYDBXsfM0NLYq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(7053199007)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 5499b0a1837f4470aced8b5970d38a33:solidrun,office365_emails,sent,inline:12b0fcb10f4278561484c091dce66039
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	70a0d91e-729b-4b97-1f40-08de67283648
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|14060799003|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnJBczVTSEtveFo0MHVSUHo3aC9xaEM4ZVdQaERsSUFFQzVNQWI2bjFxL0N2?=
 =?utf-8?B?RUNrTU5zQWg1cG80MTNwSEpoRFgyenBUNWZSQXgwNDRMbGNCNEtCNVNRaWRj?=
 =?utf-8?B?Q2t2NHJ4NmZTUkJiVkdDN3dmdGpXWUV6TEdQR0d1bSs1ZDNWWHFaSE9Tck94?=
 =?utf-8?B?MHhUOEp2eDBkcGRML09Famt5RC9zZUdvV2pWY3pYZ1QydlhySHBxTDZNcS9G?=
 =?utf-8?B?OU4yMjUrSmpJdVczVDBteHVtb3dmM29sWWVEZERVYzk4VUVLdEZNaGJzY2Uz?=
 =?utf-8?B?M3lRSTVkd0pad1ZJSjNBRHNoZjlBQXRxZFU5YWUySDdDaGZuVlRnYWVQQ240?=
 =?utf-8?B?eThreVVnTHVXRmltTnBTeTVWY3B1WTB1Z2UyY3VHVUZnOVR5emtaVXgwUFEv?=
 =?utf-8?B?Z2R3Y040VFdEZGNORUEvNGJ0dzcwd0xBTzc3Qy9TSzkxQVdKQk50bkJ0c2Uz?=
 =?utf-8?B?eEhNQmcrK0NjQU9PRU1kSDIySzhxUC9venZuQU92VDloQm9RbGxhdVRPaCt4?=
 =?utf-8?B?eFhxMGtwSGRhUG1kUVU4amRjUm1iVktkb1VOQjRMNDUxTlRZUGl0OXh1NWUx?=
 =?utf-8?B?SHRKVFpWeGxRYkpIQjQxTWpVVCtqOVVremdEL203WHFsVkZsTTY1M1hSMVRw?=
 =?utf-8?B?Vnpqc2RBTDZ1bnk2NUlYakJkKzc4RmhzLzBuOGtkcGRvNTdBVW02V3hYVVZW?=
 =?utf-8?B?OXNyeTVaelc1K1pacGdRdUVGRjlLMWpxNGJyaEFKOHRqNklkNVlvcU16cHpO?=
 =?utf-8?B?czE1WG53U0E1Y1QrL1BLSHZvQmNvVjdGMyticStGME4xSmh4WWFOOUZHTEJx?=
 =?utf-8?B?REViUDViRXFvTVNsbVZwTVI4cklUSUhJOVFoaDN1YWNPSGdzZSt3UlAwOXRU?=
 =?utf-8?B?T2FReTVHSnlZQ1NuWWNuZCtEbmEwdFI0VjRmYmtBa09wSkVvQzZnMFJ2RGRN?=
 =?utf-8?B?TU5yVnJTa0p3dTFsNmJvQko4VDhrRWpMcFFQQUx0U1R1M1AvcjBhaWNOZmJG?=
 =?utf-8?B?NkduNVJnNTF6dWRuQkpqT2xwNmw5Tks2OEEraXNyMGdWVytyb3pGMndjQ25M?=
 =?utf-8?B?MjYrOS81WDdWSnc5cU9hRUhxdUNsbG84N3l6c1k5WTV2dFltMEZ6dThFa04x?=
 =?utf-8?B?VXk2a05rMmY2M3FMM3VxTFJSbzNpS2graGlRdGJKbkNESDcxb2pENHpaNFNq?=
 =?utf-8?B?Wk10NUJ1aXZZaXFjMXRwNTZOZHdwK0xUUkpRWFo3Qkoza0t4R1lvclBqOGh5?=
 =?utf-8?B?UEU5Q2ltaUR0OWtqRTN6WGZzbW0vWmpwaU40cTd1Q0IrV0VNRCt0dmhUQkli?=
 =?utf-8?B?MTlGSVRYOVVQV3c4bFJWb2tPcWhlOGNNMXdDaVZ1L2c2c3hZR2FVWE9YVkdq?=
 =?utf-8?B?T2ZoajNPRm96TUlINHQvNFVRNkN5Sk82ZDdsWUthTElrRjZqYkY5bGtXY1Bu?=
 =?utf-8?B?bEpmY3dsemxBYWZhcUNsOUUyM1E0OG90TVNyeC9YYXkreUNCeGFia2NkYmJF?=
 =?utf-8?B?dGR5L3NDVzRTcW04YU5pZ0F2WGo5aVlIeWZuTW53eXIzWlhVMEZKazA0M3FK?=
 =?utf-8?B?TW1xT0tydXcxci9qZ0hIU1o0RUZTQzd0a3VmUmdvVU1mQTBWcjRYQkZobFNT?=
 =?utf-8?B?dzZ3Qy82TnYrcWVKUlYxUzIzZkJpZDdqUWJoQ3ppY3dweTlMMURuN0VuNjdr?=
 =?utf-8?B?L2c3SlBWMS9pUC9nWmRHMkhOajV3N0ZkSjl6d2RVdWc2VWZUWURDclpTTkRY?=
 =?utf-8?B?QkI1WkJQYTA4VFZwOWtScmRQUHdjNlJybDNMaHU4TExVYnNzbU1TVWYvc3Bh?=
 =?utf-8?B?ZkRvMDdmbmI4UE1QUWRmTllCd2x5NGl1b2N1TklaK05WRzNnbXB5bGkvZzc1?=
 =?utf-8?B?alhaWVlLMDlpdEkwQTVnUWxmVERCM0lRL3JKNk1CU0VpMncyTDJrS2NCeU1w?=
 =?utf-8?B?T0pjUUlENitreS80cjkvcmZISkIxMDM4MVZaSFV5YXB6ajF0V25nT2lmZkRr?=
 =?utf-8?B?UGNkR0psMzZBV3FZQ3d0bFJaaGZuazh6ZFBKMmZuejNVZWx4MTNnQzVEMzBC?=
 =?utf-8?B?dnhiTU9tZTkwWVhZVmljaHV2UWFCVklYUWdEYWR2RjU1anZVRW9ZSEdDSjRI?=
 =?utf-8?B?WlhvOHhiS2dURlpudFh2eHg4UiszUkUzMEovKzBpajhubWpNeXVUTk5mM2VT?=
 =?utf-8?B?THVyNEhVVzFhMWdwWGtkYkQ1bWFVMkNRc1dYZ0NQVnBLcFg1YU44MTNLbGtR?=
 =?utf-8?Q?uzextjm72R79hZfdAsaW3LcY28HIofGcwwhZ1yci8k=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(14060799003)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fXnaRWYGVh9fKfNL6OVMkJrB2iaGOzosBhO1yKfxu4G6UxALeHeRuraq73R82hmqAOFRfWuVlUBHexrT8+YnrxxgB+tb2iJvAw4EK3ipSjTV2HoCJOKQNlIU6hE4VkPlWAXSFL6u/sVo1JRdFATT4bmL1ZyCP4HnG9i/rjop++mjZnq9pN4e8wCjSaxWxsVkVaVryvuCcEmS++KN092fB+DeCevk6ZgIRh3JeIsvAlyXLLiDaCKr5MbCFuGyc6PdJSZIVNrI4UUwrbh3EG62EydxwNmwiNEzO5Vw1ShPgFbqzy4tqfzp2LTfr91PlbAP16YcEVJQ2cQG1w8DTAVArhSgbzJtizcfCwMseZ7DRXOROmBuaHorCNzrHKmhml3/+AqYrcSV37aOHiQjoYAUFJN+pJZp4oPG2dHdYsyL9+IgbrUArIjYo/OGpeItGH89
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 15:39:25.6857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3a873e-5cee-454e-1425-08de67283d42
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6506-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,sang-engineering.com:email,solidrn.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0A3E110942C
X-Rspamd-Action: no action

Multiplexer subsystem has now added helpers for getting managed optional
mux-state.

Switch to the new devm_mux_state_get_optional helper.

This change is only compile-tested.

Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/phy/phy-can-transceiver.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 81591d247128..2b52e47f247a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -126,16 +126,6 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 
-/* Temporary wrapper until the multiplexer subsystem supports optional muxes */
-static inline struct mux_state *
-temp_devm_mux_state_get_optional(struct device *dev, const char *mux_name)
-{
-	if (!of_property_present(dev->of_node, "mux-states"))
-		return NULL;
-
-	return devm_mux_state_get(dev, mux_name);
-}
-
 static struct phy *can_transceiver_phy_xlate(struct device *dev,
 					     const struct of_phandle_args *args)
 {
@@ -183,7 +173,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	priv->num_ch = num_ch;
 	platform_set_drvdata(pdev, priv);
 
-	mux_state = temp_devm_mux_state_get_optional(dev, NULL);
+	mux_state = devm_mux_state_get_optional(dev, NULL);
 	if (IS_ERR(mux_state))
 		return PTR_ERR(mux_state);
 

-- 
2.43.0



