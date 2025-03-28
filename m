Return-Path: <linux-can+bounces-3289-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F556A74EAB
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BADC189810F
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998691CEE8D;
	Fri, 28 Mar 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DqsGmuoB"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010036.outbound.protection.outlook.com [52.101.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78D17F7;
	Fri, 28 Mar 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743180387; cv=fail; b=jIql3ZdbV9cyP1X9nc92ebSAnofwlf7NI2DqL9TBqp4kf1I87NFr2nZomH56bwmIq5aMcO82yjFD6P66bFpNnorPjjWqLRi8AimFm8AD69y606L1RtQwNpM0BmjOlJfPkpscS8BaFp+WDttMylLg6tmhwA966mdJKWNxrPnAX+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743180387; c=relaxed/simple;
	bh=F6qJqVcR3rR+SH6gZZHlcoAbDPCw2N9f8mQAKByyLSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFKiylr8G2uN0sA9/+dk1vEduORNs7hWM26xyn8cVgkG6PkAY3OcxpYH3clrARJa7ao30U4BXz9BGTZxiqak2f10HgRXsYQXK4EtLv9ZM6PC9FpmIId4VFGFdHgpHlBFcf9edfJGtJzsEx9u8YrD/wysHZwwF0wIcCXwnwCYRDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DqsGmuoB; arc=fail smtp.client-ip=52.101.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck7X4uBshr5CoodtiLF5+bIANcNcc/msrTExN+AHnMsO2215XDCjFf5jDa9KXoHPpi6woslQKpBN846Ef32B8cd+e+UE0Uo5JcRBQ2MORk4uocL97vZUrJ/jupXC2dW6zWUyK262TOxDtgO0CFTMM/pfwFclDLyqLYkEym/8O/tiK/6ZD3xS2Wt1V99lM+/pwU6b7Jr/FSDGTh7QvjZTDAw626B8MIO+2jwNiKiSDnrzxd4mCfzNWB66UGuCbeOnikR+dVkWSrReVBgGF30DKRXgJ17G7wUYqsuweXc5UQmrClOVIGPh3Fa/yJyk2H2lUO1rF3Vxa1OjJNyLaRPXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6qJqVcR3rR+SH6gZZHlcoAbDPCw2N9f8mQAKByyLSA=;
 b=w5zx6WbLtnlTiN8CmeftCGJvO37ewm6um2Iu3HGcK5pqHzjrDHGE497vRiFLF8nTsqh5mWCXYAT5D3G8hnqwiceWPi43RykKJN3JowUvu4vE81FWQJ9iPUr/4LZEShaw3U7uJMLT72cjJCUWkmCYwpEnTU3lbKDhBFChMo7G9O1ejcmomyBjWwh1c2zFYKqBsRwjU4Sj6dgeaXMpxHJ9688TwM/JMCD0YQ4h8Rq7EZwS5Sy3jBZKTL5XN7jhwUR9+oZnB+OaQD3oCSiBGU4Y3uJiijyLFvU155DaJW5MIuMvhAaStHWF/1T4NVVQNjgzZfyeuCXgIySXm2Zf+d/hyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6qJqVcR3rR+SH6gZZHlcoAbDPCw2N9f8mQAKByyLSA=;
 b=DqsGmuoBUoPbQ8gshD8ybMSiWXlX9XAFilo4Td6dz9vhj77lbDagJdsCx1fdeMdWsG3F6A/3Fy/lZlX29+NMLf0OVl7uBCTa9/8RUZec2iCsvB1MBdQJWp2LeE7ak+sIUNeX+wlmzPUl0iNicfCOzV/WyeHHEkhnsSJY710u1FM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8288.jpnprd01.prod.outlook.com (2603:1096:604:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.29; Fri, 28 Mar
 2025 16:46:20 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 16:46:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
Thread-Topic: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
Thread-Index: AQHbnkl9i1pj+Nv9/0+uivOvdWdzlLOIXgMAgABSoRCAAAiogIAACvnA
Date: Fri, 28 Mar 2025 16:46:20 +0000
Message-ID:
 <TY3PR01MB1134664605538933A2A59285186A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com>
 <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
 <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdW7qTBVuHCxVfpOom-dEkROYfPG_neUiY7iUq=HAgAjFA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdW7qTBVuHCxVfpOom-dEkROYfPG_neUiY7iUq=HAgAjFA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8288:EE_
x-ms-office365-filtering-correlation-id: 243cc3e6-c254-470b-1a53-08dd6e181152
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QStTK2NZZ203VjZDazYvUGlRYVFXbE10RTZscEFEaGRlR2ZLaFcwNW1mMEJl?=
 =?utf-8?B?aHczWVJrcGNCVnhkUmlpNjNpR2h2dWViTnQ5dnB5RzlMa3A2R0NJNnNMSEEv?=
 =?utf-8?B?VXpXUEZ6c0xWQkoxSXdIS1hDN2VUeXhNY0NWU0ZnTTB0MGRmWUJBSStvZW5G?=
 =?utf-8?B?NlhQN0MyL1BkS2RMUTVvY0JwRzNSeHB3K21lS0ljdkI0NkpDRWdZQXJrUmpn?=
 =?utf-8?B?NkRpMjE2RnpNVmNpYVF2TEE1SnJYZ3Q1Q1RiS1gwalFkL0JBY2xuVTQ3QVox?=
 =?utf-8?B?QVNtOCs3TmtlQVVkbTl2WTN5bHVHOG9wVWdVMStvR09oVzY1UmVFUlhZWmJi?=
 =?utf-8?B?RmI0cEh0Y3FhZFFQcjhrRVlFdFoxVXJDV2xTclh2M28vQ0FudnFSc1ZYbFB6?=
 =?utf-8?B?R1FWSU15OHFrMDgzK1VuY1FuUzBreGVTSDhDNzF0M3VIeGh1UmxvMW5DU2JC?=
 =?utf-8?B?ZnJCU3NRQjZRbjNCN0cyTTJZUG5WL1VpNzluNUpLMml5MElqSitCeFJKaER2?=
 =?utf-8?B?NE5vL04rUk9PMnRZeVpjYXJmUFNFb01tWmhuQjRWUngzNzU5aDlHelFzV2Qw?=
 =?utf-8?B?Z1J0ckxWS0lMQXlIRDNWRGtoQUR4N2tqbGtVTi9aSnB6a3BiWENZOXJWajhj?=
 =?utf-8?B?WVZDd1o0N3ZnUzl3YnNXSHhnWEMwSDA4dXg5TFhxUGxlTEJDZTVOVUFReDVX?=
 =?utf-8?B?b3Z6MS9taElBT3BlNHFuQ2grdjE2RGpnaWRtbE5TZ2ZYMzdZa0IxN2RkSEt5?=
 =?utf-8?B?TTJWS1pBVDdkOWZFdm9oZXVzanBOelpKMVJBSVdRMGYwN0l5dm1WbHlVZnQv?=
 =?utf-8?B?TTRLRlhEcGJvNjZUMGNyR1AzcFBjYVhXUzlDM1JMR1EwaHYzZXhnSFR4eWwv?=
 =?utf-8?B?Ty8vZnozQVg0Vzd2dmNwVGZ1aTRJQklNTUdmRVIySXdLb3Y5a1VwMnQvNmNp?=
 =?utf-8?B?dzljSDVQZGoxdDI4dUZTZ1lOajl0bWo1c3ZLQ0liSVhFYzRUS1IwQ3Joc1hE?=
 =?utf-8?B?eWRGMUo5TFR1MFlQak56Yk53b1VZM2tHZnhIMUFLekxhVDliZzhWSzE4U2tB?=
 =?utf-8?B?TmFodlR0RWtNdGpHMXR5L3hGRWxvdTNsMStNYkloYml3SHc5bm5GaXVmajJ1?=
 =?utf-8?B?Mlh5bGkxK1RXbWR3Zlk1S2JQWHFGdFhxOHYyNUsyYUs0RDRnYXpsYlUrTStN?=
 =?utf-8?B?ZElYclpGeE56V21OSGczODJWOTRzU2pWYXZEVjZNV1pOU3Zpd1hRQmpxMGlX?=
 =?utf-8?B?NG10Zm4vVm41MVJRUmU1Y09MMUtMczFSa2EycHJBZVptNzZuTXo0WlhiOTRH?=
 =?utf-8?B?UjJENFZsVnV3ZEZPTkFvWXJnM25aMkwyUW1LZTEwVVRXbUpYRmJ1aTQ0bUts?=
 =?utf-8?B?K3JuUGJabkE1YVU5SDRFdVRsUVJqNlRjRXBnTXZ5RjRFeFM2V2pJT3NYM2pN?=
 =?utf-8?B?WFNCVlRRTDZlZ0p5Z3IwOHNhVWZ5Nyt3ZStsdkJrVlFUZzBvLzR1d0lBaXd4?=
 =?utf-8?B?Z1FCTE5xREloOG5DbmM0N001cHBWOCtaZEd0dnNMNGdyeGt2NzdkK1BzNExB?=
 =?utf-8?B?S2U2QVNKWWtaTTRTMkVpZFJRaDE1ZExkNGM5WHlmQTZxOFpCU1R5MjR2MWRJ?=
 =?utf-8?B?SUJ0a0QvbU1NTVNHN0plTTVTNHoxa0FOZFVGcVcybjhRWGRSVnBCRWR5Q2Yr?=
 =?utf-8?B?UW85OTR0SjExb3d0T3J6ZjJhRzhGRzA2c0VURE5yU2RzWjlLcUtOY1VVRTNu?=
 =?utf-8?B?a3VZRXZXNG1NN25VTHg4TWZkWmpSeXdpaDVnTkJYUGlOU0VucDFxdXplcEJx?=
 =?utf-8?B?dkFFMEwzd2dZOXZjT0xFeExaVUFRS1dzZGc2aVBwRUxoaXZ5M2w2RlBSM1ox?=
 =?utf-8?B?cFFIVGFIYlR5bXJGNXdtcXJLL2NpdE9xRW9BSUhDQ0RRS2VEaGRBR1oxeXI2?=
 =?utf-8?Q?rNEnVk1jRRAME2Et6Edq0uvEdOkEdusk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHc1Qjl2dE1ZaGFTT2NVYXZCQjBuc2s1OU02Nm5MWVA1bW1kY3BmNmp6aFVV?=
 =?utf-8?B?Y24xUXhhZk1OMDFhM1g4dzhPajdhY1hNaktyUDBhUXcyOUVWbHdtVUhzWm02?=
 =?utf-8?B?S1E4ZnNmRUR1cjY0SGZ3ak5ZY1BXSVZQdUx0OFBnUXFWY2ZIcjBKL0hlZ0JP?=
 =?utf-8?B?ZEdmb0NkK1dvRUxkUlhKbFhYN1A0TlZ4SkhCM3BDOHJtblNNd0d3SHVSbkFq?=
 =?utf-8?B?KzhTOU5nZU9aMEdkbGVrYzFsOEtkaDZ5TjRsWG1KYnhzMDRwQlZSdlZVWStH?=
 =?utf-8?B?Yk41bkVTU3BSQ0lGZXB0cGgrVEozVUJyU3FzaER1SnVBb3pMa3pNelJqNlcy?=
 =?utf-8?B?dnVyeUY4bVlRZURQQm9zYTJWR1Fmcko1R3JRYWxxa2V5UDg0TW1VWVl4L3U0?=
 =?utf-8?B?azVNWkt6SUNmTjBUaGxsckJ4dWthS2FYUFhxQmlSQjhEcnI2NDg0NEovUEty?=
 =?utf-8?B?K0xIVGJESS9CMTV3c3JoNFBCZG53UHVSb0JEMWYrTVJEWEh1emVSKzE0bE1u?=
 =?utf-8?B?U0ZKMTFjTHZzcnRCYzh0VUE1VGdFb1ZuSVdoVTVHOG9vUm9LdlE2MHdSTEwv?=
 =?utf-8?B?UlluNmtqY0tEcmE2RWNWQ3BUQm1pcEZvNm52T25ucmJra1pCa0g0TmFDTVND?=
 =?utf-8?B?UXRlVkU2NXRoR1BzZy8zd3JVRXBOdmJhbVB0eUhGTDlMUi94K2oreFhsRitL?=
 =?utf-8?B?em1HaDZWcXVVRWVUa2c3M3BwQzA5bGZ4enB1anF0RHNJTFBsOCtHbjdNdkcw?=
 =?utf-8?B?a0hNM2grenp6bjVmcERmSmJvUitBekQrT09TRDlOM3pCRWtBbHJvdGtZNFJ6?=
 =?utf-8?B?R0VNV1VkMDA2aDJ6Y25vZ1ZVeDJvUWRTRmRvRVIrWlFMT3dueUtrRDdLd296?=
 =?utf-8?B?V2FDb1RrTzNsMGd0V0ZjMW5CRTMwVmlFWVcwWkdGZUFVeVMrWXJockpVdWZ2?=
 =?utf-8?B?QzRzS1RMYTBHb0xacks4aE1xakk4R1M0TXczNk9NTTNLTVp3VzJmZS85aFg5?=
 =?utf-8?B?RFBnb1h5QVp0YUxsNGgzRDRTK2xPMDZNQWx4WS9BTmR5aXpDNGpBQjY3V1pw?=
 =?utf-8?B?bzcyWk5EZmJ1d3BZZXV1bGgwL29NR0J5V2tPQ3JON01xQVloVDFpdDdrUC85?=
 =?utf-8?B?MzVJM1NVMVFqd2xac3JrY2lnaVVMOXpPNGZnRnZodVdvYTROYUdOL3dhRnBQ?=
 =?utf-8?B?NS9SSkZXeU9UTVlpOGdiaUlaRGtDNFpnRERiTllOR3JYaWhXa0crUk04VGpX?=
 =?utf-8?B?Z2kzazMwbUw0aTlab2tOUnNpM2htMVJpU21Eb2d6TFJEZThNQlJwSDEybkdV?=
 =?utf-8?B?ak4yNWRZOUIzRzYySW10NEEzNWd6YitpZlpHZFRiblhqclhNcjd1ZTJyaEs3?=
 =?utf-8?B?M00xL2gyNTIxQ2E0V0JONVl3c1BXZ01XVFd2Q1VKRVo1NXJLRnhNeVM4ejRh?=
 =?utf-8?B?bUw5TWg3Zk95UGcxdHlHQi96K3ZFMloyUkpDbFdya2lOMUp0QUc3SlkzS1A4?=
 =?utf-8?B?bDlZUUhwekxCRkZrbzloczB3UDVFYlpPNzRBcmE0Wml5THRndEY3eGk2OVhn?=
 =?utf-8?B?UlJLQXNMRlloN1B5SW5zOURHR1U0Z0RaZkxUMWZoMXVnekNoU2RCV0ZXUHFx?=
 =?utf-8?B?SnJ2Q2p3ZE9ScEZXRkJlaHBXUmZlN1Y5TUlrVjVPV2tNZnQzQjA4U1VGWFpI?=
 =?utf-8?B?TUVBVzMzSTM3VmFKaTk0b2t0UkF1cTI2akI4MXR6bUNtWmFxZzZYa0RmNGM0?=
 =?utf-8?B?aW4wUWd1ZUJCRHNDUEtCRU1oWElmSmZ6c0g2WVIrUWNqZlhEWHQ3TnNxLzh4?=
 =?utf-8?B?N3l0bUhxbVVJL3dDSlRwZDNkU2twQ0t5MklueHlYN0krMGxoVENRd05KaGdR?=
 =?utf-8?B?cXVRMkhKWGhKNU8vb1Rpb2R6QlhFTlRqMG5QamNOcVlIMEFNSGYxeWcwclBH?=
 =?utf-8?B?TmRHcGR2eFZsQU4zNEhTMVdSQzJDRjJzK3BHL3FHQVdnK0J4alB2VWxlK1dD?=
 =?utf-8?B?WGh1ZjBTNFE0eEtYbXAwSHlhclFWZGNJWHZhYjlJU084ZmZRTytaTktuOVpQ?=
 =?utf-8?B?L1FhTHFpbmpjQ0RoOUE5dVBSeDVjdHlxcDI1aDFOMDY0NzhNSVNiNzJ5dmFH?=
 =?utf-8?B?RkUxS09laGVqSEwrcFh5M1gwSkJJOE00QytqNDEyVEZMekVFU2RKa1E3d1VO?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243cc3e6-c254-470b-1a53-08dd6e181152
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 16:46:20.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAlXXAY0X9IrP+XhbN7wBgMp1y9/OC2fljAj2xi5p2WvE+0CFEnusurLsBG8aezxwLVPswBuafUa6y4zjU2xEfs13Zv6xvqhm4VfZP9FEJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8288

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMjggTWFyY2ggMjAy
NSAxNjowMw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDA3LzE4XSBjYW46IHJjYXJfY2FuZmQ6
IEFkZCBybmNfc3RyaWRlIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8NCj4g
DQo+IEhpIEJpanUsDQo+IA0KPiBPbiBGcmksIDI4IE1hciAyMDI1IGF0IDE2OjM5LCBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IEJ5IGludHJvZHVjaW5n
IHNldHJuYygpLCB0aGlzIHBhdGNoIGlzIG5vIG1vcmUgbmVlZGVkIGFzIHJuY19zdHJpZGUgaXMN
Cj4gPiBsb2NhbCB2YXJpYWJsZSBpbnNpZGUgc3RybmMoKS4gU28gSSB3b3VsZCBsaWtlIHRvIGRy
b3AgdGhpcyBwYXRjaCBpbg0KPiA+IG5leHQgdmVyc2lvbi4NCj4gPg0KPiA+IFsxXQ0KPiA+IHN0
YXRpYyB2b2lkIHJjYXJfY2FuZmRfc2V0cm5jKHN0cnVjdCByY2FyX2NhbmZkX2dsb2JhbCAqZ3By
aXYsIHUzMiBjaCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnVtX3J1
bGVzKSB7DQo+ID4gICAgICAgICB1MzIgc2hpZnQsIHJuYywgb2Zmc2V0LCB3LCBybmNfc3RyaWRl
Ow0KPiA+DQo+ID4gICAgICAgICBybmNfc3RyaWRlID0gMzIgLyBncHJpdi0+aW5mby0+cm5jX2Zp
ZWxkX3dpZHRoOw0KPiA+ICAgICAgICAgc2hpZnQgPSAzMiAtICgoY2ggJSBybmNfc3RyaWRlICsg
MSkgKiBncHJpdi0+aW5mby0+cm5jX2ZpZWxkX3dpZHRoKTsNCj4gPiAgICAgICAgIHJuYyA9IChu
dW1fcnVsZXMgJiAoZ3ByaXYtPmluZm8tPm51bV9zdXBwb3J0ZWRfcnVsZXMgLSAxKSkgPDwgc2hp
ZnQ7DQo+ID4gICAgICAgICB3ID0gY2ggLyBybmNfc3RyaWRlOw0KPiA+ICAgICAgICAgb2Zmc2V0
ID0gUkNBTkZEX0dBRkxDRkcodyk7DQo+ID4gICAgICAgICByY2FyX2NhbmZkX3NldF9iaXQoZ3By
aXYtPmJhc2UsIG9mZnNldCwgcm5jKTsgfQ0KPiANCj4gTmljZSENCj4gDQo+IFBsZWFzZSBjb21i
aW5lIHZhcmlhYmxlIGRlY2xhcmF0aW9uIGFuZCBhc3NpZ25tZW50Lg0KPiBXaGlsZSBhdCBpdCwg
cGVyaGFwcyAidW5zaWduZWQgaW50IGNoIiBhbmQgInVuc2lnbmVkIGludCBudW1fcnVsZXMiPw0K
PiBBY3R1YWxseSBhYm91dCBldmVyeXRoaW5nIGFib3ZlIHNob3VsZCBiZSB1bnNpZ25lZCBpbnQs
IGV4Y2VwdCBybmMuDQo+IA0KPiBJIGtub3cgdGhpcyBleGlzdGVkIGJlZm9yZSwgYnV0IGRvIHdl
IG5lZWQNCj4gDQo+ICAgICBudW1fcnVsZXMgJiAoZ3ByaXYtPmluZm8tPm51bV9zdXBwb3J0ZWRf
cnVsZXMgLSAxKQ0KPiANCj4gPyBUaGF0ICImIiBvbmx5IHdvcmtzIGFzIGxvbmcgYXMgbnVtX3N1
cHBvcnRlZF9ydWxlcyBpcyBhIHBvd2VyIG9mIHR3bywgYW5kIEkgdGhpbmsgbnVtX3J1bGVzIGNh
bg0KPiBuZXZlciBiZSBsYXJnZXIgdGhhbiBudW1fc3VwcG9ydGVkX3J1bGVzIGFueXdheS4NCg0K
QnV0IHRoaXMgd2lsbCBtYWtlIHN1cmUgaXQgZml0cyBpbnRvIGZpZWxkX3dpZHRoIGZvciBudW1f
cnVsZXMuDQoNCllvdSBtZWFuIGRyb3AgIm51bV9zdXBwb3J0ZWRfcnVsZXMiIGFuZCB1c2UgbXVt
X3J1bGVzIGRpcmVjdGx5ID8/DQoNCnJuYyA9IG51bV9ydWxlcyA8PCBzaGlmdDsNCg0KQ2hlZXJz
LA0KQmlqdQ0KDQo=

