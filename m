Return-Path: <linux-can+bounces-4341-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E756CB33745
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 09:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5F81B2075E
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 07:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECF2BE03C;
	Mon, 25 Aug 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TIukRtx4"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C72BDC28;
	Mon, 25 Aug 2025 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105324; cv=fail; b=hKf6g6AYbB9qa8u3IoIOoRFGPi8znBLFOvpmuCEuFXZgLNFUAAB3yuL0FLxNvWwo4oKSpFFmyn/uK9riQ9RiU9zdSTvRTVqorMamCQkJkf+IB+mCnyZ7BLNaL3BW2bIgFHw5zoxKBi8XHg8tpDara0QhnFgE1HbkBI8+hsa0Ft8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105324; c=relaxed/simple;
	bh=sg1mCBVjrV/ea9bWQfMds5PJVjIvz+mFUd8wJSv2G0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glUc4nUDNXHRHVqoIO7REidIexZJaxPIHer/kBX8vA0J7dXdKWQ+a0xyjs7jLyko2FhLkVxQNrcdyLukkBxPFDKrqWP3YGDGDXlDC//E59mjVAxZlxNYg09Z8SdvmAfDEvf652UzFzxC81+ADg0/eUHOt7k0XyajY2D+rM5GIGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TIukRtx4; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgKN4lKcrnUaVlKOkHA2Fjf+/7H/frLyma7+nhMUJjoqvBZOc5rWEsZkkHqH5zpJsrUNoDz20QkZz2mLCTbiFEUEVaj3+HYNpuoPR4AJ0TGx+PcgnI6n0y7gJJsvHsUzAEcqWrJWCaSYTt7wjBWO8g9X9/5p94FwP0q6qwgjoKqMSS9W9Q5AzRIOQIgchsTRhspKXMBkQRf7Os8LI2ehz+wtyim+mXfbUoFwnT6WIdtI2Gq+u9XCWETNsB+NIrzyKSNEDOSbeozcMhAhcYWsTQ55G4O5xsfXOqp/rD7+0nMYTxtKmu/i/4iRs3aWAyNfW052R/efqwSsSzwsLA/E3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg1mCBVjrV/ea9bWQfMds5PJVjIvz+mFUd8wJSv2G0c=;
 b=Q59OYpOCWy1BxJwSVCf7FtcISXYqPRso1Dj7HmKARIHVvUsbFn5iKq9X+uNGUdclG/RpMH/ovpJe1QRz2B7e2xXG7Mj1TILbplruE7/VeiyMU9Vu4chGHIpUspi1y6rqaT7KO49wFwryBwwivZEPJKkqedCTgPzCE6mdldLkOE7VuyRJojjfnBFuh4XRJAnMsuylI+Wil9W69W/OArmo0DCrJ8c5gzPIpRUJHFxdg2eBJwPoRuom2ZQMwEaQhQprAc06qrmijhjCGDTrtgt/OxMx7cHBoGGblzIGi8DnySTLftZqyUD77Etzn1edrRZG4p5FMH/omOrv1cvcaHjOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg1mCBVjrV/ea9bWQfMds5PJVjIvz+mFUd8wJSv2G0c=;
 b=TIukRtx41/04TQy/kq82zNi/OQBS+1lGx7yUI/K1RFM26ysqzSl5z5K8bJLY+ScsgmJL2sATAX8NDdmp/DwIqqtWbvHG6HPUFX6Qf3giDZoXFvnS7V0xlTN4ASHWF0uoyJ05oyfa93n9Q1Ibe1OqZccuHlPDwyeTkIdrFrHnqboxVn4CIppBdHNatr331oqZlb6/UsxDgDWHbD6foe06xTqXq9kLqWhvZhKgW+WkUafSVxR7l/xOMN4KMTp0JAsfUIk79VSGhX6wGePE1JZAOC4IhMdYgijeJpqDO7rH1m32ATPVj7zE/2Y7DbH5IN4HaHsl+ouuftZ/CpMt9TJzpQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 07:01:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 07:01:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Maud Spierings <maudspierings@gocontroll.com>
CC: "a-govindraju@ti.com" <a-govindraju@ti.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	Frank Li <frank.li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "kishon@kernel.org" <kishon@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "mailhol.vincent@wanadoo.fr"
	<mailhol.vincent@wanadoo.fr>, "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH 2/6] phy: phy-can-transceiver: Add support for NXP TJA1051
Thread-Topic: [PATCH 2/6] phy: phy-can-transceiver: Add support for NXP
 TJA1051
Thread-Index: AQHcExoSUnxd0gULoE2wg5azTlggmbRuREkAgASxoKA=
Date: Mon, 25 Aug 2025 07:01:57 +0000
Message-ID:
 <PAXPR04MB8459009CF8AC91D3F71060E8883EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250822-can-v1-2-c075f702adea@nxp.com>
 <060439dd-3df8-4d0b-8957-83b75dc13537@gocontroll.com>
In-Reply-To: <060439dd-3df8-4d0b-8957-83b75dc13537@gocontroll.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
x-ms-office365-filtering-correlation-id: 2ba2a6a7-e36c-4594-6b34-08dde3a5481c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFBkWitCTUdYRXcyN1krMmt3bmV1eVdSQWFvZkNVb1daYytTMXhXcFQ1dlNu?=
 =?utf-8?B?akVFZFFjdkcxbEZmNmFGd1U5dGxxQUFHZ0dJSkNmQjR6MVoyVjUwZTkwNEtl?=
 =?utf-8?B?QXVDZkRBa2V1ZnA3YlhLdUUrV1RXdEZHdGtYYjQ4a04xM1BBRXlWQUhaVldm?=
 =?utf-8?B?UGJMWmlQbVBId3JpUmJ5SHRXZU9kcHhBTXFUTE5RanRXbzhvV0R4VWNBc1NZ?=
 =?utf-8?B?eXpVMlhiUXVJdFNycmdmbjVMc1BXR3F5YytRdXlkK3dNdFNsVDcxOGc1YzZS?=
 =?utf-8?B?U2c3VUlWYmwwTVRRd0Z6bTA3b0FubnVUWSsvYitNMlRwT25OVDk2aktsU1Fv?=
 =?utf-8?B?WWl5WURpZVltVi8yblBxTkI1WHlMWGFKejJqL09hdDRtbGJBWCtLY254M0po?=
 =?utf-8?B?NmhHNE5ZR2pKMGZFL0plU3BmQmplQi91MWhkMzBuUXhqOEh1OXRiUEVFV0w0?=
 =?utf-8?B?YkdsT2RORkI4ZDdEWFZZQXZ3bmNXNmdhZE5Yb2tQNW5hNTQyVFRSRUYzWDFv?=
 =?utf-8?B?ZVZSUldPOVZjOUxSTUZzS2QyR1dHNUo0dktNblBudmVjSnRGQjV1NjMwQ0h2?=
 =?utf-8?B?ckh3S0Mrc3g4dUV5RndSSlNQL0xyQjlMQjI2Zkp6NEJCL1d6V0N3dVZadzJ6?=
 =?utf-8?B?Smx2YmdNVDVJVlV6eGprZ0F3dThyNjd3aTl1Z2NNT3FoTXdYdDA5YmtvTjBo?=
 =?utf-8?B?VnQ3M0lHcjBxN0hLQ1Q3cTZMWjNTR0tyR0UxcmxoSW9JRStMNVBxZ2F4M01v?=
 =?utf-8?B?VXBPMEpmTnNjblRmYk5xK05yQUgwVy9lS3lEM0hQMnpEOTh2dk1YN2RkOWg5?=
 =?utf-8?B?Q1RQV200aXN3M09KTEMwUVUvQ1loT1R4SGhjc0VCU1BNblV1VTZZTGR1Mkdj?=
 =?utf-8?B?MmJjZnR0am9wSGQ4TjlnYXQ3LzhFNWdHcktRTkhtd1NCaGxGNGFRTGdXdjBX?=
 =?utf-8?B?ampRUTJxSm5OQmc0QUJNdjB6c2hrWUxBUEl0MHFKdlRhakFHcTl1RVdMVFNR?=
 =?utf-8?B?alVjVFlBL2NRUFRGbUVsLy9tc082aGMrVTErVGR6S09CVUJzZnIxVk1Xd09l?=
 =?utf-8?B?RG1ZbXRYOWpEMC9ESFY5V0E5MmtySGJvYWFJckxsNjFxbk8vZUdBbFFzRjlW?=
 =?utf-8?B?ZExteGZhLzVpY3pMWWQvemppQ2R4SzFCRCt4VW40SkZ1V0trYWloQXBQWHRL?=
 =?utf-8?B?Ky9TWW1aSmtJYUpXSjI5TGtKNlg4ZWxOd1FHVHNoK1U3WGpibytKcWFhVUpu?=
 =?utf-8?B?NURHSllZUEM5b1JuRnZGWGNsTWFkaVp4SCtsTUFKeldJais2SnNpaE9mRVk1?=
 =?utf-8?B?Qmw0alFvWXBlUzlTMUdaa1Q1QVpuaHhhSnZNWjIzLytZSmFmajdsOHJuSG41?=
 =?utf-8?B?SmUyQzFXZjgyTUY1T1hhL1F1V3FCWWsrSlZvUUdXdERUVVY2SmZoc3l6NW4y?=
 =?utf-8?B?QmtkNmJ1cklMaGQ0ejB5dVJKZnd5YjMyR1drZDF6dEg2Qlp2Um5CSFpnN3RZ?=
 =?utf-8?B?R0F0SHRDRkRraEFXaDB4ZXVZLzVvdFVHaERXd2ZzUmpSUFdiMlFJRnI2azVX?=
 =?utf-8?B?K2hCVEMrZ1h1UVUxY09rMG9pSHN6M0taK3RkWUczbzF2c2VIY2VzYmlMczQ0?=
 =?utf-8?B?NW1CMDJ6NlllT2tGM2tYMHRSZS9LRkI5ZWQxVXFza2dOUk5EZ0dib1lxOUEz?=
 =?utf-8?B?LzBIeFpZQ3h5K0RPdlJLQWxDMkV6YlVOT3JRZ0h5VXpzWEEyOFpmMlRoRjh5?=
 =?utf-8?B?TjY5ajB2VHFLVHJ5cWN2bzFReE9nVmhvUExoSW4zOWZYMGpnUjJ6NjBQSTBw?=
 =?utf-8?B?QWxSSXY3RTdmS2RlM3lpZzRHOStwUjBoekw0SXB4S2VQcnZXMlN5QWR0cDE1?=
 =?utf-8?B?WVBLNkU1UlVtaS9sNjNwaytvRWNQaFNBK04vQnVjbVBCR2l6ZXhTMEVtZEhm?=
 =?utf-8?B?WnNZOWRZcTVWSjgvY3B0WFQvTURVTERtOXd0U2dJbzU0TXNKbCtaaHM2Z0tL?=
 =?utf-8?B?TGRCS1lxbTZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V21ZT3B1RWdUWmdqSHRVaXlMQkgrMUI5cUJ1djRmNnN1MGJxL0lYenpHbjgr?=
 =?utf-8?B?MkY2emxwcEVOTFFFNUYwWGw2NThHQjFkM0NSU1RiMDNvT1E0Zis0Y3RjMUdK?=
 =?utf-8?B?eFhCRjE3c084bTdNRWZ1NjdaVXp1NkwwRmIyKzJkeXN2MEtPbTZhdytHSy8x?=
 =?utf-8?B?U3V6R1h3bUpEN282cklnTjRoMVdpV0lJL21YTHFReU80K3Vkc2d2WFliRER6?=
 =?utf-8?B?OVFSY2xBR2xVQzJxbXpYb0RhVEtkYit6VEd5bXhUcGhmaE1jUXAvSlEyS1FY?=
 =?utf-8?B?WGpxTTBMOVZIOWw2REZNZEdQZFVVYnc1czRTZkQyWDQyY1k1R2h4U0hjNkIv?=
 =?utf-8?B?SDVaUnZwTmwrRElKbUU4R2FBczJQRERRYUJKWW9heHE1ZWsyWWNqK3hVQTMr?=
 =?utf-8?B?dGoxRlRVQi8zRUVTSFFPdnJPRlY4aGQ0aHA1VmNOTUZPbXJ5T1dPblp3UjRY?=
 =?utf-8?B?OUFYdEZsZVhFVzZBTTZucW5NSVpyNVlrSUYwNkkzb0g1Q2ZpajFSTVJvZHhp?=
 =?utf-8?B?VDhIdzE3S2xCSTMyM0U1VWU2aklnSHF3OU4xZFlaWVk4Z01WM3RnczZycGwy?=
 =?utf-8?B?dXhYZis3Zzc1YjAzZDNQMmZ3dXR2MjU5WVk3V3RxRitETmdoK0YrRFRqSytW?=
 =?utf-8?B?UWYwN01mYWpDbkxZVkplN0Q1T0h3djJUVHRieHp6UmVyVWcvY0VBWXdtbGs4?=
 =?utf-8?B?NDNKSTFDWDRjeEx5Nm5xNHR5Q0hNL3E4cjgzSFk1cXMvNzdISmlBZC9Ua3c1?=
 =?utf-8?B?WWlDeDlsMmFlaFo3MEJmNEkveHpQTmFMWkM4M1EzZGQ2VEtJLzBUaVlyUUxn?=
 =?utf-8?B?eHI5MG95T0ZWekp3dTNYdThPUEZiL3Q0cXgrSnFpdlpPcFk1bWhJaXpEbGdq?=
 =?utf-8?B?LzVBR2dwWklsazJuVlIxQlI5VW1Pa0N1bS9PYjljTEVkUTZGVjFTWDJrTHpr?=
 =?utf-8?B?azN6RlpjQ3hWbDBpWkQrK1RGZDdTczI1RFA3blYrSDIwWEtUdVdCMmZ4T0Fh?=
 =?utf-8?B?L3dVSWNYamJOYldHV1BQOGpKbkFHeS9RT1V3ZmdPOWNVZG1uSGlDNmdUNEk2?=
 =?utf-8?B?WU12aXdxUkphNUZJaTRIOFBjVkZlaExUVXFuak5zdGxITm9PK0hvQ25yRHZq?=
 =?utf-8?B?Q3ZDTHRHYmNHU3Awem5LMm9WQTgrY1luS1hQbDl5K3R1U0ZjRG1wbkx4TE9E?=
 =?utf-8?B?VXVaeXVlY3gzdDFxNnNSTXlJWHJsbWF5UmFqSUdkSmhxcTlmOVRIL3pQK1kz?=
 =?utf-8?B?ZmZhRkxxMUdHSFlqS3B0Y3h4cVBndTFHdE9QQzMrUk9lMlQ1UXQ4cnk3OUZn?=
 =?utf-8?B?VnBhdXhiNDlkY2R1WXZXTG9veTA5SVZnMEFWdkkvcDl5a0Z5ZnN6OWVYcFJM?=
 =?utf-8?B?YWphR2dVNGthcFc0V3pHNDZVS0JnRWVMeWpHOGhVMUphemZMbjBDdHFnQ0F3?=
 =?utf-8?B?YzdQWW1RMXBmdFdWRVhtS3RpaEtWdVNEaUhETllLUWNEajJtSnNuUVZ4cWZz?=
 =?utf-8?B?MDBmSFA4dWU4Qk5nUlovNEp5UGlDRU1EOUpQTm4wY0NteEtkVHZqa3p4MVFW?=
 =?utf-8?B?czFuQ2NWRExZLzRNYWd1M1ZiSC9KR3NlTi9NaW10Z2J6VVZCOEZNbFpVcko3?=
 =?utf-8?B?V0xtc3hER3JYcU5PUmkzRXZ2T0hWc3VwcFdOL2F3b0FwL25sOXY1VTMvNDY5?=
 =?utf-8?B?QnE2YWtxL3dFcmFmenZmYTNkNGZCZjNlbHB5K08vclVVWVFVRVVKSGwzMVJN?=
 =?utf-8?B?Nm52WmwrYUF2aEZPaDQvSmdhR01lUUkzV2VLbzkzYWUxQXIvRFBKY3VnTW84?=
 =?utf-8?B?T2cvMWNGWkpxOGh1Q1duTjJtc2JvV05EUzRxRnpqY29lYkcvRlB4aTJUZWxq?=
 =?utf-8?B?MnhUVUplMjdtV1N4TXlSRHhYVGZob3RrTUpkTTR0bXY2Mmh4U1oxRG1tY2Ey?=
 =?utf-8?B?VjNmQ1hqQzRvNnFHQW1XM3YwNG85Ujl0R3RwRTNOR3B3c2IzRStOZmsxVzJx?=
 =?utf-8?B?d05kVmRiSFRldi9YU080UUxnMlFPUXQySXNoajhOMXFpd1Q5RXhoQUhYVjVk?=
 =?utf-8?B?Q1d3NDg2NUhpV0V4OGVjTzM2UzhwcHFKNno3VTV5UkpVZUU0Mk5jaDNMdlFI?=
 =?utf-8?Q?antw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba2a6a7-e36c-4594-6b34-08dde3a5481c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 07:01:57.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIZyrOZ2c9nrh1Htvwt5QFZpEeFaBolWp80Yl2PhTYv4lugDLWuMU5k70FPYObqNKYVaELpEErBM05QhDpRbHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNl0gcGh5OiBwaHktY2FuLXRyYW5zY2VpdmVyOiBBZGQg
c3VwcG9ydCBmb3INCj4gTlhQIFRKQTEwNTENCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiA+IFRoZSBU
SkExMDUxIGlzIGEgaGlnaC1zcGVlZCBDQU4gdHJhbnNjZWl2ZXIgd2hpY2ggaXMgYSBwaW4tDQo+
IGNvbXBhdGlibGUNCj4gPiBhbHRlcm5hdGl2ZSBmb3IgVEkgVENBTjEwNDMgd2l0aCBTbGVlcCBt
b2RlIHN1cHBvcnRlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9waHktY2FuLXRyYW5zY2VpdmVy
LmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3BoeS1jYW4tdHJhbnNjZWl2ZXIuYw0KPiA+IGIv
ZHJpdmVycy9waHkvcGh5LWNhbi10cmFuc2NlaXZlci5jDQo+ID4gaW5kZXgNCj4gPg0KPiBmNTlj
YWZmNGIzZDRjMjY3ZmVjYTQyMjBiZjE1NDdiNmZhZDA4Zjk1Li5iNDkzNzFhMTI3MmNkOGEyNWIN
Cj4gNWUyMjcxNTg2Yg0KPiA+IDc1NjEwM2M2NGYwYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BoeS9waHktY2FuLXRyYW5zY2VpdmVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9waHktY2Fu
LXRyYW5zY2VpdmVyLmMNCj4gPiBAQCAtODUsNiArODUsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQNCj4gY2FuX3RyYW5zY2VpdmVyX3BoeV9pZHNbXSA9IHsNCj4gPiAgCQku
Y29tcGF0aWJsZSA9ICJ0aSx0Y2FuMTA0MyIsDQo+ID4gIAkJLmRhdGEgPSAmdGNhbjEwNDNfZHJ2
ZGF0YQ0KPiA+ICAJfSwNCj4gPiArCXsNCj4gPiArCQkuY29tcGF0aWJsZSA9ICJueHAsdGphMTA1
MSIsDQo+ID4gKwkJLmRhdGEgPSAmdGNhbjEwNDNfZHJ2ZGF0YQ0KPiA+ICsJfSwNCj4gPiAgCXsN
Cj4gPiAgCQkuY29tcGF0aWJsZSA9ICJueHAsdGpyMTQ0MyIsDQo+ID4gIAkJLmRhdGEgPSAmdGNh
bjEwNDNfZHJ2ZGF0YQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjM3LjENCj4gDQo+IElzbid0IHRoaXMg
dW5uZWNlc3NhcnkgYXMgaXQgaGFzIHRoZSB0aSx0Y2FuMTA0MyBmYWxsYmFjayBjb21wYXRpYmxl
IGluDQo+IHRoZSBiaW5kaW5ncz8gSSdtIHN0aWxsIGxlYXJuaW5nIGEgbG90IHNvIEkgbWlnaHQg
YmUgd3JvbmcuDQoNCk9vcHMuIFRoaXMgcGF0Y2ggaXMgbm90IG5lZWRlZCBhbmQgc2hvdWxkIGJl
IGRyb3BwZWQuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gTWF1
ZA0K

