Return-Path: <linux-can+bounces-6463-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IU1OZzcgWmDLQMAu9opvQ
	(envelope-from <linux-can+bounces-6463-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 12:31:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC4D8623
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 12:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F84830257A4
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0532937E;
	Tue,  3 Feb 2026 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="drH9xaeO";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="drH9xaeO"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021089.outbound.protection.outlook.com [52.101.70.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2152D1936;
	Tue,  3 Feb 2026 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.89
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118295; cv=fail; b=UrVd9Ul/xYEFftylplZCazbixiytHpfjgKtvfVfi13B4TiiaXAnWcf11X6ZWwHaa+zroAxfY4J/Vr7n8kU7EMz056Wz5ZyGrvzS4yjc2ithSej41pCeL2wULUK15d/SHZlS8B21EKAi6UIv8D+pk1QJxCrxmTpCJ4bGcrJxlC1A=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118295; c=relaxed/simple;
	bh=DmnwD202si/dTX4kngn5VJtMF0u2QiSO2sewkr7MWdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TjF+pauQqu8BHhMWDv7Tl1RpnemhsEijaeO0U+FPL7sqLBXxfWcJTSK94osZnUhDi0wZpTvJkAewu090Zm8TbRcdr2YgkikAQXDp5JvCLzbqZCe9jzrJjXgf6bXu8GJxI+HfmVF0rBivnZ/Bx/tGvXRp9lpU2kPIafeUrHE+AcQ=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=drH9xaeO; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=drH9xaeO; arc=fail smtp.client-ip=52.101.70.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nD6qYwOLS9SGO1IHxkBB4Bo8FGDe1doHhEF+iXCJIXCiRJzbx6OT7KRpTFF+nFznoLOQAYS6MfsdVufcSe5j9aoiOBFjih3iYU1xwOO2/q8ZQ4dUr/IqBDEcm/bQaBZhMHJHGEYSSfVEfwH3AwhLZ8Vf3vRaYMUs2bOa7XNKdwtOjzoZwVunjupnVZDsB/jdtkvDe/2Y4MSJBDnV6hABNQ51G2qS++bxUQC7cLopbfphEgdXYpwE+k8Hm/uBK8XEvlN/hkIOPQGSYBN7dfe3gqLjTuGcForQasyyp80RaA1TxvGsnscCv4t3GVworM6aD8eleBTnt/kaaY78lRN86g==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmnwD202si/dTX4kngn5VJtMF0u2QiSO2sewkr7MWdk=;
 b=UfoLeC2cdbDs02nR8bwo2JALlGrdqXibQU56Sd0VaDR5j4/FmPA4JiQ5T1dvfzadvTonlivmfP4V4OiIpz+g1jhZgWc44BNKquAZwyLB5Yp26F6jU7R/R3HAovn/x38es+Z1uPaWzz9JYiy+nxLjUt5PJOT02Fm/4mAR8urrikB9WtPDL36MqtriF8Jr7y8eu60xtZtQ5c8iohUflotIBbJZwJQomrTGfpLVVuIBz94hzrM8BycclRs9XwLpkl3T9uuo/hDSBIdQXb1we/eSZRG9wklbGSrPAp4sLmqzRhWa5Aq9bMWzlrpchnETmnSPD4mzhCuLbxueQIRLIbuK6w==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=atomide.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmnwD202si/dTX4kngn5VJtMF0u2QiSO2sewkr7MWdk=;
 b=drH9xaeOQxHBcY+h8vIk5wZbqdJf5niLfjlhf2FttgMEoXOUjHDDxvcGLrjYY0gIHehs8fSkH62R+g1klNwPRvCqNiyOMYg5tTo2kF9ryAmn5qjH7kad6aXdxMBuABq19hya+F23vwkUuh0r7IB7TAGUF04y5aGjqmutZB2dflo=
Received: from DU7PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::24) by PA1PR04MB10503.eurprd04.prod.outlook.com
 (2603:10a6:102:446::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:31:29 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::31) by DU7PR01CA0002.outlook.office365.com
 (2603:10a6:10:50f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 11:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Tue, 3 Feb 2026 11:31:29 +0000
Received: from emails-8694077-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-224.eu-west-1.compute.internal [10.20.6.224])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id DBBF3804CD;
	Tue,  3 Feb 2026 11:31:28 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1770118288; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=DmnwD202si/dTX4kngn5VJtMF0u2QiSO2sewkr7MWdk=;
 b=gBQ5RUnJpmPSh+xTOwPzULzfrTxNWMLbtMP7WRGfy8SIJhPRQonYN5IJhQMg90tuaWqmS
 ajTf5n0P3q1OS1mydHw2xUMpOcL0IKmSzIGHHaWwCg79uwz0GApYg0DC6p8tTBqa43WpW2T
 fp5Or9Z1aDMp6h4BQKN76g3wZa0n8sY=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1770118288;
 b=GimEAUMtTuPGWVXonb+vWvKqvgE43oI/hVOgw0BewV8/WpFcumBNwJuBFAtO/2f1Sre+D
 VhCPApmk+qOOn8Oph5zJQD+u+eanzaphlTrEHE3YHiWqzT8wzOQIDXkR12MzPjeKLhebMkZ
 OQYhFIdQD02Ch6IXUfgE91SI5npsZKA=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r73xyTRkaqX8v8D45NH7u2HHMNlPVtZnbsE40ZDwsUZjUolx7diumrsrUB2o8dlwcfrBukoeyhhHBrc9XZsYitQu0beH/MuzEotS1rTtAWBCPtsl/g1sE/CNgYrI5ngehXtWt6DWTZQZ8BrViF4/Cq8my9acRAyaQBYoxASRA5QHk/yv1HWlkZnPMhb0txCH5pUP3RkrYWeXDLx/hc+I5mLZBzu9lLAM0NNMqZiMH1/EUPGenfB6lPw8QBLTitH2eXz+6ZoKu7PHZK33AK2ZkAywJLc9C7odSz0k5R0wbSIsNrpwznnddDX+dNTqkbW7C5IPZb7NueJklDBXtrM5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmnwD202si/dTX4kngn5VJtMF0u2QiSO2sewkr7MWdk=;
 b=i9IzYAAeFHfeEu09A+h0opWdDVid1Dn2Qp3erBqEi0mSQaA5fjoUVekD7/55GCYVU7Wl+InPI8HTyx+3JKZH6D2BipRt9jBOOc45ZagxZi/7y7x0pMw2L3lpPQ8OFHGf5hwSvAVmb3r431APMH96jdaJr4ntpaL5o6PvmiojAjrIbYCNbl0l4rXKEocrjPiuP1kIerBS0e3OUo5JWXRqja+oNJGncf4hWbJf5VkMhikH702EV0SXfplDnOqlXXV4e18WW3v4SxaleaRvCpwPrLgHfeLpI5Ry4o5N+DBF9mB6Szw+9pwWGp6EdDoT1KfGd/orE00TpLMtxelm7tBZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmnwD202si/dTX4kngn5VJtMF0u2QiSO2sewkr7MWdk=;
 b=drH9xaeOQxHBcY+h8vIk5wZbqdJf5niLfjlhf2FttgMEoXOUjHDDxvcGLrjYY0gIHehs8fSkH62R+g1klNwPRvCqNiyOMYg5tTo2kF9ryAmn5qjH7kad6aXdxMBuABq19hya+F23vwkUuh0r7IB7TAGUF04y5aGjqmutZB2dflo=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AS5PR04MB10018.eurprd04.prod.outlook.com (2603:10a6:20b:67e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:31:18 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 11:31:18 +0000
From: Josua Mayer <josua@solid-run.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
	<aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman
	<khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
	<tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R
	<vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional and
 selected mux-state
Thread-Topic: [PATCH v7 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Thread-Index: AQHckGTeQp7u3kOOpk2xNnRQI4AIhbVpUZQAgAAB9ACAB4zoAA==
Date: Tue, 3 Feb 2026 11:31:18 +0000
Message-ID: <35e582a3-9311-4679-a18a-447973a4efe5@solid-run.com>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
 <CAPDyKFrBuL+747QUJJUejtcvjm0V7Lt=vHwjvcMdCt_h4=sFwg@mail.gmail.com>
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXgLR9yeLa5JKNdAOtNEirJ8263bmn1zRNAnKnmf8F-Sg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|AS5PR04MB10018:EE_|DB3PEPF00008860:EE_|PA1PR04MB10503:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d96698-6cd9-4133-8255-08de6317c602
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YWtydExwVVV5L1NRM1NvYmZETXBTMXdFUjJTR0FmUzM3WC91VGx0eEoxTHBS?=
 =?utf-8?B?TkcxU2lhdTRiV2FMYnVvK2o3dEtjdEcrL3Qzby9lZ2JKckdzUC9odWdzZ3pn?=
 =?utf-8?B?elRWc2dNWEJ2M0RYOUw5S3J6cEpTQWZjc2NTcURvRU52RzRmbkp3dUZlT2lG?=
 =?utf-8?B?S09QS05NTG1jSytCbVRpaFM2WklVQ21uaFFLOWlNTzc2dEhnL0gxUFFpTjEy?=
 =?utf-8?B?b1RuY2Z3czRNeG42OFg3YUtuOUVGSFhvWWV5K3F5NU9kWHNrVHFSY01pZXo3?=
 =?utf-8?B?dVVaanlwdVRTek5JMmRFWkpvTzljV0kyeHQybXkwWFlNNW83a2tuMUplSDc0?=
 =?utf-8?B?SEtCeHF0Y1p1QlFQMCt2dFdkNUViMkV5eUFtbkxiODNZcFZSYUdZa2gveTVU?=
 =?utf-8?B?ejYyUWVoaEJsbnZzZm5qdWtVdmwrRTBKOWVUcDdRTjRwUmVpQ3dZcTFrV2Zy?=
 =?utf-8?B?QjBucDdVZ285clJURlhqN1ZUbGZYVEZ5VjdRWWJVNFpVcnhyUEE2K1lTemd4?=
 =?utf-8?B?eHl2MVY0eldua09mNjh5Y1dEaUdFM0Y2U1dUanFvbkFDRkRyU01RMm1oNm5t?=
 =?utf-8?B?akY1T0cycGZsRm1YKysrNWJkWUp1UHlwa1N4OTUrUndoRHBBNGxtT1dCM0Qw?=
 =?utf-8?B?bFZ0RmFHNmNaVVRsTU1qUXBDK2J1UzZDanFMMGFpcHNyQm8rTUNjMG5XUmpi?=
 =?utf-8?B?UFdLaWc2Rk1YYzBsYUFEMGdJUys4Y0hESE5VWlRrdUdjdWQ1N1JONTF3dG9n?=
 =?utf-8?B?aDhaL05xV0M2ZlN4bmNyNXBySmNhZEJ4OFo1WklvZTB2QTZ3R2RLa3MxUmJv?=
 =?utf-8?B?QWljR1V6ck1ZWG5PWXlBWHg0dXN3Y3JISGdxeEt6RUhlZ1RjS215YkhoSWlV?=
 =?utf-8?B?Z0VMSDFMRTBsRVZGQ290Q0RDbWFreFFnVmN5aFZZaGtEZmg5K2o3emRPT09V?=
 =?utf-8?B?V2NmMEpKdHhhTE5nWkk2bWU2RDVJY2hMQWpwR2ZWYUZ4RnI5dllPMU9tVXVj?=
 =?utf-8?B?cjRqK25KOEF3ZFNEV1dFVUtCUXJES1dXemlSR2dpbUNjMStHU05vRVJDVWRr?=
 =?utf-8?B?K2lnV1dMN0M3YzR3TjBRMU5yeVQwS2IxaVRQcm9LU3BBUXY3WW5WZzBGRDdK?=
 =?utf-8?B?WGdUc25mbWpJZXNybG5NSExNVHU3L0o1ZmE2U0l6TktSRVIwNmpJUmZrM25a?=
 =?utf-8?B?bmwxbjFjdlphTDNCS1AzcjRFdlZJRlBtMWU3aFB2eWVZd04xYjB5SzRsbDRa?=
 =?utf-8?B?Y0VDeVpwQmNBU2p6LytHdXFUUzNwRVNCdUNhOUJnNmJ6T1k2cFhHNjhBTE1h?=
 =?utf-8?B?dm1ibXh4SlhWUDgvamtFc2grK09GNGppTGZ4ZFlzTnlpY3prQXBreU1MNW5N?=
 =?utf-8?B?NlZpejlaZ0lWUXoreVpPM1lHSVlkMlQyZFliTW9oVVhRQUVpZDE0YzFFNTEr?=
 =?utf-8?B?UUp5S0dqSGsvRXdZWEhmRVppUENHVW8rMDQ4OElxZVBQaVh4T25tZGxmVEM4?=
 =?utf-8?B?TFlHUWpydzUrd3BQTVNsNzQyVENoMVl6SEJFUUJadDU3SFJIMUJIQTNOUXNH?=
 =?utf-8?B?ZGVtaFk2L2QzbDJKNVJmdS8reVFLQmt5NUs4T2QwQmFmeHdmSUlRNzFVNG5K?=
 =?utf-8?B?enVKaGl4T1doTHM0cWpvWnFpZUt6MmgybDhZVGc4eVkxSHFEMHpka3NFQmlq?=
 =?utf-8?B?U05ObVVGUEZac29kanVFUnpnNE15S3RxbmM0NDc2NDFiZW1VcGs1NnhZWDlM?=
 =?utf-8?B?MzJRM3M1dXphSHh0REo4WVhDQlBmTHBmVzIwaDg3c1lwU0xUbDJYYitGeFk2?=
 =?utf-8?B?THJQMUpoR0NSL2pwYnMwOHRMLzV0MGRsS2xzS1ovenF2cGtGV255NmV3UHJa?=
 =?utf-8?B?U2M0SGxJaGVwRkVkU3NWZUhXVVJRWWJRVjYydXBuOWQrSDB2WFE2d3ArSDNa?=
 =?utf-8?B?OVA0amZrZ1Jlb2x5SmpDNENzSVZ1L01LcFpHNG1IdUs5cncwZGxqZ25aL0Vq?=
 =?utf-8?B?LzdRM25uWFc3dk03c0lXZUx0a1luUG1wbUVwbCtZRU9zUVYwZmdaclhZeVlJ?=
 =?utf-8?B?ZGQxSGNkSHdIZ3NKTVQ4T0F1Tk1JTVlDeUFXdVV0aFREbkpXYjdIMkFQaXRu?=
 =?utf-8?B?c3M2c3ZWUkZaR3BtT3JZMzMrd0Z6Rm5kZjdwajhYRGpLcVkvVVlUWktROWhj?=
 =?utf-8?Q?JZVX4ARoxEQdr74UscCu8J0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <A642F74222D4C64A8ADA41BDF36B9BBD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10018
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: b4a17a8279014956b866fdfd5428bcfc:solidrun,office365_emails,sent,inline:84c4398de5403a6356c3ddb453a79d6d
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2e4e2a18-3f4b-4ab5-77aa-08de6317bfaa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|7416014|376014|36860700013|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3cwVzNKYnBQZFM2MWNrdzVGOUNtak1FdXB2N0ZGcUh1d3RPeU1SOEtRSVJU?=
 =?utf-8?B?SXBJVEUyYWttcDQvb2ZoazZQNmloNGV2ZFdwN1dZYytLU2E1WlFWbWlwZ1Vn?=
 =?utf-8?B?ZHpoQnIzcXd3ak5BWXZUVXpvT04zc2VVdUJ1dFhVRkY1VU9qZTI3dVV2bFlT?=
 =?utf-8?B?RWprL05YS0RYZ0RqdUx6V29DSWJwdE5pa1hXSHZMWm16anlINGtlZXdUMGd3?=
 =?utf-8?B?V3JzNlFNVU4vRjVZdjNiSWtOc3lpbXNpSGF0T2c4cjhpdzhNNU8vWlZZUVN0?=
 =?utf-8?B?OTJIS2R1Yzc1VzNNcUQvZ25OVW9mT0ZFZVhBRHVGb3A1TmlVQTkwYVo5UUNa?=
 =?utf-8?B?VHd2dkxXWEhNcnZqRFdTYUZVdWE3SjhwQlQ1dTdCWHYwb0VZVlVyVjc2VjlE?=
 =?utf-8?B?dHRmVkZDdUNZUWF0UVMzaWJ2WkVGNG5NUk1EcUIvdEhzaUVMc0taWEFuR2dS?=
 =?utf-8?B?WXd5djdKL1NOWS9TMXVVRlcxczduY1JTQXU3MDZIbHpjclhrQnkzbkI1WVBR?=
 =?utf-8?B?bFNaMzU0RGEzOUg3MnRVM0NsaWQ0bEJkeTFHbXhWQlJRSjdQck16TWNFMEJi?=
 =?utf-8?B?OGFzMnFsM25LTE5pQjlDelFTK3Z4OFRqT3Z6c3J3N3NnUUUxY0ZJR051aGla?=
 =?utf-8?B?aDhEdGUwOGtkRGVxTEs3OGt5UjJKOFpLU0ZXVjd0NlI2dVpkZFhzcHdoSWZk?=
 =?utf-8?B?NVlKaGxCclIxeHp6bUZvVzF4MW5rb0N2Wk5JSDZmMEM3KzlQS0dLKzZSamtL?=
 =?utf-8?B?Nm1USVZOZVc3azRpMHY5Q0VWYmNEMzRjOE9UVW5QK2ZtUkJRWVppUGIzNkh1?=
 =?utf-8?B?b3VyazNrYk50NFFzL2pQV2U5U1poNm9oN2JxdGVmNlB3NEhjTXI4a2tGa0pR?=
 =?utf-8?B?bkRpWlh2cTRCVVZLUjZZTU9rTlAvZWVBZ3VBRUkrU2Y4d3pleVJURmNHWmFO?=
 =?utf-8?B?RGFzaDJESVI2MjF3YzhTSkxEOCtadlVVeW44eUNWUTd3UXVLeCsybVFaaXNY?=
 =?utf-8?B?YWc3Y3dOOTNFbk1qYTlzdmx0TDJadmwxSlMwMDNKeUlRVTc5UTVZZzRDc0U4?=
 =?utf-8?B?Rkx3bVR3OHZtRitjTDBpVURac1h0NmlqTWJaR3ArMG9TR0xWVVVOQUpLc3Jz?=
 =?utf-8?B?cG5FWEdCVEZtWE0wMDBqZW85MkVCM0JCWHI1UU5GcWpmcWx2WWFXQ2dCU3lq?=
 =?utf-8?B?M2tocWd4WE1VZ3ZKYXZCRUtySGpUTnN5RzVLNE1ZakdLNEdOc2pGelBmZlpm?=
 =?utf-8?B?clVwNEN1TGVjVG00SEdRbktYZ3JwNGJ6MERKV1ljanZNbXRCaFBwaXVMKzZ4?=
 =?utf-8?B?SjFlWCt5N1lvVVNQTzVZN2JwNHlramQ2Zko5MFRrRmtZb29NaTFNZXZ5THJx?=
 =?utf-8?B?eloxWFdwY3VOZkNidzU2cmgzSUNmdHNXYWJYNW5yV2Yxd0ZiRU01WGg0SU54?=
 =?utf-8?B?c1BqRU5taElFWVhOS0poZ0t3LzJWbm5lc2dhS0dMUnZyOGxmUUdjV0JHOFdX?=
 =?utf-8?B?TkNoY0hKWnF4Tk5qditodWswaFJrVDJlTnIzbnEydW4yR25teFRDS2s3SWJ5?=
 =?utf-8?B?enI0SkJsNDRCS3d3TkFwRlg5SmdKZHpsaVVka1l6U1kvUzlNN0QzUGN1QzFL?=
 =?utf-8?B?ZlFDOHB4QUFnN045anJFQmQ3M3dKdG0xMGtjV2dVRWJiMEE1NnhkVlAzVTZp?=
 =?utf-8?B?TWVQNVZVNGVWWWZGMDN5Rk1NQ284aWltTW1MR1phaTltZEpsOUJEN3hsdTVz?=
 =?utf-8?B?YXhTY2VpTGR3Ujgrb3pjVnRXYmIxZjZpM3ZqWkltbitaOHAvS2NrYThCT3hr?=
 =?utf-8?B?K043NEtBYzQwTkpQSjRQTEVtS1ViZGZHMkdmN3VQVm95Sk9lbHpYQVIvOGRQ?=
 =?utf-8?B?NWdpVk5TQyttV3R1SnJsU2JsaXZxSitsMmRxWXlFYmZ4ZWc3TWZaWDZuOEsw?=
 =?utf-8?B?NUYraDcrSlRSQU5xSFFPZ2U0QStVK3lCUVdsd0NWdTF5elRyV1ZxeGtQc1Bp?=
 =?utf-8?B?cTNLMnNaenprOHJEUllkOWVYanFoSmdpT3ZvazlpUjFwUzUxVEJlUWFhWVRJ?=
 =?utf-8?B?Tmx5VFpkSVVNS3JwKzVsaGxGQ1JPT3g3UUN5UG90aWNNV2JNenMrcWxBZFl3?=
 =?utf-8?B?Q2xQY25pSkw5TWhaajdHUWZRd0NUTXYyaWdBMWtMbTVBWko0SFp1T1NUaEMw?=
 =?utf-8?B?UkhwdEN2MVJaUWM4b29vZTBiTnJUK1o0N1NVV2pRb2RKQVpKeEZZL0xtbE9p?=
 =?utf-8?B?eHp0NitmTkxFcmFZdmNBR1VjZUxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(7416014)(376014)(36860700013)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nK0GBRokZe3gMVzHGR9Z+jotPs31I2YdGW9asXpR9kIL8NhDvlvxvktju9Dke8CbhNCtIlIUzaUWp5kGCqjWkXmz2lIaU7Z3ZbIGoqaBnt7e+oXFbodvtmaXad5qy4GToIwc1RKRHXOc4hLdPpvzu3P3ymNW0ta/grqTyJjqDStrP1xD8x2pcu8ZbIQqpuZhK5BTX+lE3jJsDxrARa2I5Eh83iuZ/1ZQUdbBYBwdVSMq6eayW6y/Nu7O3bmns1C63YWqrdkyhT1SJXcOwkBdUGEBUOKg7VMa9Z/RzRC/tNKrSLoufaHMAlfzTOMVKsBaEeqGWmOFBARcSnFosp4UWWQhsm5GsayNhn2MeLlZ+rmhvWE5dGrgFvfcHqcA8FhhaLXl4Ij/deY4Z3MWDFzWKjT3O+AJgjvgWOFd62XhxAX4WGkbbnGw+3sJ/KAoe4XG
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:31:29.0199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d96698-6cd9-4133-8255-08de6317c602
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10503
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=4];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6463-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,solidrn.onmicrosoft.com:dkim,solid-run.com:mid,solid-run.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8AFC4D8623
X-Rspamd-Action: no action

T24gMjkvMDEvMjAyNiAxODoxMywgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBPbiBUaHUs
IDI5IEphbiAyMDI2IGF0IDE3OjA2LCBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9y
Zz4gd3JvdGU6DQo+PiBPbiBXZWQsIDI4IEphbiAyMDI2IGF0IDE1OjQ2LCBKb3N1YSBNYXllciA8
am9zdWFAc29saWQtcnVuLmNvbT4gd3JvdGU6DQo+Pj4gSW4tdHJlZSBwaHktY2FuLXRyYW5zY2Vp
dmVyIGRyaXZlciBoYXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBhIGxvY2FsDQo+Pj4gdmVyc2lvbiBv
ZiBkZXZtX211eF9zdGF0ZV9nZXRfb3B0aW9uYWwuDQo+Pj4NCj4+PiBUaGUgb21hcC1pMmMgZHJp
dmVyIGdldHMgYW5kIHNlbGVjdHMgYW4gb3B0aW9uYWwgbXV4IGluIGl0cyBwcm9iZQ0KPj4+IGZ1
bmN0aW9uIHdpdGhvdXQgdXNpbmcgYW55IGhlbHBlci4NCj4+Pg0KPj4+IEFkZCBuZXcgaGVscGVy
IGZ1bmN0aW9ucyBjb3ZlcmluZyBib3RoIGFmb3JlbWVudGlvbmVkIHVzZS1jYXNlczoNCj4+Pg0K
Pj4+IC0gbXV4X2NvbnRyb2xfZ2V0X29wdGlvbmFsOg0KPj4+ICAgIEdldCBhIG11eC1jb250cm9s
IGlmIHNwZWNpZmllZCBpbiBkdCwgcmV0dXJuIE5VTEwgb3RoZXJ3aXNlLg0KPj4+IC0gZGV2bV9t
dXhfc3RhdGVfZ2V0X29wdGlvbmFsOg0KPj4+ICAgIEdldCBhIG11eC1zdGF0ZSBpZiBzcGVjaWZp
ZWQgaW4gZHQsIHJldHVybiBOVUxMIG90aGVyd2lzZS4NCj4+PiAtIGRldm1fbXV4X3N0YXRlX2dl
dF9zZWxlY3RlZDoNCj4+PiAgICBHZXQgYW5kIHNlbGVjdCBhIG11eC1zdGF0ZSBzcGVjaWZpZWQg
aW4gZHQsIHJldHVybiBlcnJvciBvdGhlcndpc2UuDQo+Pj4gLSBkZXZtX211eF9zdGF0ZV9nZXRf
b3B0aW9uYWxfc2VsZWN0ZWQ6DQo+Pj4gICAgR2V0IGFuZCBzZWxlY3QgYSBtdXgtc3RhdGUgaWYg
c3BlY2lmaWVkIGluIGR0LCByZXR1cm4gZXJyb3Igb3IgTlVMTC4NCj4+Pg0KPj4+IEV4aXN0aW5n
IG11eF9nZXQgaGVscGVyIGZ1bmN0aW9uIGlzIGNoYW5nZWQgdG8gdGFrZSBhbiBleHRyYSBhcmd1
bWVudA0KPj4+IGluZGljYXRpbmcgd2hldGhlciB0aGUgbXV4IGlzIG9wdGlvbmFsLg0KPj4+IElu
IHRoaXMgY2FzZSBubyBlcnJvciBpcyBwcmludGVkLCBhbmQgTlVMTCByZXR1cm5lZCBpbiBjYXNl
IG9mIEVOT0VOVC4NCj4+Pg0KPj4+IENhbGxpbmcgY29kZSBpcyBhZGFwdGVkIHRvIGhhbmRsZSBO
VUxMIHJldHVybiBjYXNlLCBhbmQgdG8gcGFzcyBvcHRpb25hbA0KPj4+IGFyZ3VtZW50IGFzIHJl
cXVpcmVkLg0KPj4+DQo+Pj4gVG8gc3VwcG9ydCBhdXRvbWF0aWMgZGVzZWxlY3QgZm9yIF9zZWxl
Y3RlZCBoZWxwZXIsIGEgbmV3IHN0cnVjdHVyZSBpcw0KPj4+IGNyZWF0ZWQgc3RvcmluZyBhbiBl
eGl0IHBvaW50ZXIgc2ltaWxhciB0byBjbG9jayBjb3JlIHdoaWNoIGlzIGNhbGxlZCBvbg0KPj4+
IHJlbGVhc2UuDQo+Pj4NCj4+PiBUbyBmYWNpbGl0YXRlIGNvZGUgc2hhcmluZyBiZXR3ZWVuIG9w
dGlvbmFsL21hbmRhdG9yeS9zZWxlY3RlZCBoZWxwZXJzLA0KPj4+IGEgbmV3IGludGVybmFsIGhl
bHBlciBmdW5jdGlvbiBpcyBhZGRlZCB0byBoYW5kbGUgcXVpZXQgKG9wdGlvbmFsKSBhbmQNCj4+
PiB2ZXJib3NlIChtYW5kYXRvcnkpIGVycm9ycywgYXMgd2VsbCBhcyBzdG9yaW5nIHRoZSBjb3Jy
ZWN0IGNhbGxiYWNrIGZvcg0KPj4+IGRldm0gcmVsZWFzZTogX19kZXZtX211eF9zdGF0ZV9nZXQN
Cj4+Pg0KPj4+IER1ZSB0byB0aGlzIHN0cnVjdHVyZSBkZXZtX211eF9zdGF0ZV9nZXRfKl9zZWxl
Y3RlZCBjYW4gbm8gbG9uZ2VyIHByaW50DQo+Pj4gYSB1c2VmdWwgZXJyb3IgbWVzc2FnZSB3aGVu
IHNlbGVjdCBmYWlscy4gSW5zdGVhZCBjYWxsZXJzIHNob3VsZCBwcmludA0KPj4+IGVycm9ycyB3
aGVyZSBuZWVkZWQuDQo+Pj4NCj4+PiBDb21taXQgZTE1M2ZkZWE5ZGIwNCAoInBoeTogY2FuLXRy
YW5zY2VpdmVyOiBSZS1pbnN0YXRlICJtdXgtc3RhdGVzIg0KPj4+IHByb3BlcnR5IHByZXNlbmNl
IGNoZWNrIikgbm90ZWQgdGhhdCAibXV4X2dldCgpIGFsd2F5cyBwcmludHMgYW4gZXJyb3INCj4+
PiBtZXNzYWdlIGluIGNhc2Ugb2YgYW4gZXJyb3IsIGluY2x1ZGluZyB3aGVuIHRoZSBwcm9wZXJ0
eSBpcyBub3QgcHJlc2VudCwNCj4+PiBjb25mdXNpbmcgdGhlIHVzZXIuIg0KPj4+DQo+Pj4gVGhl
IGZpcnN0IGVycm9yIG1lc3NhZ2UgY292ZXJzIHRoZSBjYXNlIHRoYXQgYSBtdXggbmFtZSBpcyBu
b3QgbWF0Y2hlZA0KPj4+IGluIGR0LiBUaGUgc2Vjb25kIGVycm9yIG1lc3NhZ2UgaXMgYmFzZWQg
b24gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2FyZ3MNCj4+PiByZXR1cm4gdmFsdWUuDQo+Pj4NCj4+
PiBJbiBvcHRpb25hbCBjYXNlIG5vIGVycm9yIGlzIHByaW50ZWQgYW5kIE5VTEwgaXMgcmV0dXJu
ZWQuDQo+Pj4gVGhpcyBlbnN1cmVzIHRoYXQgdGhlIG5ldyBoZWxwZXIgZnVuY3Rpb25zIHdpbGwg
bm90IGNvbmZ1c2UgdGhlIHVzZXINCj4+PiBlaXRoZXIuDQo+Pj4NCj4+PiBXaXRoIHRoZSBhZGRp
dGlvbiBvZiBvcHRpb25hbCBoZWxwZXIgZnVuY3Rpb25zIGl0IGJlY2FtZSBjbGVhciB0aGF0DQo+
Pj4gZHJpdmVycyBzaG91bGQgY29tcGlsZSBhbmQgbGluayBldmVuIGlmIENPTkZJR19NVUxUSVBM
RVhFUiB3YXMgbm90IGVuYWJsZWQuDQo+Pj4gQWRkIHN0dWJzIGZvciBhbGwgc3ltYm9scyBleHBv
cnRlZCBieSBtdXggY29yZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxq
b3N1YUBzb2xpZC1ydW4uY29tPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9tdXgvY29yZS5jICAg
ICAgICAgICB8IDE3OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+Pj4gICBpbmNsdWRlL2xpbnV4L211eC9jb25zdW1lci5oIHwgMTA4ICsrKysrKysrKysrKysr
KysrKysrKysrKystDQo+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDI1MyBpbnNlcnRpb25zKCspLCAz
MyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL211eC9jb3JlLmMg
Yi9kcml2ZXJzL211eC9jb3JlLmMNCj4+PiBpbmRleCBhMzg0MGZlMDk5NWYuLmIwMWVjMTI2Y2Fh
ZiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL211eC9jb3JlLmMNCj4+PiArKysgYi9kcml2ZXJz
L211eC9jb3JlLmMNCj4+IFsuLi5dDQo+Pg0KPj4+ICAgc3RhdGljIHZvaWQgZGV2bV9tdXhfc3Rh
dGVfcmVsZWFzZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKnJlcykNCj4+PiAgIHsNCj4+PiAt
ICAgICAgIHN0cnVjdCBtdXhfc3RhdGUgKm1zdGF0ZSA9ICooc3RydWN0IG11eF9zdGF0ZSAqKily
ZXM7DQo+Pj4gKyAgICAgICBzdHJ1Y3QgZGV2bV9tdXhfc3RhdGVfc3RhdGUgKmRldm1fc3RhdGUg
PSByZXM7DQo+Pj4NCj4+PiAtICAgICAgIG11eF9zdGF0ZV9wdXQobXN0YXRlKTsNCj4+PiArICAg
ICAgIGlmIChkZXZtX3N0YXRlLT5leGl0KQ0KPj4+ICsgICAgICAgICAgICAgICBkZXZtX3N0YXRl
LT5leGl0KGRldm1fc3RhdGUtPm1zdGF0ZSk7DQo+Pj4gKw0KPj4+ICsgICAgICAgbXV4X3N0YXRl
X3B1dChkZXZtX3N0YXRlLT5tc3RhdGUpOw0KPj4+ICAgfQ0KPj4+DQo+Pj4gICAvKioNCj4+PiAt
ICogZGV2bV9tdXhfc3RhdGVfZ2V0KCkgLSBHZXQgdGhlIG11eC1zdGF0ZSBmb3IgYSBkZXZpY2Us
IHdpdGggcmVzb3VyY2UNCj4+PiAtICogICAgICAgICAgICAgICAgICAgICAgIG1hbmFnZW1lbnQu
DQo+Pj4gLSAqIEBkZXY6IFRoZSBkZXZpY2UgdGhhdCBuZWVkcyBhIG11eC1jb250cm9sLg0KPj4+
IC0gKiBAbXV4X25hbWU6IFRoZSBuYW1lIGlkZW50aWZ5aW5nIHRoZSBtdXgtY29udHJvbC4NCj4+
PiArICogX19kZXZtX211eF9zdGF0ZV9nZXQoKSAtIEdldCB0aGUgb3B0aW9uYWwgbXV4LXN0YXRl
IGZvciBhIGRldmljZSwNCj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgd2l0aCByZXNv
dXJjZSBtYW5hZ2VtZW50Lg0KPj4+ICsgKiBAZGV2OiBUaGUgZGV2aWNlIHRoYXQgbmVlZHMgYSBt
dXgtc3RhdGUuDQo+Pj4gKyAqIEBtdXhfbmFtZTogVGhlIG5hbWUgaWRlbnRpZnlpbmcgdGhlIG11
eC1zdGF0ZS4NCj4+PiArICogQG9wdGlvbmFsOiBXaGV0aGVyIHRvIHJldHVybiBOVUxMIGFuZCBz
aWxlbmNlIGVycm9ycyB3aGVuIG11eCBkb2Vzbid0IGV4aXN0Lg0KPj4+ICsgKiBAaW5pdDogT3B0
aW9uYWwgZnVuY3Rpb24gcG9pbnRlciBmb3IgbXV4LXN0YXRlIG9iamVjdCBpbml0aWFsaXNhdGlv
bi4NCj4+PiArICogQGV4aXQ6IE9wdGlvbmFsIGZ1bmN0aW9uIHBvaW50ZXIgZm9yIG11eC1zdGF0
ZSBvYmplY3QgY2xlYW51cCBvbiByZWxlYXNlLg0KPj4+ICAgICoNCj4+PiAgICAqIFJldHVybjog
UG9pbnRlciB0byB0aGUgbXV4LXN0YXRlLCBvciBhbiBFUlJfUFRSIHdpdGggYSBuZWdhdGl2ZSBl
cnJuby4NCj4+PiAgICAqLw0KPj4+IC1zdHJ1Y3QgbXV4X3N0YXRlICpkZXZtX211eF9zdGF0ZV9n
ZXQoc3RydWN0IGRldmljZSAqZGV2LA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBjaGFyICptdXhfbmFtZSkNCj4+PiArc3RhdGljIHN0cnVjdCBtdXhfc3Rh
dGUgKl9fZGV2bV9tdXhfc3RhdGVfZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAq
bXV4X25hbWUsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgb3B0aW9uYWwsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCAoKmluaXQpKHN0cnVjdCBtdXhfc3RhdGUgKm1zdGF0ZSksDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAoKmV4aXQp
KHN0cnVjdCBtdXhfc3RhdGUgKm1zdGF0ZSkpDQo+Pj4gICB7DQo+Pj4gLSAgICAgICBzdHJ1Y3Qg
bXV4X3N0YXRlICoqcHRyLCAqbXN0YXRlOw0KPj4+ICsgICAgICAgc3RydWN0IGRldm1fbXV4X3N0
YXRlX3N0YXRlICpkZXZtX3N0YXRlOw0KPj4+ICsgICAgICAgc3RydWN0IG11eF9zdGF0ZSAqbXN0
YXRlOw0KPj4+ICsgICAgICAgaW50IHJldDsNCj4+Pg0KPj4+IC0gICAgICAgcHRyID0gZGV2cmVz
X2FsbG9jKGRldm1fbXV4X3N0YXRlX3JlbGVhc2UsIHNpemVvZigqcHRyKSwgR0ZQX0tFUk5FTCk7
DQo+Pj4gLSAgICAgICBpZiAoIXB0cikNCj4+PiArICAgICAgIGRldm1fc3RhdGUgPSBkZXZyZXNf
YWxsb2MoZGV2bV9tdXhfc3RhdGVfcmVsZWFzZSwgc2l6ZW9mKCpkZXZtX3N0YXRlKSwgR0ZQX0tF
Uk5FTCk7DQo+Pj4gKyAgICAgICBpZiAoIWRldm1fc3RhdGUpDQo+Pj4gICAgICAgICAgICAgICAg
ICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4+Pg0KPj4+IC0gICAgICAgbXN0YXRlID0gbXV4
X3N0YXRlX2dldChkZXYsIG11eF9uYW1lKTsNCj4+PiAtICAgICAgIGlmIChJU19FUlIobXN0YXRl
KSkgew0KPj4+IC0gICAgICAgICAgICAgICBkZXZyZXNfZnJlZShwdHIpOw0KPj4+IC0gICAgICAg
ICAgICAgICByZXR1cm4gbXN0YXRlOw0KPj4+ICsgICAgICAgbXN0YXRlID0gbXV4X3N0YXRlX2dl
dChkZXYsIG11eF9uYW1lLCBvcHRpb25hbCk7DQo+Pj4gKyAgICAgICBpZiAoSVNfRVJSX09SX05V
TEwobXN0YXRlKSkgew0KPj4+ICsgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKG1zdGF0ZSk7
DQo+PiBTaG91bGQgdGhpcyBiZSBQVFJfRVJSX09SX1pFUk8/DQo+ICJtdXhfc3RhdGVfZ2V0KCkg
bmV2ZXIgcmV0dXJucyBOVUxMIg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy8yMDI2MDEyMjEw
MzYuSjBrUjc4VXctbGtwQGludGVsLmNvbQ0KDQptdXhfc3RhdGVfZ2V0IGFmdGVyIG15IG1vZGlm
aWNhdGlvbnMgZG9lcyByZXR1cm4gTlVMTDoNCg0KIMKgIMKgIGlmIChtdXhfbmFtZSkgew0KIMKg
IMKgIMKgIMKgIC4uLg0KIMKgIMKgIMKgIMKgIGlmIChpbmRleCA8IDAgJiYgb3B0aW9uYWwpIHsN
CiDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gTlVMTDsNCiDCoCDCoCDCoCDCoCAuLi4NCiDCoCDC
oCB9DQouLi4NCiDCoCDCoCBpZiAocmV0KSB7DQogwqAgwqAgwqAgwqAgaWYgKG9wdGlvbmFsICYm
IHJldCA9PSAtRU5PRU5UKQ0KIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBOVUxMOw0KLi4uDQoN
Cj4NCj4+PiArICAgICAgICAgICAgICAgZ290byBlcnJfbXV4X3N0YXRlX2dldDsNCj4+PiAgICAg
ICAgICB9DQo+IEdye29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgR2VlcnQNCj4NCg0K


