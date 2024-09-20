Return-Path: <linux-can+bounces-1518-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D034797D0CC
	for <lists+linux-can@lfdr.de>; Fri, 20 Sep 2024 06:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9461F229C1
	for <lists+linux-can@lfdr.de>; Fri, 20 Sep 2024 04:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12E2D057;
	Fri, 20 Sep 2024 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EJyEfZCu"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2381F951;
	Fri, 20 Sep 2024 04:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726807925; cv=fail; b=f1fpD6TXnU5lVepjTC5OtaqGxWa4gSfbQxjWyWMHkd8SYsupw/WO1mCrtiKmHhMhJGyYtJEEcf7lriwUM3iAP0gbRw4bo3a/Krm00dHHnfj7lprcMVA9K3RQ14g4Yfk/IKnlnos5cCK7PBID7cWq+QqkCtMrqjyzElZb3K7UObw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726807925; c=relaxed/simple;
	bh=Os7l4+15lMlO8RTCYffRmaMOlAhPC3Eq/yMao4KhkSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkDScftrOyfgvva/uCcrQiNa/zlZ+YKUxtbt6WNCLa/JYzk4ivs9NmS2LTMtrAxdXFcPEZWnIVY2jaYgI4cY1/I3VUfxkFAgIXO3BcOeYIswBjiLnBm1uuMi+o51pmFvREzTqm8n7DW+dQs1kZ7Idltg3eK/PmjJcDsFek5vvmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EJyEfZCu; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObcJ/GI87lrMh5GiS49BJvF8fNtpujpioWqHi++ok8sNeuPiaIvxumiVoWkSRqOwVZhsNWSmBoyEejtuljn6lTdM64B2DB2n++VwmXDb4ru+1nF62K1M1mbTf3hDutslA6lPMR89CW3yuYGkcu2oexCJACCZ8bilrzw/W0wgXZp6J4qOVekQdVrkfkceSt4EsC4dhd7gxlmOqeLKP93zIkUG8x4d35GjRjbXNcRaQrcqff5gE/40pl7KV1F3cGbgVfccTMMyAyAVTJEdIWTP9nm8YZGHC6W2XQiIpOZ07V0C9XpYq4KxITApLoyt6ny5BKc111v5RvyHC/oOoQHU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os7l4+15lMlO8RTCYffRmaMOlAhPC3Eq/yMao4KhkSE=;
 b=paDPO+F19nL9yPitjOnwNjdHY11Tl7hSXSNOadoOwawAOMToohCnB8CbzsoppuoZcOl7ElfTKkwAV+FWE8yGQTDZXO9CWlmZClPSE3jPiizUHDynL0MCjITm10cvVfKm8/bj+BJpo0BRk8WmG8l68rMc+e281HDJVyq/MsL0vUUL3b20e+6/rwuY1izxMDXCdd4q/VRbIyHGbSDqq4bTQZIrHMBVGwO4ibZaEchh+h4/lZvQRHphfdJoJZPK+Uq+iPoh40TYPYk96jWlWxEfHbM6/tZyPvn2lELexDc93C0lOx9uxYXgqiq5RN9IzcxPxDdZymLcV0w5VhfAFXX6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os7l4+15lMlO8RTCYffRmaMOlAhPC3Eq/yMao4KhkSE=;
 b=EJyEfZCuhsub0NJju5Xu9Tc+eZZnaNu+ZxJ/Gv6unDx84mIaQQMzAviuYKGjx/vUSTKJw50Oh4x19IU/XJ3mXWERxOA40E93RXBUfScrURDeJVoYcIb5EPGQ2yKkgSO/BsUhjX/QQfrQ85zpqnBD42LjynsKVHLvCtGr+ilHVmotFiqprsfWhg8iLGuiP0liPp3vzdx+/2N4ZEoUdKcqEML9XibCXfue1od+BY3pBh2mjaPDc1o9NPCR1lCuzSyg1y/WcCm0/MKwHlOPwVSED4vT2NufHhbCGBLIQ6IlybazFx5YJqw3hFyCvw+/ZIShqUyhUse8AO6ojqxpDcK46A==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 04:51:58 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%7]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 04:51:57 +0000
From: <Charan.Pedumuru@microchip.com>
To: <mkl@pengutronix.de>
CC: <mailhol.vincent@wanadoo.fr>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Thread-Topic: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Thread-Index: AQHbBNe8L4bnDgesHkesBlyKKxeHIbJTwvyAgAxk+IA=
Date: Fri, 20 Sep 2024 04:51:57 +0000
Message-ID: <d9987295-74eb-4795-8517-379249cd7626@microchip.com>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
 <20240912-literate-caped-mandrill-4c0c9d-mkl@pengutronix.de>
In-Reply-To: <20240912-literate-caped-mandrill-4c0c9d-mkl@pengutronix.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|MW3PR11MB4586:EE_
x-ms-office365-filtering-correlation-id: b9e4f5c6-1130-4980-688c-08dcd92ff519
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eW12eFh0eitQWUtJOEYzdjNjK2hwa0VMYnV2T2lYUEx3ZDBqR3lFbDI0UEQ5?=
 =?utf-8?B?OWdrSzZnRW4rbk5HL0dENk13TVJDVzBpRnc0N1cxd2tYNXBWV1F4ODM5ai9z?=
 =?utf-8?B?MzhIREVWMzBMcjcybWJoRjBiT0RPRHM3R215WXV3U2p0TmVZQy85R1BtTWpk?=
 =?utf-8?B?d01LeHkxRkE1K2ZzZFNYbW8vMVhvSEtIUWVTczBocmpOK04vOWUrR04wMnpa?=
 =?utf-8?B?ZUJzY01hTEpPb29zNXoxSFhZaTRQSUpGVlpaOUh1UlNubUF6Z0FGZ3ArODRF?=
 =?utf-8?B?MmJSNkNOcjFxMmZjSkwzYndnOGUrZk1Wa2hiYzQvbmhERnUzcFgxdW91cEUz?=
 =?utf-8?B?MkxDRmw2djVSL0diVFVzdnBIZGFxZWluTE5MTnh6SENtcjRMYkNpTGp0eVdC?=
 =?utf-8?B?YytjVnpxMitXSFRXK2Q5NkxRWFNnVTFKaHhkUHBqWS80cklCTStpTnNIdFZl?=
 =?utf-8?B?S3VFUEtPOVJSS05rRTV1L3dza3F6cTA0MVVJQjIremdyVERWNmI3TVQvcFlG?=
 =?utf-8?B?NXhvNVBpZk5Db3N3ZnFNNmhUYVFRUUpZOUlYT2lZMkVYTUVnTFJKcVhoUDJO?=
 =?utf-8?B?azg1SDV6TC9oMG5Db1o0MW5TQy85Z1l6dno2Z1ZKK0pIUnNwMzIybk5MWU9W?=
 =?utf-8?B?RFhGZEYzVlJvMWtJQlpCVGVRZHhwSXJISHFScUorZW16WTZWK0xDTnlPNWF6?=
 =?utf-8?B?VnVYODduSkpEUy81T2ZpclZNU3NEQWVkOWpid1k5V3FxNG9tdmZOWUlXRnVE?=
 =?utf-8?B?c3V3UGJtbmJvZiszK3NrUkRRVThFNVNIUDFoajZnY0hxSzA3RVBhMm8yNm1h?=
 =?utf-8?B?MFFqTG1oYXMwSEJmTmFiSjdWVHVXRVQ4cVBYWjNUYkNYMkVmemVyNXBWMENL?=
 =?utf-8?B?WC9uYk9NQ243azFZc0t5cVVUakZMcXZlSzNLR05POVBIRHppTU9SNTg3cHBI?=
 =?utf-8?B?TDVrUXVPRTlDTGtma0xZeTZDbHVZaHJFZ3gvTGFHWTNRaXdsbUpGeFl0L2tx?=
 =?utf-8?B?YlZRbC9TblNlVzlvbWxrbnhlR2l0Snh0b1gvRkFFYmQ2UG1wUjFSQU9iMXZk?=
 =?utf-8?B?VEwrNkN6eFh5akw3STMxb3NxWXpHY3RRaDRjcHFDN0xuTDNHdE8yMUdhbVBO?=
 =?utf-8?B?QTRNRE54bDlJY1lCcnJ4RzllM0FxVDNhQ0tnRldGclFpMmFNeC9ONjJ2Q3l0?=
 =?utf-8?B?N1dGNTEzSUFYVUZmQU10TDRMUjlKRWRxZmIybGFwTkNWdUx4dGdqeVpUWFkz?=
 =?utf-8?B?cE1kZHdJN0FneXJtQkY3eXRYL3Y2dytkV214bExPb2xPa2JCRkRES0M0UUlz?=
 =?utf-8?B?Z3dsOGsrVTRxRHdicHJCYWFkU3BvSUZmNk5RK09NK1BKbDZVVVF4ZkpRQlhS?=
 =?utf-8?B?UkcxeWtINk1odm1CQUo2bDBLOWFlRXBucHF5d29sOWI5cmhOcnA0MlVFUGZR?=
 =?utf-8?B?SE5tRDhzODZmcVcrWlRtd2NTT2YrWTBkOHZqUVpOV3pHUlI4S2hzckp0Y0V1?=
 =?utf-8?B?VUt2OUxHQXJ2YkZlU0ZMeU9HWWFUKzZPNHNhbnJ0ZVRkakwrZE16ajhhK3Vl?=
 =?utf-8?B?bWpQNXVkc1NWOFRxUEtYZkVzV3BqZUVENm94QW9SM2NsSW8wSUZoenBydmxh?=
 =?utf-8?B?RThrUzh2UzRocjNkaHdTTnNxNEwrRWFZbWR2R0xuYy9RQnU0TkpaMUJhMkZD?=
 =?utf-8?B?NmFvN1l1Q3lSaGtqOWhVMm5hMXZFdnY3UXNoaitsZGtWemFRaG5qNEUvVEYy?=
 =?utf-8?Q?nY4pxmBevYQXZOe7as=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3BRckhWbFJGWUI5Z0s0OUR5TDBxUTJ6NGpDRG5uTHN4bUVxSU5ZaDBxbGZp?=
 =?utf-8?B?cHRkRUd1MmJHaDRwR21SYWs0SVVZTVVPN2ZWMUNsampQSXlkTUV6SDhmSFF3?=
 =?utf-8?B?dVd4T2FNYXVscmxVb1pXdmwxZTZzZHNkM0lFMElKVTJvL0hCclBsQWlCOTBu?=
 =?utf-8?B?VW95VlhNOS9lU0xhVDIyU0R3ZXg0WnNLZlcxOG81NUt3ZjJqUDZ2eTNhSHRz?=
 =?utf-8?B?emtqVE8yRXpTMDBQb1VIaWpVU0FkVm42Q3pLWmwwckw4Z0N3N21WbTdINnhu?=
 =?utf-8?B?RUxkQ2d6c2VSMm9tdHJydnpMSEFSVnhEOURnUlBBSSs1UGZvNVppRHNyb3FP?=
 =?utf-8?B?SXFTd3Y1V0Fva000L0hVd2prQTlKKzRGMVlHbmFwcWpETVhwNzJOTjlkcUI1?=
 =?utf-8?B?UWF5N1haYXRsUUlpNE9TRE1icG5pZzBoN21aSzFOenpMQjgrcjJFajhmUmRB?=
 =?utf-8?B?UGtUVTZ6QUVyNXcwcVVLdUdNYmVkazdKZ1pkZGlBMDRxSEV6b3NLN3BaUWlj?=
 =?utf-8?B?UTd2aXhGMzBjeEVQTUhoazFZZHRpWWloUnZJdTdmYTdqQklpQVJ5eWkzOWJ2?=
 =?utf-8?B?R1BiMGI4QTFjZkVTSnZQakEzSDZFeS9FZlpDQllzN00rNzd1SG8vZUtYZ3R3?=
 =?utf-8?B?NjNFYTVJMnRCVW5hU0o1dklpU2szV3NrZVVXTEM3Q3ZJYWRSRG9ORkI2NW91?=
 =?utf-8?B?Y3FjZnl3bzV5ZUhVUDlSZHh5c2Qvc01KTVBYQjRqZGxEZWZxQ2paSkVQUnZt?=
 =?utf-8?B?TWpiN0Zjcmo1UTdpbnJLL3MySkVQMjl5ZVl0OUlxNm5ncTFEVFk4M21rRERQ?=
 =?utf-8?B?WjZ3MHMxYXk5MFU0ckVheTUzOUxYRTdDU3VXSkFOK24vVk1Eb2lHc2RKb0gz?=
 =?utf-8?B?ZHpEcmp0RnFRUHVKSHc3aUY2NEpvZE0zd0k4OU5WaHVkRGNlbW94cC9mZnZs?=
 =?utf-8?B?cU9UcnM4S28zZlVlbmcvTlcvZ2srOUNkdWtrMEY1K0E4cFdpb1lTZEsrZjhk?=
 =?utf-8?B?THVzUWhBVk5ua051UGc0clpuWWgxNU9LWS9EM1dBZ1ltOGdsZE96aldQM25L?=
 =?utf-8?B?Q0NSY3NCU1lBVDJmSW9vVG5pVm1lSnM4SmVCYndIOWRJNkpWRWoyTlRabDky?=
 =?utf-8?B?d09lTWpxc3ZxTlB5UUNqaHdoVUVZY1M2ZDVicWxCQnpvOGtMN2hROE1rSGly?=
 =?utf-8?B?ZjFwSkJmckMvamdGNHVvbmFNelo2c1p2UlZwelFZTGo2bzRKZ2o0WVREV3l6?=
 =?utf-8?B?dHYxb1UwNkk3azMxZmtyUlBlTkRxM3JUazlSRlJEZE1YeTRWRStEOGpxZEFY?=
 =?utf-8?B?RUNXYVRFOENIbkVuSWVVYllXazZvTENCeVBJbG12ODZSUlNBdnBNU3dYQkpY?=
 =?utf-8?B?V3MwelFnSGZveEhqQnFSdXg5T2dJQmxEcGUyS1VPZFNXMHFhRkVuT3dhWXVh?=
 =?utf-8?B?Ni8yajZBTDQwQ2dSWk5HQXdZUU84TmZZL1JOTjhwVEcyTVpzV2RXNVIrWGVP?=
 =?utf-8?B?ZHl6eWtGMFJaaDY1bnJGeTdiMDl3Z29KRWFxMU03anRqUE44UGVwbjBETTFV?=
 =?utf-8?B?R1RkMTU0VmwzRWo2R0ZjVmFUUlBGVkNhQ3BQZWFyZ1pGVUNWQm4wSVZQeDZ3?=
 =?utf-8?B?QzIxelk0NU15V1J3eThmRkkwZk9OZW9HRHVzZlJBZ2tNUUhORnFneG5Sbnk4?=
 =?utf-8?B?K3B3T1FoemlNOFl1ZVlGb1JRQU9pT2dPc21haE96RXkvUXhCUE54YXg5dEd5?=
 =?utf-8?B?eEhqQldTWlRWMlhsYU9ub2FONWJRSlhsTkdpRGdHcTV3QXJCVWlVRng4U0VV?=
 =?utf-8?B?SXFHU1IwUUl4bFlDRjYwdkJIeUhHSGJLV1lFYXc3UzVCaU1EQ2hsamxoVXVo?=
 =?utf-8?B?Z2RibFMzaDNibVFJNjhWc0Z3RWhaSlF5U3dIRS9VNVlzeEVBMFF1Vno0dXp5?=
 =?utf-8?B?RGxOelZkWkMxM2xkWkJZSUIxNlJvSGYwL01TeGk1NGIrYVIzdTJQREc2MUQ2?=
 =?utf-8?B?V3JNV0ErWWczejhxaytkc2VYWFo0dGFiajVRZElVZUVDZDNVSjlpTDlnNUVY?=
 =?utf-8?B?cVlUVWZVUFpnS05OOTFTZnpkaWFSM0hNNFFrbWl5S0tiTWduQ1gzSGs1SzBI?=
 =?utf-8?B?akJzZkFmSTNaK0FTcTFjY3JucEYwelduaU9lNlZvc0NDUXRSajJScWMxT0xy?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B30D2BDE2A60A54692FB9D431010C53F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7410.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e4f5c6-1130-4980-688c-08dcd92ff519
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 04:51:57.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n7sDb9VETN+gfxhtO7Utb26lTwod1Q8Z6S8c3xPCt62B+uPSLFtkCn5AIDnqQTuxUxyBlUkgLuv0uvBPPYpC7r0B4upcSEfUAWLsVzD1d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586

T24gMTIvMDkvMjQgMTM6MDUsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOg0KPiBPbiAxMi4wOS4y
MDI0IDExOjE5OjE2LCBDaGFyYW4gUGVkdW11cnUgd3JvdGU6DQo+PiBDb252ZXJ0IGF0bWVsLWNh
biBkb2N1bWVudGF0aW9uIHRvIHlhbWwgZm9ybWF0DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hh
cmFuIFBlZHVtdXJ1PGNoYXJhbi5wZWR1bXVydUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAg
IC4uLi9iaW5kaW5ncy9uZXQvY2FuL2F0bWVsLGF0OTFzYW05MjYzLWNhbi55YW1sICAgIHwgNjcg
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL2F0bWVsLWNhbi50eHQgICAgICB8IDE1IC0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwg
NjcgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2F0bWVsLGF0OTFzYW05MjYz
LWNhbi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vYXRt
ZWwsYXQ5MXNhbTkyNjMtY2FuLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjI2OWFmNGM5OTNhNw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vYXRtZWwsYXQ5MXNhbTky
NjMtY2FuLnlhbWwNCj4+IEBAIC0wLDAgKzEsNjcgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+
ICstLS0NCj4+ICskaWQ6aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L2Nhbi9hdG1l
bCxhdDkxc2FtOTI2My1jYW4ueWFtbCMNCj4+ICskc2NoZW1hOmh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBBdG1lbCBDQU4gQ29u
dHJvbGxlcg0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBOaWNvbGFzIEZlcnJlPG5p
Y29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAg
Y29tcGF0aWJsZToNCj4+ICsgICAgb25lT2Y6DQo+PiArICAgICAgLSBlbnVtOg0KPj4gKyAgICAg
ICAgICAtIGF0bWVsLGF0OTFzYW05MjYzLWNhbg0KPj4gKyAgICAgICAgICAtIGF0bWVsLGF0OTFz
YW05eDUtY2FuDQo+PiArICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtY2FuDQo+IFRoZSBk
cml2ZXIgZG9lc24ndCBoYXZlIGEgY29tcGF0aWJsZSBmb3IgIm1pY3JvY2hpcCxzYW05eDYwLWNh
biIuDQpZZXMsIEkgd2lsbCByZW1vdmUgaXQuDQo+DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsg
ICAgICAgICAgLSBlbnVtOg0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1j
YW4NCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTl4NS1jYW4NCj4+ICsNCj4+
ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+
PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBjbG9ja3M6DQo+PiArICAgIG1heEl0ZW1z
OiAxDQo+PiArDQo+PiArICBjbG9jay1uYW1lczoNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAg
LSBjb25zdDogY2FuX2Nsaw0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxl
DQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArDQo+PiArYWxsT2Y6DQo+PiAr
ICAtICRyZWY6IGNhbi1jb250cm9sbGVyLnlhbWwjDQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHBy
b3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgICBjb250YWlu
czoNCj4+ICsgICAgICAgICAgICBlbnVtOg0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAs
c2FtOXg2MC1jYW4NCj4+ICsgICAgdGhlbjoNCj4+ICsgICAgICByZXF1aXJlZDoNCj4+ICsgICAg
ICAgIC0gY29tcGF0aWJsZQ0KPj4gKyAgICAgICAgLSByZWcNCj4+ICsgICAgICAgIC0gaW50ZXJy
dXB0cw0KPj4gKyAgICAgICAgLSBjbG9ja3MNCj4+ICsgICAgICAgIC0gY2xvY2stbmFtZXMNCj4g
QUZBSUNTIGNsb2NrLW5hbWVzIGlzIHJlcXVpcmVkIGZvciBhbGwgY29tcGF0aWJsZXMuDQpJbiBv
dXIgY2FzZSBvbmx5IHNhbTl4NjAgaXMgdXNpbmcgY2xvY2stbmFtZXMgcHJvcGVydHkuDQo+DQo+
PiArDQo+PiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK2V4YW1wbGVz
Og0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9pcnEuaD4NCj4+ICsgICAgY2FuMDogY2FuQGYwMDBjMDAwIHsNCj4gSSB0aGluayB1
bnVzZWQgbGFiZWxzIHNob3VsZCBiZSByZW1vdmVkLg0KT2ssIEkgd2lsbCByZW1vdmUgdGhlIGxh
YmVscyBpbiBuZXh0IHJldmlzaW9uLiBUaGFua3MuDQo+DQo+PiArICAgICAgICAgIGNvbXBhdGli
bGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1jYW4iOw0KPj4gKyAgICAgICAgICByZWcgPSA8MHhmMDAw
YzAwMCAweDMwMD47DQo+PiArICAgICAgICAgIGludGVycnVwdHMgPSA8MzAgSVJRX1RZUEVfTEVW
RUxfSElHSCAzPjsNCj4+ICsgICAgfTsNCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9hdG1lbC1jYW4udHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vYXRtZWwtY2FuLnR4dA0KPj4gZGVsZXRlZCBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAyMThhM2IzZWIyN2UuLjAwMDAwMDAwMDAwMA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vYXRtZWwtY2FuLnR4
dA0KPj4gKysrIC9kZXYvbnVsbA0KPj4gQEAgLTEsMTUgKzAsMCBAQA0KPj4gLSogQVQ5MSBDQU4g
Kg0KPj4gLQ0KPj4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiAtICAtIGNvbXBhdGlibGU6IFNo
b3VsZCBiZSAiYXRtZWwsYXQ5MXNhbTkyNjMtY2FuIiwgImF0bWVsLGF0OTFzYW05eDUtY2FuIiBv
cg0KPj4gLSAgICAibWljcm9jaGlwLHNhbTl4NjAtY2FuIg0KPj4gLSAgLSByZWc6IFNob3VsZCBj
b250YWluIENBTiBjb250cm9sbGVyIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiAt
ICAtIGludGVycnVwdHM6IFNob3VsZCBjb250YWluIElSUSBsaW5lIGZvciB0aGUgQ0FOIGNvbnRy
b2xsZXINCj4+IC0NCj4+IC1FeGFtcGxlOg0KPj4gLQ0KPj4gLQljYW4wOiBjYW5AZjAwMGMwMDAg
ew0KPj4gLQkJY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOXg1LWNhbiI7DQo+PiAtCQlyZWcg
PSA8MHhmMDAwYzAwMCAweDMwMD47DQo+PiAtCQlpbnRlcnJ1cHRzID0gPDQwIDQgNT4NCj4+IC0J
fTsNCj4+DQo+PiAtLS0NCj4+IGJhc2UtY29tbWl0OiAzMmZmYTUzNzM1NDBhOGQxYzA2NjE5ZjUy
ZDAxOWM2Y2RjOTQ4YmI0DQo+PiBjaGFuZ2UtaWQ6IDIwMjQwOTEyLWNhbi04ZWI3ZjhlNzU2NmQN
Cj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiAtLSANCj4+IENoYXJhbiBQZWR1bXVydTxjaGFyYW4u
cGVkdW11cnVAbWljcm9jaGlwLmNvbT4NCj4+DQo+Pg0KPj4NCj4gTWFyYw0KDQotLSANCkJlc3Qg
UmVnYXJkcywNCkNoYXJhbi4NCg0K

