Return-Path: <linux-can+bounces-6531-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NuxG2Q9imniIgAAu9opvQ
	(envelope-from <linux-can+bounces-6531-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 21:02:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DF811450D
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 21:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04FA3001583
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A78A329C5D;
	Mon,  9 Feb 2026 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TFSyTqgc";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TFSyTqgc"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBD8462;
	Mon,  9 Feb 2026 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667357; cv=fail; b=daLTQOQF4wLPburEmS/eLhmY+/1KAO89MKanPG2+cFhukTceqoNT+d0uEBsa52+mCwHwIvcWtpdWte4cgEklMTZE9TP81lk8Jo049zofboDPnCNi7N4RitmPvFJrWeO2G31aTvAs+sWt9ycC+CwYCIpE3i9EWBqMa97aLKr+jec=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667357; c=relaxed/simple;
	bh=WLt3vMddS7perI6xXcf65FJrVvQj0IY+VYZfHlxUGBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M+o7bJDZBlHg0g+S/6GWT4EXx+mikJp4Dt+6zgKYO/PuDRgsiOiNGakVrhsI6P8pfb5TVC7JZBcr7t524rN0eUz4oqPWtbbEx/x0btqEbWXK9zNCbJvwy41+4O8fV/P2v7B3djuX1cIcMOe9ifmf18sRe/ZEuejX3KXpOSxeA+I=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TFSyTqgc; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TFSyTqgc; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O09t+GA/L+Ua4QPhYqoP53591N7wAuAcR7xGmNZ002YAT0eg6Q6rQ3iExw9oO/bjLIEknbKsrFqstW2Y+u4oUwQ5RaNzPLu6SN6cW0vSzJqU8yvlgTj3rrKuNPmZmOI+1QT6RCPvonvAd1uVff26B4tsPUkvRt5PSQOjnGUFO+5cZasov51JF4PCt9gIWFTFsOkoxA7SeeexIbj6PACg0dQeQyRkCkhGcTvq9vOOJmf8xMcjytOpWF9w53ra2dy7Cq5J9vEcM9+3PuctINR64k+gUIQfHq0ujVeTtievwPX5I+AMfb258aqXxao7XNvQOd8Sy+MjgUswCJjkp3qubg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLt3vMddS7perI6xXcf65FJrVvQj0IY+VYZfHlxUGBA=;
 b=xt9H0kk1Dfs4p+kf5kP4SPi2La4L6LnrdWaffJsalFK8asy30J2uZzJppc6Zrylvvv9NLbgh4buWoaQwsOPGJ8UhvSIBwpeS5o7zaJcDDDUWAAPh1QeGomCCvCyf+wGEQQ0q7UtrxPDdNbLwuzIxugvVJPWC1d0OwQy8DEwlXWXAmIczWRz9ZgA5D9l3abmzpKtub6VyJ27MrFDgzaSIaokiIA5dIpA3pDE38iy02naJuAFfzJJgooHoQR+EfRipLFrOPZv/DbGhjiSYR6Bww30IX3FVgwciM/s5mfLLP0YrQ0BThP/8Q1ioRLkCoaWDg4Ip7f7P8IErtl+IfHjSCA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLt3vMddS7perI6xXcf65FJrVvQj0IY+VYZfHlxUGBA=;
 b=TFSyTqgc9RZO/rT6dqmf5jeOKCrhlv/td1bqk5JAfYDRwyvC6ZBbT016K1nkq1UuBAWNQPT/sbjMW4zw3rX7CfMNHZRm7eyUyTw0wselWjxDstqIzWArXfODcPyymw97eR2l3fImMWb8I/Cgx0kNZByOWiy29ShaPemBVvByWZY=
Received: from DBBPR09CA0034.eurprd09.prod.outlook.com (2603:10a6:10:d4::22)
 by PA1PR04MB11012.eurprd04.prod.outlook.com (2603:10a6:102:492::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 20:02:33 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::22) by DBBPR09CA0034.outlook.office365.com
 (2603:10a6:10:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 20:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 20:02:31 +0000
Received: from emails-9264805-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-189.eu-west-1.compute.internal [10.20.6.189])
	by mta-outgoing-dlp-141-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 3998A8042A;
	Mon,  9 Feb 2026 20:02:31 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770667351; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=WLt3vMddS7perI6xXcf65FJrVvQj0IY+VYZfHlxUGBA=;
 b=HOyNGCBWHTvzjuUV5nIYPLxCgqUwrZziTEv1cOxggjX4MjQXF4W1b1zprYm7t0fDe1kuN
 ypDNJG0sg3g6pSYYY8HEbgzYDIc4kEdIg70sEizIJJRjdUsEzg6FkfvMbw1NAVExhAaguC6
 M8whAMqAfV+iPzSx4jn24sUUf+Bs7J4=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770667351;
 b=JQyxhkIzN6652xr3SJfXKxEYjTg8dKOxKJrne+OCJFU9+jICy2I9uGEJzhh9Vob1AlEg4
 hJs4qVp9DnBT/S4wwefOsAHZt81eyXbd5j6eleiuXo4w3+wcgKjlHl2/3eA2pw1jmuscdwQ
 OcFIM/QMbzTpkZSdynkxKgyKB7gOk18=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcGYF0Hz4CLbpv/Qm5w5RcqPwj41ipyoMLxzt4SDRZNSmbUgyZWbo7hp04KZqb7PkEqOOTTITLpoNyQKlUhlTkjU7VYVqXHiyd3SJEiHEEGf89GMhfSRewycnzOJoMrujqkcaEJpn3uqgHQhY3zlAClpYeVGdyHL3xFy1zl6ab7ln3tX2TVY/YGCrvrrALNNLMi+8HS9eLpipbtAsp9IIhkBfNj61Pj+TVSLaA3DynVc2zRG2gDODtEvLLzrrfhEhx88FwwgGOGEB9GL4kuy81nAuqVDqXi4Pwb5wsp+cgTAtVv3ADlW4dtUD5OTlv88riZ1J1fcrbAN+mM4AT6RjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLt3vMddS7perI6xXcf65FJrVvQj0IY+VYZfHlxUGBA=;
 b=EMcQIcqUqrH84XVYYVvnP8z+2cTSxdGGIXY8chjmlQezmsasGk+bGsOOe8+kEl/Ab8gmQLjuKFo1u/2D+qfF8DAqjR+gqCsd3U6+GpGMoesqhAP4D29qQtfbis4atNS2GTgTKDpK/IEm65cQTJnnhhc+47vGY7XUQVifHlvH4tT1QIWUg+q+mkDEAa5CFWcACKY6ib3IC7IHLOqkAg6r92hZkaSraQXI6osFlWmKrBFSyrR9bxyckfZeE3DAFRpBIDY+woSxXEMuA8JNWC/FiruG9dT3KBgYrSPvs/zqjbF95JAvuoq5GQ/PWx9ur5vCBbeNYIFKBSpFMIi4ia0NeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLt3vMddS7perI6xXcf65FJrVvQj0IY+VYZfHlxUGBA=;
 b=TFSyTqgc9RZO/rT6dqmf5jeOKCrhlv/td1bqk5JAfYDRwyvC6ZBbT016K1nkq1UuBAWNQPT/sbjMW4zw3rX7CfMNHZRm7eyUyTw0wselWjxDstqIzWArXfODcPyymw97eR2l3fImMWb8I/Cgx0kNZByOWiy29ShaPemBVvByWZY=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA4PR04MB9344.eurprd04.prod.outlook.com (2603:10a6:102:2a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 20:02:19 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 20:02:19 +0000
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
Thread-Index:
 AQHcmRESUG4499YSf0mIlO8cui8aobV6NzeAgAAF7ACAAANKgIAABrCAgAARQQCAAHN8AA==
Date: Mon, 9 Feb 2026 20:02:19 +0000
Message-ID: <de20903c-cae3-4f2e-8784-5b04421fdf4e@solid-run.com>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
 <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
 <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com>
 <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
 <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com>
 <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
In-Reply-To: <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PA4PR04MB9344:EE_|DB1PEPF00039234:EE_|PA1PR04MB11012:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9a0fbf-5996-4f02-01af-08de681628a7
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UlVnN1d4bS9xSmlKaFVPcmVrUlVhRTJJQkNWRXduV0g2QjR1Q29ub0ZVU1pG?=
 =?utf-8?B?RVdvbWozZkJYNWM2Zk8xRUNvTkY2RlJXSEM5aHJVaEJramF0S3RsYmxHbGJK?=
 =?utf-8?B?ek84bkpYQmNjZ1JLbmc5SzBISTFYbGFWNHkvNmdzcTBoSnA0NngwL3N1TU56?=
 =?utf-8?B?b1g0Si9zWEZxdHdycFJibFNKR0htTHY5OEF2NlBqblJ6cmtjZDVqckVoUmZS?=
 =?utf-8?B?T0JDVlVWMDJGdXUxSXRBLzd4K1FzeTdvY1Yyb01CTTVYRms1YVFGZ0dyMms0?=
 =?utf-8?B?UUp1SWJ5VHk3aWlPZCt0eG9wQ095MjF0MHh5NlFWSmRNS3pWUHJwd2U5VDli?=
 =?utf-8?B?dFJucEh2WkFuT0hhWitBQzN1Z1pCaGhXR3EyT2RKazRlZmJZd0luUEt5eklC?=
 =?utf-8?B?QlJCNzJvV3A2VnNONTNxU2orcWZvdFNqMVdaenhWVWVLZHBQVnNwMzhiL0Z1?=
 =?utf-8?B?azJTcTBFOXNmNjEyZVNTOGlkSXhwNk5hUy84TnlqQVBOckw3MGs4dGxWSWxR?=
 =?utf-8?B?THBHKzJ1ZlVtRDNwc0p2V0NlNGxuajI0K0FQZ1VFZUVKdit1SCt1Q3hyTFcv?=
 =?utf-8?B?cnpveHNPQ05seERzZ0RDTkZvMWhaUGhIaEFHU2c5bGxPTkR3MVVmN0FvN3NS?=
 =?utf-8?B?cTgzZm1pODIxRzlhZUVwSkMyOU5HLzZ3d012TkdTbFZkQXZEK3cvdWwzTUhi?=
 =?utf-8?B?M1ltekFUVE9UdkFHczdpUVdWVXZmcFEvdzhYL2Vka1UwclIwS29HTTV6ZStJ?=
 =?utf-8?B?UzdYdmFVbS92dDZIMUZubzZ6K1NoVGFTNG9VR2tVMDcvVUxLNXJkaUxOKzli?=
 =?utf-8?B?S1kxZzNjRFJVMHYwSkx5VlpyMmZGS2M4aGVldDBIR2pvNEZEeVNXcWxZR3Fl?=
 =?utf-8?B?bFFQblRRN0ppbXNGdlMyVW9lWEtNY1VpcFN1WGtLUVQrM3ZpenIyeVBLbEhW?=
 =?utf-8?B?ZmFiOWZTUWh1Z0psVDlVUEdYS2FXQk1hSjlrMEJjSFJ3a0NvWldxMVZjNlBQ?=
 =?utf-8?B?N3lySlZibm5LVlZIclJGaHRJQjVlSVUyU0crbXNQWGYyNGhyOXRrVXEzYmhG?=
 =?utf-8?B?ZEdLd1oxNXNZN202YTFwaER4Ty9ENjQ5UHhiZG1ncm0rQXJFMlBqR29ncFpp?=
 =?utf-8?B?QnFTWHBZMk5adDJXb0hyU1V6TElHTmpZTUxIVTFOd3lhWkRvcVpGOHg3b3R3?=
 =?utf-8?B?L29Cd1NjcE05aGlPdGpWK1hUOHlRTlJSQmFYUmN3dCtQNmN0TXQ3UXM3YjlD?=
 =?utf-8?B?TnRyNGFzRCtSeE44dDkyUC84ZHRITHorMjBRZnNBcVVuTmswa0dzRmNRN3ZV?=
 =?utf-8?B?U0VDWTVnWmpnTkJVOGhHcnB1ZVpwSkdPSW5hNkFmTVUyNHZGWGJDMEl0R2R0?=
 =?utf-8?B?UXhuWlM3VG84OGhRelRLYll0WGFIK09yNERPM3N4dTY1SmxpSUVIWXRweS92?=
 =?utf-8?B?K1hLNUMrT3JwQUxsUlRpMk5CQmVMano4S3RDamx5U3lBNHhaZWR0K3hkSHVP?=
 =?utf-8?B?WGdjQlF0dEwxTU9pNHNzcUdLaGRGdGE1Vis2QXo1WFJmdm9MTDVpZ1cvekcz?=
 =?utf-8?B?eTl1bHMxUzFMdk42dGRBbm9yeHUvS2QxK2IzVmtkeVZwVlZyY29FVVpWcm15?=
 =?utf-8?B?Um0valllL055T2VqaWNneFNqR01RUlA1NWs5aVJBS2lFNmRHVEdPR1pUR3BO?=
 =?utf-8?B?bzJNbXlGNC9tcXFPeW9FSUFlNENTcldhRGVpTUcvUVFORjJBOWtmWjh6bHNX?=
 =?utf-8?B?S21XVVFabVVhK01GWE1HeDlPYzZLU3dIOWxPc3V4WTFPQ05ENy9YREM2RDk2?=
 =?utf-8?B?ZEhoaGhUdTdESFlpTVNmVFI3ZXVaTmFlb0RKNUs3elNjTkU0d2pxd01GaFZy?=
 =?utf-8?B?NVFINk92SmZDOEJiSXFIMThlU0wzVWkzdDVQREV4YW5tMkwreXlOeStHcHgx?=
 =?utf-8?B?Q1VGK2RId0lPTTVUeVJMZWZEY1Fkc05hQzBjNzB6di9LQkFTbmpYbURZemVS?=
 =?utf-8?B?eFdoNWx5ZjlBR3NBUUQ0SFRmZ0pWdGFQUExqSFZxVFdjcUlGSEdZZnUvazZI?=
 =?utf-8?B?TjhWcG1Zd00zNlhycGFNUGNqRUk5dTVDR2djUS9ZZXRPVTcvaUZXakcrRm9Y?=
 =?utf-8?B?KzVyM0tRL3lDaEhTQnN2Q2hPYzJIVVMzcnV1Mit3WXMrSk5GMzFtWmVEeDRJ?=
 =?utf-8?Q?4SZxbKuQuONeVIDh8W0ZZc+MjLZfOuinwZvj99TcsO1G?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A3F5D81AC15194EA03600590EA03CC0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9344
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: e5003dac5e8f40a7bc84a3f521060555:solidrun,office365_emails,sent,inline:7299f935d81ea421dfac3c9fa9405b59
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	238bfe15-f9e9-4f45-bc29-08de68162168
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|376014|7416014|1800799024|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHVVVjRWaWdKTmNUbnBpVUl2TWY2Wko1eG5vMExHenUzVjNYZkx5WGIvdThI?=
 =?utf-8?B?RTNFMnhRN0I2eHFnMEVXTnlSYjNYSnllckFjdUNlcUEyNEVVT0xSUVBUazhP?=
 =?utf-8?B?R2kvdm5ZK3ZZN2VCZGJlT0EycnhWTC9XazVxbFB5bmVxdnJxY1VIS29WdlZM?=
 =?utf-8?B?eVh3d2s3cVplY1NldUVjbWdTUzkxSnJDZkVHdXowVUZnRlhwbnVCd0RkMXJC?=
 =?utf-8?B?bVNkVmJJQTdwRmFhN0h3ZEQvdkhGbWIwbGpaZm93U29TVWo5TXFxSVRhVmlC?=
 =?utf-8?B?aHIyYWFKbGxkLzNTdlNOVnYrWEE0Wi84K25sdDMxVlNaQW55MEswWSt5cGcy?=
 =?utf-8?B?SytpcHlVSVQ4UUlQRG9iQnFYdlRsSlB5Q3N4VUtGZ1dKNzdmS01tQXJ6RHJi?=
 =?utf-8?B?STVqcXNjZURvOFB3VjJwS1ljeC9vL1VlTFhxNjN2TzFrYXBSaHJvR2ZOMXFI?=
 =?utf-8?B?SWd3MGNQUDVpci93MEVaSFl1bDI3eDBMeWo2R056Zk1idWRJRjF6RGc3bVFR?=
 =?utf-8?B?VVRubXkxT1YvaVhOOXplTmszZWRsZHhNak1uSnVFYTR5dzZVWjVFTmxhWUl0?=
 =?utf-8?B?MWd2dCt5UmdobmhNZE9mZXIyOTVaUGlyOW1XbGt1QXNZeW1vNFl3WWpPajhj?=
 =?utf-8?B?bnh0Yktady9TUld3amppUVgyUTl0TTN4bjZFMWZKSzdQSzRuTEhDVDlLNkFE?=
 =?utf-8?B?NkxwVGJrTUZScWFmalErTm0wT01rbWFMdVI4VjcxOTd0cHR6ZDRsMzUzT3FV?=
 =?utf-8?B?MmVTWUJSbUticFloRGlXeG5XWWVkYVR1MkhsSWVTTStZM0ZqNk1hVDdabEVm?=
 =?utf-8?B?amVkUUdLTWU0RmlHeU9tUHBGd1dLWjdnem9HeS9ORGJzT1hkcHdnMEFWODRj?=
 =?utf-8?B?TnBtbnoweG4reFhpQVF3RUdEV1B5aXlXUlcrWkMxenhXcE52Y0xWRGd0UmI5?=
 =?utf-8?B?aHBHdFZUYUZGeDdqTnhnV0w3bUdJNjA1VzNQd0FpUStsMWlRV0RmVFg5STFI?=
 =?utf-8?B?SFRxZnNOL1BVOE5mWVdyVTQ3YUNxNmJhdU1EQzRKTHFQS2k2ak5RbUZldk05?=
 =?utf-8?B?UDZFSGVUcjFYTDRqT1U4dHArWVNrdGFZQXBnMUwveTZiTVR4QWhicHhMOGh3?=
 =?utf-8?B?b3A1Z0tyUDlBL0lGd2ZTOENwMDZBLzJSK3VYaXVkRkJEWFpjYTc0S2xxQVow?=
 =?utf-8?B?UG0zeE1oMEg1anVKL2pKOWRsSkE3VEU4V1MvamNXdW04SGhVTlQveGJ3U0FY?=
 =?utf-8?B?cEx1LzRERnJKcHVUMEM4dEpSOHNOOHF2YWFYc3hRdG9LTXUzRVNBSFg3elMr?=
 =?utf-8?B?SEJxQ0hoajVtbHBwcDdHT1Q2bWlRNGJJK0tFTnAxcDNxSHFCd0xrWU5PMXp1?=
 =?utf-8?B?am9RK0s1YWd6SVRoeThaWjdQSmM5ZHR5SU5jem1CREkxdUZLMkNpN2wxS1Vh?=
 =?utf-8?B?dC9jeG5xdksyeTRVREVNNm1mYkFNbzFEOWZiVlU3d3Y1N3J6eWcwRU1mZkRH?=
 =?utf-8?B?RXVTYytIQTF6VGlkYkxOWW9EWHRnTnZpdTRyWG9KQ0c2em5hV0ZnV3V5K25k?=
 =?utf-8?B?d1krZ0FUQWF5M1FFay9vWndxTjhTRVczYUlQS29OS2xGWkxPTzQzdjVOOGJF?=
 =?utf-8?B?SnR0MUhGNzIxYVJGRmlaZ1pIU1oyMVk2dlhpNVpmVk80dVlnVHIwRzU1OHFZ?=
 =?utf-8?B?VGRqSUphWDBvMGU1b2ZLZEEvYytsOTRlSHZLU0VGVHA0RWhXZEZncFE0OFU1?=
 =?utf-8?B?VG5VUUluY01ZeW11TG1IU3hCM0lWb3hBdFFEbDB3aUFhOW14a1k4NmRiQkhG?=
 =?utf-8?B?K1FROThSd0RpNWp6b3p3blZWZW1PQUFLdlEyRU94T0l0WmU2KytaS3dPZEpC?=
 =?utf-8?B?UUZWaWRlelpVL2JiTXhleEFiZGMxcTlOMUNUcHA3NmEyazl6d3VXUXNaeTVY?=
 =?utf-8?B?ZW8xYnpTZERhTDBBK2dzSWZ5cnRnblpUTE96cGVBRnM1MkthU3hoUHhXbTJS?=
 =?utf-8?B?aHFBM1VaNU10clpwd1dZc3lJU3NmclZRcjQwTTVIWGpZZVM0cWJzd1VqWWtK?=
 =?utf-8?B?MmRIcXRqMGpZc3crTWNTZVFUK2lMeG5PeVFUS21EaVdoYUZ6SWk3Zktta1or?=
 =?utf-8?B?SThPR3pCdUtDSnpubnJ5L2RGMTMxVmJib2s4NUpaVFdXR25QbXJGSXZwdVdS?=
 =?utf-8?B?UytDQWQyNm9lYnY4SmdlaUp0aDEveXpFMmg0aUxOa0NuNFhaNGhKRXJuYTNF?=
 =?utf-8?Q?x0U9I9ANavTnyaN1zQRiGoRCWksQg9f22NG8kGGz84=3D?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(376014)(7416014)(1800799024)(35042699022)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kRuLKsvHI9fMJcd5CV2/WZ5HdYsjgG46ST1ZbykenoqCYVV7xTUYx7yHGunp2MofRZQGAU+Ghdt5fh7hTVUw700YHV5h7phf5edL9QXMT9eG7MQgx1Xdm+Ka8iMs5ssJZU0NkMqGcmqrTtyC3UVA2+yEZ6GYFCVtu2r+fB5ulSCk1W1TAG6DZcQn7bl1grhv2WUpqMV8lxRbXfD/hhEkBC96neu5JMUsS5BUpl6C3TsTRY9iJuZepnRaGn3jA+BYM2QSQEO0dnaqeaWTKglRLUvGQp5I0BOldDcK8yq+2xx10Ta56T2hyB7bfl03+vV2a99DpjxgcfkWFgqx4IiIO/IK2ile3Rkk3in/0UoR513+iIuBQEfapoArwG7uLfbdgS26Yc+DBWCDMDAWTAD5pWXDkCbCovSyUNtDl0lE6sBv2vWNWxv3pSsF1LBssM1G
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:02:31.3343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9a0fbf-5996-4f02-01af-08de681628a7
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11012
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6531-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[axentia.se,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 78DF811450D
X-Rspamd-Action: no action

T24gMi85LzI2IDE1OjA4LCBQZXRlciBSb3NpbiB3cm90ZToNCj4gSGkhDQo+DQo+IDIwMjYtMDIt
MDkgYXQgMTM6MDcsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gT24gMDkvMDIvMjAyNiAxMzo0Mywg
UGV0ZXIgUm9zaW4gd3JvdGU6DQo+Pj4gSGkhDQo+Pj4NCj4+PiAyMDI2LTAyLTA5IGF0IDEyOjMx
LCBKb3N1YSBNYXllciB3cm90ZToNCj4+Pj4gSGkgUGV0ZXIsDQo+Pj4+DQo+Pj4+IE9uIDA5LzAy
LzIwMjYgMTM6MTAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+Pj4gSGkhDQo+Pj4+Pg0KPj4+Pj4g
MjAyNi0wMi0wOCBhdCAxNjozOCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4+Pj4gQWRkIHByb21w
dCBhbmQgaGVscCB0ZXh0IGZvciBDT05GSUdfTVVMVElQTEVYRVIgdG8gYWxsb3cgZW5hYmxpbmcg
dGhpcw0KPj4+Pj4+IG9wdGlvbiB0aG9ydWdoIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiB3aXRo
b3V0IGV4cGxpY2l0ICJzZWxlY3QiIGRyaXZlcg0KPj4+Pj4+IGRlcGVuZGVuY2llcy4NCj4+Pj4+
Pg0KPj4+Pj4+IFNlbGVjdCBpdCBieSBkZWZhdWx0IHdoZW4gQ09NUElMRV9URVNUIGlzIHNldCBm
b3IgYmV0dGVyIGNvdmVyYWdlLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEg
TWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgIGRyaXZl
cnMvbXV4L0tjb25maWcgfCA5ICsrKysrKysrLQ0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdXgvS2NvbmZpZyBiL2RyaXZlcnMvbXV4L0tjb25maWcNCj4+Pj4+PiBpbmRl
eCBjNjgxMzJlMzgxMzguLjRmN2M2YmI4NmZjNiAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJz
L211eC9LY29uZmlnDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9tdXgvS2NvbmZpZw0KPj4+Pj4+IEBA
IC00LDcgKzQsMTQgQEANCj4+Pj4+PiAgICAgIw0KPj4+Pj4+ICAgICANCj4+Pj4+PiAgICAgY29u
ZmlnIE1VTFRJUExFWEVSDQo+Pj4+Pj4gLQl0cmlzdGF0ZQ0KPj4+Pj4+ICsJdHJpc3RhdGUgIkdl
bmVyaWMgTXVsdGlwbGV4ZXIgU3VwcG9ydCINCj4+Pj4+PiArCWRlZmF1bHQgbSBpZiBDT01QSUxF
X1RFU1QNCj4+Pj4+PiArCWhlbHANCj4+Pj4+PiArCSAgVGhpcyBmcmFtZXdvcmsgaXMgZGVzaWdu
ZWQgdG8gYWJzdHJhY3QgbXVsdGlwbGV4ZXIgaGFuZGxpbmcgZm9yDQo+Pj4+Pj4gKwkgIGRldmlj
ZXMgdmlhIHZhcmlvdXMgR1BJTy0sIE1NSU8vUmVnbWFwIG9yIHNwZWNpZmljIG11bHRpcGxleGVy
DQo+Pj4+Pj4gKwkgIGNvbnRyb2xsZXIgY2hpcHMuDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsJICBJZiB1
bnN1cmUsIHNheSBuby4NCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gICAgIG1lbnUgIk11bHRpcGxleGVy
IGRyaXZlcnMiDQo+Pj4+Pj4gICAgIAlkZXBlbmRzIG9uIE1VTFRJUExFWEVSDQo+Pj4+Pj4NCj4+
Pj4+IEknbSBub3QgY29tZm9ydGFibGUgd2l0aCBtYWtpbmcgTVVMVElQTEVYRVIgYSB2aXNpYmxl
IHN5bWJvbC4gSXQgaXMgbWVhbnQgdG8NCj4+Pj4+IGJlIHNlbGVjdGVkIHdoZW4gbmVlZGVkIChh
bmQgdGhlcmUgYXJlIGEgZG96ZW4gb3Igc28gaW5zdGFuY2VzKS4gVGhlIGtidWlsZA0KPj4+Pj4g
ZG9jcyBoYXMgdGhpcyBvbiB0aGUgc3ViamVjdDoNCj4+Pj4+DQo+Pj4+PiAJIkluIGdlbmVyYWwg
dXNlIHNlbGVjdCBvbmx5IGZvciBub24tdmlzaWJsZSBzeW1ib2xzIChubyBwcm9tcHRzDQo+Pj4+
PiAJIGFueXdoZXJlKSBhbmQgZm9yIHN5bWJvbHMgd2l0aCBubyBkZXBlbmRlbmNpZXMuIg0KPj4+
PiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24gZGlkbid0IG1ha2UgdGhlIGRlY2lzaW9uIGxvZ2ljIGNs
ZWFyLA0KPj4+PiBhbmQgSSBwbGFuIHRvIHN1Ym1pdCBhIHN0YW5kYWxvbmUgcGF0Y2ggZm9yIHRo
aXMgYWZ0ZXIgdjcuMC1yYzEuDQo+Pj4+DQo+Pj4+IEJhc2ljYWxseSBleGlzdGluZyBkcml2ZXJz
IHVzaW5nIG11eCBjb3JlIHVzZWQgInNlbGVjdCIgdG8gZW5hYmxlIGl0LA0KPj4+PiBldmVuIHRo
b3VnaCB0aGUgY29yZSBjYW4gZnVuY3Rpb24gc3RhbmRhbG9uZSB3aXRoIGRldmljZS10cmVlLg0K
Pj4+Pg0KPj4+PiBTb21lIG9mIHRoZXNlIHVzZXJzIChwaHktY2FuLXRyYW5zY2VpdmVyKSBmdW5j
dGlvbiBwZXJmZWN0bHkNCj4+Pj4gcGVyZmVjdGx5IGZpbmUgd2l0aG91dCBtdXgsIGFuZCB1c2Ug
aXQgYXMgYW4gb3B0aW9uYWwgZmVhdHVyZS4NCj4+Pj4NCj4+Pj4gTGlrZWx5IGRyaXZlcnMgb25s
eSB1c2VkICJzZWxlY3QiIHRvIGF2b2lkIHdyaXRpbmcgaGVscGVyIGZ1bmN0aW9ucywNCj4+Pj4g
cHJvbXB0LCBrY29uZmlnIGRlc2NyaXB0aW9uIGFuZCBzdHVicyAtIHdoaWNoIHRoaXMgcGF0Y2gt
c2V0IGFkZGVkLg0KPj4+Pg0KPj4+PiBTbyBJIHdpbGwgYXJndWUgdGhhdCBzb21lIGV4aXN0aW5n
IHVzZXJzIHJlbHlpbmcgb24gInNlbGVjdCIgd2FzIHdyb25nLA0KPj4+PiBhbmQgdGhhdCB0aGUg
bXV4IGZyYW1ld29yayBpcyBnZW5lcmFsbHkgdXNlZnVsIG9uIGl0cyBvd24uDQo+Pj4gV2hlbiBJ
IHdyb3RlIHRoZSBtdXggc3ViLXN5c3RlbSBpdCB3YXMgdmVyeSBtdWNoIGludGVudGlvbmFsIGFu
ZCBieQ0KPj4+IGRlc2lnbiB0aGF0IGRyaXZlcnMgbmVlZGluZyBhIG11eCBzaG91bGQgc2VsZWN0
IE1VTFRJUExFWEVSLCBhbmQgdGhhdA0KPj4+IE1VTFRJUExFWEVSIHNob3VsZCBub3QgYmUgYSB2
aXNpYmxlIHN5bWJvbC4NCj4+IE5lZWQgaXMgYSBzdHJvbmcgd29yZCBoZXJlLCBhbmQgZG9lc24n
dCBhZGRyZXNzIHRoZSBvcHRpb25hbCBjYXNlLg0KPiAiTmVlZCIgd2FzIHRoZSBjb3JyZWN0IHZl
cmIgdXAgdW50aWwgeW91IG5lZWRlZCB0aGUgc3Vic3lzdGVtIHRvIGJlDQo+IG9wdGlvbmFsLiBJ
ZiB5b3UgbmVlZCB0aGUgbXV4IHN1YnN5c3RlbSB0byBiZSBvcHRpb25hbCwgeW91IG5lZWQgdG8N
Cj4gZG8gaXQgaW4gYSB3YXkgdGhhdCBkb2VzIG5vdCBpbnRyb2R1Y2UgaGVhZGFjaGVzLg0KPg0K
Pj4+IFlvdSBzYXkgdGhhdCBpdCBjb3VsZCBiZSB1c2VmdWwgdG8gaGF2ZSBpdCB2aXNpYmxlLCB3
aGljaCBpcyBhbGwgZmluZQ0KPj4+IEkgc3VwcG9zZS4gQnV0LCB5b3UgZmFpbCB0byBhZGRyZXNz
IHRoYXQgcXVvdGUgZnJvbSB0aGUga2J1aWxkIGRvY3MuDQo+Pj4gV2h5IGlzIGl0IE9LIHRvIGhh
dmUgdGhlIHByZWV4aXN0aW5nIGRyaXZlcnMgc2VsZWN0IGEgdmlzaWJsZSBzeW1ib2wsDQo+Pj4g
d2hlbiB0aGUga2J1aWxkIGRvY3VtZW50YXRpb24gc3RhdGVzIHRoYXQgaXQgc2hvdWxkIG5vdCBi
ZSBkb25lIHRoYXQNCj4+PiB3YXk/DQo+PiBJdCBtaWdodCBoYXZlIGJlZW4gb2theSBmb3IgYSB0
cmFuc2l0aW9uYWwgcGVyaW9kLg0KPiBXaGF0IHdvdWxkIGJlIG9rIGZvciBhIHRyYW5zaXRpb25h
bCBwZXJpb2Q/IEludHJvZHVjaW5nIHBvdGVudGlhbGx5DQo+IHByb2JsZW1hdGljIGtidWlsZCBk
ZXBlbmRlbmNpZXM/IEknZCByYXRoZXIgbm90Li4uDQo+DQo+PiBNeSBvcmlnaW5hbCBwYXRjaC1z
ZXQgaGFkIGFscmVhZHkgZXhwbG9kZWQgZHVlIHRvIHRoZSByZXF1ZXN0IHRvDQo+PiBpbnRyb2R1
Y2UgZ2VuZXJhbCBwdXJwb3NlIGRldm1fKl9vcHRpb25hbF8qIGhlbHBlcnMsDQo+PiBhbmQgdGhl
IGZhY3QgcGh5LWNhbi10cmFuc2NlaXZlciBhbHJlYWR5IGhhZCBhIGxvY2FsIHZlcnNpb24gb2Yg
dGhlIHNhbWUuDQo+Pg0KPj4gU28gcGVyaGFwcyBpZiBJIHdpbGwgc3VibWl0IGEgcGF0Y2gtc2V0
IGNoYW5naW5nIHRvIHZpc2libGUgc3ltYm9sLA0KPj4gSSBzaGFsbCBhbHNvIGNoYW5nZSB0aGUg
ZmV3IGRyaXZlcnMgdGhhdCBhcmUgbm93IHVzaW5nICJzZWxlY3QiPw0KPiBJIHRoaW5rIGl0IHdv
dWxkIGJlIHNpbXBsZXIgdG8gaW50cm9kdWNlIHNvbWUgbmV3IHZpc2libGUgc3ltYm9sDQo+IHRo
YXQgdHJpZ2dlcnMgc2VsZWN0IE1VTFRJUExFWEVSLA0KDQpDb25zaWRlcmluZyB0aGUgbGFyZ2Ug
bnVtYmVyIG9mIGV4aXN0aW5nIHVzZXJzLCBJIHRlbmQgdG8gYWdyZWUgaGVyZToNCg0KZHJpdmVy
cy9ncHUvZHJtL2JyaWRnZS9LY29uZmlnOiBzZWxlY3QgTVVMVElQTEVYRVINCmRyaXZlcnMvaTJj
L2J1c3Nlcy9LY29uZmlnOsKgIMKgIMKgc2VsZWN0IE1VTFRJUExFWEVSDQpkcml2ZXJzL2kyYy9t
dXhlcy9LY29uZmlnOsKgIMKgIMKgIHNlbGVjdCBNVUxUSVBMRVhFUg0KZHJpdmVycy9paW8vbXVs
dGlwbGV4ZXIvS2NvbmZpZzrCoCDCoCDCoCDCoCBzZWxlY3QgTVVMVElQTEVYRVINCmRyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vS2NvbmZpZzogc2VsZWN0IE1VTFRJUExFWEVSDQpkcml2ZXJzL210ZC9o
eXBlcmJ1cy9LY29uZmlnOsKgIMKgc2VsZWN0IE1VTFRJUExFWEVSDQpkcml2ZXJzL210ZC9tYXBz
L0tjb25maWc6wqAgwqAgwqAgwqBzZWxlY3QgTVVMVElQTEVYRVINCmRyaXZlcnMvbmV0L21kaW8v
S2NvbmZpZzrCoCDCoCDCoCDCoHNlbGVjdCBNVUxUSVBMRVhFUg0KZHJpdmVycy9waHkvdGkvS2Nv
bmZpZzogc2VsZWN0IE1VTFRJUExFWEVSDQpkcml2ZXJzL3BoeS90aS9LY29uZmlnOiBzZWxlY3Qg
TVVMVElQTEVYRVINCmRyaXZlcnMvcGh5L0tjb25maWc6wqAgwqAgc2VsZWN0IE1VTFRJUExFWEVS
DQpkcml2ZXJzL3NwaS9LY29uZmlnOsKgIMKgIHNlbGVjdCBNVUxUSVBMRVhFUg0KZHJpdmVycy9z
cGkvS2NvbmZpZzrCoCDCoCBzZWxlY3QgTVVMVElQTEVYRVINCnNvdW5kL3NvYy9jb2RlY3MvS2Nv
bmZpZzrCoCDCoCDCoCDCoHNlbGVjdCBNVUxUSVBMRVhFUg0KDQo+IG1ha2luZyBpdCBwZXJmZWN0
bHkgZmluZSB0bw0KPiBsZWF2ZSBhbGwgdGhlIGV4aXN0aW5nIHNlbGVjdCBNVUxUSVBMRVhFUiB1
c2VycyBhcy1pcz8NCkhvd2V2ZXIgSSB0aGluayBlYWNoIG9mIHRoZW0gc2hvdWxkIGJlIHJldmll
d2VkIGFzIHRvIHdoZXRoZXINCnRoZWlyIHVzZSBvZiBtdXggaXMgbWFuZGF0b3J5IG9yIG9wdGlv
bmFsIChwaHktY2FuLXRyYW5zY2VpdmVyKS4NCg0KQSAiZGVwZW5kcyIgcmVsYXRpb25zaGlwIG1p
Z2h0IGJlIGNsZWFyZXIgbG9uZy10ZXJtLA0KYW5kIHBlcmhhcHMgYWxsIHVzZXJzIHNob3VsZCBi
ZSBjb252ZXJ0ZWQgZXZlbnR1YWxseS4NCg0KSXQgaXMgcmF0aGVyIGZydXN0cmF0aW5nIHRoYXQg
dGhlIGNvbnNpZGVyYXRpb24gdG8gbWFrZSBtdXggZnJhbWV3b3JrDQphbiBvcHRpb25hbCBkZXBl
bmRlbmN5IHRvIGRyaXZlcnMsIHJhdGhlciB0aGFuIG1hbmRhdG9yeSwNCmNhbWUgYWZ0ZXIgc28g
bWFueSB1c2VzIHdlcmUgYWxyZWFkeSBlc3RhYmxpc2hlZC4NCg0KQW55IHN1Z2dlc3Rpb24gaG93
IHRvIG5hbWUgdGhlIG5ldyBjb25maWcgc3ltYm9sIHRoYXQgY2FuIGhhdmUNCmEgdmlzaWJsZSBw
cm9tcHQ/DQoNCi0gcmVnYXJkcw0KSm9zdWEgTWF5ZXINCg==


