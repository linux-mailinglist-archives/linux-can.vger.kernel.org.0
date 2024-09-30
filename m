Return-Path: <linux-can+bounces-1574-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3989899B2
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9857B2183F
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 04:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466034D8BC;
	Mon, 30 Sep 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x4xEuP7Y"
X-Original-To: linux-can@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A225745;
	Mon, 30 Sep 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727669235; cv=fail; b=Dc4qOli+aJhbv06+J15xLiRVAkcMg1yu1v0zBoE7bfYTkBVDoILCw7WO9IMKWhoWiQ4HCMYU5V7xQZES6UTOD/teGPyl4iqzH/1U+vH8qqIidH6jZbf0R9OTmWPOZ+LpzwGXM7HQECNyYlZvBqVrj41/0QvgOUEHBjDjF+Kcdzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727669235; c=relaxed/simple;
	bh=7USyi3K3b7jXyhyrpfb72lVtN1Gi/fzBrv8AU9Yw+Pk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a7auH9B00v9WJUbktNusPEkS4uGmA5sM8s18brETKo2S3CO0IzYwagqjM5++fyYB1bnEEPED/7ImdoVhalwijEitR87/jak8+xaCvL8LxMLXu61wWm1p84FeGwLfK1XgyDj5RPaVEGc09zV+jrvvbocGFMyDw5pDK5m/mTqn4qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x4xEuP7Y; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ0Gff3l5xK9188KRodYars7SD7b1z1rYAdaIEX4wn0hXASxDj1SLccXlnymG6n+V4qRLiYj+F6LYZFI1YUaGct4MCliQGFp4/ozNEiK2F2xhOv9rwEvGoWo5pbJa8Ro7puVPdT18tChPglV89FyXxcqPdHTyPdrgOcHXqSZZg8uDzePZ1rJrAFDhvvs1XXjgdhveA+aolhuLa6+d/luZhyt+J8EqS/175hqeTNCS6GGxBXgtXhnlQPaIJwPMmjLMwa0WF1vbnNenPOPQiu+XtOXKIq1tX0ShXOn8Rx1lTodEoeoTSjJ58YkmPfifTguwkgNC5cJQVBHVmy2xaPrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7USyi3K3b7jXyhyrpfb72lVtN1Gi/fzBrv8AU9Yw+Pk=;
 b=b1B93kosDrAocIitneDrF49Zdc4RNND9VS4INvCWI/4+xqfGlJSpHVUqV3Uekj8RKiDzONRmBWBoIyFZVH4+46yikBkBvYBBjPW57tC2pAC0W/vwR/v73W4qQBNq5qCnTWHPiIYNOKmyG7c0La2bcHSms4bmpKp8GR6sEUY/BD8fSnp4A0xzvPOX+EigL3fmh2B6bTuuPdCY42lG8l9OplY1DaXca9c3dYLX3RB5U5YXaoMuKSZ7y5y+j/A5XAGDlaoXo1lH/yDk20ZQoA3vf7rklq/+DyTmfQovRKvQbv474wQmoOS1DyGQs2v3K6ZYAVkBgkAN7HsE+rDsrJtLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7USyi3K3b7jXyhyrpfb72lVtN1Gi/fzBrv8AU9Yw+Pk=;
 b=x4xEuP7YjAbz6kjU1BgZEKwfXN99PQiDJvhJ4BRzH/6TmW8xJ07GpOUKigLYsIgq21nH7JVhUHiJtulq8JrEHIGxJuHhwUS4+fbn2kpEPBmtMDFj54fU+PVpW6rW6p71bcP1CSEiWL57HV0I1Yb02ATb9Zu+1PXzJT/AB6uLBBDUJngGDl2GdwpmAhQGcbaD4v+T1j58+jODjgmj+/iJTlYdhcFgmJrro2VBQ9Xnf3HsNkG2OKrFDvv4WUfI2ZJQHNBJmqOszCq/NluhQkTRNOZgWqacaEkCUZvqIc8vXt7OWBvNOMb7yYG+XKI4FETq/St6F4Dq8leJdJqWeHnBUA==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by DS7PR11MB7930.namprd11.prod.outlook.com (2603:10b6:8:da::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.26; Mon, 30 Sep 2024 04:07:08 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%7]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 04:07:08 +0000
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
Thread-Index: AQHbBNe8L4bnDgesHkesBlyKKxeHIbJTwvyAgAxk+ICABR0GgIAKjcUA
Date: Mon, 30 Sep 2024 04:07:08 +0000
Message-ID: <ddf6d8cf-8d35-4dcf-b156-d6e221d0ddf8@microchip.com>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
 <20240912-literate-caped-mandrill-4c0c9d-mkl@pengutronix.de>
 <d9987295-74eb-4795-8517-379249cd7626@microchip.com>
 <20240923-burrowing-poised-taipan-22a14d-mkl@pengutronix.de>
In-Reply-To: <20240923-burrowing-poised-taipan-22a14d-mkl@pengutronix.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|DS7PR11MB7930:EE_
x-ms-office365-filtering-correlation-id: fcd59e01-246e-4ee2-2e4a-08dce1055a55
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWkvdzRHMHVNbWk1TVdaU1J4WkpURkxlUEJ1NUt0c2JPR1E5K3lkajdyY2w5?=
 =?utf-8?B?ZG9ZNDI5K3huWWZJNU4vQUI5eGRxdzRyR1djcjAwYmplQ2IwWHlkK01iVUF6?=
 =?utf-8?B?OEhIdWQyNDVXa1VucW1qamNPcU1oMVZlclVGcUVBalR2K25QZGtLNG9tSDVD?=
 =?utf-8?B?bkNOdkdYK3FKTGlDOUlDeS9jQk8yVnhFQVd0U2lhdm1XZW1TUmk0RXpZZUMv?=
 =?utf-8?B?cHd5UENlZG1vZEYrV1YxbDVVakx2NkkveW1HdzNZK0xuYXRYckVibHUxTnU0?=
 =?utf-8?B?RkREZkdTVnptWXRoV0syZGZvcUE5L0REM0NzYVhFZnpldGQ3cFlYMEVqcnVF?=
 =?utf-8?B?R0dDN3VyRDdoL2tZU25pRG9XKzQxQytsQjdqT3VHODZKWjBoWnRpUFFHSnJq?=
 =?utf-8?B?Nzd6aS9JNjZMdk51M0U0V3lqSGRCc0l2ejIvMVpOS2laZ3krT3JpUXVrVGJ5?=
 =?utf-8?B?cTNpYnNnYlU4Sk81ZFlkRTk4Z2RHd3JHT1NBaC9XRTlTVGgxVG1rQW5PeGZS?=
 =?utf-8?B?Tk1vOWk0Q2lUY2Rob1dkVnQ1Q2J3b3BrTTQ1VWJTNFhUU0hnWkNOcUIrQjVB?=
 =?utf-8?B?VENvaG1DcGtrZkNNa1RxaFloVGJiL0VwNkE1NjlnUm9OaU43OG03bktORDZh?=
 =?utf-8?B?dFU0TzNubVNnQmVsSHMwTkdHamkzWEJDM1RFS1dIdXpEL1VpR0YwZ0ZPVS9i?=
 =?utf-8?B?VU1WRThmYzBmeldlL0pMekJXcFlEeVpyM2toT2pGcG5OQnV2Vm1aWGZqUHVs?=
 =?utf-8?B?NURONXQvaXRRYnVxNVhCdU4zSGk2Q1d6akVyWVg2UHJ5bTFqWnNnT2x4QmxN?=
 =?utf-8?B?Wk9YUmFDVm5EaTdNb3VMNTdXSDFXTTh6dzY2RGN4WGlpaFFnOGJJR0RQcGx3?=
 =?utf-8?B?UXd5WTgwVHV3SUdVOERoNG1wRW1melFzOUV2MWs4SG54c01UcjR4ZDdEdjlV?=
 =?utf-8?B?ajN3U0thL2Y4WUtTSnhkOVZuTEJGVmZKNGdFS0cyaHJ6Q3VQblQ3bFEwZU4w?=
 =?utf-8?B?MDZybCtJMWV2MXJBRk9hbjVUY1c3NXoyazArTVN2aVc4ZU1Kd3MzSmkybDVr?=
 =?utf-8?B?eENULzV6RFFma1RIK2UxelQrczZLTTZLSmFXaVl2VS9ZQ1NULzJhdmdlNHVH?=
 =?utf-8?B?T1NmUC9SYWtpbkdTSXplenVxL2xRZFJadXlwaG9BdmlWd0RBVVoyT1h6STd5?=
 =?utf-8?B?Y2pqbjhMUFpLUkRJaThnSFpBS1VOd0kyL1VaWUQ4MUZqSzg0QXZ1VUpES1Iy?=
 =?utf-8?B?dTRvZ2tZR291OXNYR2pKL2Z6aWl0UjJYT0RkbzR6NDhpMVcyc05TODk2aWVl?=
 =?utf-8?B?YXBJd0NlRmVHSWY0c1prTExKZEJwVks5bnhYNEhXamlvZ05GUkxUWVYzZStp?=
 =?utf-8?B?SjJTZm1ka0d2WVdrNW9WdFU4OTFoS0N1VWFoQUIxTWlTTzNYZjZEOVpnNFI2?=
 =?utf-8?B?eXVNTFRRWTB6Si80S3dzSCtFcmhXS1dIZ2w5ZGI1eEZBcHgyYXFBUGVRa21s?=
 =?utf-8?B?cnNkM2RJWmtITzNCcHlXOVJoTkh1cnJQR3U4eTFKZlZsSjlyNVZLdjVIamJa?=
 =?utf-8?B?NjluVUhoNTFJU3E4OHUzcEdEcnVrNVgvZE1odjN2em8rc0dibkZjTSs2a3dE?=
 =?utf-8?B?WVFudEZSMUxLL3l0SS9yTTJiVnN2TngzdVE3VXV0Y3daOHhGZXlJTGFUdlZo?=
 =?utf-8?B?KzFmdUEvcGZtcnVRTE94b1JUR01KK2ZnRnkyVDd3M3lYMzdqWEtlNXNuVlB3?=
 =?utf-8?B?NFQ2dy9udFdYRGZ1MmN6aFZPR2lQZEZSZVJGTHlhU3EzNkNGalhyaHF5SEd6?=
 =?utf-8?Q?93FMLqQBZVU0uFho20dilRcRfwDNCBkCi5FGs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWpTam84MDZHRFBjZzVHSG1kU3BEZUZoR01Ncy9iTEhYaWRWUlNaT1RkYTdh?=
 =?utf-8?B?UGtRL2V0dXNWY1VJa3FEak5xT0thMVNSWnVXUWpuaVBBZkpYeHVsd1RSQmNh?=
 =?utf-8?B?dnRlTFNMc3Fqc3dIWHNvcFIrMEZlRTFwNk1rTWpJNU83RmxwenpQelE3Vldy?=
 =?utf-8?B?K2IvRk00TSt2K3BmQ2hIbmk3eWdFWGlkOVU4N0t4SHhGdm5ZSWI5Y1U2VVAw?=
 =?utf-8?B?R2JHanVWNldaeG1XclQ1all6a2hLRWRNT2RydGNLamFxTlhrZEg4Z1NXakhF?=
 =?utf-8?B?cEFPZGMwZmVLTjhKRTZQOUJFZzRxZnNNTkFsOGMvRWFBWGhkanFFUkZKalh2?=
 =?utf-8?B?LzROUlhJN2VLeEhOenFVelpOcXB1WjRxSnpSVFRkKzR5YXl6WHNEY2dZNTBD?=
 =?utf-8?B?ZmtKdTRnZGZiUkl1L1FEaGlmUnFqR0FVaXQzajFVRUxUWThTeUdjdEhkN1ZX?=
 =?utf-8?B?NGdxQ2FyY0k2Yjd3M2MxNVJjKzF0bHZFOU5OaTQ0WVFnZFFTWnp5Q0w0N1B0?=
 =?utf-8?B?L3oxUTQ1Nk4xc0lRbGhTUVdodTEzRFlIdkRJUUhaRkxqemgvcU91VGg4WWww?=
 =?utf-8?B?R1U4SW8xWkxLNnEyWjFPUlpWaE1tUDJJeW43VnVIT2pMUVhNZXMrNi9ITHg2?=
 =?utf-8?B?RHJlZDBrQW5lRU9JcFR5TDJyQXBnUlJVcnJ0cDk4OG9XbVBqN3ROclFXY3hI?=
 =?utf-8?B?dThHSFBrRy9ic1VSVDczejN6bWNYdzd2aUxNN095OFJtSFRtL0hWYXB3V083?=
 =?utf-8?B?ZHlScFljVUhkVzg0dUhrSXJTRW5yZ1A1d1pLVWtMQ0c0ODZOOVVSV3Z2elM5?=
 =?utf-8?B?K1habDd5MW1GV3NEUDY5SFFqekFHTUxXTmdQWFU5S252MXg3NUovVy83RWRS?=
 =?utf-8?B?TVhiV0VVQTBFemsxTVJ0ZEo1MWFXZkVMcmt4dURYM2FRdkRFcXVTMmtuRWgy?=
 =?utf-8?B?dXVyRXdBaG9pQ2pEUmNha0xKZ2tTWTFWUFZXRUQrWTNHV2RVU3N6Z3B3WjB6?=
 =?utf-8?B?SXN4bWtVQnNRYjRZOU5VSXZUNjZUa1pQbmpZZTNnYU8zaGdFU2kwcHdmNUIw?=
 =?utf-8?B?SExiN25pSXJuaG9JRFMycmtaV0hQRWRpRkQyaVlLenN5cFhzZWxIYzFCd0sy?=
 =?utf-8?B?Q1BRRkdXTGJJY3pBdkl2ZklQVEs0ZmYxVHBhWHl1aW5va2VzejhwQ2N3VUhW?=
 =?utf-8?B?eHlONEhrbWYyTDJhbnhDVk1LMCtUUENnZVB4STFtb3ppU1NjenJpS2tXTzND?=
 =?utf-8?B?V0VWa3FqdlJ4UlZJUERwcHNWcGNmZEZSU2lnaXh2aEJxNWhXeWdqbitRT1Z1?=
 =?utf-8?B?cFZSckg4OFBTcVVZT09IbGxFcE5kb2krUHdlU2xkdXBCMmV4VVNscmd5ZG9W?=
 =?utf-8?B?Nlh1ci81M3FZWi9ITEFuVHVXLzdIYmxvNnMzdXoxR3pTNld5cWRlNjRlNUox?=
 =?utf-8?B?d0dabVo4Ym5tWlg3ajZMUCs0dlE3YU1QamRuSVBzSTlOVlRHKzRpajExSFRw?=
 =?utf-8?B?clRkVEd0VUcyeXpvZEdYbDhLQ1UxV1Z5SFF0eUVsa21zRllBaWljeWNkSDhH?=
 =?utf-8?B?WUlrSlpEdThxblV1cUE2U1RUME1RU1BIS1JxWWlTM1NBMUcvS2ZueG1RTndk?=
 =?utf-8?B?SHY0NWxocks0NjFuTmJ6WGZka2hsa0JqTC8zZGo5M1BnclI4OE1WbEtjZ3lI?=
 =?utf-8?B?QXE1ekNTOXJrODBkSDViVWpTeDVVemFNcXRUUGRmR2NTSjJjQ2RDcHgrVDFh?=
 =?utf-8?B?aWNhWUxFUkZMSE1kUTF2SG5KaE9taUdTYlNnci9mVFVjYStEeSs4RGFLVHRz?=
 =?utf-8?B?WTV1UjJhNDNTQ1hXcWRRWUdTMjhwaTUxcXlIWHM1cUp4RFZvd0ZodUxBWCtX?=
 =?utf-8?B?Rjc1WFNoRFdMK2REVGYyYW5XU2JIOTlSYkVSWllkMzlUNWVpdU9KNngyOGMz?=
 =?utf-8?B?aVdrZUZSNEMxdkZvdmhDVUVtK2Rib2RDaHZxVTZJQXJQbDM1UWY2VEFOaFRP?=
 =?utf-8?B?WmZlWW5XNkpoVkxBWU95RDRWS2FJbTBZRHFJbU5ZME5TNG9GNkZBc0lUNlc5?=
 =?utf-8?B?K1U5U0FRU2R3emw0UzhWcXl2T2JidHJaWityQW9FN0FjWTlTMzlYSW1INVVo?=
 =?utf-8?B?K3pCejJiazBabTRHS3JCTE1FVWtjWTBFc1FrVWkyR2Q0ekRPOFhzQVE5cGdZ?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0251882B7C0314CA5A65464B38F1ECC@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd59e01-246e-4ee2-2e4a-08dce1055a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 04:07:08.6036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RrvYUgpEsJ3VwRyhK1YxU2xBbUPkCKPpGMYqKBl9pJ3aFYFtnmogQe5JFokL3P/VSo6WNC5a/tDk8slsoaL3hQD3NJZhfAMBiAGo6UvsPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7930

T24gMjMvMDkvMjQgMTY6MjcsIE1hcmMgS2xlaW5lLUJ1ZGRlIHdyb3RlOg0KPiBPbiAyMC4wOS4y
MDI0IDA0OjUxOjU3LENoYXJhbi5QZWR1bXVydUBtaWNyb2NoaXAuY29tICB3cm90ZToNCj4+Pj4g
K2FsbE9mOg0KPj4+PiArICAtICRyZWY6IGNhbi1jb250cm9sbGVyLnlhbWwjDQo+Pj4+ICsgIC0g
aWY6DQo+Pj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4+PiArICAgICAgICBjb21wYXRpYmxlOg0K
Pj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4+PiArICAgICAgICAgICAgZW51bToNCj4+Pj4g
KyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1jYW4NCj4+Pj4gKyAgICB0aGVuOg0K
Pj4+PiArICAgICAgcmVxdWlyZWQ6DQo+Pj4+ICsgICAgICAgIC0gY29tcGF0aWJsZQ0KPj4+PiAr
ICAgICAgICAtIHJlZw0KPj4+PiArICAgICAgICAtIGludGVycnVwdHMNCj4+Pj4gKyAgICAgICAg
LSBjbG9ja3MNCj4+Pj4gKyAgICAgICAgLSBjbG9jay1uYW1lcw0KPj4+IEFGQUlDUyBjbG9jay1u
YW1lcyBpcyByZXF1aXJlZCBmb3IgYWxsIGNvbXBhdGlibGVzLg0KPj4gSW4gb3VyIGNhc2Ugb25s
eSBzYW05eDYwIGlzIHVzaW5nIGNsb2NrLW5hbWVzIHByb3BlcnR5Lg0KPiBObywgdGhlIGRyaXZl
ciB1c2VzICJjbGtfZ2V0KCZwZGV2LT5kZXYsICJjYW5fY2xrIikiLCBzbyB0aGlzIHByb3BlcnR5
DQo+IGlzIG1hbmRhdG9yeS4NClllcywgd2hhdCB5b3Ugc2FpZCB3YXMgY29ycmVjdCwgaXQgd2Fz
IG91ciBtaXN0YWtlLiBJIHdpbGwgcmVtb3ZlIHRoZSBpZiANCnN0YXRlbWVudHMgYW5kIG1ha2UN
CmNsb2NrcyBhbmQgY2xvY2stbmFtZXMgYXMgZGVmYXVsdCByZXF1aXJlZCBwcm9wZXJ0aWVzLiBJ
IHdpbGwgZml4IHRoaXMgDQppbiBuZXh0IHJldmlzaW9uLg0KDQo+DQo+IHJlZ2FyZHMsDQo+IE1h
cmMNCj4NCj4gLS0gUGVuZ3V0cm9uaXggZS5LLiB8IE1hcmMgS2xlaW5lLUJ1ZGRlIHwgRW1iZWRk
ZWQgTGludXggfCANCj4gaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfCBWZXJ0cmV0dW5nIE7D
vHJuYmVyZyB8IFBob25lOiANCj4gKzQ5LTUxMjEtMjA2OTE3LTEyOSB8IEFtdHNnZXJpY2h0IEhp
bGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiANCj4gKzQ5LTUxMjEtMjA2OTE3LTkgfA0KDQoNCi0t
IA0KQmVzdCBSZWdhcmRzLA0KQ2hhcmFuLg0KDQo=

