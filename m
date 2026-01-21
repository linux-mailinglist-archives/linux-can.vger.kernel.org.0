Return-Path: <linux-can+bounces-6238-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILrtFMKccGlyYgAAu9opvQ
	(envelope-from <linux-can+bounces-6238-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:30:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D32546A7
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01F055C2905
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B33547B41F;
	Wed, 21 Jan 2026 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iSOkrSEl";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iSOkrSEl"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021076.outbound.protection.outlook.com [40.107.130.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688523803D1;
	Wed, 21 Jan 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.76
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987269; cv=fail; b=Te+CNEouIvZhv09lqu5rOIBdyTzDxw+T2GsJ9lhJrgYOugbfGz0VP6+ADjqbQiP7PnnibMxdwTo+mQ0qQ1ZQn9I56dqr8l7r8c6nQME1igfBib0cFEyJUy9zI6Y3exV8euyHO0wJaxq09xIrX69gYeQmLCEjp5Cy0iuV2hbRcck=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987269; c=relaxed/simple;
	bh=4NbwPUNfj1FWUvwb3462sVTi2Tufr3U4X61Pr+4OYOs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Z4qL5BjrU/YZaVS9qSDl8lWhUWcGvhvnOMzvRX8+fm3RKcQPr2i9S8NJC3jCXRoox1bRhuezsodReY1vncqaYxKELOxGJwBQLQICL6d9YR87yzkBmh5z8JU/mZvMZBV0XYBDa//IrdDkVvn6OsQMBuroaitPle0nohLPZp3SGts=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=iSOkrSEl; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=iSOkrSEl; arc=fail smtp.client-ip=40.107.130.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=c1anMxeUKCJlYTBmc/43NZT7NVl7NmZlCe2FgyJsFashGX2atZn9kF0sxcE83b+VgF1aBNo2Pc2O6X/S0hE4d61yda3QBXIUDeb+BCgbklzJ2p3lHCZOL0QeJzAVTSgPYWqBE1UiwsD/c2bC6j7Dias0DgNqrzlE8ZHTgOuBh6h/+Qb4B1y1rlDDTT+kCSTrGNIxqW9+uFCVpQOLoqx245lAVMwzZmgOy8plybOtMqd3YktZEL1/0Darm/VDH+b398MRYpuoCmbVG09rvJz2xgGMM+BtrcA58hGFaHY0gFy/JUR2IZpqwOUiIvjbBX0PJejApKfWf4z0h2gnFJi0Lg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEcXnvX/OlK1x0Rcb6I/5vVi2Z34yjEhiPYtP6vvA+0=;
 b=Wn2qG+sq9QNsHx2+XYkMsHEhHuTuedxAtLlm/VoqyxedjFrHhDrivo7oe+L9fw5F0ebTuCGxkZioyvJ9x+/uet0P+P4KkGr7/Dctn8CME1dGJa+P1DIQeRJIj3aTcHrsz67CttomvCkcJEeM66qJC014LvGU/XeXyzcDvt6XPGLhOccMOBa31kf2s9XOTF7vh+xc4n2+VLWKej8Zv3tG/bdtgwD1io2UsVH5p4LAJAvX6HcxTve/4rySEdL+MI7X6GwxXm3KPv3theC9syCzgmsGXIOm2ioSdX0lfzyWmKwLPqJJ7N3y7PWmaHFIz6iNC7XT8STDlr/1RJtVSkm/Pw==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEcXnvX/OlK1x0Rcb6I/5vVi2Z34yjEhiPYtP6vvA+0=;
 b=iSOkrSElcKx0V9aSloU3iUaMbsBhZKEMRC5SQt40Gs+Hbqqgp0CsIsaDezmrWr8TBmJ1nfajJu4fMjdNsAe7olz16iEZohAYplo9aItM/7cqLgfJNMEVKoTIv+Zj3DAAXqWIAtSVUKqrpfdxRR5Vy1h+udGx8msZs+VFpeFCHoI=
Received: from DU6P191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::15)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:21:02 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::b3) by DU6P191CA0040.outlook.office365.com
 (2603:10a6:10:53f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 09:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Wed, 21 Jan 2026 09:21:01 +0000
Received: from emails-8668735-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-30.eu-west-1.compute.internal [10.20.6.30])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id B94FD8061D;
	Wed, 21 Jan 2026 09:21:01 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768987261; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=pEcXnvX/OlK1x0Rcb6I/5vVi2Z34yjEhiPYtP6vvA+0=;
 b=eClNLC32UDTlhZNFN00OxLhkWnBvTGlcYza6CFJDJN+yC6zphraG8X6ZwOWhy23VeMz2v
 9Gqq6V5laI2Qs3ifU8ijwJ/5C9JeWgdH4dvQEbbCclQRNZYxR1GeGASkIYVAy0PhcFVqudl
 JzQxtnPLvkQOPSasKKCF4jiZxXWiEZI=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768987261;
 b=MAoQPc6aDyALGdbqsefS9EjyIEBUIQgtAP2XfgZyReMxbroe0Ycf0oKAY4ekaOSIk1ffo
 nFjayC/FgJq65PThQG772pV0hDT79xIvGc8+jndFq5ZeCjUmBHp79PBESdeO7RhwGtSQx3s
 csszNLzjcX6C1+7A/dymxiyVFhj+Ypk=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtHbmFQENPt4oF62OWX9pT6QaKERoa9Ruivh/AGrnLMExQWPaRDvtC/EiDerhQ3LudyVNtvXebVr76xU6qjwNiPWvq3inkBKiu1MxRdQOMFjSZtb7huOto0AVUMKDuzooypQXUU30/qmhwMUhwU2VpmAQUBfHxIqrMeeB3vkrdnOqSIs1psHGSV18GTUDltk9FeNQ7cWclOgjn8ww0C4NdaoIUqUHkSwl+XeEoJXJpRzDax5ZPimSfShvPidn9uPDVfSUK3wV2sa8MJDPIeb6Dl4rKTrBw6yZvClltenUdsFKEH96bOyhFEJ18nrN5Qc2MvO0TWBesPNF/zTPrS9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEcXnvX/OlK1x0Rcb6I/5vVi2Z34yjEhiPYtP6vvA+0=;
 b=ipeHUYyFVtclV/6iVvfKS4ciUYsQf+oqqMl1qWjheA6W2Li+1LsC7aaG2PmLEXNjqXAfCdC6UWRjFkLoRRQszUgUBLZ9R7Hj7egHVCLh8v920+bD+d/Lrbhf5OXNTVgBneMRVihmfC0tsmUlcnTkR6uTxvm6TraPaxsAV3YMNyt0XWkJSb8U/gD+XGUCD39deH2NOoS1cfapNzm5NWX2UfoSdZ2wtHCrpFbcOoJKhs8S5eVhROpb9e/UdaCkQazlMsmaodRivGSIhCXETZmVe8wQDA5rSSRFGemADhcScNmFz17boA8mUmMd8LILAAUTVwifwBVdOAkhxkeUrFan3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEcXnvX/OlK1x0Rcb6I/5vVi2Z34yjEhiPYtP6vvA+0=;
 b=iSOkrSElcKx0V9aSloU3iUaMbsBhZKEMRC5SQt40Gs+Hbqqgp0CsIsaDezmrWr8TBmJ1nfajJu4fMjdNsAe7olz16iEZohAYplo9aItM/7cqLgfJNMEVKoTIv+Zj3DAAXqWIAtSVUKqrpfdxRR5Vy1h+udGx8msZs+VFpeFCHoI=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:20:50 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:20:50 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v6 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Date: Wed, 21 Jan 2026 11:20:37 +0200
Message-Id: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWacGkC/23OwWrDMAzG8VcpPs9DsmtF22nvUXpwLGc1rPGw1
 9Ct5N3nFsbakOMn+P3RRdVYUqzqdXNRJU6ppjy2QU8bFQ5+fI86SdvKgHGIhnX50VVS1sfTWfs
 QHNpuQEJWTXyWOKTzrbbbt31I9SuX71t8wut1vTOhBo1RokUWJBjeav5IostpfA75qK6tyfx7A
 /joTfN96B1jzyzSrXl75xEevW0+eDIsvSMhWPPbP0+AsPh/2/yLeAJCP7APa97deVx417wNtov
 MnSG2Sz/P8y+HnC2LqgEAAA==
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
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7436:EE_|DB1PEPF000509F1:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd2ebd5-addc-4d4c-5492-08de58ce6550
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Q0xVam4wR09CRUVubVh5UUJCeE0rYThaRjZKS29qZmhweTdsb2dxNEdZTmdB?=
 =?utf-8?B?Qzl2UkI4Nm9Gb0hsdmNSYjdBY0lmaVlMU3R4eTNobDlNWVhQRnZXcjVFOGFS?=
 =?utf-8?B?bGJ6TC94K2ViRVpZTENqVy9UNU1NN0hTNzhpTHJHOGkrVEdjVmpQUERaTTZ6?=
 =?utf-8?B?SnF4dmJuaG43blIwNkR1a3IreFlTM2JiSjRnL3YzeHVPaHRpVUZlTnVrTmFT?=
 =?utf-8?B?UUVJaGM0a0tmZS9IVG5GcnVtdWlLSmJtZGVXMDRtU3pzK3NoUURmWG9mTnN1?=
 =?utf-8?B?MHFyQXMvblQweFN6STEvcWZBcUFtT0ljdjkrbUhkZlFBWWVvdFdCSXh6OXov?=
 =?utf-8?B?Ujl5YmpGMGw2UzlFemg3a3FmQXNLV0d2SlplYlV1K295cTN6c0pHZGpvU2ow?=
 =?utf-8?B?anJ2WExXTllrOC8xYmlCYmJHaDdSaFUzSURCaTBkRDJnR3NIRFpYMXBuTUV6?=
 =?utf-8?B?WnRLN1FsRDhEWXRoT0Q3bnl6WkNCRjFYd2lac0dtRHNTWm9XaHMyVWtQNzh4?=
 =?utf-8?B?MEwzMEhucEE0dHRuT2EreDZyamppOTd2ZEFSYi9sUWdWenBQRDFPbS9QTTM4?=
 =?utf-8?B?eWo4YWpiVFlZRU1ibEtGQThxbXhSTHNJM09CUTJsSURMMjllWEJHZjVFYkJy?=
 =?utf-8?B?Y0xNbzFaOE84RkdWb2tVWDY5MGlQcjdZZ3dncXBvblZMcHovdm85VHlObUpO?=
 =?utf-8?B?SDNUbzNWdHhreWZ6ZnNQSTVJZlFubTJ3akhwcXFzVmNqNGZ5N0lYT0dINzNC?=
 =?utf-8?B?R2ROYlVrLytubXVkN3R2ekZvZjBLZnR3endQWEQzdUp4Z3FqT2tLU09Sc0JW?=
 =?utf-8?B?a3NmSG11R0ZvM2tORFFSQlhaQUYxUDY5cDY3V1Bhc3NaZkllL2JxRWdZellY?=
 =?utf-8?B?OGNrSUtmbW12VllTNUI3REg1alZtUWpkK0xTOFVXa0hrWDZ2L2JFWjdnM2Ny?=
 =?utf-8?B?V1pMYURRQ1Ivc05YTmtXSTFsZXNkU3ZRemxoZ285bkV2OUZMZVA4aXdFdVFj?=
 =?utf-8?B?dnBid2dWSVpmZTNra093K3R2c0wrY3p6YVVMdUxicXhIMm1DaFdxeU5iUTly?=
 =?utf-8?B?UTZYOElDZEZsZ0VDUmdOMnU2enJCampneHJraFAxcEdMbEt3a2ljOFVPcWV0?=
 =?utf-8?B?S3hnbHNES0lNeENHSXVVaElaVHlBZ0RJWGJYY0REUHFDVHZab1RMYWJQcDNJ?=
 =?utf-8?B?VHNUL2hyTUdCUTBoaUpTRUg3a1hOc3hRY0hnNVJBRmdrT01Qc3pjd1ppdmVZ?=
 =?utf-8?B?L2h4RXpaNGl1a3Y0bEdQNGs1b2dQeXl5ZWo4TWRRSFAwZG5YQWhCUkdxbGpE?=
 =?utf-8?B?YWtUQUNFZEY0bFhlV1l1VUlyTTI0YVRqRFBxSTQ3dmxhcXl0OGFMUUNubnZo?=
 =?utf-8?B?bjRVODNkMHZ3U2h3V2NJWVVoaCtYSHYxTVJnS0ZDQWVzUWRSY1RSYVBIclZV?=
 =?utf-8?B?QkRVdnhNVmdxMjUxbElkQ2phcDdOSWdyWmVNUUR4d05JUXRoMmN1aUFmVWls?=
 =?utf-8?B?UTJFVXQzVXNVTXlpSWIyTmhQYlVQaGdqL1VyQUhkYzZtaWplZW0yQVNvaHcy?=
 =?utf-8?B?ditNYlBnZlk1ZlpZWWdFKytiUFlsSkVSdlJuM3M0eFZNcE1PV0ZUWVdjYVhj?=
 =?utf-8?B?SjFPaWEvaFhpM2xJZHc0bGdEd0lwTDFMbnFiZ2krMlVVMnFLTVV0cGx0MWMw?=
 =?utf-8?B?KzRuU0FpT1BuUnJiUlBZekM5TFl0TlIvSjh1dVovbVJUMmdNK0Fia1NkNitS?=
 =?utf-8?B?Vk1oaWQ4S0MwZVRBVjVqLzhWVVhZelNmdmVBV01JblYwdDFac1FvbllrYjlR?=
 =?utf-8?B?aWtEaTYzWWIvOW5zbjdnSU15S3UzUGtmVS9TSUpQQlBLNmFiaFZtTGlSVExM?=
 =?utf-8?B?MzUrbDV2UVhpRWlmOU1WN0RnR2dZYkJ6N3RIcG95NHBFVllBYnFENktZd205?=
 =?utf-8?B?N3FTenYzTkJZOVpUMFMzcFFrWjZNMEg3b1NtakllbGR6QlhzNkhGZmhYWXls?=
 =?utf-8?B?bTFSNGhsVC9mUGhxb3lCM044T0o5cnhkYkNXcTFSK1h1ODdueHUwZFVId3M0?=
 =?utf-8?B?S2x4NFpEd0tYYy9Ccm5LY2JpS2cvYmZ5NjlEZ3FJNlZKbGhwNFNGWGhRaXdn?=
 =?utf-8?B?K0puS1BEWlV0Vmg2RVh2RTE0MDc0VGp1bjc3OW9wai9tbDdNbFlIR01LVkFo?=
 =?utf-8?Q?M/+4j2GV+43SSBldhsnb1td59moiccWhR5PC7fjJvu3s?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 6bcb0b1ac86649969d80275ef1df3560:solidrun,office365_emails,sent,inline:8406f9cb3e46051fa2a59ad8ba71cfe5
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5abd751e-fb5f-4d3c-5fc5-08de58ce5dd8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWhKbDR1eTdvZ1VRRDZiTDRvWTNmMlpOZXYxeTNCbENWbllta0tNVmhtcWRY?=
 =?utf-8?B?UytiaFE2TlMzMkU1UlE2TElSQnlFdjAvVWgxSXZzTGFPMS85YzZrVStEQ3A4?=
 =?utf-8?B?WFh6UVRSOTM5VVorM1huTWlMVXZVdVE0TnZVV1M3cG1NUDEyd0NDT1F2MmRS?=
 =?utf-8?B?cnB1WWZvN3d4alpaNWk2aFdqeW9GZ0lRNHZ0QUZMR3dnVnlidHVFVUxHM0xv?=
 =?utf-8?B?OGdoMFoyS1lqMVlTZ0RORnNTRTN5NTc1QU1idlZqSTlyb0lCNWJUcndHbkpk?=
 =?utf-8?B?dVpva0cwRFc2c1EzU0tYNkYvYnJaejRLdWJEMGRwME10T2xEYjl5WENzZ2Jn?=
 =?utf-8?B?TDN2d05WVFMxd29RL0wwRWhVdnhZeVRNRTFRcmZnQWV4OVpjVTlGNFozMjk0?=
 =?utf-8?B?S0U4ekMvK25nR1ZCS20rWnR3R2hTMjUyclBuR0lDZUZPV0J0R3E4R3Y0NElt?=
 =?utf-8?B?MzlSMlNMdXBXb0E1RjJ3TEJnVzArZFB5MHZLWFNZSGY1UzJma3lRbFJqQjhI?=
 =?utf-8?B?OThZcVplRFY1dWhjeEIwR21BNnMrVUowb3dNbU4vTzVDM2dDUDlZRlNzMlYv?=
 =?utf-8?B?bkkzYzlNYlV5T2M0SXl0b1hReFBlVXVOczBMdU1nOENGUEE2alRaUTE5YXNU?=
 =?utf-8?B?TTJRajBsNFhCWUF3RlUrM3BoazRwMDAzVkNWLzU2SFFYTFlXdUh3OFBwcExl?=
 =?utf-8?B?ZzZ2UUorMzZGS1lJQUtiaGNUTlRtdTBpUmJ0WjhVQ2NmbFRQd0dYZm43aVo0?=
 =?utf-8?B?T1hLSzRwMituVS9CTXFUVkNpRjhlQ09XRUJCR04wRlBac2VrNFpFSGE3ekYv?=
 =?utf-8?B?V1lEWHhOQnBWYUdOZGJNb3ZITGNGb0JSZVM1V1k1YTBiZ2lpbzRweWwxdWpB?=
 =?utf-8?B?ckZUMTROd1o0K2JQQ1R4dXVOeVZwZ05rYk9TTlVSRStvTndaR3NOeG5kWnZo?=
 =?utf-8?B?MkV4d1FpVnJqTDFKd2kva204V0dkWXBEWk8vdmozUVR3WERoVVdDVXErVkJT?=
 =?utf-8?B?NUVjeG9SeXVobnlwSm5iaENrZkxUYUNwYWdtR2pGZmtKUmV4cUpXZXhNdjVw?=
 =?utf-8?B?VzdkNWFHTTdNREx1M2pNR09IRUtoZUs4Q2tTQittbUxCOGJKeHcxQVlkbmlW?=
 =?utf-8?B?UHExRmIwWGJuQml4amFLMmU1azFKSlZKUlZWcDI1N0xVS2NMOUs3TldDNHU0?=
 =?utf-8?B?VVoyVFF4MnQ2SHR2bmZla01kcXN1V1Z5cXhLRlNzcG4yWWhMeU1qUHg0ajZL?=
 =?utf-8?B?U0w0V3IwL05GSDY2bUxkVkMxVlIwVjdpU2dHWHh4L1Ixcy93Ri9BeGxDTjRO?=
 =?utf-8?B?bjVUVlVabk91QjFoRTFrNHo5VUhReDIwSzlRdk15aDYrZGplYk1NMW5RSmFk?=
 =?utf-8?B?UHg5cjV3ZGxkcGZIMEM1WmV4VndxbVlQekdienl1Vi9LRVJLWDFEblM3bkE2?=
 =?utf-8?B?YVpCZWs0SFpWMzB5ZnhiU2p5aEsyUEtoTG9zZ2hyM295L0U2cUZ3bDlETDFK?=
 =?utf-8?B?V09ZY0d6ZUpSdmJXV0JyZjg3WTRSd0ZjWHJpb0ZKb3Y2RFdEWDB5TVY0ZE51?=
 =?utf-8?B?ejlGOUt2a1FzR2tUYURmM2wzZU41bmd4WTVtck9LRXlWSmhTazI1VUg3bkpo?=
 =?utf-8?B?YXZqNDNDQU5uNWpjQjZZa05pbHh6bnhHZUFqS2FzL1ZVODYwM09MQVNTRnhJ?=
 =?utf-8?B?SlBoWTdSY3ZpdDQ5cTZtcW40ODQxNEhXWXRQUzlwMDNxbU1LV1E0NkY1OWxs?=
 =?utf-8?B?d04vNjNlWENWTGI4czF5STdla0I0dCtRSEYwREJiZi90bnRHcWhRa1c5Rjk5?=
 =?utf-8?B?S3ppaHFsUG1VcjgxdUpuSkNvcWxuK1lkRFo0aGkyQjBITEZMNVBielVVakdu?=
 =?utf-8?B?dm1vZEFtWTMxSWlFQzhNWHE0WDJiYWhMWU5wU0RWcFV4eFFJQnZTK3hmQjNI?=
 =?utf-8?B?ajZsRkkybkZEbFhHUzcwVVZHQlcxc1ZSOXloSGRFT1YwNjBsbEx2ZmpqRWNX?=
 =?utf-8?B?VFNueDlkeFYzaDJrKzExMUlkeHVNdGVqcmZZQ1p0UFYrZFgveU5DaFR1amI3?=
 =?utf-8?B?SE1naDFtVkc3b0Z4Q05UZmlUbWVINWhhM0cvY0ErWER3S2FnNkhBU2FnZ1NI?=
 =?utf-8?B?NERxa2JVVXNpZEFya0ZLVU0rVDhjVGJxT0g5a1IxY3UxT293UTg1RFF5R25a?=
 =?utf-8?B?eEpmeHNCdXFIb2N5V0hSZDhKek93cm5UbnZWZzFvNXp0K1ppSFRYakV5anJa?=
 =?utf-8?Q?e5Rb2sOBxGipIbE8Hs76TosQ81u+TlnoOIT/oiBhyA=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:21:01.9016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2ebd5-addc-4d4c-5492-08de58ce6550
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : No valid SPF, DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6238-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux-m68k.org:email,solid-run.com:email,solid-run.com:mid,linaro.org:email,solidrn.onmicrosoft.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,sang-engineering.com:email];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E8D32546A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some Renesas SoC based boards mux SD and eMMC on a single sdio
controller, exposing user control by dip switch and software control by
gpio.

Purpose is to simplify development and provisioning by selecting boot
media at power-on, and again before starting linux.

Add binding and driver support for linking a (gpio) mux to renesas sdio
controller.

Introduce generic helper functions for getting managed and selected
mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v6:
- replaced /* with /** for devm_mux_state_state function description.
- collected review tags.
- fixed checkpatch warnings (space-before-tab, void-return).
  (Reported-by: Geert Uytterhoeven)
- fixed use-after-free in mux core mux_get function.
  (Reported-by: Geert Uytterhoeven)
- fix mux helper error path uninitialised return code variable.
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com

Changes in v5:
- implemented automatic mux deselect for devm_*_selected.
  (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
- because of semantic changes I dropped reviewed and acks from omap-i2c
  patch (Andreas Kemnade / Wolfram Sang).
- fix invalid return value in void function for mux helper stubs
  (Reported-by: kernel test robot <lkp@intel.com>)
- Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com

Changes in v4:
- added MULTIPLEXER Kconfig help text.
- removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
  not required for all devices using this driver.
- added stubs for all symbols exported by mux core.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- refactored mux core logic to silence ENOENT errors only on optional
  code paths, keeping error printing unchanged otherwise.
  (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
- picked up various reviewed- and acked-by tags
- Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com

Changes in v3:
- updated omap-i2c and phy-can-transceiver to use new helpers.
- created generic helper functions for getting managed optional mux-state.
  (Reported-by: Rob Herring <robh@kernel.org>)
- picked up binding ack by Rob Herring.
- replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
  commit descriptions.
  (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
- Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com

Changes in v2:
- dropped mux-controller node from dt binding example
  (Reported-by: Conor Dooley <conor@kernel.org>
   Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
- Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com

---
Josua Mayer (7):
      phy: can-transceiver: rename temporary helper function to avoid conflict
      mux: Add helper functions for getting optional and selected mux-state
      mux: add help text for MULTIPLEXER config option
      phy: can-transceiver: drop temporary helper getting optional mux-state
      i2c: omap: switch to new generic helper for getting selected mux-state
      dt-bindings: mmc: renesas,sdhi: Add mux-states property
      mmc: host: renesas_sdhi_core: support selecting an optional mux

 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
 drivers/i2c/busses/i2c-omap.c                      |  24 +--
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +
 drivers/mux/Kconfig                                |   8 +
 drivers/mux/core.c                                 | 178 +++++++++++++++++----
 drivers/phy/phy-can-transceiver.c                  |  10 --
 include/linux/mux/consumer.h                       | 108 ++++++++++++-
 7 files changed, 278 insertions(+), 62 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251128-rz-sdio-mux-acc5137f1618

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



