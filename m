Return-Path: <linux-can+bounces-6341-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA82Afghemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6341-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:49:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3154A3252
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A36730731A4
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56298331A68;
	Wed, 28 Jan 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="e7iX4tJN";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="e7iX4tJN"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023088.outbound.protection.outlook.com [40.107.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D328D830;
	Wed, 28 Jan 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.88
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611600; cv=fail; b=SrJT5n8F+QvnzmKwHhcZjO2PtYMdxxdC4heQevAYdbxa1XKQFp26N3biqX7UEvaSv4HoKUcWwwL7pigxedJLsgIqquHWXmzigiGaN8eIIUXmFsrqwL7UBKXys31lsKMIqquS5N1ZmEzQA1CbFGO2d2Effj4xYyjo8dXiEs9/icg=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611600; c=relaxed/simple;
	bh=kCrsUMCWtzRbvvBzHRd/ml9szpn7OIR/51+hV2opIWo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Phe0zuT4UdhgPT4NUesGCyiEp/NWFhosWuMIlAXA3eWh9WUcv4QTEB9nMKNwClXBL3tjxsf5TsCVe24cpuxA+MQUCVtR7hy52pmTRIBMI2Ea3twoIk6qRQWroXW2oxiiGyy0tEqp3h2/4CemmEAa5h2OZfgre41jovxpTuXg2E0=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=e7iX4tJN; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=e7iX4tJN; arc=fail smtp.client-ip=40.107.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=j2/WZj0ySRRdIN3eDSKFEWo38hS9UiBzoU/J0XL5KJOOYZmz1vivWXW9CeV4VwYsw8lQFvF36qsqMaVArU4x2PQK8AeGcUvKl0kNEwXzotFnGsRT0NZ8WnwkPG0BgiIIKQVzp3BsPgSTqkxBhKsNeDPAABcxkKGMI30k9bCixwycR7XgFMfe9gQwLbcirt0aark36ZifLkFnVnenlTDUoRlfvaBinCgoNZ3S+GBjkrankF2SLM/TzVLUADqsbcYg6F8b9HdZzjl4n8o6zQp/vtx17RNQpYTognr1hAJ3k9G4TdX9GUaQvn1n15HKk+a5SzL2SwI2tHhxd4Xq5hL9Og==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLi/U59Brmt9K4wNjrVHItzfw8i6NMSIFcdw3MoeAbE=;
 b=TiYhMdEIo1KzZkdimMxtdL9PfXlzgRyFtV7xdROLO3siUS6HlP4XNa+8JuzDVbGPD01rOtG6kyc8N0W/stbkt9yLra0XIvcop0V/CFXQljvj1lCrw5R1CBH5D9IHy4ali//PSXBE2gP5d923naFl4S9pzuaj37UKRRptHPNNgeiEYmV0P799LjsVlf1oKdgnOgVHlKH8/Wmzh+darV4dNSV5DJmkN7QquHEso6oXIrs/MRhlNuHZxvMIDp8y52u0OXOIjAtjTmynMSgeiEe8PI2U5D7pcSOH1iiT+PjKUMi0LDoOc9PuV7ZfM7M4njA7hrPObmfJR8AAiiB0M3GCsQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLi/U59Brmt9K4wNjrVHItzfw8i6NMSIFcdw3MoeAbE=;
 b=e7iX4tJN8W7mBf+l4+0AVCjs5JWEJeVqrGQ1xns/KkWHCwzo4I6LUvS2HBTVgYbJnj8WolO/ZACNOhQjcELgc9JnVtDXlxe1+ErzU0wSq2BLZy811TPTGL2RV7cU0L6/pQwabFs067QM7EBp/UvypUVJAzwjwfwFFXO87UMCmPI=
Received: from DB9PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:10:1d9::15)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:46:32 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::3b) by DB9PR02CA0010.outlook.office365.com
 (2603:10a6:10:1d9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:46:31 +0000
Received: from emails-3211892-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-155.eu-west-1.compute.internal [10.20.5.155])
	by mta-outgoing-dlp-670-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 493B080690;
	Wed, 28 Jan 2026 14:46:31 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1769611591; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=GLi/U59Brmt9K4wNjrVHItzfw8i6NMSIFcdw3MoeAbE=;
 b=HQCwnTbltc2x/0hob5A0KdZS1bfoyX2JMxS7+P8dVu/Lkbp8iADqzdU1ae/sOBpJAT7a7
 z1D+aRRVZC0FC8KYOObMBucu5v7NeCQcM2+6jWhMfdTzPtew3E0Ga5rYNAbsmjI7fKyzynP
 Ki3cfzWY4fBexr0I2zHTNtWzkJq7YQU=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1769611591;
 b=C4KNXeJTmhxVyFDAQ1R35+94HAp/QB7caeBS3w4qfJbwAnXyJTG6DeJMoRDQ5DDSiBPG1
 9f6A8QeCe99EY/uOkAxxn863MaALDKyyhi/joD1q4cfpdHQ3zdy94edo6BJrnydqAODs75x
 YSqeqxdvHCTEGmSa5uftP1unsEO6J2s=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/ze9retGuMuSNNM7PclZGVFtA2IwVZTotNTp1Ivps55Vn9newACpmsuWPw8IWzbSm6l8z0/wrYkUuyf0ngC85mINZl9mHHJY3iHozS9pA4G7c2pLT6X91KiNQcGzI29bpWu8h7N13vf9l9NkkjtGMnLEJ48BvPVluQxSyE6vXoBmoCCDDYB8fEou3qQtVkJNgpwD5YVkFnCAWKIvjhndfFJIib5B6MzCPZRRX6RvIUM1OF2fNysyf1lz5f4FnxPj6Sgb+TUOD0262cAB8yKQsqtKGTDLAOwi5AxjreLlhbJ77LGWJkt+p4DJAwwojDEEp9hosV+I1oUkVqs5hBAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLi/U59Brmt9K4wNjrVHItzfw8i6NMSIFcdw3MoeAbE=;
 b=TyxcOybkiQpclQDH3UsfEUfSxSj1TbJ9xCmh6OxHIZ1y4i608NBH4Gvi3vM56abkErsHAFADqiOD58rVg5JsDndCtEeSJ0uaAhepeR7rgurgrlWUs513LwKM6B/DyKIoFgTli94sjlOinrpvUqcO1iCtVdVZLkAWIolLIW5BdIxMJXaH9hddVHQ2Q3wjSEbN5mV2wV1BpotULaXLruqnqYbdlERNP946n0EnHE7YPxgbGNZsznz4lWrSNsSyaaYzTaPM9JPXqcYI9b7HS3Xb7d/GYICFk2eE2eHA3LMQLJMuNGf8f7dppe7kVXtxcJVYxwsw11rothacDg5pz8FNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLi/U59Brmt9K4wNjrVHItzfw8i6NMSIFcdw3MoeAbE=;
 b=e7iX4tJN8W7mBf+l4+0AVCjs5JWEJeVqrGQ1xns/KkWHCwzo4I6LUvS2HBTVgYbJnj8WolO/ZACNOhQjcELgc9JnVtDXlxe1+ErzU0wSq2BLZy811TPTGL2RV7cU0L6/pQwabFs067QM7EBp/UvypUVJAzwjwfwFFXO87UMCmPI=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 14:46:21 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 14:46:21 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 28 Jan 2026 16:46:10 +0200
Subject: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
In-Reply-To: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
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
	PAXPR04MB8749:EE_|VI1PR04MB10028:EE_|DB1PEPF000509F5:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b30eff9-6d70-4c15-1fbb-08de5e7c06ad
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NkNCdDhQb3dqVGdoYlZjV3FOdTdWSDc4SHJiTXBPemVrYXJKSDJFVGJqb1lY?=
 =?utf-8?B?STBZb3Jiai9Vc1VCQzJhVmQ3MTNpYXNHRlhsS1hFdUt4VGFLY21wc2FwNFdF?=
 =?utf-8?B?UDJsTXUyS3VyS1NWZGZ3Wm10SjJUL2RqeW1velRHdGRDdHk2aXdIVHdRZTcz?=
 =?utf-8?B?clVlazVPUExybytzOHpiajUrRG9lZmlaM2Z3SitMRldqZlMxUngvR05rakhE?=
 =?utf-8?B?MVdTNTV5TGdNcXFCWVN2Q3g3OWlhQ1RaRXljVjA5ZXpORm1sbitxOHFlQmRG?=
 =?utf-8?B?THRkVEJnbEhKS2RBa0xyVWdxTldHd2kvTzBiTnhrSjZsclJRY0gwYVN5QU5O?=
 =?utf-8?B?eVpvYjJlTUx0Z2lsU1lQK2hrMGFtN0p1Q21aREZDczJGQ3FKVnpaVVpTVjVZ?=
 =?utf-8?B?cUdTcWRZKy90dUZoTG5jdy9rOHMwTkdKdE9UYkNtYytUWFZJbEprVDNLb3NI?=
 =?utf-8?B?WWRZSWhDVTJIYTZZdkZpY2EvWUs0V0pKYzBDcXZRTEEyQXNQMTFmdFcvNnh0?=
 =?utf-8?B?SEhiamlKbzJCWEw5TlpKYzFwVng1UkJLVzU2c2F1VEUrZDZNY2xOQmF2RjZJ?=
 =?utf-8?B?ZDhnWElUazZDSzVoODdUZ2gySFRKUjhldmRFdWIwSXJMdVFod2xOWGhXWnFT?=
 =?utf-8?B?WHBnNzFCaGVESmhOaDIrSmx4L0h5REQ5V3QrNFBZdjBGdFZGK1d4Wk0vVzZa?=
 =?utf-8?B?V0xWT3VBWldXZ2Y2a2xqcE4rUDhpaWZYRnBsS2FZcitwVHU5b1dnVitkN1o3?=
 =?utf-8?B?aU4xbXJVOHBCUUR3TFZ3cnNSQVlneWNwN1pTd1licW5iLzZZaDVUSTFYQTI2?=
 =?utf-8?B?bG1oYWo0UEd0d05TY3FOMWFEYVl2Mk5oRFVjQzUreFBqdVZFZFB6c3FRRUJ2?=
 =?utf-8?B?MWFLQ25IUS9nSlBka0l5SVN2SmQ2L08wb1hMOEZkd2VISGVuTy9TNmJwY3hS?=
 =?utf-8?B?TlpFM2hQVlVMQjFDVDVzY3NQSTFVVmppdERnd0tDcWVpb0RaUU9wNXhES1d0?=
 =?utf-8?B?VDZqa0ZCc0UxNEdlZlNsc1JrYkZhL2dzZis2Wlhtb0k0M2dNTDBtVTNPU3Rt?=
 =?utf-8?B?VDNzdVNKS25SdytYaWhvelBXL1hQbFczNXZOSWJKb3lHREtBeHBIcXY1akpn?=
 =?utf-8?B?VWFRdmk2aExQdGJMbE9mdjM0d2lPYXdmREZ0NWRJRjk2Z1dXOHdBMHp1QWh4?=
 =?utf-8?B?djlsNTNzQ0hSTHpQLzR6ZzZhcGc5a2dMS1ZrcXRRS3ZZdlBIMVBwb0Q3WjB3?=
 =?utf-8?B?THNOL09haStSWjlEMnZ5aCsrSkl3ckVtUjBDOTk1cWUramJtZ2hlV294SGcr?=
 =?utf-8?B?NVRRNUl2QTBObzNjZzZnMCtDSWpkMFFiWElhMnV0VmhCM2pnWjBGU1lOUVd5?=
 =?utf-8?B?NS9FNUxRV1VvR0dqb1hFMWZtVFJwSk5FNUhhUjgrV2FSeXMvbmNOd1Y3VEJv?=
 =?utf-8?B?MHhBTVM0WGp3N2NIVEsxYUtoS1JMTVZRK3U4N09OZWF1eXFjVWY0OWNYdGVW?=
 =?utf-8?B?ZmZHRUVQT3lxdG5CaG40cTdqMC9QN3lidFE1R1o5S2ppR0J1Y1hVZCt6bTl1?=
 =?utf-8?B?MWdRQWNRaDIwYVVvcGlHMUdEaTcvTDBwbmpJZzIyTXltUlpGeVNDT3k1NUlV?=
 =?utf-8?B?WFkwVTRCbS8yWm1XU25jYWlQSytQVzdub05IcFg2VVhaWWk3dlFpd1RqLzMr?=
 =?utf-8?B?VzhFVHZKbFJ4dmUwTkFMamdPRHdSWTFRc1daWnBUVEw5REdIRS93K2xUNU9M?=
 =?utf-8?B?bEFqUmY1WHJOdFJRN1FQQktSOFNpaEltbkwvLy9lbUREeHBnUFZ0bkR4Y095?=
 =?utf-8?B?UUVQQm1lZTdEeG85amJGek5GSmV0YXRwL1JiZm1BQ1Y4L0JhUllUL3JpNTY0?=
 =?utf-8?B?VVJoakJDZ1EvMmVUK3JhZDFiQ2R1SllJTGRnT0lHWlhMN1lRbkprMVZ6YnJH?=
 =?utf-8?B?ZHlCMTlEaEt2SDc5L2lqeTRLYTJuTjJncC90T3MyS3dVNXVLUjJic25WSDhp?=
 =?utf-8?B?bFNFbmloamNVYWx4RWREODdyVkV0SkluQll4OUtITERQWmU4WlhKaXo3NGE0?=
 =?utf-8?B?TDFWRElCcnE0M3pQRzlwVFc5RkZrU2lGdGRvVWNQbVhZTFlBcHBMK1h6UlJz?=
 =?utf-8?B?eVhhTjdSQ3J0R0k3UVA3Sy9nRHdtUnFYWmViMStZR01rcW5ja0Fuci9wYmEr?=
 =?utf-8?Q?vjowpmld+vP2GAFs5HWT3kSIZhk6vCCex5No50y8xglF?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d8fb3f9a95b947f584783a9184ed2aba:solidrun,office365_emails,sent,inline:5c927907a0056d3547fa923b049e9e5f
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3abd63b8-4de2-4b11-9385-08de5e7c008b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|82310400026|14060799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW1yaURpSUlhQTZvdzNQdHdBamMra1hsR3huZHVadzJuc0xML3FUaTBZenhJ?=
 =?utf-8?B?TDNIeGtjVTdtdUtKNDJSOVJRMlllaUh6b3lzRHdIalVRWlF4ZjhJRUlyZUIy?=
 =?utf-8?B?ODV4WUdmaVVYZThZMDVpRjRrWFFsK2IwVEIxUDF4QU9uTkhTck12d0NYUE9E?=
 =?utf-8?B?N1U3ZXNZT0JNNGpSL2JyMzl4SW5OTk5MTjlvS25RcGxOL1YrRE9KTExaeXpa?=
 =?utf-8?B?aGJZSnZQNjdlblBNU2U0MlFicUZZcmhDVWk4SkNCUFAwU0x1Mi90K2xxeXd0?=
 =?utf-8?B?QnluREFTeEFTcVpFWjMrY3hHcWM2L0ZLREMzb1l2elFtU04vaXFCNldsbHY1?=
 =?utf-8?B?QWJUMHpFSVpEUHorcWEwMXdERmx2UnFrQTB0VnoyZDVKejJxL0FnNXVZR0FB?=
 =?utf-8?B?Zy9zdXl0R2Nsck5kbmN0dllDQWRMWU56RkhqTGxQdjVBd2czdmRBdXFkcmNq?=
 =?utf-8?B?aGE3ZGk1UzlFaVhyWWJSaHA0MTNyZndKZ2V2QkE2aC9ZRXNBY2ppZlE1U2VM?=
 =?utf-8?B?aDNnWHdFVzNsR3pJYkpycmNwRlRlZzFVeHhBOHVDU3JQTXZjcmVNdm5rczJF?=
 =?utf-8?B?Z3QwdHU0dUlSbFhYWG1WV2lGd3ZQbkNEY3U5Tm5zeXZ3TTF3T254dkRwc3l4?=
 =?utf-8?B?WVpkMHJraGdwRGZyUW1pUkdpNnZoMmtnZFNWWER2dXpzb3VGNVJNMEw3S240?=
 =?utf-8?B?b3diQUd4YkhiQ0JHbW1jbUNKeFBRaXExZGdnZG1ieGJvV29DTTRtaFczUU0x?=
 =?utf-8?B?WnNJa1RkK29rK3JSUkhuZVMybUh2S2xheUxDcmZtejhHcTI1aGhGNzRpOXkx?=
 =?utf-8?B?Tmk2aUJud1lWZ3JwaGUwL0hJWkNtKzZiQ0xPTy82aDRJL1hocUVTZUtQclBY?=
 =?utf-8?B?a0UyRXJndmFtd3JsWlM1bUY5OFpyQ3FhQ0NXbVkxak5QdDBpeGtZOFFFN1hU?=
 =?utf-8?B?aE1reXBBc3YweThZSm45eEoyYVg2SUdHb0l2OVNtUU1QUGZRT2xGeVk2N2Jh?=
 =?utf-8?B?eVRQL0RNZWRDbGp4ZGxlaHQ4ay9abFZXRmZWQXZzK2tFWUpYTlNZUHkvM1JJ?=
 =?utf-8?B?NE12eklFSGFmVy9LS0tia1RMVERvd0Q5Tk1TZjU0enJ6QThmVWFxL3VFWmx2?=
 =?utf-8?B?OElLZC9FZ2ZJUkx5OE9HejJwVkF4UU9UcGxCNVI1YTdYVzJsOTVkOUxwQTB6?=
 =?utf-8?B?dXo4M2hFTWNUR0Q4WkUrQnF6c0xWR2k2K3MwNkw4QjhhRHIrZjk1UmhUZVNw?=
 =?utf-8?B?ODBmbEpOT2p4VzVkSitGZjRsYWFRYS9PYk5haW9vRWRoRno1MHNUWHYyL2VG?=
 =?utf-8?B?dmJobFl5WHZJRUtQY3R6V3IrYUtjaVY4cVZuZFlwb3BDL1RzYkRmVWFoREZn?=
 =?utf-8?B?UmtlUFhyMWozMHFVNStaNGdFSktaVXZiV1B1THBRaVR2QXVqRDU1OEY0UEEy?=
 =?utf-8?B?ZUs3eDRvamVPd3kzRDNPWWNSdzloTGdnN0JOSHNPQmFWYmdCVEVrRFQrclhQ?=
 =?utf-8?B?Q0RUTmEyVGVuLzNmYVFMM1RNKzRvS0w3dDkyaUhYeit5V2k4UnpBZERHdkY2?=
 =?utf-8?B?S1pJa0dISk9TbDRrTEpMN1ovSng3NGNFVG1QT1AyN0t3OHpGK2FZSm52QkNM?=
 =?utf-8?B?VlRNR01uZldDeDhBK1ZlZkdyb3dDTm94RTJqMlZDYmlUSHhwa3k1UklOWktH?=
 =?utf-8?B?V1lVY2xCWGVOK0ZsMk1FdTR1QUkwN2tkNHhwcklGS0QvTk1hdU5mZFdxMUNR?=
 =?utf-8?B?SkZxVVV3WWJ0YmQyakNTM0Rrbmc0bzhreHZ5ek5jUTEwSUxKUWU4WitscGRO?=
 =?utf-8?B?Q1NhVGxPM05DYmxDN0F1ZlVKOTFPTitKajlZUjk3a0wyaHVabGY3NlNwWklw?=
 =?utf-8?B?ZHJrZ2hLOG01ZXVoRnJaOGNKY0tOWWgzamRoYlZoUVI0VmpNTGVnbVhRWm0x?=
 =?utf-8?B?VXU3N2hHK1hTamJNWEplcFk4bmJPWVIwamxNRHRpZTEyZkZrUERWekJUUkFi?=
 =?utf-8?B?eHgyVEk2MzdYdFpSR0d5R2hKWWVZNEFPWU5sUkl0cDhvb1hxUmtFRFh4Ri9M?=
 =?utf-8?B?YU45bTdqQXMyVEU1dmd3a2xYeFdRaHNVU05rajdkemdTdUNSS0R6bm96dWw4?=
 =?utf-8?B?NkJQQ3ZkdmVyTW93eTZXUjJPd3NwSUR0NC9tLzQwWFN0NDVxc1dJVU81TVUy?=
 =?utf-8?B?S1NoaE9EOU43TWhKNHdVallCK1oyK0RueE8zUDdFd3l5dlZ1aVNQRU5pT09m?=
 =?utf-8?Q?gqwd+MoYnCct4IkUzRDCIG4Y1cysc2lWTqRB2XBQ/w=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(82310400026)(14060799003)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:46:31.3714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b30eff9-6d70-4c15-1fbb-08de5e7c06ad
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6341-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solidrn.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B3154A3252
X-Rspamd-Action: no action

In-tree phy-can-transceiver driver has already implemented a local
version of devm_mux_state_get_optional.

The omap-i2c driver gets and selects an optional mux in its probe
function without using any helper.

Add new helper functions covering both aforementioned use-cases:

- mux_control_get_optional:
  Get a mux-control if specified in dt, return NULL otherwise.
- devm_mux_state_get_optional:
  Get a mux-state if specified in dt, return NULL otherwise.
- devm_mux_state_get_selected:
  Get and select a mux-state specified in dt, return error otherwise.
- devm_mux_state_get_optional_selected:
  Get and select a mux-state if specified in dt, return error or NULL.

Existing mux_get helper function is changed to take an extra argument
indicating whether the mux is optional.
In this case no error is printed, and NULL returned in case of ENOENT.

Calling code is adapted to handle NULL return case, and to pass optional
argument as required.

To support automatic deselect for _selected helper, a new structure is
created storing an exit pointer similar to clock core which is called on
release.

To facilitate code sharing between optional/mandatory/selected helpers,
a new internal helper function is added to handle quiet (optional) and
verbose (mandatory) errors, as well as storing the correct callback for
devm release: __devm_mux_state_get

Due to this structure devm_mux_state_get_*_selected can no longer print
a useful error message when select fails. Instead callers should print
errors where needed.

Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
property presence check") noted that "mux_get() always prints an error
message in case of an error, including when the property is not present,
confusing the user."

The first error message covers the case that a mux name is not matched
in dt. The second error message is based on of_parse_phandle_with_args
return value.

In optional case no error is printed and NULL is returned.
This ensures that the new helper functions will not confuse the user
either.

With the addition of optional helper functions it became clear that
drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
Add stubs for all symbols exported by mux core.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mux/core.c           | 178 ++++++++++++++++++++++++++++++++++++-------
 include/linux/mux/consumer.h | 108 +++++++++++++++++++++++++-
 2 files changed, 253 insertions(+), 33 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index a3840fe0995f..b01ec126caaf 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -46,6 +46,16 @@ static const struct class mux_class = {
 	.name = "mux",
 };
 
+/**
+ * struct devm_mux_state_state -	Tracks managed resources for mux-state objects.
+ * @mstate:				Pointer to a mux state.
+ * @exit:				An optional callback to execte before free.
+ */
+struct devm_mux_state_state {
+	struct mux_state *mstate;
+	int (*exit)(struct mux_state *mstate);
+};
+
 static DEFINE_IDA(mux_ida);
 
 static int __init mux_init(void)
@@ -522,11 +532,12 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
  * @mux_name: The name identifying the mux-control.
  * @state: Pointer to where the requested state is returned, or NULL when
  *         the required multiplexer states are handled by other means.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
 static struct mux_control *mux_get(struct device *dev, const char *mux_name,
-				   unsigned int *state)
+				   unsigned int *state, bool optional)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -542,7 +553,9 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 		else
 			index = of_property_match_string(np, "mux-control-names",
 							 mux_name);
-		if (index < 0) {
+		if (index < 0 && optional) {
+			return NULL;
+		} else if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
 			return ERR_PTR(index);
@@ -558,8 +571,12 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
 						 "mux-controls", "#mux-control-cells",
 						 index, &args);
 	if (ret) {
+		if (optional && ret == -ENOENT)
+			return NULL;
+
 		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
-			np, state ? "state" : "control", mux_name ?: "", index);
+			np, state ? "state" : "control",
+			mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -617,10 +634,23 @@ static struct mux_control *mux_get(struct device *dev, const char *mux_name,
  */
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 {
-	return mux_get(dev, mux_name, NULL);
+	return mux_get(dev, mux_name, NULL, false);
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
 
+/**
+ * mux_control_get_optional() - Get the optional mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_optional);
+
 /**
  * mux_control_put() - Put away the mux-control for good.
  * @mux: The mux-control to put away.
@@ -657,8 +687,8 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
-	if (IS_ERR(mux)) {
+	mux = mux_get(dev, mux_name, NULL, false);
+	if (IS_ERR_OR_NULL(mux)) {
 		devres_free(ptr);
 		return mux;
 	}
@@ -677,20 +707,19 @@ EXPORT_SYMBOL_GPL(devm_mux_control_get);
  *
  * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
  */
-static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name, bool optional)
 {
 	struct mux_state *mstate;
+	struct mux_control *mux;
 
 	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
 	if (!mstate)
 		return ERR_PTR(-ENOMEM);
 
-	mstate->mux = mux_get(dev, mux_name, &mstate->state);
-	if (IS_ERR(mstate->mux)) {
-		int err = PTR_ERR(mstate->mux);
-
+	mstate->mux = mux = mux_get(dev, mux_name, &mstate->state, optional);
+	if (IS_ERR_OR_NULL(mux)) {
 		kfree(mstate);
-		return ERR_PTR(err);
+		return ERR_CAST(mux);
 	}
 
 	return mstate;
@@ -710,41 +739,132 @@ static void mux_state_put(struct mux_state *mstate)
 
 static void devm_mux_state_release(struct device *dev, void *res)
 {
-	struct mux_state *mstate = *(struct mux_state **)res;
+	struct devm_mux_state_state *devm_state = res;
 
-	mux_state_put(mstate);
+	if (devm_state->exit)
+		devm_state->exit(devm_state->mstate);
+
+	mux_state_put(devm_state->mstate);
 }
 
 /**
- * devm_mux_state_get() - Get the mux-state for a device, with resource
- *			  management.
- * @dev: The device that needs a mux-control.
- * @mux_name: The name identifying the mux-control.
+ * __devm_mux_state_get() - Get the optional mux-state for a device,
+ *			    with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ * @optional: Whether to return NULL and silence errors when mux doesn't exist.
+ * @init: Optional function pointer for mux-state object initialisation.
+ * @exit: Optional function pointer for mux-state object cleanup on release.
  *
  * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
  */
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name)
+static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
+					      bool optional,
+					      int (*init)(struct mux_state *mstate),
+					      int (*exit)(struct mux_state *mstate))
 {
-	struct mux_state **ptr, *mstate;
+	struct devm_mux_state_state *devm_state;
+	struct mux_state *mstate;
+	int ret;
 
-	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
+	if (!devm_state)
 		return ERR_PTR(-ENOMEM);
 
-	mstate = mux_state_get(dev, mux_name);
-	if (IS_ERR(mstate)) {
-		devres_free(ptr);
-		return mstate;
+	mstate = mux_state_get(dev, mux_name, optional);
+	if (IS_ERR_OR_NULL(mstate)) {
+		ret = PTR_ERR(mstate);
+		goto err_mux_state_get;
 	}
 
-	*ptr = mstate;
-	devres_add(dev, ptr);
+	if (init) {
+		ret = init(mstate);
+		if (ret)
+			goto err_mux_state_init;
+	}
+
+	devm_state->mstate = mstate;
+	devm_state->exit = exit;
+	devres_add(dev, devm_state);
 
 	return mstate;
+
+err_mux_state_init:
+	mux_state_put(mstate);
+err_mux_state_get:
+	devres_free(devm_state);
+	return ERR_PTR(ret);
+}
+
+/**
+ * devm_mux_state_get() - Get the mux-state for a device, with resource
+ *			  management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(devm_mux_state_get);
 
+/**
+ * devm_mux_state_get_optional() - Get the optional mux-state for a device,
+ *				   with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The mux-state will automatically be freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional);
+
+/**
+ * devm_mux_state_get_selected() - Get the mux-state for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, false, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_selected);
+
+/**
+ * devm_mux_state_get_optional_selected() - Get the optional mux-state for
+ *					    a device, with resource management.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ *
+ * The returned mux-state (if valid) is already selected.
+ *
+ * The mux-state will automatically be deselected and freed on release.
+ */
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+						       const char *mux_name)
+{
+	return __devm_mux_state_get(dev, mux_name, true, mux_state_select, mux_state_deselect);
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get_optional_selected);
+
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
  * the non-modular case - that the subsystem is initialized when mux consumers
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 2e25c838f831..3ede55b907eb 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,8 @@ struct device;
 struct mux_control;
 struct mux_state;
 
+#ifdef CONFIG_MULTIPLEXER
+
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
@@ -54,11 +56,109 @@ int mux_control_deselect(struct mux_control *mux);
 int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
-struct mux_state *devm_mux_state_get(struct device *dev,
-				     const char *mux_name);
+struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name);
+struct mux_state *devm_mux_state_get_optional_selected(struct device *dev, const char *mux_name);
+
+#else
+
+static inline unsigned int mux_control_states(struct mux_control *mux)
+{
+	return 0;
+}
+static inline int __must_check mux_control_select_delay(struct mux_control *mux,
+							unsigned int state, unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
+						      unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
+							    unsigned int state,
+							    unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+							  unsigned int delay_us)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_control_try_select(struct mux_control *mux,
+						      unsigned int state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mux_control_deselect(struct mux_control *mux)
+{
+	return -EOPNOTSUPP;
+}
+static inline int mux_state_deselect(struct mux_state *mstate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_control *mux_control_get_optional(struct device *dev,
+							   const char *mux_name)
+{
+	return NULL;
+}
+static inline void mux_control_put(struct mux_control *mux) {}
+
+static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
+							    const char *mux_name)
+{
+	return NULL;
+}
+static inline struct mux_state *devm_mux_state_get_selected(struct device *dev,
+							    const char *mux_name)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
+								     const char *mux_name)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MULTIPLEXER */
 
 #endif /* _LINUX_MUX_CONSUMER_H */

-- 
2.43.0



