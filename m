Return-Path: <linux-can+bounces-983-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0393353E
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 04:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1B8B20B46
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 02:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D617FF;
	Wed, 17 Jul 2024 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pvWmOnbM"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F56FB6;
	Wed, 17 Jul 2024 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181823; cv=fail; b=tReDqssMecVEFQKkX3DeJY2PTCy1brBu7AHQuhtYL3yBtkQPP35qHfBmGP2XNC275ea4dERESo0cKVPg3yQ3cmaXWSf7B1X68Up1vPQh3hAvrdmZCbB+Ykt76Tq3dEra3SeMsYsrwlsHbD4+dLFBoad3LbMPtHhZLYzgh48H3G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181823; c=relaxed/simple;
	bh=veEzdPGtvwDKphALwVn81vmerSrqCu+GyeWUjIkSMPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rApjW1HiUMkyWR1kHyXtoC5weNA43VV6hh1fJbxK8eJ3WHSgSe6EPEDyWaFHvNRUFxfFmxxDCqL/LTrima/6R98K/D7E4AeyMc18FLxSlIzdJWyVRzePxhOBZErcf5gSs/vqXBCS8B+9XO0WchQWHsgV65jABbp8cX6RXjGmD/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pvWmOnbM; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDwVR3P5JYf22VN7SIyQXWE8facKj1fT2AtBqW13nsREcsem+/WA2JMrirS9IDGm+w339SEYMSZ3BRGhGGLjCb5uyC+HrLXd3y/XsisSROaguU5igeJSiweaaN+JIFIrVaxckoXU0gWXjccKDDU1aQVf5bsVo4wseTWQ3LZWHBtOfXPkhclyjzT80JZpSRVbl5IVxw2Z0jeYgAkACsKlWX2SVrumi63m8N8gN9KYPa1PlhQOamKm7Z7os3oYaQiGWcCZhWpEe6cv0U0X0QLhd+S99cw1L/9Does9hH8HqU4Gra8zhZPMh56xKmoEIT/BqVJ3MsRZLz8ZUmwYFIxwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veEzdPGtvwDKphALwVn81vmerSrqCu+GyeWUjIkSMPo=;
 b=WLWQG7bRzm/gioyNmSFmCDgUzoWthTHdSrwmIYI/KNQkbPTYEKkSdnzkClsX3h69wvtbnLuwOxpr84sfoqC3V9fsWVYdpm0Rc3rrKU27cpRmKrp+ET5W7/5xHN3PwKNmSrnW2o53Y/Gg9r1+tSbjNV4Y3T1fKD2Q9Q0rjORtxt6je0/x7y+GOITF3hinNSy6ZF/kl6ZwY2tCubhoLCP3DKlH3GWOeIXdACM+W0uSv2dG3N1BblORst7TOg/Ov2+qLTAyZrfjrxwMrZY7GviUJ/+0o7UqXnQHb4VP26ICGSe80C+USYpfZxFHN0NoQhotrJKkLH4ESPTkGol8ySCrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veEzdPGtvwDKphALwVn81vmerSrqCu+GyeWUjIkSMPo=;
 b=pvWmOnbMsxGisY0dWqIQ4jx0NihozMGvrvNPdWHO3UM7tmQyux2uolDJCDyW4mHnr6PGeru3629aEvWbJkEZa5x2qLlaZHXTE2t2FHL8b17QfAiUB3Zksu/9rPf/7CTKFn1sSWWX6qF6ygcMg4x3oezz1y288Yrvw/0uU/0SGMg=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB11082.eurprd04.prod.outlook.com (2603:10a6:102:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 02:03:37 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 02:03:35 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <frank.li@nxp.com>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Han Xu <han.xu@nxp.com>
Subject: RE: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Thread-Topic: [PATCH v2 4/4] can: flexcan: add wakeup support for imx95
Thread-Index: AQHa1v3YNS4Ss8Dl5E+GTLJUMI3iC7H4704AgAB+7YCAAAFogIAAup7A
Date: Wed, 17 Jul 2024 02:03:35 +0000
Message-ID:
 <DU0PR04MB9496C653249E66016A43F97790A32@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240715-flexcan-v2-0-2873014c595a@nxp.com>
 <20240715-flexcan-v2-4-2873014c595a@nxp.com>
 <20240716-curious-scorpion-of-glory-8265aa-mkl@pengutronix.de>
 <ZpaF4Wc70VuV4Cti@lizhi-Precision-Tower-5810>
 <20240716-chowchow-of-massive-joviality-77e833-mkl@pengutronix.de>
In-Reply-To:
 <20240716-chowchow-of-massive-joviality-77e833-mkl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA1PR04MB11082:EE_
x-ms-office365-filtering-correlation-id: 5128b283-8447-4230-4b15-08dca604aaae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVRPbmkvdXIyY0RBWm9JYnZZN2FOWGpIVEhLWFUza3BCRldkem5WY1lTVkZW?=
 =?utf-8?B?WkNmY3p1cElwNlZUNSt4allIWW5WR2NDOHZCUEh0Q3U4T3JrVktlVitkdEty?=
 =?utf-8?B?blE4NUtPZ0RxVyt4eFRSSTE5S0pYdDc5Z3M0OU4rRU1xMmc4UTdab1puZlly?=
 =?utf-8?B?WUJxZFpQdUtobEo4b1dQVUp4eWhMMFQwNUVyeUV6SlVhcEU1eHVsd0tQQnpo?=
 =?utf-8?B?UTJoZ0R2RFJ0TXp2T2NLbndKQjVRdklNUGlUcHp1VkdwdEdMcWdYb2F6TUhk?=
 =?utf-8?B?dDJybFgxdkJ2cnFwVnhrbnQ0VDh3eXp2MWhvb2packlJSzdNeDFiamdRWXBw?=
 =?utf-8?B?dUIwZFVuRTNQZXJpZ0NaaGhBN1k2Tlk1d1ZzRFBMRjJXUHlTV2w0Slo3bklO?=
 =?utf-8?B?T21abVMxcjZRMURzNTBEd0cxWEhCSjk0ak1CRlZRenJzVy81c2kvRGcwZjBn?=
 =?utf-8?B?MjNEVmtjaVgzTGFnd3F0WDNlRGZmcSsvVzEvSFVXYmVRRXFkQVlUeTNLOXJF?=
 =?utf-8?B?MjR2UGw0U0VjRlpjMHN2OXBQamhFWi8zaStiOVBNQ1hDMXlnVnMydXVwbHln?=
 =?utf-8?B?ekJSL0lEdStiS3FJZzJOQ2tsS3hRVHpNNE5WaFE3UEFzRHdyTVBHMkNYTURv?=
 =?utf-8?B?enBBNER0WUI1b0ZoSlNBb0xiZVR0YzVPK3pxNmk2c2haRWVWd2JNSDZzTHJh?=
 =?utf-8?B?TUVYOWZJTVoxTFdPclNyWGNaaHFsU2k0cEJJemo5ZS9SRjNBVUFGZXNwY3Nw?=
 =?utf-8?B?NnN6TzcxcUJMeHMvVlh5RzhCQys2dkdPR2VNNUs5MnNOcWFsVGMwQ2Q5dytG?=
 =?utf-8?B?TWJhck5WV003RDFRQzBaSXBUSEZOZGdZOG1wOHZvVlNtQVYzakhTbWM0UThu?=
 =?utf-8?B?MkplS2s2ZDFCenBjT1JhZ2Q5YVlBencrTytVOWt6U0NQVUtMYVNVaWtuNnkw?=
 =?utf-8?B?UWVJQVFPOElwall2c01FVkVFSlVaSUJ1VTBHMmd3QXFjWVZ1TUl2ZUg1Smx0?=
 =?utf-8?B?Ti85VkN6d0tSYTJpT2VjYS9LdlA3T0hhRk9RMnVOWDlXd2JQWXRSWEUrd0J1?=
 =?utf-8?B?MEdrQTR5MUJ6MGcyOWE5T0s1RVhCaytrU0NVeEVFdlEvbFRCYkRLWWo0eEMr?=
 =?utf-8?B?cnErb05HU0poeDNnZnVqVTR2Zmg0eW9US3BHdDlrME9GQWkrU0RGa1lUYm1H?=
 =?utf-8?B?L1BZZmNDS2ZPMm9WU3NUR1BvODd0VWJvMUlhRW42dnU2OWYzcUhteTFLeXBp?=
 =?utf-8?B?OWh0cXZuSmovQUk3RGpjQUhvQVVLbE5qWEU2bys0ZG1mZ01YTklOblBHbDZF?=
 =?utf-8?B?NG13R29qUHNqZWhqUDF2WGphZGhrVGFRMDRxK2t6SFh4S1Y1RitSUDFaOENF?=
 =?utf-8?B?M1hFQ0VCVjlEblp3YStQY09NT2NwNVhVQ0tJVS9DblJHMkliV3hoM2hETTBj?=
 =?utf-8?B?VWlJOVpnbWNjY1dXbWxPdUUrYURFbDZ2QUtKa3ZKbFpRbHFhL2t5WjdVNWNV?=
 =?utf-8?B?OTM1L2RrUzFCNjR4TVlKd3A1WWw1N2pHN3VKeldsTDdaY1JROUI4QS8va09j?=
 =?utf-8?B?NUpIV2RGdGRYSi9hcnpsWnNLellwdzFHbGdReHdNcjVucnBISExMSTZ4WnVt?=
 =?utf-8?B?NWNvcUFMTU9XMFdBRDRzeWo1MWVOMVdBUzZYQVFFVEM4SlZXYVdUZFZBOGNP?=
 =?utf-8?B?ektCbFpNd2hVNE4vbnJ6TEVGV1NpcVhnaTFKZEJWbUZhVFppVEVzRXlPNVNu?=
 =?utf-8?B?OWxEYXdXWGR0ckl6UytHODBpYmswejg1YkE2NXdialhwQ28zY0ZpWmJ5c0RO?=
 =?utf-8?B?ZUJjZlFXN2E1Y2JFQmEvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWh1d3FaUWFJZlhaa3lhSTJ2Sk52NHhyQkhWRGJSbkdkNE43MTVUR2FzbTBC?=
 =?utf-8?B?Wm4yaTFKRk5taytRMC9PaW4zSlN1N1hIc1BINVpFZ0V2K1hRaE02SCt0MitH?=
 =?utf-8?B?TWFBSmlLbnNUd0oxcFlIdVduTS9zWkkydWF2Z2pNNWxMYkc0U21qR01TRzFF?=
 =?utf-8?B?UEFLeERkcVliakZXS2liTTlPMXdraXluQ2d3Y2pVekhHODVOZys2ajIvQTBI?=
 =?utf-8?B?dDZ0dzlCMW5uVjN6QXRJcmJiYkV3SkpEcCsvcTZVTFpuWTNWVjJ6KzZpckhI?=
 =?utf-8?B?SC9kYzZabjZ5b1JSR1orT3l0R1RnZTRDYnpPZnYrMXlXWVkrSWVGUllQRDlE?=
 =?utf-8?B?RkJPaCtQZjllcm1UUDJCandDZi9xQ2swZmNwN0JWL1dtbnNwN29FUTZZWkVO?=
 =?utf-8?B?clQ0WWpBdFFxZGtvMmRiNmpHZENQRHVIMXNtWmdLVm5IQU9GeS9wTjBEaEdO?=
 =?utf-8?B?NEQvcmpuRGFXOXFnTnBHTWxYK3dHUHhENTVTdkNaQTNpVnRVMzBYVnpKdUN1?=
 =?utf-8?B?aENRZ1l0d0c4SzcxWVB0YytiVjZ0YzVYTlZKSUpZMVNRM0piMEZSNlRSeFg5?=
 =?utf-8?B?MWs2bllEc1BaQ1pDcjV3WTc5cU9ZUXNaZTA4LzVWNENYdmVERUxXR2Q4Mmxk?=
 =?utf-8?B?REZJMkdFdko1QlhyZG5QTTYzZGYzdjh1YzhwMXNCYmFyZ0x1WFd4N3l6V3Y2?=
 =?utf-8?B?VUZ1MWZEQ0NiaHQ2dldiTzFkakJLYnBiMU13REJaYWtod3N6U0lJQ09ZUUkw?=
 =?utf-8?B?UVRRRTFYbTlnWVM4VkVOYUdtMjRzSzVORFdYT1oveWhjY1dHOFZiSVVrVTUy?=
 =?utf-8?B?Mm9MaFlIdlFJM3JWcEIveStYUTcrc2FpT0poOHM5ZCtlSlFEQk1ZYzg5Mm9Y?=
 =?utf-8?B?S21QWDR5bTBrZ2lRZlkzTWRBRUlzY24wUzRQaUFMR1hmc3VpcXpBcHRERnQ2?=
 =?utf-8?B?aTJyejhDQk9SQkVuejFqRlNCZ0M3TnAxRXJpM1JGNTQ1Z3l2R3pqN254c2J0?=
 =?utf-8?B?dUdTSmdDd1dtTHR2WENYcGVZbnF0RmdHNVdBYytxSEt0N2RNZkpXVlRnbW02?=
 =?utf-8?B?ejZveWF1cktSNkg2R0pmL3hMMG9BRTlINVBJbHJOTEx4Vy82VW4xYnVjYWVU?=
 =?utf-8?B?N0FZRVM0d0w4YUZuYUxaeDdNS2dMU0NBUkRlSVcxYlJHdWVhVVR1dXhtZlZa?=
 =?utf-8?B?WlVSRUJhZk1kWG1jTVlSQ0NTVUtNMkRpbHdqVUVCdVhTRWtSdnJpek0rR1pw?=
 =?utf-8?B?RzJ5YnUrbzh5anBZVTFlZDNTc2lTNThndjdaQk0zaWhjUEcxMTgxc1RHV0Vl?=
 =?utf-8?B?S21rZlE3RFoxbjFqa24wYTc2WTJ6R1owbGkzdElJVmhscFpZaWJHSDZpWEdQ?=
 =?utf-8?B?cXhnenlQcmlrSFJTSXY1VUdCNHNvc0JSdEtOb2xreVRYZ2dMelZwRk9OcldP?=
 =?utf-8?B?TWlmcWxBeWdMcXdnSDZEUHN5SFh3S2h3RmloVHFPN01tekl0RkpCV1dqRTA2?=
 =?utf-8?B?b1F3dmpUWnlUcHNVUnkvSXIwRHJzYittTGc5ZnI2M3ZjZ0xzMmZhMlhPVVg4?=
 =?utf-8?B?RVhLa2JBZTRYd3pLam5NMWludFdsdFBBcVdOQUtia0JZT1lLcmtCREJwcDRT?=
 =?utf-8?B?ZHdYNWQzK3MzWTFUV3lkZlB6VWJoZEswUzVKS29wcE1sQzhoWGJCZ2FzZXVt?=
 =?utf-8?B?aEcyRlpSZ0pwL1ZHZGl6Q2lvWVlQa0V6VE96UjZneEM5SEEydjI2NXFJWTl1?=
 =?utf-8?B?ajJzMTA4WDByQnZKRE0wTitObHRZYXJsenpZc1NSK2ZpZFNZZWhYVCtteUQ4?=
 =?utf-8?B?OGw3bnpZUWVmQ2djT2hGYW9NeHVReUtFVEFsQ1NPWWxSR2RIa2IyQk9PU0xH?=
 =?utf-8?B?c1J3NnQ5OUNYVUU4N3hqSkFtaFlweS9WZEpNVkljTmY1OXBqR2J6UEhDWG9C?=
 =?utf-8?B?MnZ6aGVTd2g2MjZPT2FUdmNJTk9kcURWUnNhS0tJK1dWbEpqSG80b09UNUdi?=
 =?utf-8?B?TXRqUXo5cm5HYkdKdFZ2TmpkMFhTQWYxNVErYUtRYWdJY25XY0d3QUhqcmcy?=
 =?utf-8?B?WStnM1NOcTJzQVBqMU9waXJhSTNsWXp3UG80ekhTeGZaaHUyQytITml3RE55?=
 =?utf-8?Q?7KR4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5128b283-8447-4230-4b15-08dca604aaae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:03:35.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeB4nhjPro3s7WwM/2/2KFGBDwQ5P+j4/14ob4SmNhZHi2nnb1X2F4tKYHMyrHYYeBNR6JlF+OYJmi9cCD8c/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11082

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTlubQ35pyIMTbml6UgMjI6NDYNCj4g
VG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogVmluY2VudCBNYWlsaG9sIDxt
YWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj47IERhdmlkIFMuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViDQo+
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwu
b3JnPjsgbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsN
Cj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEJvdWdoIENoZW4NCj4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IGlteEBsaXN0cy5saW51eC5k
ZXY7IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC80
XSBjYW46IGZsZXhjYW46IGFkZCB3YWtldXAgc3VwcG9ydCBmb3IgaW14OTUNCj4gDQo+IE9uIDE2
LjA3LjIwMjQgMTA6NDA6MzEsIEZyYW5rIExpIHdyb3RlOg0KPiA+ID4gPiBAQCAtMjMzMCw5ICsy
MzY2LDEyIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQNCj4gZmxleGNhbl9ub2lycV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2aWNlKQ0KPiA+ID4gPiAgCWlmIChuZXRpZl9ydW5uaW5nKGRl
dikpIHsNCj4gPiA+ID4gIAkJaW50IGVycjsNCj4gPiA+ID4NCj4gPiA+ID4gLQkJZXJyID0gcG1f
cnVudGltZV9mb3JjZV9yZXN1bWUoZGV2aWNlKTsNCj4gPiA+ID4gLQkJaWYgKGVycikNCj4gPiA+
ID4gLQkJCXJldHVybiBlcnI7DQo+ID4gPiA+ICsJCWlmICghKGRldmljZV9tYXlfd2FrZXVwKGRl
dmljZSkgJiYNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl4NCj4gPiA+DQo+ID4gPiBXaGVyZSBkb2VzIHRoaXMgY29tZSBmcm9tPw0KPiA+DQo+ID4g
aW5jbHVkZS9saW51eC9wbV93YWtldXAuaA0KPiA+DQo+ID4gc3RhdGljIGlubGluZSBib29sIGRl
dmljZV9tYXlfd2FrZXVwKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiB7DQo+ID4gICAgICAgICBy
ZXR1cm4gZGV2LT5wb3dlci5jYW5fd2FrZXVwICYmICEhZGV2LT5wb3dlci53YWtldXA7DQo+ID4g
fQ0KPiANCj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uIEkgd2FudGVkIHRvIHBvaW50IG91dCwg
dGhhdCB0aGUgb3JpZ2luYWwgZHJpdmVyIGRvZXNuJ3QNCj4gaGF2ZSB0aGUgY2hlY2sgdG8gZGV2
aWNlX21heV93YWtldXAoKS4gV2h5IHdhcyB0aGlzIGFkZGVkPw0KDQpIaSBNYXJjLA0KDQpIZXJl
IGFkZCB0aGlzIHRvIG1ha2Ugc3VyZSBmb3IgQ0FOIHdpdGggZmxhZyBGTEVYQ0FOX1FVSVJLX1NF
VFVQX1NUT1BfTU9ERV9TQ01JIGFuZCByZWFsbHkgdXNlZCBhcyB3YWtldXAgc291cmNlLCBkbyBu
b3QgbmVlZCB0byBjYWxsIHBtX3J1bnRpbWVfZm9yY2VfcmVzdW1lKCksIGtlZXAgaXQgYWxpZ24g
d2l0aA0Kd2hhdCB3ZSBkbyBpbiBmbGV4Y2FuX25vaXJxX3N1c3BlbmQuDQpBcyB0aGUgY29tbWVu
dCBpbiBmbGV4Y2FuX25vaXJxX3N1c3BlbmQsIENBTiB3aXRoIGZsYWcgRkxFWENBTl9RVUlSS19T
RVRVUF9TVE9QX01PREVfU0NNSSwgd2hlbiB1c2VkIGFzIHdha2V1cCBzb3VyY2UsIG5lZWQgdG8g
a2VlcCBDQU4gY2xvY2sgb24gd2hlbiBzeXN0ZW0gc3VzcGVuZCwgbGV0IEFURiBwYXJ0IGxvZ2lj
IHdvcmtzLCBkZXRhaWwgc3RlcHMgcGxlYXNlIHJlZmVyIHRvIHRoaXMgcGF0Y2ggY29tbWl0IGxv
Zy4gV2hldGhlciBnYXRlIG9mZiB0aGUgQ0FOIGNsb2NrIG9yIG5vdCBkZXBlbmRzIG9uIHRoZSBI
YXJkd2FyZSBkZXNpZ24uIFNvIGZvciB0aGlzIGNhc2UsIGluIGZsZXhjYW5fbm9pcnFfc3VzcGVu
ZCwgZGlyZWN0bHkgcmV0dXJuMCwgZG8gbm90IGNhbGwgdGhlIHBtX3J1bnRpbWVfZm9yY2Vfc3Vz
cGVuZCgpLCB0aGVuIGluIGZsZXhjYW5fbm9pcnFfcmVzdW1lKCksIHVzZSB0aGUgc2FtZSBsb2dp
YyB0byBza2lwIHRoZSBwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSgpLg0KDQpCZXN0IFJlZ2FyZHMN
CkhhaWJvIENoZW4gDQo+IA0KPiA+ID4NCj4gPiA+ID4gKwkJICAgICAgcHJpdi0+ZGV2dHlwZV9k
YXRhLnF1aXJrcyAmDQo+IEZMRVhDQU5fUVVJUktfU0VUVVBfU1RPUF9NT0RFX1NDTUkpKSB7DQo+
ID4gPiA+ICsJCQllcnIgPSBwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZShkZXZpY2UpOw0KPiA+ID4g
PiArCQkJaWYgKGVycikNCj4gPiA+ID4gKwkJCQlyZXR1cm4gZXJyOw0KPiA+ID4gPiArCQl9DQo+
ID4gPiA+DQo+ID4gPiA+ICAJCWlmIChkZXZpY2VfbWF5X3dha2V1cChkZXZpY2UpKQ0KPiA+ID4g
PiAgCQkJZmxleGNhbl9lbmFibGVfd2FrZXVwX2lycShwcml2LCBmYWxzZSk7IGRpZmYgLS1naXQN
Cj4gPiA+ID4gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi9mbGV4Y2FuLmgNCj4gPiA+ID4gYi9k
cml2ZXJzL25ldC9jYW4vZmxleGNhbi9mbGV4Y2FuLmgNCj4gPiA+ID4gaW5kZXggMDI1YzM0MTcw
MzFmNC4uNDkzM2Q4Yzc0MzllNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvY2Fu
L2ZsZXhjYW4vZmxleGNhbi5oDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2Fu
L2ZsZXhjYW4uaA0KPiA+ID4gPiBAQCAtNjgsNiArNjgsOCBAQA0KPiA+ID4gPiAgI2RlZmluZSBG
TEVYQ0FOX1FVSVJLX1NVUFBPUlRfUlhfTUFJTEJPWF9SVFIgQklUKDE1KQ0KPiA+ID4gPiAgLyog
RGV2aWNlIHN1cHBvcnRzIFJYIHZpYSBGSUZPICovICAjZGVmaW5lDQo+ID4gPiA+IEZMRVhDQU5f
UVVJUktfU1VQUE9SVF9SWF9GSUZPIEJJVCgxNikNCj4gPiA+ID4gKy8qIFNldHVwIHN0b3AgbW9k
ZSB3aXRoIEFURiBTQ01JIHByb3RvY29sIHRvIHN1cHBvcnQgd2FrZXVwICovDQo+ID4gPiA+ICsj
ZGVmaW5lIEZMRVhDQU5fUVVJUktfU0VUVVBfU1RPUF9NT0RFX1NDTUkgQklUKDE3KQ0KPiA+ID4g
Pg0KPiA+ID4gPiAgc3RydWN0IGZsZXhjYW5fZGV2dHlwZV9kYXRhIHsNCj4gPiA+ID4gIAl1MzIg
cXVpcmtzOwkJLyogcXVpcmtzIG5lZWRlZCBmb3IgZGlmZmVyZW50IElQIGNvcmVzICovDQo+IA0K
PiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXgg
ICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSB8DQo+IFZlcnRy
ZXR1bmcgTsO8cm5iZXJnICAgICAgICAgICAgICB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMTI5
IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5LTUxMjEt
MjA2OTE3LTkgICB8DQo=

